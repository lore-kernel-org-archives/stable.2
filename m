Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926719;
	b=Skr+vt9Ix40lW9YAKBcowXCXNk85BW1B0+IUUPOMQqtI7W3CUdfjNdWkXqihRnwmGs+B
	 c+dwb9ODzG4wACYbzfGYIKCDnzIzKdm25iMyUecdZZnc19b3OTS0uYvbs4y/8rfj8RUxm
	 Bdd5PF908qVHxrCz9dZDNRs1XvKW57w7XOV54UuUky1Oo4oMq4yWY8aCnOh+cPqw/f4Ul
	 ZQRqhO3oHB8Uww4on6kZfTx058eOu2GyPCWQTtHyOcOBgVcfRrnIPEZ3vrbpQOQJywV7v
	 RijfRCs5Jqp9cWgXY61naXEMw+fTxu427h67XV5ku9V8C4KGJL+OiYvoTvoUU+VlgAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926719;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gmdv5PmERZ8TtphNZK2NA41gu0N6z1x/+itME5x3JD4=;
	b=Y0O6HgdjqrNeIdk+a4IBWbMkuT+UGJaF74zHa9GNphWUWmev176A0g1dq3PJFvYkg3QV
	 mwE/sj6kC2uife+OggOBen45uSRYfBBqaNrH04FKJPfwnKJxZZ81cTZjPl/1lkXpESN7g
	 Z1IF5nZ/f4VY52+wTj3GrLOH2VVvN5WGwMh2FLLBNIzDhGRbw5eHZVHLWlLQq/ytIG2qH
	 LsGSd6WEMSjMNCt1VgvEdp0kAQ6oPXf68ZjFaPR5z/A72EEKE7c832PmZBvdcktIaHybv
	 scPQl6tT37SfHuclfNccLFnesNvEMzXN0OrOCXJhwLQ2fMENOa2UUaCK6g4mOteYcjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vci2hUZY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDF1606A328
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vci2hUZY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D21651F0089F;
	Fri,  6 Nov 2026 00:58:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926719;
	bh=gmdv5PmERZ8TtphNZK2NA41gu0N6z1x/+itME5x3JD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vci2hUZY+gwBX47fMx2/7moZ9DVhY7Zd5nQZQyVKI7OXFTSzKRfvCHqe5SDfY7Xm1
	 1RB+bcoUWxJQE2QrKOFSWKKkJVxgAcO7xbRmVYz4zCwbFgZgHKHYd7JDeAh4U4Xh29
	 4iQI6GMhG4NoSpfu6jhatgZGNPAmdg07p/vBNDyzUXMOsn5l7JqKWbEKXQ9PVrTUKX
	 /g320/co9FFJFKOid+8rZH2+TLSZU8b08gDSjYjeZ/BRB1MJ6EdArGiLloHTK7njWt
	 fyWWJuDMhvm/qsRhG6U0vBSLiYACldr4e8cyzHTs/IeAjNLSzEFeZ+LWHIxhx8P35Y
	 4lu2NctQ4bBqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neilb@suse.de>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] nfs: convert to using new filelock helpers
Date: Thu,  5 Nov 2026 19:58:36 -0500
Message-ID: <20261106005831.3499434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110415-pamphlet-protrude-0e3f@gregkh>
References: <2026110415-pamphlet-protrude-0e3f@gregkh>
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

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit d7c9616be0759c1cfb44a68ba838548d22b98484 ]

Convert to using the new file locking helper functions. Also, in later
patches we're going to introduce some temporary macros with names that
clash with the variable name in nfs4_proc_unlck. Rename it.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://lore.kernel.org/r/20240131-flsplit-v3-11-c6129007ee8d@kernel.org
Reviewed-by: NeilBrown <neilb@suse.de>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: 7fa2ad367abe ("NFSv4/flexfiles: fail I/O to the data server once a lock is lost")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/delegation.c |  2 +-
 fs/nfs/file.c       |  4 ++--
 fs/nfs/nfs4proc.c   | 12 ++++++------
 fs/nfs/nfs4state.c  | 18 +++++++++---------
 fs/nfs/nfs4xdr.c    |  2 +-
 fs/nfs/write.c      |  4 ++--
 6 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/fs/nfs/delegation.c b/fs/nfs/delegation.c
