import ballerina/http;
import socialmedia.store;
import ballerina/persist;

type Conflict record {|
    *http:Conflict;
    record {
        string message;
    } body;
|};

public type UserWithPosts record {|
    string firstName;
    string lastName;
    string bio?;
    store:Post[] posts;
|};

service /socialmedia on new http:Listener(9090) {

    private final store:Client cache;

    // Initialize the client API
    function init() returns error? {
        self.cache = check new();
    }

    // Add a user to the cache
    resource function post users(store:UserInsert user) returns Conflict|http:Created & readonly|persist:Error {
        int[]|persist:Error result = self.cache->/users.post([user]);
        if result is persist:AlreadyExistsError {
            Conflict response = {body: {message: result.message()}};
            return response;
        } else if result is persist:Error {
            return result;
        }
        return http:CREATED;
    }

    // Add a post to the cache
    resource function post posts(store:PostInsert post) returns Conflict|http:Created & readonly|persist:Error {
        int[]|persist:Error result = self.cache->/posts.post([post]);
        if result is persist:AlreadyExistsError || result is persist:ConstraintViolationError {
            Conflict response = {body: {message: result.message()}};
            return response;
        } else if result is persist:Error {
            return result;
        }
        return http:CREATED;
    }

    // Get user details
    resource function get users/[int id]() returns UserWithPosts|persist:Error|http:NotFound {
        UserWithPosts|persist:Error user = self.cache->/users/[id]();
        if user is persist:NotFoundError {
            return {body: {message: user.message()}};
        }
        return user;
    }
}
