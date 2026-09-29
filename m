Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE48252BE3E
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688690; cv=none; b=Qtp7plMBZM86jHTDCSD2arwSkQwHl4ebGHyaejHBInOf7CbW7mstbLEGvxdzN10/RwXXa+fAO0PJAAHe4PoIUyGDX0H8uDjApvxtQ7Y2VQ+NGTQxyTNQJONgGNenDNJPzHrplXGuQ5mqQgVl41kL9R9Q/ABCfhWAIsGYAdYo3zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688690; c=relaxed/simple;
	bh=bpHmE2raesb9QSaMSNRytuspRZ2YDnv3EwiQfKcpopI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ux5ydpOHjNDB8vCX1R5Ua1reEOBClVKL+Z1WVQUpD1LhWaxbzzMyciOcd95nRhQbxA0RPunbHbFFm8xxVKYwtz8nu3bRG/fKmRyZthvhtp/0A9nQxUsxnyIlDRsCt3i5taeMrdwf3WPmmjI+szKFsrKg9fMXWS5OI9HkxVoVfCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HigyNv62; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HigyNv62"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6704D1F000FF;
	Tue, 29 Sep 2026 13:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688685;
	bh=Np4QC2pXf0NpVyWSVAEjQTw3WJVMupMk91qgyI2zlY4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HigyNv62JWf+cD6pfQnyyQosIOaXZuwZAdhz9o8cLAw2fRPlwYSg0NSUzv6UMPIpu
	 Qp1f1h5ZE1su4Ua1nd0mNrXZ64Sliv5BxtcK0CA5I9mP251FahaMqAL+SutXDR/naY
	 1ZAXAiQmqb3dWyP9t6Bc52KPfa4SDOKbrIOtLC0HhwMF2Ow+QG6v5NeFGp8n6Mlb16
	 6H13fcc5LH4MdWLNcz2mdbWv4v4d6zQv4Q2qKapLxlsMuzIXVkQysssCGMvF7ZryGX
	 gE+7ZtTalMmJS7X1dhRLlkTHzcvlSXpH0p5Wtwg3ERr5znu74YCQ6SdE4Lv20aPQJT
	 UCLWVljkkLaYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] fs/ntfs3: remove atomic_open
Date: Tue, 29 Sep 2026 09:31:22 -0400
Message-ID: <20260929133124.3504204-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092904-porthole-attire-bdfd@gregkh>
References: <2026092904-porthole-attire-bdfd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 93b4d70f6a4129fcfad18deae248bf89c129d1b5 ]

atomic_open is an optional VFS operation, and is primarily for network
filesystems. NFS (for instance) can just send an open call for the last
path component rather than doing a lookup and then having to follow that
up with an open when it doesn't have a dentry in cache.

ntfs3 is a local filesystem however, and its atomic_open just does a
typical lookup + open, but in a convoluted way. atomic_open will also
make directory leases more difficult to implement on the filesystem.

Remove ntfs_atomic_open.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

Backport preparation for 1abd643f3783ea8f8e273c18697ff0413aa92dc7:

Remove the stable version of ntfs_atomic_open(), which still uses
mnt_idmap(file->f_path.mnt), while retaining the surrounding stable fixes.

Fold in the error-return conversion from c935c66878867 for
ntfs_create_inode(), its declaration, and its four remaining callers.
Keep the existing file allocation behavior; the unrelated resident-file
creation change from that commit is not needed here.

Use the existing inode timestamp setters when restoring creation times.
These equivalent assignments and the error-return cleanup provide the
context needed for the target to apply unchanged. Keep d_instantiate()
and the successful unlock_new_inode() here for the target to replace.

