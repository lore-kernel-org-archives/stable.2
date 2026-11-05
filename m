Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901527;
	b=BC8WRNmVBLOtIKGLYUpgmFdemWTfqr8ZofAL7icpIDX/hNiYl50pKNqvofVmYrlk4pzI
	 UrT6o1K2UrF59PFHZyTOVyGUKt3oF3qXk+AKTbtF04b0HIJu4DeD94QIwl0XPlUInGLSm
	 LkipPbCXdRBWn+FREIhubGa8rTIelnHOwUNWo1NqJSMZGSrMMLNenbpTfkcTmzVEa6tXl
	 PuHX885l481poHFVMyA8JhiTsH7Qu2oj9Vm+DRMrjqPJk4rhbnAkGZXgTt1C0RK4UMJdQ
	 EauNiTEeTR4Z3OYFnwsy5Z3G8YbbrfJcLoNKU6cPUmHDBYKi2EB3ewTD0SlNdE6bPJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901527;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R3kSVNpZPrPap6Obxn8cD+B8hAiNAKnyxQvJlbx84w4=;
	b=GkHZbzcN5UkV8EdsKm5DOCML6YK03qEfCs61TICsl3bjuMOfHuCWoo4sePcbov49rS5i
	 +xcW0/JGxSwL0e5wv9uMCMTuaqm1xseSmQf9BFn5666DYvo66KH1EGX65sRV2qtFCMQv7
	 LB75zz7ee+lR5U1Nf8AafKaNX4ysmrzQtBy1PUtCyI9g3jhIOPQxPcZ54/tf9GRpe4lGp
	 SaCyFCZCkjFIXPGcT0GNvCdtq6K9WoAzrWQ1LVyR6CMEZWDxLh0r9JN4nog4O19mNv9mk
	 xeXGxPutzQ2zvLu3JNO9Ghl4//BObOGrsR3/6ChhcSgb2O4GF3Hovns4/45wlEZkyQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfUSJURR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86F3606A32E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bfUSJURR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE5A1F0093A;
	Thu,  5 Nov 2026 17:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901526;
	bh=R3kSVNpZPrPap6Obxn8cD+B8hAiNAKnyxQvJlbx84w4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bfUSJURRAEsxkzkjztMgz5uyL9/of428rQS+RjX8+KJ6GoNbcSydJV53KgjytiXzj
	 ZUvPhzujCVCG1NNbKimpereOtQND25xamO+HEwTqMTykwvizZ3pwjvTsES/9IyVfIX
	 NvW4WJwFVgByeYdYEoU4IRijxhEmUMHtAOBOm0Cz0l/5+lNniiHcmz4VdMlSLffSzF
	 0EbzRp3tKU9ZRlXAraYbrN+ewe0tTVOnHmnXAgBz0sfJHYe7qtf0cq3Sv2csObLtNe
	 awLlDffC092oNT1yVWYwRl3rb+z4bWPdx4xpCI2ewwUWoppEsHKN35k9hyEsyrUItX
	 PmbgEQTAlUBHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/8] smb: move create_durable_req_v2 to common/smb2pdu.h
Date: Thu,  5 Nov 2026 12:58:37 -0500
Message-ID: <20261105175828.2192358-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105175828.2192358-1-sashal@kernel.org>
References: <2026110435-maternity-atlantic-ccce@gregkh>
 <20261105175828.2192358-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

[ Upstream commit 833a75fc9ecc3856a52223d8c245e52703e0a9f1 ]

Modify the following places:

  - some fields in "struct create_durable_req_v2" ->
                           struct durable_context_v2
  - durable_context_v2 -> durable_context_v2_req
  - create_durable_v2 -> create_durable_req_v2

