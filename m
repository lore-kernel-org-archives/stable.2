Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD0A92F745C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919776; cv=none; b=SfRs4ZCYyrnbKsXkBA95UMemOWd7sJLz3nRyPizpeBLWclpaklf4ga8wY/CC1cvLwsm4IUsJqOnx+TbFNKSMLG6PG7yTrKkdgMzt+iVyAI1Dmz0oz0Gr3A8CwttYwtyAJ+eT6BKtlDuw4NROl5YvPH3Q8tgAgdz88nDz8rGIMT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919776; c=relaxed/simple;
	bh=Ti0/WCH6XVa5whLB5Pkhfwkrei/kCo+CFXfSPRvk+eE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j9aLnQojBCfzq2AoYOdiZm0bqnsYCQGvHTKiFc9VCpCeUNp0S+fAwTqnu9ZmYO2JkCZakmaxj1+zgbr6OpGr+5IBV8zc/V12ZzbCPsnv5bFBAjIRpArGn0AkTWawh+hAR+1qSrUkznW6hyna2T2zMhPjaCQ5TDsmFnVwob4iRTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Og24rwNo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Og24rwNo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EA31F00A3E;
	Wed,  9 Sep 2026 02:09:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788919774;
	bh=Dke0+NP0PsYYOkQzEwC2JV1hMePohX9zC/8WhWRy6D8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Og24rwNoqRYRSKxDKR1CTJW7fa7xbdBapJSmikaSdaq/UAn0mW3sQ8cEjq7JK6DGy
	 h73EoZDqR90K69MfckQpxBgLcCVHaMFCO6m3W+LSG0jXBKlrP1BzxVDIZQgy5r4nI3
	 6If2kNxvdN0+xMVp9VGnLwsG7xqj8l9jAWMk2pStfiPToHqDCIX0yzxQBNLqYgYQKA
	 HhgnWlfAVMwxrCnuLpnahDhx5NhH1xGcULGhTpALK22wRkWZtGlJG4YicjPn20WSXs
	 tOgDuvEg5hht398CelXC5Q8lsD2QOiyjF8JkitJJWlRfoq+XIXHxA/OOI/JKaFpXDN
	 y2t6VG999N4/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] svcrdma: Fix retry loop in svc_rdma_send()
Date: Tue,  8 Sep 2026 22:09:30 -0400
Message-ID: <20260909020931.1057969-3-sashal@kernel.org>
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

[ Upstream commit fc709d82dda6405862a681cc425386bfaf049539 ]

Don't call ib_post_send() at all if the transport is already
shutting down.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

[Stable backport preparation for 0fbe20dfe74b]
Keep the 6.1 Send Queue tracepoint signatures: sq_retry takes only the
transport, and sq_post_err takes the transport and error status. This tree
has no local completion ID in svc_rdma_send(). Do not import the upstream
comment about completion releasing the Send context; this branch retains
synchronous completion and caller-managed context lifetime.

Retain the retry-loop fix: check XPT_CLOSE before reserving an SQ entry
or posting, restore the reserved entry and wake waiters only after an
actual post failure, and return -ENOTCONN on either shutdown or failure.
The existing pull-up and reply-error preparation for 0fbe20dfe74b remains
unchanged. No functions are added.

Stable-dep-of: 0fbe20dfe74b ("svcrdma: Reject inline replies that overflow the pull-up buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 28 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index d845922bd39c2..fe3369f5c75a6 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -294,8 +294,9 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
  * @rdma: transport on which to post the WR
  * @ctxt: send ctxt with a Send WR ready to post
  *
- * Returns zero if the Send WR was posted successfully. Otherwise, a
- * negative errno is returned.
+ * Return values:
+ *   %0: @ctxt's Send WR was posted successfully
+ *   %-ENOTCONN: The connection was lost
  */
 int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 {
@@ -311,30 +312,35 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
 				      DMA_TO_DEVICE);
 
 	/* If the SQ is full, wait until an SQ entry is available */
-	while (1) {
+	while (!test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags)) {
 		if ((atomic_dec_return(&rdma->sc_sq_avail) < 0)) {
 			svc_rdma_wake_send_waiters(rdma, 1);
+
+			/* When the transport is torn down, assume
+			 * ib_drain_sq() will trigger enough Send
+			 * completions to wake us. The XPT_CLOSE test
+			 * above should then cause the while loop to
+			 * exit.
+			 */
 			percpu_counter_inc(&svcrdma_stat_sq_starve);
 			trace_svcrdma_sq_full(rdma);
 			wait_event(rdma->sc_send_wait,
 				   atomic_read(&rdma->sc_sq_avail) > 0);
-			if (test_bit(XPT_CLOSE, &rdma->sc_xprt.xpt_flags))
-				return -ENOTCONN;
 			trace_svcrdma_sq_retry(rdma);
 			continue;
 		}
 
 		trace_svcrdma_post_send(ctxt);
 		ret = ib_post_send(rdma->sc_qp, wr, NULL);
-		if (ret)
+		if (ret) {
+			trace_svcrdma_sq_post_err(rdma, ret);
+			svc_xprt_deferred_close(&rdma->sc_xprt);
+			svc_rdma_wake_send_waiters(rdma, 1);
 			break;
+		}
 		return 0;
 	}
-
-	trace_svcrdma_sq_post_err(rdma, ret);
-	svc_xprt_deferred_close(&rdma->sc_xprt);
-	svc_rdma_wake_send_waiters(rdma, 1);
-	return ret;
+	return -ENOTCONN;
 }
 
 /**
-- 
2.53.0

