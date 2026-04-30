require "test_helper"

class PetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @pet = pets(:one)
    @owner = owners(:one)
  end

  test "should get index" do
    get pets_url
    assert_response :success
  end

  test "should get show" do
    get pet_url(@pet)
    assert_response :success
  end

  test "should get new" do
    get new_pet_url
    assert_response :success
  end

  test "should create pet with valid params" do
    assert_difference("Pet.count", 1) do
      post pets_url, params: { pet: {
        name: "Rex",
        species: "dog",
        breed: "German Shepherd",
        date_of_birth: "2022-01-01",
        weight: 30.0,
        owner_id: @owner.id
      } }
    end
    assert_redirected_to pet_url(Pet.last)
    assert_equal "Pet was successfully created.", flash[:notice]
  end

  test "should not create pet with invalid params" do
    assert_no_difference("Pet.count") do
      post pets_url, params: { pet: {
        name: "",
        species: "",
        date_of_birth: "",
        weight: ""
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_pet_url(@pet)
    assert_response :success
  end

  test "should update pet with valid params" do
    patch pet_url(@pet), params: { pet: { name: "UpdatedBuddy" } }
    assert_redirected_to pet_url(@pet)
    assert_equal "Pet was successfully updated.", flash[:notice]
  end

  test "should not update pet with invalid params" do
    patch pet_url(@pet), params: { pet: { name: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy pet" do
    # Remove dependent appointments first
    @pet.appointments.destroy_all
    assert_difference("Pet.count", -1) do
      delete pet_url(@pet)
    end
    assert_redirected_to pets_url
    assert_equal "Pet was successfully deleted.", flash[:notice]
  end
end
