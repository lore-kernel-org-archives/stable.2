Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795668429;
	b=N3n39fomBRp1Kb6N85vA9nO/RS/yNkf4TF1VrDL9oIktaqIT2/fQqNEc3a+Wx6TE+Q+g
	 bAs0Yw1SxaCpUynl2TR9/o42mG3Hxs+FmG4bqRvQnUlZ/qUxAj64g5CNxgMg5cRbJz3Ls
	 wFyPSefj4tg7AWYYujWiTvgyc6LeL4j2hDN8o9Xj5gll4+YfNfH9tSkMT0vDt29v4MuLg
	 rgynW2O+cMW99pCzFJhbGJ0kz+JQLgDSIIc7Kac4dsnrIoGnWkMue5iYRYGJG4oMk0W71
	 /wfC4ghsAj+2nUUUi9utV1iHbML+0JTutpWedYLT13v8blxqJQsw8InjqJcMqaOIcNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795668429;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=eKWRbERJyJkciBGQZO0v2B+PPKAnVLx51qfIZ+V5Imc=;
	b=gndU38OXPLt1FDtZDXwnh/cYvJC1B4kHG/ciK8waOfS9Vvtm3+04pP0jKJPDA3b0hOk8
	 DhQnacm8pPKRYOLrBWUDth9GhIjcSsbQ3znNVXRNqZkpH7kS9sn1gWdTnBsmzlQsoF+d9
	 7i028uJxdxsBMFMvu1evBWPHdNe/B6nlTznFKqIODqk6KyQndKTKKRnonfpT/oLomJiQU
	 GmKou2NK0il2gDTWnvtuVEbNOzmdBsB2U0AuLyuNHkY8xA+V7XR5auW5J2NlrOsHU0riY
	 wqqvPCk91QJmf7u6/3Ndj8tFce7dSN8pNkpNoVHJlvShk56zZrvgWs4ci66D6z0cTeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ROOjKBDJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE0A606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 04:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ROOjKBDJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57FB21F000CF;
	Thu, 26 Nov 2026 04:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795668428;
	bh=eKWRbERJyJkciBGQZO0v2B+PPKAnVLx51qfIZ+V5Imc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ROOjKBDJzzUEg70bIHQd74k/k/kSe3KzClqASj8jSGwmTpxRIjkqWnuUjXYW3aAvR
	 6sTQ2qOYu99kXOct5PzBd2lbstAsQOPjscJoCcnrbDZMis20ka6E7rEEOFW86Jdo7D
	 qTW5KGN3YtUF90l7HXddjemCJooPSLLJsmwpR34JsnpAQ4xI/CRxr+s5mfD66/Y3/x
	 jnqPovbLODmMNCTIK41x3oNJYng8BwkwXJ56fB6NZQUGI1SxBy8chqIbnJHvcVkEyj
	 8kBo73XOm3G6tOvSXyr9BzwUShVC+Vj4EIJNQZscVnvqVBpyL59tkNOsa21iWqFhKD
	 M7zzLsAK3+D5w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 4/5] smb: client: let umount -f stop waiting for reconnects on hard mounts
Date: Wed, 25 Nov 2026 23:47:01 -0500
Message-ID: <20261126044608.1960941-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261126044608.1960941-1-sashal@kernel.org>
References: <2026112529-flatly-mammal-3d12@gregkh>
 <20261126044608.1960941-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.org>

[ Upstream commit f8ea398448ce4adf32493649ab6665ab1f858d10 ]

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
Stable-dep-of: 9bd8ee0c1614 ("smb: client: don't replay handle reopens inside SMB2_open()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c    | 115 ++++++++++++++++++++++++++++----------
 fs/smb/client/cifsglob.h  |   8 +++
 fs/smb/client/cifsproto.h |   4 +-
 fs/smb/client/cifssmb.c   |   9 ++-
 fs/smb/client/connect.c   |  69 +++++++++++++++++++----
 fs/smb/client/file.c      |  35 ++++++++++--
 fs/smb/client/misc.c      |  16 +++++-
 fs/smb/client/smb2pdu.c   |   9 ++-
 8 files changed, 211 insertions(+), 54 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 5518a62549806..b912717668f4b 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -295,6 +295,64 @@ cifs_read_super(struct super_block *sb)
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
@@ -839,47 +897,46 @@ cifs_show_options(struct seq_file *s, struct dentry *root)
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
index 6193340963845..219f991fe435a 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1199,6 +1199,9 @@ struct cifs_tcon {
 	struct list_head tcon_list;
 	int debug_id;		/* Debugging for tracing */
 	int tc_count;
+	int mnt_refs;		/* refs held by mounts, under tc_lock */
+	int mnt_unlinked;	/* mnt_refs of tlinks being built */
+	atomic_t umount_aborts;	/* nr of umount -f attempts */
 	struct list_head rlist; /* reconnect list */
 	spinlock_t tc_lock;  /* protect anything here that is not protected */
 	atomic_t num_local_opens;  /* num of all opens including disconnected */
@@ -2386,6 +2389,11 @@ static inline void cifs_reset_oplock(struct cifsInodeInfo *cinode)
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
index 5b41af529955f..515ca0698d4ab 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -440,7 +440,9 @@ static inline int cifs_create_options(struct cifs_sb_info *cifs_sb, int options)
 		return options;
 }
 
-int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry);
+void cifs_wake_ses_waiters(struct cifs_ses *ses);
+int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server,
+				   struct cifs_tcon *tcon, int aborts);
 
 static inline void cifs_put_smb_ses(struct cifs_ses *ses)
 {
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index ae81d00fddd9d..ff9bf20088b12 100644
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
index 1878a880e1662..9c41515044473 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2591,7 +2591,8 @@ static int match_tcon(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 }
 
 static struct cifs_tcon *
-cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
+cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx,
+	       bool unlinked)
 {
 	struct cifs_tcon *tcon;
 
@@ -2603,6 +2604,8 @@ cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 			continue;
 		}
 		++tcon->tc_count;
