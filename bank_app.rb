$accounts = [
    {
        user: "masho",
        pass: "123",
        history: []
    },
    {
        user: "steve",
        pass: "abc",
        history: []
    }
]

class Account
    attr_accessor :user, :pass
    def initialize
        @balance = 0
        # @history = []
    end
    def display
        puts user
        puts pass
    end
    def store_history(name)
        new_balance = "Balance: $#{@balance}"
            $accounts.each do |i|
                if i[:user] == name
                    i[:history].push(new_balance)
                else
                    puts "no good"
                end
            end
    end
end

history = []

name_found = false
active_account = false
puts "New account? Y/N"
answer = gets.chomp
if answer == "Y" || answer == "y"
    puts "Enter username"
    userName = gets.chomp
    puts "Enter password"
    password = gets.chomp
    user1 = Account.new()
    user1.user = userName
    user1.pass = password
    $accounts.push({user: userName, pass: password, history: []})
    puts $accounts
    user1.store_history(userName)
    puts $accounts
    active_account = true
end

if answer == "N" || answer == "n"
    puts "Activating old account"
    puts "Enter username"
    userName = gets.chomp
    $accounts.each do |check|
        if check[:user] == userName
        name_found = true
        puts "found"
        elsif name_found
            break
        end
    end
    if !name_found
        puts "User not found"
    end
    if name_found
        while name_found
            puts "\nEnter password"
            password = gets.chomp        
            $accounts.each do |check|
                if check[:pass] == password
                    active_account = true
                    name_found = false
                    break
                else
                    puts "Wrong password, try again"
                    break
                end
            end    
        end        
    end
end

balance = 0

while active_account 
    puts "Welcome to the banking app...\n"
    puts "What would you like to do?\n[Options: [1]: balance, [2]: deposit, [3]: withdraw, [4]: history, [5]: exit]"

    option = gets.chomp.to_i

    case option        

        when 1
        
            puts "Your balance is: $#{balance}"
            sleep 2
            system 'clear'

        when 2
            puts "How much would you like to deposit?"
            deposit = gets.chomp.to_i
            puts "New balance: $#{balance + deposit}"
            balance += deposit
            history.push ("Deposited: $#{deposit}")
            sleep 1.5
            system 'clear'

        when 3
            puts "How much would you like to withdraw?"
            withdraw = gets.chomp.to_i
            if withdraw < balance
                puts "New balance: $#{balance - withdraw}"
                balance -= withdraw
                history.push ("Withdrew: $#{withdraw}")
                sleep 1.5
                system 'clear'    
            else
                puts "You do not have enough in your account for that action"
            end

        when 4
            output =  history.join("\n")
            puts "Transaction history: \n#{output}"
            puts "Current Balance: $#{balance}"       

        when 5
            new_balance = "Balance: $#{balance}"
            accounts.each do |i|
                i[:history].push(new_balance)
            end
            # open('accounts.yml', 'w') { |f|
            # f.puts accounts[:history] << new_balance
            # }
            break
        # else
        #     puts "Invalid selection"
        #     sleep 1.5
        #     system "clear"
        # end
    end
end
