Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636974;
	b=Ackq8c7sw8ckEGsxafJz/jLgxGPIJTBunhzh1xSgameEvLvTkczd7S/R3hRZk6Wacslx
	 HZoNEZ0/J4EI+js2ToYtfoxYx8IGn8RCrN7guii57KiGt6YINk44JNqlBYBehIlaLLPDt
	 tAi+S5MqXjeAPLUpRvdkBn0wHEPdbnbuEm1YOAcg3Z9B8gxN1pCWE59Kl2GnlxtGHczec
	 T1FODFm5xeFhw0PmygmgbHLsvwlp1x11nBRcKkgxiARb8/RIHVtu8MKrkh7ecdOVUJlkt
	 tKyAFSMR8JBe2n6J284UB4rmM0C3tpYV0ILK1Jgc9lQ6cbcgqXU2STpu0cUZPLH9BSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636974;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nddjdLCP0YLzOYcBbWjfgiZItB/URDyG+AYXga+UDtM=;
	b=U+3c+Ud1WTFDAUhT0ANbzthwAX7gDuOcU8SpvNN3fzrIJ1/v7iKSCy6I9tGpBPUaRPVF
	 xUoC7EmSWiKJR0YfuNKNjpr0gQgYFNWXZsVQKf6bpeuQpo5HJf2GenpWeUn6mQLkFYQph
	 2dwVmJgmKo7uEXcu4wA93imOIWwG2NG+B01VqXaeDSAXQUeG0G5ZeiYZorNsGAa5vMKf1
	 8FjUp1uZMA5L5nSi0gYM98UYpRzACUlL1ALEyZskU6TKvPBDmjdRtf2GznLnW/mfSYfiu
	 ezTd857PW2W6sGCqslPeq75BAVGpHxMP17gdyjcaSJpE4vdk1C24PtvXC5ab1rynGmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h76d82MJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A0B606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h76d82MJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831871F000C4;
	Wed, 25 Nov 2026 20:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636974;
	bh=nddjdLCP0YLzOYcBbWjfgiZItB/URDyG+AYXga+UDtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h76d82MJo+Gk9lv6ODmqgO5cYMkBGcx1w6dSGJcOtavrGreAlB68t962j3WOaTHoF
	 KQ0c289a/PCGE6rRsmx4s52IEbQXOLgSl1TnQ/ozo1l+n/8IBh31p4zKPjGxerzaLe
	 RyrU25gkxhY0ilm2GkEi6qjIkbanJC9zAUOaPmTqeXob3fNPWx5Qoqsh9teGjq/l2B
	 wk7MfQ6l3DUTChKiKMuqqUdFKHelGYv/6F32BCfh4qqeC+LtE++0yeRJuTzSvu60VJ
	 uW9aE39GXHSwYKoKemFeaS9mtqPcOAZs136k+2xdEGVHN2mc4gGWEnAMYlfJLSRFwA
	 SuI1hO0IHTxUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] ksmbd: skip metadata-only opens in sharing checks
Date: Wed, 25 Nov 2026 15:02:52 -0500
Message-ID: <20261125200234.1346061-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112534-ecosystem-blanching-c903@gregkh>
References: <2026112534-ecosystem-blanching-c903@gregkh>
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

From: Ian Bridges <icb@fastmail.org>

[ Upstream commit 81fefb6c635489e71e286d1465b6dd1d0a27ceec ]

A READ_CONTROL open without sharing can block later reads, writes and
deletes even though it holds no data, execute or delete access.

Keep the existing attribute-only exception. For other pairs, require
both effective access masks to hold one of those rights. MS-FSA
2.1.5.1.2 grants FILE_WRITE_DATA when an open overwrites a file or
stream, or creates a named stream on an existing file. Use that granted
access for sharing checks while keeping the requested access on the
returned handle.

The Time Machine AFP_AfpInfo synthesis keeps its requested access.
ksmbd implements FILE_SUPERSEDE by truncating the file, so count it as
a write.

This also prevents an overwrite from truncating a file while another
open that holds data, execute or delete access does not share writing.

Fixes: e2f34481b24d ("cifsd: add server-side procedures for SMB3")
Cc: stable@vger.kernel.org
Signed-off-by: Ian Bridges <icb@fastmail.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
[ sashal: Added the stream_created and implied_write handling to the 6.12 code, with adjusted context for missing later features, a non-const idmap pointer, and the existing unlock helper. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c    | 30 ++++++++++++++++++++++--------
 fs/smb/server/smb_common.c | 34 +++++++++++++++++++++++++++++++++-
 fs/smb/server/smb_common.h |  5 +++++
 fs/smb/server/vfs_cache.h  |  2 ++
 4 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 115960cc93994..20ef4478a14ea 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2548,7 +2548,8 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 
 static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
-					       char *stream_name, int s_type)
+					       char *stream_name, int s_type,
+					       bool *created)
 {
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	size_t xattr_stream_size;
@@ -2586,6 +2587,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
+	else
+		*created = true;
 	return 0;
 }
 
@@ -3011,6 +3014,7 @@ int smb2_open(struct ksmbd_work *work)
 	char *name = NULL;
 	char *stream_name = NULL;
 	bool file_present = false, created = false, already_permitted = false;
+	bool stream_created = false;
 	int share_ret, need_truncate = 0;
 	u64 time;
 	umode_t posix_mode = 0;
@@ -3590,7 +3594,8 @@ int smb2_open(struct ksmbd_work *work)
 		rc = smb2_set_stream_name_xattr(&path,
 						fp,
 						stream_name,
-						s_type);
+						s_type,
+						&stream_created);
 		if (rc)
 			goto err_out;
 		file_info = FILE_CREATED;
