Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE9A2343BE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919776; cv=none; b=ICA5V8kp4mxbjjJH0l+acma/uvk/e1NJHI6fIxx+t+8fMf99v5gikMDD8NCMMJtatLcbMvmifd6kslmOYIOCmCWxOKzkJ4mG4EvOTsI4fC6AW60euBJt45MkII1J5SHzvuIwktR7tK6hphsiA/e+PehLKnmBYpAJP8Gh84INLIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919776; c=relaxed/simple;
	bh=oauptF0KlAKzDM2cZcIetVcdmp7Y2NVcXhZDh0cqPoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ccl78hs2EEE+1iRHIZ9bqVt5erZ6MY5M2ZJKB+ZTSspRzHtORGvGV8NrazkBZ9uy5xmZMFjHRLnCfsYomM9iqWJ0cfdXvueU9MRYY/Znn2twO8mZmUXRk2dlLtPCGCAxUIiUWf+q02CDKwayvgz0i9lpdFZRG+sWtp5jMCIcQb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjy55r+A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjy55r+A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC9E11F00A3A;
	Wed,  9 Sep 2026 02:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788919774;
	bh=1WIaThHokrSseW19Cqd8gYiJjCiMSYvHPuVV1+tPUjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wjy55r+A5RNaI1kqRzD/G8rBRUIGn7s1I5NFb0i1h8XIDcJxeaM0y2/S7qQ7MuFdQ
	 2xrbvtEP1WACO12uuEtUajlhnv7rHvhXcBgcWIp6xxSqsAv3lMu5z2uf4rMq+uWhLH
	 W7eb7Aj7iH5rLgLluFhC1LAj3/e3NPiZA/4VzDS+AKvNPE8ZFEtJc8PjW9FMgLjEXV
	 IrNB5D6Yzr/rdr1z4x8xbM+w2s+O9ACh/Cg3Ba9oYwuc6WgJ3y6p7eoLWuO7LlZQwL
	 JQ45C9WXEBawN4gEbM2CyjRHSU2htJX63oqLghTCPMNne/vftA8oT7MjAGUlKWPdY5
	 WS7EOqC5opw5g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] svcrdma: Fix SQ wake-ups
Date: Tue,  8 Sep 2026 22:09:29 -0400
Message-ID: <20260909020931.1057969-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909020931.1057969-1-sashal@kernel.org>
References: <2026090318-fretted-breach-0806@gregkh>
 <20260909020931.1057969-1-sashal@kernel.org>
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

[Stable backport preparation for 0fbe20dfe74b]
Keep the 6.1 tracepoint signatures while retaining all SQ accounting and
wake-up changes. The existing svc_rdma_wake_send_waiters() supplies the
atomic increment, ordering, and wake-up; do not increment twice.

Pass the Write PCL directly to the existing pull-up helpers, using a local
alias in svc_rdma_map_reply_msg() to preserve its public interface. Guard
the existing Reply chunk send at its caller and move successful reply page
accounting into svc_rdma_send_reply_msg(), after Send completion. These
preparatory changes preserve the stable transport's synchronous I/O and
resource lifetime rules while allowing the target's pull-up size check and
ERR_CHUNK error routing to merge cleanly. No functions are added.

The preceding backport 17122dca335f also enabled an asynchronous Read
completion consumer that references the absent recv_ctxt::rc_pages array.
Remove that helper and its receive-path branch: this tree completes Reads
synchronously in svc_rdma_process_read_list(), and nothing enqueues a Read
on sc_read_complete_q. Keep the queue declaration, initialization, and
teardown from that prerequisite. This removes the build failure without
introducing the unrelated asynchronous Read machinery.

