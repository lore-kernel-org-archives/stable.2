Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929CB4BFE6D
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790781240; cv=none; b=h4IFazBauQxNcp7ed6W4nNP/HTeUvOPb2PHEh+FDpkhHl9KVu7Qdq4L/lv3F5kUTKIdbQa74U0rGQnMggmwRVw7Kst/oSF/BfaZi4XnywrwSn/tlOs+ObQiRP5EIIdww1yvA74QlgjyYBtwSSvREE6NeXhHwDC71k7is4GQ5hhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790781240; c=relaxed/simple;
	bh=CMg0PiwAKl9BPA/Js9yzMhs0NzB+HuIyK5H05Ei3B3c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rsj8U0Xg4yfvuywIYmdFp0jgNutx9yeMBnQAkP2+s5UGu1J5HpVpz569w60O2NmMltmshkYg8lieXd6+hF6m+zRMPq3nBlyjfDxNHI8dmrilajTYV1j117IUX9VG8/sJOEMeyycNYkiI0+2yqZGzLdB+RBKmbsibXrSD6W5P7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xPAwW9hO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xPAwW9hO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7641D1F0089F;
	Wed, 30 Sep 2026 15:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790781228;
	bh=nAAkc2++rg6O32zIOXRDaEoHwkwM8jCAvEMdTSe1exU=;
	h=Subject:To:Cc:From:Date;
	b=xPAwW9hO43B3ReuppKk00+dfMfmVLl4UFz3M6LU8b0no5nTAySM9NFv4EHSOSEcO4
	 u+2kYioR6fe/JgY24KsEcpN/PhQgT1uBXZN3+/jN/sj97MwRTmqg5oXUGBO9W6g4V2
	 RtoNAMrDZuggbHmIWKPTaSg2t145eT7hn7+N64J8=
Subject: FAILED: patch "[PATCH] smb/server: fix posix state check for directory rename" failed to apply to 6.6-stable tree
To: chenxiaosong@kylinos.cn,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 30 Sep 2026 17:13:41 +0200
Message-ID: <2026093041-subprime-padded-e4c5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 2d99fbd7ad36ef288700f00102aaee11bcae04b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026093041-subprime-padded-e4c5@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2d99fbd7ad36ef288700f00102aaee11bcae04b4 Mon Sep 17 00:00:00 2001
From: ChenXiaoSong <chenxiaosong@kylinos.cn>
Date: Mon, 3 Aug 2026 17:21:17 +0900
Subject: [PATCH] smb/server: fix posix state check for directory rename

Pass the source ksmbd_file to the rename helpers and use the per-handle
POSIX create-context state when deciding whether open children block a
directory rename.

work->tcon->posix_extensions only records whether POSIX extensions were
negotiated on the connection.  It does not indicate that the handles were
opened with POSIX create contexts.

Reproducer:

  1. server: systemctl start ksmbd
  2. client: mount -t cifs //${server_ip}/export /mnt
     # without posix option
  3. client: mkdir /mnt/dir1/; touch /mnt/dir1/file
  4. client: tail -f /mnt/dir1/file # open file
  5. client: mv /mnt/dir1 /mnt/dir2

Without this fix, the rename can succeed when it should fail with
"Permission denied".

Fixes: c841bd3d8dec ("ksmbd: deny renaming directory with open children")
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index e214d27e4d37..80f5791c687b 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -7690,7 +7690,7 @@ static int smb2_rename(struct ksmbd_work *work,
 		goto out;
 
 	smb_break_all_levII_oplock_rename(work, fp);
-	rc = ksmbd_vfs_rename(work, &fp->filp->f_path, new_name, flags);
+	rc = ksmbd_vfs_rename(work, fp, new_name, flags);
 out:
 	kfree(new_name);
 	return rc;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index ff86e0e88177..0e7d66b0e899 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -678,9 +678,10 @@ int ksmbd_vfs_check_rename_share(struct ksmbd_work *work,
 	return err;
 }
 
-int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
+int ksmbd_vfs_rename(struct ksmbd_work *work, struct ksmbd_file *old_fp,
 			     char *newname, int flags)
 {
+	const struct path *old_path = &old_fp->filp->f_path;
 	struct dentry *old_child = old_path->dentry;
 	struct path new_path;
 	struct qstr new_last;
@@ -717,8 +718,7 @@ int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
 	if (err)
 		goto out_drop_write;
 
-	if (!work->tcon->posix_extensions && d_is_dir(old_child) &&
-	    ksmbd_has_open_files(old_child)) {
+	if (d_is_dir(old_child) && ksmbd_has_open_files(old_fp)) {
 		err = -EACCES;
 		goto out3;
 	}
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 1818b3f1971c..55d099de71f5 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -88,8 +88,8 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, const struct path *path);
 int ksmbd_vfs_link(struct ksmbd_work *work,
 		   const char *oldname, const char *newname);
 int ksmbd_vfs_getattr(const struct path *path, struct kstat *stat);
-int ksmbd_vfs_rename(struct ksmbd_work *work, const struct path *old_path,
-			     char *newname, int flags);
+int ksmbd_vfs_rename(struct ksmbd_work *work, struct ksmbd_file *old_fp,
+			 char *newname, int flags);
 int ksmbd_vfs_check_rename_share(struct ksmbd_work *work,
 				 const struct path *old_path);
 int ksmbd_vfs_truncate(struct ksmbd_work *work,
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index a35df2ab59c9..eac9886eb6e3 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -1137,8 +1137,9 @@ struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry)
 	return NULL;
 }
 
-bool ksmbd_has_open_files(struct dentry *dentry)
+bool ksmbd_has_open_files(struct ksmbd_file *old_fp)
 {
+	struct dentry *dentry = old_fp->filp->f_path.dentry;
 	struct ksmbd_file *fp;
 	unsigned int id;
 	bool ret = false;
@@ -1151,6 +1152,8 @@ bool ksmbd_has_open_files(struct dentry *dentry)
 			continue;
 		if (fp_dentry == dentry)
 			continue;
+		if (old_fp->is_posix_ctxt && fp->is_posix_ctxt)
+			continue;
 		if (is_subdir(fp_dentry, dentry)) {
 			ret = true;
 			break;
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index d80f379d4e12..127ea4987e3f 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -212,7 +212,7 @@ bool ksmbd_has_stream_without_delete_share(struct ksmbd_file *fp);
 int ksmbd_close_fd_app_instance_id(char *app_instance_id);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
 struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
-bool ksmbd_has_open_files(struct dentry *dentry);
+bool ksmbd_has_open_files(struct ksmbd_file *old_fp);
 unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp);
 void ksmbd_launch_ksmbd_durable_scavenger(void);

