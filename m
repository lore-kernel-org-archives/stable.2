Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606099;
	b=DCR94GcpdIxsZYfXhhAVCaLMSxZEZkHs0gujwxFEF1dH7WGlHc0kTX9X1xJOLM/eGHvC
	 lRdWeoDz3J8Xpz+LdO5TFGdY0yJ5S768v9tE4OZJtZdgcUbPuF/MKUaAjU8KerGxgj5PZ
	 PcXZKBGDK0i4rqDACdvpA9kbTEnAMgAQzl91PnmeyMd0jYu0DPBovJlXnDs9rS4Ckoehl
	 R9UjhVG6PsjnG+vRVbUmXuEhE+lEg8pT66ngbZxYF/gI6EdI867icTfrVxsoti1+BEyJS
	 uBkbAOW1BPBm/NDFkjliwFg5or/9Sw57bxf8vbdI/qyCRnnbQuFwI6tu73otazlf4dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606099;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=/4ppV3m1hgJnXfbCJ21OIXII8HaiQAESVEv6yKunL88=;
	b=YPQLnmys091wLfhC9dkXLht7SWIvvCk3drUgs9975iJoHf+RZJe0Wi+Gs3EBKRSA2Dib
	 2CFIrMh+Zl7WOG5LsA3J7YGLOr1SU/dNTMS/fqopBmSfKnmwc+Kb1nZbHdcHp4aNhbooI
	 g9gVS5xiNa1UC2C06FxD1yhlwAH/9n4iL7rWhApdWiTzJiTnMZPfiFlHEO6KWbWD/4dZr
	 9JsaHS/FJifPN1CuFCA2606UF6qs+EOh0TUsxhzOTuDB/BL43TZhx0xkTqjuk5E1O7Sch
	 4SaiOPcSBCwcYc8W/yQH+tGqDel1CEFdKvnURCO7bz7bb96NTbyuwKrf3cfmczVlSTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mYbDWe47;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90CB8606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=mYbDWe47
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 909241F000C4;
	Wed, 25 Nov 2026 11:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606099;
	bh=/4ppV3m1hgJnXfbCJ21OIXII8HaiQAESVEv6yKunL88=;
	h=Subject:To:Cc:From:Date;
	b=mYbDWe47Jal29VQinT7blC16UFKJ1MmYE5PUWtvVOcWkbVWT4+CiraaklK2r0jsj4
	 X4XBm5tt6oooxSRP0i5w7AqUMnxG7Cfx59xdgfI+KcZGNOX2BI0TSS0uIqCZbUYd1m
	 DI6PnR9o/y7ZeBPAtyUmaDOSU4aad6s+AZIUx1hg=
Subject: FAILED: patch "[PATCH] smb: client: let umount -f stop waiting for reconnects on" failed to apply to 5.15-stable tree
To: pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:15:46 +0100
Message-ID: <2026112545-referable-curtsy-b54a@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
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
git cherry-pick -x f8ea398448ce4adf32493649ab6665ab1f858d10
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112545-referable-curtsy-b54a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f8ea398448ce4adf32493649ab6665ab1f858d10 Mon Sep 17 00:00:00 2001
From: Paulo Alcantara <pc@manguebit.org>
Date: Wed, 28 Oct 2026 23:15:18 -0300
Subject: [PATCH] smb: client: let umount -f stop waiting for reconnects on
 hard mounts

Requests waiting in smb2_reconnect() or cifs_reconnect_tcon() for a
reconnect wait for as long as it takes on hard mounts.  With the server
gone, writeback stuck there keeps umount -f hanging in sync_filesystem()
while it waits for that writeback, even though retries of reads and
writes started before it now give up.

Count umount -f attempts per tcon and stop waiting for reconnects, as on
soft mounts, once one is made after the request started waiting, waking
up such requests on all channels right away.  Do this for the master
tcon and for the per-user tcons of a multiuser mount, skipping tcons
another mount still uses.  Count the references mounts hold on a tcon
for that, rather than relying on tc_count, which internal references
such as a reconnect worker also raise: one per tlink in a superblock's
tree, dropped when the tlink leaves it, and decide under the tree lock so
that pruning or building a tlink can't skew it.  Have a handle reopen
started before umount -f stop short of a reconnect it would otherwise
wait for afterwards, and have a retried read check for umount -f again
after backing off.  Requests started after umount -f are unaffected.

