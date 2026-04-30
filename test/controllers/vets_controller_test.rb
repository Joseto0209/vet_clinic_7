require "test_helper"

class VetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @vet = vets(:one)
  end

  test "should get index" do
    get vets_url
    assert_response :success
  end

  test "should get show" do
    get vet_url(@vet)
    assert_response :success
  end

  test "should get new" do
    get new_vet_url
    assert_response :success
  end

  test "should create vet with valid params" do
    assert_difference("Vet.count", 1) do
      post vets_url, params: { vet: {
        first_name: "Maria",
        last_name: "Lopez",
        email: "maria.lopez@clinic.com",
        phone: "+15559999999",
        specialization: "Dermatology"
      } }
    end
    assert_redirected_to vet_url(Vet.last)
    assert_equal "Veterinarian was successfully created.", flash[:notice]
  end

  test "should not create vet with invalid params" do
    assert_no_difference("Vet.count") do
      post vets_url, params: { vet: {
        first_name: "",
        last_name: "",
        email: "",
        specialization: ""
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_vet_url(@vet)
    assert_response :success
  end

  test "should update vet with valid params" do
    patch vet_url(@vet), params: { vet: { first_name: "Updated" } }
    assert_redirected_to vet_url(@vet)
    assert_equal "Veterinarian was successfully updated.", flash[:notice]
  end

  test "should not update vet with invalid params" do
    patch vet_url(@vet), params: { vet: { first_name: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy vet" do
    # Remove dependent appointments first
    @vet.appointments.destroy_all
    assert_difference("Vet.count", -1) do
      delete vet_url(@vet)
    end
    assert_redirected_to vets_url
    assert_equal "Veterinarian was successfully deleted.", flash[:notice]
  end
end
