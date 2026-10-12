Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234C4AB1B8
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819720; cv=none; b=AoBe7D2uJgasCqwMKVNlc45VznTr0VDBnHEjpKB7Z2+ZchQdvBoeNyhWu2PP7TEzw3tvIyD9YIZqqlVe4bolxZ8yu1RtrisQiSOkm2MVfmJuLdss8ggA5sR2bRdUKIeDzpHe18vEb0soDZ6WeiXsQxqaoFUyz1z37ZHgnQ0R/CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819720; c=relaxed/simple;
	bh=VG8gm+1W+pArjaCgrHivtChCZxnVdmEF8dagxEoKqJo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=axRYIwYutOZ7DYc61Yj/SWLOU/yTx9/yJpNYA3tj0wybuuaF/WhdECPNUUfpiONcU+WtQkmATSLHSLD6zOsMdR+E4nA8GqMfn1SW40u1Ozby9KuzJuNqH3VI24xVXIncyBYFd52JJCPw+btGq3D9+3OWNS38d4j83q02W9euGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ce/jnkXF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ce/jnkXF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3051F0089B;
	Mon, 12 Oct 2026 15:41:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819719;
	bh=SQhUNL4NB2d3gJq6ARcp2pkeqnfIr7v3BFH/pqYxwF8=;
	h=Subject:To:Cc:From:Date;
	b=ce/jnkXFQBe8ZVU3IPEtePt5eILuqA59+l2gPMjCJM6Enb+RKHqnnDtWXlwBWVOL1
	 PRKHntYZ/70eEuSJvvfw+PWFYokx+tCscKjz+zgKkK0jKveS7ZH7xnKR3L8Pm0E/76
	 xX5MZtmWRBe5bOnAgJKCV+63HczDqhJqN+JXoZvk=
Subject: FAILED: patch "[PATCH] namespace: don't inherit MNT_UMOUNT in clone_mnt()" failed to apply to 6.6-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:39:18 +0200
Message-ID: <2026101218-daybed-book-3e2f@gregkh>
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
git cherry-pick -x e2c6d326216642011da318b9edfd5d57ebd5a56f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101218-daybed-book-3e2f@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e2c6d326216642011da318b9edfd5d57ebd5a56f Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:26 +0200
Subject: [PATCH] namespace: don't inherit MNT_UMOUNT in clone_mnt()

MNT_UMOUNT gets raised on a mount that umount_tree() or umount_one() has
taken out of its namespace. It's never cleared. __detach_mounts()
unhooks a mount that carries it instead of unmounting it.

disconnect_mount() lets an unmounted child stay attached only if its
parent carries it. propagate_umount() takes it as the sign that a mount
is going to be unmounted when it decides what else can be unmounted,
where a chain of locked mounts ends and where a for reparenting an
overmount.

clone_mnt() copies the flags of the source and only masks
MNT_INTERNAL_FLAGS which doesn't include MNT_UMOUNT. A mount that was
lazily unmounted but is kept alive by a file descriptor can still be
copied when its root is an nsfs or pidfs file because may_copy_tree()
accepts those before checking whether the source is mounted at all:

  mount --bind /proc/self/ns/net /tmp/x
  exec 3< /tmp/x
  umount -l /tmp/x
  mount --bind /proc/self/fd/3 /tmp/y

The mount on /tmp/y is attached to the caller's namespace with
MNT_UMOUNT already set and every copy of it inherits the flag again.

That causes a number of bugs:

- Unlink its mountpoint from a mount namespace where it isn't one.
  __detach_mounts() takes it for a mount that was unmounted earlier,
  unhooks it from its parent and drops the reference the namespace
  holds on it. It stays in the namespace with one reference too few
  and as its own parent, so it can't be unmounted through the file
  descriptor anymore and the namespace never finds it again. When the
  namespace goes away it's leaked and points to a freed struct
  mnt_namespace that may_change_propagation() and anon_ns_root() read
  on the next propagation change or mount_setattr() through the file
  descriptor.

- Make it shared and unmount a peer. trace_transfers() follows the
  flag from the peer into it and strips it from its peer group.

- Let a propagated umount reach it. gather_candidates() marks it with
  T_UMOUNT_CANDIDATE but never puts it on the candidate list, so the
  mark is never cleared and every later propagated umount skips it. If
  it's the parent of a locked mount handle_locked() takes it as the
  cutoff and commits the locked child that should have stayed and
  disconnect_mount() leaves that child attached to it, unmounted under
  a mounted parent, which is what disconnect_mount() exists to
  prevent. When the namespace goes away umount_tree() visits the child
  a second time. And once __detach_mounts() has made it its own parent
  reparent() never finds the end of the chain of unmounted parents.

A clone is a new mount that has never been unmounted. Add MNT_UMOUNT
to MNT_INTERNAL_FLAGS so clone_mnt() never copies it. And warn when
umount_tree() reaches a mount that already has it set.

Fixes: 590ce4bcbfb4 ("mnt: Add MNT_UMOUNT flag")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260926-work-mount-fixes-2-v1-3-f357abf3d17b@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index d1e8dd2e1e8e..6d4ecde682df 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1799,6 +1799,8 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 
 	/* Gather the mounts to umount */
 	for (p = mnt; p; p = next_mnt(p, mnt)) {
+		/* A mount is unmounted once. */
+		VFS_WARN_ON_ONCE(p->mnt.mnt_flags & MNT_UMOUNT);
 		p->mnt.mnt_flags |= MNT_UMOUNT;
 		if (mnt_ns_attached(p))
 			move_from_ns(p);
diff --git a/include/linux/mount.h b/include/linux/mount.h
index acfe7ef86a1b..b16ba5d45605 100644
--- a/include/linux/mount.h
+++ b/include/linux/mount.h
@@ -52,7 +52,7 @@ enum mount_flags {
 	MNT_ATIME_MASK = MNT_NOATIME | MNT_NODIRATIME | MNT_RELATIME,
 
 	MNT_INTERNAL_FLAGS = MNT_INTERNAL | MNT_DOOMED |
-			     MNT_SYNC_UMOUNT | MNT_LOCKED
+			     MNT_SYNC_UMOUNT | MNT_LOCKED | MNT_UMOUNT
 };
 
 struct vfsmount {

