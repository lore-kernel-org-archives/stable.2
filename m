Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795636223;
	b=Nxy3YCyxiRhAi7nDQBJVIOeaNSpOePM8/kgCt3fgns3/Rbz33yULqTSu6WthYSwpuA0Q
	 9gVRHn0Zo9hJ3dXGDpUzx3m8jpUMjz8350VDnimIBelYd+FvrHRBP1xrv5cIEm7it1iCr
	 f3pZZ0uSs6pVPSYE7AKYXdtfRVhxlD5bRC0nZKyhrCL7k0zXMnVdMaEc1uc2ivzxwcqf9
	 5II0kgwFAtb5sWbX48zTnJbl7HtrMNFiQuYiAUA4oXxEUJuQM6quxhJk/nv2KXyIze2KJ
	 jqoVLOb2IEyV7jkbIiSg6S6dzgpKWKT3ymxGc0+6RqCjwwR6CegoQMSDXfz4ntysfJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795636223;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CHPphcOBT1HbPAnwwi85joy3gLNDA7QhbWaoGa3Y5pQ=;
	b=lrz6U5vbQ/BDFwy90uF2OFMG+6KcMgejhVQPPRRFGdiVJZU3SOYTTqeHsNtGRjvFbBl3
	 f7HElPznd6EPA2HOcnDXp9xOqkVAw6l8fUfOdWPo+F14kvdxSMFpv2aPTMuElLT/qHOpE
	 sJboJi58siAKQN2WjsgA+mMGROSiuhSHR/Q0FowyEOO01MLYzi2rjahoVN39NeM7e9XV9
	 FIVdvj+oQl8bSjtg/EbImWTvtVN0Oq3lvhVLnEmw55UrvCupozVABn3Jwu8TlDMGM0J10
	 gVwLlvvz1Qm3ycVOqjjzqgTbdMA2NLsgBzJeU5rOmx++b7jn58phsuwfyLBQC1dOQZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NI2ysyXE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54835606A337
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NI2ysyXE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47F4C1F000C4;
	Wed, 25 Nov 2026 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795636222;
	bh=CHPphcOBT1HbPAnwwi85joy3gLNDA7QhbWaoGa3Y5pQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NI2ysyXEEbJjDPozMKSdrdIwtQlnkJbuKJcnghvRjUo60U2bDkK3SMnT8rcB+3Wd+
	 EV0RWL85P8Gl4xVYpcEqVlqiQtbE/xhNV/d0eMgu9Bpx/LPSH3tFwVnu86lWWEPeqa
	 Z6pjTLtT3zbzGMCE9FPKvFfqWJV6KDwfUexsW384KqRzVQuEPdyKWyH0NX8wUSZdcn
	 hoy82Nyk7C2lEs/cqJFP8tIj0yXfLDQqeT91Vd51tp7ERQlmR/6h0mlGsxBvKEydcr
	 mawt0PGgpkmUeNTNIqjfA3e91GzzUeI4X+pJ0t9grrNdg5EcNm4qZnDyPg3lF76Jfw
	 vAfGs9wMnGGDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ian Bridges <icb@fastmail.org>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y] ksmbd: skip metadata-only opens in sharing checks
Date: Wed, 25 Nov 2026 14:50:20 -0500
Message-ID: <20261125195014.1296732-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112530-spoof-absentee-8dbc@gregkh>
References: <2026112530-spoof-absentee-8dbc@gregkh>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c    | 30 ++++++++++++++++++++++--------
 fs/smb/server/smb_common.c | 34 +++++++++++++++++++++++++++++++++-
 fs/smb/server/smb_common.h |  5 +++++
 fs/smb/server/vfs_cache.h  |  2 ++
 4 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 8f9773e0cf016..97c3f07244c54 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3537,7 +3537,8 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 
 static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
-					       char *stream_name, int s_type)
+					       char *stream_name, int s_type,
+					       bool *created)
 {
 	struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	size_t xattr_stream_size;
@@ -3601,6 +3602,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
+	else
+		*created = true;
 	return 0;
 }
 
@@ -4419,6 +4422,7 @@ int smb2_open(struct ksmbd_work *work)
 	char *stream_name = NULL;
 	bool file_present = false, created = false, already_permitted = false;
 	bool app_instance_id_checked = false, app_instance_closed;
+	bool stream_created = false;
 	int share_ret, need_truncate = 0;
 	u64 time, alloc_size = 0;
 	umode_t posix_mode = 0;
@@ -5151,7 +5155,8 @@ int smb2_open(struct ksmbd_work *work)
 		rc = smb2_set_stream_name_xattr(&path,
 						fp,
 						stream_name,
-						s_type);
+						s_type,
+						&stream_created);
 		if (rc)
 			goto err_out;
 		file_info = FILE_CREATED;
@@ -5159,12 +5164,24 @@ int smb2_open(struct ksmbd_work *work)
 
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
@@ -5185,11 +5202,8 @@ int smb2_open(struct ksmbd_work *work)
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
index 5ddefb5a7078c..9c962952082fb 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -695,10 +695,24 @@ static void smb_shared_mode_error(int error, struct ksmbd_file *prev_fp,
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
@@ -719,6 +733,24 @@ int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
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
@@ -745,7 +777,7 @@ int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp)
 		}
 
 		if (!(prev_fp->saccess & FILE_SHARE_WRITE_LE) &&
-		    curr_fp->daccess & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE)) {
+		    access & (FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE)) {
 			smb_shared_mode_error(SHARE_WRITE_ERROR,
 					      prev_fp,
 					      curr_fp);
diff --git a/fs/smb/server/smb_common.h b/fs/smb/server/smb_common.h
index 7b9c5cfcb63b0..d481f02b365e8 100644
--- a/fs/smb/server/smb_common.h
+++ b/fs/smb/server/smb_common.h
@@ -69,6 +69,10 @@
 		FILE_EXECUTE | FILE_DELETE_CHILD | \
 		FILE_READ_ATTRIBUTES | FILE_WRITE_ATTRIBUTES)
 
+/* Rights that make an open take part in sharing checks */
+#define FILE_SHARE_CHECKED_ACCESS_LE	(FILE_EXECUTE_LE | FILE_READ_DATA_LE | \
+		FILE_WRITE_DATA_LE | FILE_APPEND_DATA_LE | FILE_DELETE_LE)
+
 #define SMB_COM_NEGOTIATE		0x72 /* See MS-CIFS 2.2.2.1 */
 
 /* See MS-CIFS 2.2.3.1 */
@@ -186,6 +190,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
 
 int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command);
 
+__le32 ksmbd_sharing_daccess(const struct ksmbd_file *fp);
 int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp);
 int __ksmbd_override_fsids(struct ksmbd_work *work,
 			   struct ksmbd_share_config *share);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index 84ca73f483143..c35e4ba8432c0 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -119,6 +119,8 @@ struct ksmbd_file {
 
 	bool				is_nt_open;
 	bool				attrib_only;
+	/* writes data on open, see ksmbd_sharing_daccess() */
+	bool				implied_write;
 	bool				allocation_size_set;
 
 	char				client_guid[16];
-- 
2.53.0

