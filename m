Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1B233C465
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914188; cv=none; b=uR9TJ20GQclUtr8v4mvPLhkaUiXg4zIW2/MAMpSlJf5xS8O1fHKeRJnnLbO1NAgALrK0ARAwggLc3vmCNRf7nIJw6hbRzz/mMm7A0muP0olvXw4t8Y0yQei+RyLWMrN4/pvbhywhKCG24S6CMUdm42cXivzsrp++XwmOrvXExEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914188; c=relaxed/simple;
	bh=rryeEo2OAy+bdyXSDTDOjXTJTiIvqNRUzLev05oVCS0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpjC4hq89Gk2zsecdx0C5y9Gn5WHuM2TPou1KxQcuJw9iP5FwiCdMe813JSR5ZrcjSbXQkGGUzJ+Iz7R7sY2wPlujL13V6YMyCNAfdUhup+F7DHggZW7bE0ykJFRS5zja6x39XA5qwP+775XLRmAJqbPH73U4ugPAkUJ2mts0xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jn4uBhii; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jn4uBhii"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08E191F00A3A;
	Wed,  9 Sep 2026 00:36:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914186;
	bh=qjY+W0JChP7jbtalFco4fliX4dtATTCOlquF5clued4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Jn4uBhiiBi/fvcWvPJtNLb494LTOHT2yCFMF+y6cTZSUoRr1of3pA8VMh7IfBtFZt
	 qCd79P/ugcAqEsRkrygZ9Oj+sMa2zLFzZ/Xt/QL0D/gBPTzGHabvhIPHAiOvViIopQ
	 JkW8+ZXinC5uCrHyGi8ZE+QhSUO7wueYayrwCXZSNP8yVlPx5/n/rQ97rF/ERWK0rQ
	 KzOFJoB6iHVON0ZhNdePuk0zGX+CMC58fVkrIGfn+r5lqxr3f7GpGFaNqVhBJ4Peq4
	 cCRmhoFn6e/1KO+AUsY5ujxWAToHf2u4SVDnWfvaLaCXUAZh7KkbEtBE1rmUZu+Nkk
	 e352yU2wIJOdg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] svcrdma: Add Write chunk WRs to the RPC's Send WR chain
Date: Tue,  8 Sep 2026 20:36:23 -0400
Message-ID: <20260909003624.747050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090326-unclamped-ecosphere-df9a@gregkh>
References: <2026090326-unclamped-ecosphere-df9a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit d16f060f3ee297424c0aba047b1d49208adb9318 ]

Previously, Write chunk RDMA Writes were posted via a separate
ib_post_send() call with their own completion handler. Each Write
chunk incurred a doorbell and generated a completion event.

Link Write chunk WRs onto the RPC Reply's Send WR chain so that a
single ib_post_send() call posts both the RDMA Writes and the Send
WR. A single completion event signals that all operations have
finished. This reduces both doorbell rate and completion rate, as
well as eliminating the latency of a round-trip between the Write
chunk completion and the subsequent Send WR posting.

The lifecycle of Write chunk resources changes: previously, the
svc_rdma_write_done() completion handler released Write chunk
resources when RDMA Writes completed. With WR chaining, resources
remain live until the Send completion. A new sc_write_info_list
tracks Write chunk metadata attached to each Send context, and
svc_rdma_write_chunk_release() frees these resources when the
Send context is released.

