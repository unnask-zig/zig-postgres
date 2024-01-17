const std = @import("std");

const BackendMessage = union(enum) {
    authenticationOk,

    unsupported,
};

inline fn deserializeAuthentication(message: []const u8) BackendMessage {
    _ = message;
    return .authenticationOk;
}

pub fn deserialize(message: []const u8) BackendMessage {
    return switch (message[0]) {
        'R' => deserializeAuthentication(message),
        else => .unsupported,
    };
}

//authenticationOk
//authenticationKerberosV5
//authenticationCleartextPass
//authenticationMD5Pass
//authenticationSCMCredential
//authenticationGSS
//authenticationGSSContinue
//authenticationSSPI
//authenticationSASL
//authenticationSASLContinue
//authenticationSASLFinal
//backendKeyData
//bindComplete
//closeComplete
//commandComplete
//copyData
//copyDone
//copyInResponse
//copyOutResponse
//copyBothResponse
//dataRow
//emptyQueryResponse
//errorResponse
//functionCallResponse
//negotiateProtocolVersion
//noData
//noticeResponse
//notificationResponse
//parameterDescription
//parameterStatus
//parseComplete
//portalSuspended
//readyForQuery
//rowDescription

test "BackendMessage.authenticationOK good message" {
    const msg = [_]u8{ 'R', 0, 0, 0, 8, 0, 0, 0, 0 };

    const des = deserialize(&msg);

    try std.testing.expectEqual(des, BackendMessage.authenticationOk);
}