+		++tcon->mnt_refs;
+		tcon->mnt_unlinked += unlinked;
 		trace_smb3_tcon_ref(tcon->debug_id, tcon->tc_count,
 				    netfs_trace_tcon_ref_get_find);
 		spin_unlock(&tcon->tc_lock);
@@ -2676,10 +2679,44 @@ cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
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
@@ -2699,13 +2736,13 @@ cifs_put_tcon(struct cifs_tcon *tcon, enum smb3_tcon_ref_trace trace)
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
@@ -2731,6 +2768,8 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 		rc = -ENOMEM;
 		goto out_fail;
 	}
+	tcon->mnt_refs = 1;
+	tcon->mnt_unlinked = unlinked;
 	tcon->nohandlecache = nohandlecache;
 
 	if (ctx->snapshot_time) {
@@ -3558,7 +3597,7 @@ void cifs_mount_put_conns(struct cifs_mount_ctx *mnt_ctx)
 	int rc = 0;
 
 	if (mnt_ctx->tcon)
-		cifs_put_tcon(mnt_ctx->tcon, netfs_trace_tcon_ref_put_mnt_ctx);
+		put_mnt_tcon(mnt_ctx->tcon, netfs_trace_tcon_ref_put_mnt_ctx);
 	else if (mnt_ctx->ses)
 		cifs_put_smb_ses(mnt_ctx->ses);
 	else if (mnt_ctx->server)
@@ -3638,7 +3677,7 @@ int cifs_mount_get_tcon(struct cifs_mount_ctx *mnt_ctx)
 	cifs_sb = mnt_ctx->cifs_sb;
 
 	/* search for existing tcon to this server share */
-	tcon = cifs_get_tcon(mnt_ctx->ses, ctx);
+	tcon = cifs_get_tcon(mnt_ctx->ses, ctx, false);
 	if (IS_ERR(tcon)) {
 		rc = PTR_ERR(tcon);
 		tcon = NULL;
@@ -4014,8 +4053,7 @@ cifs_umount(struct cifs_sb_info *cifs_sb)
 	while ((node = rb_first(root))) {
 		tlink = rb_entry(node, struct tcon_link, tl_rbnode);
 		cifs_get_tlink(tlink);
-		clear_bit(TCON_LINK_IN_TREE, &tlink->tl_flags);
-		rb_erase(node, root);
+		erase_tlink(cifs_sb, tlink);
 
 		spin_unlock(&cifs_sb->tlink_tree_lock);
 		cifs_put_tlink(tlink);
@@ -4305,7 +4343,7 @@ cifs_construct_tcon(struct cifs_sb_info *cifs_sb, kuid_t fsuid)
 	}
 #endif
 
-	tcon = cifs_get_tcon(ses, ctx);
+	tcon = cifs_get_tcon(ses, ctx, true);
 	if (IS_ERR(tcon)) {
 		cifs_put_smb_ses(ses);
 		goto out;
@@ -4408,6 +4446,7 @@ cifs_sb_tlink(struct cifs_sb_info *cifs_sb)
 {
 	struct tcon_link *tlink, *newtlink;
 	kuid_t fsuid = current_fsuid();
+	struct cifs_tcon *tcon;
 	int err;
 
 	if (!(cifs_sb_flags(cifs_sb) & CIFS_MOUNT_MULTIUSER))
@@ -4465,7 +4504,16 @@ cifs_sb_tlink(struct cifs_sb_info *cifs_sb)
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
 
@@ -4514,8 +4562,7 @@ cifs_prune_tlinks(struct work_struct *work)
 			continue;
 
 		cifs_get_tlink(tlink);
-		clear_bit(TCON_LINK_IN_TREE, &tlink->tl_flags);
-		rb_erase(tmp, root);
+		erase_tlink(cifs_sb, tlink);
 
 		spin_unlock(&cifs_sb->tlink_tree_lock);
 		cifs_put_tlink(tlink);
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 2f073088f5700..ac2fd53e27f2e 100644
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
@@ -1549,6 +1553,16 @@ cifs_relock_file(struct cifsFileInfo *cfile)
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
@@ -1567,7 +1581,10 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	int create_options = CREATE_NOT_DIR;
 	struct cifs_open_parms oparms;
 	int rdwr_for_fscache = 0;
+	int aborts;
 
+	tcon = tlink_tcon(cfile->tlink);
+	aborts = atomic_read(&tcon->umount_aborts);
 	xid = get_xid();
 	mutex_lock(&cfile->fh_mutex);
 	if (!cfile->invalidHandle) {
@@ -1575,10 +1592,14 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
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
@@ -1660,10 +1681,16 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
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
index 05168284f2051..71a233adade31 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -1075,7 +1075,15 @@ int cifs_inval_name_dfs_link_error(const unsigned int xid,
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
@@ -1098,7 +1106,9 @@ int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry)
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
@@ -1113,7 +1123,7 @@ int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry)
 			return 0;
 		}
 		spin_unlock(&server->srv_lock);
-	} while (retry);
+	} while (cifs_tcon_retry(tcon, aborts));
 
 	cifs_dbg(FYI, "%s: gave up waiting on reconnect\n", __func__);
 	return -EHOSTDOWN;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 3c7e42a47a5ae..679ab668051cb 100644
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
-- 
2.53.0

