Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23A2E62A9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918925; cv=none; b=hCAb5aKkFwteq3ErTUnXoTuzq19wapMaxqkVS3ZF6vVLhoI+Lr8iHxcI508e+f2KSwsq/qE3G5gOE1FgGNhf8f5C6xAQtiL/+oekY+lSybWF0J/AU+d0g+/N5ATzNHP3arCZ3xTuVIXFYXm+yr7hHLn9L2mX12pkGHL2IhE83+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918925; c=relaxed/simple;
	bh=GAgLelBQ2PnGdb1XFmzW3CkEy8pKLGj7wNMA812HVRY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JiY5Ad2chRxM+kenfUCCH/SGjHPb12YrYcPC2E8/rc6VBwpq6E8W4Cwcrhn4/DkE/QmC7yb4BiWLcqnmloldFFqpemHpwVlEEC/a4hbDenRO8SLhryOfwL65+Xornzzvp+jOJeNTgTOXDma9BEpmP4DqtbIdSalUqqVRq37PMyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrdBnxcO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrdBnxcO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE4641F00A3A;
	Wed,  9 Sep 2026 01:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918924;
	bh=pfxrBoAx/XyyOZSDBcLC3cHvODx1F3VuHeDUleI5d7Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WrdBnxcOqa/I7IG6LzhKAdZTeU9YSly4owSpt72j42TcKozCKGE9OOEjSoEETOJbN
	 Ozhs/lx9vKRLky0GrRCqwCN2CAW/vWqqXwiRB6J1jwJNg82+ammV23EuPHk0evYYBv
	 WzM1d9TvIzYgFawSLxu1+RGL05vDWp/SPut1hTk9NT74OQ2EqQDGXs91I6BCt+yna6
	 u0b4dIbZ/XMidOqvBqLJT5v7yepc77nswcA5MPm9Fj9SQHTStohh/sj4xMV8rwEUf6
	 Zb6Y9CU0ZfoS2wkYCULmLQ5m0ACuHwQzC7Tm4luPzB1u7JG920OIlP+5JnUrT39XGA
	 VE6hcSpTt2k0A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] svcrdma: Allocate new transports on device's NUMA node
Date: Tue,  8 Sep 2026 21:55:19 -0400
Message-ID: <20260909015522.954712-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090356-dehydrate-probe-c315@gregkh>
References: <2026090356-dehydrate-probe-c315@gregkh>
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
Stable-dep-of: e346ef7bcb13 ("svcrdma: Use svc_xprt_put to free listener on create failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 1041ea72b3613..575de045b465e 100644
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
@@ -126,14 +126,14 @@ static void qp_event_handler(struct ib_event *event, void *context)
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
@@ -197,9 +197,9 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
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

