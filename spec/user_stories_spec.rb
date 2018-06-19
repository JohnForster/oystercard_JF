# describe 'User stories' do
#   let(:oystercard) { Oystercard.new }
#   it 'in order to use public transport, there should be money on the card' do
#     expect { oystercard.balance }.not_to raise_error
#   end
#
#
#   it 'in order to keep using public transport, I want to add money to my card' do
#     expect { oystercard.top_up(1) }.not_to raise_error
#   end
#
#   it "in order to protect my money, I don't want to put too much money on my card" do
#     max = Oystercard::MAX_BALANCE
#     expect { oystercard.top_up(max + 1) }.to raise_error "Balance cannot exceed £#{max}."
#   end
#
#   it 'in order to pay for my journey, I need my fare deducted from my card' do
#     oystercard.top_up(2)
#     expect { oystercard.deduct(2) }.to change oystercard.balance
#   end
#
#   # In order to get through the barriers
#   # As a customer
#   # I need to touch in and out
#   it 'in order to get through the barriers I need to touch in and out' do
#     oystercard.top_up(2)
#     expect { oystercard.touch_in }.not_to raise_error
#   end
#
#   # In order to pay for my journey
#   # As a customer
#   # I need to have the minimum amount for a single journey
#   #
#   # In order to pay for my journey
#   # As a customer
#   # I need to pay for my journey when it's complete
#   #
#   # In order to pay for my journey
#   # As a customer
#   # I need to know where I've travelled from
#   #
#   # In order to know where I have been
#   # As a customer
#   # I want to see to all my previous trips
#   #
#   # In order to know how far I have travelled
#   # As a customer
#   # I want to know what zone a station is in
#   #
#   # In order to be charged correctly
#   # As a customer
#   # I need a penalty charge deducted if I fail to touch in or out
#   #
#   # In order to be charged the correct amount
#   # As a customer
#   # I need to have the correct fare calculated
# end
