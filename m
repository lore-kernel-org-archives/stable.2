Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCBE2E5B2D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 02:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788919320; cv=none; b=apDjhGu8DVRMdeULBUoh0dUvwk7SmXiv3cmM/acadbbgNUiBe501fU1umWE0QVINrWWdxzAne6OKfOtg2FQkmgdV4VgNThu2M2VqR0URxBlibtBlNk+fmdlMPTNfCZFGesFoLltCCV8xFL9RL92upU7HwZXxzg2MbRcu3mBOQaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788919320; c=relaxed/simple;
	bh=zIoK1Mg9fqBQb1DFO9IrJbkj6lKWrx5/FxOuj5FRfeA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgKICszF5CMAiqaW/IvxUCZtogz73OKp0eT8Z4pjKOgUlN6cPREHOB9I2qVbv+1CWUx4vEfMtA+PIc21xD5fRB66fKppW1eJejBgTqjUPhZml0LWxli4EgFWo/QEu7lAKO9WENnMxuuFqGm51jf/A1BD+xsJMJP36nYEYIvx2Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mZN9RIbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZN9RIbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61D721F00A3D;
	Wed,  9 Sep 2026 02:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788919318;
	bh=s8+ceXcgLkpOStZ1aJ2nysXGPuFB5+hIWhlHGFiVCG4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mZN9RIbvVMgNzGwdKL+mR6TuKlnva9TkHionUJQPAzy/Fju5R+tIJ0w5olFCjcyk9
	 1E9Y8fqzA2unwaX7b1q7lJAY4cow5DqTXKG/cCJat3vx5UCEZNHlsEFvLS/E0eLBEO
	 odAe3q4zx9zJ1RqIB69a6qKzX+z6ea+LQMDUpk7k1rdOmfH7SIy+lAR0RBq5KoIbLb
	 OVyZHJ0sVfNABmjTu0rMIYUQap/YiUgi5mXtstF5O2aroptQ307bNvTvu7ZHkXd9uR
	 LWPoLeKdHLsEpiHEu5V0D+EaZHMm08mooa/woYSNSEq7dOtRve/Q1BDcRy3VW7WjZB
	 wc5y3UB3ChbOQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] svcrdma: Fix retry loop in svc_rdma_send()
Date: Tue,  8 Sep 2026 22:01:54 -0400
Message-ID: <20260909020155.1007668-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909020155.1007668-1-sashal@kernel.org>
References: <2026090318-deskbound-cushy-edcc@gregkh>
 <20260909020155.1007668-1-sashal@kernel.org>
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
index 1216bb05e26cf..f3b837eedfa30 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_sendto.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_sendto.c
@@ -302,8 +302,9 @@ static void svc_rdma_wc_send(struct ib_cq *cq, struct ib_wc *wc)
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
@@ -319,30 +320,35 @@ int svc_rdma_send(struct svcxprt_rdma *rdma, struct svc_rdma_send_ctxt *ctxt)
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

