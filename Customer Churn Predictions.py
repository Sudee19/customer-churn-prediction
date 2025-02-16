from django.shortcuts import render
import pandas as pd
import plotly.express as px
import plotly.io as pio

def churn_visualization(request):
    # Load your dataset
    data = pd.read_excel("C:\\Users\\SUDEEP MADAGONDA\\OneDrive\\Desktop\\Customer Churn Prediction\\customer_churn_large_dataset.xlsx")

    # Create a 3D scatter plot
    fig_3d = px.scatter_3d(data, 
                            x='Age', 
                            y='Monthly_Bill', 
                            z='Total_Usage_GB', 
                            color='Churn', 
                            title='3D Scatter Plot of Customer Churn Prediction',
                            labels={'Age': 'Age', 'Monthly_Bill': 'Monthly Bill', 'Total_Usage_GB': 'Total Usage (GB)'},
                            color_discrete_sequence=['darkpink', 'lightpink'])

    # Convert the plotly figure to HTML
    graph_html = pio.to_html(fig_3d, full_html=False)

    return render(request, 'visualizations/churn_visualization.html', {'graph_html': graph_html})