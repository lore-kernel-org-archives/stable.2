Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619115;
	b=kU1rHuBTVmoo+H0hGFbFTN3uG1asfnm3xdedK0k6lv/umcG4ATidLOaWwhX6nzCBGk66
	 kh1Rt2s+9M8sgu0i/QTL9DFyTq1t/dsgulnShoUzLHwmLyADDZIKQ7sg/cUmhuGE+81ht
	 F3KX6+ppIGS/MZLLjmwzjDwHnre54uuqinRhXU3yjwXtkxEB73uYWrszd6h1lBuzO2qoJ
	 AuC0NegbvWvHydYKJOpPp6EhcCXK94AEIQ+KwVAr6aY5hY+LxkyPyoqjJyQLIJW4ZrT2M
	 oEuKnfYdrjhOfD/9k6JLIux1OfIUOlPJZ4J7NRfltXRpALWZCuf8A5chvAwJFAeWzhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619115;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=keBNKkOuEJqVu0zQcwfqLOtccpo6GKEsYjSZ1/SYHiQ=;
	b=19ZuaY6DPNXYlGWCo57b4WnKvf8SwyOSrc96pOF8r1tNpIP8DOV5OzJpy8voPxuBQ3ka
	 0FV8jyKrTygrBiqZo1duldzdnVUM+BbnyQURoHZlqI/kUaDYXZll0fGH/ak0mXLijabzG
	 mINm174HHWMuiYjhSKWF0svGdLwPD1Y1ccn+9k49fI8JMnM9THEwBYnOvZOOGwbPXaT4q
	 RlRRRkP+7jOrOMItZOi7i4FiehQYRe5MH1iKZcOHkQwJYthMtgLeIHncNSYQNf/SfNf5I
	 j1eMk+wxC+oeMns8iK2DEBw2CDgbLQFwRWRAMtd3IRxAAjlJuunp05dg5wThtjOYsyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hdjfvn7G;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAB6606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Hdjfvn7G
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A711F000C4;
	Wed, 25 Nov 2026 15:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619115;
	bh=keBNKkOuEJqVu0zQcwfqLOtccpo6GKEsYjSZ1/SYHiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hdjfvn7Gvhs3lfu5Ybimyj9iFT9jjK54AGL1RFoDRJRk65pn5McTpktPa5SkTZQOj
	 Jh68wfMAPfF37bNvpg8g/SN/1/Iy+Yo3U8zKO6Y0pfYZFQg3VWECbUfSZweGFd5T7n
	 /iAjMGgbPpoUNJg8Oc0y1SdJSJ5/M981HKOV558M6L81NuGqvMSx+O0beND2mhv/7B
	 R2UiQUb+4Sibp/MWjYwwQSS3boRrmoouw7bOJMjtfbzYOFUrertFh4F3U5zsNZ2Ual
	 oSNoRLIi3tlbISxNRSpU6jEZtnl6zgzINUfjpYSeoRvLLdOxt4Ng/Awt+DCggLDgvp
	 8Q7o5Cny4+HYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Anna Schumaker <Anna.Schumaker@Netapp.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] xprtrdma: Clean up synopsis of frwr_mr_unmap()
Date: Wed, 25 Nov 2026 10:05:09 -0500
Message-ID: <20261125150506.11963-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112557-renewal-pyramid-fc9e@gregkh>
References: <2026112557-renewal-pyramid-fc9e@gregkh>
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

