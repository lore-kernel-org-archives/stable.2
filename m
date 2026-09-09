Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7101E2E7BD3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917473; cv=none; b=OE+hu/5/PsZJQrslt7mAnUiLDEhhyIE+UTLnfbQ+CoTL8xvC/C+Lu0fAIN2umsccq7MkeqVW7rodQk4KYp6GDL7rW2xur/VgEGzjWJm2AiAQrkuDFB58ItITfaZrtk/gaAuMHUcmx//jBQOG0A6R1K9rBfUV55bj0z9P3z/c2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917473; c=relaxed/simple;
	bh=sKH5vjWlLt/fVCj6wH2a+xEuqqSrlI0e1dEFnpC27Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Abqbx/YwvzHjPGH0VszrNNFUwZhgDThzqkTuOuPCq9jeW/5LyiQbVkvM/ypHiae1tnyrHJb2/HF90MYbirk65A9oNgS4E+Lvo8UjdjjenDqoeM1d6oXymbNqm5BvEf3x1SUW4Grb4Y+atUWbjqMHjuRaUSFWi3nbU+pGfdnZpcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L1oyhzfL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L1oyhzfL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A9B1F00A3D;
	Wed,  9 Sep 2026 01:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917472;
	bh=wlLgnLhKjZVP6rgQe+X5rOLiI3Ri7yJSm0mJTOz53l8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L1oyhzfLx7t6ZsNBOhyg+dTQMN+vpEO15W8nbS8jhylin7ZfdUANJP2xhPD7teLD0
	 MkofQuf1fJppdL60uOdcHNR23kLHeLSNEjNYQZ+ozA4Gk1WThPfKIqa13uARyKMrz2
	 /4jbbnN1Z+9qcrZar5kEUIWdiiORya7GImieNPDexu1/KSOj1v5NH01X6ott8yHWVT
	 I18tTr3vAjTpbYcaNu4gs1TjlL224krZ5o8nCRIsfpjIi5jYaWfmfAlrMApFwx+mSC
	 QqNbYBxuWpz9OzDuF3F5mEd2Rm2kAwXDN+mOL5m7bcP9ks/1xV3lssZoTWN9ZY6ib7
	 /0cBBxwNN7KJQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] svcrdma: Refactor the creation of listener CMA ID
Date: Tue,  8 Sep 2026 21:31:07 -0400
Message-ID: <20260909013109.887545-2-sashal@kernel.org>
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

[ Upstream commit 283d28546234b1764a0a37cb3df30cc3321c75b4 ]

In a moment, I will add a second consumer of CMA ID creation in
svcrdma. Refactor so this code can be reused.

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Stable-dep-of: 0944462247dc ("svcrdma: Reject connection when transport allocation fails")
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

