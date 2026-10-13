Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222F75304B3
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 18:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791915190; cv=none; b=jgnnANH8miXB+2+dPRG2h7iS1cf37EvfBJGuCDKfJbEwj3QoRzfYJRThGJffdtv0l8mWCdab/7DZeDznnpdxJQ2Q0+EcDtOCLH/Sd2k2bMHu4hCe6HVh7QiGbLGqbP1b7nMHAiAeVEwdiBT3/UuqCYFI5ENaHNXRCdntWxXad70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791915190; c=relaxed/simple;
	bh=Sqc7psR3R9F1ycOtEJijn9i+aUGeM6E1Jq+9MXzu3E4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nFws6T03UbcXL+vg5IHuvuEnOY5GBwhTam0ZyWMXRzMLisySqUC1TYaGYvw8durYufNDmIKTqwBZsDbu56MQnn8B4P0B4gmahg4h8vcYC3ec76QE2Ahg46uXXHrfkdGs+nqpbv9uHbxb3JfQHvnUPHvAVzoPI3YYT7n8R29MIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTNNzRam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTNNzRam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB021F000FF;
	Tue, 13 Oct 2026 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791915188;
	bh=MGf8xa6Szws8B3uDV4w9/TaPiv+vU85T9sNe6EDzFcA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QTNNzRam+4PqcYn4jBrU3lBGcwfugztOj2W9Mqv33FSSAIXwAvAF10YxUk95phoi3
	 TPgmevCASprjbzyAEY8JjTYb6FpcjkBPQLSo6+somotpdAJk8VV6C0O60wOg6G6103
	 XL6HD5CMAqobEO1ImQmnB08/Y/6DN6IwL3jgGgrqCO5LUBS7ZafTi2Bs4/u5rnyluR
	 7HD5vTcN8F/yMx59sWs9G2kKiX66DEU0Lsfew16JAZ34RRMNq6WI5f2D5Msh/JrIU1
	 glLW21Wr89Ke70PwpsOvLqvPFhwC/myaDUkXNNfu/q0JbjUKDlguy+Q4QYQYpFba1H
	 Fv986EqHVOmVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Junxuan Liao <ljx@cs.wisc.edu>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] docs/vfs: update references to i_mutex to i_rwsem
Date: Tue, 13 Oct 2026 14:13:05 -0400
Message-ID: <20261013181246.702440-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026101252-mushily-wrought-79e6@gregkh>
References: <2026101252-mushily-wrought-79e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Junxuan Liao <ljx@cs.wisc.edu>

[ Upstream commit 2773d282cd56464f62e9b4703c41d2f733a67842 ]

VFS has switched to i_rwsem for ten years now (9902af79c01a: parallel
lookups actual switch to rwsem), but the VFS documentation and comments
still has references to i_mutex.

Signed-off-by: Junxuan Liao <ljx@cs.wisc.edu>
Link: https://lore.kernel.org/72223729-5471-474a-af3c-f366691fba82@cs.wisc.edu
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 528b383dc35d ("namespace: unhash a dentry before detaching the mounts on it")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/filesystems/vfs.rst |  5 +++--
 fs/attr.c                         | 10 +++++-----
 fs/buffer.c                       |  2 +-
 fs/dcache.c                       | 10 +++++-----
 fs/direct-io.c                    |  8 ++++----
 fs/inode.c                        |  9 ++++-----
 fs/libfs.c                        |  5 +++--
 fs/locks.c                        |  2 +-
 fs/namei.c                        | 22 +++++++++++-----------
 fs/namespace.c                    |  2 +-
 fs/stack.c                        |  4 ++--
 fs/xattr.c                        |  2 +-
 include/linux/exportfs.h          |  4 ++--
 include/linux/fs.h                |  6 +++---
 include/linux/fs_stack.h          |  2 +-
 include/linux/quotaops.h          |  2 +-
 16 files changed, 48 insertions(+), 47 deletions(-)

diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
index 0b18af3f954eb..7bd60c97dd7a5 100644
--- a/Documentation/filesystems/vfs.rst
+++ b/Documentation/filesystems/vfs.rst
@@ -740,8 +740,9 @@ process is more complicated and uses write_begin/write_end or
 dirty_folio to write data into the address_space, and writepage and
 writepages to writeback data to storage.
 
