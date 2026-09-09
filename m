Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44DE92E92BA
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917474; cv=none; b=jhftIEwKkPjklNwxoh8MaBXl/gHqo40oeP3LC0U/2Odlfutip7ZAI/0AgkDmS2KeQTTphoCAiWrqPdwZ2NiyHTr7eRfQMgdOr1iwE/nw7VYoDYR6imx/4LUANoKTJhh0N1nGleakW+iqEn5hWdBVqFG8HxhPKX5qFrUaiyIz+cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917474; c=relaxed/simple;
	bh=gKDus124aAI2YnqCQ4+6UO10mc3FE9r+suYeaZl3Y0Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lhn0gY7ShfQfC5x9AcvVHLP84MM5TeTkeNW0YWu889H1L63HeC+8m0ofhT3rAVDrCuhIzhvM/MoxcAqf9R/0fHDkyEgjNAT4Tr2LNRHx1nQv2FrBctZKprNia3S3ullvvEtlfLfSnp9yasvr58dzQq2rl86y0IMfeegb+UQo660=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OLuHbGiD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OLuHbGiD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF131F00A3E;
	Wed,  9 Sep 2026 01:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917472;
	bh=Ua5aTx8V58BNIvBAljlwdI9s7AberK/gc8OyzPOo99k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OLuHbGiDCwt6SRiA/eZ97iCaAv4fIFsu4pQtu1hZp/clXAxV1a98ar76eby+9PvDp
	 14Hl48ENATWz5GdOjX8HhAHLHuzkUcVwO9+zx8rTDbLpk9ow3mACFWpbFiJg92SYiE
	 4ovTPOIQLoO5pa9qwkVgBGMgE2Qe1Kt/Pco2t8/wixSPTAGlb2d/VcA2ZW+cdztDGu
	 S27YNVxqV6tfY+iC+5w7+795J+LFhrhXTgAAouIiiD0SJEjC24dOT2xmS6Fj++dr4h
	 0o7lqBvRm5NpF2zyHDA8Av4s4LQ0Ht0vRRnmd0ZfnnoW9+NkAUUJQCKD4vxiuSpol6
	 +oLjOBuAblAjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] svcrdma: Handle ADDR_CHANGE CM event properly
Date: Tue,  8 Sep 2026 21:31:08 -0400
Message-ID: <20260909013109.887545-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909013109.887545-1-sashal@kernel.org>
References: <2026090304-coroner-snowfall-f3c0@gregkh>
 <20260909013109.887545-1-sashal@kernel.org>
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

