Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794437636;
	b=dKOYOJuWQplvCgG76OOYFcTNfHMRDwEkk1uolizuAqH5+wctYwFjigeREtSHXbMx7rpM
	 Z5HcrlEmUGIoW41+xCpPBqsb5+Q6pBHxaRlCCXow7JK1hQufWEDuMZrQ8XZUe8tkvGps0
	 rVwRGywkxTEaVbjGzHLikYHnOqENOK5IYq9UwJf6rd/DdU8i64WAHgJRar/0HPrMJzEqG
	 Qi5IL35lniZ4VJbRX55cREJaxDNcHoTYh/CKQZPBtJ8OIT7b7XBGYU2oHf82ME1FVDCt6
	 qxa84RShsgyApBK9pdfp1zRHzax97S1jnk6SDQPKldX5IgVDWiZyGI2sYYrNXrC5XKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794437636;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FQkke4ecjKDpNbsFDm9UR+yA/9kA4if7XF3uNTp5Ge0=;
	b=foduHogE0wSWp6bwiylrj8M2E0SztSVCUgArDMa8OLmMNqK20FAWZc1xTM9xmU+TnWM0
	 XNqIt5fKCpn0JaTaD2LcliKb+7VkkXvsYdjwttViLW+SoqZGM4t7i+mm0NIz8DlZWMorz
	 UAInDm+GZEj7Zw/vrxtxl+WIDQTTUf0AEqY8E33oDtl68ev8A53moviAEX6W2LxJhTdgZ
	 Vad9kvglEOj8KSfn0AbfSDDTvXzad6A7n0KaQLgtVGrXnbrvay6Ydi1cFsDeFVHAaBeMe
	 Zq7OUl7LM0Dwz4oUkMdb+PX/24RLSGFaXPu+eSpN4lrE4naLY8V3NE9wRbk43GKHFWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJjyOB4J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BDE8606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KJjyOB4J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4135F1F00A05;
	Wed, 11 Nov 2026 22:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794437635;
	bh=FQkke4ecjKDpNbsFDm9UR+yA/9kA4if7XF3uNTp5Ge0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KJjyOB4JeyI6GKB6X2z71FuQdIl1fromofzSia9+3FTSQ4iOOrylm6598UDOdyeJX
	 +Vq66bdHNqK5EyTETJW/rYhWu4n3znLeIYElSa8Wd30MJHs1WwLh22t2h1SxpJy3ft
	 V31UHxTogAnT4+K5xRYXySDS/A4B2xKPTVqgJbhzm4hq010pNrHlmECeidP0PbOUDl
	 MppuudJf6EOz2O1FI8+s9adfHNfa0yEY8GsmApPWOvIq2q0MbSroTbLltQNX42REcE
	 +VnctrdKFBpZONLD2ehdpTSYENh38meBUFNcaw89+2/pokKDvABT4f4SSntrlrq9w3
	 jdbS+/mLv33hw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Chris Mason <mason@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] backing-file: enforce append-only and immutable backing inodes
Date: Wed, 11 Nov 2026 17:53:54 -0500
Message-ID: <20261111225316.192369-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052805-failed-6.12-19b18e01d036@kernel.org>
References: <20261107052805-failed-6.12-19b18e01d036@kernel.org>
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

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 19b18e01d0361ce495be153ecce80b581086ab3f ]

FUSE passthrough opens the backing file anew whenever the FUSE file is
opened. fuse_passthrough_open() passes the flags of that open to
backing_file_open() which opens the backing file with vfs_open() and the
credentials of the server. But vfs_open() doesn't go through may_open().
So the backing inode is never checked for S_APPEND and S_IMMUTABLE. The
checks that did run were done on the FUSE inode and that one never has
either flag.

So anyone who may open the FUSE file for writing can overwrite an
append-only backing file anywhere or write to an immutable one. The
server only has to register the file and a read-only or even an O_PATH
file descriptor is enough for that. Registering requires CAP_SYS_ADMIN
but the writer can be any user that the server lets open the file.

The FUSE inode is checked instead of the backing inode in a few more
places:

