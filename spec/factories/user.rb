FactoryGirl.define do
    factory :user do
        name "John"
        email  "Doe"
        password "testtest"
        password_confirmation "testtest"
        admin 't'
    end
end