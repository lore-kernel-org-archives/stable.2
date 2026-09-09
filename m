Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AC812E266C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788918445; cv=none; b=eg4IgrlLjKW1c3ERvaim70M6V0L4EXfDIQGXFj2sEXGoTSuB8w/kYiRLr+ia0EUfOMi/2skSqwjNwom3pf6+SYRDAQfUjVUWgLRDCGMsY/L4aLGPak6G1kvRY7BqFbq9jIR3x8DcPqnz7kYzmusU5lh4QRH6BVqRdqp79U2D4kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788918445; c=relaxed/simple;
	bh=N+kJs2NBOBbEiqmcKa7Q4bq1LWtuxJV45KfGs8iX0l8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GUUrSRJRX9R3UxkftBSu02QOGqQutzYVMFExP4wxj9I3j9Qui9II5NldFERuSmkH+JeW+xfA4FTlqMMIgHWyUnHfQreWwt4nxb/Q/F+aUIS0Gxty45S4/qiRoaYm+Z/42+RNDtLtmTK03g3N0YSyEwR/UecsHPIjTeudFRf4Xnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IE6pg9Mr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IE6pg9Mr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BD41F00A3E;
	Wed,  9 Sep 2026 01:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788918444;
	bh=yuN2JJHQAa0imlw4k0nMGCTLdQfZppRC7GD/hN52OBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IE6pg9MrFn4lWQ8jzZ29XK5+FHq1u1FhGvQGNKGCINvJpd2ivnBntBtsaajFzWXOV
	 6NTsdWqviSqZvs4c5AO8g4jxZCeX8lugyBxbwS1I+s9jgt+H8foMLWDEkLo8jBXc0A
	 yCPWseAXG83X57YfyyL36QkR21JucAZo/YbjfzsZcvYgccYkfvZTIrHoLf0K4nNeOY
	 dy7v3w0rfZ/+y0CHNdYvTNySrltKwtMTn3TU1vEE7STVrOWSLZvy0UMJT66o0OjyoT
	 hhuRggFm7/gsKyypk+WKjkx2Lk/hUXzJjkMMLDKK4FY9TmfxDKRvfGmqvFhhitKvza
	 qL9jiH7ey937A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] svcrdma: Refactor the creation of listener CMA ID
Date: Tue,  8 Sep 2026 21:47:19 -0400
Message-ID: <20260909014721.928409-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909014721.928409-1-sashal@kernel.org>
References: <2026090356-skimpily-grape-6667@gregkh>
 <20260909014721.928409-1-sashal@kernel.org>
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
index 9c4cd4caa0c1c..c84343fbf2d2f 100644
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
@@ -124,6 +126,41 @@ static void qp_event_handler(struct ib_event *event, void *context)
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