Signed-off-by: Paulo Alcantara <pc@manguebit.org>
Cc: stable@vger.kernel.org

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 7146bb22a69e..6c26f82b9cca 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -294,6 +294,64 @@ cifs_read_super(struct super_block *sb)
 	return rc;
 }
 
+struct cifs_tcon_ref {
+	struct list_head	list;
+	struct tcon_link	*tlink;
+	struct cifs_tcon	*tcon;
+	bool			shared;
+};
+
+static bool used_by_other_mounts(struct cifs_tcon *tcon,
+				 struct list_head *tcons)
+{
+	struct cifs_tcon_ref *ref;
+	int n = 0;
+
+	list_for_each_entry(ref, tcons, list)
+		n += ref->tcon == tcon;
+
+	guard(spinlock)(&tcon->tc_lock);
+	return tcon->mnt_refs - tcon->mnt_unlinked > n;
+}
+
+static void get_sb_tcons(struct cifs_sb_info *cifs_sb, struct list_head *tcons)
+{
+	struct rb_root *root = &cifs_sb->tlink_tree;
+	struct cifs_tcon_ref *ref;
+	struct tcon_link *tlink;
+	struct cifs_tcon *tcon;
+	struct rb_node *node;
+
+	guard(spinlock)(&cifs_sb->tlink_tree_lock);
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		tlink = rb_entry(node, struct tcon_link, tl_rbnode);
+		tcon = tlink_tcon(tlink);
+		if (IS_ERR_OR_NULL(tcon))
+			continue;
+
+		ref = kmalloc_obj(struct cifs_tcon_ref, GFP_ATOMIC);
+		if (!ref)
+			break;
+
+		ref->tlink = cifs_get_tlink(tlink);
+		ref->tcon = tcon;
+		list_add_tail(&ref->list, tcons);
+	}
+	list_for_each_entry(ref, tcons, list)
+		ref->shared = used_by_other_mounts(ref->tcon, tcons);
+}
+
+static void put_sb_tcons(struct list_head *tcons)
+{
+	struct cifs_tcon_ref *ref, *tmp;
+
+	list_for_each_entry_safe(ref, tmp, tcons, list) {
+		cifs_put_tlink(ref->tlink);
+		list_del(&ref->list);
+		kfree(ref);
+	}
+}
+
 static void cifs_kill_sb(struct super_block *sb)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
@@ -837,47 +895,46 @@ cifs_show_options(struct seq_file *s, struct dentry *root)
 	return 0;
 }
 
+static void abort_reconnect(struct cifs_tcon *tcon)
+{
+	scoped_guard(spinlock, &tcon->tc_lock)
+		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
+				    netfs_trace_tcon_ref_see_umount);
+
+	atomic_inc(&tcon->umount_aborts);
+	if (tcon->ses && tcon->ses->server) {
+		cifs_dbg(FYI, "wake up tasks now - umount begin not complete\n");
+		cifs_wake_ses_waiters(tcon->ses);
+		msleep(1); /* yield */
+		/* we have to kick the requests once more */
+		cifs_wake_ses_waiters(tcon->ses);
+		msleep(1);
+	}
+}
+
 static void cifs_umount_begin(struct super_block *sb)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
-	struct cifs_tcon *tcon;
+	struct cifs_tcon_ref *ref;
+	LIST_HEAD(tcons);
 
 	if (cifs_sb == NULL)
 		return;
 
 	atomic_inc(&cifs_sb->umount_aborts);
-	tcon = cifs_sb_master_tcon(cifs_sb);
 
-	spin_lock(&cifs_tcp_ses_lock);
-	spin_lock(&tcon->tc_lock);
-	trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
-			    netfs_trace_tcon_ref_see_umount);
-	if ((tcon->tc_count > 1) || (tcon->status == TID_EXITING)) {
-		/* we have other mounts to same share or we have
-		   already tried to umount this and woken up
-		   all waiting network requests, nothing to do */
-		spin_unlock(&tcon->tc_lock);
-		spin_unlock(&cifs_tcp_ses_lock);
-		return;
-	}
 	/*
-	 * can not set tcon->status to TID_EXITING yet since we don't know if umount -f will
-	 * fail later (e.g. due to open files).  TID_EXITING will be set just before tdis req sent
+	 * Abort the reconnect waits of the master tcon and of any per-user
+	 * tcons of a multiuser mount that no other mount uses, pinning their
+	 * tlinks so that they stay alive, and aren't pruned, while we abort and
+	 * sleep outside the tree lock.
 	 */
