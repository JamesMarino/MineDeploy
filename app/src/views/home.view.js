import React, { Component } from 'react';
import withStyles from 'react-jss';

import styles from '../styles/css/RecipeView.css';

class HomeView extends Component {

    render() {
        const { classes } = this.props;

        return (
            <div className={classes.container}>
                <h1>Dashboard Home</h1>
            </div>
        );
    }
}

export default withStyles(styles)(HomeView);
