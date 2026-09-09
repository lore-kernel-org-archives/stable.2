Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E32F319CD0A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914191; cv=none; b=g5jXpWALGSiTkIvEnlW+MeihrfdrJvS/pbcCXG5qdMmm19jSL0+XevnDj1tLunDtXlRcFLzk0Jomykb39i5it5RIshuja5OItblCelZk5Ofdw84Ir3E8ydtg1goeDttwPaeadkJIqwb3HgdrjMef7PS+VRueaGsBZC2dWSM3Cic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914191; c=relaxed/simple;
	bh=BIO0y56ELI+Zu0qw8PTkEmVm/xoNh/ARBewG8lbGVfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ee7X8pqli1Q50vwpGX/+ZWD70sRkAx9N9Zc6mgtEvEiIuQ6rpK4cLh4cnqc0ba1vPuALYo5P5rNkgUrZbvu/Syu4GP7L/59dwAcaAzoWTpEyxtfWBVzfDiYFTccdPYRJ5DL//nYOnx2mwjD366aKjG8SyKnLmXwxU4sMNpvnfms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IxWvSKo4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IxWvSKo4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CEC51F00A3A;
	Wed,  9 Sep 2026 00:36:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914189;
	bh=PY8NxKlePOcryr9j3VyLnvJOHssJAvAjE46jldBOxrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IxWvSKo45vfwK4RX9Bd8BE7P6aSQJPRo3X/TMIxPQTKZMGaPx92+6rztymR3oFDcF
	 LJEBeoayX9pOUFrrXdRPFoKJ4LCYeyQIpvlM80nJEil3n6+4rAy7A6oGd7dEMFTJP3
	 jZV3Nfli57PbU1JGKJkI3t7Vro3/Z9bUwR1dCpsIVpd4snqbvClM9ePMK+ZBLOMqjo
	 uP3gC68LDhTMM/CkMzL/RAIaNS/HQYC0IchyI+RYISxfHQnSqxBSeTztImUMgdj5lH
	 V/EUtEGDZjKrhfRe5xRaUKe4e2MuWCHsZaBRnDbWH1l2UFGB659SLA1AmM+Cs72B+E
	 gKY9QujrhFlbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] svcrdma: Add back svcxprt_rdma::sc_read_complete_q
Date: Tue,  8 Sep 2026 20:36:24 -0400
Message-ID: <20260909003627.747182-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090317-dining-snippet-cb36@gregkh>
References: <2026090317-dining-snippet-cb36@gregkh>
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
Stable-dep-of: 0fbe20dfe74b ("svcrdma: Reject inline replies that overflow the pull-up buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h          |  1 +
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c  | 37 +++++++++++++++++++++++-
 net/sunrpc/xprtrdma/svc_rdma_transport.c |  1 +
 3 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index a5ee0af2a3103..c7a796527dada 100644
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
index 9cec7bcb8a976..b83671f9d64db 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -373,6 +373,10 @@ void svc_rdma_flush_recv_queues(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
 
+	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_read_complete_q))) {
+		list_del(&ctxt->rc_list);
+		svc_rdma_recv_ctxt_put(rdma, ctxt);
+	}
 	while ((ctxt = svc_rdma_next_recv_ctxt(&rdma->sc_rq_dto_q))) {
 		list_del(&ctxt->rc_list);
 		svc_rdma_recv_ctxt_put(rdma, ctxt);
@@ -760,6 +764,30 @@ static bool svc_rdma_is_reverse_direction_reply(struct svc_xprt *xprt,
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
@@ -804,8 +832,14 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 
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
@@ -843,6 +877,7 @@ int svc_rdma_recvfrom(struct svc_rqst *rqstp)
 			goto out_readfail;
 	}
 
+complete:
 	rqstp->rq_xprt_ctxt = ctxt;
 	rqstp->rq_prot = IPPROTO_MAX;
 	svc_xprt_copy_addrs(rqstp, xprt);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index b8d13b522298b..90eeddc5c95f6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -134,6 +134,7 @@ static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
 	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
+	INIT_LIST_HEAD(&cma_xprt->sc_read_complete_q);
 	init_llist_head(&cma_xprt->sc_send_ctxts);
 	init_llist_head(&cma_xprt->sc_recv_ctxts);
 	init_llist_head(&cma_xprt->sc_rw_ctxts);
-- 
2.53.0

