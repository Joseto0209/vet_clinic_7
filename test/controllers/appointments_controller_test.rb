require "test_helper"

class AppointmentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @appointment = appointments(:one)
    @pet = pets(:one)
    @vet = vets(:one)
  end

  test "should get index" do
    get appointments_url
    assert_response :success
  end

  test "should get show" do
    get appointment_url(@appointment)
    assert_response :success
  end

  test "should get new" do
    get new_appointment_url
    assert_response :success
  end

  test "should create appointment with valid params" do
    assert_difference("Appointment.count", 1) do
      post appointments_url, params: { appointment: {
        pet_id: @pet.id,
        vet_id: @vet.id,
        date: "2026-06-01 10:00:00",
        reason: "Annual wellness exam",
        status: "scheduled"
      } }
    end
    assert_redirected_to appointment_url(Appointment.last)
    assert_equal "Appointment was successfully created.", flash[:notice]
  end

  test "should not create appointment with invalid params" do
    assert_no_difference("Appointment.count") do
      post appointments_url, params: { appointment: {
        pet_id: nil,
        vet_id: nil,
        date: "",
        reason: "",
        status: ""
      } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    get edit_appointment_url(@appointment)
    assert_response :success
  end

  test "should update appointment with valid params" do
    patch appointment_url(@appointment), params: { appointment: { reason: "Updated reason" } }
    assert_redirected_to appointment_url(@appointment)
    assert_equal "Appointment was successfully updated.", flash[:notice]
  end

  test "should not update appointment with invalid params" do
    patch appointment_url(@appointment), params: { appointment: { reason: "" } }
    assert_response :unprocessable_entity
  end

  test "should destroy appointment" do
    # Remove dependent treatments first
    @appointment.treatments.destroy_all
    assert_difference("Appointment.count", -1) do
      delete appointment_url(@appointment)
    end
    assert_redirected_to appointments_url
    assert_equal "Appointment was successfully deleted.", flash[:notice]
  end
end
