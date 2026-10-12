Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8478E223DE7
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820709; cv=none; b=gJ763uCORVoI0ixb+vSHAQC7hkBsKro7X6NjFzI3BTYz8vi3wujwIpg/YX14gx2VAjehvTifHEq0uYHrsLYUSj+i5g+0GUXi2IvPhKFg65c1v0Kcs05Bh+pwZLmKd1THT7iwvPj5lvD76EWoJxBo/BG8FsrjG4syo3DBckUsiU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820709; c=relaxed/simple;
	bh=Yo4M/SoWuFwUlg78AA/DUMu6wIewCNJb3UKWtx1kiHs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZaDqEFES9FuiWQQ1W7T4LnSjXm/ObQSAtWv5vK+MKP3NOb6yoTJwb534lqt6zR+WUDqjUMwPDhLqV1dlDDKOBHGjaHVNw9qUyXjyH3BIv9dYmQEB040+kcIsZ5nBmruS91ZHnYhmV+8DEr7ZXCgVDblnKlfmxFqoIxwoXNxXxEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YFV7Hjqh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YFV7Hjqh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D08A71F0089B;
	Mon, 12 Oct 2026 15:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820708;
	bh=V9vKL8nA1CNgLcBJ9rcjwgFz6w36ABQ+NKc3leuQPs0=;
	h=Subject:To:Cc:From:Date;
	b=YFV7HjqhoOIMiToAL8kFih/eHvKUIdj5Aot+fo5FysppZB5thX6tJAXVEj6DjC+J3
	 y1b6BZDVDcVpc+uhbqFn5Y+8pmgdnQD31uhNqeHvPXeSub1CUfrC6qdDQhxUxBRsyC
	 Yuvh4rIziHp4lvqxVGFIXculgKFd+rhL8pykEcnc=
Subject: FAILED: patch "[PATCH] namespace: never expire a locked mount" failed to apply to 6.6-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:58:25 +0200
Message-ID: <2026101225-sudoku-conform-c790@gregkh>
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
git cherry-pick -x f78ddcc872248c7aa1d7e904928441a0be4c6d5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101225-sudoku-conform-c790@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f78ddcc872248c7aa1d7e904928441a0be4c6d5d Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 2 Oct 2026 15:52:39 +0200
Subject: [PATCH] namespace: never expire a locked mount

Locked mounts are special. They protect the underlying files and
directories from being revealed. do_umount() refuses to unmount locked
mounts but shrink_submounts() doesn't.

A shrinkable mount can become locked once the owner of a user namespace
puts it beneath a locked mount with MOVE_MOUNT_BENEATH. The locked
property now moves to the mount at the bottom making it possible to
unmount the top mount.

So umount() of an unlocked ancestor now expires the bottom mount first
and the covered directory is revealed:

  move_mount(c -> x/hidden, MOVE_MOUNT_BENEATH) = 0
  the cover after the lock moved:  umount2(x/hidden) = 0
  the holder of the lock:          umount2(x/hidden) = EINVAL
  the root of the copy, busy:      umount2(x) = EBUSY
  reads x/hidden/secret: "covered-by-root"

So leave a locked mount alone as it dies together with its parent. A
plain umount() of an unlocked mount with a locked one below it is EBUSY
from now on. It's the same for any other locked child. A lazy umount
still takes the whole tree.

mark_mounts_for_expiry() never sees a locked mount. lock_mnt_tree()
leaves a mount on an expiry list alone and nothing else puts a locked
one on such a list. Add an assert for this.

Fixes: 5ff9d8a65ce8 ("vfs: Lock in place mounts from more privileged users")
Fixes: c62a4766937e ("move_mount: transfer MNT_LOCKED")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261002-work-mount-fixes-4-v1-8-dd44b89d44ce@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index 27bf8665ed58..e74e63466c24 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4032,6 +4032,8 @@ void mark_mounts_for_expiry(struct list_head *mounts)
 	list_for_each_entry_safe(mnt, next, mounts, mnt_expire) {
 		if (!is_mounted(&mnt->mnt))
 			continue;
+		/* lock_mnt_tree() leaves expirable mounts alone */
+		VFS_WARN_ON_ONCE(IS_MNT_LOCKED(mnt));
 		if (!xchg(&mnt->mnt_expiry_mark, 1) ||
 			propagate_mount_busy(mnt, 1))
 			continue;
@@ -4058,7 +4060,8 @@ EXPORT_SYMBOL_GPL(mark_mounts_for_expiry);
  */
 static bool shrink_submount(struct mount *mnt)
 {
-	if (propagate_mount_busy(mnt, 1))
+	/* not the kernel's to remove either */
+	if (IS_MNT_LOCKED(mnt) || propagate_mount_busy(mnt, 1))
 		return false;
 	touch_mnt_namespace(mnt->mnt_ns);
 	umount_tree(mnt, UMOUNT_PROPAGATE|UMOUNT_SYNC);

