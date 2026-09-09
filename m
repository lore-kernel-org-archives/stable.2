Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B375237AE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788950523; cv=none; b=NpYh4rphNRaosLwDwVjssVg6TgZNsrNyjNmv0gRGlNhf/jwrnqoIamEV4vzorLe5A57g2b67BdkdRKTZmmwow2qqAH0aDJZqzaTtoj58YAsG/ciYIQKddxlpRhr77cOVSAtMywxjc959GTyGhwiMtDRo6obbcmfnoLuPlwFWWwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788950523; c=relaxed/simple;
	bh=1vcisorHnDGTdxgrZI4EW+5CrEz+sHoHWjNwE69IOBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QS4HQmur8av++sScRJUUq/YnFmkL80YH0tiCTqqXgPvehhiJcxCeQQBIGeK7zUbEqGFJ3IXla0UeLRdk75I0CB9KDnrd1Q69JEcNfTxon+lMAluIlb4mkROt8s0xm326WEoEkd7pfF1i/ZW/uKa/LoVYdpns4NPGwAapCNPMp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lnEsDyy4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lnEsDyy4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C74AB1F00A3E;
	Wed,  9 Sep 2026 10:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788950521;
	bh=/UXvp7ILtq5yHIdx75CTq5Y0kvSiPGcDNwlcOAxuk1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lnEsDyy4bM+bZAzsSzidYE8YVgPSzBxG+So5woIJpXzy1jn8PHqQT0k66pBSGtc9m
	 wZ3bdYo8o1jQhcNxqyPqLv6ZETtJCTeT83sELzczLQuScjnKIQ6krlcBUQRZinjr17
	 jXRR0uRn2gMFMqU1lhJ+VNSRQC6xn2zxxVPfW/v5PAcVKEZceQsfHWRXBHrxDKKrMF
	 dJRuqXx61pbhgOZoEwEhECuiuOx3Akh4iTd+zZ468klEzR2g5cn70DncZ5leQnnxSh
	 v2mDsGDL2vXAlJ1YLFx7sMwMNi05nxexUJykIs2Wj7GBN623Og64RvG7XFN7C4kDy/
	 lUWcI4HCJ3pXg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/5] svcrdma: Move the svc_rdma_cc_init() call
Date: Wed,  9 Sep 2026 06:41:55 -0400
Message-ID: <20260909104158.1554268-2-sashal@kernel.org>
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

[ Upstream commit 018f34051bc9f4908336b3fe9e52931bb8410ced ]

Now that the chunk_ctxt for Reads is no longer dynamically allocated
it can be initialized once for the life of the object that contains
it (struct svc_rdma_recv_ctxt).

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

[Stable 6.1 dependency adaptation]
Keep rc_temp initialization in svc_rdma_recv_ctxt_alloc(), since this
stable tree still distinguishes temporary receive contexts. Initialize
the embedded rc_cc alongside it using the existing svc_rdma_cc_init(),
retaining cc_rdma for the stable completion and cleanup paths.

Replace per-Read chunk-context initialization with a cc_sqecount reset,
keeping the existing Read counter initialization order and synchronous
completion/release path. The release path drains cc_rwctxts before a
receive context is reused, so its list and transport can be initialized
once at allocation. No functions are added.

Preserve the preceding dependency's reconstruction changes and saved
inline argument. All hunks of target 3779b7b9e7d1 apply cleanly to this
adapted tree.

Stable-dep-of: 3779b7b9e7d1 ("svcrdma: Validate Read chunk positions before reconstruction")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h         |  2 ++
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c |  1 +
 net/sunrpc/xprtrdma/svc_rdma_rw.c       | 11 ++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 536b95e28a8e2..edf6955295fc8 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -203,6 +203,8 @@ extern int svc_rdma_recvfrom(struct svc_rqst *);
 
 /* svc_rdma_rw.c */
 extern void svc_rdma_destroy_rw_ctxts(struct svcxprt_rdma *rdma);
+extern void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
+			     struct svc_rdma_chunk_ctxt *cc);
 extern int svc_rdma_send_write_chunk(struct svcxprt_rdma *rdma,
 				     const struct svc_rdma_chunk *chunk,
 				     const struct xdr_buf *xdr);
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 186c9c12432b1..29bfbd8b72089 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -156,6 +156,7 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	ctxt->rc_recv_sge.lkey = rdma->sc_pd->local_dma_lkey;
 	ctxt->rc_recv_buf = buffer;
 	ctxt->rc_temp = false;
+	svc_rdma_cc_init(rdma, &ctxt->rc_cc);
 	return ctxt;
 
 fail2:
diff --git a/net/sunrpc/xprtrdma/svc_rdma_rw.c b/net/sunrpc/xprtrdma/svc_rdma_rw.c
index f32635d0f5216..ffe7d4a54d5f0 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_rw.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_rw.c
@@ -149,8 +149,13 @@ static void svc_rdma_cc_cid_init(struct svcxprt_rdma *rdma,
 	cid->ci_completion_id = atomic_inc_return(&rdma->sc_completion_ids);
 }
 
-static void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
-			     struct svc_rdma_chunk_ctxt *cc)
+/**
+ * svc_rdma_cc_init - Initialize an svc_rdma_chunk_ctxt
+ * @rdma: controlling transport instance
+ * @cc: svc_rdma_chunk_ctxt to be initialized
+ */
+void svc_rdma_cc_init(struct svcxprt_rdma *rdma,
+		      struct svc_rdma_chunk_ctxt *cc)
 {
 	svc_rdma_cc_cid_init(rdma, &cc->cc_cid);
 	cc->cc_rdma = rdma;
@@ -1023,8 +1028,8 @@ int svc_rdma_process_read_list(struct svcxprt_rdma *rdma,
 	struct xdr_buf *buf = &rqstp->rq_arg;
 	int ret;
 
-	svc_rdma_cc_init(rdma, cc);
 	cc->cc_cqe.done = svc_rdma_wc_read_done;
+	cc->cc_sqecount = 0;
 	head->rc_curpage = 0;
 	head->rc_pageoff = 0;
 	head->rc_readbytes = 0;
-- 
2.53.0

