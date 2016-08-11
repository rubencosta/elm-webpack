const resolve = require('path').resolve
const HtmlWebpackPlugin = require('html-webpack-plugin')
const Webpack = require('webpack')

module.exports = env => {
    const addPlugin = (add, plugin) => (add ? plugin : undefined)
    const ifDev = plugin => addPlugin(env.dev, plugin)
    const ifProd = plugin => addPlugin(env.prod, plugin)
    const removeEmpty = array => array.filter(plugin => !!plugin)

    return {
        context: resolve(__dirname, './src'),
        entry: './index.js',
        output: {
            path: resolve(__dirname, './dist'),
            pathinfo: !env.prod,
            filename: 'bundle.js',
        },
        devtool: env.prod ? 'source-map' : 'cheap-module-eval-source-map',
        bail: env.prod,
        resolve: {
            moduleDirectories: ['node_modules'],
            extensions: ['', '.js', '.elm'],
        },
        module: {
            noParse: /\.elm$/,
            loaders: [
                env.prod ?
                    {
                        test: /\.elm$/,
                        exclude: [/elm-stuff/, /node_modules/],
                        loader: 'elm-webpack'
                    } : {
                        test: /\.elm$/,
                        exclude: [/elm-stuff/, /node_modules/],
                        loader: 'elm-hot!elm-webpack?verbose=true&warn=true'
                    },
                {
                    test: /\.(css|scss)$/,
                    loaders: ['style', 'css'],
                },
                {
                    test: /\.woff(2)?(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                    loader: 'url-loader?limit=10000&minetype=application/font-woff',
                },
                {
                    test: /\.(ttf|eot|svg)(\?v=[0-9]\.[0-9]\.[0-9])?$/,
                    loader: 'file-loader',
                },
            ],
        },
        plugins: [
            new HtmlWebpackPlugin({
                template: './index.tpl.html',
            }),
            ...removeEmpty([
                ifDev(new Webpack.LoaderOptionsPlugin({
                    minimize: false,
                    debug: true,
                })),
                ifDev(new Webpack.DefinePlugin({
                    __DEV__: true,
                    'process.env': {
                        NODE_ENV: '"development"',
                    },
                })),
                ifProd(new Webpack.LoaderOptionsPlugin({
                    minimize: true,
                    debug: false,
                })),
                ifProd(new Webpack.DefinePlugin({
                    __DEV__: false,
                    'process.env': {
                        NODE_ENV: '"production"',
                    },
                })),
                ifProd(new Webpack.optimize.UglifyJsPlugin({
                    screw_ie8: true,
                    warnings: false,
                })),
                ifProd(new Webpack.optimize.OccurrenceOrderPlugin()),
                ifProd(new Webpack.optimize.DedupePlugin()),
            ]),
        ]
    }
}