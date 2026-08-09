Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDCF72941A
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 00:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786236501; cv=none; b=Kb7pDwG3BayPM5Nbnoa4AVX7PHWotSEw38r4YpXKqxPoCx1O3T+7nDKI9yNo9rOlwrU0Q1mNiOr90SHnFfh/f8m+9V8KdPJHYHMtQcOX/xEqMVX5raZHku+GwOTfpPM42hxvofvfxirNyCub69rFqaiymRROG1DVAKwH00rUW0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786236501; c=relaxed/simple;
	bh=zQCrp54J2DxVSTj2I0r0sHubBKAtojCkXDgPwU1NClU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qa9qJSvo+mifax9qhAtqefhz1NdwpuGs1RSHvUfCEfrPL9fCbecTmXJ2trj6tTk/VsC2LY/kuYun7MQHj4DcIAR1nlM7p0Y5t319LkVtVIEn9z9eq55F28Z8FwCv5hCJ6K+GWfDDOmsbKIwr0WXAdehhQURSdV2f/7qCnGxf7KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOCCzIJI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOCCzIJI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4273D1F00A3E;
	Sun,  9 Aug 2026 00:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786236499;
	bh=66MEpxQ9Ggp2Ef/smcWSlRkaKuxrsDgRns16q+jWiHE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nOCCzIJIDzFjU2jqN03dYUnjJG0DE+/yztb8aW/Fn70vYdcmzmh78kwr7Vl0fwm0G
	 s44CopGX+XMz1jWduBS1K6MguHE9Fi/z6tTQHyeayeE/po/IcDvQCOi3xvrw5Bey4y
	 MA2x5uLfirOIf0bhgJLyUFZG30wCiwDpLpgytxaImMzgNQ+aiZpfnmWWB027w6vljn
	 A/8ORxG6Xe6/EOFy+0uDQPExYgFRthv0cAW97lFwiaTSUBQ17PvePo5WCsyO8tZos1
	 JzfU2xcJ6j2A2unVATeZmNr7dIWEvpBLMPBRhrZhcnVJ7QYIe5inf97/VKAv69uPht
	 7I88KJ71V1EYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 7/7] ksmbd: validate minimum PDU size for transform requests
Date: Sat,  8 Aug 2026 20:48:11 -0400
Message-ID: <20260809004811.874454-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809004811.874454-1-sashal@kernel.org>
References: <2026072924-music-polyester-3132@gregkh>
 <20260809004811.874454-1-sashal@kernel.org>
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
index 9b5d95d0481d6..5a896b146f437 100644
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

