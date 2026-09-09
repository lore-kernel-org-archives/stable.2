Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412BE3C465
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914191; cv=none; b=tHYyaLI/GquJYqnO6OzY5bpeJbYQtuZb1Rc5TIjDfa0P0yrbPNMWJUO18Z+CV/6Intv/zROmwz42UNCcLwmpUhPDQsO7r2jXJtQRtkC+wOiBRL3rCk+2uuPSA33enRkRC2HsFfk2HWux9RvWyAOecEsBDUtATAFFU+sEQ9igmcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914191; c=relaxed/simple;
	bh=GaSNT8cHGnXfmp8FArX1i8jvX3VoEArc/sn4t5EEikA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/Vje4pWZv6BWnZCz38suRxIxIhPNu5SnAg2Awu54ci09uSH+e/WuUYc7Wr2c66FCDTE2kkTVx3OvXFNkN7Sf3TxkXA2S5G+qxfnXWUTUJM6wj79n5PC7TYVSPpuANCjryS61M8ZIfAlBprxnedJzfIR6BXhcNCxf/qNU1yupX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WmXodnP3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WmXodnP3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCAE61F00A3E;
	Wed,  9 Sep 2026 00:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914190;
	bh=Fuz7bz03YPHSVNgtGU9PcBkdM/eh8mqweLN8eQ4fXFs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WmXodnP3P23FJqwO3zAVe34BfQDsLHO47xrO24wx5Ov4DA3IuFVSsOhfMpNXau9qQ
	 008IYZ+zUc8IoZ0O3hznLgiwbixThys3R5RiHO0BHtDJndHpujQtA4N/0mctK8SVWh
	 lI24JfEMGNBY+rZgV+YcsX90wbgD2ftO+8CzncVD5S1SwlF3JwfObXgmdQGKeUJ7Zo
	 fVZr5j3ekknMnJz2O6mbC7uhZ90h1McdmV3T7y4APs0u6JX5f5vw3CPWAcImvVHWiJ
	 VXMz4MViCdfqkrNEyI9CWo8M3T7mP6rXvQfc6whPtW7svJfD1gdW5h+nP2KJxJ7lbC
	 DgbguT+W43+1A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] svcrdma: Fix SQ wake-ups
Date: Tue,  8 Sep 2026 20:36:25 -0400
Message-ID: <20260909003627.747182-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909003627.747182-1-sashal@kernel.org>
References: <2026090317-dining-snippet-cb36@gregkh>
 <20260909003627.747182-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 5b9a85899c93430ff5173748fbcb79f28af21388 ]

Ensure there is a wake-up when increasing sc_sq_avail.

Likewise, if a wake-up is done, sc_sq_avail needs to be updated,
otherwise the wait_event() conditional is never going to be met.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

For the stable backport, retain the existing one-argument SQ tracepoint.
Use the existing wake-up helper both when returning an SQ entry after
failed reservation and when ib_post_send() fails, and retry as soon as
one entry is available.