Then move duplicate definitions to common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: f8171804a39e ("smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.c | 14 +++++++-------
 fs/smb/client/smb2pdu.h | 12 ------------
 fs/smb/common/smb2pdu.h | 14 ++++++++++++++
 fs/smb/server/smb2pdu.c |  8 ++++----
 fs/smb/server/smb2pdu.h |  9 ---------
 5 files changed, 25 insertions(+), 32 deletions(-)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 6d610f136f43e..436dd661d339c 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2456,21 +2456,21 @@ add_lease_context(struct TCP_Server_Info *server,
 	return 0;
 }
 
-static struct create_durable_v2 *
+static struct create_durable_req_v2 *
 create_durable_v2_buf(struct cifs_open_parms *oparms)
 {
 	struct cifs_fid *pfid = oparms->fid;
-	struct create_durable_v2 *buf;
+	struct create_durable_req_v2 *buf;
 
-	buf = kzalloc(sizeof(struct create_durable_v2), GFP_KERNEL);
+	buf = kzalloc(sizeof(struct create_durable_req_v2), GFP_KERNEL);
 	if (!buf)
 		return NULL;
 
 	buf->ccontext.DataOffset = cpu_to_le16(offsetof
-					(struct create_durable_v2, dcontext));
-	buf->ccontext.DataLength = cpu_to_le32(sizeof(struct durable_context_v2));
+					(struct create_durable_req_v2, dcontext));
+	buf->ccontext.DataLength = cpu_to_le32(sizeof(struct durable_context_v2_req));
 	buf->ccontext.NameOffset = cpu_to_le16(offsetof
-				(struct create_durable_v2, Name));
+				(struct create_durable_req_v2, Name));
 	buf->ccontext.NameLength = cpu_to_le16(4);
 
 	/*
@@ -2540,7 +2540,7 @@ add_durable_v2_context(struct kvec *iov, unsigned int *num_iovec,
 	iov[num].iov_base = create_durable_v2_buf(oparms);
 	if (iov[num].iov_base == NULL)
 		return -ENOMEM;
-	iov[num].iov_len = sizeof(struct create_durable_v2);
+	iov[num].iov_len = sizeof(struct create_durable_req_v2);
 	*num_iovec = num + 1;
 	return 0;
 }
diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index de2d83c6463c9..472553e499830 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -137,18 +137,6 @@ struct share_redirect_error_context_rsp {
 /* See MS-SMB2 2.2.13.2.11 */
 /* Flags */
 #define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
-struct durable_context_v2 {
-	__le32 Timeout;
-	__le32 Flags;
-	__u64 Reserved;
-	__u8 CreateGuid[16];
-} __packed;
-
-struct create_durable_v2 {
-	struct create_context_hdr ccontext;
-	__u8   Name[8];
-	struct durable_context_v2 dcontext;
-} __packed;
 
 /* See MS-SMB2 2.2.13.2.12 */
 struct durable_reconnect_context_v2 {
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 1bd5835c56e45..ca47c54afd324 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1290,6 +1290,20 @@ struct create_mxac_req {
 	__le64 Timestamp;
 } __packed;
 
+/* See MS-SMB2 2.2.13.2.11 */
+struct durable_context_v2_req {
+	__le32 Timeout;
+	__le32 Flags; /* see SMB2_DHANDLE_FLAG_PERSISTENT */
+	__u64 Reserved;
+	__u8 CreateGuid[16];
+} __packed;
+
+struct create_durable_req_v2 {
+	struct create_context_hdr ccontext;
+	__u8   Name[8];
+	struct durable_context_v2_req dcontext;
+} __packed;
+
 /* See MS-SMB2 2.2.14.2.5 */
 struct create_mxac_rsp {
 	struct create_context_hdr ccontext;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 55d634b5d2e2f..9e54b4301106b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2908,7 +2908,7 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 			durable_v2_blob =
 				(struct create_durable_req_v2 *)context;
 			ksmbd_debug(SMB, "Request for durable v2 open\n");
-			dh_info->fp = ksmbd_lookup_fd_cguid(durable_v2_blob->CreateGuid);
+			dh_info->fp = ksmbd_lookup_fd_cguid(durable_v2_blob->dcontext.CreateGuid);
 			if (dh_info->fp) {
 				if (!memcmp(conn->ClientGUID, dh_info->fp->client_guid,
 					    SMB2_CLIENT_GUID_SIZE)) {
@@ -2933,11 +2933,11 @@ static int parse_durable_handle_context(struct ksmbd_work *work,
 			if ((lc && (lc->req_state & SMB2_LEASE_HANDLE_CACHING_LE)) ||
 			    req_op_level == SMB2_OPLOCK_LEVEL_BATCH) {
 				dh_info->CreateGuid =
-					durable_v2_blob->CreateGuid;
+					durable_v2_blob->dcontext.CreateGuid;
 				dh_info->persistent =
-					le32_to_cpu(durable_v2_blob->Flags);
+					le32_to_cpu(durable_v2_blob->dcontext.Flags);
 				dh_info->timeout =
-					le32_to_cpu(durable_v2_blob->Timeout);
+					le32_to_cpu(durable_v2_blob->dcontext.Timeout);
 				dh_info->type = dh_idx;
 			}
 			break;
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 48026edb7314b..189e0d955b4a5 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -66,15 +66,6 @@ struct preauth_integrity_info {
 /* Apple Defined Contexts */
 #define SMB2_CREATE_AAPL		"AAPL"
 
-struct create_durable_req_v2 {
-	struct create_context_hdr ccontext;
-	__u8   Name[8];
-	__le32 Timeout;
-	__le32 Flags;
-	__u8 Reserved[8];
-	__u8 CreateGuid[16];
-} __packed;
-
 #define DURABLE_HANDLE_MAX_TIMEOUT	300000
 
 struct create_durable_reconn_req {
-- 
2.53.0

