Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E1B347FCD
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 13:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283687; cv=none; b=I5FHQtdgpuMwCHMm6omCXyZeRQ6RKR2Ww/m+eFnX67LgsNTwPvqh25GttbDpvFtP6T6oY1h7Bl7jFgOvlMtqYs2qVUnCRfaXrWUL9cr8SGnHB4pmjEM7p1HvKvuSaPIuK44UouN67K937OlomAWi9+dMSPbesQCRJbT5360OPM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283687; c=relaxed/simple;
	bh=a1dm2/K8+AOuds0d7/geId2G89Z6Qc9YZTsWvXbxZeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mHqL98Y7YPGU3e1tpsS4bApWh866zwOKKkxM5npnhGWfGmM2C2NWyZKIHHFOjLzvSMB9Fhri3jyPIe74s2ibnTo1mnoTHHsY7VVudryMTPL3bNBMCHu1/yHDT6ZyOCdYo/EKpVNpSCowFriCFc0yNmNjUgpBvPAE7eD763KjUfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YboXikxV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YboXikxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15C71F00ACF;
	Sun,  9 Aug 2026 13:54:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786283685;
	bh=wXTgGDva9Qg3AX56wx39W5Cdn1KPnuU8+2a0pPOwBjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YboXikxVgU1eQ/57qme7lRTsKGpNzegwGa9I4LNUdEu+JH7CEQ17jWavSnNokhY01
	 xxlyDou3zFAFo6BVgk/drSKM+BsScfm/T+hmrU+e+FizxsXrvV2FImFydNRrIpRod9
	 sWhHMjUmbjvwxzahpy2xw9ei+Jok9z04AqxQJbhXsWkJpIEm+q7sSqUxzWhPKsA+o+
	 +2CNinXpK3BRfGyfVQkQLEqJv1mnCgeSWSJMBkyV/0tDyORNFuwJ/PTJuP+vsoOjrt
	 KAw99+YvPxDEVfRoBMMsKdU+y7sve32Rk8R6SJ7jZzZLgDpF8e5UMFUMp6vX7/vLLP
	 dh4sVz70x5JFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	zdi-disclosures@trendmicro.com,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 4/4] ksmbd: validate minimum PDU size for transform requests
Date: Sun,  9 Aug 2026 09:54:40 -0400
Message-ID: <20260809135440.1507266-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809135440.1507266-1-sashal@kernel.org>
References: <2026072926-trapped-grumbling-0f6e@gregkh>
 <20260809135440.1507266-1-sashal@kernel.org>
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
 fs/ksmbd/connection.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index 399ac2f15c60a..b0a47b7923d52 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
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

