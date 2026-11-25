Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620087;
	b=U20h1yfTbdvcGRSXtznsWoc/WQ52XkRfmotV+yv/kvT2vxVDXYermf3gAc1gdhlneXvh
	 ZLLXogKrcxO9ItG8wWYmOsOlAp5tDKFnsfwoztbooxbC8vilYAoCjY7qaedRNr7pueuk2
	 u6KN5ewjkUWuDGPhuyetx8kQ4orLwrpZsFwXW0CTfwD71oZcVqTQFQ7v6nJVOdr7DZQfB
	 Ws6Beka0aaYFRMwcE1Fm1SfWt5H1POwdOaPNZ+KD5h8qIPkr4JfF52obSAhOri8i080Ln
	 2yEXvPYNYTb+Kp9+WfynI+mr188LsfAWwcjD+cH2P0zOEvef306Mw8/M3kS2WSQdOug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620087;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=TuYza/mtb5FMCqO/2to32Dt8Zho7iP1sR+gZ7aqNX4g=;
	b=2S3E3K7hp47qpFldHK9OK2CdogzyLYlnJsfm+x8bY6yJh6IEXDXCKuepVIUvTju0USNe
	 DXiuvEsFI1kBUS+pUBVllUfK4q8hXP7Glm0mILEryBLKcJu63v1uaGWmqZPY+rePLHi7s
	 KBJF7+QnRxBKVu083CZUNPo48wOAZyl9gEshN14DctCM6UdAsynAIGdkpQW7cfaKZIjl7
	 7vroSRUauk8s0inmpgeLBBLZZSuPqrsZbUeRyIYlKtdixbsb4Ts07gsjJ9KvsSqZGcFet
	 qihYTrFI+iCv4xtfHX7ka0bndYudLHyXNeg2pNZ8QF1ZKIoyhoSI16EtpNuRzROJ7ug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXcEM8bz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF0C606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eXcEM8bz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BF51F000C0;
	Wed, 25 Nov 2026 15:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795620087;
	bh=TuYza/mtb5FMCqO/2to32Dt8Zho7iP1sR+gZ7aqNX4g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eXcEM8bzoV0+G7bqplPT3vRYe8BwOp5WWX7DRzHGU6zvwFockMJNIlNHvIJ+/2GqH
	 cBwLnuqihPmSAYpqXFn+YuDeZ5Ap0xVMrO2J6zd6bkTIfelgHFkOkHQKQ7pcJ8qV9F
	 oyNyWccgAK5wKqiu6F+TlZ5MS3BCVKpq1z0XhMSD7wHL5bl+8sEbLWyITqJtvMv8Za
	 Re60al6k3cIjwMVK4vPaf0WWIfXdnq/0XPyy6NXDbIsIL2AdAbNvtcrrTFng8V4/I9
	 HAkxBA0yuQJzrHFHEcSMP3w6W+imoydmrtJrfTqTdsO9kIe9ZsZ2ILDMiIow5eW3JY
	 S27fGjftoXQFw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <bcodding@redhat.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] xprtrdma: Fix a maybe-uninitialized compiler warning
Date: Wed, 25 Nov 2026 10:21:22 -0500
Message-ID: <20261125152042.30755-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112558-goofball-gear-57c8@gregkh>
References: <2026112558-goofball-gear-57c8@gregkh>
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

From: Benjamin Coddington <bcodding@redhat.com>

[ Upstream commit cb5a967f7ce413d08cb86ab2285ed34f5ca54935 ]

This minor fix-up keeps GCC from complaining that "last' may be used
uninitialized", which breaks some build workflows that have been running
with all warnings treated as errors.

Signed-off-by: Benjamin Coddington <bcodding@redhat.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: 1fa415883c37 ("xprtrdma: serialize unmap_sync with xprt_disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/frwr_ops.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index 551f3dd4e6237..dfd8007540c7c 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -516,8 +516,8 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * a single ib_post_send() call.
 	 */
 	prev = &first;
-	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
-
+	mr = rpcrdma_mr_pop(&req->rl_registered);
+	do {
 		trace_xprtrdma_mr_localinv(mr);
 		r_xprt->rx_stats.local_inv_needed++;
 
@@ -534,7 +534,8 @@ void frwr_unmap_sync(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 		*prev = last;
 		prev = &last->next;
-	}
+	} while ((mr = rpcrdma_mr_pop(&req->rl_registered)));
+
 	mr = container_of(last, struct rpcrdma_mr, mr_invwr);
 
 	/* Strong send queue ordering guarantees that when the
@@ -618,8 +619,8 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 	 * a single ib_post_send() call.
 	 */
 	prev = &first;
-	while ((mr = rpcrdma_mr_pop(&req->rl_registered))) {
-
+	mr = rpcrdma_mr_pop(&req->rl_registered);
+	do {
 		trace_xprtrdma_mr_localinv(mr);
 		r_xprt->rx_stats.local_inv_needed++;
 
@@ -636,7 +637,7 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
 
 		*prev = last;
 		prev = &last->next;
-	}
+	} while ((mr = rpcrdma_mr_pop(&req->rl_registered)));
 
 	/* Strong send queue ordering guarantees that when the
 	 * last WR in the chain completes, all WRs in the chain
-- 
2.53.0