Also prepare this tree for 0fbe20dfe74b ("svcrdma: Reject inline replies
that overflow the pull-up buffer"). Pass the Write chunk list directly
to the two existing pull-up helpers, deriving it locally in
svc_rdma_map_reply_msg() so its external interface stays unchanged.
Make the nonempty Reply chunk branch explicit in svc_rdma_sendto(),
retaining the stable send_reply_chunk implementation. This aligns the
target's merge context without importing newer WR-chain machinery or
adding functions. The target's overflow check remains in the target.

The preceding sc_read_complete_q dependency also introduced a
svc_rdma_read_complete() path that refers to the absent rc_pages field.
This stable tree still waits synchronously in svc_rdma_process_read_list()
and has no producer for sc_read_complete_q. Drop that unreachable helper,
its dequeue branch, and its label, retaining the existing synchronous
Read handling and the queue's declaration/initialization/flush support.
This fixes the inherited build failure without adding functions or
backporting the asynchronous Read machinery.

Stable-dep-of: 0fbe20dfe74b ("svcrdma: Reject inline replies that overflow the pull-up buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 32 ----------------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   | 36 ++++++++++++++-----------
 2 files changed, 20 insertions(+), 48 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index b83671f9d64db..d968dd4c48a14 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -764,30 +764,6 @@ static bool svc_rdma_is_reverse_direction_reply(struct svc_xprt *xprt,
 	return true;
 }
 
-static noinline void svc_rdma_read_complete(struct svc_rqst *rqstp,
-					    struct svc_rdma_recv_ctxt *ctxt)
-{
-	int i;
-
-	/* Transfer the Read chunk pages into @rqstp.rq_pages, replacing
-	 * the rq_pages that were already allocated for this rqstp.
-	 */
-	release_pages(rqstp->rq_respages, ctxt->rc_page_count);
-	for (i = 0; i < ctxt->rc_page_count; i++)
-		rqstp->rq_pages[i] = ctxt->rc_pages[i];
-
-	/* Update @rqstp's result send buffer to start after the
-	 * last page in the RDMA Read payload.
-	 */
-	rqstp->rq_respages = &rqstp->rq_pages[ctxt->rc_page_count];
-	rqstp->rq_next_page = rqstp->rq_respages + 1;
-
-	/* Prevent svc_rdma_recv_ctxt_put() from releasing the
-	 * pages in ctxt::rc_pages a second time.
-	 */
-	ctxt->rc_page_count = 0;
-}
-
 /**
  * svc_rdma_recvfrom - Receive an RPC call
  * @rqstp: request structure into which to receive an RPC Call
@@ -833,13 +809,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 	rqstp->rq_xprt_ctxt = NULL;
 
 	spin_lock(&rdma_xprt->sc_rq_dto_lock);
-	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_read_complete_q);
-	if (ctxt) {
-		list_del(&ctxt->rc_list);
-		spin_unlock_bh(&rdma_xprt->sc_rq_dto_lock);
-		svc_rdma_read_complete(rqstp, ctxt);
-		goto complete;
-	}
 	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_rq_dto_q);
 	if (ctxt)
 		list_del(&ctxt->rc_list);
@@ -877,7 +846,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 			goto out_readfail;
 	}
 
-complete:
 	rqstp->rq_xprt_ctxt = ctxt;
 	rqstp->rq_prot = IPPROTO_MAX;
 	svc_xprt_copy_addrs(rqstp, xprt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index c6644cca52c57..3247a0aa2004b 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -326,11 +326,11 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 	/* If the SQ is full, wait until an SQ entry is available */
 	while (1) {
 		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
+			svc_rdma_wake_send_waiters(rdma, 1);
 			percpu_counter_inc(&svcrdma_stat_sq_starve);
 			trace_svcrdma_sq_full(rdma);
-			atomic_inc(&rdma->sc_sq_avail);
 			wait_event(rdma->sc_send_wait,
-				   atomic_read(&rdma->sc_sq_avail) > 1);
+				   atomic_read(&rdma->sc_sq_avail) > 0);
 			if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
 				return -ENOTCONN;
 			trace_svcrdma_sq_retry(rdma);
@@ -346,7 +346,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 
 	trace_svcrdma_sq_post_err(rdma, ret);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
-	wake_up(&rdma->sc_send_wait);
+	svc_rdma_wake_send_waiters(rdma, 1);
 	return ret;
 }
 
@@ -653,7 +653,7 @@ static int svc_rdma_xb_count_sges(const struct xdr_buf *xdr,
  * svc_rdma_pull_up_needed - Determine whether to use pull-up
  * @rdma: controlling transport
  * @sctxt: send_ctxt for the Send WR
- * @rctxt: Write and Reply chunks provided by client
+ * @write_pcl: Write chunk list provided by client
  * @xdr: xdr_buf containing RPC message to transmit
  *
  * Returns:
@@ -662,7 +662,7 @@ static int svc_rdma_xb_count_sges(const struct xdr_buf *xdr,
  */
 static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
 				    const struct svc_rdma_send_ctxt *sctxt,
-				    const struct svc_rdma_recv_ctxt *rctxt,
+				    const struct svc_rdma_pcl *write_pcl,
 				    const struct xdr_buf *xdr)
 {
 	/* Resources needed for the transport header */
@@ -672,7 +672,7 @@ static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
 	};
 	int ret;
 
-	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+	ret = pcl_process_nonpayloads(write_pcl, xdr,
 				      svc_rdma_xb_count_sges, &args);
 	if (ret < 0)
 		return false;
@@ -728,7 +728,7 @@ static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
  * svc_rdma_pull_up_reply_msg - Copy Reply into a single buffer
  * @rdma: controlling transport
  * @sctxt: send_ctxt for the Send WR; xprt hdr is already prepared
- * @rctxt: Write and Reply chunks provided by client
+ * @write_pcl: Write chunk list provided by client
  * @xdr: prepared xdr_buf containing RPC message
  *
  * The device is not capable of sending the reply directly.
@@ -743,7 +743,7 @@ static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
  */
 static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
 				      struct svc_rdma_send_ctxt *sctxt,
-				      const struct svc_rdma_recv_ctxt *rctxt,
+				      const struct svc_rdma_pcl *write_pcl,
 				      const struct xdr_buf *xdr)
 {
 	struct svc_rdma_pullup_data args = {
@@ -751,7 +751,7 @@ static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
 	};
 	int ret;
 
-	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+	ret = pcl_process_nonpayloads(write_pcl, xdr,
 				      svc_rdma_xb_linearize, &args);
 	if (ret < 0)
 		return ret;
@@ -779,6 +779,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 			   const struct svc_rdma_recv_ctxt *rctxt,
 			   const struct xdr_buf *xdr)
 {
+	const struct svc_rdma_pcl *write_pcl = &rctxt->rc_write_pcl;
 	struct svc_rdma_map_data args = {
 		.md_rdma	= rdma,
 		.md_ctxt	= sctxt,
@@ -797,10 +798,10 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 	/* For pull-up, svc_rdma_send() will sync the transport header.
 	 * No additional DMA mapping is necessary.
 	 */
-	if (svc_rdma_pull_up_needed(rdma, sctxt, rctxt, xdr))
-		return svc_rdma_pull_up_reply_msg(rdma, sctxt, rctxt, xdr);
+	if (svc_rdma_pull_up_needed(rdma, sctxt, write_pcl, xdr))
+		return svc_rdma_pull_up_reply_msg(rdma, sctxt, write_pcl, xdr);
 
-	return pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+	return pcl_process_nonpayloads(write_pcl, xdr,
 				       svc_rdma_xb_dma_map, &args);
 }
 
@@ -972,10 +973,13 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!p)
 		goto put_ctxt;
 
-	ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
-	if (ret < 0)
-		goto reply_chunk;
-	rc_size = ret;
+	rc_size = 0;
+	if (!pcl_is_empty(&rctxt->rc_reply_pcl)) {
+		ret = svc_rdma_send_reply_chunk(rdma, rctxt, &rqstp->rq_res);
+		if (ret < 0)
+			goto reply_chunk;
+		rc_size = ret;
+	}
 
 	*p++ = *rdma_argp;
 	*p++ = *(rdma_argp + 1);
-- 
2.53.0

