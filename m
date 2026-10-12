Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4F83921E6
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 16:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820803; cv=none; b=PD5Hm7iSFkCSzAWEJLNNNKgT0Z2hnyTq9gb/xbcPWSaNbe3IzNHB0uvfS9IUDbyy/flj0rAJEFqhQlLWpZig7BOz30IGJTB83PSB/5c54VEzBHNDddPQzxZkTKRratI5PVOum0kX1zu3LY78UUsYKIFBcUUWlZhiYdwAa4q85i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820803; c=relaxed/simple;
	bh=Bf8ZSEXkRpLIUL5g8xL0TtRbS+PP+KEnUREECVoxJVs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=d6nkuxhNNXJByEZlnQ1t2ldhnYOAqV7wd+ADCYL1+qJakgZMO9Cz1Jm2hzPe4PONS14AcZkEcjSMSKfW4MqE7FbmWorq/KTIzMH62TMfqlj5a4inNlrEBCYgHEOE5gLNcEepcHHc1B0i7UR3sdhL6rViDjXnIvf31Gp0mEAiy48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Zx5+gW0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Zx5+gW0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D0BF1F0089B;
	Mon, 12 Oct 2026 16:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820802;
	bh=AgVVZg+pok01Q67kk10giLUTi+qw+TD+c/g6ZkclliM=;
	h=Subject:To:Cc:From:Date;
	b=2Zx5+gW07esdn4XZ+dgIIefmELTHhG1ON4awiEZtLM6vQ6d4NsNWhbGnILMfVpqj3
	 CAv55qifQOoaJN8que+YUXDhtPSeaSgBdF903E+GPZXhbrwyYu31kWhGx32jUf/ptE
	 THhXRF23i+m+pNPiTA7JX09pZ58C1In68Ch1r9aw=
Subject: FAILED: patch "[PATCH] readdir: take no inode lock on an immutable directory" failed to apply to 7.2-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 18:00:06 +0200
Message-ID: <2026101206-reexamine-jolliness-5e12@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x e08f57a7dcb83818c058e415988c23beb6c5a47f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101206-reexamine-jolliness-5e12@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e08f57a7dcb83818c058e415988c23beb6c5a47f Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 2 Oct 2026 15:52:50 +0200
Subject: [PATCH] readdir: take no inode lock on an immutable directory

iterate_dir() takes the directory's i_rwsem shared and holds it across
->iterate_shared(). For a directory that never has an entry and is
never removed the lock keeps nothing still, it only orders every reader
and every writer of that inode behind each other.

For the directory of a nullfs instance that matters. The instance of
the initial mount namespace is the root of every empty mount namespace
and the private instance is the root of every kernel thread, so one
inode is shared across users who have nothing else in common. And a
reader can hold the lock for as long as it likes: back the getdents()
buffer with a mapping of a file on a FUSE mount of your own, let the
copy of "." and ".." fault and let the server wait. Queue an exclusive
taker behind it, a mkdir() in that directory goes through start_dirop()
before the read-only mount is reported, and from then on every lookup
that misses the dcache in that directory, every create and every mount
on it waits until the server answers. One user of an empty mount
namespace stalls all the others.

Add FOP_IMMUTABLE for the file operations of a directory that never
changes and is never removed and let iterate_dir() skip the lock for
it. The flag never changes for a file, ->f_pos is protected by
f_pos_lock since directories are FMODE_ATOMIC_POS, IS_DEADDIR can't be
set on such a directory and neither touch_atime() nor fsnotify take
i_rwsem. Set it on the nullfs directory. The placeholder directories of
libfs never have an entry either but their owners remove them, so they
keep the lock.

Fixes: 9d4e752a24f7 ("namespace: allow creating empty mount namespaces")
Cc: stable@vger.kernel.org # v7.1+
Link: https://patch.msgid.link/20261002-work-mount-fixes-4-v1-19-dd44b89d44ce@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/nullfs.c b/fs/nullfs.c
index d90c71f5eece..ca0dbe3dc259 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -36,6 +36,7 @@ static const struct file_operations nullfs_dir_operations = {
 	.fsync		= noop_fsync,
 	.lock		= nullfs_nolock,
 	.flock		= nullfs_nolock,
+	.fop_flags	= FOP_IMMUTABLE,
 };
 
 static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
diff --git a/fs/readdir.c b/fs/readdir.c
index 76bb1ae3a450..f2288841337a 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -87,6 +87,8 @@ EXPORT_SYMBOL(wrap_directory_iterator);
 int iterate_dir(struct file *file, struct dir_context *ctx)
 {
 	struct inode *inode = file_inode(file);
+	/* never an entry, never removed: nothing for the lock to keep still */
+	bool locked = !(file->f_op->fop_flags & FOP_IMMUTABLE);
 	int res = -ENOTDIR;
 
 	if (!file->f_op->iterate_shared)
@@ -100,9 +102,11 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 	if (res)
 		goto out;
 
-	res = down_read_killable(&inode->i_rwsem);
-	if (res)
-		goto out;
+	if (locked) {
+		res = down_read_killable(&inode->i_rwsem);
+		if (res)
+			goto out;
+	}
 
 	res = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
@@ -112,7 +116,8 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 		fsnotify_access(file);
 		file_accessed(file);
 	}
-	inode_unlock_shared(inode);
+	if (locked)
+		inode_unlock_shared(inode);
 out:
 	return res;
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 784fa20217c4..deb411e86661 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1978,6 +1978,8 @@ struct file_operations {
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
 /* File system supports uncached read/write buffered IO */
 #define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
+/* Never changes and is never removed, readdir of a directory takes no lock */
+#define FOP_IMMUTABLE		((__force fop_flags_t)(1 << 8))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,

