Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 564FB13D53C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918926; cv=none; b=brKOm4n+VCeuD3j0MIT2YwOEJhtnc0KtuKlhSORFlBNT5uFN5ZypmqK9nnVIBdquv8kmajQtZclqSO++qeV7es74/KwgaP8uuurfaSyqwq2Q+u72oFKN+sLb0xygC7EgLvQfRw+tbS/flPrgrjpx5NfCsz6sAnHFwRsvXaYSTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918926; c=relaxed/simple;
	bh=+v8ZVKIuuYCt4h1/8uOflnLIShSafmzs1wuEit29XaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NQe+AB0Kt+oSemS6dRcAUNCtLfTHhcyA6Emm+6QnYEXdvn6odMyJr1kg3xzRjU7eByr3AJCS4hbRq7WP0fYi13uo89coScTEBx6H9YBfu7H/9GpgDegAbOZs0yvTuyg6tfHIw/c3Rk00Yl8PHLLUQHeSo+J/SC1YJ3Xc90OII+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fOwBB462; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fOwBB462"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6241F00A3D;
	Wed,  9 Sep 2026 01:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918925;
	bh=oxFaKTokBYHQVZHFiz5Pfo++0LKM9CrQwC4DcuYSkOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fOwBB462023ei7e8WJQDllE+9tv7YnSCz5/uUi6TiXZm/Gqbjj5b0QBgICJOkjrte
	 2B6LsEM00kbYzEgkcfNmAdMCfWwVg79C2Fm34ovFcccKpgWZQQyyzy1I6QiUwVntxt
	 6qL1EAm79luNS1jrCGM7OR2TSV9jpmw5TGxqPPqjut1BkFilWJBvIwVMQmtu3ZkUhB
	 WefsKwL1DoqO97Tf91hYuTcI9YFRSgm/FgiNYEgNfFqNfvZXfQS8jkpB1nRHhPlhLh
	 Go1CibxiAuCgkS4bAs62DAjBgZp6o0P7MCjlfIXZQG7cuzx6zjFXRcWlM3HC7Dd0kh
	 DptVfPIK7/43w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] svcrdma: Refactor the creation of listener CMA ID
Date: Tue,  8 Sep 2026 21:55:20 -0400
Message-ID: <20260909015522.954712-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909015522.954712-1-sashal@kernel.org>
References: <2026090356-dehydrate-probe-c315@gregkh>
 <20260909015522.954712-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 283d28546234b1764a0a37cb3df30cc3321c75b4 ]

In a moment, I will add a second consumer of CMA ID creation in
svcrdma. Refactor so this code can be reused.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: e346ef7bcb13 ("svcrdma: Use svc_xprt_put to free listener on create failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 67 ++++++++++++++----------
 1 file changed, 40 insertions(+), 27 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index 575de045b465e..e067d171fc4d4 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -65,6 +65,8 @@
 
 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 						 struct net *net, int node);
+static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
+				   struct rdma_cm_event *event);
 static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 					struct net *net,
 					struct sockaddr *sa, int salen,
@@ -125,6 +127,41 @@ static void qp_event_handler(struct ib_event *event, void *context)
 	}
 }
 
+static struct rdma_cm_id *
+svc_rdma_create_listen_id(struct net *net, struct sockaddr *sap,
+			  void *context)
+{
+	struct rdma_cm_id *listen_id;
+	int ret;
+
+	listen_id = rdma_create_id(net, svc_rdma_listen_handler, context,
+				   RDMA_PS_TCP, IB_QPT_RC);
+	if (IS_ERR(listen_id))
+		return listen_id;
+
+	/* Allow both IPv4 and IPv6 sockets to bind a single port
+	 * at the same time.
+	 */
+#if IS_ENABLED(CONFIG_IPV6)
+	ret = rdma_set_afonly(listen_id, 1);
+	if (ret)
+		goto out_destroy;
+#endif
+	ret = rdma_bind_addr(listen_id, sap);
+	if (ret)
+		goto out_destroy;
+
+	ret = rdma_listen(listen_id, RPCRDMA_LISTEN_BACKLOG);
+	if (ret)
+		goto out_destroy;
+
+	return listen_id;
+
+out_destroy:
+	rdma_destroy_id(listen_id);
+	return ERR_PTR(ret);
+}
+
 static struct svcxprt_rdma *svc_rdma_create_xprt(struct svc_serv *serv,
 						 struct net *net, int node)
 {
@@ -302,7 +339,6 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 {
 	struct rdma_cm_id *listen_id;
 	struct svcxprt_rdma *cma_xprt;
-	int ret;
 
 	if (sa->sa_family != AF_INET && sa->sa_family != AF_INET6)
 		return ERR_PTR(-EAFNOSUPPORT);
@@ -312,30 +348,13 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	set_bit(XPT_LISTENER, &cma_xprt->sc_xprt.xpt_flags);
 	strcpy(cma_xprt->sc_xprt.xpt_remotebuf, "listener");
 
-	listen_id = rdma_create_id(net, svc_rdma_listen_handler, cma_xprt,
-				   RDMA_PS_TCP, IB_QPT_RC);
+	listen_id = svc_rdma_create_listen_id(net, sa, cma_xprt);
 	if (IS_ERR(listen_id)) {
-		ret = PTR_ERR(listen_id);
-		goto err0;
+		kfree(cma_xprt);
+		return (struct svc_xprt *)listen_id;
 	}
-
-	/* Allow both IPv4 and IPv6 sockets to bind a single port
-	 * at the same time.
-	 */
-#if IS_ENABLED(CONFIG_IPV6)
-	ret = rdma_set_afonly(listen_id, 1);
-	if (ret)
-		goto err1;
-#endif
-	ret = rdma_bind_addr(listen_id, sa);
-	if (ret)
-		goto err1;
 	cma_xprt->sc_cm_id = listen_id;
 
-	ret = rdma_listen(listen_id, RPCRDMA_LISTEN_BACKLOG);
-	if (ret)
-		goto err1;
-
 	/*
 	 * We need to use the address from the cm_id in case the
 	 * caller specified 0 for the port number.
@@ -344,12 +363,6 @@ static struct svc_xprt *svc_rdma_create(struct svc_serv *serv,
 	svc_xprt_set_local(&cma_xprt->sc_xprt, sa, salen);
 
 	return &cma_xprt->sc_xprt;
-
- err1:
-	rdma_destroy_id(listen_id);
- err0:
-	kfree(cma_xprt);
-	return ERR_PTR(ret);
 }
 
 /*
-- 
2.53.0