Stable-dep-of: 0fbe20dfe74b ("svcrdma: Reject inline replies that overflow the pull-up buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 32 -----------------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c   | 47 ++++++++++++++-----------
 2 files changed, 26 insertions(+), 53 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index a9a7f8137edbc..9b5ffc0f49192 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -763,30 +763,6 @@ static bool svc_rdma_is_reverse_direction_reply(struct svc_xprt *xprt,
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
@@ -834,13 +810,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
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
@@ -878,7 +847,6 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 			goto out_readfail;
 	}
 
-complete:
 	rqstp->rq_xprt_ctxt = ctxt;
 	rqstp->rq_prot = IPPROTO_MAX;
 	svc_xprt_copy_addrs(rqstp, xprt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 599021b2391d1..d845922bd39c2 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -313,11 +313,11 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
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
@@ -333,7 +333,7 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 
 	trace_svcrdma_sq_post_err(rdma, ret);
 	svc_xprt_deferred_close(&rdma->sc_xprt);
-	wake_up(&rdma->sc_send_wait);
+	svc_rdma_wake_send_waiters(rdma, 1);
 	return ret;
 }
 
@@ -640,7 +640,7 @@ static int svc_rdma_xb_count_sges(const struct xdr_buf *xdr,
  * svc_rdma_pull_up_needed - Determine whether to use pull-up
  * @rdma: controlling transport
  * @sctxt: send_ctxt for the Send WR
- * @rctxt: Write and Reply chunks provided by client
+ * @write_pcl: Write chunk list provided by client
  * @xdr: xdr_buf containing RPC message to transmit
  *
  * Returns:
@@ -649,7 +649,7 @@ static int svc_rdma_xb_count_sges(const struct xdr_buf *xdr,
  */
 static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
 				    const struct svc_rdma_send_ctxt *sctxt,
-				    const struct svc_rdma_recv_ctxt *rctxt,
+				    const struct svc_rdma_pcl *write_pcl,
 				    const struct xdr_buf *xdr)
 {
 	/* Resources needed for the transport header */
@@ -659,7 +659,7 @@ static bool svc_rdma_pull_up_needed(const struct svcxprt_rdma *rdma,
 	};
 	int ret;
 
-	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+	ret = pcl_process_nonpayloads(write_pcl, xdr,
 				      svc_rdma_xb_count_sges, &args);
 	if (ret < 0)
 		return false;
@@ -715,7 +715,7 @@ static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
  * svc_rdma_pull_up_reply_msg - Copy Reply into a single buffer
  * @rdma: controlling transport
  * @sctxt: send_ctxt for the Send WR; xprt hdr is already prepared
- * @rctxt: Write and Reply chunks provided by client
+ * @write_pcl: Write chunk list provided by client
  * @xdr: prepared xdr_buf containing RPC message
  *
  * The device is not capable of sending the reply directly.
@@ -730,7 +730,7 @@ static int svc_rdma_xb_linearize(const struct xdr_buf *xdr,
  */
 static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
 				      struct svc_rdma_send_ctxt *sctxt,
-				      const struct svc_rdma_recv_ctxt *rctxt,
+				      const struct svc_rdma_pcl *write_pcl,
 				      const struct xdr_buf *xdr)
 {
 	struct svc_rdma_pullup_data args = {
@@ -738,7 +738,7 @@ static int svc_rdma_pull_up_reply_msg(const struct svcxprt_rdma *rdma,
 	};
 	int ret;
 
-	ret = pcl_process_nonpayloads(&rctxt->rc_write_pcl, xdr,
+	ret = pcl_process_nonpayloads(write_pcl, xdr,
 				      svc_rdma_xb_linearize, &args);
 	if (ret < 0)
 		return ret;
@@ -766,6 +766,7 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
 			   const struct svc_rdma_recv_ctxt *rctxt,
 			   const struct xdr_buf *xdr)
 {
+	const struct svc_rdma_pcl *write_pcl = &rctxt->rc_write_pcl;
 	struct svc_rdma_map_data args = {
 		.md_rdma	= rdma,
 		.md_ctxt	= sctxt,
@@ -784,10 +785,10 @@ int svc_rdma_map_reply_msg(struct svcxprt_rdma *rdma,
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
 
@@ -833,6 +834,12 @@ static int svc_rdma_send_reply_msg(struct svcxprt_rdma *rdma,
 
 	ret = wait_for_completion_killable(&sctxt->sc_done);
 	svc_rdma_send_ctxt_put(rdma, sctxt);
+
+	/* Prevent svc_xprt_release() from releasing the page backing
+	 * rq_res.head[0].iov_base. It's no longer being accessed by
+	 * the I/O device. */
+	if (!ret)
+		rqstp->rq_respages++;
 	return ret;
 }
 
@@ -945,10 +952,13 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
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
@@ -968,11 +978,6 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	ret = svc_rdma_send_reply_msg(rdma, sctxt, rctxt, rqstp);
 	if (ret < 0)
 		goto put_ctxt;
-
-	/* Prevent svc_xprt_release() from releasing the page backing
-	 * rq_res.head[0].iov_base. It's no longer being accessed by
-	 * the I/O device. */
-	rqstp->rq_respages++;
 	return 0;
 
 reply_chunk:
-- 
2.53.0

