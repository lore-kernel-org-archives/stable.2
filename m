Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED504A6888
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819967; cv=none; b=hz2+cNlFU3EJMeL2QVxba1PcmL2s0EiJd2D6n93cgwqreRMjtC5mhU4Ld1aMQG4jPmb1MOAlspOAdDHnojvYh/cBAmQN4Qd9lgs2rHVp+UFP0f8lzWctjlY5gNjPuLZ1ejbB+UBRpJzdzwx05vZ0/XbRLHyUA4DqoF4nZNSLmaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819967; c=relaxed/simple;
	bh=/35lBtdVlQmQWJW2IX6ChuhsuIxkIM3fyhNbG7WbXao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q3zdwu6Q/7OpVRwL6kbP/QGWsgO1fRrz4XNNlO0qDY0xgIFPEMlDf4l8SHOmiAWJNZa+2t3J7qfn/mv/nq3dIiWzk29If6z4fckA5AUMTzZlBg0iPihmGQl86KcFFHdBEGIT+6ww9Q1UDZKLINNCVtP9z0QQnxfXRqnWTKQTVmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CVh+vI5Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CVh+vI5Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 266D71F0089B;
	Mon, 12 Oct 2026 15:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819965;
	bh=OPZ50Phjnx5t6g2Eo8u+JcYcs6EqSgm/9fVvmRRMUJI=;
	h=Subject:To:Cc:From:Date;
	b=CVh+vI5QlLCN9zQwMDO64ZzjwrpyQjMsMnDNlHr23QJMwyhyRB+0vNWPuVU7v0/xD
	 hcMecAEOu28fekss2/GynlntNSJKdgGcxd9p4QEP/TUWmWaMOH+vqz0h2nRIEdAA9s
	 GNeQ0/SZQJRytgSTQr47KVOX8tMrCaEX9abE1Fzw=
Subject: FAILED: patch "[PATCH] namespace: check the target before walking it in" failed to apply to 5.15-stable tree
To: brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:46:10 +0200
Message-ID: <2026101210-barge-alkalize-e6de@gregkh>
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
git cherry-pick -x 08f4288a37ef4b3d19b4a9599ec3048219cac828
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101210-barge-alkalize-e6de@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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
 