Stable-dep-of: 1abd643f3783 ("fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c   |  28 +++++------
 fs/ntfs3/namei.c   | 121 +++------------------------------------------
 fs/ntfs3/ntfs_fs.h |   9 ++--
 3 files changed, 25 insertions(+), 133 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index fff604cd95279..ce08d44d0d250 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1230,15 +1230,13 @@ ntfs_create_reparse_buffer(struct ntfs_sb_info *sbi, const char *symname,
  * - ntfs_mknod
  * - ntfs_symlink
  * - ntfs_mkdir
- * - ntfs_atomic_open
  *
- * NOTE: if fnd != NULL (ntfs_atomic_open) then @dir is locked
+ * NOTE: if fnd != NULL then @dir is locked
  */
-struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
-				struct dentry *dentry,
-				const struct cpu_str *uni, umode_t mode,
-				dev_t dev, const char *symname, u32 size,
-				struct ntfs_fnd *fnd)
+int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
+		      struct dentry *dentry, const struct cpu_str *uni,
+		      umode_t mode, dev_t dev, const char *symname, u32 size,
+		      struct ntfs_fnd *fnd)
 {
 	int err;
 	struct super_block *sb = dir->i_sb;
@@ -1705,9 +1703,11 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 
 	/* Set original time. inode times (i_ctime) may be changed in ntfs_init_acl. */
-	inode->i_atime = inode->i_mtime =
-		inode_set_ctime_to_ts(inode, ni->i_crtime);
-	dir->i_mtime = inode_set_ctime_to_ts(dir, ni->i_crtime);
+	inode_set_atime_to_ts(inode, ni->i_crtime);
+	inode_set_ctime_to_ts(inode, ni->i_crtime);
+	inode_set_mtime_to_ts(inode, ni->i_crtime);
+	inode_set_mtime_to_ts(dir, ni->i_crtime);
+	inode_set_ctime_to_ts(dir, ni->i_crtime);
 
 	mark_inode_dirty(dir);
 	mark_inode_dirty(inode);
@@ -1748,12 +1748,10 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	if (!fnd)
 		ni_unlock(dir_ni);
 
-	if (err)
-		return ERR_PTR(err);
-
-	unlock_new_inode(inode);
+	if (!err)
+		unlock_new_inode(inode);
 
-	return inode;
+	return err;
 }
 
 int ntfs_link_inode(struct inode *inode, struct dentry *dentry)
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index dc41b80cfc584..f435be439a37a 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -107,12 +107,8 @@ static struct dentry *ntfs_lookup(struct inode *dir, struct dentry *dentry,
 static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 		       struct dentry *dentry, umode_t mode, bool excl)
 {
-	struct inode *inode;
-
-	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode, 0,
-				  NULL, 0, NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFREG | mode, 0,
+				 NULL, 0, NULL);
 }
 
 /*
@@ -123,12 +119,8 @@ static int ntfs_create(struct mnt_idmap *idmap, struct inode *dir,
 static int ntfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode, dev_t rdev)
 {
-	struct inode *inode;
-
-	inode = ntfs_create_inode(idmap, dir, dentry, NULL, mode, rdev, NULL, 0,
-				  NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(idmap, dir, dentry, NULL, mode, rdev, NULL, 0,
+				 NULL);
 }
 
 /*
@@ -200,15 +192,12 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 			struct dentry *dentry, const char *symname)
 {
 	u32 size = strlen(symname);
-	struct inode *inode;
 
 	if (unlikely(ntfs3_forced_shutdown(dir->i_sb)))
 		return -EIO;
 
-	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
-				  symname, size, NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFLNK | 0777, 0,
+				 symname, size, NULL);
 }
 
 /*
@@ -217,12 +206,8 @@ static int ntfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 static int ntfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 		      struct dentry *dentry, umode_t mode)
 {
-	struct inode *inode;
-
-	inode = ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
-				  NULL, 0, NULL);
-
-	return IS_ERR(inode) ? PTR_ERR(inode) : 0;
+	return ntfs_create_inode(idmap, dir, dentry, NULL, S_IFDIR | mode, 0,
+				 NULL, 0, NULL);
 }
 
 /*
@@ -353,95 +338,6 @@ static int ntfs_rename(struct mnt_idmap *idmap, struct inode *dir,
 	return err;
 }
 
-/*
- * ntfs_atomic_open
- *
- * inode_operations::atomic_open
- */
-static int ntfs_atomic_open(struct inode *dir, struct dentry *dentry,
-			    struct file *file, u32 flags, umode_t mode)
-{
-	int err;
-	struct inode *inode;
-	struct ntfs_fnd *fnd = NULL;
-	struct ntfs_inode *ni = ntfs_i(dir);
-	struct dentry *d = NULL;
-	struct cpu_str *uni = __getname();
-	bool locked = false;
-
-	if (!uni)
-		return -ENOMEM;
-
-	err = ntfs_nls_to_utf16(ni->mi.sbi, dentry->d_name.name,
-				dentry->d_name.len, uni, NTFS_NAME_LEN,
-				UTF16_HOST_ENDIAN);
-	if (err < 0)
-		goto out;
-
-#ifdef CONFIG_NTFS3_FS_POSIX_ACL
-	if (IS_POSIXACL(dir)) {
-		/*
-		 * Load in cache current acl to avoid ni_lock(dir):
-		 * ntfs_create_inode -> ntfs_init_acl -> posix_acl_create ->
-		 * ntfs_get_acl -> ntfs_get_acl_ex -> ni_lock
-		 */
-		struct posix_acl *p = get_inode_acl(dir, ACL_TYPE_DEFAULT);
-
-		if (IS_ERR(p)) {
-			err = PTR_ERR(p);
-			goto out;
-		}
-		posix_acl_release(p);
-	}
-#endif
-
-	if (d_in_lookup(dentry)) {
-		ni_lock_dir(ni);
-		locked = true;
-		fnd = fnd_get();
-		if (!fnd) {
-			err = -ENOMEM;
-			goto out1;
-		}
-
-		d = d_splice_alias(dir_search_u(dir, uni, fnd), dentry);
-		if (IS_ERR(d)) {
-			err = PTR_ERR(d);
-			d = NULL;
-			goto out2;
-		}
-
-		if (d)
-			dentry = d;
-	}
-
-	if (!(flags & O_CREAT) || d_really_is_positive(dentry)) {
-		err = finish_no_open(file, d);
-		goto out2;
-	}
-
-	file->f_mode |= FMODE_CREATED;
-
-	/*
-	 * fnd contains tree's path to insert to.
-	 * If fnd is not NULL then dir is locked.
-	 */
-	inode = ntfs_create_inode(mnt_idmap(file->f_path.mnt), dir, dentry, uni,
-				  mode, 0, NULL, 0, fnd);
-	err = IS_ERR(inode) ? PTR_ERR(inode) :
-			      finish_open(file, dentry, ntfs_file_open);
-	dput(d);
-
-out2:
-	fnd_put(fnd);
-out1:
-	if (locked)
-		ni_unlock(ni);
-out:
-	__putname(uni);
-	return err;
-}
-
 struct dentry *ntfs3_get_parent(struct dentry *child)
 {
 	struct inode *inode = d_inode(child);
@@ -607,7 +503,6 @@ const struct inode_operations ntfs_dir_inode_operations = {
 	.setattr	= ntfs3_setattr,
 	.getattr	= ntfs_getattr,
 	.listxattr	= ntfs_listxattr,
-	.atomic_open	= ntfs_atomic_open,
 	.fiemap		= ntfs_fiemap,
 };
 
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 5e7536ad0b94c..acfa2a2f7e517 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -714,11 +714,10 @@ int ntfs_sync_inode(struct inode *inode);
 int ntfs_flush_inodes(struct super_block *sb, struct inode *i1,
 		      struct inode *i2);
 int inode_write_data(struct inode *inode, const void *data, size_t bytes);
-struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
-				struct dentry *dentry,
-				const struct cpu_str *uni, umode_t mode,
-				dev_t dev, const char *symname, u32 size,
-				struct ntfs_fnd *fnd);
+int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
+		      struct dentry *dentry, const struct cpu_str *uni,
+		      umode_t mode, dev_t dev, const char *symname, u32 size,
+		      struct ntfs_fnd *fnd);
 int ntfs_link_inode(struct inode *inode, struct dentry *dentry);
 int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry);
 void ntfs_evict_inode(struct inode *inode);
-- 
2.53.0

