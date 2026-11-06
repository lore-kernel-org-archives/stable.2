Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926720;
	b=r0M3fKaea2yyxuYlSrYmPe7JErwFU9wDh6ZBgGyOQXoRxlppcOUslrcJTq8t6IkkT5DR
	 iALwfOqeH9kLZU0ikFVSGUM38lJMf6/zTd/2nzXiHuAu+3xyy7ZnW+/YDbqBaOZcMhKhS
	 sBPXs91ODqi5RdNk0ue3VBetWOAiEkmpL2zTkGFQhp7I7TwUdVeJ+K9aec1mY+Le1gd4g
	 Ewl7Ke0C6Mr4xdh0ufmlkhLhU3JBIND9uItzMJROUcqODSm5XFHrTZ0oobJSyTkh/LNda
	 AHa3Cz1BUol57B+nCz4HbjuvlaMHoFMOq8fQay83A2/lFTkZeYYsKU8UMUdIGmFuKAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926720;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UExdaFBNurWSxawXAzBkzRaP1oQn7Fj+u2t0OEIBZ3M=;
	b=EkrXePyEsz0NhAptv5iaOrdob78YP4AZEkha19xNTllYYf6uTMonMPQ7Kungw/VPcLed
	 QhXfwRDXGCEocpZL5XUzRoBXdM5Nts5NweOIt6m4D7mJ2hWKFiLr38W3zMd+pLZRqoNaS
	 +2uUrM4MWgtcY0RRpezGzc5iAG/I6wrYLR7744FwZWZAQXaHZ5ZPOdvlI/N0ufm0tgCcb
	 VfDYxI2DhZoNjdggx5v0V507YAi4kLGpExTdY8czomMunY66oJjO/d5JEXdxoxRnALpAF
	 aHek+n7fLWOSzgXRi6D7wGDujKoAsSm3VQU3n9XdLb4f3UsGX8tKQhiOtzadOpMKMAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZjSPpK4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B21606A332
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 00:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BZjSPpK4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB73B1F008A1;
	Fri,  6 Nov 2026 00:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926720;
	bh=UExdaFBNurWSxawXAzBkzRaP1oQn7Fj+u2t0OEIBZ3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BZjSPpK4G4u9kR453PaAkvcAEYbObDJZzrO+mribRDruUvle+H7w6pK2OjmQKEQxH
	 XV8QlrD/hgqxs61kxUiMww7/repzq8qM+T8W5mVT6VsF+pBc+miOPL0CggGs9HzS+0
	 D/jcn6v38S27J9j3e8yUDmr3RL9ZEP6S0U4j8yLbmYcJS7dnxwqqxianwqhV+0A0WO
	 +MJTW2CaWIwAeE45qfY9yv6wSS8ojjJunkpuKrkh01ZobJHSrFoKsJbZZbWlLv+NH4
	 MZM69pLkQuhi1RE+TfegfADtYLpIkLgGF8370zsdFVxhWMzH4+maR9DRzA9LMjVEGD
	 ovsaildTFMh/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <bcodding@hammerspace.com>,
	Arun Potharaju <arun.potharaju@hammerspace.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] NFSv4/flexfiles: fail I/O to the data server once a lock is lost
Date: Thu,  5 Nov 2026 19:58:37 -0500
Message-ID: <20261106005831.3499434-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261106005831.3499434-1-sashal@kernel.org>
References: <2026110415-pamphlet-protrude-0e3f@gregkh>
 <20261106005831.3499434-1-sashal@kernel.org>
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

From: Benjamin Coddington <bcodding@hammerspace.com>

[ Upstream commit 7fa2ad367abe6d3155daefb57331e7fce1a17afd ]

When a client loses a byte-range lock, because its lease expired and it
may not recover the lock (nfs.recover_lost_locks=0) or because reclaim
failed, it marks the lock state NFS_LOCK_LOST and fails further I/O by
that lock owner.  Otherwise an application that believes it holds a
lock over a range is never told that the lock is gone, and can
overwrite data that another client has since written under its own
lock on that range.

The NFSv4 READ/WRITE and file layout I/O paths apply this in
rpc_call_prepare, where nfs4_set_rw_stateid() returns -EIO for a lost
lock.  The flexfiles data server I/O path does not: the NFSv3 data
server path never checked, and the check on the NFSv4 path was removed
when the data server stateid began to be taken from the layout.

