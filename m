Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793901528;
	b=KbR2S+r0BKelGBi6P5f5NB6r9x6OGXASB8QBnSTdVpPTBFuEGqqwUwuQR4QB3qgQ0Kpr
	 HOXPTjoIg/UhTNRreEAueiIUQ1wc2mg0Mkhjyl0mfhMLlvzNNfAH7Q3oKOHVm/KUNUDla
	 Wv+U8XAOL6/N02Pga/7gQ8M4uof33V89/L5Rr5JBH+a45LWdAeJT4U/ss0YCiEtNJb4Fl
	 +m9mVpGWk3Dp9X3ENO8siUccvEZImhL2wASjR6VJY/mAlH76v9SqVmnIS+gJMpKYNFTM6
	 lpL9DZ43mVIVnrrKOGLuHkbFdUQ9jUlkC/1qSWmNdBDUELRRBsua86MBHDumgQ77PHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793901528;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wWmxEbut0bksASAJ5oOfT0KOYyWtCUnzf9CoTHuek5E=;
	b=F/FbhfrdlZ8h49v8y9ADbPwSH4ruO4o8G6GJg67EoYGFipXPTvQZcLon8D5/vModJdzt
	 al3AreZ2ulyh91kAyDP3ok802bRTFVcxGh9VxJ+obQbKfg6+pqGe7Q4pxUd/Rsz/vyiPG
	 gnhBp+VuK8NYcvh8WXPiOSxT5vXuAhBDoZY/bcVXHRfxo8Nyr7JZnaSjuxBVPbpkedeT2
	 0ES7LTjlhSU+Ufn+rGyLOmpo7f6UhGzrjrsJhj/hsDPF/z0xIK6YrlaQHbaJhEQnk3xad
	 5+lIaa3foGD8kMULnrtdYn4IrnOHTV1oBoadjz6FiBc2XkFEXKAZnGYpHyCH1H2mfNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYQg5W68;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D5C606A32E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 17:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bYQg5W68
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EC461F000C1;
	Thu,  5 Nov 2026 17:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793901528;
	bh=wWmxEbut0bksASAJ5oOfT0KOYyWtCUnzf9CoTHuek5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bYQg5W68Zyj+s0F4QjNw/X/6hirE2+g5voxNFWkJTzmd9SUoFk/BIMAmkRt7jBJlD
	 uMXrvOtJFax1J0+hi8Vt2/Iqcwv2T/z8pbyqBlYhMm4SOs9/AufrM94WiHhpBv2DAX
	 C6hHGhCt/HTRbQuDUKSPDIbaO+NVtJ3K1QgDoN7gv9JAGmTfaF/LSJjea8z4WM66Ui
	 Bsxun66+sTERSvAn0AgazCiCjuNeTFa7bxpp9LLdg70+f7a43aZZ0H0+eLrk9UpPvd
	 uCmcJIlxXMXLq9jQSvSTsAOTMJJyHzBSCfbt14pDlXXexeaUfv9rzPRD6ZdJS+s9Zm
	 NSA3a8Gwv7KNQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: ChenXiaoSong <chenxiaosong@kylinos.cn>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/8] smb: move create_durable_rsp_v2 to common/smb2pdu.h
Date: Thu,  5 Nov 2026 12:58:39 -0500
Message-ID: <20261105175828.2192358-4-sashal@kernel.org>
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

[ Upstream commit 96721fd292264d712b7b9a51752ab87de5035db4 ]

Modify the following places:

  - some fields in "struct create_durable_v2_rsp" ->
                       struct durable_context_v2_rsp
  - durable_reconnect_context_v2_rsp -> durable_context_v2_rsp
  - create_durable_v2_rsp -> create_durable_rsp_v2

Then move them to common header file.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: f8171804a39e ("smb: client: fix OOB read of the resume name sent in TRANS2_FIND_NEXT2")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/smb2pdu.h |  6 ------
 fs/smb/common/smb2pdu.h | 12 ++++++++++++
 fs/smb/server/oplock.c  |  8 ++++----
 fs/smb/server/smb2ops.c |  6 +++---
 fs/smb/server/smb2pdu.h |  6 ------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/smb/client/smb2pdu.h b/fs/smb/client/smb2pdu.h
