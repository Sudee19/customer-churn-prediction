# Customer Churn Analytics Dashboard

A modern, responsive dashboard for visualizing customer churn analytics, built with React and Chart.js.

![Dashboard Preview](dashboard-preview.png)

## Features

- **Dark Theme**: Modern dark theme with purple, dark blue, and dark red accents
- **Responsive Design**: Adapts to different screen sizes
- **Real-time Charts**: Six different charts showing various churn metrics:
  1. Revenue Risk Over Time
  2. Churn by Spend
  3. Customer Journey Risk
  4. Customer Acquisition vs Loss
  5. Most Valued Customers
  6. Customer Risk Distribution

## Technology Stack

- React 18
- TypeScript
- Chart.js & react-chartjs-2
- Modern CSS with Grid Layout

## Getting Started

### Prerequisites

- Node.js (v14 or higher)
- npm (v6 or higher)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourusername/customer-churn-dashboard.git
```

2. Navigate to the project directory:
```bash
cd customer-churn-dashboard
```

3. Install dependencies:
```bash
npm install
```

4. Start the development server:
```bash
npm start
```

5. Configure the environment:
   - Create a `.env` file in the root directory
   - Add your Firebase configuration:
   ```
   REACT_APP_FIREBASE_API_KEY=your-api-key
   REACT_APP_FIREBASE_AUTH_DOMAIN=your-app.firebaseapp.com
   REACT_APP_FIREBASE_PROJECT_ID=your-project-id
   REACT_APP_FIREBASE_STORAGE_BUCKET=your-app.appspot.com
   ```

6. The application will automatically open in your default browser

## Dashboard Components

### 1. Revenue Risk
- Line chart showing revenue at risk over time
- Helps identify trends in potential revenue loss

### 2. Churn by Spend
- Bar chart displaying churn rates across different spending brackets
- Identifies which customer segments are most likely to churn

### 3. Customer Journey Risk
- Line chart showing risk levels at different stages of the customer journey
- Helps identify critical points where customers are most likely to churn

### 4. Customer Acquisition vs Loss
- Bar chart comparing new customer acquisition against customer loss
- Provides a clear view of customer base growth/decline

### 5. Most Valued Customers
- Doughnut chart showing distribution of customer value segments
- Helps focus retention efforts on high-value customers

### 6. Customer Risk Distribution
- Doughnut chart showing the distribution of customers across risk levels
- Helps prioritize retention efforts

## Customization

### Colors
The dashboard uses a custom color palette defined in the theme:
- Dark Blue: #1A237E
- Dark Red: #B71C1C
- Purple: #4A148C

You can modify these colors in the `colors` object in `index.tsx`.

### Chart Options
All charts use a consistent set of options defined in the `chartOptions` object, including:
- Responsive design
- White text for better visibility on dark background
- Custom grid colors
- Positioned legends

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details
