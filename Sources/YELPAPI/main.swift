import ApolloCodegenLib
import FileProvider

let parentFolderOfScriptFile = FileFinder.findParentFolder()

let packageDirectoryFolder = parentFolderOfScriptFile.deletingLastPathComponent().deletingLastPathComponent()

let sourceSourcesFolder = parentFolderOfScriptFile.deletingLastPathComponent()

let cliFolderURL = packageDirectoryFolder.appendingPathComponent("ApolloCLI")

let graphQLFolder = sourceSourcesFolder.appendingPathComponent("GraphQL")

let yelpGraphQLURL = URL(string: "https://api.yelp.com/v3/graphql")!

let yelpAPIKey: String = "qco6Jeyqwo8-v8QRaCxWSiO5Fwr7JhWOSObUthK4ajdFVGuTvPHNjmi_b9A_UaOAmJzo2Vt6GlEmyxJwIOs2yWXr3FcPK0x3QBA-YpLFPq-w_UnIl9Q4bb0_SumwXHYx"

let schemaDownloadOptions: ApolloSchemaOptions = ApolloSchemaOptions.init(endpointURL: yelpGraphQLURL, header: "Authorization: Bearer \(yelpAPIKey)", outputFolderURL: graphQLFolder)

let codeGenerationOption: ApolloCodegenOptions = ApolloCodegenOptions.init(targetRootURL: graphQLFolder)

do {
    
    //Do the schema download
    try ApolloSchemaDownloader.run(with: cliFolderURL, options: schemaDownloadOptions)
    
    try ApolloCodegen.run(from: graphQLFolder, with: cliFolderURL, options: codeGenerationOption)
    
}catch{
    print(error)
    exit(1)
}