-Adding and removing pages to/from an address_space is protected by the
-inode's i_mutex.
+Removing pages from an address_space requires holding the inode's i_rwsem
+exclusively, while adding pages to the address_space requires holding the
+inode's i_mapping->invalidate_lock exclusively.
 
 When data is written to a page, the PG_Dirty flag should be set.  It
 typically remains set until writepage asks for it to be written.  This
diff --git a/fs/attr.c b/fs/attr.c
index 927cb18d25d52..b038b9bcd265a 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -240,7 +240,7 @@ EXPORT_SYMBOL(setattr_prepare);
  * @inode:	the inode to be truncated
  * @offset:	the new size to assign to the inode
  *
- * inode_newsize_ok must be called with i_mutex held.
+ * inode_newsize_ok must be called with i_rwsem held exclusively.
  *
  * inode_newsize_ok will check filesystem limits and ulimits to check that the
  * new inode size is within limits. inode_newsize_ok will also send SIGXFSZ
@@ -287,7 +287,7 @@ EXPORT_SYMBOL(inode_newsize_ok);
  * @inode:	the inode to be updated
  * @attr:	the new attributes
  *
- * setattr_copy must be called with i_mutex held.
+ * setattr_copy must be called with i_rwsem held exclusively.
  *
  * setattr_copy updates the inode's metadata with that specified
  * in attr on idmapped mounts. Necessary permission checks to determine
@@ -364,13 +364,13 @@ EXPORT_SYMBOL(may_setattr);
  * @attr:	new attributes
  * @delegated_inode: returns inode, if the inode is delegated
  *
- * The caller must hold the i_mutex on the affected object.
+ * The caller must hold the i_rwsem exclusively on the affected object.
  *
  * If notify_change discovers a delegation in need of breaking,
  * it will return -EWOULDBLOCK and return a reference to the inode in
  * delegated_inode.  The caller should then break the delegation and
  * retry.  Because breaking a delegation may take a long time, the
- * caller should drop the i_mutex before doing so.
+ * caller should drop the i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -417,7 +417,7 @@ int notify_change(struct mnt_idmap *idmap, struct dentry *dentry,
 		if (S_ISLNK(inode->i_mode))
 			return -EOPNOTSUPP;
 
-		/* Flag setting protected by i_mutex */
+		/* Flag setting protected by i_rwsem */
 		if (is_sxid(attr->ia_mode))
 			inode->i_flags &= ~S_NOSEC;
 	}
diff --git a/fs/buffer.c b/fs/buffer.c
index c5aaf1419d341..2c57eff673493 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -2623,7 +2623,7 @@ EXPORT_SYMBOL(block_commit_write);
  * holes and correct delalloc and unwritten extent mapping on filesystems that
  * support these features.
  *
- * We are not allowed to take the i_mutex here so we have to play games to
+ * We are not allowed to take the i_rwsem here so we have to play games to
  * protect against truncate races as the page could now be beyond EOF.  Because
  * truncate writes the inode size before removing pages, once we have the
  * page lock we can determine safely if the page is beyond EOF. If it is not
diff --git a/fs/dcache.c b/fs/dcache.c
index 982559a94d155..dc6d85de920e8 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -2733,10 +2733,10 @@ static void copy_name(struct dentry *dentry, struct dentry *target)
  * @target: new dentry
  * @exchange: exchange the two dentries
  *
- * Update the dcache to reflect the move of a file name. Negative
- * dcache entries should not be moved in this way. Caller must hold
- * rename_lock, the i_mutex of the source and target directories,
- * and the sb->s_vfs_rename_mutex if they differ. See lock_rename().
+ * Update the dcache to reflect the move of a file name. Negative dcache
+ * entries should not be moved in this way. Caller must hold rename_lock, the
+ * i_rwsem of the source and target directories (exclusively), and the sb->
+ * s_vfs_rename_mutex if they differ. See lock_rename().
  */
 static void __d_move(struct dentry *dentry, struct dentry *target,
 		     bool exchange)
