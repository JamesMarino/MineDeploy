import React, { Component } from 'react';
import withStyles from 'react-jss';

import styles from '../styles/css/views/NewDeploymentView.css';
import DeploymentForm from '../components/DeploymentForm.component';
import Header from "../components/Header.component";

class HomeView extends Component {

    render() {
        const { classes } = this.props;

        return (
            <div className={classes.container}>
                <Header headingText="New Deployments" />
                <DeploymentForm />
            </div>
        );
    }
}

export default withStyles(styles)(HomeView);
