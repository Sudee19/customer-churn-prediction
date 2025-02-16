import React from 'react';
import ReactDOM from 'react-dom/client';
import { Line, Bar, Doughnut } from 'react-chartjs-2';
import {
  Chart as ChartJS,
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Title,
  Tooltip,
  Legend,
} from 'chart.js';

ChartJS.register(
  CategoryScale,
  LinearScale,
  PointElement,
  LineElement,
  BarElement,
  ArcElement,
  Title,
  Tooltip,
  Legend
);

// Theme colors
const colors = {
  darkBlue: '#1A237E',
  darkRed: '#B71C1C',
  purple: '#4A148C',
  lightBlue: 'rgba(26, 35, 126, 0.5)',
  lightRed: 'rgba(183, 28, 28, 0.5)',
  lightPurple: 'rgba(74, 20, 140, 0.5)'
};

const Dashboard = () => {
  // Revenue Risk Data
  const revenueData = {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
    datasets: [{
      label: 'Revenue at Risk',
      data: [200000, 180000, 220000, 250000, 220000, 300000],
      borderColor: colors.darkRed,
      backgroundColor: colors.lightRed,
    }],
  };

  // Churn by Spend Data
  const churnData = {
    labels: ['0-10k', '10-50k', '50-100k', '100-250k', '250k+'],
    datasets: [{
      label: 'Churn Rate by Spend',
      data: [25, 15, 10, 18, 35],
      backgroundColor: colors.darkBlue,
    }],
  };

  // Customer Journey Data
  const journeyData = {
    labels: ['Allocation', 'Onboard', 'Engage', 'Enhance', 'Renewal'],
    datasets: [{
      label: 'Customers at Risk by Journey',
      data: [12, 15, 28, 15, 20],
      borderColor: colors.purple,
      backgroundColor: colors.lightPurple,
      tension: 0.4,
    }],
  };

  // Customer Acquisition vs Loss
  const acquisitionData = {
    labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
    datasets: [
      {
        label: 'Acquired',
        data: [45, 52, 38, 41, 35, 48],
        backgroundColor: colors.darkBlue,
      },
      {
        label: 'Lost',
        data: [-20, -15, -18, -22, -16, -19],
        backgroundColor: colors.darkRed,
      },
    ],
  };

  // Most Valued Customers
  const valuedCustomersData = {
    labels: ['Premium', 'Standard', 'Basic'],
    datasets: [{
      data: [120, 200, 300],
      backgroundColor: [colors.darkRed, colors.darkBlue, colors.purple],
    }],
  };

  // Customer Risk Distribution
  const riskDistributionData = {
    labels: ['High Risk', 'Medium Risk', 'Low Risk'],
    datasets: [{
      data: [30, 45, 25],
      backgroundColor: [colors.darkRed, colors.purple, colors.darkBlue],
    }],
  };

  const chartOptions = {
    responsive: true,
    maintainAspectRatio: false,
    plugins: {
      legend: {
        position: 'top' as const,
        labels: {
          color: '#fff',
          padding: 20,
          font: {
            size: 12
          }
        }
      }
    },
    scales: {
      y: {
        ticks: { 
          color: '#fff',
          padding: 10,
          font: {
            size: 12
          }
        },
        grid: { 
          color: 'rgba(255, 255, 255, 0.1)',
          drawBorder: false
        },
        border: {
          display: true,
          color: 'rgba(255, 255, 255, 0.3)'
        }
      },
      x: {
        ticks: { 
          color: '#fff',
          padding: 10,
          font: {
            size: 12
          }
        },
        grid: { 
          color: 'rgba(255, 255, 255, 0.1)',
          drawBorder: false
        },
        border: {
          display: true,
          color: 'rgba(255, 255, 255, 0.3)'
        }
      }
    },
    layout: {
      padding: {
        left: 15,
        right: 15,
        top: 15,
        bottom: 25
      }
    }
  };

  return (
    <div style={{ 
      padding: '30px', 
      backgroundColor: '#121212',
      minHeight: '100vh',
      color: '#fff'
    }}>
      <h1 style={{ 
        color: '#fff', 
        textAlign: 'center', 
        marginBottom: '40px',
        fontSize: '2.5rem',
        fontWeight: '500'
      }}>
        Customer Churn Analytics Dashboard
      </h1>
      
      <div style={{ 
        display: 'grid', 
        gridTemplateColumns: 'repeat(2, 1fr)',
        gap: '30px',
        maxWidth: '1800px',
        margin: '0 auto'
      }}>
        {/* Revenue Risk */}
        <div style={{ 
          backgroundColor: '#1E1E1E', 
          padding: '25px', 
          borderRadius: '15px',
          height: '380px',
          boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)',
          border: '1px solid rgba(255, 255, 255, 0.1)'
        }}>
          <h2 style={{ 
            color: colors.darkRed,
            marginBottom: '20px',
            fontSize: '1.5rem'
          }}>Revenue Risk</h2>
          <Line data={revenueData} options={chartOptions} />
        </div>

        {/* Churn by Spend */}
        <div style={{ 
          backgroundColor: '#1E1E1E', 
          padding: '25px', 
          borderRadius: '15px',
          height: '380px',
          boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)',
          border: '1px solid rgba(255, 255, 255, 0.1)'
        }}>
          <h2 style={{ 
            color: colors.darkBlue,
            marginBottom: '20px',
            fontSize: '1.5rem'
          }}>Churn by Spend</h2>
          <Bar data={churnData} options={chartOptions} />
        </div>

        {/* Customer Journey */}
        <div style={{ 
          backgroundColor: '#1E1E1E', 
          padding: '25px', 
          borderRadius: '15px',
          height: '380px',
          boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)',
          border: '1px solid rgba(255, 255, 255, 0.1)'
        }}>
          <h2 style={{ 
            color: colors.purple,
            marginBottom: '20px',
            fontSize: '1.5rem'
          }}>Customer Journey Risk</h2>
          <Line data={journeyData} options={chartOptions} />
        </div>

        {/* Acquisition vs Loss */}
        <div style={{ 
          backgroundColor: '#1E1E1E', 
          padding: '25px', 
          borderRadius: '15px',
          height: '380px',
          boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)',
          border: '1px solid rgba(255, 255, 255, 0.1)'
        }}>
          <h2 style={{ 
            color: colors.darkBlue,
            marginBottom: '20px',
            fontSize: '1.5rem'
          }}>Customer Acquisition vs Loss</h2>
          <Bar data={acquisitionData} options={chartOptions} />
        </div>

        {/* Most Valued Customers */}
        <div style={{ 
          backgroundColor: '#1E1E1E', 
          padding: '25px', 
          borderRadius: '15px',
          height: '380px',
          boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)',
          border: '1px solid rgba(255, 255, 255, 0.1)'
        }}>
          <h2 style={{ 
            color: colors.darkRed,
            marginBottom: '20px',
            fontSize: '1.5rem'
          }}>Most Valued Customers</h2>
          <Doughnut data={valuedCustomersData} options={{
            ...chartOptions,
            plugins: {
              ...chartOptions.plugins,
              legend: {
                ...chartOptions.plugins.legend,
                position: 'right' as const
              }
            }
          }} />
        </div>

        {/* Risk Distribution */}
        <div style={{ 
          backgroundColor: '#1E1E1E', 
          padding: '25px', 
          borderRadius: '15px',
          height: '380px',
          boxShadow: '0 4px 6px rgba(0, 0, 0, 0.1)',
          border: '1px solid rgba(255, 255, 255, 0.1)'
        }}>
          <h2 style={{ 
            color: colors.purple,
            marginBottom: '20px',
            fontSize: '1.5rem'
          }}>Customer Risk Distribution</h2>
          <Doughnut data={riskDistributionData} options={{
            ...chartOptions,
            plugins: {
              ...chartOptions.plugins,
              legend: {
                ...chartOptions.plugins.legend,
                position: 'right' as const
              }
            }
          }} />
        </div>
      </div>
    </div>
  );
};

const root = document.getElementById('root');
if (!root) throw new Error('Root element not found');

const reactRoot = ReactDOM.createRoot(root);

reactRoot.render(
  <React.StrictMode>
    <Dashboard />
  </React.StrictMode>
);
