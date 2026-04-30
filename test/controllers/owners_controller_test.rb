require "test_helper"

class OwnersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = owners(:one)
  end

  test "should get index" do
    get owners_url
    assert_response :success
  end

  test "should get show" do
    get owner_url(@owner)
    assert_response :success
  end

  test "should get new" do
    get new_owner_url
    assert_response :success
  end

  test "should create owner with valid params" do
    assert_difference("Owner.count", 1) do
      post owners_url, params: { owner: {
        first_name: "Carlos",
        last_name: "Rivera",
        email: "carlos.rivera@example.com",
        phone: "+15551234000",
        address: "789 Elm St"
      } }
    end
    assert_redirected_to owner_url(Owner.last)
    assert_equal "Owner was successfully created.", flash[:notice]
  end

  test "should not create owner with invalid params" do
    assert_no_difference("Owner.count") do
      post owners_url, params: { owner: {
        first_name: "",
        last_name: "",
        email: "",
        phone: ""
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_owner_url(@owner)
    assert_response :success
  end

  test "should update owner with valid params" do
    patch owner_url(@owner), params: { owner: { first_name: "Updated" } }
    assert_redirected_to owner_url(@owner)
    assert_equal "Owner was successfully updated.", flash[:notice]
  end

  test "should not update owner with invalid params" do
    patch owner_url(@owner), params: { owner: { first_name: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy owner" do
    # Remove dependent pets first to avoid foreign key issues
    @owner.pets.destroy_all
    assert_difference("Owner.count", -1) do
      delete owner_url(@owner)
    end
    assert_redirected_to owners_url
    assert_equal "Owner was successfully deleted.", flash[:notice]
  end
end
