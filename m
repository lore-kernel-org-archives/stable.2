Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E1A30BF70
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917853; cv=none; b=Zcd7xQUna0BS3bpZcEwZzDaD5Mq6i3N3ALGBffO1s7cZRta/Jxf3S8dm+jxDMskNoRbXkaNjPlkmcQXaxaOKXfRVEKRmvB+Z4dqtAGdAblwWkbhUazPxNaDGa7jp7IwGPOkOw01N2z0iNHDlLl4okvKLaPq03CgI6JQO+esVFBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917853; c=relaxed/simple;
	bh=NMG2CUL1owBiKdSPBOgOf/9z8E6JWM63XGiS7GttxWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sk5mf/jenB6SyUSUazWT3o6GYoRYdQZYr6VHZwFyMeU5xMbQeyLvd9kvJRf0ioCOh0hdxeRGguCkMmm3qwuCMZ5YaMuTq4dbC//ENiCRQcDax5Avm+gMejoLEh9a5aVZ2Ir0X/tiKjAWYE48Zx4FIWh+IaQ1abnqDnu+Oq9jYvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I7eMXm6G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I7eMXm6G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F6C1F00AC4;
	Wed,  9 Sep 2026 01:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917850;
	bh=h2FxRz4cLhVuYc/kA5xAdEWUt5pon+ERUEZQeA8GBCQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I7eMXm6GVwJVC5fPUoHbGSA27m9tL43iCWN/+y3q4nPgfHq/lJbPe0sCzrQV8EDdj
	 SMU5tVJdWirj1XPkNlonM4WfXzNgcmnQOQxjRb4dWpyMWsu9dqvYRffqFTzelyY+Mw
	 2u40+qp9ialnW2ok5U+UuxgiWXDBDkRBjKcjXue0OR0goORo7rMGhiBEAdFIX22iPn
	 +3Wey0CoHXbqvnv6zJLdZ+QFR61OM2cKIRG+M07623YuN6+X2YQkFoY/dgfLbbM8Uk
	 aDxm8O/DMBri35KlfaXx5xjscsaAoGydB6bQxrOZUR/XAD1cRRoCkkJa+YGNaT8kWu
	 8jZ8dgbfeXkng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] svcrdma: Handle ADDR_CHANGE CM event properly
Date: Tue,  8 Sep 2026 21:37:26 -0400
Message-ID: <20260909013727.906528-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909013727.906528-1-sashal@kernel.org>
References: <2026090304-champion-prevent-c92a@gregkh>
 <20260909013727.906528-1-sashal@kernel.org>
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
index e067d171fc4d4..9adb2ad031e97 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -281,17 +281,31 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
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

