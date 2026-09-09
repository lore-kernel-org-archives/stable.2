Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAA8292B2E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915129; cv=none; b=nE0QVqRnlFc+zWHg0wL+ik6uHDqDvvUp8FoiT/Qyl/PcvkttqBRpLlpTBPsQkgPzuAfnGVEgBaly2IozabTg9pA8qG2ok+5vDb2EOeZPhc56e01Y33qJLdwHzdEWTujVA45ml2oDZVCNB65d3570mJ5tH5jRYgzZxPQytYFDolg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915129; c=relaxed/simple;
	bh=gKDus124aAI2YnqCQ4+6UO10mc3FE9r+suYeaZl3Y0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GKqCua5lxrliQrMbFTs0MDVsyF1g1x8kHRYFybr/wH0E143HU/j5MgRGyztvjZKW49ymGk5EZqoG2sg62k3ZH/zmzHTJ3ZrQmkuyHNQeOpG2GFWxlvzqdImdDNCymAphyS4FTTrmsJxtkvuuRuzEc7nsksis6nFLzOc9/Um9qZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QlG5lEsw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QlG5lEsw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A75201F00A3A;
	Wed,  9 Sep 2026 00:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915128;
	bh=Ua5aTx8V58BNIvBAljlwdI9s7AberK/gc8OyzPOo99k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QlG5lEswfFKzLVo6OVmGH5gYbIRNZD3bu7nS38U8Dicd/mmZsa7meG4gl5+zcoKuz
	 gb4Atbtm794EcZnlf7pE/VlL/Yv4X0KdxYGPEil1fc6PtkR8W2fq4v57v+kg+BfkTN
	 g/kaf8vGIOpD9UKIqo4OeFqH1rERpN+6JdO4XHIti2c9qBANmxUfXPQnOqh1CX2DfK
	 3RbgpQ57orRfRHuKoIv3v5h+PBvHFVe8qIpjcyYHT1S0Dh6qP5efNzFIRKjqL7SydP
	 KqMbM92xsSD2arV6P5dCVbEFoWg8kG9EvBG4XLNCMvEpDJR+P8XHkFlL+zPtHqrzOQ
	 tVFYCsNosdxrQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/4] svcrdma: Handle ADDR_CHANGE CM event properly
Date: Tue,  8 Sep 2026 20:52:03 -0400
Message-ID: <20260909005204.805051-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909005204.805051-1-sashal@kernel.org>
References: <2026090303-zoning-shimmer-544a@gregkh>
 <20260909005204.805051-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit d1b586e75ec619dde1af47e21a41a6b1b51874c2 ]

Sagi tells me that when a bonded device reports an address change,
the consumer must destroy its listener IDs and create new ones.

See commit a032e4f6d60d ("nvmet-rdma: fix bonding failover possible
NULL deref").

Suggested-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 0944462247dc ("svcrdma: Reject connection when transport allocation fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index c84343fbf2d2f..de28aae30a409 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -279,17 +279,31 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
  *
  * Return values:
  *     %0: Do not destroy @cma_id
- *     %1: Destroy @cma_id (never returned here)
+ *     %1: Destroy @cma_id
  *
  * NB: There is never a DEVICE_REMOVAL event for INADDR_ANY listeners.
  */
 static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
 				   struct rdma_cm_event *event)
 {
+	struct sockaddr *sap = (struct sockaddr *)&cma_id->route.addr.src_addr;
+	struct svcxprt_rdma *cma_xprt = cma_id->context;
+	struct svc_xprt *cma_rdma = &cma_xprt->sc_xprt;
+	struct rdma_cm_id *listen_id;
+
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
 		handle_connect_req(cma_id, &event->param.conn);
 		break;
+	case RDMA_CM_EVENT_ADDR_CHANGE:
+		listen_id = svc_rdma_create_listen_id(cma_rdma->xpt_net,
+						      sap, cma_xprt);
+		if (IS_ERR(listen_id)) {
+			pr_err("Listener dead, address change failed for device %s\n",
+				cma_id->device->name);
+		} else
+			cma_xprt->sc_cm_id = listen_id;
+		return 1;
 	default:
 		break;
 	}
-- 
2.53.0