-	spin_unlock(&tcon->tc_lock);
-	spin_unlock(&cifs_tcp_ses_lock);
-
-	if (tcon->ses && tcon->ses->server) {
-		cifs_dbg(FYI, "wake up tasks now - umount begin not complete\n");
-		wake_up_all(&tcon->ses->server->request_q);
-		wake_up_all(&tcon->ses->server->response_q);
-		msleep(1); /* yield */
-		/* we have to kick the requests once more */
-		wake_up_all(&tcon->ses->server->response_q);
-		msleep(1);
+	get_sb_tcons(cifs_sb, &tcons);
+	list_for_each_entry(ref, &tcons, list) {
+		if (!ref->shared)
+			abort_reconnect(ref->tcon);
 	}
-
-	return;
+	put_sb_tcons(&tcons);
 }
 
 static int cifs_freeze(struct super_block *sb)
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 09bde6a08dd7..78ab6abe5297 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1196,6 +1196,9 @@ struct cifs_tcon {
 	struct list_head tcon_list;
 	int debug_id;		/* Debugging for tracing */
 	int tc_count;
+	int mnt_refs;		/* refs held by mounts, under tc_lock */
+	int mnt_unlinked;	/* mnt_refs of tlinks being built */
+	atomic_t umount_aborts;	/* nr of umount -f attempts */
 	struct list_head rlist; /* reconnect list */
 	spinlock_t tc_lock;  /* protect anything here that is not protected */
 	atomic_t num_local_opens;  /* num of all opens including disconnected */
@@ -2382,6 +2385,11 @@ static inline void cifs_reset_oplock(struct cifsInodeInfo *cinode)
 		WRITE_ONCE(cinode->oplock, 0);
 }
 
+static inline bool cifs_tcon_retry(struct cifs_tcon *tcon, int aborts)
+{
+	return tcon->retry && atomic_read(&tcon->umount_aborts) == aborts;
+}
+
 static inline bool cifs_forced_shutdown(const struct cifs_sb_info *sbi)
 {
 	return cifs_sb_flags(sbi) & CIFS_MOUNT_SHUTDOWN;
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index a37eee2ca54b..1b735a1c5b3d 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -442,7 +442,9 @@ static inline int cifs_create_options(struct cifs_sb_info *cifs_sb, int options)
 		return options;
 }
 
