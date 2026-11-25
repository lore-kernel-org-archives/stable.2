Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618592;
	b=kNeIjag6GBN1SakaedIFm1nIXiIOOG5depHzlJKWnmbC4e2Rotmi+qfjT0PowBd1BzU+
	 a4z8a1GMlS4ECwlYg7YsBK5CeEsm4x0u1q6KOFpsCNuKR7uAfd6BaDHgZeRLUdMG+b59g
	 b7Xys+6tvDWrgf+53DYAPrI/ke3iuf99DeZeQHs8aq75kdRkFRrcT+Oiy21B06vPIvk7O
	 EtqRlFn6k6G4cCE4U4riiIKYeVp6TqjbRualqNikLA1XADAhzN3B9pKxqZu2IeyHcQ1yi
	 cnkFp56XcWBTBN8wmODCoVuFZrkcg3dN/XvnBQgK0NZ19THf4xAXrHLb8vHYT83iQ7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618592;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=keBNKkOuEJqVu0zQcwfqLOtccpo6GKEsYjSZ1/SYHiQ=;
	b=Ff11JdOvneV8DuBu6jtWtjWO/650javwfwlCsF+rYXSLKztL3ym0p8eKhXttyF8Hn+dR
	 Mo4c2qq0EaSyW9hMiwLyZyLQbBsYW/ZGiU5SQnkhtJm1syDl2Wwde2Q4B7v9QM7GAfuMX
	 erp9vJXGegsgMvP2aCLCfabuX8SPIjFe3pQk5q3JY0pkJGAU8zvMbMdbvrZSoVCF5f7SL
	 8Lwrj3ypNpZj+fhDknTek/6NjxbG7pPi7JVNrtbNvgP0yyANyCbLq7g6BDTbaRt+lYFl4
	 A0S/WBHElVZe6N7J/svrP6HjAx0DPql1yvnvnFQIutyiaHG1rqYN3mufPHtZJo9pSdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRhdmdtT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B400E606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PRhdmdtT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6BD1F000D2;
	Wed, 25 Nov 2026 14:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795618592;
	bh=keBNKkOuEJqVu0zQcwfqLOtccpo6GKEsYjSZ1/SYHiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PRhdmdtT0qHROMBaXl2oQ9oMpvCAyc2su/MW6LDuobv6Biu3bZZ1nsoRTzqB+sYKP
	 6PXN+0QJeNJGnfx6hMhP3ZPrwG4HMWK2t+yqcVvS9U5uZeGDwI5gS2qIgNvjwFu6I9
	 qlP9K2njZv3uKoEB2FURsOdbjqiIXwTFu1+AoU4rRG5DphOO9EunVxQdQgSDEwdwRO
	 E8NrXs84JpJgV3c3uYG89lG+bdwRIhb/L1GRdDYwa2GTMiRIMJTg1ihk5a5URLyado
	 MdlY2wOC2FoQS0GBTw1BeAq5eMutpbxvWECJtMi1Qacq5au3w562o42mI+J2SQ1ztL
	 2GjRMnDp2bQ/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] xprtrdma: Clean up synopsis of frwr_mr_unmap()
Date: Wed, 25 Nov 2026 09:56:27 -0500
Message-ID: <20261125145623.4186690-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112556-catchy-compost-16aa@gregkh>
References: <2026112556-catchy-compost-16aa@gregkh>
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

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 9d53378c2c145991fb5bc986c82eb9030212c2ea ]

Commit 7a03aeb66c41 ("xprtrdma: Micro-optimize MR DMA-unmapping")
removed the last use of the @r_xprt parameter in this function, but
neglected to remove the parameter itself.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Anna Schumaker <Anna.Schumaker@Netapp.com>
Stable-dep-of: 1fa415883c37 ("xprtrdma: serialize unmap_sync with xprt_disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/frwr_ops.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index a0d49580dcb87..a82eefe5e6b58 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -54,7 +54,7 @@ static void frwr_cid_init(struct rpcrdma_ep *ep,
 	cid->ci_completion_id = mr->mr_ibmr->res.id;
 }
 
-static void frwr_mr_unmap(struct rpcrdma_xprt *r_xprt, struct rpcrdma_mr *mr)
+static void frwr_mr_unmap(struct rpcrdma_mr *mr)
 {
 	if (mr->mr_device) {
 		trace_xprtrdma_mr_unmap(mr);
@@ -73,7 +73,7 @@ void frwr_mr_release(struct rpcrdma_mr *mr)
 {
 	int rc;
 
-	frwr_mr_unmap(mr->mr_xprt, mr);
+	frwr_mr_unmap(mr);
 
 	rc = ib_dereg_mr(mr->mr_ibmr);
 	if (rc)
@@ -84,7 +84,7 @@ void frwr_mr_release(struct rpcrdma_mr *mr)
 
 static void frwr_mr_put(struct rpcrdma_mr *mr)
 {
-	frwr_mr_unmap(mr->mr_xprt, mr);
+	frwr_mr_unmap(mr);
 
 	/* The MR is returned to the req's MR free list instead
 	 * of to the xprt's MR free list. No spinlock is needed.
-- 
2.53.0

