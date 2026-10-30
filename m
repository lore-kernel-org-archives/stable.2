Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793375762;
	b=byJfrVORJCSOd2Uk4efvowEd0vpeoWg3YEyNr6b25TCoPnjNoxkIQAvJ6qrN+t5tUv9M
	 nobjGzaCv+IQtntjrl++ja/uwMdk+qxLc3IWQtctss79/vDgbMZpGp2RRama+hxjIzIoC
	 3Ch0Kjv86lkVPNCIpssaEfAlGhPUkqhIMVFBe8H82Tlez42V8vzw6T8gObrsXGY48A7KX
	 cgVG8BzY3i7X0zLDdYVKsqcQmwIkyaY7afvKc3dXGyrSs5Vdmd+OIvvEpYgr2D1vi+pkZ
	 DeRazjKhTQMhOvt/o66YHqqBpG/qRN7XG1elRtYIbw+Wzo3ElrHh7gScG7BMhZBbOew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793375762;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=OLB/pPnAIIk2q96c36n8ii4RGtN4TNNruaHmv/xG850=;
	b=pTibVex5AavmMsswUza0ava8G0mqVK/govL5/cNUzm9+cFSXsfx3uR5sPDnlZLCYvNoG
	 o9LDw/xJ3opYksKH7EHk5azH1pIspeekC1I69gkQJ9ifp6pxql2s63T3gX3PBEHXAdIie
	 G/Yu91wpv3EDaEoJ2C94Hv5qFvMRUpCvgFMwJpXwu60MkZpIxugUtV7jBVv0Qj1dud9FA
	 kg8p5sM6laG8AnLTodNo8J+3CPKvYK5ZBPP6f+MR1uUfKr41Be3iP/tGq1ufUnwg9P8qt
	 AMkI9wyouiedlvHaKw0kNwP+X3ZBkzNeS7iW0p0HeKpZvBLOHmPa1gPcvzwTJRWnT3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gu+NrYjv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C73606A31C;
	Fri, 30 Oct 2026 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gu+NrYjv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BEB11F000C1;
	Fri, 30 Oct 2026 15:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793375761;
	bh=OLB/pPnAIIk2q96c36n8ii4RGtN4TNNruaHmv/xG850=;
	h=From:Date:Subject:To:Cc;
	b=gu+NrYjvtx8Os15tkJhMPWl6gxwEbofxtoe1MEaaZ3FLv11miajhNLq6GOYJ2H2P8
	 wxGCWjKgvlIkBIBYFALJM75k/eatvHsTu/1OIW0BOJsJavyye4yWrd6avw40I/CED+
	 5Cupkwl0BIo5Do11Lhgg3R6JWchuc8M61goqzIM0lJ5sqMar6v0QYuX0RHrcQyVPTK
	 P6sutRqrbLiOFLTtxIXJkZIkb4TZ3wuixU2ZVgcfdOcZtJBMAqBU1e0WEV3omJ1Bpu
	 kkO6e6D3AQbRN9VBDHjzst2lXT1r5fvr5oc5G0Lq4vqY4vA7I4cZIbC4WxxDGCcL1A
	 nIHb4CzyjNMhg==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 16:55:52 +0100
Subject: [PATCH] fs: don't fail __d_obtain_alias() for unlinked inodes
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-work-dcache-obtain_alias-v1-1-a1f7e44536d2@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMUQ7CIBAFr9LwLYYWo8arGGN2YZFVA4at1aTp3
 QX7OS9vZlZChUnUqZtVoYmFc6rQbzrlIqQbafaV1WCGfW+s0Z9cHto7cJF0xhE4XeHJIBqN9QG
 PO7KHoKr+KhT4+0+fLyvLG+/kxtZrDwQhjQWSi22agmxXY1l+JeoTgpgAAAA=
X-Change-ID: 20261030-work-dcache-obtain_alias-b03dfb84e37f
To: Amir Goldstein <amir73il@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, 
 Daehyeon Ko <4ncienth@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=5614; i=brauner@kernel.org;
 h=from:subject:message-id; bh=7CkDPptf5GKXAUEwHygW7KJbUOkaX22YmoFnT7Y0qCw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ92cebYJ8e+PqLxR6hUAUjLZ8piXPerC+5Hm9zxfjRm
 s77U6dqdZSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExk1j5GhjMVbsfcjmQz/NK+
 9VDwxxbZDUoWByatNhX2v31nwpSCjZ0Mv1mEVNTMGpnPL1Sr+aBdMyVMxeT702qZxNma3/u+mrR
 u4gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

From: Amir Goldstein <amir73il@gmail.com>

