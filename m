Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138A3CEBB8
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 13:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788701322; cv=none; b=Wff64tw1jyS//wrl27QiVp3UNJdulEA7KXeq4JupNkGTIk6gi2cGzoe7FCAzphV8CGvWG44pzVP5wwJeBpLjznr9uiYt0o/+UGHq+vzwaH7BjmmcmdbylRRKrPxoLnlqIvyC4qX2KEDww9kXfaWwSJ4LpLrf+3czDUsBcYWMyls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788701322; c=relaxed/simple;
	bh=7485Fes3WEYYbIySbHLeCmw7EPJPk3wTp1+qz6uwrdU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nHSaljmbufQDN6wWMRR07e0GK5Onq3wKuaVbmDnGptklLrIX/B9QInSbUoUoIARTNzzF5+bqmpF+AsiNJw+RCePEUOMeyfMHuMfwUvEFcz4csEcXGMcKEjnT7WTkmfDNcG+17Cf1xtbjb9Gz9WT4HLVYkoMJQ6BX9PqjEMLe5R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E2o0ORAC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E2o0ORAC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3431A1F00ADE;
	Sun,  6 Sep 2026 13:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788701318;
	bh=eSBw6r/XKNhjGCqRamcJFIXAZi1wO3B81+o2xzY4pQ0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=E2o0ORACS2hZ62WOgc45AKtha8qzm5KorFg4tOJE2JWN3BlMKCVcpkuy77ObSqILI
	 XYNStKQ6hrkHYmu4FfkJAuFBHU5z3JzYQbvV6odLcxRpy3MzPpK6JimBvEZvOuPcsC
	 suDPNHao2R0cXPmLTWi4lzqOUOYBaNoC/vbaxGChJ2+hlvZINcAvUgi8Cxu+2xOxoA
	 cY9uqRQgQNSAH/XBeQSl2kBfKCnncxx3182dpy9zrndHrvWv21PwwF2JcmhaIEvt8X
	 WMoFMRE66PBkdO/4KGkRpDq0A22WahOiGpEaKh0a7zM+NVdGJW9mfCMJxpfsYT6IJn
	 YqVaEKokjfu5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>,
	Chris Mason <clm@meta.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 7/7] nfsd: RCU-protect cl_cb_session to fix use-after-free on session teardown
Date: Sun,  6 Sep 2026 09:28:31 -0400
Message-ID: <20260906132831.874344-7-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906132831.874344-1-sashal@kernel.org>
References: <2026090304-heroism-outclass-581e@gregkh>
 <20260906132831.874344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jeff Layton <jlayton@kernel.org>

[ Upstream commit 01c5d5f58a5db9b0ee5afba2e49d3157788687b2 ]

After a DESTROY_SESSION the per-session teardown path can free a
session while rpciod still holds an inflight callback rpc_task that
dereferences clp->cl_cb_session.  nfsd4_probe_callback_sync() flushes
cl_callback_wq, but once nfsd4_run_cb_work() has called
rpc_call_async() the rpc_task lives on rpciod; flushing the workqueue
does not wait for it.  rpc_shutdown_client() does drain rpciod tasks,
but uses a 1-second wait_event_timeout — tasks stuck in rpc_delay()
(e.g. 2-second NFS4ERR_DELAY retries) can outlive the drain.

    destroy path                       rpciod
    ------------                       ------
    unhash_session(ses)
    nfsd4_probe_callback_sync(clp)
      flush_workqueue(cl_callback_wq)
      /* returns; rpc_task still live */
    nfsd4_put_session_locked(ses)
    free_session(ses) -> kfree(ses)
                                       nfsd4_cb_sequence_done()
                                         reads cb_clp->cl_cb_session
                                         /* freed slab */

A second window exists in nfsd4_process_cb_update().  When
__nfsd4_find_backchannel() returns NULL because unhash_session() has
already removed the destroyed session from cl_sessions,
setup_callback_client() takes the v4.1 early return so
clp->cl_cb_session = ses never fires and the field retains a pointer
to the about-to-be-freed session.

