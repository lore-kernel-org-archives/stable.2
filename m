Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636603;
	b=jEEtLfy0uHFaaHawxUnDPmBlIRbisFVI2SuNcjJToP7+4CF9SH1bxYK0hcy2X45pZC6W
	 /QLtwn8sy95sOqG04uk7vc2hRGs39oJIKKLO3DK2l6EkvuIf9BkSYz5epMtgI9L7QCH4q
	 zqSLKqq+mbJ/HzRp2w+OYJMmsHBgC8Ert+Q9TsN4Nj4eV+KMp6EgWjZMOY/YgYqJjvQP7
	 S1NO8ti9Uq0znQyt8eLHpJQTDBf61qr9xvj235cfJlIwg3Tki3MTQiPSU+QIBifQn2yTf
	 HgHmOOrYW7CDN75SWjuxMQGaJCO9Tv8BZbd8pXLzJqz/bGHBbmkYWPPCLOwhx81OA/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636603;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+hsTYTcw8zShLauy/z3TY0wEa51svopo57NTGf1l4FM=;
	b=uS0JEcPm2UAj3ZmdUwf48W0A+toWVaxJZd6Tp0g7Heqtn+J66Y0C4P3QhLIIFP7YmLUy
	 x6Phl8XvPH3LIJaz+HB+PXOFEhWnc4D8OfwgH3E9cDo9F+h2Hgh32T+lwYLKzlU1ESNc5
	 aqQpzWFUVzUUNB9MHlHbuRU3MHXqQ+wbUmUJy+TVSfJFmfVoOdS5PsvqZE3Mv6vJpXT3i
	 SpX+emRMFG4rrLSbC3XjFC3X9bH1xqCtGaaz4P4oT66pIPq4YM67mStNfEJzYRkodmou3
	 bNuXak0m7C3klH1/hBQa+Arms+1DTcdp/xEUa6BaVkZL/qOb3ZSSJ3FU/8j0u8oaTzQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHtMdzK7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B83606A338
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gHtMdzK7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A8491F000D0;
	Wed, 25 Nov 2026 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636602;
	bh=+hsTYTcw8zShLauy/z3TY0wEa51svopo57NTGf1l4FM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gHtMdzK7v4Sy83YentuHYRXfTHICqS0TrDURCuHQ/m9g/WBC0EDFOEz80riVcakdz
	 C/EmfiojeSWCYzZhfcmKKdhCt8mbTDf2in+Xoy/rgbKOttz0mncJ907U7LTotZ36es
	 hVOvpnq1AweGxfwMkx0N8aMGh4gJNB1BJRbxFi61NkCCV2sVtlKlubpZMFrP9p2ogi
	 HZLb4YZq4egdQhBJpM72jr91kdFyjHeZSJkojaljBYRPoxtHtTN1x7c+AG6IISHqpE
	 vHownS0GdIigqPV+aoMX90RdDXFre2Bw1+vWr28xaIePlB5MoU1heXXnBmHkYZBbcB
	 oZG7eOblgOUrw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] ksmbd: skip metadata-only opens in sharing checks
Date: Wed, 25 Nov 2026 14:56:41 -0500
Message-ID: <20261125195621.1308808-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112533-hate-urethane-a546@gregkh>
References: <2026112533-hate-urethane-a546@gregkh>
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
[ sashal: Context-only adjustments: dropped const on idmap and omitted the app_instance_* and posix_append lines, which this tree lacks. The new stream_created declaration and defines were placed beside the nearest existing lines. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c    | 30 ++++++++++++++++++++++--------
 fs/smb/server/smb_common.c | 34 +++++++++++++++++++++++++++++++++-
 fs/smb/server/smb_common.h |  5 +++++
 fs/smb/server/vfs_cache.h  |  2 ++
 4 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index aae6e9adf2e84..9cc354039e4cc 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2541,7 +2541,8 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 
 static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
-					       char *stream_name, int s_type)
+					       char *stream_name, int s_type,
+					       bool *created)
 {
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	size_t xattr_stream_size;
@@ -2579,6 +2580,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
+	else
+		*created = true;
 	return 0;
 }
 
@@ -3004,6 +3007,7 @@ int smb2_open(struct ksmbd_work *work)
 	char *name = NULL;
 	char *stream_name = NULL;
 	bool file_present = false, created = false, already_permitted = false;
+	bool stream_created = false;
 	int share_ret, need_truncate = 0;
 	u64 time, alloc_size = 0;
 	umode_t posix_mode = 0;
@@ -3586,7 +3590,8 @@ int smb2_open(struct ksmbd_work *work)
 		rc = smb2_set_stream_name_xattr(&path,
 						fp,
 						stream_name,
-						s_type);
+						s_type,
+						&stream_created);
 		if (rc)
 			goto err_out;
 		file_info = FILE_CREATED;
@@ -3594,12 +3599,24 @@ int smb2_open(struct ksmbd_work *work)
 
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
 
 	fp->is_posix_ctxt = posix_ctxt;
 
 	/* fp should be searchable through ksmbd_inode.m_fp_list
-	 * after daccess, saccess, attrib_only, and stream are
-	 * initialized.
+	 * after daccess, saccess, attrib_only, implied_write, and
+	 * stream are initialized.
 	 */
 	down_write(&fp->f_ci->m_lock);
 	list_add(&fp->node, &fp->f_ci->m_fp_list);
@@ -3614,11 +3631,8 @@ int smb2_open(struct ksmbd_work *work)
 	if (file_present || created)
 		path_put(&path);
 
-	if (!S_ISDIR(file_inode(filp)->i_mode) && open_flags & O_TRUNC &&
-	    !fp->attrib_only && !stream_name) {
+	if (need_truncate)
 		smb_break_all_oplock(work, fp);
-		need_truncate = 1;
-	}
 
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index 3a4b7b380a6bc..7ff75a069cd59 100644
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
index d6f72195482f9..912f1bb70b181 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -82,6 +82,10 @@
 		FILE_EXECUTE | FILE_DELETE_CHILD | \
 		FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES)
 
+/* Rights that make an open take part in sharing checks */
+#define FILE_SHARE_CHECKED_ACCESS_LE	(FILE_EXECUTE_LE | FILE_READ_DATA_LE | \
+		FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE | FILE_DELETE_LE)
+
 #define SMB1_PROTO_NUMBER		cpu_to_le32(0x424d53ff)
 #define SMB_COM_NEGOTIATE		0x72
 #define SMB1_CLIENT_GUID_SIZE		(16)
@@ -221,6 +225,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
 
 int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command);
 
+__le32 ksmbd_sharing_daccess(const struct ksmbd_file *fp);
 int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp);
 int __ksmbd_override_fsids(struct ksmbd_work *work,
 			   struct ksmbd_share_config *share);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 03494f2627cd6..c39deb10d2166 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -107,6 +107,8 @@ struct ksmbd_file {
 
 	bool				is_nt_open;
 	bool				attrib_only;
+	/* writes data on open, see ksmbd_sharing_daccess() */
+	bool				implied_write;
 	bool				allocation_size_set;
 
 	char				client_guid[16];
-- 
2.53.0

