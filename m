Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6A24A387F
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820701; cv=none; b=hWW5ypaXTd/uQ+Q7T/Rp9oCvh3SCy8wMtH9V4Z4iOaQrU7Gn/Mem3nLcoE6XKCxguERnGoiebMmtiVc8wIVxNBYUeiA/Ag1fzPrp2KhCZEJbFadOP5ihVIJoIZgWKJA11Y3UtMYLUW53k6KLIkPNMpS6vCcymDE89UVKVKkTUmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820701; c=relaxed/simple;
	bh=wwIzqpIgKPY5aMtcJ2ti9U/JFJV2K/m7FtWgRsTtT6g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Rkzb8Qq0yUUcfLUEUjgZeF46Tbtf+B57NgZOpMaIwxkmuQA3z77RaWf4PRpXw93GezRelB/bKGShMas8flMN5mnbU7SB9uAFdp5ctXzXULx4nJa1SxRvGlONPR2i7OKQRCN+hlbe0OGxPpH+Mvolf5yIg4jauvndaZJr7qhn+XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n/1EuCIE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n/1EuCIE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B421F0089B;
	Mon, 12 Oct 2026 15:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820700;
	bh=OkB/w9+wZvaTrNfLODLh/7ytfXIvNlRjtwCypwj77Ds=;
	h=Subject:To:Cc:From:Date;
	b=n/1EuCIEQqy7Cg++KLnr+LlxjCBqt3Sj4eXQfGiP3yTp6hrkndCWi6q8A88SlDvNZ
	 ln9AI0sl4/lV5EjHvq7/H/7yP833R/DJb5Gy7D556N+rH7DecNa+XcSx6x6U+wx+ru
	 jij83+Zsn9W1ST2rtXVFOP4QZ5G4X5iXRI7rJfj0=
Subject: FAILED: patch "[PATCH] namespace: never expire a locked mount" failed to apply to 6.12-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:58:25 +0200
Message-ID: <2026101225-upon-doorknob-a385@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x f78ddcc872248c7aa1d7e904928441a0be4c6d5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101225-upon-doorknob-a385@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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

