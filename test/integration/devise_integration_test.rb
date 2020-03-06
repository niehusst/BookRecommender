require 'test_helper'

class DeviseIntegrationTest< Capybara::Rails::TestCase
    
    test "bad email start session" do
        visit '/users/sign_in'
        
        fill_in 'Email', with: 'fail@example.com'
        fill_in 'Password', with: 'securepassword'

        click_on 'Log in'

        assert_current_path '/users/sign_in'
        assert page.has_content?('Log in')

    end

    test "bad password start session" do
        visit '/users/sign_in'
        
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'insecurepassword'

        click_on 'Log in'

        assert_current_path '/users/sign_in'
        assert page.has_content?('Log in')
    end

    test "double login" do
        visit '/users/sign_in'
        
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'securepassword'

        click_on 'Log in'

        assert_selector 'h1', text:'Recommend me a book...'

        #attempt to sign in again
        visit '/users/sign_in'
        assert_selector 'h1', text:'Recommend me a book...'
    end

    test "session end success" do
        visit '/users/sign_in'
        
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'securepassword'

        click_on 'Log in'

        assert_selector 'h1', text: 'Recommend me a book...'
        
        click_on 'Logout'
        assert_selector 'h1', text: 'Get some fresh Reads!'
    end

    test "create valid user" do
        visit '/'
        
        within('.centered') do
            click_on 'Sign up'
        end
        
        fill_in 'Email', with: 'good@email.com'
        fill_in 'Password', with: 'goodpassword'
        fill_in 'Password confirmation', with: 'goodpassword'

        click_button 'Sign up'

        assert_selector 'h1', text: 'Recommend me a book...'

        #assert user was put in db too
    end

    test "create invalid email user" do
        visit '/'
        
        within('.centered') do
            click_on 'Sign up'
        end
        
        fill_in 'Email', with: 'goodemail.com'
        fill_in 'Password', with: 'goodpassword'
        fill_in 'Password confirmation', with: 'goodpassword'

        click_button 'Sign up'

        #assert did not go anywhere
        assert_selector 'h2', text: 'Sign up'
    end

    test "create invalid password mismatch user" do
        visit '/'
        
        within('.centered') do
            click_on 'Sign up'
        end
        
        fill_in 'Email', with: 'good@email.com'
        fill_in 'Password', with: 'goodpassword'
        fill_in 'Password confirmation', with: 'gooderpassword'

        click_button 'Sign up'

        assert page.has_content?("Password confirmation doesn't match Password")
    end

    test "create invalid password user" do
        visit '/'
        
        within('.centered') do
            click_on 'Sign up'
        end
        
        fill_in 'Email', with: 'good@email.com'
        fill_in 'Password', with: 'bad'
        fill_in 'Password confirmation', with: 'bad'

        click_button 'Sign up'

        assert page.has_content?("Password is too short (minimum is 6 characters)")
    end

    test "create invalid empty user" do
        visit '/'
        
        within('.centered') do
            click_on 'Sign up'
        end
        
        fill_in 'Email', with: ''
        fill_in 'Password', with: ''
        fill_in 'Password confirmation', with: ''

        click_button 'Sign up'

        assert page.has_content?("Email can't be blank")
        assert page.has_content?("Password can't be blank")
    end

    test "create invalid identical user" do
        visit '/'
        
        within('.centered') do
            click_on 'Sign up'
        end
        
        fill_in 'Email', with: 'test@example.com'
        fill_in 'Password', with: 'goodpassword'
        fill_in 'Password confirmation', with: 'goodpassword'

        click_button 'Sign up'

        assert page.has_content?("Email has already been taken")
    end

    test "unlogged in navbar links" do
        visit '/'

        within('nav') do
            click_on 'Sign up'
        end
        assert_selector 'h2', text: 'Sign up'

        within('nav') do
            click_on 'Login'
        end
        assert_selector 'h2', text: 'Log in'

        within('nav') do
            find('.navbar-brand').click
        end
        assert_selector 'h1', text: 'Get some fresh Reads!'
    end

    test "logged in navbar links" do
        sign_in users(:user1)

        visit '/'

        click_on 'About'
        assert_selector 'h1', text: 'About'
        
        click_on 'Recommendations'
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'Profile'
        assert_selector 'h1', text: 'Profile'

        within('nav') do
            find('.navbar-brand').click
        end
        assert_selector 'h1', text: 'Recommend me a book...'

        click_on 'Logout'
        assert_selector 'h1', text: 'Get some fresh Reads!'
    end

end
