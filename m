Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6961DF736
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580481; cv=none; b=nTLUPFvprsKtsWBVwLqa6t6zoXXatZoQ5tX5YLG3bwTGQsxTk9lnI25H2EwOCa36tlfTvlxZXquX6KZ6wEV0SWQZAOSvw1+WNQaEwkWCBhKV7RJhYSQ69c4Y5xdbSNrYaCUGo309cEzcujIlyArHaFdk+YOkW+nx2eT3h34bS58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580481; c=relaxed/simple;
	bh=n42qKgEbERyMPDNKiIrNA6S4d+4sEJTG4CFiIlbIaAQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TV2+1q/HLXdheRst/IqYk/VyfWpkWyTI/X4DC4ggzJwHIlepfiiTKn0EUIYaN3tyBpWJKiPjOTsVvoKlFu52jccU2I6nfE9mUi5f/JvCEazR32CzLryEUPMCkQLDL+SI4HLBzIQ8TX7JoDWVD2F9SiN0OJu7FPf1o0IJNy1RODk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qvnmENp7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qvnmENp7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8BCC1F000FF;
	Wed, 16 Sep 2026 17:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789580459;
	bh=Z0FQ3yH12QqciT1VWWtNGVrf0B6cubJishO+v8RDv3k=;
	h=Subject:To:Cc:From:Date;
	b=qvnmENp7VUbzif/tUUN9f4/lcuBCQppyhh4YG5kUNRRKy57H31bH56TVJsfPvD08F
	 3H9XdgPemvqt78CuN4g9Zn4NXSTtoMhs1EqqTjlT7AWpyFLeH0zVZablxwIE8brD8k
	 2XACrl1iVx4qAxZJXqCj/OIdAwCeW5Yt6BvUvjC0=
Subject: FAILED: patch "[PATCH] smb/server: fix posix state check for directory rename" failed to apply to 6.12-stable tree
To: chenxiaosong@kylinos.cn,linkinjeon@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 18:35:37 +0100
Message-ID: <2026091637-envoy-playmaker-ba87@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 2d99fbd7ad36ef288700f00102aaee11bcae04b4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091637-envoy-playmaker-ba87@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

