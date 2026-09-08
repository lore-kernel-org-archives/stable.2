Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423562E4257
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 23:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788909573; cv=none; b=f3t9eENs0MjiwiwoRVYUcXN9NXLUQh+IzSinkhHNYEql23krn2556CF5Hq1qa4CqBrHuCCazX2I//k+b/M5LB+IgyMz60ykkN0NkzBGN52pmfAEWN0kxiOdtXdT+vsElfBkvb2urL3hrxstXGoBsY+PS4JlY3dYI9AnqLzj+UfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788909573; c=relaxed/simple;
	bh=zyI5VgI3JwGYnIZmdR1wEw/eH8ZgtA1qMvSeGAZFazs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wmnbr9U6GJsV0d89bZ8bgpmVJhDNJsN+JoG8nGMsYnTqt9YFAz9Y1EciIufwX9v7qWD1sxdIbx2HYijiMfeEo9Aq350axmdI/Gd9HcOZZ94gJCCs0UNsGDzVo+xHMT5YwZ3/EAIjd0h5w/SuqmJmPO9s/xDZePCZrWJQjB+xNVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hh7cJnqr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hh7cJnqr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 844BD1F00A3D;
	Tue,  8 Sep 2026 23:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788909572;
	bh=sWi/bTSVB84dIKF9OwaD/fNaqFIj93RspxPcgRRsL6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Hh7cJnqrWLrHvGyfCAg9UgLuAPpQrDZ6dnGAUaKKtyrjiWpPexesrRhouytEh9yGu
	 yTxI/FjcMskIe//oZeIhOWH5azZqtbvCNfkrAfqy2KNXVyDCJs2pk6vuJraNbzjRaw
	 ByAv9u+EbBLfmDANdU0n8Dl54F+uwyzvXrEk3FGxDoVYO/L2Bqp3OdprIfKJYQw63u
	 RPir4RBZ1+E2DW9uMSBGN/iO5fXGPKkZz1iDLwCFMcoT78Pkqmp1aIrSahqKR6jBs1
	 EoWVbvQTksrF+iCXwPLE2efptdSee8jdF0AD8UZ6ZC3IldAZvRoYCoEwAgDZwQtWAa
	 077OtFKgUBc9A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] svcrdma: Reorder rpcrdma_rn_unregister before rdma_destroy_id
Date: Tue,  8 Sep 2026 19:19:28 -0400
Message-ID: <20260908231929.624931-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908231929.624931-1-sashal@kernel.org>
References: <2026090308-barstool-liftoff-6f6d@gregkh>
 <20260908231929.624931-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 4488e912973773d64368828acf3b8e39d93650ae ]

svc_rdma_free() caches rdma->sc_cm_id->device before teardown,
then calls rdma_destroy_id(sc_cm_id) which frees the cm_id.
rpcrdma_rn_unregister() follows, but between those two calls
the transport's sc_rn entry is still installed in the device's
rd_xa. A concurrent ib_unregister_device walk can dispatch
svc_rdma_xprt_done() against the now-freed sc_cm_id.

Move rpcrdma_rn_unregister() before rdma_destroy_id() so the
transport's notification entry is removed from the xarray before
the cm_id it references is destroyed.

Also guard the sc_cm_id dereference with a NULL check: the
following patches introduce paths that reach svc_rdma_free()
with sc_cm_id == NULL (listener create failure, ADDR_CHANGE
replacement failure).

Fixes: c4de97f7c454 ("svcrdma: Handle device removal outside of the CM event handler")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-2-1b09bd87b6cd@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 72b653d38bc78..55f810a22c6aa 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -621,10 +621,15 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 {
 	struct svcxprt_rdma *rdma =
 		container_of(xprt, struct svcxprt_rdma, sc_xprt);
-	struct ib_device *device = rdma->sc_cm_id->device;
+	struct ib_device *device;
 
 	might_sleep();
 
+	if (!rdma->sc_cm_id)
+		goto out_free;
+
+	device = rdma->sc_cm_id->device;
+
 	/* This blocks until the Completion Queues are empty */
 	if (rdma->sc_qp && !IS_ERR(rdma->sc_qp))
 		ib_drain_qp(rdma->sc_qp);
@@ -649,11 +654,13 @@ static void svc_rdma_free(struct svc_xprt *xprt)
 	if (rdma->sc_pd && !IS_ERR(rdma->sc_pd))
 		ib_dealloc_pd(rdma->sc_pd);
 
+	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
+		rpcrdma_rn_unregister(device, &rdma->sc_rn);
+
 	/* Destroy the CM ID */
 	rdma_destroy_id(rdma->sc_cm_id);
 
-	if (!test_bit(XPT_LISTENER, &rdma->sc_xprt.xpt_flags))
-		rpcrdma_rn_unregister(device, &rdma->sc_rn);
+out_free:
 	kfree(rdma);
 }
 
-- 
2.53.0

