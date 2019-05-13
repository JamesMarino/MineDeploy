import React from 'react';
import withStyles from 'react-jss';

import styles from '../styles/css/components/DeploymentForm.css';

class DeploymentForm extends React.PureComponent {
    render() {
        const { classes } = this.props;

        return (
            <div className={classes.container}>
                <label>Friendly Name: </label>
                <input type="text" />
                <br />
                <label>Host Name: </label>
                <input type="text" />
                <br />
                <label>Memory: </label>
                <input type="text" />
                <br />
                <label>CPU: </label>
                <input type="text" />
            </div>
        );
    }
}

export default withStyles(styles)(DeploymentForm);