@@ -2882,7 +2882,7 @@ struct dentry *d_ancestor(struct dentry *p1, struct dentry *p2)
  * This helper attempts to cope with remotely renamed directories
  *
  * It assumes that the caller is already holding
- * dentry->d_parent->d_inode->i_mutex, and rename_lock
+ * dentry->d_parent->d_inode->i_rwsem, and rename_lock
  *
  * Note: If ever the locking in lock_rename() changes, then please
  * remember to update this too...
diff --git a/fs/direct-io.c b/fs/direct-io.c
index bbd05f1a21453..1694ee9a93820 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -1083,8 +1083,8 @@ static inline int drop_refcount(struct dio *dio)
  * The locking rules are governed by the flags parameter:
  *  - if the flags value contains DIO_LOCKING we use a fancy locking
  *    scheme for dumb filesystems.
- *    For writes this function is called under i_mutex and returns with
- *    i_mutex held, for reads, i_mutex is not held on entry, but it is
+ *    For writes this function is called under i_rwsem and returns with
+ *    i_rwsem held, for reads, i_rwsem is not held on entry, but it is
  *    taken and dropped again before returning.
  *  - if the flags value does NOT contain DIO_LOCKING we don't use any
  *    internal locking but rather rely on the filesystem to synchronize
@@ -1094,7 +1094,7 @@ static inline int drop_refcount(struct dio *dio)
  * counter before starting direct I/O, and decrement it once we are done.
  * Truncate can wait for it to reach zero to provide exclusion.  It is
  * expected that filesystem provide exclusion between new direct I/O
- * and truncates.  For DIO_LOCKING filesystems this is done by i_mutex,
+ * and truncates.  For DIO_LOCKING filesystems this is done by i_rwsem,
  * but other filesystems need to take care of this on their own.
  *
  * NOTE: if you pass "sdio" to anything by pointer make sure that function
