Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63FD525A71
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950524; cv=none; b=EY+sPNdNZ44nL5l5lc3H+YIQW/jPC0G3SFBl1mgtz6OGHl9Qgal7yIFeYI0vcMz+0VkmjexfJr4DOQrZGd0FhJ3tq6VbSFBLT/dJ0nbXJIaFapAEaY9SCF+dRWrFAIHJPIQqWQHjq3DTC/ylsEnu0/ZWg1aRX24WHU+4/7xzpd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950524; c=relaxed/simple;
	bh=HmKMCuY15qI2c6M5+JKrsBWSINpQd/iFhWWESXPqC28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G/Ch0+4Bs8jc3PL4hlfBEK984N+EkVSm3J67YxPFOWDsGbKOvHJV1p8j8X5LJ2b5jkaaJ1TprBflT65Yw+9RC33OFyFdCjpMKid2WusYzuaz/Db7Mz4TnQ0HyMFmAn2p11CRC4vjmo5CT5VaCLNzgAxEEUMy/k/s94IWNt6bj18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BO75wVKm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BO75wVKm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B20B1F00A3A;
	Wed,  9 Sep 2026 10:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950522;
	bh=o6zCbaNUoDGGgN7hIuJeVAgggfdsfBS7+FxiX6HRw2s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BO75wVKm1lW9w9lOZLFcPLG6oHtJrkM6yoql4+qyTpQOU9V6TSlCP8Ve2W9AwHYxg
	 CqjZnmIQiTt9L84Uh4MAqoFh8Jgypw15py9u7cEHivDDZstl73TApMZlJNznoEUp2b
	 SV7j6Xzke7KjO1LKnlMcMIAkaP1b16Fy8h893ZRlG70PNmVvYDlQ0aEpFHIQCGm2OU
	 Hf1QIMnuSCcBTDXkhi5ezrsUlj4Q1/oln/jP/rHCMzlmOPn4XbQYzCMZ+lqHSavSwg
	 FnlR/DbvoY426H4An+yiXeEGYfkz4VgZwPx97eKXdJZqrwJfDi+EKaHO42Bgu+xE1g
	 pdfW7ikDzoyUQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/5] svcrdma: Add back svcxprt_rdma::sc_read_complete_q
Date: Wed,  9 Sep 2026 06:41:57 -0400
Message-ID: <20260909104158.1554268-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909104158.1554268-1-sashal@kernel.org>
References: <2026090310-onto-impotence-7944@gregkh>
 <20260909104158.1554268-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit a937693a82fd2211c5e52b638959d1486a77d16a ]

Having an nfsd thread waiting for an RDMA Read completion is
problematic if the Read responder (ie, the client) stops responding.
We need to go back to handling RDMA Reads by allowing the nfsd
thread to return to the svc scheduler, then waking a second thread
finish the RPC message once the Read completion fires.

As a next step, add a list_head upon which completed Reads are queued.
A subsequent patch will make use of this queue.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 3779b7b9e7d1 ("svcrdma: Validate Read chunk positions before reconstruction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h          |  1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 37 +++++++++++++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 7f75c3a652c28..7bdec8bf1c0ba 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -97,6 +97,7 @@ struct svcxprt_rdma {
 	u32		     sc_pending_recvs;
 	u32		     sc_recv_batch;
 	struct list_head     sc_rq_dto_q;
+	struct list_head     sc_read_complete_q;
 	spinlock_t	     sc_rq_dto_lock;
 	struct ib_qp         *sc_qp;
 	struct ib_cq         *sc_rq_cq;
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 020573c0f8e7e..a3416f855a2fa 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -383,6 +383,10 @@ void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
 
+	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_read_complete_q))) {
+		list_del(&ctxt->rc_list);
+		svc_rdma_recv_ctxt_put(rdma, ctxt);
+	}
 	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_rq_dto_q))) {
 		list_del(&ctxt->rc_list);
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
@@ -770,6 +774,30 @@ static bool svc_rdma_is_reverse_direction_reply(struct svc_xprt *xprt,
 	return true;
 }
 
+static noinline void svc_rdma_read_complete(struct svc_rqst *rqstp,
+					    struct svc_rdma_recv_ctxt *ctxt)
+{
+	int i;
+
+	/* Transfer the Read chunk pages into @rqstp.rq_pages, replacing
+	 * the rq_pages that were already allocated for this rqstp.
+	 */
+	release_pages(rqstp->rq_respages, ctxt->rc_page_count);
+	for (i = 0; i < ctxt->rc_page_count; i++)
+		rqstp->rq_pages[i] = ctxt->rc_pages[i];
+
+	/* Update @rqstp's result send buffer to start after the
+	 * last page in the RDMA Read payload.
+	 */
+	rqstp->rq_respages = &rqstp->rq_pages[ctxt->rc_page_count];
+	rqstp->rq_next_page = rqstp->rq_respages + 1;
+
+	/* Prevent svc_rdma_recv_ctxt_put() from releasing the
+	 * pages in ctxt::rc_pages a second time.
+	 */
+	ctxt->rc_page_count = 0;
+}
+
 /**
  * svc_rdma_recvfrom - Receive an RPC call
  * @rqstp: request structure into which to receive an RPC Call
@@ -816,8 +844,14 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 
 	rqstp->rq_xprt_ctxt = NULL;
 
-	ctxt = NULL;
 	spin_lock(&rdma_xprt->sc_rq_dto_lock);
+	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_read_complete_q);
+	if (ctxt) {
+		list_del(&ctxt->rc_list);
+		spin_unlock_bh(&rdma_xprt->sc_rq_dto_lock);
+		svc_rdma_read_complete(rqstp, ctxt);
+		goto complete;
+	}
 	ctxt = svc_rdma_next_recv_ctxt(&rdma_xprt->sc_rq_dto_q);
 	if (ctxt)
 		list_del(&ctxt->rc_list);
@@ -855,6 +889,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 			goto out_readfail;
 	}
 
+complete:
 	rqstp->rq_xprt_ctxt = ctxt;
 	rqstp->rq_prot = IPPROTO_MAX;
 	svc_xprt_copy_addrs(rqstp, xprt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 45b0fef0b5e26..4c758a7ef60a9 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -136,6 +136,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
 	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
+	INIT_LIST_HEAD(&cma_xprt->sc_read_complete_q);
 	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	init_llist_head(&cma_xprt->sc_rw_ctxts);
-- 
2.53.0