Fix both by converting cl_cb_session to an RCU-protected pointer:

  - Move the cl_cb_session = ses assignment in setup_callback_client()
    to after rpc_create() succeeds, so it is only published when a
    working backchannel exists.  Clear cl_cb_session on the error
    return in nfsd4_process_cb_update().  Both stores use
    rcu_assign_pointer().

  - Annotate cl_cb_session with __rcu.  All rpciod-side readers use
    rcu_read_lock()/rcu_dereference() and check for NULL, bailing to
    the appropriate error or requeue path:
    encode_cb_sequence4args(), decode_cb_sequence4resok(),
    nfsd41_cb_get_slot(), nfsd41_cb_release_slot(),
    nfsd4_cb_prepare(), and nfsd4_cb_sequence_done().

  - Switch __free_session() from kfree() to kfree_rcu() so the
    session slab is not reclaimed until after an RCU grace period,
    guaranteeing that rpciod readers inside rcu_read_lock() never
    dereference freed memory.

  - Pass the session pointer to the nfsd_cb_seq_status and
    nfsd_cb_free_slot tracepoints instead of having them re-read
    cl_cb_session.

  - nfsd4_cb_prepare() calls rpc_exit() when the session is NULL,
    routing through the done/release path to requeue the callback.

Fixes: dcbeaa68dbbd ("nfsd4: allow backchannel recovery")
Cc: stable@vger.kernel.org
Reported-by: Chris Mason <clm@meta.com>
Signed-off-by: Chris Mason <clm@meta.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260530-nfsd-fixes-v2-2-f27e8eb4d974@kernel.org
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
[ adapted RCU callback-session handling to the older single client-wide callback slot model. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfsd/nfs4callback.c | 74 +++++++++++++++++++++++++++++++++++-------
 fs/nfsd/nfs4state.c    |  4 +--
 fs/nfsd/state.h        |  3 +-
 3 files changed, 66 insertions(+), 15 deletions(-)

diff --git a/fs/nfsd/nfs4callback.c b/fs/nfsd/nfs4callback.c
index 00e3664727fd9..aa7816d4bee27 100644
--- a/fs/nfsd/nfs4callback.c
+++ b/fs/nfsd/nfs4callback.c
@@ -373,12 +373,19 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 				    const struct nfsd4_callback *cb,
 				    struct nfs4_cb_compound_hdr *hdr)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_session *session;
 	__be32 *p;
 
 	if (hdr->minorversion == 0)
 		return;
 
+	rcu_read_lock();
+	session = rcu_dereference(cb->cb_clp->cl_cb_session);
+	if (!session) {
+		rcu_read_unlock();
+		return;
+	}
+
 	encode_nfs_cb_opnum4(xdr, OP_CB_SEQUENCE);
 	encode_sessionid4(xdr, session);
 
@@ -390,6 +397,7 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 	xdr_encode_empty_array(p);		/* csa_referring_call_lists */
 
 	hdr->nops++;
+	rcu_read_unlock();
 }
 
 /*
@@ -416,21 +424,32 @@ static void encode_cb_sequence4args(struct xdr_stream *xdr,
 static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 				    struct nfsd4_callback *cb)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_session *session;
 	int status = -ESERVERFAULT;
 	__be32 *p;
 	u32 dummy;
 
+	rcu_read_lock();
+	session = rcu_dereference(cb->cb_clp->cl_cb_session);
+	if (!session) {
+		rcu_read_unlock();
+		cb->cb_seq_status = -NFS4ERR_BADSESSION;
+		return -NFS4ERR_BADSESSION;
+	}
+
 	/*
 	 * If the server returns different values for sessionID, slotID or
 	 * sequence number, the server is looney tunes.
 	 */
 	p = xdr_inline_decode(xdr, NFS4_MAX_SESSIONID_LEN + 4 + 4 + 4 + 4);
