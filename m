Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C154C478E50
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 16:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627772; cv=none; b=U4s5kv10eRyT5gbi0W0tdfP1449AHtF2LonTqvhPTOP/vyKB7gDSvY+gGDNUtm19q7G8NwHzPbBEg1z2gN8hL9Z0J/nNw5tAuTDoc19pOR2W+qyrRzo/H536SRk/9+usX7gmYCXYIUXLsXU1rgNGjMPYbA7zIt9p798yyHTmfJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627772; c=relaxed/simple;
	bh=mfc6n0A7sbM0kjEl9/C74kqzhMmQRtaxLBOpW31w0YA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F0N7GkSAOX8OMS3lHTNGU/GgAoRf8r7JoF+tg/82iMRe92xT1sEDtc/3UXuyUn8qGPz4djHOLcZWOWUBQG4kkACydhctbgjfpGuJyw7XTiyp0XBxp+kjq/MY2FGAvJ+Ma3iIt5rJ9KrRcI2FNdsw3JG6X1eboQPSYBQYNN40OKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UMRSM2fF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UMRSM2fF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E08C1F00A3A;
	Tue, 16 Jun 2026 16:36:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781627771;
	bh=XF6QMOjZ2NqPiOjMU16ndMtHlK7HjWRu49qLw2B2K8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UMRSM2fFrTqLTlyox8S3mYWRci9Z0RdVAAick5kpGH1Xg2do57eeb27hScSRC+IeK
	 IlwNI+7vXKflQKMJm+EllxPp4ihGWCktYl4+mhIK/q606XAV0yP5/nR3jCDjtOHAPb
	 4gJDCTIRJp2uRhCWD5IrfCLT3oDlKWOYTpxZp7i9S1OG2JdqCj/13w1ndBNwy3SHTq
	 1W+Rn6Ego/HTDsCk815QnxtEF1dqxzdu73EmWO438sKpf8j5/8gsLcJlD8EWBygWWX
	 S4L7c6+sg9EWrizD5VvJhRsvteis1b0BLFc8Z1NATI2LOP6nzElpzPEeEX1RZ/fGRX
	 bSENzur4gPaoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] fhandle: fix UAF due to unlocked ->mnt_ns read in may_decode_fh()
Date: Tue, 16 Jun 2026 12:36:09 -0400
Message-ID: <20260616163609.3352096-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026061543-clavicle-quote-2f44@gregkh>
References: <2026061543-clavicle-quote-2f44@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit 40ab6644b99685755f740b872c00ef40d9aa870e ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fhandle.c   | 16 ++++++++++++++--
 fs/mount.h     | 10 +++++++++-
 fs/namespace.c |  6 +++---
 3 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/fs/fhandle.c b/fs/fhandle.c
index 38d803a28ab916..bbb5857c77b9b1 100644
--- a/fs/fhandle.c
+++ b/fs/fhandle.c
@@ -242,6 +242,19 @@ static int do_handle_to_path(struct file_handle *handle, struct path *path,
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
 /*
  * Allow relaxed permissions of file handles if the caller has the
  * ability to mount the filesystem or create a bind-mount of the
@@ -273,8 +286,7 @@ static inline bool may_decode_fh(struct handle_to_path_ctx *ctx,
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
index 179f690a0c7223..c3987f1d174982 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -58,7 +58,15 @@ struct mount {
 	struct list_head mnt_slave_list;/* list of slave mounts */
 	struct list_head mnt_slave;	/* slave list entry */
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
index df6d6a2c6b89cc..94c06c84290236 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1132,7 +1132,7 @@ static void mnt_add_to_ns(struct mnt_namespace *ns, struct mount *mnt)
 	struct rb_node *parent = NULL;
 
 	WARN_ON(mnt_ns_attached(mnt));
-	mnt->mnt_ns = ns;
+	WRITE_ONCE(mnt->mnt_ns, ns);
 	while (*link) {
 		parent = *link;
 		if (mnt->mnt_id_unique < node_to_mount(parent)->mnt_id_unique)
@@ -1493,7 +1493,7 @@ EXPORT_SYMBOL(mntget);
 void mnt_make_shortterm(struct vfsmount *mnt)
 {
 	if (mnt)
-		real_mount(mnt)->mnt_ns = NULL;
+		WRITE_ONCE(real_mount(mnt)->mnt_ns, NULL);
 }
 
 /**
@@ -1805,7 +1805,7 @@ static void umount_tree(struct mount *mnt, enum umount_tree_flags how)
 			ns->nr_mounts--;
 			__touch_mnt_namespace(ns);
 		}
-		p->mnt_ns = NULL;
+		WRITE_ONCE(p->mnt_ns, NULL);
 		if (how & UMOUNT_SYNC)
 			p->mnt.mnt_flags |= MNT_SYNC_UMOUNT;
 
-- 
2.53.0

