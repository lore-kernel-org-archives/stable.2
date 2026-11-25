Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795637693;
	b=hf43ZggIUup9LHTe/ZvSSPooIfHW575COzj1Mvr+QmIqil6qzhHPhQ7ES2aU08YxUkJ5
	 pGfBak3YGaJGZJIEoi86EG+MqUG/h6MkyqXik018vAcW5inVRh3IWuIz2wC8jzOCNKU/7
	 paqyGJEr8+kkF65sIovxft1zHNEGShqWIy5kA2eji80lQMbI80WQJ1Mw+PZJtnxDS/Qlj
	 jBKiz26YPtSd96l7EFx3dqTfraP7aPKHeYEv00ItxqUgPDgvjkbzi2XSZWR869/bXNyjF
	 FAqKVgMKFpdkUPH3Dt9Yb2MFpNNcyoU4pEoVRcchWULz9b/ik6vtdh/kGyCWEhy8M4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795637693;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9hKjXpijeIjIV9X5s801DWxfKdNOYtGDnK7KX1EcI+4=;
	b=YicoNcr0o1jYs3avMxYRKkrHlJiw9Ge77uHH0Bl2kmATNfjx8RGqiYcSFcqK0ejcNMKT
	 FLuBzCmMYbOlOs0z0KDXyZki6566uobVugkQ7bgav8Ks5DiUFdUMeXBucVrmHaKihs6Jg
	 cVNrK+4VE91mw4f2LsRe2lA0bKJqMbXzZ/pzmGzwfqd0Xcjupu8YgFdz1PyPzIfcO23Fp
	 +77HROUPSnPKlcRoh6w+NQthjSqiFzRVy1YDtsAXJBj5+bpBGelO707unmsFPWhHIXflA
	 pW6JOVsN8e7KbarRJGuhqe+sKKRi8kEpcoYhxN3q9wHAwGKWzgNrPXdhfq5XVH4lc5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByX828PS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CE3606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 20:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByX828PS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BC91F000CA;
	Wed, 25 Nov 2026 20:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795637692;
	bh=9hKjXpijeIjIV9X5s801DWxfKdNOYtGDnK7KX1EcI+4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ByX828PShgfXJVoGqv7IkzBGx8VyyRvBGNGk/6ahbhWEs3p8aNb7aa6lArMx/GPsq
	 KLpgoGNxldIriVPPQT0XCQmfFNIpbSMjVlMKXp3B9tgjFvvY7TMbYByB7iMhVTJIgw
	 5FMvttPMPeIyU4YihFPMkPDGAhHVj5ViH3R4jFTmLRsfA8EWqutfLf2P1qadpXjFtg
	 CHfVE5ptfVe6x7Z37s/bvFIlekjZpR7w+z0zNHoFPml/BtfCCaunZ5Dg3GZR8i2aFv
	 6/wBw8L4JQ4FAilLrRHWXJPkLdIxCyo7tFyIbdG2JYaP7PKp12Hk95prfnMyrgH6WZ
	 DKOmNtTVaGW+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ksmbd: skip metadata-only opens in sharing checks
Date: Wed, 25 Nov 2026 15:14:50 -0500
Message-ID: <20261125201430.1399021-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112535-multitask-canon-efb2@gregkh>
References: <2026112535-multitask-canon-efb2@gregkh>
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
[ sashal: Adapted paths and APIs to the older tree (user_ns instead of idmap, older locking and path helpers) and adjusted hunk context for features that are absent there. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/smb2pdu.c    | 30 ++++++++++++++++++++++--------
 fs/ksmbd/smb_common.c | 34 +++++++++++++++++++++++++++++++++-
 fs/ksmbd/smb_common.h |  5 +++++
 fs/ksmbd/vfs_cache.h  |  2 ++
 4 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index bb4695b61ec39..cdc3d46f44f37 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2511,7 +2511,8 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 
 static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
-					       char *stream_name, int s_type)
+					       char *stream_name, int s_type,
+					       bool *created)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	size_t xattr_stream_size;
@@ -2549,6 +2550,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	rc = ksmbd_vfs_setxattr(user_ns, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
+	else
+		*created = true;
 	return 0;
 }
 
@@ -2784,6 +2787,7 @@ int smb2_open(struct ksmbd_work *work)
 	char *name = NULL;
 	char *stream_name = NULL;
 	bool file_present = false, created = false, already_permitted = false;
+	bool stream_created = false;
 	int share_ret, need_truncate = 0;
 	u64 time;
 	umode_t posix_mode = 0;
@@ -3305,7 +3309,8 @@ int smb2_open(struct ksmbd_work *work)
 		rc = smb2_set_stream_name_xattr(&path,
 						fp,
 						stream_name,
-						s_type);
+						s_type,
+						&stream_created);
 		if (rc)
 			goto err_out;
 		file_info = FILE_CREATED;
@@ -3313,10 +3318,22 @@ int smb2_open(struct ksmbd_work *work)
 
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
 	write_lock(&fp->f_ci->m_lock);
 	list_add(&fp->node, &fp->f_ci->m_fp_list);
@@ -3331,11 +3348,8 @@ int smb2_open(struct ksmbd_work *work)
 	if (file_present || created)
 		ksmbd_vfs_kern_path_unlock(&parent_path, &path);
 
-	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
-	    !fp->attrib_only && !stream_name) {
+	if (need_truncate)
 		smb_break_all_oplock(work, fp);
-		need_truncate = 1;
-	}
 
 	req_op_level = req->RequestedOplockLevel;
 	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index 8a2b4db4a5665..a99ac2d0b858f 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -657,10 +657,24 @@ static void smb_shared_mode_error(int error, struct ksmbd_file *prev_fp,
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
@@ -681,6 +695,24 @@ int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
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
@@ -707,7 +739,7 @@ int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
 		}
 
 		if (!(prev_fp->saccess & FILE_SHARE_WRITE_LE) &&
-		    curr_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE)) {
+		    access & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE)) {
 			smb_shared_mode_error(SHARE_WRITE_ERROR,
 					      prev_fp,
 					      curr_fp);
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index 62b6367dc2572..57829ac9033e9 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -204,6 +204,10 @@
 		FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES)
 
 #define SMB1_PROTO_NUMBER		cpu_to_le32(0x424d53ff)
+/* Rights that make an open take part in sharing checks */
+#define FILE_SHARE_CHECKED_ACCESS_LE	(FILE_EXECUTE_LE | FILE_READ_DATA_LE | \
+		FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE | FILE_DELETE_LE)
+
 #define SMB_COM_NEGOTIATE		0x72
 #define SMB1_CLIENT_GUID_SIZE		(16)
 
@@ -493,6 +497,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
 
 int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command);
 
+__le32 ksmbd_sharing_daccess(const struct ksmbd_file *fp);
 int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp);
 int ksmbd_override_fsids(struct ksmbd_work *work);
 void ksmbd_revert_fsids(struct ksmbd_work *work);
diff --git a/fs/ksmbd/vfs_cache.h b/fs/ksmbd/vfs_cache.h
index cd61c0b85e4d6..1ff052fe69002 100644
--- a/fs/ksmbd/vfs_cache.h
+++ b/fs/ksmbd/vfs_cache.h
@@ -90,6 +90,8 @@ struct ksmbd_file {
 
 	bool				is_nt_open;
 	bool				attrib_only;
+	/* writes data on open, see ksmbd_sharing_daccess() */
+	bool				implied_write;
 
 	char				client_guid[16];
 	char				create_guid[16];
-- 
2.53.0