index af7751f05bbd7..55b345a4b9e48 100644
--- a/fs/nfs/delegation.c
+++ b/fs/nfs/delegation.c
@@ -156,7 +156,7 @@ static int nfs_delegation_claim_locks(struct nfs4_state *state, const nfs4_state
 	list = &flctx->flc_posix;
 	spin_lock(&flctx->flc_lock);
 restart:
-	list_for_each_entry(fl, list, fl_list) {
+	for_each_file_lock(fl, list) {
 		if (nfs_file_open_context(fl->fl_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
diff --git a/fs/nfs/file.c b/fs/nfs/file.c
index cf16ee710d42b..1d67e7c7d6e73 100644
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@ -863,7 +863,7 @@ int nfs_lock(struct file *filp, int cmd, struct file_lock *fl)
 
 	if (IS_GETLK(cmd))
 		ret = do_getlk(filp, cmd, fl, is_local);
-	else if (fl->fl_type == F_UNLCK)
+	else if (lock_is_unlock(fl))
 		ret = do_unlk(filp, cmd, fl, is_local);
 	else
 		ret = do_setlk(filp, cmd, fl, is_local);
@@ -890,7 +890,7 @@ int nfs_flock(struct file *filp, int cmd, struct file_lock *fl)
 		is_local = 1;
 
 	/* We're simulating flock() locks using posix locks on the server */
-	if (fl->fl_type == F_UNLCK)
+	if (lock_is_unlock(fl))
 		return do_unlk(filp, cmd, fl, is_local);
 	return do_setlk(filp, cmd, fl, is_local);
 }
diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
index 626f7337dd535..cf1832641b84a 100644
--- a/fs/nfs/nfs4proc.c
+++ b/fs/nfs/nfs4proc.c
@@ -7074,7 +7074,7 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	struct rpc_task *task;
 	struct nfs_seqid *(*alloc_seqid)(struct nfs_seqid_counter *, gfp_t);
 	int status = 0;
-	unsigned char fl_flags = request->fl_flags;
+	unsigned char saved_flags = request->fl_flags;
 
 	status = nfs4_set_lock_state(state, request);
 	/* Unlock _before_ we do the RPC call */
@@ -7109,7 +7109,7 @@ static int nfs4_proc_unlck(struct nfs4_state *state, int cmd, struct file_lock *
 	status = rpc_wait_for_completion_task(task);
 	rpc_put_task(task);
 out:
-	request->fl_flags = fl_flags;
+	request->fl_flags = saved_flags;
 	trace_nfs4_unlock(request, state, F_SETLK, status);
 	return status;
 }
@@ -7427,7 +7427,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 {
 	struct nfs_inode *nfsi = NFS_I(state->inode);
 	struct nfs4_state_owner *sp = state->owner;
-	unsigned char fl_flags = request->fl_flags;
+	unsigned char flags = request->fl_flags;
 	int status;
 
 	request->fl_flags |= FL_ACCESS;
@@ -7439,7 +7439,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	if (test_bit(NFS_DELEGATED_STATE, &state->flags)) {
 		/* Yes: cache locks! */
 		/* ...but avoid races with delegation recall... */
-		request->fl_flags = fl_flags & ~FL_SLEEP;
+		request->fl_flags = flags & ~FL_SLEEP;
 		status = locks_lock_inode_wait(state->inode, request);
 		up_read(&nfsi->rwsem);
 		mutex_unlock(&sp->so_delegreturn_mutex);
@@ -7449,7 +7449,7 @@ static int _nfs4_proc_setlk(struct nfs4_state *state, int cmd, struct file_lock
 	mutex_unlock(&sp->so_delegreturn_mutex);
 	status = _nfs4_do_setlk(state, cmd, request, NFS_LOCK_NEW);
 out:
-	request->fl_flags = fl_flags;
+	request->fl_flags = flags;
 	return status;
 }
 
@@ -7591,7 +7591,7 @@ nfs4_proc_lock(struct file *filp, int cmd, struct file_lock *request)
 	if (!(IS_SETLK(cmd) || IS_SETLKW(cmd)))
 		return -EINVAL;
 
-	if (request->fl_type == F_UNLCK) {
+	if (lock_is_unlock(request)) {
 		if (state != NULL)
 			return nfs4_proc_unlck(state, cmd, request);
 		return 0;
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 78d52c2006dcc..7805f33d77a03 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -847,15 +847,15 @@ void nfs4_close_sync(struct nfs4_state *state, fmode_t fmode)
  */
 static struct nfs4_lock_state *
 __nfs4_find_lock_state(struct nfs4_state *state,
-		       fl_owner_t fl_owner, fl_owner_t fl_owner2)
+		       fl_owner_t owner, fl_owner_t owner2)
 {
 	struct nfs4_lock_state *pos, *ret = NULL;
 	list_for_each_entry(pos, &state->lock_states, ls_locks) {
-		if (pos->ls_owner == fl_owner) {
+		if (pos->ls_owner == owner) {
 			ret = pos;
 			break;
 		}
-		if (pos->ls_owner == fl_owner2)
+		if (pos->ls_owner == owner2)
 			ret = pos;
 	}
 	if (ret)
@@ -868,7 +868,7 @@ __nfs4_find_lock_state(struct nfs4_state *state,
  * exists, return an uninitialized one.
  *
  */
-static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, fl_owner_t fl_owner)
+static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, fl_owner_t owner)
 {
 	struct nfs4_lock_state *lsp;
 	struct nfs_server *server = state->owner->so_server;
@@ -879,7 +879,7 @@ static struct nfs4_lock_state *nfs4_alloc_lock_state(struct nfs4_state *state, f
 	nfs4_init_seqid_counter(&lsp->ls_seqid);
 	refcount_set(&lsp->ls_count, 1);
 	lsp->ls_state = state;
-	lsp->ls_owner = fl_owner;
+	lsp->ls_owner = owner;
 	lsp->ls_seqid.owner_id = ida_alloc(&server->lockowner_id, GFP_KERNEL_ACCOUNT);
 	if (lsp->ls_seqid.owner_id < 0)
 		goto out_free;
@@ -993,7 +993,7 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 		const struct nfs_lock_context *l_ctx)
 {
 	struct nfs4_lock_state *lsp;
-	fl_owner_t fl_owner, fl_flock_owner;
+	fl_owner_t owner, fl_flock_owner;
 	int ret = -ENOENT;
 
 	if (l_ctx == NULL)
@@ -1002,11 +1002,11 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 	if (test_bit(LK_STATE_IN_USE, &state->flags) == 0)
 		goto out;
 
-	fl_owner = l_ctx->lockowner;
+	owner = l_ctx->lockowner;
 	fl_flock_owner = l_ctx->open_context->flock_owner;
 
 	spin_lock(&state->state_lock);
-	lsp = __nfs4_find_lock_state(state, fl_owner, fl_flock_owner);
+	lsp = __nfs4_find_lock_state(state, owner, fl_flock_owner);
 	if (lsp && test_bit(NFS_LOCK_LOST, &lsp->ls_flags))
 		ret = -EIO;
 	else if (lsp != NULL && test_bit(NFS_LOCK_INITIALIZED, &lsp->ls_flags) != 0) {
@@ -1529,7 +1529,7 @@ static int nfs4_reclaim_locks(struct nfs4_state *state, const struct nfs4_state_
 	down_write(&nfsi->rwsem);
 	spin_lock(&flctx->flc_lock);
 restart:
-	list_for_each_entry(fl, list, fl_list) {
+	for_each_file_lock(fl, list) {
 		if (nfs_file_open_context(fl->fl_file)->state != state)
 			continue;
 		spin_unlock(&flctx->flc_lock);
diff --git a/fs/nfs/nfs4xdr.c b/fs/nfs/nfs4xdr.c
index a9d57fcdf9b40..b685d6f641900 100644
--- a/fs/nfs/nfs4xdr.c
+++ b/fs/nfs/nfs4xdr.c
@@ -1303,7 +1303,7 @@ static void encode_link(struct xdr_stream *xdr, const struct qstr *name, struct
 
 static inline int nfs4_lock_type(struct file_lock *fl, int block)
 {
-	if (fl->fl_type == F_RDLCK)
+	if (lock_is_read(fl))
 		return block ? NFS4_READW_LT : NFS4_READ_LT;
 	return block ? NFS4_WRITEW_LT : NFS4_WRITE_LT;
 }
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index 85426764017ce..b8c957318396e 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -1356,7 +1356,7 @@ static bool
 is_whole_file_wrlock(struct file_lock *fl)
 {
 	return fl->fl_start == 0 && fl->fl_end == OFFSET_MAX &&
-			fl->fl_type == F_WRLCK;
+			lock_is_write(fl);
 }
 
 /* If we know the page is up to date, and we're not using byte range locks (or
@@ -1396,7 +1396,7 @@ static int nfs_can_extend_write(struct file *file, struct folio *folio,
 	} else if (!list_empty(&flctx->flc_flock)) {
 		fl = list_first_entry(&flctx->flc_flock, struct file_lock,
 					fl_list);
-		if (fl->fl_type == F_WRLCK)
+		if (lock_is_write(fl))
 			ret = 1;
 	}
 	spin_unlock(&flctx->flc_lock);
-- 
2.53.0

