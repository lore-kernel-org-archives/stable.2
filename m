Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07C82212550
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914192; cv=none; b=sqI4nAw1aTZfsLZwlqvejvWUOXNujKg8nEOib8v4a7/pawEhVrG3bOZLOT5kNmo07iByal5E78vnHWJfnYd47rKf5349xRp/Modgk/gtoLg3y63VRU1oXScxT1Y7bKcjBpKAcXHeMQqBkKYJzbBcbNZgSDsiNoKxXmdWVBia2vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914192; c=relaxed/simple;
	bh=hYiOXkTPGNSGtDh8gRtLgvqLej7ec0koz6zU6N1fwK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cRb02041FUUDLHUc5OCiQ794pILrbDGGgB7o5uN5kXcscQacJhiETbYDH86QtptSc0fMSG46dKI0+w2j4iusGJMYI1N4jkXdxliUKzqw4FVhJ+Dw/WSM0wryXjC5q1WVuKEFnCSZGrPsL4h9V8fMyce8+WeWraJoL4PXo6aX3sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9KN/HdR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9KN/HdR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686DF1F00A3F;
	Wed,  9 Sep 2026 00:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914190;
	bh=PlWtvHwh6Ks97rbTAcfYMYTRB0JjeM6FFd5S0/XP04A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K9KN/HdRaOkLxu9WG6kslnvBS7hf0Q2lVMJfENQQNElQr7qcXoopJwOO6vippVhQg
	 /m2poMBIlp3fZ2nE7tB3FuvzIaDPlPFk2itKpt03W3EQ+dtZ+owCnj05pzBBdkv2WU
	 5rJDFMIzf1JppdrkanjRw7MIHc9tl6vTSOFyiipYoaT2gQSq7CGnpxGLFKN0rnJl3L
	 6moxNazXzZhvl9vgCI+EKm1WqSuq8TFouExuH13cugKJ1X+oaatZ0Ynn8XFe7Wdp8Y
	 4vBBmhxmys4T9st2E5qqAyRiO41t9afvC1sAORKbodMk/K8iyXHm/iu6hMRj529FUy
	 3nzZmW0MDpyYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] svcrdma: Fix retry loop in svc_rdma_send()
Date: Tue,  8 Sep 2026 20:36:26 -0400
Message-ID: <20260909003627.747182-3-sashal@kernel.org>
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

[ Upstream commit fc709d82dda6405862a681cc425386bfaf049539 ]

Don't call ib_post_send() at all if the transport is already
shutting down.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

For this stable dependency, retain the existing SQ tracepoint signatures:
full/retry take only rdma, and post_err takes rdma and status. This tree
has no local completion-ID copy in svc_rdma_send(), so omit the upstream
comment about copying context fields and describe the existing single
Send WR instead of a WR chain.

Keep the shutdown check at the top of the retry loop, before reserving
an SQ entry or posting a Send. On ib_post_send() failure, trace the actual
status, schedule transport closure, restore the reserved SQ entry and
wake waiters; return -ENOTCONN for either failure or shutdown.

The preceding dependency already prepared the pull-up helper arguments
and Reply chunk branch for 0fbe20dfe74b. Preserve that preparation; the
target applies cleanly with a three-way application. No functions added.

Stable-dep-of: 0fbe20dfe74b ("svcrdma: Reject inline replies that overflow the pull-up buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_sendto.c | 28 ++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_sendto.c b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
index 3247a0aa2004b..175d3a0478c26 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -307,8 +307,9 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
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
@@ -324,30 +325,35 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
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

