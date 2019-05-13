import React, { Fragment } from 'react';
import withStyles from 'react-jss';
import { Link } from 'react-router-dom';

import styles from '../styles/css/NavBar.css';
import logo from '../images/logo.svg';
import { staticRoutes } from '../constants/routes.constants';

class NavBar extends React.PureComponent {
    render() {
        const { classes } = this.props;

        return (
            <Fragment>
                <div className={classes.container}>
                    <img
                        className={classes.logo}
                        src={logo}
                        alt="Mine Deploy"
                    />
                    <Link className={classes.headerLink} to={staticRoutes.home}>
                        Home
                    </Link>
                </div>
                <div className={classes.heightContainer} />
            </Fragment>
        );
    }
}

export default withStyles(styles)(NavBar);
