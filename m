Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F236DCE1
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249231; cv=none; b=OlEygkVxgYRuMt1Iz6yOPwXnmHStmpK/4f9dZK2HAOgUJx5+AguZQ6PmPCCO7OLAjiVREbEiZgnvLFx23Gh1oFlQO+P41DmaaDqkHwTuyFcJjEcoN5eRi8fuYsa2+/mV+NYqA+roTbQZ3jgRohvlZjhc/FnZNIB5Wz5HqBvO9ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249231; c=relaxed/simple;
	bh=QqXDo2yjW3AIuoh+1qRSHrmteYvYELFbeONF0+2ah8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bmPM70nGPnxiXDzgazyiOyeRppMOba3esMwiSklvISs+xX1u0YWvC1ZLslw1gXTwSHFpjF3ZxWmDIj1D7d787muLyW4k8D5DajuH5GUU7P9kehGg2imo1hkVzzJsBNahr13kxI3tUPQP4Ax3ChGh3FvI09TUDRY7tO5Uf4RZKCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P1j3TPLa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P1j3TPLa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2C781F00A3D;
	Sun,  9 Aug 2026 04:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249230;
	bh=W9NqGIAwEwo/Kj7hJO5vyZ2HyO7l3RC6+EjHnv0x2YA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P1j3TPLaZq5tDeBAK3leQaSuEZd4v8cnKWbLVJUeTMGLVcBrlCgcdO741QcdysYZ2
	 gAQIbXZGm92D3M0KHTWcuhcVgH/RxEww12F3vxROQewPC2WyTYO77tWvcYDOY6KHHP
	 nCsoEZ7Pjft8RoYA2kiafHpI6Y0q5pThtxp5obB6aXlwkX2YLUcnc69eWJ/KppQBKt
	 zMWCxXDENKE6fxnq/uHOAAsj/lKvYG946GVX5SSxpGyTYSxAY6Ofy7l5mtWvJTC5jI
	 /iBLD1eDNRbsd6BJWGPiVUFykFxxV0O2WAQQKvcyBZnkWq7Sn+NOZshKbCpV3Hpe5X
	 VxpVSFeAkhqBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 5/5] ksmbd: validate minimum PDU size for transform requests
Date: Sun,  9 Aug 2026 00:20:24 -0400
Message-ID: <20260809042024.1093624-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809042024.1093624-1-sashal@kernel.org>
References: <2026072925-revenge-tabasco-bcf9@gregkh>
 <20260809042024.1093624-1-sashal@kernel.org>
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
index b10313cb50ea2..0d27651aa4cc5 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -308,6 +308,8 @@ bool ksmbd_conn_alive(struct ksmbd_conn *conn)
 /* "+2" for BCC field (ByteCount, 2 bytes) */
 #define SMB1_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb_hdr) + 2)
 #define SMB2_MIN_SUPPORTED_PDU_SIZE (sizeof(struct smb2_pdu))
+#define SMB2_TRANSFORM_MIN_SUPPORTED_PDU_SIZE	\
+	(sizeof(struct smb2_transform_hdr) + sizeof(struct smb2_hdr))
 
 /**
  * ksmbd_conn_handler_loop() - session thread to listen on new smb requests
@@ -322,6 +324,7 @@ int ksmbd_conn_handler_loop(void *p)
 	struct ksmbd_conn *conn = (struct ksmbd_conn *)p;
 	struct ksmbd_transport *t = conn->transport;
 	unsigned int pdu_size, max_allowed_pdu_size;
+	__le32 proto;
 	char hdr_buf[4] = {0,};
 	int size;
 
@@ -397,11 +400,14 @@ int ksmbd_conn_handler_loop(void *p)
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