-int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry);
+void cifs_wake_ses_waiters(struct cifs_ses *ses);
+int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server,
+				   struct cifs_tcon *tcon, int aborts);
 
 static inline void cifs_put_smb_ses(struct cifs_ses *ses)
 {
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index fcf97b3d6bea..712086eb3d1f 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -73,6 +73,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 {
 	struct TCP_Server_Info *server;
 	struct cifs_ses *ses;
+	int aborts;
 	int rc;
 
 	/*
@@ -83,6 +84,8 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	if (!tcon)
 		return 0;
 
+	aborts = atomic_read(&tcon->umount_aborts);
+
 	ses = tcon->ses;
 	server = ses->server;
 
@@ -102,7 +105,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	spin_unlock(&tcon->tc_lock);
 
 again:
-	rc = cifs_wait_for_server_reconnect(server, tcon->retry);
+	rc = cifs_wait_for_server_reconnect(server, tcon, aborts);
 	if (rc)
 		return rc;
 
@@ -127,7 +130,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	case CifsNeedReconnect:
 		spin_unlock(&server->srv_lock);
 		mutex_unlock(&ses->session_mutex);
-		if (!tcon->retry)
+		if (!cifs_tcon_retry(tcon, aborts))
 			return -EHOSTDOWN;
 		goto again;
 	default:
@@ -159,7 +162,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	rc = cifs_negotiate_protocol(0, ses, server);
 	if (rc) {
 		mutex_unlock(&ses->session_mutex);
-		if (!tcon->retry)
+		if (!cifs_tcon_retry(tcon, aborts))
 			return -EHOSTDOWN;
 		goto again;
 	}
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 6497b0d54fea..ef970905f6c7 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2611,7 +2611,8 @@ static int match_tcon(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 }
 
 static struct cifs_tcon *
-cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
+cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx,
+	       bool unlinked)
 {
 	struct cifs_tcon *tcon;
 
@@ -2623,6 +2624,8 @@ cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 			continue;
 		}
 		++tcon->tc_count;
+		++tcon->mnt_refs;
+		tcon->mnt_unlinked += unlinked;
 		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
 				    netfs_trace_tcon_ref_get_find);
 		spin_unlock(&tcon->tc_lock);
@@ -2696,10 +2699,44 @@ cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
 #endif
 }
 
+void cifs_wake_ses_waiters(struct cifs_ses *ses)
+{
+	guard(spinlock)(&ses->chan_lock);
+	for (size_t i = 0; i < ses->chan_count; i++) {
+		struct TCP_Server_Info *server = ses->chans[i].server;
+
+		if (!server)
+			continue;
+		wake_up_all(&server->request_q);
+		wake_up_all(&server->response_q);
+	}
+}
+
+static void drop_mnt_ref(struct cifs_tcon *tcon)
+{
+	guard(spinlock)(&tcon->tc_lock);
+	tcon->mnt_refs--;
+}
+
+static void put_mnt_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
+{
+	drop_mnt_ref(tcon);
+	cifs_put_tcon(tcon, trace);
+}
+
+static void erase_tlink(struct cifs_sb_info *cifs_sb, struct tcon_link *tlink)
+{
+	clear_bit(TCON_LINK_IN_TREE, &tlink->tl_flags);
+	rb_erase(&tlink->tl_rbnode, &cifs_sb->tlink_tree);
+	if (!IS_ERR(tlink_tcon(tlink)))
+		drop_mnt_ref(tlink_tcon(tlink));
+}
+
 /**
  * cifs_get_tcon - get a tcon matching @ctx data from @ses
  * @ses: smb session to issue the request on
  * @ctx: the superblock configuration context to use for building the
+ * @unlinked: the mount reference is for a tlink not yet in a superblock's tree
  *
  * - tcon refcount is the number of mount points using the tcon.
  * - ses refcount is the number of tcon using the session.
@@ -2719,13 +2756,13 @@ cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
  *    decrement the ses refcount.
  */
 static struct cifs_tcon *
-cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
+cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx, bool unlinked)
 {
 	struct cifs_tcon *tcon;
 	bool nohandlecache;
 	int rc, xid;
 
-	tcon = cifs_find_tcon(ses, ctx);
+	tcon = cifs_find_tcon(ses, ctx, unlinked);
 	if (tcon) {
 		/*
 		 * tcon has refcount already incremented but we need to
@@ -2751,6 +2788,8 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		rc = -ENOMEM;
 		goto out_fail;
 	}
+	tcon->mnt_refs = 1;
+	tcon->mnt_unlinked = unlinked;
 	tcon->nohandlecache = nohandlecache;
 
 	if (ctx->snapshot_time) {
@@ -3577,7 +3616,7 @@ void cifs_mount_put_conns(struct cifs_mount_ctx *mnt_ctx)
 	int rc = 0;
 
 	if (mnt_ctx->tcon)
-		cifs_put_tcon(mnt_ctx->tcon, netfs_trace_tcon_ref_put_mnt_ctx);
+		put_mnt_tcon(mnt_ctx->tcon, netfs_trace_tcon_ref_put_mnt_ctx);
 	else if (mnt_ctx->ses)
 		cifs_put_smb_ses(mnt_ctx->ses);
 	else if (mnt_ctx->server)
@@ -3657,7 +3696,7 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 	cifs_sb = mnt_ctx->cifs_sb;
 
 	/* search for existing tcon to this server share */
-	tcon = cifs_get_tcon(mnt_ctx->ses, ctx);
+	tcon = cifs_get_tcon(mnt_ctx->ses, ctx, false);
 	if (IS_ERR(tcon)) {
 		rc = PTR_ERR(tcon);
 		tcon = NULL;
@@ -4033,8 +4072,7 @@ cifs_umount(struct cifs_sb_info *cifs_sb)
 	while ((node = rb_first(root))) {
 		tlink = rb_entry(node, struct tcon_link, tl_rbnode);
 		cifs_get_tlink(tlink);
-		clear_bit(TCON_LINK_IN_TREE, &tlink->tl_flags);
-		rb_erase(node, root);
+		erase_tlink(cifs_sb, tlink);
 
 		spin_unlock(&cifs_sb->tlink_tree_lock);
 		cifs_put_tlink(tlink);
@@ -4322,7 +4360,7 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 	}
 #endif
 
-	tcon = cifs_get_tcon(ses, ctx);
+	tcon = cifs_get_tcon(ses, ctx, true);
 	if (IS_ERR(tcon)) {
 		cifs_put_smb_ses(ses);
 		goto out;
@@ -4425,6 +4463,7 @@ cifs_sb_tlink(struct cifs_sb_info *cifs_sb)
 {
 	struct tcon_link *tlink, *newtlink;
 	kuid_t fsuid = current_fsuid();
+	struct cifs_tcon *tcon;
 	int err;
 
 	if (!(cifs_sb_flags(cifs_sb) & CIFS_MOUNT_MULTIUSER))
@@ -4482,7 +4521,16 @@ cifs_sb_tlink(struct cifs_sb_info *cifs_sb)
 			goto wait_for_construction;
 	}
 
-	tlink->tl_tcon = cifs_construct_tcon(cifs_sb, fsuid);
+	tcon = cifs_construct_tcon(cifs_sb, fsuid);
+	scoped_guard(spinlock, &cifs_sb->tlink_tree_lock) {
+		tlink->tl_tcon = tcon;
+		if (!IS_ERR(tcon)) {
+			scoped_guard(spinlock, &tcon->tc_lock)
+				tcon->mnt_unlinked--;
+			if (!test_bit(TCON_LINK_IN_TREE, &tlink->tl_flags))
+				drop_mnt_ref(tcon);
+		}
+	}
 	clear_bit(TCON_LINK_PENDING, &tlink->tl_flags);
 	wake_up_bit(&tlink->tl_flags, TCON_LINK_PENDING);
 
@@ -4531,8 +4579,7 @@ cifs_prune_tlinks(struct work_struct *work)
 			continue;
 
 		cifs_get_tlink(tlink);
-		clear_bit(TCON_LINK_IN_TREE, &tlink->tl_flags);
-		rb_erase(tmp, root);
+		erase_tlink(cifs_sb, tlink);
 
 		spin_unlock(&cifs_sb->tlink_tree_lock);
 		cifs_put_tlink(tlink);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 17aa34c020f8..b851e9b78f51 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -485,8 +485,12 @@ static void cifs_issue_read(struct netfs_io_subrequest *subreq)
 	if (rc)
 		goto not_sent;
 
-	if (rdata->replay && rdata->cur_sleep)
+	if (rdata->replay && rdata->cur_sleep) {
 		msleep(rdata->cur_sleep);
+		rc = -EIO;
+		if (cifs_io_aborted(rdata))
+			goto failed;
+	}
 
 	rc = -EAGAIN;
 	if (req->cfile->invalidHandle ||
@@ -1552,6 +1556,16 @@ cifs_relock_file(struct cifsFileInfo *cfile)
 	return rc;
 }
 
+static bool reopen_aborted(struct cifs_tcon *tcon, int aborts)
+{
+	struct TCP_Server_Info *server;
+
+	if (atomic_read(&tcon->umount_aborts) == aborts)
+		return false;
+	server = cifs_pick_channel(tcon->ses);
+	return server && READ_ONCE(server->tcpStatus) == CifsNeedReconnect;
+}
+
 static int
 cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 {
@@ -1570,7 +1584,10 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	int create_options = CREATE_NOT_DIR;
 	struct cifs_open_parms oparms;
 	int rdwr_for_fscache = 0;
+	int aborts;
 
+	tcon = tlink_tcon(cfile->tlink);
+	aborts = atomic_read(&tcon->umount_aborts);
 	xid = get_xid();
 	mutex_lock(&cfile->fh_mutex);
 	if (!cfile->invalidHandle) {
@@ -1578,10 +1595,14 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 		free_xid(xid);
 		return 0;
 	}
+	if (reopen_aborted(tcon, aborts)) {
+		mutex_unlock(&cfile->fh_mutex);
+		free_xid(xid);
+		return -EHOSTDOWN;
+	}
 
 	inode = d_inode(cfile->dentry);
 	cifs_sb = CIFS_SB(inode->i_sb);
-	tcon = tlink_tcon(cfile->tlink);
 	server = tcon->ses->server;
 
 	/*
@@ -1663,10 +1684,16 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	 * version of file size can be stale. If we knew for sure that inode was
 	 * not dirty locally we could do this.
 	 */
-	rc = server->ops->open(xid, &oparms, &oplock, NULL);
+	if (reopen_aborted(tcon, aborts))
+		rc = -EHOSTDOWN;
+	else
+		rc = server->ops->open(xid, &oparms, &oplock, NULL);
 	if (rc == -ENOENT && oparms.reconnect == false) {
 		/* durable handle timeout is expired - open the file again */
-		rc = server->ops->open(xid, &oparms, &oplock, NULL);
+		if (reopen_aborted(tcon, aborts))
+			rc = -EHOSTDOWN;
+		else
+			rc = server->ops->open(xid, &oparms, &oplock, NULL);
 		/* indicate that we need to relock the file */
 		oparms.reconnect = true;
 	}
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index ec28f102ea08..13eb067ad88a 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -1073,7 +1073,15 @@ int cifs_inval_name_dfs_link_error(const unsigned int xid,
 }
 #endif
 
-int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry)
+static bool reco_wait_done(struct TCP_Server_Info *server,
+			   struct cifs_tcon *tcon, int aborts)
+{
+	return server->tcpStatus != CifsNeedReconnect ||
+		atomic_read(&tcon->umount_aborts) != aborts;
+}
+
+int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server,
+				   struct cifs_tcon *tcon, int aborts)
 {
 	int timeout = 10;
 	int rc;
@@ -1096,7 +1104,9 @@ int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry)
 	 */
 	do {
 		rc = wait_event_interruptible_timeout(server->response_q,
-						      (server->tcpStatus != CifsNeedReconnect),
+						      reco_wait_done(server,
+								     tcon,
+								     aborts),
 						      timeout * HZ);
 		if (rc < 0) {
 			cifs_dbg(FYI, "%s: aborting reconnect due to received signal\n",
@@ -1111,7 +1121,7 @@ int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry)
 			return 0;
 		}
 		spin_unlock(&server->srv_lock);
-	} while (retry);
+	} while (cifs_tcon_retry(tcon, aborts));
 
 	cifs_dbg(FYI, "%s: gave up waiting on reconnect\n", __func__);
 	return -EHOSTDOWN;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 2984af6335f4..0f248eb52520 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -253,6 +253,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	bool hold_server_ref = false;
 	struct cifs_ses *ses;
 	int rc = 0;
+	int aborts;
 	int xid;
 
 	/*
@@ -263,6 +264,8 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	if (tcon == NULL)
 		return 0;
 
+	aborts = atomic_read(&tcon->umount_aborts);
+
 	if (smb2_command == SMB2_TREE_CONNECT)
 		return 0;
 
@@ -319,7 +322,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	spin_unlock(&server->srv_lock);
 
 again:
-	rc = cifs_wait_for_server_reconnect(server, tcon->retry);
+	rc = cifs_wait_for_server_reconnect(server, tcon, aborts);
 	if (rc)
 		return rc;
 
@@ -347,7 +350,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	case CifsNeedReconnect:
 		spin_unlock(&server->srv_lock);
 		mutex_unlock(&ses->session_mutex);
-		if (!tcon->retry)
+		if (!cifs_tcon_retry(tcon, aborts))
 			return -EHOSTDOWN;
 		goto again;
 	default:
@@ -378,7 +381,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	rc = cifs_negotiate_protocol(0, ses, server);
 	if (rc) {
 		mutex_unlock(&ses->session_mutex);
-		if (!tcon->retry)
+		if (!cifs_tcon_retry(tcon, aborts))
 			return -EHOSTDOWN;
 		goto again;
 	}