- do_mmap() refuses a shared mapping of an append-only file that was
  opened for writing. A FUSE file opened with O_RDWR | O_APPEND passes
  the open check and can then be mapped shared and written to at any
  offset.

- fcntl(F_SETFL) and RWF_NOAPPEND refuse to take append mode away from a
  file on an append-only inode. On the FUSE file both succeed. A
  synchronous write still appends because the backing file was opened
  with O_APPEND. But an asynchronous write is submitted with the flags
  of the user's kiocb and lands at the given offset.

Do the checks on the backing inode. backing_file_open() refuses to open
an immutable inode for writing and an append-only inode for writing
without O_APPEND, just like may_open(). backing_file_mmap() refuses a
shared mapping of an append-only inode, just like do_mmap(). And writes
and splices to a backing file in append mode fail if append mode was
taken away from the user file.

A FUSE file that was opened before the backing file became append-only
can still write anywhere. That's what happens on the native filesystem
as well and the backing file of such a file isn't in append mode. Two
differences remain. F_SETFL succeeds and the next write fails. And FUSE
reports EIO for a refused open because it turns every error from opening
the backing file into EIO.

overlayfs uses the same helpers but it mirrors S_APPEND and S_IMMUTABLE
in its own inode and a chattr through the overlay never sets them on the
upper inode. So for overlayfs this only changes something if the upper
inode is changed behind the overlay's back.

Fixes: 4a90451bbc7f ("fuse: implement open in passthrough mode")
Reported-by: Chris Mason <mason@kernel.org>
Cc: stable@vger.kernel.org # v6.9+
Link: https://patch.msgid.link/20261029-work-fs-ai-fixes-v1-2-88f22792f6f7@kernel.org
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
[ sashal: Retained file_remove_privs(ctx->user_file) instead of file_remove_privs(iocb->ki_filp) to match the existing API. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/backing-file.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 2ed8f17aa5f48..a0caad973766b 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -35,9 +35,21 @@ struct file *backing_file_open(const struct file *user_file, int flags,
 			       const struct cred *cred)
 {
 	const struct path *user_path = file_user_path(user_file);
+	struct inode *real_inode = d_inode(real_path->dentry);
 	struct file *f;
 	int error;
 
+	/*
+	 * may_open() checked the inode of the user file, which need not carry
+	 * S_APPEND and S_IMMUTABLE of the backing inode.
+	 */
+	if ((flags & O_ACCMODE) != O_RDONLY) {
+		if (IS_IMMUTABLE(real_inode))
+			return ERR_PTR(-EPERM);
+		if (IS_APPEND(real_inode) && !(flags & O_APPEND))
+			return ERR_PTR(-EPERM);
+	}
+
 	f = alloc_empty_backing_file(flags, cred, user_file);
 	if (IS_ERR(f))
 		return f;
@@ -224,6 +236,14 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
 	if (!iov_iter_count(iter))
 		return 0;
 
+	/*
+	 * F_SETFL and RWF_NOAPPEND can take append mode away from the user
+	 * file. They checked its inode, not the backing one.
+	 */
+	if ((file->f_flags & O_APPEND) && !(flags & IOCB_APPEND) &&
+	    IS_APPEND(file_inode(file)))
+		return -EPERM;
+
 	ret = file_remove_privs(ctx->user_file);
 	if (ret)
 		return ret;
@@ -312,6 +332,10 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (!out->f_op->splice_write)
 		return -EINVAL;
 
+	/* splice refuses a user file in append mode, so F_SETFL cleared it */
+	if ((out->f_flags & O_APPEND) && IS_APPEND(file_inode(out)))
+		return -EPERM;
+
 	ret = file_remove_privs(ctx->user_file);
 	if (ret)
 		return ret;
@@ -343,6 +367,10 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 	if (!file->f_op->mmap)
 		return -ENODEV;
 
+	/* do_mmap() checked the inode of the user file */
+	if ((vma->vm_flags & VM_SHARED) && IS_APPEND(file_inode(file)))
+		return -EACCES;
+
 	vma_set_file(vma, file);
 
 	old_cred = override_creds(ctx->cred);
-- 
2.53.0

