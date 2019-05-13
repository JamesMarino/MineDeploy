import React, { Component } from 'react';
import { ThemeProvider } from 'react-jss';
import { BrowserRouter as Router, Route } from 'react-router-dom';

import { staticRoutes } from './constants/routes.constants';
import mainTheme from './styles/themes/main.theme';
import HomeView from './views/Home.view';
import NewDeployment from './views/NewDeployment.view';
import NavBar from './components/NavBar.component';

class App extends Component {
    render() {
        return (
            <ThemeProvider theme={mainTheme}>
                <Router>
                    <NavBar />
                    <Route path={staticRoutes.home} exact component={HomeView} />
                    <Route path={staticRoutes.newDeployment} exact component={NewDeployment} />
                </Router>
            </ThemeProvider>
        );
    }
}

export default App;
