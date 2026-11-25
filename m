Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618046;
	b=GIKgg/Ocnpu1sspWANDIdiz07D3Wt+paXmOwQ8wqkIP6iSme2nSpiJMF4Ul5VugSnVgK
	 6X568XQTrDARpYMuey413BXOVjOAT+mrHTJxJuZJ4MVppiIOTc99zFUv/4aT/09OpBCJM
	 VrJZk1n4zj0cs/a/yRoHBR/55pi51kyVvGOPexKiiE7dn2nLqVR9VX+7zBd9eP15JEIku
	 wVBPjyTo/m1uYNZmxVyNF+ylXShejj54BcIlzRaW2bGcl8QpKD8CYSHTu0cNjkMCb9XDf
	 PFEp8Chzy5s+wk960lO1piZG5w1tLyWRn3vLyc2JU1KDYNpXwcp+EPkMQvoL60E+H5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618046;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CziEIYDJsY5jut+fq+jocznnYSs5ZsZkSwt8TGjG8Ew=;
	b=zM2Bg7BPRih50QhhO6kfo2T/VBjjvw4Cccd/nnZFjEDv/W9yjOpOnKBzAxoXZG7QoHkV
	 1zb/YF5ofBXXvfqHQ6CHHhpiHK2KvsYy0EXdg2Oc4Jq6gRC81Vgc9gBwhDUBUeA27jE0k
	 K6wFuLFZi5Xy91rqxOobClj21lAuHYAiINSTkWeDUykDR7jIE0bEnG2r+KuLwfu54vkiB
	 aJxGIBQ0RNw2VjYMj7WXO650mnCs+4IynWJwDRjY+fVem2eemLpn+mp6yLwkaXQjtcAIK
	 /i2JwFNDb8qcEfJ4BP7WGTxJ1UdooSCIxWpR1YYMdGGHETd2qQv29c7n4qZeHwMMw1A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHeXht6X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60811606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHeXht6X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 312891F000CA;
	Wed, 25 Nov 2026 14:47:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795618045;
	bh=CziEIYDJsY5jut+fq+jocznnYSs5ZsZkSwt8TGjG8Ew=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHeXht6XnI6Vi2wOHdxTKAZ8Uw2qLPH+QcxFwATzclAAF6Aetw2O+dIFZDkF8s4VU
	 lU5Td1sDwybgeQzj0wGrOCTc3Q3BYLavuiBE7zqH/JWY21vUQ1hmmiy9/NShiih516
	 9MAffFRpeDsHiGQfo2Tw+9BqUfsC3k8TCWjevUK7ZEYLsR0xvzIZ4ssyQUnbWeKgJx
	 HermvVng+T4fNEDVvJS7ZYFtwnwDuLkaBwP5mOPAA8pclcSfU+TgacYJR+aW5NUC4I
	 hDGd+CfYFn9RFN0c3xpohO+zF+wX/O+HOTv9qNwo1i/EBMLqWvISjTARjHkL9R2DW1
	 6GUPAtxB0LE2A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tim Menninger <tmenninger@everpuredata.com>,
	Chuck Lever <cel@kernel.org>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] xprtrdma: serialize unmap_sync with xprt_disconnect
Date: Wed, 25 Nov 2026 09:47:21 -0500
Message-ID: <20261125144713.4170491-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125144713.4170491-1-sashal@kernel.org>
References: <2026112556-maker-tabloid-5d68@gregkh>
 <20261125144713.4170491-1-sashal@kernel.org>
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

From: Tim Menninger <tmenninger@everpuredata.com>

[ Upstream commit 1fa415883c37b02ff17acdd7977ed591d3d389ee ]

frwr_unmap_sync() posts LOCAL_INV Work Requests to the QP and waits
for the matching CQE. This can race with rpcrdma_xprt_disconnect():

    1. frwr_unmap_sync() samples r_xprt->rx_ep
    2. rpcrdma_xprt_disconnect() drains the QP
    3. frwr_unmap_sync() posts LOCAL_INV WRs after the drain
    4. No CQE arrives, so wait_for_completion() blocks indefinitely

The hung task appears in the rpciod workqueue:

Workqueue: rpciod rpc_async_schedule [sunrpc]
    wait_for_completion()
    frwr_unmap_sync()
    xprt_rdma_free()
    xprt_release()

Serialize synchronous MR invalidation against QP teardown with
rx_unmap_rwsem. frwr_unmap_sync() holds the read side while it builds
and submits the LOCAL_INV chain. Disconnect holds the write side across
QP drain and resource teardown. Drop the read side before waiting so
disconnect can drain the submitted Work Requests and deliver their CQEs.

