# mrsool_test

A test Flutter project for Mrsool.

The following is part of Mrsool's Accept app which targets business partners and allows them to accept/reject orders.

This clone project was developed using the Provider pattern which is a state management and dependency injection library. It allows us to write clean and maintainable code.

Challenges:
1- One of the biggest challenges I faced during this test was to manage the UI state for all the lists of orders, each item having its own status which needed to be reflected on the screen. Refrencing a Provider across multiple routes in the app was a challenge I hadn't faced before. To solve it, I created a seperate change notifier and wrapped the MaterialPageRoute's builder with it. This allowed me to access the right instance of the Order class in the OrderDetailsScreen and listen to any changes in its data.

2- Another challenge was to create a PDF invoice of an order. Creating a pdf programatically is a tedious task. I used Flutter's pdf library, which makes it a bit easier by providing us with UI widgets that work the same as the Flutter framework. This allows us to create PDFs just like we make UI in Flutter. For example, if we want to render a text saying "Mrsool" in Fluter, we simply write Text("Mrsool"). 
The PDF library works the same. If we want to add a text to our PDF, we can write pdf.Text("Mrsool").

3- The generateOrder API given to me doesn't always work and sometimes returns a 400 error with the message "some items are disabled. Please enable them before proceeding." 


Improvements:
1- We can make the app better by making the changes appear in real time. For example, the current implementaiton requires the user to refresh the list manually if they want to see new orders. This can be improved by making it so when an order is placed, a notification is sent to the user and the list is updated on its own.

2- More time and attention can be given to the pdf invoice and to the UI in general to make it more appealing to users.

3- Currently, the time difference (checking if the order is older than 6 minutes) is only checked when the order details screen is opened. When we open the details screen, it will first check if the order has been pending for more than 6 minutes and then change its status to "time_out". The status should be updated on its own without waiting for the user to open an order's detials screen.




 