@@ -1279,7 +1279,7 @@ ssize_t __blockdev_direct_IO(struct kiocb *iocb, struct inode *inode,
 
 	/*
 	 * All block lookups have been performed. For READ requests
-	 * we can let i_mutex go now that its achieved its purpose
+	 * we can let i_rwsem go now that its achieved its purpose
 	 * of protecting us from looking up uninitialized blocks.
 	 */
 	if (iov_iter_rw(iter) == READ && (dio->flags & DIO_LOCKING))
diff --git a/fs/inode.c b/fs/inode.c
index 7942673f686fd..9f622a05ca8dc 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1133,9 +1133,8 @@ void lockdep_annotate_inode_mutex_key(struct inode *inode)
 		/* Set new key only if filesystem hasn't already changed it */
 		if (lockdep_match_class(&inode->i_rwsem, &type->i_mutex_key)) {
 			/*
-			 * ensure nobody is actually holding i_mutex
+			 * ensure nobody is actually holding i_rwsem
 			 */
-			// mutex_destroy(&inode->i_mutex);
 			init_rwsem(&inode->i_rwsem);
 			lockdep_set_class(&inode->i_rwsem,
 					  &type->i_mutex_dir_key);
@@ -2552,7 +2551,7 @@ EXPORT_SYMBOL(inode_dio_finished);
  * proceed with a truncate or equivalent operation.
  *
  * Must be called under a lock that serializes taking new references
- * to i_dio_count, usually by inode->i_mutex.
+ * to i_dio_count, usually by inode->i_rwsem.
  */
 void inode_dio_wait(struct inode *inode)
 {
@@ -2570,7 +2569,7 @@ EXPORT_SYMBOL(inode_dio_wait_interruptible);
 /*
  * inode_set_flags - atomically set some inode flags
  *
- * Note: the caller should be holding i_mutex, or else be sure that
+ * Note: the caller should be holding i_rwsem exclusively, or else be sure that
  * they have exclusive access to the inode structure (i.e., while the
  * inode is being instantiated).  The reason for the cmpxchg() loop
  * --- which wouldn't be necessary if all code paths which modify
@@ -2578,7 +2577,7 @@ EXPORT_SYMBOL(inode_dio_wait_interruptible);
  * code path which doesn't today so we use cmpxchg() out of an abundance
  * of caution.
  *
- * In the long run, i_mutex is overkill, and we should probably look
+ * In the long run, i_rwsem is overkill, and we should probably look
  * at using the i_lock spinlock to protect i_flags, and then make sure
  * it is so documented in include/linux/fs.h and that all code follows
  * the locking convention!!
diff --git a/fs/libfs.c b/fs/libfs.c
index 028f2cf729d5d..831884e5c5ee4 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -932,7 +932,8 @@ EXPORT_SYMBOL(simple_write_begin);
  * simple_write_end does the minimum needed for updating a folio after
  * writing is done. It has the same API signature as the .write_end of
  * address_space_operations vector. So it can just be set onto .write_end for
- * FSes that don't need any other processing. i_mutex is assumed to be held.
+ * FSes that don't need any other processing. i_rwsem is assumed to be held
+ * exclusively.
  * Block based filesystems should use generic_write_end().
  * NOTE: Even though i_size might get updated by this function, mark_inode_dirty
  * is not called, so a filesystem that actually does store data in .write_inode
@@ -959,7 +960,7 @@ static int simple_write_end(struct file *file, struct address_space *mapping,
 	}
 	/*
 	 * No need to use i_size_read() here, the i_size
-	 * cannot change under us because we hold the i_mutex.
+	 * cannot change under us because we hold the i_rwsem.
 	 */
 	if (last_pos > inode->i_size)
 		i_size_write(inode, last_pos);
diff --git a/fs/locks.c b/fs/locks.c
index 3bc5f88121602..b70f29fcec3e1 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1794,7 +1794,7 @@ generic_add_lease(struct file *filp, int arg, struct file_lease **flp, void **pr
 
 	/*
 	 * In the delegation case we need mutual exclusion with
-	 * a number of operations that take the i_mutex.  We trylock
+	 * a number of operations that take the i_rwsem.  We trylock
 	 * because delegations are an optional optimization, and if
 	 * there's some chance of a conflict--we'd rather not
 	 * bother, maybe that's a sign this just isn't a good file to
diff --git a/fs/namei.c b/fs/namei.c
index 0c47a14e88a6b..433b1a432ffc9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -1417,7 +1417,7 @@ static int __traverse_mounts(struct path *path, unsigned flags, bool *jumped,
 	int ret = 0;
 
 	while (flags & DCACHE_MANAGED_DENTRY) {
-		/* Allow the filesystem to manage the transit without i_mutex
+		/* Allow the filesystem to manage the transit without i_rwsem
 		 * being held. */
 		if (flags & DCACHE_MANAGE_TRANSIT) {
 			if (lookup_flags & LOOKUP_NO_XDEV) {
@@ -2925,7 +2925,7 @@ EXPORT_SYMBOL(try_lookup_one_len);
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code.
  *
- * The caller must hold base->i_mutex.
+ * The caller must hold base->i_rwsem.
  */
 struct dentry *lookup_one_len(const char *name, struct dentry *base, int len)
 {
@@ -2954,7 +2954,7 @@ EXPORT_SYMBOL(lookup_one_len);
  * Note that this routine is purely a helper for filesystem usage and should
  * not be called by generic code.
  *
- * The caller must hold base->i_mutex.
+ * The caller must hold base->i_rwsem.
  */
 struct dentry *lookup_one(struct mnt_idmap *idmap, const char *name,
 			  struct dentry *base, int len)
@@ -4521,13 +4521,13 @@ SYSCALL_DEFINE1(rmdir, const char __user *, pathname)
  * @dentry:	victim
  * @delegated_inode: returns victim inode, if the inode is delegated.
  *
- * The caller must hold dir->i_mutex.
+ * The caller must hold dir->i_rwsem exclusively.
  *
  * If vfs_unlink discovers a delegation, it will return -EWOULDBLOCK and
  * return a reference to the inode in delegated_inode.  The caller
  * should then break the delegation on that inode and retry.  Because
  * breaking a delegation may take a long time, the caller should drop
- * dir->i_mutex before doing so.
+ * dir->i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -4586,7 +4586,7 @@ EXPORT_SYMBOL(vfs_unlink);
 
 /*
  * Make sure that the actual truncation of the file will occur outside its
- * directory's i_mutex.  Truncate can take a long time if there is a lot of
+ * directory's i_rwsem.  Truncate can take a long time if there is a lot of
  * writeout happening, and we don't want to prevent access to the directory
  * while waiting on the I/O.
  */
@@ -4766,13 +4766,13 @@ SYSCALL_DEFINE2(symlink, const char __user *, oldname, const char __user *, newn
  * @new_dentry:	where to create the new link
  * @delegated_inode: returns inode needing a delegation break
  *
- * The caller must hold dir->i_mutex
+ * The caller must hold dir->i_rwsem exclusively.
  *
  * If vfs_link discovers a delegation on the to-be-linked file in need
  * of breaking, it will return -EWOULDBLOCK and return a reference to the
  * inode in delegated_inode.  The caller should then break the delegation
  * and retry.  Because breaking a delegation may take a long time, the
- * caller should drop the i_mutex before doing so.
+ * caller should drop the i_rwsem before doing so.
  *
  * Alternatively, a caller may pass NULL for delegated_inode.  This may
  * be appropriate for callers that expect the underlying filesystem not
@@ -4968,7 +4968,7 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	c) we may have to lock up to _four_ objects - parents and victim (if it exists),
  *	   and source (if it's a non-directory or a subdirectory that moves to
  *	   different parent).
- *	   And that - after we got ->i_mutex on parents (until then we don't know
+ *	   And that - after we got ->i_rwsem on parents (until then we don't know
  *	   whether the target exists).  Solution: try to be smart with locking
  *	   order for inodes.  We rely on the fact that tree topology may change
  *	   only under ->s_vfs_rename_mutex _and_ that parent of the object we
@@ -4980,9 +4980,9 @@ SYSCALL_DEFINE2(link, const char __user *, oldname, const char __user *, newname
  *	   has no more than 1 dentry.  If "hybrid" objects will ever appear,
  *	   we'd better make sure that there's no link(2) for them.
  *	d) conversion from fhandle to dentry may come in the wrong moment - when
- *	   we are removing the target. Solution: we will have to grab ->i_mutex
+ *	   we are removing the target. Solution: we will have to grab ->i_rwsem
  *	   in the fhandle_to_dentry code. [FIXME - current nfsfh.c relies on
- *	   ->i_mutex on parents, which works but leads to some truly excessive
+ *	   ->i_rwsem on parents, which works but leads to some truly excessive
  *	   locking].
  */
 int vfs_rename(struct renamedata *rd)
diff --git a/fs/namespace.c b/fs/namespace.c
index f87bdff661664..6f8a75dbae786 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1955,7 +1955,7 @@ static int do_umount(struct mount *mnt, int flags)
  * detach_mounts allows lazily unmounting those mounts instead of
  * leaking them.
  *
- * The caller may hold dentry->d_inode->i_mutex.
+ * The caller may hold dentry->d_inode->i_rwsem.
  */
 void __detach_mounts(struct dentry *dentry)
 {
diff --git a/fs/stack.c b/fs/stack.c
index f189201199443..d8c782e064e3e 100644
--- a/fs/stack.c
+++ b/fs/stack.c
@@ -3,7 +3,7 @@
 #include <linux/fs.h>
 #include <linux/fs_stack.h>
 
-/* does _NOT_ require i_mutex to be held.
+/* does _NOT_ require i_rwsem to be held.
  *
  * This function cannot be inlined since i_size_{read,write} is rather
  * heavy-weight on 32-bit systems
@@ -41,7 +41,7 @@ void fsstack_copy_inode_size(struct inode *dst, struct inode *src)
 	 * If CONFIG_SMP or CONFIG_PREEMPTION on 32-bit, it's vital for
 	 * fsstack_copy_inode_size() to hold some lock around
 	 * i_size_write(), otherwise i_size_read() may spin forever (see
-	 * include/linux/fs.h).  We don't necessarily hold i_mutex when this
+	 * include/linux/fs.h).  We don't necessarily hold i_rwsem when this
 	 * is called, so take i_lock for that case.
 	 *
 	 * And if on 32-bit, continue our effort to keep the two halves of
diff --git a/fs/xattr.c b/fs/xattr.c
index 23b9e4b1f3dd8..cb672c010976e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -215,7 +215,7 @@ EXPORT_SYMBOL(__vfs_setxattr);
  *
  *  returns the result of the internal setxattr or setsecurity operations.
  *
- *  This function requires the caller to lock the inode's i_mutex before it
+ *  This function requires the caller to lock the inode's i_rwsem before it
  *  is executed. It also assumes that the caller will make the appropriate
  *  permission checks.
  */
diff --git a/include/linux/exportfs.h b/include/linux/exportfs.h
index 0ac405f884859..1ffcb6499819f 100644
--- a/include/linux/exportfs.h
+++ b/include/linux/exportfs.h
@@ -205,7 +205,7 @@ struct fid {
  *    directory.  The name should be stored in the @name (with the
  *    understanding that it is already pointing to a %NAME_MAX+1 sized
  *    buffer.   get_name() should return %0 on success, a negative error code
- *    or error.  @get_name will be called without @parent->i_mutex held.
+ *    or error.  @get_name will be called without @parent->i_rwsem held.
  *
  * get_parent:
  *    @get_parent should find the parent directory for the given @child which
@@ -216,7 +216,7 @@ struct fid {
  *    @commit_metadata should commit metadata changes to stable storage.
  *
  * Locking rules:
- *    get_parent is called with child->d_inode->i_mutex down
+ *    get_parent is called with child->d_inode->i_rwsem down
  *    get_name is not (which is possibly inconsistent)
  */
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 19211eb49a8c0..2b8f863c3b643 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -818,7 +818,7 @@ static inline void inode_fake_hash(struct inode *inode)
 }
 
 /*
- * inode->i_mutex nesting subclasses for the lock validator:
+ * inode->i_rwsem nesting subclasses for the lock validator:
  *
  * 0: the object of the current VFS operation
  * 1: parent
@@ -970,7 +970,7 @@ static inline loff_t i_size_read(const struct inode *inode)
 
 /*
  * NOTE: unlike i_size_read(), i_size_write() does need locking around it
- * (normally i_mutex), otherwise on 32bit/SMP an update of i_size_seqcount
+ * (normally i_rwsem), otherwise on 32bit/SMP an update of i_size_seqcount
  * can be lost, resulting in subsequent i_size_read() calls spinning forever.
  */
 static inline void i_size_write(struct inode *inode, loff_t i_size)
@@ -1895,7 +1895,7 @@ static inline void sb_end_intwrite(struct super_block *sb)
  * freeze protection should be the outermost lock. In particular, we have:
  *
  * sb_start_write
- *   -> i_mutex			(write path, truncate, directory ops, ...)
+ *   -> i_rwsem			(write path, truncate, directory ops, ...)
  *   -> s_umount		(freeze_super, thaw_super)
  */
 static inline void sb_start_write(struct super_block *sb)
diff --git a/include/linux/fs_stack.h b/include/linux/fs_stack.h
index 2b1f74b240707..0cc2fa283305b 100644
--- a/include/linux/fs_stack.h
+++ b/include/linux/fs_stack.h
@@ -3,7 +3,7 @@
 #define _LINUX_FS_STACK_H
 
 /* This file defines generic functions used primarily by stackable
- * filesystems; none of these functions require i_mutex to be held.
+ * filesystems; none of these functions require i_rwsem to be held.
  */
 
 #include <linux/fs.h>
diff --git a/include/linux/quotaops.h b/include/linux/quotaops.h
index 2334a02c30149..f9c0f9d7c9d93 100644
--- a/include/linux/quotaops.h
+++ b/include/linux/quotaops.h
@@ -19,7 +19,7 @@ static inline struct quota_info *sb_dqopt(struct super_block *sb)
 	return &sb->s_dquot;
 }
 
-/* i_mutex must being held */
+/* i_rwsem must being held */
 static inline bool is_quota_modification(struct mnt_idmap *idmap,
 					 struct inode *inode, struct iattr *ia)
 {
-- 
2.53.0

