require_relative 'spec_helper'
require 'pry'
require 'time'

describe "Trip class" do

  describe "initialize" do
    before do
      start_time = Time.parse('2015-05-20T12:14:00+00:00')
      end_time = start_time + 25 * 60 # 25 minutes
      driver = RideShare::Driver.new(id: 54, name: "Rogers Bartell IV",
        vin: "1C9EVBRM0YBC564DZ",
        phone: '111-111-1111',
        status: :AVAILABLE)
        @trip_data = {
          id: 8,
          passenger: RideShare::User.new(id: 1,
            name: "Ada",
            phone: "412-432-7640"),
            start_time: start_time,
            end_time: end_time,
            cost: 23.45,
            rating: 3,
            driver: driver
          }
          @trip = RideShare::Trip.new(@trip_data)
        end

        it "is an instance of Trip" do
          expect(@trip).must_be_kind_of RideShare::Trip
        end

        it "stores an instance of user" do
          expect(@trip.passenger).must_be_kind_of RideShare::User
        end

        it "raises error if end date is before start date" do

          start_time = Time.parse('2017-05-21T12:14:00+00:00')
          end_time = Time.parse('2015-05-20T12:14:00+00:00')

          @trip_data = {
            id: 8,
            passenger: RideShare::User.new(id: 1,
              name: "Ada",
              phone: "412-432-7640"),
              start_time: start_time,
              end_time: end_time,
              cost: 23.45,
              rating: 3
            }
            expect {RideShare::Trip.new(@trip_data)}.must_raise ArgumentError
          end

          it "stores an instance of driver" do
            # Unskip after wave 2
            expect(@trip.driver).must_be_kind_of RideShare::Driver  ## here in the trip data , there is no driver?? so it doesn't exist
          end

          it "raises an error for an invalid rating" do
            [-3, 0, 6].each do |rating|
              @trip_data[:rating] = rating
              expect {
                RideShare::Trip.new(@trip_data)
              }.must_raise ArgumentError
            end
          end

          describe "duration" do

            before do
              start_time = Time.parse('2015-05-20T12:14:00+00:00')
              end_time = start_time + 25 * 60 # 25 minutes
              @trip_data = {
                id: 8,
                passenger: RideShare::User.new(id: 1,
                name: "Ada",
                phone: "412-432-7640"),
                start_time: start_time,
                end_time: end_time,
                cost: 23.45,
                rating: 3
                }
                @trip = RideShare::Trip.new(@trip_data)
              end

              it "returns the trip duration in a kind of Integer" do
                expect(@trip.duration).must_be_kind_of Integer
              end

              it "returns the trip duration in seconds" do
                expect(@trip.duration).must_equal 1500
              end

            end

          end
        end
