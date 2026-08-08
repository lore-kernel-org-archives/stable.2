Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7F4418A44
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 14:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786198196; cv=none; b=m9oGYD/nwSMbm3gaB3EbQJ9Joi9CZuOTnY7ex50vWWeuO5R0KIVrwgL+EHHYClmiCLCS4EB263lwfo3xllUARBn+kjKO5cBdwPzrRAbi6UkTr/Jn8PN92dGPnjKmNANdz8zikFzgKQ7raO67DPAfoWLufuNZbOEd6Gb77DxUPoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786198196; c=relaxed/simple;
	bh=AFtHcdMypOjeg9r5cQllgAt9I05RwVH3IFjVSFHQrWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r/c4J6/pcuM2zzyJWMKMMPNbyU3M12kM3/4TIsfYFeAL1zU1ZtlNwtbPVmNi16ZMFvhCMGWKjg66ZKao105yaJ4VmoW3zcdig3gGMytxFL9+mjZeK20c/zxNB5V1Dp7AUrjGMTlxPrwqFnW5ICcIdtH8j4yZd19C/fX+6CbKCv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JmTGX2is; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JmTGX2is"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D06F91F00A3E;
	Sat,  8 Aug 2026 14:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786198195;
	bh=ZUScZUdflganX3liUyC0M3pmtp50GO7+oLv5ZYwn+wQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JmTGX2iswoWxidm0aKl5VZmjumxuhRpnGpJjS5lMI9k2Hxmm3TWQlToUSj+EuxS3B
	 2wwTb9o9fEGPjpDgPLO1XCUF+Qj3NpjViIFLZzeYibmXa1LrC2bMuIJwuBRZC2eIHB
	 v0NGNlN1/LAVUC6bofhqoYPq2DJWtX5OW+J9MPzv5Fw0HsSGOal9x+SpZdA3Fb9lXy
	 BEKQoUdJCDf0hzMj9XV7F7rTcgqNNgqrsON4l5xo51ns9B4iNCXE9YLLy4cy/I65RL
	 kgTxrNvOXTNPSV4JZlHhOaGgHyYK0CmRwyM6jqoBrK0BWSfEpPe7BdUfCWuZ4WkHD4
	 XmrhugthjWnrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 7/7] ksmbd: validate minimum PDU size for transform requests
Date: Sat,  8 Aug 2026 10:09:48 -0400
Message-ID: <20260808140948.340323-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808140948.340323-1-sashal@kernel.org>
References: <2026072924-aviator-carton-3ed9@gregkh>
 <20260808140948.340323-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit cfc0b8e5080aec87700774e8568765eaa4b7b92b ]

The receive path applies the minimum SMB2 PDU size check only when
ProtocolId is SMB2_PROTO_NUMBER. A packet carrying
SMB2_TRANSFORM_PROTO_NUM bypasses the check even when the negotiated
dialect does not provide transform handling.

On an SMB 2.1 connection, a short transform packet therefore reaches
init_smb2_rsp_hdr(), which interprets the request as a full SMB2 header
and reads beyond the request allocation. The copied fields can then be
returned to the unauthenticated client.

Compression transforms are converted to ordinary SMB2 messages before
protocol validation. After that conversion, validate ordinary SMB2
requests against SMB2_MIN_SUPPORTED_PDU_SIZE and require encryption
transform requests to contain both a transform header and an SMB2
header. This rejects truncated requests before work allocation.

Fixes: 368ba06881c3 ("ksmbd: check the validation of pdu_size in ksmbd_conn_handler_loop")
Cc: stable@vger.kernel.org
Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-31063
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/connection.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index a50213e4307e1..c193b87cfa750 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -379,6 +379,8 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 /* "+2" for BCC field (ByteCount, 2 bytes) */
 #define SMB1_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb_hdr) + 2)
 #define SMB2_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb2_pdu))
+#define SMB2_TRANSFORM_MIN_SUPPORTED_PDU_SIZE	\
+	(sizeof(struct smb2_transform_hdr) + sizeof(struct smb2_hdr))
 
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
@@ -393,6 +395,7 @@ int ksmbd_conn_handler_loop(void *p)
 	struct ksmbd_conn *conn = (struct ksmbd_conn *)p;
 	struct ksmbd_transport *t = conn->transport;
 	unsigned int pdu_size, max_allowed_pdu_size, max_req;
+	__le32 proto;
 	char hdr_buf[4] = {0,};
 	int size;
 
@@ -476,11 +479,14 @@ int ksmbd_conn_handler_loop(void *p)
 		if (!ksmbd_smb_request(conn))
 			break;
 
-		if (((struct smb2_hdr *)smb_get_msg(conn->request_buf))->ProtocolId ==
-		    SMB2_PROTO_NUMBER) {
-			if (pdu_size < SMB2_MIN_SUPPORTED_PDU_SIZE)
-				break;
-		}
+		proto = *(__le32 *)smb_get_msg(conn->request_buf);
+		if (proto == SMB2_PROTO_NUMBER &&
+		    pdu_size < SMB2_MIN_SUPPORTED_PDU_SIZE)
+			break;
+
+		if (proto == SMB2_TRANSFORM_PROTO_NUM &&
+		    pdu_size < SMB2_TRANSFORM_MIN_SUPPORTED_PDU_SIZE)
+			break;
 
 		if (!default_conn_ops.process_fn) {
 			pr_err("No connection request callback\n");
-- 
2.53.0