Fail read and write RPCs to the data server in rpc_call_prepare when the
lock is lost.  The data server path has no use for the stateid that
nfs4_set_rw_stateid() selects, and selecting it looks up a delegation
or open stateid on every I/O.
Instead add nfs4_lock_context_lost(), which only tests NFS_LOCK_LOST,
and check it alongside the open state.  Its lookup,
__nfs4_lookup_lock_state(), is split out of __nfs4_find_lock_state()
and takes no reference: a lock state is only unlinked from
state->lock_states under state->state_lock, so one found while holding
that lock cannot be freed before it is released.  Use it in
nfs4_copy_lock_stateid() as well, which only reads the lock state under
that lock.  That drops a reference get and put from stateid selection
for all NFSv4 I/O without changing the stateid selected.

Terminating the RPC in rpc_call_prepare is not enough on its own.  The
done callback reads the -EIO as a data server connection error, forgets
the device ID, and resets the I/O to pNFS (or, for an NFSv4 data
server, possibly to the MDS).  After a reset to pNFS a new LAYOUTGET is
granted and rpc_call_prepare fails the I/O again, without end.  The
existing NFS_CONTEXT_BAD check does not loop, since the open state is
then invalid and pnfs_update_layout() fails the reset I/O, but it still
forgets the device ID.

So when an RPC that was never sent fails and the open context is bad,
the open state is invalid, or the lock is lost, complete it with -EIO
without error handling.  An RPC that was sent and failed is handled as
before, so a real data server error is still reported to the MDS.

Fixes: d67ae825a59d ("pnfs/flexfiles: Add the FlexFile Layout Driver")
Fixes: bb21ce0ad227 ("flexfiles: use per-mirror specified stateid for IO")
Cc: stable@vger.kernel.org
Tested-by: Arun Potharaju <arun.potharaju@hammerspace.com>
Assisted-by: LLM
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/flexfilelayout/flexfilelayout.c | 25 +++++++++++++++--
 fs/nfs/nfs4_fs.h                       |  2 ++
 fs/nfs/nfs4state.c                     | 38 +++++++++++++++++++++++---
 3 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/fs/nfs/flexfilelayout/flexfilelayout.c b/fs/nfs/flexfilelayout/flexfilelayout.c
index a1dc557245977..254ae2d45ee28 100644
--- a/fs/nfs/flexfilelayout/flexfilelayout.c
+++ b/fs/nfs/flexfilelayout/flexfilelayout.c
@@ -1372,12 +1372,27 @@ static void ff_layout_io_track_ds_error(struct pnfs_layout_segment *lseg,
 	dprintk("%s: err %d op %d status %u\n", __func__, err, opnum, status);
 }
 
