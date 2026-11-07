Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047287;
	b=ry4iyKB/f5JWXKXyC2PgAq8q5FOQjFFsVpmmIgMwC7vXIJVTty/2hzEmcbFkLDNI20fm
	 ECwwQFnjZxu4CyWGcI1c7lwS5lvBWo7wIPy4WEFDb+7Huxl4jj+MagzEbh7IqWtUePkX+
	 m+ZyTJLBcVuj6zskAND54QIQ0cq2N0YpqjRUl2CgWlmacjNIi/JRchephBUQTy0mtqr2m
	 Fzy0QU32rTabRZPVZcapsKoUh4JCs/Jvp1Zh7WSmcdY1/wb7nAyAZqMe9hX5s8fek+/4b
	 lhy79+Myi00fYikAMKRBaMtUrbJpNEKsu/duuCQtKDPVW8AXcferb2QEHZ5uOrBmnPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047287;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=6zFOskH8Lbpvt1SdN+6Wo3BTaMl9HH+et62btuTMuNk=;
	b=5n3Bv/t2R1WhMQDktyBXJL1z90ov5h/5KgAngJeGB0HrMQg/SDAybMQaHPAPDaBlbYtq
	 rmqXN9KxYhggxaCuAXaIunnORzqqVAMajcsbgopVaIuWlz3Kw/H1bGuQ684BMK7H53I0Y
	 H8mLinABq03ir4pqKPYoqgM8WFMfVAFIgFoKQqdWQcgMJ05LhnRkQMCdDVTC/Fnog44kl
	 CnTnFszQrobSKfc7trtXGfRcHNJxM1/Jc/foH6ls+oVw5w12yZolX0ct6wcGOEeTQVvHU
	 r2DRF02EECGhhrAqch/CaaSl/OCgJLXyvIKm6WuIriAmhB4T6vzgHHZeQ0sqKKeovgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omLuEGnI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5D1606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omLuEGnI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC0D1F0089F;
	Sat,  7 Nov 2026 10:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047287;
	bh=6zFOskH8Lbpvt1SdN+6Wo3BTaMl9HH+et62btuTMuNk=;
	h=From:To:Cc:Subject:Date;
	b=omLuEGnIIgvFVGMLVogJ01Jbiq7G+Mc/KVx8EvCGYmkpBrdPqCCLjOchKJPXh0tcj
	 f8XLSNXwDMlv1gBrvWRUS34r1zPquqBsolpBWU+85DPwI62hBe8S7g08GDVV19K7ib
	 SPBmiSkt2hqYmurOVal64fhLGmhJ6o4cyzyNr51KJx9B71JuNd1LajD6F/kPA86SXy
	 ls6y5aRIVY4kqQOKtV1wyd/EnZw4ey1rvmIwcXXYF5aEiMGs7S16tVI9GZ1dqhyDNG
	 pjPLfWK5DK2uIrHyGZrlMIVqh8LFEzdKBE0CCdW4778PCbnmPvnLSnXN916WDltf6S
	 2U8ZCYX1f55yA==
From: Sasha Levin <sashal@kernel.org>
To: brauner@kernel.org,
	mason@kernel.org,
	amir73il@gmail.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] backing-file: enforce append-only and immutable backing inodes" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:28:05 -0500
Message-ID: <20261107052805-failed-6.12-19b18e01d036@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 19b18e01d0361ce495be153ecce80b581086ab3f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052805-failed-6.12-19b18e01d036@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 19b18e01d0361ce495be153ecce80b581086ab3f Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 29 Oct 2026 15:00:21 +0100
Subject: [PATCH] backing-file: enforce append-only and immutable backing
 inodes

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
---
 fs/backing-file.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/fs/backing-file.c b/fs/backing-file.c
index 5614cb7801e1b..2424dc38d21ac 100644
--- a/fs/backing-file.c
+++ b/fs/backing-file.c
@@ -36,9 +36,21 @@ struct file *backing_file_open(const struct file *user_file, int flags,
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
@@ -263,6 +275,14 @@ ssize_t backing_file_write_iter(struct file *file, struct iov_iter *iter,
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
 	ret = file_remove_privs(iocb->ki_filp);
 	if (ret)
 		return ret;
@@ -309,6 +329,10 @@ ssize_t backing_file_splice_write(struct pipe_inode_info *pipe,
 	if (!out->f_op->splice_write)
 		return -EINVAL;
 
+	/* splice refuses a user file in append mode, so F_SETFL cleared it */
+	if ((out->f_flags & O_APPEND) && IS_APPEND(file_inode(out)))
+		return -EPERM;
+
 	ret = file_remove_privs(iocb->ki_filp);
 	if (ret)
 		return ret;
@@ -338,6 +362,10 @@ int backing_file_mmap(struct file *file, struct vm_area_struct *vma,
 	if (!can_mmap_file(file))
 		return -ENODEV;
 
+	/* do_mmap() checked the inode of the user file */
+	if ((vma->vm_flags & VM_SHARED) && IS_APPEND(file_inode(file)))
+		return -EACCES;
+
 	vma_set_file(vma, file);
 
 	scoped_with_creds(ctx->cred) {
-- 
2.53.0




