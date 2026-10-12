Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64C3750D5
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791820733; cv=none; b=rU1ArJp24NTcqSttcwfET3XQ0WZvGqkGez4Ifqd23BAV+DuOFJ44HWF3sTOMVVLFA31Xs8TnfqL1A7C3LvNpPZQFySGIZ7Gy367lIebjYvZ9ckg1Ah90BUxMpWhc4zYdmAYcksFYzDXQUtue7Y+P1D3dnBPEA0JBDFzv4z56lGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791820733; c=relaxed/simple;
	bh=pbEu3JSoE8ZVobKBilbP73jf32g6qObw3BiQ37Zx9M4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EAZ4kAgB63CjzquaaqeoC8Qo+CIqZFPS7SnwPahOKIOSTuZmGAl6jw035nn0nH7Ngl0s+RvXWcugHOrSOLU6xKlv+CEAda8ixFJW3q2Lf3qJ2ZGTOskUth9weXAvDiVNW2SNiAQh83ofCbxI58nBorEfco1BNXTcSK+VVUegKts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bmUW3SYu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bmUW3SYu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2629C1F0089B;
	Mon, 12 Oct 2026 15:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791820732;
	bh=4/fweObjkUGV6g3LUbz0xeB2+fdC8+FJcH4op17+P7M=;
	h=Subject:To:Cc:From:Date;
	b=bmUW3SYuSSNf9P3R+TL1yP8uvNmHXl5ZiAbGTjph2bB0xSfPl66Xg8GISbix0ZCw+
	 L+dhC5Zfebmr9LnoHfNJHMMZBvRzzPGWFQT0zkmzwEKFmIXGScHpacNINOdKHcZz03
	 DYm4QkUHRAI3PtyBb7wsy4YLZqgfug60AhDp0mCQ=
Subject: FAILED: patch "[PATCH] namespace: handle mount locking for automounts correctly" failed to apply to 5.15-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:58:53 +0200
Message-ID: <2026101253-pelvis-snuff-c746@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 33aadc7c72055fca93cb5a3691d836ebf8b31c9b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101253-pelvis-snuff-c746@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 33aadc7c72055fca93cb5a3691d836ebf8b31c9b Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 2 Oct 2026 15:52:37 +0200
Subject: [PATCH] namespace: handle mount locking for automounts correctly

If mounts are propagated across user namespaces, attach_recursive_mnt()
locks every copy of the source mount to protect overmounts from
vanishing and revealing the underlying files or directories.

The user namespace is taken from the caller's mount namespaces since
this is where the mounts end up. Except, that's not always true.
Automounts may legitimately get popped in by tasks located in a
different mount and user namespace during path lookup.

Then check doesn't make sense at that point. The copy in the namespace
of the parent - which may be the host's - is now locked and the host
cannot change the flags of its own mounts anymore.

Here's the reproducer:

- host has debugfs mounted nosuid,nodev,noexec and shared
- tracefs automount below it is not yet active
- hand a child process a directory descriptor on that mount
- child process enters auser and mount namespace
- child process' namespace now holds a locked copy of the host's debugfs
  mount that receives propagation from it
- child process stats "tracing/." through the descriptor
- lookup runs on the host's mount so the automount lands below the host's mount
- propagation puts a copy below the child's copy
- both try to clear the flags on the mount they got, with a bind remount:

    host, on its own automount:            MS_REMOUNT|MS_BIND = EPERM
    child, on the copy in its namespace:   MS_REMOUNT|MS_BIND = 0

So the lock landed on the host's mount instead of the child's copy.
Congrats. So we need to compare with the owner of the namespace the
mount actually gets mounted on. For all regular cases that is the
caller's mount namespace and so nothing changes.

Detached trees in anonymous mount namespaces by be handed over via
SCM_RIGHTS or inherited in other ways on purpose so the attaching task's
mount namespace is authoritative, not the creator of the detached tree.

Fixes: 132c94e31b8b ("vfs: Carefully propogate mounts across user namespaces")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261002-work-mount-fixes-4-v1-6-dd44b89d44ce@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index 60b57572fc64..27bf8665ed58 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2604,11 +2604,11 @@ enum mnt_tree_flags_t {
 static int attach_recursive_mnt(struct mount *source_mnt,
 				const struct pinned_mountpoint *dest)
 {
-	struct user_namespace *user_ns = current->nsproxy->mnt_ns->user_ns;
 	struct mount *dest_mnt = dest->parent;
 	struct mountpoint *dest_mp = dest->mp;
 	HLIST_HEAD(tree_list);
 	struct mnt_namespace *ns = dest_mnt->mnt_ns;
+	struct user_namespace *user_ns = ns->user_ns;
 	struct pinned_mountpoint root = {};
 	struct mountpoint *shorter = NULL;
 	struct mount *child, *p;
@@ -2617,6 +2617,22 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 	int err = 0;
 	bool moving = mnt_has_parent(source_mnt);
 
+	/*
+	 * A caller in an unprivileged mount namespaces may trigger an
+	 * automount and propagate locked mounts into privileged mount
+	 * namespaces. Take ownership from the target mount namespace.
+	 * It's equivalent for everything but the automount case.
+	 *
+	 * Detached trees in anonymous mount namespaces by be handed
+	 * over via SCM_RIGHTS or inherited in other ways on purpose
+	 * the attaching task's mount namespace is authoritative, not
+	 * the creator of the detached tree.
+	 */
+	if (is_anon_ns(ns))
+		user_ns = current->nsproxy->mnt_ns->user_ns;
+	else
+		user_ns = ns->user_ns;
+
 	/*
 	 * Preallocate a mountpoint in case the new mounts need to be
 	 * mounted beneath mounts on the same mountpoint.