+static bool ff_layout_io_state_lost(const struct nfs_pgio_header *hdr)
+{
+	struct nfs_open_context *ctx = hdr->args.context;
+
+	return test_bit(NFS_CONTEXT_BAD, &ctx->flags) ||
+	       !nfs4_valid_open_stateid(ctx->state) ||
+	       nfs4_lock_context_lost(ctx->state, hdr->args.lock_context);
+}
+
 /* NFS_PROTO call done callback routines */
 static int ff_layout_read_done_cb(struct rpc_task *task,
 				struct nfs_pgio_header *hdr)
 {
 	int err;
 
+	if (task->tk_status < 0 && !RPC_WAS_SENT(task) &&
+	    ff_layout_io_state_lost(hdr)) {
+		task->tk_status = -EIO;
+		return 0;
+	}
+
 	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
@@ -1465,7 +1480,7 @@ static void ff_layout_read_record_layoutstats_done(struct rpc_task *task,
 static int ff_layout_read_prepare_common(struct rpc_task *task,
 					 struct nfs_pgio_header *hdr)
 {
-	if (unlikely(test_bit(NFS_CONTEXT_BAD, &hdr->args.context->flags))) {
+	if (unlikely(ff_layout_io_state_lost(hdr))) {
 		rpc_exit(task, -EIO);
 		return -EIO;
 	}
@@ -1549,6 +1564,12 @@ static int ff_layout_write_done_cb(struct rpc_task *task,
 	loff_t end_offs = 0;
 	int err;
 
+	if (task->tk_status < 0 && !RPC_WAS_SENT(task) &&
+	    ff_layout_io_state_lost(hdr)) {
+		task->tk_status = -EIO;
+		return 0;
+	}
+
 	if (task->tk_status < 0) {
 		ff_layout_io_track_ds_error(hdr->lseg, hdr->pgio_mirror_idx,
 					    hdr->args.offset, hdr->args.count,
@@ -1652,7 +1673,7 @@ static void ff_layout_write_record_layoutstats_done(struct rpc_task *task,
 static int ff_layout_write_prepare_common(struct rpc_task *task,
 					  struct nfs_pgio_header *hdr)
 {
-	if (unlikely(test_bit(NFS_CONTEXT_BAD, &hdr->args.context->flags))) {
+	if (unlikely(ff_layout_io_state_lost(hdr))) {
 		rpc_exit(task, -EIO);
 		return -EIO;
 	}
diff --git a/fs/nfs/nfs4_fs.h b/fs/nfs/nfs4_fs.h
index 47c5c1f86d662..7efe74933a10f 100644
--- a/fs/nfs/nfs4_fs.h
+++ b/fs/nfs/nfs4_fs.h
@@ -519,6 +519,8 @@ extern int nfs4_select_rw_stateid(struct nfs4_state *, fmode_t,
 		const struct cred **);
 extern bool nfs4_copy_open_stateid(nfs4_stateid *dst,
 		struct nfs4_state *state);
+extern bool nfs4_lock_context_lost(struct nfs4_state *state,
+		const struct nfs_lock_context *l_ctx);
 
 extern struct nfs_seqid *nfs_alloc_seqid(struct nfs_seqid_counter *counter, gfp_t gfp_mask);
 extern int nfs_wait_on_sequence(struct nfs_seqid *seqid, struct rpc_task *task);
diff --git a/fs/nfs/nfs4state.c b/fs/nfs/nfs4state.c
index 7805f33d77a03..ca99e662d7747 100644
--- a/fs/nfs/nfs4state.c
+++ b/fs/nfs/nfs4state.c
@@ -844,10 +844,13 @@ void nfs4_close_sync(struct nfs4_state *state, fmode_t fmode)
  * be made.  Failing that, a "consistent" choice is preferable.  The
  * consistent choice we make is to prefer the first owner, that of a
  * Posix lock.
+ *
+ * Called with state->state_lock held.  No reference is taken: a lock
+ * state is freed only after it is unlinked under state->state_lock.
  */
 static struct nfs4_lock_state *
-__nfs4_find_lock_state(struct nfs4_state *state,
-		       fl_owner_t owner, fl_owner_t owner2)
+__nfs4_lookup_lock_state(struct nfs4_state *state,
+			 fl_owner_t owner, fl_owner_t owner2)
 {
 	struct nfs4_lock_state *pos, *ret = NULL;
 	list_for_each_entry(pos, &state->lock_states, ls_locks) {
@@ -858,6 +861,16 @@ __nfs4_find_lock_state(struct nfs4_state *state,
 		if (pos->ls_owner == owner2)
 			ret = pos;
 	}
+	return ret;
+}
+
+static struct nfs4_lock_state *
+__nfs4_find_lock_state(struct nfs4_state *state,
+		       fl_owner_t owner, fl_owner_t owner2)
+{
+	struct nfs4_lock_state *ret;
+
+	ret = __nfs4_lookup_lock_state(state, owner, owner2);
 	if (ret)
 		refcount_inc(&ret->ls_count);
 	return ret;
@@ -1006,7 +1019,7 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 	fl_flock_owner = l_ctx->open_context->flock_owner;
 
 	spin_lock(&state->state_lock);
-	lsp = __nfs4_find_lock_state(state, owner, fl_flock_owner);
+	lsp = __nfs4_lookup_lock_state(state, owner, fl_flock_owner);
 	if (lsp && test_bit(NFS_LOCK_LOST, &lsp->ls_flags))
 		ret = -EIO;
 	else if (lsp != NULL && test_bit(NFS_LOCK_INITIALIZED, &lsp->ls_flags) != 0) {
@@ -1014,11 +1027,28 @@ static int nfs4_copy_lock_stateid(nfs4_stateid *dst,
 		ret = 0;
 	}
 	spin_unlock(&state->state_lock);
-	nfs4_put_lock_state(lsp);
 out:
 	return ret;
 }
 
+bool nfs4_lock_context_lost(struct nfs4_state *state,
+			    const struct nfs_lock_context *l_ctx)
+{
+	struct nfs4_lock_state *lsp;
+	bool ret;
+
+	if (!test_bit(LK_STATE_IN_USE, &state->flags))
+		return false;
+
+	spin_lock(&state->state_lock);
+	lsp = __nfs4_lookup_lock_state(state, l_ctx->lockowner,
+				       l_ctx->open_context->flock_owner);
+	ret = lsp && test_bit(NFS_LOCK_LOST, &lsp->ls_flags);
+	spin_unlock(&state->state_lock);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(nfs4_lock_context_lost);
+
 bool nfs4_copy_open_stateid(nfs4_stateid *dst, struct nfs4_state *state)
 {
 	bool ret;
-- 
2.53.0

