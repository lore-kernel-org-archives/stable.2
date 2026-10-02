Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 074844DBD70;
	Fri,  2 Oct 2026 13:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949263; cv=none; b=og79CD0mMKHwQSnC+kyBpd2pqGMw88WX8MqyE4UZYF0+SEdr5BksDW5P0k7rhBrgq0e/lcr2xHGuGF4Gm9uL/EARXG3LR1SlElxZg5pRpVtUEFmtcRPdpLCuECVyPT//F72C8laJu81/oz8odS7C5rOrLMDruAdWqnhDB08HKL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949263; c=relaxed/simple;
	bh=6DTUTR3vci9TVR0f5VJSu7/oQFnEzU3Q12LI98klt38=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DOQzyjcp/M2xJzUoVWn4osl+sKb7vfFktfVPZ91mPbP4O22Knq/sRnAZncoIm3zgGgz2nJIrT8CsHoVDo5t/YurmeSIHoF/VVte9OPJUGYVgXetdqYHLGPWhsb+UUmXuo77DN1FyIuhNbbB3g5znlaKac0L0RkUddHrJfgeXvMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EZ7kq2YG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EZ7kq2YG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D30611F000FF;
	Fri,  2 Oct 2026 13:54:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949261;
	bh=3fGReSXC5XNGD1PpaGmsCBaQNVkgsJNA6DlnvCVauj4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EZ7kq2YGeQYe2UmN47oJF8WyHKR8fuKGtSXclNpkYw30DMe8n1NZ0wHnyv6XPS5NZ
	 eAWkhrlIwwyvEF5slYBKxxs/v6rTWTzxY94srjqS5ya2BMAzTwYJVhQ0PXaEeGkypy
	 tHZpyC69/O2t6vpIbQv0sov5KP8oSHTCVXnEIvKC9jld4alTOaUjRBiNVI62OP3KqC
	 W6Hi2EFKN/PzVZKpyVOpJIZGXNNQdxYnvpVPlOR3Cxt1vovySn+/D51wiNxmtJMyY7
	 Qru5vCnww1Aw1KZ+VOF9cxmVPErNIoV/WL7XrxX21aI1sTDH23KRM4sfxzh9jzUFnD
	 noa3/qoW6Sr0w==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Oct 2026 15:52:50 +0200
Subject: [PATCH 19/21] readdir: take no inode lock on an immutable
 directory
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-work-mount-fixes-4-v1-19-dd44b89d44ce@kernel.org>
References: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
In-Reply-To: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4042; i=brauner@kernel.org;
 h=from:subject:message-id; bh=6DTUTR3vci9TVR0f5VJSu7/oQFnEzU3Q12LI98klt38=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x5VxSJk+Pmkxd8flbX9c9s0bZW2TVF9xCWWr/4nQ
 /4cx7S9HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOp9WT4n/xHVTXz+y+FpPbD
 T6NZTgWy/r3zlcM2OknAa9El4+QLcYwMTwQnOmV+V7OrUJLJ9OpzMqrbOsHs6WTNux1vtvYZ5rz
 jBAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/nullfs.c        |  1 +
 fs/readdir.c       | 13 +++++++++----
 include/linux/fs.h |  2 ++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index f76b87cf1841..bfc04bca3940 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -44,6 +44,7 @@ static const struct file_operations nullfs_dir_operations = {
 	.lock		= nullfs_nolock,
 	.flock		= nullfs_nolock,
 	.setlease	= nullfs_nolease,
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

-- 
2.53.0

