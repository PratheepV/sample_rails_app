require 'spec_helper'

describe PagesController do

  #Delete these examples and add some real ones
  it "should use PagesController" do
    controller.should be_an_instance_of(PagesController)
  end


  describe "GET 'home'" do
    describe "when not signed in" do

      before(:each) do
        get :home
      end
    
      it "should be successful" do
        response.should be_success
      end
    
      it "should have the right title" do
        response.should have_tag("title", "#{@base_title} | Home")
      end
    end
    
    describe "when signed in" do
      
      before(:each) do
        @user = test_sign_in(Factory(:user))
        other_user = Factory(:user, :email => Factory.next(:email))
        other_user.follow!(@user)
      end
      
      it "should have the right follower/following counts" do
        get :home
        response.should have_tag("a[href=?]", following_user_path(@user), 
                                              /0 following/)
        response.should have_tag("a[href=?]", followers_user_path(@user), 
                                              /1 follower/)
      end
    end
  end

  describe "GET 'contact'" do
    it "should be successful" do
      get 'contact'
      response.should be_success
    end
  end
end
