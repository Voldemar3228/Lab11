require 'test_helper'

class Laba10ControllerTest < ActionDispatch::IntegrationTest
   test "should get input" do
     get laba10_input_url
     assert_response :success
   end

   test "should_not_exist_two_equal_params" do
     get laba10_output_url, params: { v1: 4 }
     bef = Model.count
     get laba10_output_url, params: { v1: 4 }
     after = Model.count
     assert_equal bef, after
   end

   test "should not equal" do
     get laba10_output_url, params: { v1: 4 }
     one = assigns(:result)
     get laba10_output_url, params: { v1: 8 }
     two = assigns(:result)
     refute_equal one, two
   end
end
