Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54A1A492E4C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913508; cv=none; b=knmELEUnmRl3tZ11PPAyPnd1bspC5Jz41rZSZ8Mo+eo2NYPekBeeFH5eVMsekZmpXJ5maPprEGhQhSLq4L1kFjvxi/tzN7PmHl2Evb9KW5MeyEdCY3CChhFCGlmDTtZYsj29leiAV0FvGwooqVxb9PeOuoudq/ANob73TuD8G2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913508; c=relaxed/simple;
	bh=EgD7SUZZBjqv1xsf0Gx1tp0vMEKGbaIrikzEKMaj6AY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnIFL4V3rQrsrIwkmkzrbY3eSQlZlJBQBOYTUN1IvV61/vSyjkPqiD9g2gWIt9lVy+KeyFC3mPJ1XIwi8LxAcN6p8WHEGkroVZCoifQ3+7jGatvy49ymAnvyBVswRcxeBtp9wU+1audpxRaIBXpsFSeYzZLzFVRwzbJGqz4CKYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A+zgN73F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A+zgN73F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A131F00A3E;
	Wed,  9 Sep 2026 00:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913507;
	bh=/qdF303bZwAlDi57mrhgpPIdn1uSUdDHaWCvJavV6Oc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A+zgN73Fmb8nCC/YM92DxO0fn0ETAgXnvPxuAmRvlfZLpx9md+dCCYhF/t9baFN2V
	 vHZT/5CfT4rrVmUHqiQJicwkik/pOvw+7xS+gVfNV9u24ux+u6yFCqmlWqCCGFMEV+
	 0K6VTElhPq2NTFQCbR8KlehqWr5Mjs3U7cdIFpXd332BFej42mkQLOjYXJ5Kpsz1Wf
	 LACQMx90UuRw3If81uPJFFT7pBfXRxj5xwAfcGYLns0bG+X+XIL5abDjKL0TxSErut
	 gR5T3Ww11+J6FKXqQroOFRwnhPZ0SqBO5XpMvX+VbqWykG75tIl4rh2en5mZcEbazx
	 gEn7809u6K+eA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] svcrdma: Handle ADDR_CHANGE CM event properly
Date: Tue,  8 Sep 2026 20:25:03 -0400
Message-ID: <20260909002504.725024-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909002504.725024-1-sashal@kernel.org>
References: <2026090303-catcall-blinked-014b@gregkh>
 <20260909002504.725024-1-sashal@kernel.org>
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
index c01685223973c..ec7f1bfcf98b5 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -277,17 +277,31 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
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

