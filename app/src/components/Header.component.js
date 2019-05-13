import React, { Fragment } from 'react';
import withStyles from 'react-jss';

import styles from '../styles/css/components/Header.css';

class Header extends React.PureComponent {
    render() {
        const { headingText, classes } = this.props;

        return (
            <Fragment>
                <h1 className={classes.container}>{headingText}</h1>
            </Fragment>
        );
    }
}

export default withStyles(styles)(Header);
