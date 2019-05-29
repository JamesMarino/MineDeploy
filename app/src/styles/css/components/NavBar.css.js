const styles = theme => ({
    container: {
        position: 'fixed',
        backgroundColor: theme.primaryBackgroundColor,
        display: 'flex',
        flexDirection: 'row',
        alignItems: 'center',
        width: '100%',
        boxShadow: '0 2px 4px rgba(0,0,0,0.15)',
        padding: 10,
        height: 40,
        zIndex: theme.maxZIndex,
    },
    logo: {
        height: 30,
    },
    heightContainer: {
        height: 50,
        paddingBottom: 10,
        backgroundColor: theme.secondaryBackgroundColor,
    },
    headerLink: {
        paddingLeft: 30,
        textDecoration: 'none',
        color: theme.primaryFontColor,
    },
});

export default styles;
