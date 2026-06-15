Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708523542F4
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 14:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781534774; cv=none; b=AiYTGxvBwtPc/dMANOY99qtDzQ3tDX2jDTyzChoX4hsH4BrfQScjiRMpRc/4yCMtxM4s+bENJdAb0/fNIjIY45O0cvhqSQZA9xVmS+mPZVk056wWP//F8xFkcbAaPVI5dSpzMIgIVdIPVDJEBpVWqqH2nqTRgQM5VIll2UFYznc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781534774; c=relaxed/simple;
	bh=cxfCRPuXLzFW1/3FPR4rC1XHt1wfYbhoG9a27BIPENc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=m79YD+7AkfS7dgg12+CzmVLZtPvurVWOL2QdDVOc86L1UTAge0/7ogooVF2iq+HeXK7a+L5fI/9e2rjcyuvWREe5A73nn7JOquX3OoH6UgYIN/iVefW7ZwUAk7rFLc7MgzsOW4U5XLf5Yo8srtkBF2b0sTZPShGDRxT7X2H1AVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZryZn86h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZryZn86h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704B91F000E9;
	Mon, 15 Jun 2026 14:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781534773;
	bh=hmwBhP/T4Gslw26Kh9dL6t4cKWB8WOkZvNH25OkrUJA=;
	h=Subject:To:Cc:From:Date;
	b=ZryZn86hxpHij5EfT+Diwut7J7Pd8E86SVVTPwabk6m5LclqgUg2NyxpiJY+fPWNw
	 qTlspqMpWWM6+NnGGQi7UoArs2zE/HUrpjdHHbfMyLLPfkJmIEQiM2ra4kQc1fljg+
	 rqXdYryBmsiP3DDrBZJbv3pirutWr4nKuOrb+XU8=
Subject: FAILED: patch "[PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in" failed to apply to 6.12-stable tree
To: jannh@google.com,brauner@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 15 Jun 2026 16:32:43 +0200
Message-ID: <2026061543-clavicle-quote-2f44@gregkh>
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
git cherry-pick -x 40ab6644b99685755f740b872c00ef40d9aa870e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026061543-clavicle-quote-2f44@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40ab6644b99685755f740b872c00ef40d9aa870e Mon Sep 17 00:00:00 2001
From: Jann Horn <jannh@google.com>
Date: Wed, 3 Jun 2026 21:31:57 +0200
Subject: [PATCH] fhandle: fix UAF due to unlocked ->mnt_ns read in
 may_decode_fh()

may_decode_fh() accesses mount::mnt_ns without holding any locks; that
means the mount can concurrently be unmounted, and the mnt_namespace can
concurrently be freed after an RCU grace period.

This race can happens as follows, assuming that the mount point was
created by open_tree(..., OPEN_TREE_CLONE):

thread 1            thread 2            RCU
                    __do_sys_open_by_handle_at
                      do_handle_open
                        handle_to_path
                          may_decode_fh
                            is_mounted
                              [mount::mnt_ns access]
                            [mount::mnt_ns access]
__do_sys_close
  fput_close_sync
    __fput
      dissolve_on_fput
        umount_tree
        class_namespace_excl_destructor
          namespace_unlock
            free_mnt_ns
              mnt_ns_tree_remove
                call_rcu(mnt_ns_release_rcu)
                                        mnt_ns_release_rcu
                                          mnt_ns_release
                                            kfree
                            [mnt_namespace::user_ns access] **UAF**

Fix it by taking rcu_read_lock() around the mount::mnt_ns access, like
in __prepend_path().
Additionally, document the semantics of mount::mnt_ns, and use WRITE_ONCE()
for writers that can race with lockless readers.

This bug is unreachable unless one of the following is set:

 - CONFIG_PREEMPTION
 - CONFIG_RCU_STRICT_GRACE_PERIOD

because it requires an RCU grace period to happen during a syscall without
an explicit preemption.