Disconnect can reset a request while frwr_unmap_sync() waits for the
read side. Recheck rl_registered after acquiring the rwsem and return
without posting if the request has already been reset.

Move the synchronous invalidation completion from the final MR to the
request, whose lifetime covers xprt_rdma_free(). This allows disconnect
to destroy MRs after draining the QP while frwr_unmap_sync() is still
waiting. On a post failure, call rpcrdma_force_disconnect() before
dropping the read side so the endpoint is not dereferenced after
disconnect can run.

frwr_unmap_async() runs inline from Receive completion processing.
rpcrdma_xprt_drain() drains the Receive Queue before the Send Queue, so
asynchronous LOCAL_INV Work Requests are submitted before Send Queue
drain. frwr_unmap_sync(), however, runs from xprt_rdma_free() after the
transport send lock has been released, so it is not ordered against
disconnect.

Tested on v7.4-rc1 under pNFS load with repeated data server restarts
to provoke rapid QP disconnect/reconnect cycling. Without the fix, a
hung task in frwr_unmap_sync() reproduced twice in six attempts. With
the fix, no hang occurred across 200 cycles.

Also observed on v6.8 and v6.18.34.

Fixes: e28ce90083f0 ("xprtrdma: kmalloc rpcrdma_ep separate from rpcrdma_xprt")
Cc: stable@vger.kernel.org
Assisted-by: Claude:opus-4-7
Reviewed-by: Chuck Lever <cel@kernel.org>
Signed-off-by: Tim Menninger <tmenninger@everpuredata.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/frwr_ops.c  | 89 ++++++++++++++++++++-------------
 net/sunrpc/xprtrdma/transport.c |  2 +
 net/sunrpc/xprtrdma/verbs.c     | 16 ++++--
 net/sunrpc/xprtrdma/xprt_rdma.h | 10 +++-
 4 files changed, 78 insertions(+), 39 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index a974d5cac7e1c..96e8f109975de 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -27,13 +27,17 @@
 
 /* Transport recovery
  *
- * frwr_map and frwr_unmap_* cannot run at the same time the transport
- * connect worker is running. The connect worker holds the transport
- * send lock, just as ->send_request does. This prevents frwr_map and
- * the connect worker from running concurrently. When a connection is
- * closed, the Receive completion queue is drained before the allowing
- * the connect worker to get control. This prevents frwr_unmap and the
- * connect worker from running concurrently.
+ * frwr_map() is serialized with the connect worker by the transport
+ * send lock.
+ *
+ * frwr_unmap_async() runs from Receive completion processing.
+ * rpcrdma_xprt_drain() drains the Receive Queue before the Send Queue,
+ * so asynchronous LOCAL_INV Work Requests are submitted before Send
+ * Queue drain.
+ *
+ * frwr_unmap_sync() runs after the transport send lock is released.
+ * rx_unmap_rwsem orders its LOCAL_INV submission before disconnect
+ * drains the QP.
  *
  * When the underlying transport disconnects, MRs that are in flight
  * are flushed and are likely unusable. Thus all MRs are destroyed.
@@ -139,7 +143,6 @@ int frwr_mr_init(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
 	mr->mr_ibmr = frmr;
 	mr->mr_device = NULL;
 	INIT_LIST_HEAD(&mr->mr_list);
-	init_completion(&mr->mr_linv_done);
 	frwr_cid_init(ep, mr);
 
 	sg_init_table(sg, depth);
@@ -537,40 +540,60 @@ static void frwr_wc_localinv(struct ib_cq *cq, struct ib_wc *wc)
  * @cq: completion queue
  * @wc: WCE for a completed LocalInv WR
  *
- * Awaken anyone waiting for an MR to finish being fenced.
+ * Wake frwr_unmap_sync() after the final LOCAL_INV completion.
  */
 static void frwr_wc_localinv_wake(struct ib_cq *cq, struct ib_wc *wc)
 {
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct rpcrdma_mr *mr = container_of(cqe, struct rpcrdma_mr, mr_cqe);
+	struct rpcrdma_req *req = mr->mr_req;
 
 	/* WARNING: Only wr_cqe and status are reliable at this point */
 	trace_xprtrdma_wc_li_wake(wc, &mr->mr_cid);
 	frwr_mr_done(wc, mr);
-	complete(&mr->mr_linv_done);
+	complete(&req->rl_linv_done);
 
 	rpcrdma_flush_disconnect(cq->cq_context, wc);
 }
 
 /**
- * frwr_unmap_sync - invalidate memory regions that were registered for @req
+ * frwr_unmap_sync - synchronously invalidate MRs registered for @req
  * @r_xprt: controlling transport instance
- * @req: rpcrdma_req with a non-empty list of MRs to process
+ * @req: request whose registered MRs are to be invalidated
  *
- * Sleeps until it is safe for the host CPU to access the previously mapped
- * memory regions. This guarantees that registered MRs are properly fenced
- * from the server before the RPC consumer accesses the data in them. It
- * also ensures proper Send flow control: waking the next RPC waits until
- * this RPC has relinquished all its Send Queue entries.
+ * If @req still owns registered MRs after synchronizing with transport
+ * disconnect, post a chain of LOCAL_INV Work Requests and wait for the
+ * final completion. On successful completion, this fences the mapped
+ * regions from remote access and preserves Send Queue flow control.
+ *
+ * A concurrent disconnect can reset @req while this function waits for
+ * the read side. In that case the MRs have already been released and no
+ * LOCAL_INV Work Requests are posted.
+ *
+ * Context: Process context. Takes and releases
+ *	    @r_xprt->rx_unmap_rwsem for read. May sleep.
  */
 void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 {
 	struct ib_send_wr *first, **prev, *last;
-	struct rpcrdma_ep *ep = r_xprt->rx_ep;
 	const struct ib_send_wr *bad_wr;
+	struct rpcrdma_ep *ep;
 	struct rpcrdma_mr *mr;
 	int rc;
 
+	/* serialize against rpcrdma_xprt_disconnect() */
+	down_read(&r_xprt->rx_unmap_rwsem);
+
+	/*
+	 * Disconnect can reset this request while we wait for the read side.
+	 * Recheck rl_registered in case rx_ep now refers to a new connection.
+	 */
+	ep = r_xprt->rx_ep;
+	if (!ep || list_empty(&req->rl_registered)) {
+		up_read(&r_xprt->rx_unmap_rwsem);
+		return;
+	}
+
 	/* ORDER: Invalidate all of the MRs first
 	 *
 	 * Chain the LOCAL_INV Work Requests and post them with
@@ -597,37 +620,35 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 		prev = &last->next;
 	} while ((mr = rpcrdma_mr_pop(&req->rl_registered)));
 
-	mr = container_of(last, struct rpcrdma_mr, mr_invwr);
-
 	/* Strong send queue ordering guarantees that when the
 	 * last WR in the chain completes, all WRs in the chain
 	 * are complete.
 	 */
 	last->wr_cqe->done = frwr_wc_localinv_wake;
-	reinit_completion(&mr->mr_linv_done);
+	reinit_completion(&req->rl_linv_done);
 
-	/* Transport disconnect drains the receive CQ before it
-	 * replaces the QP. The RPC reply handler won't call us
-	 * unless re_id->qp is a valid pointer.
+	/*
+	 * The read side prevents disconnect from draining this QP until the
+	 * LOCAL_INV chain has been submitted.
 	 */
 	bad_wr = NULL;
 	rc = ib_post_send(ep->re_id->qp, first, &bad_wr);
+	if (rc) {
+		/* On error, the MRs get destroyed once the QP has drained. */
+		trace_xprtrdma_post_linv_err(req, rc);
+
+		/* Force a connection loss to ensure complete recovery.
+		 */
+		rpcrdma_force_disconnect(ep);
+	}
+	up_read(&r_xprt->rx_unmap_rwsem);
 
 	/* The final LOCAL_INV WR in the chain is supposed to
 	 * do the wake. If it was never posted, the wake will
 	 * not happen, so don't wait in that case.
 	 */
 	if (bad_wr != first)
-		wait_for_completion(&mr->mr_linv_done);
-	if (!rc)
-		return;
-
-	/* On error, the MRs get destroyed once the QP has drained. */
-	trace_xprtrdma_post_linv_err(req, rc);
-
-	/* Force a connection loss to ensure complete recovery.
-	 */
-	rpcrdma_force_disconnect(ep);
+		wait_for_completion(&req->rl_linv_done);
 }
 
 /**
diff --git a/net/sunrpc/xprtrdma/transport.c b/net/sunrpc/xprtrdma/transport.c
index 5ff8e5126a6c2..308fd79e09df3 100644
--- a/net/sunrpc/xprtrdma/transport.c
+++ b/net/sunrpc/xprtrdma/transport.c
@@ -364,6 +364,8 @@ xprt_setup_rdma(struct xprt_create *args)
 	INIT_DELAYED_WORK(&new_xprt->rx_connect_worker,
 			  xprt_rdma_connect_worker);
 
+	init_rwsem(&new_xprt->rx_unmap_rwsem);
+
 	xprt->max_payload = RPCRDMA_MAX_DATA_SEGS << PAGE_SHIFT;
 
 	return xprt;
diff --git a/net/sunrpc/xprtrdma/verbs.c b/net/sunrpc/xprtrdma/verbs.c
index 111c415f1aeda..3c44c2c28c4f3 100644
--- a/net/sunrpc/xprtrdma/verbs.c
+++ b/net/sunrpc/xprtrdma/verbs.c
@@ -572,20 +572,24 @@ int rpcrdma_xprt_connect(struct rpcrdma_xprt *r_xprt)
  * rpcrdma_xprt_disconnect - Disconnect underlying transport
  * @r_xprt: controlling transport instance
  *
- * Caller serializes. Either the transport send lock is held,
- * or we're being called to destroy the transport.
+ * Context: Caller serializes. Either the transport send lock is held,
+ *	    or the transport is being destroyed. Takes and releases
+ *	    @r_xprt->rx_unmap_rwsem for write. May sleep.
  *
  * On return, @r_xprt is completely divested of all hardware
  * resources and prepared for the next ->connect operation.
  */
 void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 {
-	struct rpcrdma_ep *ep = r_xprt->rx_ep;
+	struct rpcrdma_ep *ep;
 	struct rdma_cm_id *id;
 	int rc;
 
+	down_write(&r_xprt->rx_unmap_rwsem);
+
+	ep = r_xprt->rx_ep;
 	if (!ep)
-		return;
+		goto out_unlock;
 
 	/* Prevent teardown-generated events from requesting another close. */
 	atomic_xchg(&ep->re_force_disconnect, 1);
@@ -604,6 +608,9 @@ void rpcrdma_xprt_disconnect(struct rpcrdma_xprt *r_xprt)
 		rdma_destroy_id(id);
 
 	r_xprt->rx_ep = NULL;
+
+out_unlock:
+	up_write(&r_xprt->rx_unmap_rwsem);
 }
 
 /* Fixed-size circular FIFO queue. This implementation is wait-free and
@@ -912,6 +919,7 @@ struct rpcrdma_req *rpcrdma_req_create(struct rpcrdma_xprt *r_xprt,
 
 	INIT_LIST_HEAD(&req->rl_free_mrs);
 	INIT_LIST_HEAD(&req->rl_registered);
+	init_completion(&req->rl_linv_done);
 	spin_lock(&buffer->rb_lock);
 	list_add(&req->rl_all, &buffer->rb_allreqs);
 	spin_unlock(&buffer->rb_lock);
diff --git a/net/sunrpc/xprtrdma/xprt_rdma.h b/net/sunrpc/xprtrdma/xprt_rdma.h
index 62408e086d656..3214bf8b16187 100644
--- a/net/sunrpc/xprtrdma/xprt_rdma.h
+++ b/net/sunrpc/xprtrdma/xprt_rdma.h
@@ -46,6 +46,7 @@
 #include <linux/spinlock.h> 		/* spinlock_t, etc */
 #include <linux/atomic.h>		/* atomic_t, etc */
 #include <linux/kref.h>			/* struct kref */