index a75cde061a67d..be0a4f5b26c2e 100644
--- a/fs/smb/client/smb2pdu.h
+++ b/fs/smb/client/smb2pdu.h
@@ -138,12 +138,6 @@ struct share_redirect_error_context_rsp {
 /* Flags */
 #define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
 
-/* See MS-SMB2 2.2.14.2.12 */
-struct durable_reconnect_context_v2_rsp {
-	__le32 Timeout;
-	__le32 Flags; /* see above DHANDLE_FLAG_PERSISTENT */
-} __packed;
-
 /* See MS-SMB2 2.2.13.2.5 */
 struct crt_twarp_ctxt {
 	struct create_context_hdr ccontext;
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index 7899e7706318f..52250409efc8e 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1320,6 +1320,18 @@ struct create_durable_handle_reconnect_v2 {
 	struct durable_reconnect_context_v2 dcontext;
 } __packed;
 
+/* See MS-SMB2 2.2.14.2.12 */
+struct durable_context_v2_rsp {
+	__le32 Timeout;
+	__le32 Flags; /* see SMB2_DHANDLE_FLAG_PERSISTENT */
+} __packed;
+
+struct create_durable_rsp_v2 {
+	struct create_context_hdr ccontext;
+	__u8   Name[8];
+	struct durable_context_v2_rsp dcontext;
+} __packed;
+
 /* See MS-SMB2 2.2.14.2.5 */
 struct create_mxac_rsp {
 	struct create_context_hdr ccontext;
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 90cd8c962f785..c6a6c1181be66 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -1858,9 +1858,9 @@ void create_durable_rsp_buf(char *cc)
  */
 void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp)
 {
-	struct create_durable_v2_rsp *buf;
+	struct create_durable_rsp_v2 *buf;
 
-	buf = (struct create_durable_v2_rsp *)cc;
+	buf = (struct create_durable_rsp_v2 *)cc;
 	memset(buf, 0, sizeof(struct create_durable_rsp));
 	buf->ccontext.DataOffset = cpu_to_le16(offsetof
 			(struct create_durable_rsp, Data));
@@ -1874,9 +1874,9 @@ void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp)
 	buf->Name[2] = '2';
 	buf->Name[3] = 'Q';
 
-	buf->Timeout = cpu_to_le32(fp->durable_timeout);
+	buf->dcontext.Timeout = cpu_to_le32(fp->durable_timeout);
 	if (fp->is_persistent)
-		buf->Flags = cpu_to_le32(SMB2_DHANDLE_FLAG_PERSISTENT);
+		buf->dcontext.Flags = cpu_to_le32(SMB2_DHANDLE_FLAG_PERSISTENT);
 }
 
 /**
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index 4c50b7f57f763..5aa8e63f31902 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -59,7 +59,7 @@ static struct smb_version_values smb30_server_values = {
 	.cap_large_files = SMB2_LARGE_FILES,
 	.create_lease_size = sizeof(struct create_lease_v2),
 	.create_durable_size = sizeof(struct create_durable_rsp),
-	.create_durable_v2_size = sizeof(struct create_durable_v2_rsp),
+	.create_durable_v2_size = sizeof(struct create_durable_rsp_v2),
 	.create_mxac_size = sizeof(struct create_mxac_rsp),
 	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
 	.create_posix_size = sizeof(struct create_posix_rsp),
@@ -86,7 +86,7 @@ static struct smb_version_values smb302_server_values = {
 	.cap_large_files = SMB2_LARGE_FILES,
 	.create_lease_size = sizeof(struct create_lease_v2),
 	.create_durable_size = sizeof(struct create_durable_rsp),
-	.create_durable_v2_size = sizeof(struct create_durable_v2_rsp),
+	.create_durable_v2_size = sizeof(struct create_durable_rsp_v2),
 	.create_mxac_size = sizeof(struct create_mxac_rsp),
 	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
 	.create_posix_size = sizeof(struct create_posix_rsp),
@@ -113,7 +113,7 @@ static struct smb_version_values smb311_server_values = {
 	.cap_large_files = SMB2_LARGE_FILES,
 	.create_lease_size = sizeof(struct create_lease_v2),
 	.create_durable_size = sizeof(struct create_durable_rsp),
-	.create_durable_v2_size = sizeof(struct create_durable_v2_rsp),
+	.create_durable_v2_size = sizeof(struct create_durable_rsp_v2),
 	.create_mxac_size = sizeof(struct create_mxac_rsp),
 	.create_disk_id_size = sizeof(struct create_disk_id_rsp),
 	.create_posix_size = sizeof(struct create_posix_rsp),
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index 8ef681f7075ad..02fbae7531cfd 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -98,12 +98,6 @@ struct create_durable_rsp {
 /* See MS-SMB2 2.2.13.2.11 */
 /* Flags */
 #define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
-struct create_durable_v2_rsp {
-	struct create_context_hdr ccontext;
-	__u8   Name[8];
-	__le32 Timeout;
-	__le32 Flags;
-} __packed;
 
 /* equivalent of the contents of SMB3.1.1 POSIX open context response */
 struct create_posix_rsp {
-- 
2.53.0

