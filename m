Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917A44A4841
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819958; cv=none; b=ME1XZ/GhfrziHpEyDzY891KYlLG/seoyye0SkYjhJq0KmfqsH4xt5TLfQaHF5wkbAUAsC1X5z0LhTgkxu1ItwGnNuBOHdJeVZ9poWiQFw+Yh/Z9jOWE4056DmkaOloz94kIIKI7C5v5mjXSmJqGylZNViEAsVGyPcgAcXOzjJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819958; c=relaxed/simple;
	bh=8SsP0DSGqDBBpZJTb6X0Q5+R/1xG3J8LTUpbe3THt8c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qMR3A0Z1f6w1elx6z/dnVl8qUXYwLAUDZ6giwzRawiqetyOkeI0cK0vZZe8B6+GYgZBXz0jyhHJ8VDvXgVLpEpyXptu3AcAJqaYQO/vwO34lA6aFV2nRLCILQ+fF8A9+YURvM0QzQzX0wbFf+9Rr3Y+clXUehOmVxPw0Ci7k1xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CkeYq5Pl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CkeYq5Pl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 903BD1F0089D;
	Mon, 12 Oct 2026 15:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819957;
	bh=Is/Pfu2Yncm6gOyPBUvVOBVflVo+KWlxaTkGVYhpH7o=;
	h=Subject:To:Cc:From:Date;
	b=CkeYq5PlHOAZVZl9yfEIY1K51jVzzvt+iAubUkquQZgRNXg0VU82pvDAZQKzjGFqa
	 PD+1VZS2/qoANkLwN7auN6uRe+FSt7SjccE5Ra4V9eZo8URGU9EVPsYTsCj0IUZ2rm
	 sBcwsdKP9wpp0VRi2qeEvYu87GsITTzanwxBkBbs=
Subject: FAILED: patch "[PATCH] namespace: check the target before walking it in" failed to apply to 6.6-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:46:01 +0200
Message-ID: <2026101201-thrower-fascism-1179@gregkh>
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
git cherry-pick -x 08f4288a37ef4b3d19b4a9599ec3048219cac828
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101201-thrower-fascism-1179@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 08f4288a37ef4b3d19b4a9599ec3048219cac828 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Sat, 26 Sep 2026 15:44:28 +0200
Subject: [PATCH] namespace: check the target before walking it in
 do_mount_setattr()

When mount_setattr() changes the propagation type to MS_SHARED
do_mount_setattr() takes namespace_sem and calls invent_group_ids()
which walks the whole target tree with next_mnt() and allocates a peer
group id for every mount that doesn't have one.

Whether the caller may touch the target at all is only checked
afterwards under mount_lock. If it may not, cleanup_group_ids() walks
the tree a second time on the way out to free the ids again.

A detached tree that a file descriptor keeps alive, a mount in another
mount namespace or a mount below the root of an anonymous mount
namespace does a bunch of allocation work that is completely useless
because it will fail and revert right after.

Do the right thing and check the target right after taking namespace_sem
instead. A mount leaves its namespace only under namespace_sem so the
mount stays stable. The check under mount_lock stays for the case where
no propagation change is requested and namespace_sem isn't taken.
Callers get the same EINVAL as before.

Fixes: 2a1867219c7b ("fs: add mount_setattr()")
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260926-work-mount-fixes-2-v1-5-f357abf3d17b@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/namespace.c b/fs/namespace.c
index c7e252eb249e..de28fe9058ab 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4976,6 +4976,11 @@ static int do_mount_setattr(const struct path *path, struct mount_kattr *kattr)
 		 * propagation.
 		 */
 		namespace_lock();
+		/* invent_group_ids() walks the tree, only walk a mounted one */
+		if (!anon_ns_root(mnt) && !check_mnt(mnt)) {
+			namespace_unlock();
+			return -EINVAL;
+		}
 		if (kattr->propagation == MS_SHARED) {
 			err = invent_group_ids(mnt, kattr->kflags & MOUNT_KATTR_RECURSE);
 			if (err) {
@@ -4988,6 +4993,7 @@ static int do_mount_setattr(const struct path *path, struct mount_kattr *kattr)
 	err = -EINVAL;
 	lock_mount_hash();
 
+	/* Checked under namespace_sem already if the propagation changes. */
 	if (!anon_ns_root(mnt) && !check_mnt(mnt))
 		goto out;
 