The svc_rdma_write_done() handler now handles only error cases.
On success it returns immediately since the Send completion handles
resource release. On failure (WR flush), it closes the connection
to signal to the client that the RPC Reply is incomplete.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 01500306e1d5 ("svcrdma: Clear sc_cm_id when ADDR_CHANGE replacement fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h       | 13 +++-
 net/sunrpc/xprtrdma/svc_rdma_rw.c     | 94 ++++++++++++++++++++-------
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 10 ++-
 3 files changed, 91 insertions(+), 26 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 619fc0bd837a8..3961e86836a87 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -212,6 +212,7 @@ struct svc_rdma_recv_ctxt {
  */
 struct svc_rdma_write_info {
 	struct svcxprt_rdma	*wi_rdma;
+	struct list_head	wi_list;
 
 	const struct svc_rdma_chunk	*wi_chunk;
 
@@ -240,7 +241,10 @@ struct svc_rdma_send_ctxt {
 	struct ib_cqe		sc_cqe;
 	struct xdr_buf		sc_hdrbuf;
 	struct xdr_stream	sc_stream;
+
+	struct list_head	sc_write_info_list;
 	struct svc_rdma_write_info sc_reply_info;
+
 	void			*sc_xprt_buf;
 	int			sc_page_count;
 	int			sc_cur_sge_no;
@@ -272,11 +276,14 @@ extern void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
 extern void svc_rdma_cc_release(struct svcxprt_rdma *rdma,
 				struct svc_rdma_chunk_ctxt *cc,
 				enum dma_data_direction dir);
+extern void svc_rdma_write_chunk_release(struct svcxprt_rdma *rdma,
+					 struct svc_rdma_send_ctxt *ctxt);
 extern void svc_rdma_reply_chunk_release(struct svcxprt_rdma *rdma,
 					 struct svc_rdma_send_ctxt *ctxt);
-extern int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
-				    const struct svc_rdma_recv_ctxt *rctxt,
-				    const struct xdr_buf *xdr);
+extern int svc_rdma_prepare_write_list(struct svcxprt_rdma *rdma,
+				       const struct svc_rdma_recv_ctxt *rctxt,
+				       struct svc_rdma_send_ctxt *sctxt,
+				       const struct xdr_buf *xdr);
 extern int svc_rdma_prepare_reply_chunk(struct svcxprt_rdma *rdma,
 					const struct svc_rdma_pcl *write_pcl,
 					const struct svc_rdma_pcl *reply_pcl,
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index 448d3ee936a5b..ac6f6d15c8335 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -230,6 +230,28 @@ static void svc_rdma_write_info_free(struct svc_rdma_write_info *info)
 	queue_work(svcrdma_wq, &info->wi_work);
 }
 
+/**
+ * svc_rdma_write_chunk_release - Release Write chunk I/O resources
+ * @rdma: controlling transport
+ * @ctxt: Send context that is being released
+ *
+ * Write chunk resources remain live until Send completion because
+ * Write WRs are chained to the Send WR. This function releases all
+ * write_info structures accumulated on @ctxt->sc_write_info_list.
+ */
+void svc_rdma_write_chunk_release(struct svcxprt_rdma *rdma,
+				  struct svc_rdma_send_ctxt *ctxt)
+{
+	struct svc_rdma_write_info *info;
+
+	while (!list_empty(&ctxt->sc_write_info_list)) {
+		info = list_first_entry(&ctxt->sc_write_info_list,
+					struct svc_rdma_write_info, wi_list);
+		list_del(&info->wi_list);
+		svc_rdma_write_info_free(info);
+	}
+}
+
 /**
  * svc_rdma_reply_chunk_release - Release Reply chunk I/O resources
  * @rdma: controlling transport
@@ -286,13 +308,11 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct ib_cqe *cqe = wc->wr_cqe;
 	struct svc_rdma_chunk_ctxt *cc =
 			container_of(cqe, struct svc_rdma_chunk_ctxt, cc_cqe);
-	struct svc_rdma_write_info *info =
-			container_of(cc, struct svc_rdma_write_info, wi_cc);
 
 	switch (wc->status) {
 	case IB_WC_SUCCESS:
 		trace_svcrdma_wc_write(&cc->cc_cid);
-		break;
+		return;
 	case IB_WC_WR_FLUSH_ERR:
 		trace_svcrdma_wc_write_flush(wc, &cc->cc_cid);
 		break;
@@ -300,12 +320,11 @@ static void svc_rdma_write_done(struct ib_cq *cq, struct ib_wc *wc)
 		trace_svcrdma_wc_write_err(wc, &cc->cc_cid);
 	}
 
-	svc_rdma_wake_send_waiters(rdma, cc->cc_sqecount);
-
-	if (unlikely(wc->status != IB_WC_SUCCESS))
-		svc_xprt_deferred_close(&rdma->sc_xprt);
-
-	svc_rdma_write_info_free(info);
+	/* The RDMA Write has flushed, so the client won't get
+	 * some of the outgoing RPC message. Signal the loss
+	 * to the client by closing the connection.
+	 */
+	svc_xprt_deferred_close(&rdma->sc_xprt);
 }
 
 /**
@@ -601,13 +620,27 @@ static int svc_rdma_xb_write(const struct xdr_buf *xdr, void *data)
 	return xdr->len;
 }
 
-static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
-				     const struct svc_rdma_chunk *chunk,
-				     const struct xdr_buf *xdr)
+/*
+ * svc_rdma_prepare_write_chunk - Link Write WRs for @chunk onto @sctxt's chain
+ *
+ * Write WRs are prepended to the Send WR chain so that a single
+ * ib_post_send() posts both RDMA Writes and the final Send. Only
+ * the first WR in each chunk gets a CQE for error detection;
+ * subsequent WRs complete without individual completion events.
+ * The Send WR's signaled completion indicates all chained
+ * operations have finished.
+ */
+static int svc_rdma_prepare_write_chunk(struct svcxprt_rdma *rdma,
+					struct svc_rdma_send_ctxt *sctxt,
+					const struct svc_rdma_chunk *chunk,
+					const struct xdr_buf *xdr)
 {
 	struct svc_rdma_write_info *info;
 	struct svc_rdma_chunk_ctxt *cc;
+	struct ib_send_wr *first_wr;
 	struct xdr_buf payload;
+	struct list_head *pos;
+	struct ib_cqe *cqe;
 	int ret;
 
 	if (xdr_buf_subsegment(xdr, &payload, chunk->ch_position,
@@ -623,10 +656,25 @@ static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 	if (ret != payload.len)
 		goto out_err;
 
-	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
-	ret = svc_rdma_post_chunk_ctxt(rdma, cc);
-	if (ret < 0)
+	ret = -EINVAL;
+	if (unlikely(sctxt->sc_sqecount + cc->cc_sqecount > rdma->sc_sq_depth))
 		goto out_err;
+
+	first_wr = sctxt->sc_wr_chain;
+	cqe = &cc->cc_cqe;
+	list_for_each(pos, &cc->cc_rwctxts) {
+		struct svc_rdma_rw_ctxt *rwc;
+
+		rwc = list_entry(pos, struct svc_rdma_rw_ctxt, rw_list);
+		first_wr = rdma_rw_ctx_wrs(&rwc->rw_ctx, rdma->sc_qp,
+					   rdma->sc_port_num, cqe, first_wr);
+		cqe = NULL;
+	}
+	sctxt->sc_wr_chain = first_wr;
+	sctxt->sc_sqecount += cc->cc_sqecount;
+	list_add(&info->wi_list, &sctxt->sc_write_info_list);
+
+	trace_svcrdma_post_write_chunk(&cc->cc_cid, cc->cc_sqecount);
 	return 0;
 
 out_err:
@@ -635,17 +683,19 @@ static int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 }
 
 /**
- * svc_rdma_send_write_list - Send all chunks on the Write list
+ * svc_rdma_prepare_write_list - Construct WR chain for sending Write list
  * @rdma: controlling RDMA transport
  * @rctxt: Write list provisioned by the client
+ * @sctxt: Send WR resources
  * @xdr: xdr_buf containing an RPC Reply message
  *
- * Returns zero on success, or a negative errno if one or more
- * Write chunks could not be sent.
+ * Returns zero on success, or a negative errno if WR chain
+ * construction fails for one or more Write chunks.
  */
-int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
-			     const struct svc_rdma_recv_ctxt *rctxt,
-			     const struct xdr_buf *xdr)
+int svc_rdma_prepare_write_list(struct svcxprt_rdma *rdma,
+				const struct svc_rdma_recv_ctxt *rctxt,
+				struct svc_rdma_send_ctxt *sctxt,
+				const struct xdr_buf *xdr)
 {
 	struct svc_rdma_chunk *chunk;
 	int ret;
@@ -653,7 +703,7 @@ int svc_rdma_send_write_list(struct svcxprt_rdma *rdma,
 	pcl_for_each_chunk(chunk, &rctxt->rc_write_pcl) {
 		if (!chunk->ch_payload_length)
 			break;
-		ret = svc_rdma_send_write_chunk(rdma, chunk, xdr);
+		ret = svc_rdma_prepare_write_chunk(rdma, sctxt, chunk, xdr);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 02aed4932f57d..cdc3f7a1cef53 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -142,6 +142,7 @@ svc_rdma_send_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->sc_send_wr.sg_list = ctxt->sc_sges;
 	ctxt->sc_send_wr.send_flags = IB_SEND_SIGNALED;
 	ctxt->sc_cqe.done = svc_rdma_wc_send;
+	INIT_LIST_HEAD(&ctxt->sc_write_info_list);
 	ctxt->sc_xprt_buf = buffer;
 	xdr_buf_init(&ctxt->sc_hdrbuf, ctxt->sc_xprt_buf,
 		     rdma->sc_max_req_size);
@@ -227,6 +228,7 @@ static void svc_rdma_send_ctxt_release(struct svcxprt_rdma *rdma,
 	struct ib_device *device = rdma->sc_cm_id->device;
 	unsigned int i;
 
+	svc_rdma_write_chunk_release(rdma, ctxt);
 	svc_rdma_reply_chunk_release(rdma, ctxt);
 
 	if (ctxt->sc_page_count)
@@ -983,6 +985,12 @@ void svc_rdma_send_error_msg(struct svcxprt_rdma *rdma,
 	sctxt->sc_send_wr.num_sge = 1;
 	sctxt->sc_send_wr.opcode = IB_WR_SEND;
 	sctxt->sc_sges[0].length = sctxt->sc_hdrbuf.len;
+
+	/* Ensure only the error message is posted, not any previously
+	 * prepared Write chunk WRs.
+	 */
+	sctxt->sc_wr_chain = &sctxt->sc_send_wr;
+	sctxt->sc_sqecount = 1;
 	if (svc_rdma_post_send(rdma, sctxt))
 		goto put_ctxt;
 	return;
@@ -1030,7 +1038,7 @@ int svc_rdma_sendto(struct svc_rqst *rqstp)
 	if (!p)
 		goto put_ctxt;
 
-	ret = svc_rdma_send_write_list(rdma, rctxt, &rqstp->rq_res);
+	ret = svc_rdma_prepare_write_list(rdma, rctxt, sctxt, &rqstp->rq_res);
 	if (ret < 0)
 		goto put_ctxt;
 
-- 
2.53.0

