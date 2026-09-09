Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB64B2E7397
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917473; cv=none; b=ChjB2Lgbl5MXXZ/vTCdjd+4dYIO93lCwqrTjugJylYPSdT6BxRy1u3IrX9QU0me5ZI2ClnQOOsSUhQrrKJFLusu0MbOXg5+YBdDTi7mGvgjvVEjAHX4d/lnMZs5JrJcrxr6xSSqGAjg3sNr4vavZosYwvVcavHsuZILNnov0cxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917473; c=relaxed/simple;
	bh=VKIYuzxhDWwaZ4ZL6U1k+FkWBwvAk2jZ+7l6+Tqo6PQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oM2ktmuDnvG8seR2ao4ZNhGwKvpXkrUoxdNBdMwCfNrzc/46DlGF8r/VlYUyFjIOYKpgryG7mz3+J5k7h326bVJyAkExHjX+QiSXnNUrenI3LkCtb5hw42peRAnKfmFo2ogN0sRISjNw2u2vkLy/5ZF+GRfphD6aTT6nSwuLf6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BiPiL6TV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BiPiL6TV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0872F1F00A3A;
	Wed,  9 Sep 2026 01:31:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917471;
	bh=k76mPwzWieVoRSWO/eOppnYrwvosVME59TSnfv6t0Eg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BiPiL6TVL58kywGZrYn6aCq6/3a2YHoEJmsT+OPed6M02EJpEG9etC7GbVfbHwJOC
	 Q16RP1ZoJvjcwGZK9iyF1XdTnYpyXKzxESO3jJ8A/LJ5TN9JflchN8GKVnFD9hPen+
	 LFsZeVZlDr8nOpRA+PLS/qZlNdS1Maly2uat8gFUQ+e7otc2Z3GmMnFRzVbUdMo/oc
	 TxMfzG1ouLg/gG5w65W4nhfFw6FHJPc1FxUTEcI0SHynIMiuRn0uASEGzhwl5XrL+O
	 qajJQne6ulkUviU5NdWj2lI8wb4ZzvVBRCvjK6OTEfzJZfIUJrlILUwi9dlHQcUwjZ
	 Eh5uc36UrNQhg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] svcrdma: Allocate new transports on device's NUMA node
Date: Tue,  8 Sep 2026 21:31:06 -0400
Message-ID: <20260909013109.887545-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090304-coroner-snowfall-f3c0@gregkh>
References: <2026090304-coroner-snowfall-f3c0@gregkh>
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