+#include <linux/rwsem.h>		/* struct rw_semaphore */
 #include <linux/workqueue.h>		/* struct work_struct */
 #include <linux/llist.h>
 
@@ -248,7 +249,6 @@ struct rpcrdma_mr {
 	int			mr_nents;
 	enum dma_data_direction	mr_dir;
 	struct ib_cqe		mr_cqe;
-	struct completion	mr_linv_done;
 	union {
 		struct ib_reg_wr	mr_regwr;
 		struct ib_send_wr	mr_invwr;
@@ -347,6 +347,7 @@ struct rpcrdma_req {
 
 	struct list_head	rl_free_mrs;
 	struct list_head	rl_registered;
+	struct completion	rl_linv_done;
 };
 
 static inline struct rpcrdma_req *
@@ -448,6 +449,13 @@ struct rpcrdma_xprt {
 	struct delayed_work	rx_connect_worker;
 	struct rpc_timeout	rx_timeout;
 	struct rpcrdma_stats	rx_stats;
+
+	/*
+	 * Orders frwr_unmap_sync()'s LOCAL_INV submission ahead of the
+	 * QP drain. Disconnect holds the write side across the drain
+	 * and resource teardown.
+	 */
+	struct rw_semaphore	rx_unmap_rwsem;
 };
 
 #define rpcx_to_rdmax(x) container_of(x, struct rpcrdma_xprt, rx_xprt)
-- 
2.53.0

