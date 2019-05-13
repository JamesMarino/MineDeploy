import React, { Component } from 'react';
import { Link } from "react-router-dom";
import withStyles from 'react-jss';

import styles from '../styles/css/views/HomeView.css';
import { staticRoutes } from "../constants/routes.constants";
import Header from "../components/Header.component";

class HomeView extends Component {

    render() {
        const { classes } = this.props;

        return (
            <div className={classes.container}>
                <Header headingText="Home" />
                <Link to={staticRoutes.newDeployment}>Create Deployment</Link>
            </div>
        );
    }
}

export default withStyles(styles)(HomeView);