-	if (unlikely(p == NULL))
+	if (unlikely(p == NULL)) {
+		rcu_read_unlock();
 		goto out_overflow;
+	}
 
 	if (memcmp(p, session->se_sessionid.data, NFS4_MAX_SESSIONID_LEN)) {
 		dprintk("NFS: %s Invalid session id\n", __func__);
+		rcu_read_unlock();
 		goto out;
 	}
 	p += XDR_QUADLEN(NFS4_MAX_SESSIONID_LEN);
@@ -438,18 +457,21 @@ static int decode_cb_sequence4resok(struct xdr_stream *xdr,
 	dummy = be32_to_cpup(p++);
 	if (dummy != session->se_cb_seq_nr) {
 		dprintk("NFS: %s Invalid sequence number\n", __func__);
+		rcu_read_unlock();
 		goto out;
 	}
 
 	dummy = be32_to_cpup(p++);
 	if (dummy != 0) {
 		dprintk("NFS: %s Invalid slotid\n", __func__);
+		rcu_read_unlock();
 		goto out;
 	}
 
 	/*
 	 * FIXME: process highest slotid and target highest slotid
 	 */
+	rcu_read_unlock();
 	status = 0;
 out:
 	cb->cb_seq_status = status;
@@ -999,9 +1021,8 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 	} else {
 		if (!conn->cb_xprt || !ses)
 			return -EINVAL;
-		clp->cl_cb_session = ses;
 		args.bc_xprt = conn->cb_xprt;
-		args.prognumber = clp->cl_cb_session->se_cb_prog;
+		args.prognumber = ses->se_cb_prog;
 		args.protocol = conn->cb_xprt->xpt_class->xcl_ident |
 				XPRT_TRANSPORT_BC;
 		args.authflavor = ses->se_cb_sec.flavor;
@@ -1019,8 +1040,10 @@ static int setup_callback_client(struct nfs4_client *clp, struct nfs4_cb_conn *c
 		return -ENOMEM;
 	}
 
-	if (clp->cl_minorversion != 0)
+	if (clp->cl_minorversion != 0) {
 		clp->cl_cb_conn.cb_xprt = conn->cb_xprt;
+		rcu_assign_pointer(clp->cl_cb_session, ses);
+	}
 	clp->cl_cb_client = client;
 	clp->cl_cb_cred = cred;
 	rcu_read_lock();
@@ -1164,20 +1187,32 @@ static void nfsd4_cb_prepare(struct rpc_task *task, void *calldata)
 	 */
 	cb->cb_seq_status = 1;
 	cb->cb_status = 0;
-	if (minorversion && !nfsd41_cb_get_slot(cb, task))
-		return;
+	if (minorversion) {
+		if (!rcu_access_pointer(clp->cl_cb_session)) {
+			rpc_exit(task, -EIO);
+			return;
+		}
+		if (!nfsd41_cb_get_slot(cb, task))
+			return;
+	}
 	rpc_call_start(task);
 }
 
 /* Returns true if CB_COMPOUND processing should continue */
 static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback *cb)
 {
-	struct nfsd4_session *session = cb->cb_clp->cl_cb_session;
+	struct nfsd4_session *session;
 	bool ret = false;
 
 	if (!cb->cb_holds_slot)
 		goto requeue;
 
+	rcu_read_lock();
+	session = rcu_dereference(cb->cb_clp->cl_cb_session);
+	if (!session) {
+		rcu_read_unlock();
+		goto requeue;
+	}
 	switch (cb->cb_seq_status) {
 	case 0:
 		/*
@@ -1197,18 +1232,24 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 	case 1:
 	case -NFS4ERR_BADSESSION:
 		nfsd4_mark_cb_fault(cb->cb_clp, cb->cb_seq_status);
+		rcu_read_unlock();
 		goto requeue;
 	case -NFS4ERR_DELAY:
 		cb->cb_seq_status = 1;
-		if (RPC_SIGNALLED(task) || !rpc_restart_call(task))
+		if (RPC_SIGNALLED(task) || !rpc_restart_call(task)) {
+			rcu_read_unlock();
 			goto requeue;
+		}
 		rpc_delay(task, 2 * HZ);
+		rcu_read_unlock();
 		return false;
 	case -NFS4ERR_BADSLOT:
+		rcu_read_unlock();
 		goto retry_nowait;
 	case -NFS4ERR_SEQ_MISORDERED:
 		if (session->se_cb_seq_nr != 1) {
 			session->se_cb_seq_nr = 1;
+			rcu_read_unlock();
 			goto retry_nowait;
 		}
 		break;
@@ -1217,10 +1258,10 @@ static bool nfsd4_cb_sequence_done(struct rpc_task *task, struct nfsd4_callback
 		dprintk("%s: unprocessed error %d\n", __func__,
 			cb->cb_seq_status);
 	}
-
 	nfsd41_cb_release_slot(cb);
 	dprintk("%s: freed slot, new seqid=%d\n", __func__,
 		session->se_cb_seq_nr);
+	rcu_read_unlock();
 	return ret;
 retry_nowait:
 	/*
@@ -1347,7 +1388,15 @@ static struct nfsd4_conn * __nfsd4_find_backchannel(struct nfs4_client *clp)
  * Note there isn't a lot of locking in this code; instead we depend on
  * the fact that it is run from the callback_wq, which won't run two
  * work items at once.  So, for example, callback_wq handles all access
- * of cl_cb_client and all calls to rpc_create or rpc_shutdown_client.
+ * of cl_cb_client, and all calls to rpc_create or
+ * rpc_shutdown_client.
+ *
+ * cl_cb_session is written only from callback_wq (via
+ * rcu_assign_pointer) and read from rpciod under rcu_read_lock (via
+ * rcu_dereference) by encode_cb_sequence4args(), decode_cb_sequence4resok(),
+ * and nfsd4_cb_sequence_done(). Sessions are freed with kfree_rcu() so that
+ * rpciod readers in an RCU read-side critical section never dereference a
+ * freed session.
  */
 static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 {
@@ -1394,6 +1443,7 @@ static void nfsd4_process_cb_update(struct nfsd4_callback *cb)
 		nfsd4_mark_cb_down(clp, err);
 		if (c)
 			svc_xprt_put(c->cn_xprt);
+		rcu_assign_pointer(clp->cl_cb_session, ses);
 		return;
 	}
 }
diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 375d48e6093eb..c6e1b04376a23 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -1976,7 +1976,7 @@ static void nfsd4_del_conns(struct nfsd4_session *s)
 static void __free_session(struct nfsd4_session *ses)
 {
 	free_session_slots(ses);
-	kfree(ses);
+	kfree_rcu(ses, rcu_head);
 }
 
 static void free_session(struct nfsd4_session *ses)
@@ -2942,7 +2942,7 @@ static struct nfs4_client *create_client(struct xdr_netobj name,
 	clear_bit(0, &clp->cl_cb_slot_busy);
 	copy_verf(clp, verf);
 	memcpy(&clp->cl_addr, sa, sizeof(struct sockaddr_storage));
-	clp->cl_cb_session = NULL;
+	RCU_INIT_POINTER(clp->cl_cb_session, NULL);
 	clp->net = net;
 	clp->cl_nfsd_dentry = nfsd_client_mkdir(
 		nn, &clp->cl_nfsdfs,
diff --git a/fs/nfsd/state.h b/fs/nfsd/state.h
index 10d1b418e0c7c..649ca2c0844b0 100644
--- a/fs/nfsd/state.h
+++ b/fs/nfsd/state.h
@@ -273,6 +273,7 @@ struct nfsd4_session {
 	struct list_head	se_conns;
 	u32			se_cb_prog;
 	u32			se_cb_seq_nr;
+	struct rcu_head		rcu_head;
 	struct nfsd4_slot	*se_slots[];	/* forward channel slots */
 };
 
@@ -381,7 +382,7 @@ struct nfs4_client {
 #define NFSD4_CB_FAULT		3
 	int			cl_cb_state;
 	struct nfsd4_callback	cl_cb_null;
-	struct nfsd4_session	*cl_cb_session;
+	struct nfsd4_session	__rcu *cl_cb_session;
 
 	/* for all client information that callback code might need: */
 	spinlock_t		cl_lock;
-- 
2.53.0

