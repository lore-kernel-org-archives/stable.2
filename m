Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C049923D7FB
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915127; cv=none; b=uZOo2ZBX0samT5Rd+PR60LzPzmUNz1m/SwZ1lQHwaYfi25zhCY2S3f8jDcVO+OXe0A02N23iE626RqHNnxHdhZzLkQ6+5HNYvWsexWYKkw2W1zsyTLAdWwNFM2yc+hdB47XgYVTVsTD4/DzHurF/WJU3r+1kE9nQkTbpV6WhNcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915127; c=relaxed/simple;
	bh=VKIYuzxhDWwaZ4ZL6U1k+FkWBwvAk2jZ+7l6+Tqo6PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AKb2UXowoWmErDezXJMmh5LRPmvZcCkx7nrHrlN/BADtLBS4kXCG2WcyqaL3s45NII0qQJV0YMgcDRnUz8hfjCmWptwgwVAH8sKGOXEvji960sdokjyLE3K+ou5TgmY3L/ah54ahCSWCvHfkeu4OF36M01752zzW4k2+FjKjAqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=INTp3NXx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="INTp3NXx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD591F00A3E;
	Wed,  9 Sep 2026 00:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915126;
	bh=k76mPwzWieVoRSWO/eOppnYrwvosVME59TSnfv6t0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=INTp3NXxDwVdmyL+ZHxQjDH9NomQFZ68B41PkHWf3s5USfpcv9QNN5AzhrFheBXuH
	 JlBs5n3xN6XvgW593bPZLO+xXYjLkPfzFtjoGq+Gb6kkmauuBit/HEwK05VPSdnu76
	 wktf6JW/KMEsuEEnX1D9zfla4xWzcaOtRWtL5josuIWZdykWLgjplULUvzzT2e8Rrj
	 1o18tMrw4XWlmYEBMM55JDLLRzTobjtWlATnTY+aZC9hN1+JZM1+qtSIdLKaML5+5+
	 BfrqFywc9PCDBVkHYIQ3RcSDCbHrjUWxXgrID/I83lXkhI2S2SB/uorjujaobV3r41
	 Fh60QbF8V4/yw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] svcrdma: Allocate new transports on device's NUMA node
Date: Tue,  8 Sep 2026 20:52:01 -0400
Message-ID: <20260909005204.805051-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090303-zoning-shimmer-544a@gregkh>
References: <2026090303-zoning-shimmer-544a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit fe2b401e55482cf90a0056209c8a232b2d39056c ]

The physical device's NUMA node ID is available when allocating an
svc_xprt for an incoming connection. Use that value to ensure the
svc_xprt structure is allocated on the NUMA node closest to the
device.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 0944462247dc ("svcrdma: Reject connection when transport allocation fails")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 45b0fef0b5e26..9c4cd4caa0c1c 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -64,7 +64,7 @@
 #define RPCDBG_FACILITY	RPCDBG_SVCXPRT
 
 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
-						 struct net *net);
+						 struct net *net, int node);
 static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 					struct net *net,
 					struct sockaddr *sa, int salen,
@@ -125,14 +125,14 @@ static void qp_event_handler(struct ib_event *event, void *context)
 }
 
 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
-						 struct net *net)
+						 struct net *net, int node)
 {
-	struct svcxprt_rdma *cma_xprt = kzalloc(sizeof *cma_xprt, GFP_KERNEL);
+	struct svcxprt_rdma *cma_xprt;
 
-	if (!cma_xprt) {
-		dprintk("svcrdma: failed to create new transport\n");
+	cma_xprt = kzalloc_node(sizeof(*cma_xprt), GFP_KERNEL, node);
+	if (!cma_xprt)
 		return NULL;
-	}
+
 	svc_xprt_init(net, &svc_rdma_class, &cma_xprt->sc_xprt, serv);
 	INIT_LIST_HEAD(&cma_xprt->sc_accept_q);
 	INIT_LIST_HEAD(&cma_xprt->sc_rq_dto_q);
@@ -195,9 +195,9 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 	struct svcxprt_rdma *newxprt;
 	struct sockaddr *sa;
 
-	/* Create a new transport */
 	newxprt = svc_rdma_create_xprt(listen_xprt->sc_xprt.xpt_server,
-				       listen_xprt->sc_xprt.xpt_net);
+				       listen_xprt->sc_xprt.xpt_net,
+				       ibdev_to_node(new_cma_id->device));
 	if (!newxprt)
 		return;
 	newxprt->sc_cm_id = new_cma_id;
@@ -306,7 +306,7 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 
 	if (sa->sa_family != AF_INET && sa->sa_family != AF_INET6)
 		return ERR_PTR(-EAFNOSUPPORT);
-	cma_xprt = svc_rdma_create_xprt(serv, net);
+	cma_xprt = svc_rdma_create_xprt(serv, net, NUMA_NO_NODE);
 	if (!cma_xprt)
 		return ERR_PTR(-ENOMEM);
 	set_bit(XPT_LISTENER, &cma_xprt->sc_xprt.xpt_flags);
-- 
2.53.0