Commit 669bb5af15d4 ("fs: make sure to call fsnotify_inoderemove() only
once when inode is dead") did two things. It made dentry_unlink_inode()
call fsnotify_inoderemove() only once the inode has neither links nor
aliases left. And it made __d_obtain_alias() fail with -ESTALE for an
inode in that state so that open_by_handle_at() can't create a new alias
after FS_DELETE_SELF has been reported and the inode marks are gone.

The second part is wrong for network filesystems. __d_obtain_alias()
backs d_obtain_alias() and d_obtain_root(). Those are what the
->fh_to_dentry() and ->get_parent() methods use to turn the inode they
looked up into a dentry for exportfs_decode_fh_raw(), i.e., for
open_by_handle_at() and for nfsd file handle decoding.

For a local filesystem an in-core inode without links and aliases is an
orphan that goes away on the final iput(). For a network filesystem
that's not true. i_nlink is just the link count the server last
reported and whether the object is still reachable through its file
handle is up to the server. If a file is unlinked while it is still
open elsewhere, e.g., by another NFSv4 client or by a process on the
server, the server keeps the object alive and its file handle stays
valid. nfs_fh_to_dentry() fetches the attributes for such a handle,
nfs_fhget() sets i_nlink to 0 from them, the new inode has no aliases
yet and so __d_obtain_alias() now fails with -ESTALE. The same applies
to fuse_get_dentry() which takes i_nlink from the fuse server.
Filesystems that care about unlinked inodes already make that decision
themselves in ->fh_to_dentry(), e.g., ceph's __fh_to_dentry() fetches
the link count with CEPH_CAP_LINK_SHARED and only refuses an unlinked
inode if it isn't open.

Note that on a network filesystem i_nlink drops to zero through
attribute updates when another client unlinks the file. So the inode
might never have gone through dentry_unlink_inode() with i_nlink == 0,
i.e., fsnotify_inoderemove() might never have been called for it and
there's nothing for the -ESTALE to protect.

So drop the two checks from __d_obtain_alias() again and go back to the
unconditional alias lookup. While at it, update the comment above
inode_notify_dead() since it no longer blocks new aliases.

Amir sent this as v3 to replace 669bb5af15d4 but that commit was already
in mainline by then. So do it as a fix on top. The resulting code is
identical to v3.

This means open_by_handle_at() can again create a new alias for an
unlinked inode after FS_DELETE_SELF has been reported. Closing that file
reports a second FS_DELETE_SELF and the file has none of the inode marks
that were torn down. That's what Daehyeon's open_by_handle_at() LTP test
checks so it is expected to fail again. This needs to be handled
separately. A mark that is added through such a file while
fsnotify_destroy_marks() is still running is rejected with -ENOENT since
36ebddca56b9 ("fsnotify: prevent mark additions during connector
teardown") so it can't end up on a detached connector.

Christian Brauner <brauner@kernel.org> says:

Amir's v3 replaced 669bb5af15d4 as a whole. I turned it into an
incremental fix on top of mainline and wrote a new commit message.
Jan's Reviewed-by was given on v3 and the resulting code is identical.

Fixes: 669bb5af15d4 ("fs: make sure to call fsnotify_inoderemove() only once when inode is dead")
Cc: stable@vger.kernel.org
Reported-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Link: https://patch.msgid.link/CAOQ4uxg7Qt436SiKhKEJKOjtCjeB_XyTjazYF7HMyQAGGcgx2A@mail.gmail.com
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/dcache.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index efd9332c8407..810ac48ae753 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -452,10 +452,9 @@ static void dentry_free(struct dentry *dentry)
 }
 
 /*
- * If inode is unlinked and doesn't have any aliases (i.e., all fds pointing to
- * it are closed), it is pretty much dead. Except that file handle lookup could
- * still revive it which causes issues to fsnotify. So once inode reaches this
- * state we make sure to block creating any new aliases.
+ * When inode is unlinked and doesn't have any aliases (i.e., all fds pointing
+ * to it are closed) we report FS_DELETE_SELF to fsnotify and cleanup all inode
+ * marks.
  */
 static bool inode_notify_dead(struct inode *inode)
 {
@@ -2312,12 +2311,7 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 
 	sb = inode->i_sb;
 
-	spin_lock(&inode->i_lock);
-	if (!inode_notify_dead(inode))
-		res = __d_find_any_alias(inode);	/* existing alias? */
-	else
-		res = ERR_PTR(-ESTALE);
-	spin_unlock(&inode->i_lock);
+	res = d_find_any_alias(inode); /* existing alias? */
 	if (res)
 		goto out;
 
@@ -2329,10 +2323,7 @@ static struct dentry *__d_obtain_alias(struct inode *inode, bool disconnected)
 
 	security_d_instantiate(new, inode);
 	spin_lock(&inode->i_lock);
-	if (!inode_notify_dead(inode))
-		res = __d_find_any_alias(inode);	/* recheck under lock */
-	else
-		res = ERR_PTR(-ESTALE);
+	res = __d_find_any_alias(inode); /* recheck under lock */
 	if (likely(!res)) { /* still no alias, attach a disconnected dentry */
 		unsigned add_flags = d_flags_for_inode(inode);
 

---
base-commit: b44341e39d856e4cc6ad8ed94ebffd440f39846c
change-id: 20261030-work-dcache-obtain_alias-b03dfb84e37f

