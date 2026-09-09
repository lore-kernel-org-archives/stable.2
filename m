Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490DF286881
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788915130; cv=none; b=pKwSjdaoFl9sqdJiFOXRiBYV5U3GhClA0TUT3nn30udkl13/fQM+75d+7LSBBqd1hbSuETgNgBM85WIJwcdJzWPxlp1/OydGUvmWHiexW/eVTZ8E67HuaHS+H1jOjpqDZWG1GKCs26fBku9kSLpa9Zs4ItjmjYhcH5EsjkBGaVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788915130; c=relaxed/simple;
	bh=fYyBlx1Xtqp+dpx+TEi1k2MsovTolm7s31ikyjJwBWg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lG4zXXnhlx5sFjQe5oOS9eiXWmtaRGm4y7PbXdG+RmZE//0b/EQ1Crqvisp0AxEgr2EBmFzix4TpLSFJUlSWvo4udBcamogkEJg26QsTTJByR+jnobT7FxyG0mmM2iwqh9/rqpmBpxrZWniBImspViJS2QOBg5yJl9K/07fyiZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mzrcem4J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mzrcem4J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC671F00A3F;
	Wed,  9 Sep 2026 00:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788915128;
	bh=se8xM0el4THg19diSlAWDlEpM2OOFXIWqUoVjGH+NpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mzrcem4JJEoGYHI/dD0BB8PYNGK0GOjB5vaLV8x7O3HCb4mVKouMf/MtTdtuVoz/7
	 pJ3UYnwk7S5LZbqLjNq0V0nUJ01VlUcxnkQBtFpJWMAIJiQNfewg8LrMF5yxs6tpZM
	 XkhnhSIuS4M3EJXZvP7O70+x7R5G0nEwjtk+j+IPH24KjAoGTpwy4Cmw8kWKojoiyX
	 R6gyTG3CFJouofpm2fLxnTa787lsy31A6Fzkd7fBV+NnLks/BuPmcwUwvpcK5yyMGw
	 jD7RDJHzpoh+nh3cKFQ2qbJ58femvATRnQktFttMwCAVoe9dZq09UdIw02JLqlRe0+
	 PM4H7R1FDenvA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] svcrdma: Reject connection when transport allocation fails
Date: Tue,  8 Sep 2026 20:52:04 -0400
Message-ID: <20260909005204.805051-4-sashal@kernel.org>
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

[ Upstream commit 0944462247dcb7de7622cdaaadf5f05c52707dab ]

handle_connect_req() returns without action when
svc_rdma_create_xprt() fails to allocate the new transport.
The CM core returns 0 for CONNECT_REQUEST events, so it does
not destroy the new rdma_cm_id. Each allocation failure under
memory pressure leaks one rdma_cm_id, and a remote peer driving
connection attempts can amplify this.

Reject the connection by returning a non-zero status from the
CM event handler, which tells the CM core to destroy the
orphaned cm_id.

Fixes: 377f9b2f4529 ("rdma: SVCRDMA Core Transport Services")
Cc: stable@vger.kernel.org
Acked-by: Jeff Layton <jlayton@kernel.org>
Link: https://patch.msgid.link/20260527-rdma-follow-on-v1-4-1b09bd87b6cd@oracle.com
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/svc_rdma_transport.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/net/sunrpc/xprtrdma/svc_rdma_transport.c b/net/sunrpc/xprtrdma/svc_rdma_transport.c
index de28aae30a409..0961973606bcf 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -221,12 +221,16 @@ svc_rdma_parse_connect_private(struct svcxprt_rdma *newxprt,
  * structure for the listening endpoint.
  *
  * This function creates a new xprt for the new connection and enqueues it on
- * the accept queue for the listent xprt. When the listen thread is kicked, it
+ * the accept queue for the listen xprt. When the listen thread is kicked, it
  * will call the recvfrom method on the listen xprt which will accept the new
  * connection.
+ *
+ * Return values:
+ *     %0: Do not destroy @new_cma_id
+ *     %1: Destroy @new_cma_id (allocation failure)
  */
-static void handle_connect_req(struct rdma_cm_id *new_cma_id,
-			       struct rdma_conn_param *param)
+static int handle_connect_req(struct rdma_cm_id *new_cma_id,
+			      struct rdma_conn_param *param)
 {
 	struct svcxprt_rdma *listen_xprt = new_cma_id->context;
 	struct svcxprt_rdma *newxprt;
@@ -236,7 +240,7 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 				       listen_xprt->sc_xprt.xpt_net,
 				       ibdev_to_node(new_cma_id->device));
 	if (!newxprt)
-		return;
+		return 1;
 	newxprt->sc_cm_id = new_cma_id;
 	new_cma_id->context = newxprt;
 	svc_rdma_parse_connect_private(newxprt, param);
@@ -270,6 +274,7 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 
 	set_bit(XPT_CONN, &listen_xprt->sc_xprt.xpt_flags);
 	svc_xprt_enqueue(&listen_xprt->sc_xprt);
+	return 0;
 }
 
 /**
@@ -293,8 +298,7 @@ static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
 
 	switch (event->event) {
 	case RDMA_CM_EVENT_CONNECT_REQUEST:
-		handle_connect_req(cma_id, &event->param.conn);
-		break;
+		return handle_connect_req(cma_id, &event->param.conn);
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		listen_id = svc_rdma_create_listen_id(cma_rdma->xpt_net,
 						      sap, cma_xprt);
-- 
2.53.0