@@ -3598,10 +3603,22 @@ int smb2_open(struct ksmbd_work *work)
 
 	fp->attrib_only = !(req->DesiredAccess & ~(FILE_READ_ATTRIBUTES_LE |
 			FILE_WRITE_ATTRIBUTES_LE | FILE_SYNCHRONIZE_LE));
+	need_truncate = !S_ISDIR(file_inode(filp)->i_mode) &&
+			open_flags & O_TRUNC && !fp->attrib_only && !stream_name;
+	/*
+	 * Count the FILE_WRITE_DATA that MS-FSA 2.1.5.1.2 grants an overwrite,
+	 * supersede included, or a new named stream on an existing file.
+	 * An attribute-only open of the file is not truncated, and the
+	 * synthesized AFP_AfpInfo stream is not created by the client.
+	 */
+	fp->implied_write = need_truncate ||
+			    (stream_name &&
+			     (open_flags & O_TRUNC ||
+			      (file_present && stream_created)));
 
 	/* fp should be searchable through ksmbd_inode.m_fp_list
-	 * after daccess, saccess, attrib_only, and stream are
-	 * initialized.
+	 * after daccess, saccess, attrib_only, implied_write, and
+	 * stream are initialized.
 	 */
 	down_write(&fp->f_ci->m_lock);
 	list_add(&fp->node, &fp->f_ci->m_fp_list);
@@ -3616,11 +3633,8 @@ int smb2_open(struct ksmbd_work *work)
 	if (file_present || created)
 		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 
-	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
-	    !fp->attrib_only && !stream_name) {
+	if (need_truncate)
 		smb_break_all_oplock(work, fp);
-		need_truncate = 1;
-	}
 
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index a836b117f756f..870e4367da18f 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -664,10 +664,24 @@ static void smb_shared_mode_error(int error, struct ksmbd_file *prev_fp,
 		    prev_fp->saccess, curr_fp->daccess);
 }
 
+/*
+ * Sharing checks use fp->daccess plus the FILE_WRITE_DATA that MS-FSA
+ * grants an open that overwrites data or creates a named stream.
+ * fp->daccess keeps the open's own access.
+ */
+__le32 ksmbd_sharing_daccess(const struct ksmbd_file *fp)
+{
+	if (fp->implied_write)
+		return fp->daccess | FILE_WRITE_DATA_LE;
+	return fp->daccess;
+}
+
 int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
 {
 	int rc = 0;
 	struct ksmbd_file *prev_fp;
+	__le32 curr_access = ksmbd_sharing_daccess(curr_fp);
+	__le32 access;
 
 	/*
 	 * Lookup fp in master fp list, and check desired access and
@@ -688,6 +702,24 @@ int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
 		if (prev_fp->attrib_only != curr_fp->attrib_only)
 			continue;
 
+		/*
+		 * MS-FSA checks sharing per stream, so a named stream open's
+		 * implied write is not a write against the primary stream.
+		 * It still decides whether the pair is checked.
+		 */
+		access = curr_access;
+		if (ksmbd_stream_fd(curr_fp) && !ksmbd_stream_fd(prev_fp))
+			access = curr_fp->daccess;
+
+		/*
+		 * Two opens conflict only if both hold a right in
+		 * FILE_SHARE_CHECKED_ACCESS_LE (MS-FSA 2.1.5.1.2.1 and
+		 * 2.1.5.1.2.2)
+		 */
+		if (!(ksmbd_sharing_daccess(prev_fp) & FILE_SHARE_CHECKED_ACCESS_LE) ||
+		    !(curr_access & FILE_SHARE_CHECKED_ACCESS_LE))
+			continue;
+
 		if (!(prev_fp->saccess & FILE_SHARE_DELETE_LE) &&
 		    curr_fp->daccess & FILE_DELETE_LE) {
 			smb_shared_mode_error(SHARE_DELETE_ERROR,
@@ -714,7 +746,7 @@ int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
 		}
 
 		if (!(prev_fp->saccess & FILE_SHARE_WRITE_LE) &&
-		    curr_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE)) {
+		    access & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE)) {
 			smb_shared_mode_error(SHARE_WRITE_ERROR,
 					      prev_fp,
 					      curr_fp);
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 421e187982084..c958a3c37385c 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -110,6 +110,10 @@
 #define SMB_COM_NEGOTIATE		0x72
 #define SMB1_CLIENT_GUID_SIZE		(16)
 
+/* Rights that make an open take part in sharing checks */
+#define FILE_SHARE_CHECKED_ACCESS_LE	(FILE_EXECUTE_LE | FILE_READ_DATA_LE | \
+		FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE | FILE_DELETE_LE)
+
 #define SMBFLG_RESPONSE 0x80	/* this PDU is a response from server */
 
 #define SMBFLG2_IS_LONG_NAME	cpu_to_le16(0x40)
@@ -337,6 +341,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
 
 int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command);
 
+__le32 ksmbd_sharing_daccess(const struct ksmbd_file *fp);
 int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp);
 int __ksmbd_override_fsids(struct ksmbd_work *work,
 			   struct ksmbd_share_config *share);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index c8f457bb41b34..060b758008ceb 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -104,6 +104,8 @@ struct ksmbd_file {
 
 	bool				is_nt_open;
 	bool				attrib_only;
+	/* writes data on open, see ksmbd_sharing_daccess() */
+	bool				implied_write;
 
 	char				client_guid[16];
 	char				create_guid[16];
-- 
2.53.0

