class User < ApplicationRecord
end

User.create(first_name: 'Tom', last_name: 'Smith', age: '37') # Create
User.find_by(first_name: 'Tom') # Read
User.find(1).update(first_name: 'Ann') # Update
User.find_by(first_name: 'Tom').delete # Delete
