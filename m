Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE1FA3750D5
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820719; cv=none; b=A5R1PzwAYCki8c29yUrv2tckJ+HpbDmwBCwvRqrkcMKZfKpoGGzJK3etK/tovGxpp22j5EUXlTHCatIuaOQ0vaAiCpJ9QtJ90N03TBHIijUtTceG+YaVjSEf9524RacCYH+FTdwQIdAm0TMUJ4lzSE6PscA3V9FL3oA+8bt9zPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820719; c=relaxed/simple;
	bh=iHLxTUhyGoQfs6TI3Y89sHIBKb11EyVG6eKFTNWnD3M=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pvmnFHTGuNlru47J80iWIZI4FuU04NWJ9bWE4baOdXnXBN/e1wqW4KMbwIbR0teNmkNMqMKjhKHvEu8humfoyJGprFzkbAghNa6N1cK4mAIB7AYX+VahzptlF1gQAqRP8Di9lP6MP/Ib1V6NUkuv8ORyj606xlYII4uXAm6K398=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AuI3414P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AuI3414P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEEC61F0089B;
	Mon, 12 Oct 2026 15:58:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820717;
	bh=xs+Mr7kG64Waj6k84S+9unwn2GNRXhslqXIKuHnETz4=;
	h=Subject:To:Cc:From:Date;
	b=AuI3414PO6lM1/dHwqL6jBQjch3hpPzWFOnbBBjqxIPOHwXQ9Kim16ygttfLDXlcd
	 Hqge34XpVwp5DgXkwwCnAG1VGj0O8mzsvXpyTjKYgUSMsrY5ZqJE075n8dnudcI6oC
	 +CI/r9/PPqHQx2MPvrd+W7vWSFOEKC4eXBemz8FQ=
Subject: FAILED: patch "[PATCH] namespace: never expire a locked mount" failed to apply to 5.10-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:58:27 +0200
Message-ID: <2026101227-ankle-pesticide-7a90@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x f78ddcc872248c7aa1d7e904928441a0be4c6d5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101227-ankle-pesticide-7a90@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

