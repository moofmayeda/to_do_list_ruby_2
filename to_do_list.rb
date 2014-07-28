require "./lib/task"
require "./lib/list"
@lists = {}
@selected_list = 0
@selected_task = 0

puts "Task Manager"
def main_menu
  puts "Press 'l' to create a new list \n Press 'a' to see all lists \n Press 'q' to quit"
  list_selection = gets.chomp
  if list_selection == 'l'
    puts "Enter a list description"
    new_list_description = gets.chomp
    new_list = List.new(new_list_description)
    @lists[new_list_description] = new_list
    @selected_list = new_list
    display_add
  elsif list_selection == 'a'
    if @lists.length == 0
      puts "No lists have been created. Try making a list."
      main_menu
    else
      @lists.each {|name, list| puts name}
      puts "Type the name of the list you would like to view"
      @selected_list = @lists[gets.chomp]
      display_add
      list_menu
    end
  elsif list_selection == 'q'
    exit
  end
end
def task_menu
  i = 0
  @selected_list.tasks.each do |task|
    print i.to_s + " - "
    puts task.describe
    i += 1
  end
  puts "Select the number of the task you would like to modify, or press 'n' to add another task to the list"
    number_or_n = gets.chomp
  if number_or_n == 'n'
    display_add
  else
    @selected_task = @selected_list.tasks[number_or_n.to_i]
    puts "Press 'd' to change the task description \n Press 'e' set the task's due date \n Press 'p' to set the task's priority \n Press 'x' to mark this task as completed \n Press 'r' to remove this task \n Press 'q' to go back to the list menu"
    option_var = gets.chomp

    if option_var == 'd'
      puts "What would you like to change the description to?"
      @selected_task.edit_description(gets.chomp)
      task_menu
    elsif option_var == 'e'
      puts "What is the due date? mm/dd/yy"
      due_date = gets.chomp.split("/")
      @selected_task.set_due(due_date[0].to_i, due_date[1].to_i, ("20"+due_date[2]).to_i)
      task_menu
    elsif option_var == 'p'
      puts "What is the priority level, from 1-5? 1 is low and 5 is high"
      @selected_task.set_level(gets.chomp.to_i)
      task_menu
    elsif option_var == 'x'
      @selected_list.complete_task(@selected_task)
      puts "The task has been moved to your completed task list."
      task_menu
    elsif option_var == 'r'
      @selected_list.delete_task(@selected_task)
      puts "The task has been removed."
      task_menu
    elsif option_var == 'q'
      list_menu
    end
  end
end

def list_menu
  puts "Press 'd' to sort the list by due date \n Press 'p' to sort the list by priority \n Press 'e' to sort the list by description \n Press 'c' to show the completed tasks \n Press 'q' to return to the main menu"
  sort_option_var = gets.chomp
  if sort_option_var == 'd'
    @selected_list.by_date.each {|task| puts task.describe}
  elsif sort_option_var == 'p'
    @selected_list.by_priority.each {|task| puts task.describe}
  elsif sort_option_var == 'e'
    @selected_list.by_description.each {|task| puts task.describe}
  elsif sort_option_var == 'c'
    @selected_list.compeleted_tasks.each {|task| puts task.describe}
  elsif sort_option_var == 'q'
    main_menu
  end
  main_menu
end

def display_add
  @selected_list.tasks.each {|task| puts task.describe}
  puts "Press 'n' to add a new task to the selected list"
  task_add = gets.chomp
  if  task_add == "n"
    puts "What task do you want to add to this list?"
    task_name = gets.chomp
    added_task = Task.new(task_name)
    @selected_list.add_task(added_task)
  end
  task_menu
end

main_menu



# Shoes.app do
#   background gray
#   stack {
#     background white
#     para "Enter a new list"
#     flow do
#       @user_input = edit_line
#       @add_list = button "Create"
#       @add_list.click do
#         @lists[@user_input.text] = List.new(@user_input.text)
#         @word_store = ""
#         @lists.each do |i| word_store += " #{i.describe}" end
#         @list.replace @word_store
#       end
#     end
#   }
#   @list = para ""
# end
