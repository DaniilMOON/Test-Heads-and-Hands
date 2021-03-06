// \HxH School iOS Pass
// Copyright © 2021 Heads and Hands. All rights reserved.
//

import Foundation

struct ErrorResponse: Decodable {
    // MARK: Lifecycle

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode(String.self, forKey: CodingKeys.message)
        fields = try container.decode([FieldError].self, forKey: CodingKeys.fields)
    }

    // MARK: Internal

    enum CodingKeys: String, CodingKey {
        case message, fields
    }

    let message: String
    let fields: [FieldError]?
}
