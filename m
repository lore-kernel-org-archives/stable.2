Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B46E53E302
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 23:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791932704; cv=none; b=f3URb8wdGfCr9KZy49uqRY6OEAisj5jJfABGb6gm6riu3ioxpgeMINHZYnHCJR6iqHXY3vwAVUXwYrPZui9qX2hu5FjTqRZ4EDcR+WnAdAO77nq+MwswPqigMNoy5pq/FcBJoYU5jvqXfb59zlOurX9fVpfCC1eyDXRFhg8c924=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791932704; c=relaxed/simple;
	bh=E6L8UcjjnASUgQGMhYCSSW+Wnahr42npvjB4bw0pE+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wc3+ky+DdxpLIRFwlwvqCFCz3+wmu6zjhLdy3KBziAgj4nbOFvryWmfIJE1cG2/av6HQJSw9EyCgiEXzndon9hT6/QzEBEMk9c3ffv99/tr8TMb3u+/1y1egd2a9O3NxNQPuquYqM0lD4bGeQKVxCr7Bmuk/qeg+dcStRa8JQw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YdpFOpwn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YdpFOpwn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F831F00893;
	Tue, 13 Oct 2026 23:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791932703;
	bh=uOX9ZZKNvogpJcAQv/hvxUR70/BK6QqaA96Buut8Y6Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YdpFOpwna5ExHWURgwOX6bmODs8oN31GTguLHV1wUdGYXzm9d8JknV+6yeKMmfyLl
	 fVPsStYmRxkPpuHNcLh7xSUH5Gl6E8BZ824a9c8RPpo9elqJU8xSXmVrh+K/Z8Fm8Z
	 fWF47oIDjZTc1M+o4pAK7ETmHsFT9M2wE8YaGcrjBLvFYd1C5u0Y4wDd6f0+IvIfAz
	 pVjHiVXQUmCB89wzGgipby7ePp6ZdsCnThzEtd6X9YO/Z+Y2PIyDl94LVhUoCttbXv
	 PKk0W3MtS92KY1PR6aAkiMgkFR6m+08VSBKPpLZ4BcJS/0e+c82XzlA6C1psXDixhA
	 yWcLReX54gjtA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] readdir: take no inode lock on an immutable directory
Date: Tue, 13 Oct 2026 19:05:01 -0400
Message-ID: <20261013230336.829040-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013230336.829040-1-sashal@kernel.org>
References: <2026101206-reexamine-jolliness-5e12@gregkh>
 <20261013230336.829040-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit e08f57a7dcb83818c058e415988c23beb6c5a47f ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nullfs.c        |  1 +
 fs/readdir.c       | 13 +++++++++----
 include/linux/fs.h |  2 ++
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/fs/nullfs.c b/fs/nullfs.c
index fc79ca42bb178..c89181daf208c 100644
--- a/fs/nullfs.c
+++ b/fs/nullfs.c
@@ -34,6 +34,7 @@ static const struct file_operations nullfs_dir_operations = {
 	.fsync		= noop_fsync,
 	.lock		= nullfs_nolock,
 	.flock		= nullfs_nolock,
+	.fop_flags	= FOP_IMMUTABLE,
 };
 
 static int nullfs_fs_fill_super(struct super_block *s, struct fs_context *fc)
diff --git a/fs/readdir.c b/fs/readdir.c
index 76bb1ae3a4504..f2288841337ad 100644
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
index 09de7bf6f1d28..a07031fd4ae24 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1980,6 +1980,8 @@ struct file_operations {
 #define FOP_ASYNC_LOCK		((__force fop_flags_t)(1 << 6))
 /* File system supports uncached read/write buffered IO */
 #define FOP_DONTCACHE		((__force fop_flags_t)(1 << 7))
+/* Never changes and is never removed, readdir of a directory takes no lock */
+#define FOP_IMMUTABLE		((__force fop_flags_t)(1 << 8))
 
 /* Wrap a directory iterator that needs exclusive inode access */
 int wrap_directory_iterator(struct file *, struct dir_context *,
-- 
2.53.0