This doesn't seem to have interesting security impact; worst-case, it could
leak the result of an integer comparison to userspace (from the level
check in cap_capable()), cause an endless loop, or crash the kernel by
dereferencing an invalid address.

Fixes: 620c266f3949 ("fhandle: relax open_by_handle_at() permission checks")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
Link: https://patch.msgid.link/20260603-vfs-fhandle-uaf-fix-v2-1-d05db76a5084@google.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 642e3d569497..1ca7eb3a6cb5 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -285,6 +285,19 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
 	return 0;
 }
 
+static bool capable_wrt_mount(struct mount *mount)
+{
+	struct mnt_namespace *mnt_ns;
+
+	/*
+	 * For ->mnt_ns access.
+	 * The following READ_ONCE() is semantically rcu_dereference().
+	 */
+	guard(rcu)();
+	mnt_ns = READ_ONCE(mount->mnt_ns);
+	return ns_capable(mnt_ns->user_ns, CAP_SYS_ADMIN);
+}
+
 static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 				unsigned int o_flags)
 {
@@ -320,8 +333,7 @@ static inline int may_decode_fh(struct handle_to_path_ctx *ctx,
 	if (ns_capable(root->mnt->mnt_sb->s_user_ns, CAP_SYS_ADMIN))
 		ctx->flags = HANDLE_CHECK_PERMS;
 	else if (is_mounted(root->mnt) &&
-		 ns_capable(real_mount(root->mnt)->mnt_ns->user_ns,
-			    CAP_SYS_ADMIN) &&
+		 capable_wrt_mount(real_mount(root->mnt)) &&
 		 !has_locked_children(real_mount(root->mnt), root->dentry))
 		ctx->flags = HANDLE_CHECK_PERMS | HANDLE_CHECK_SUBTREE;
 	else
diff --git a/fs/mount.h b/fs/mount.h
index e0816c11a198..5c120f8361bd 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -71,7 +71,15 @@ struct mount {
 	struct hlist_head mnt_slave_list;/* list of slave mounts */
 	struct hlist_node mnt_slave;	/* slave list entry */
 	struct mount *mnt_master;	/* slave is on master->mnt_slave_list */
-	struct mnt_namespace *mnt_ns;	/* containing namespace */
+	/*
+	 * Containing namespace (active or deactivating, non-refcounted).
+	 * Normally protected by namespace_sem.
+	 * Can also be accessed locklessly under RCU. RCU readers can't rely on
+	 * the namespace still being active, but implicitly hold a passive
+	 * reference (because an RCU delay happens between a namespace being
+	 * deactivated and the corresponding passive refcount drop).
+	 */
+	struct mnt_namespace *mnt_ns;
 	struct mountpoint *mnt_mp;	/* where is it mounted */
 	union {
 		struct hlist_node mnt_mp_list;	/* list mounts with the same mountpoint */
diff --git a/fs/namespace.c b/fs/namespace.c
index fe919abd2f01..f5905f4ec560 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1079,7 +1079,7 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	bool mnt_first_node = true, mnt_last_node = true;
 
 	WARN_ON(mnt_ns_attached(mnt));
-	mnt->mnt_ns = ns;
+	WRITE_ONCE(mnt->mnt_ns, ns);
 	while (*link) {
 		parent = *link;
 		if (mnt->mnt_id_unique < node_to_mount(parent)->mnt_id_unique) {
@@ -1434,7 +1434,7 @@ EXPORT_SYMBOL(mntget);
 void mnt_make_shortterm(struct vfsmount *mnt)
 {
 	if (mnt)
-		real_mount(mnt)->mnt_ns = NULL;
+		WRITE_ONCE(real_mount(mnt)->mnt_ns, NULL);
 }
 
 /**
@@ -1806,7 +1806,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 			ns->nr_mounts--;
 			__touch_mnt_namespace(ns);
 		}
-		p->mnt_ns = NULL;
+		WRITE_ONCE(p->mnt_ns, NULL);
 		if (how & UMOUNT_SYNC)
 			p->mnt.mnt_flags |= MNT_SYNC_UMOUNT;
 

