Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795603149;
	b=toEunzLzYaACgT/jTl3sd46uNOkP6vNNdIBDYsJ8scmIwSjyhXK5v1nhg7b2G9ZrqmSr
	 w3yu5XfdzLEXvZ0Qa89bRnUTGOdmoDnvkz3e+IKP+5idgE1qd/IbACV56xT7NvCXNqm84
	 LRDc31xhMD+MO7U368Olr7zu40tCQvcrwIY+YVmz0xWef9dzjEqNg4AsUfM+v9Mt8lQyB
	 lMgJHySJsrs8QyZV75uSfzNAX5R/R4PojrqFVHeVBr4rE+PDvmymPJvrIxUMHKcgE6a45
	 DLCj7f9IoxeqTDpfaxe91igeolV9C8hWH2CgZAJI+4bJkOFPTLn+Q1QdTaiWYtZFD7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795603149;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=07lj8MIelbR0SG7svAmI1+0KWEv/v1ssCtgT5YMgLf4=;
	b=zYhRYwBEAKIoxAQ8zJC+dloe75UQj915jy08GJI32WWhgd+t9kyc62PoZps559wC21jq
	 B/Osw0diqke8xJ4TyrfM4aUYR17lFThJRpjmX0JY2pcgBLbmCIxjdUM98OY1sYghmkbt/
	 MjMUw/oM3TCURvYjBQZ6V3xyXh4/a/LM7m2aTyJ8p5gWvYMl6V/VhpbwtJoosoZt6+XzS
	 EA0qR9rNbCUNAvDgZSfQ9iYmQqW6HB0vJXd156R3LcF2vQkea3prQSfKbrTIqeuC059JY
	 Rvj/TjWTu+mFkwG70NQegyDKRmpHyf6CeC9ZsOifriGyLLMu7e9jB2nTKNvHjQCYh7g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BR+hi3ai;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFAF606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 10:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=BR+hi3ai
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3FF1F000C0;
	Wed, 25 Nov 2026 10:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795603148;
	bh=07lj8MIelbR0SG7svAmI1+0KWEv/v1ssCtgT5YMgLf4=;
	h=Subject:To:Cc:From:Date;
	b=BR+hi3aikmUMnSmAxMpU1GjWALjeWNeZmmTb9Whk3xMWe+QmAwjFYWksI5elMM4M6
	 UPNIxlNXPMAdz2FB8P25zjElAHCfIOPKrWk2owG27iVVt1rFU/N0pLWheH/WpW035y
	 I4qyc5DBOR16Wq6HR5++uuq/bnzBC5Hc7k/8w+2s=
Subject: FAILED: patch "[PATCH] ksmbd: skip metadata-only opens in sharing checks" failed to apply to 6.1-stable tree
To: icb@fastmail.org,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 11:26:35 +0100
Message-ID: <2026112535-quickness-ethanol-2d2b@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 81fefb6c635489e71e286d1465b6dd1d0a27ceec
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112535-quickness-ethanol-2d2b@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 81fefb6c635489e71e286d1465b6dd1d0a27ceec Mon Sep 17 00:00:00 2001
From: Ian Bridges <icb@fastmail.org>
Date: Thu, 5 Nov 2026 21:53:44 -0600
Subject: [PATCH] ksmbd: skip metadata-only opens in sharing checks

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

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index b084cca8813c..5bbc33d5a3a8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -3541,7 +3541,8 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 
 static noinline int smb2_set_stream_name_xattr(const struct path *path,
 					       struct ksmbd_file *fp,
-					       char *stream_name, int s_type)
+					       char *stream_name, int s_type,
+					       bool *created)
 {
 	const struct mnt_idmap *idmap = mnt_idmap(path->mnt);
 	size_t xattr_stream_size;
@@ -3605,6 +3606,8 @@ static noinline int smb2_set_stream_name_xattr(const struct path *path,
 	rc = ksmbd_vfs_setxattr(idmap, path, xattr_stream_name, NULL, 0, 0, false);
 	if (rc < 0)
 		pr_err("Failed to store XATTR stream name :%d\n", rc);
+	else
+		*created = true;
 	return 0;
 }
 
@@ -4394,6 +4397,7 @@ int smb2_open(struct ksmbd_work *work)
 	char *stream_name = NULL;
 	bool file_present = false, created = false, already_permitted = false;
 	bool app_instance_id_checked = false, app_instance_closed;
+	bool stream_created = false;
 	int share_ret, need_truncate = 0;
 	u64 time, alloc_size = 0;
 	umode_t posix_mode = 0;
@@ -5138,7 +5142,8 @@ int smb2_open(struct ksmbd_work *work)
 		rc = smb2_set_stream_name_xattr(&path,
 						fp,
 						stream_name,
-						s_type);
+						s_type,
+						&stream_created);
 		if (rc)
 			goto err_out;
 		file_info = FILE_CREATED;
@@ -5146,13 +5151,25 @@ int smb2_open(struct ksmbd_work *work)
 
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
 	fp->posix_append = posix_ctxt && !!(open_flags & O_APPEND);
 
 	/* fp should be searchable through ksmbd_inode.m_fp_list
-	 * after daccess, saccess, attrib_only, and stream are
-	 * initialized.
+	 * after daccess, saccess, attrib_only, implied_write, and
+	 * stream are initialized.
 	 */
 	down_write(&fp->f_ci->m_lock);
 	list_add(&fp->node, &fp->f_ci->m_fp_list);
@@ -5173,11 +5190,8 @@ int smb2_open(struct ksmbd_work *work)
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
index f9fb3741ada3..e7a987af64ba 100644
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
index a9cc09e31721..d3d19f1a23ea 100644
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
@@ -284,6 +288,7 @@ int ksmbd_extract_shortname(struct ksmbd_conn *conn,
 
 int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command);
 
+__le32 ksmbd_sharing_daccess(const struct ksmbd_file *fp);
 int ksmbd_smb_check_shared_mode(struct file *filp, struct ksmbd_file *curr_fp);
 int __ksmbd_override_fsids(struct ksmbd_work *work,
 			   struct ksmbd_share_config *share);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index a0239ec178d8..57c81287efe6 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -131,6 +131,8 @@ struct ksmbd_file {
 
 	bool				is_nt_open;
 	bool				attrib_only;
+	/* writes data on open, see ksmbd_sharing_daccess() */
+	bool				implied_write;
 	bool				allocation_size_set;
 
 	char				client_guid[16];

