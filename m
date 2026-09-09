Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507B6492E5D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788913509; cv=none; b=G393utVb7fohH2kBGVcp+OW1DQgvlOdFBbF4cdOVZW38GuG1fkp0Tqd1NuqOYHKV9AcFfX8gdvxZOgrPTqpqSseM9ajZeptWmQgxw6R9hk5EwjgtTIS/roSv+qUM+IyXHnvgptkd3jmf5oFAuJ+0F7htItRnvJKHNgqsGgRMDug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788913509; c=relaxed/simple;
	bh=aO0Xjueug8xzsG8qSPM+ywBFTdCMPE4SmSJi7pVd2eQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TilDHsywcXQK2cQfgdvYQJSy3C0DJJTdRV2Amb3cTZCxtXrkrFXl/15m+c62LATFm3LmlEXrBEjTThfLN8Mtp9u3/LRXzNx0tTKwXqy6kzLtxmP50NGXwo4udWM5nO8PvJatCphkF8BcSB0a3E70hGW9e9T+7kNPEWRVNwVaoDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gDqiQRGG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gDqiQRGG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE231F00A3F;
	Wed,  9 Sep 2026 00:25:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788913508;
	bh=Lqw0gjDZO0bFsX/1Pz6ojoMm3jDemBSZwh2RDnEPpYs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gDqiQRGGc3/FoxXz8WZRiYmHbivEs+vVmO8nvG7GwCdtAZvdj37eatgwUWhjuGHIF
	 7GKqAps9yqkLjPJhDW55nLdQqVv57tJbkdzxeXbReXSxuJVyflYEhPrz04CxtNBaek
	 4cNiSEOQnm2HmJtwPgSZ1Y1aGgpH3REboFbEnQBCHnY9t3FG54m92ZR8V/o4xVt+24
	 FaT/kD6ITwQ3foDvfWpteJTzgeEZQV+3zCrnTvr/IewomlWt/orT7VisgZ3iuxx5Nl
	 Gwy8UpXTL+vyIR5I7adFlG5WKQrNCbavUS6G8w/zYAQyi6MYZQELwrY4A9JDhAo3U+
	 z0p5PS+GNMAYQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] svcrdma: Reject connection when transport allocation fails
Date: Tue,  8 Sep 2026 20:25:04 -0400
Message-ID: <20260909002504.725024-3-sashal@kernel.org>
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
index ec7f1bfcf98b5..770c2d7083c60 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -219,12 +219,16 @@ svc_rdma_parse_connect_private(struct svcxprt_rdma *newxprt,
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
@@ -234,7 +238,7 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 				       listen_xprt->sc_xprt.xpt_net,
 				       ibdev_to_node(new_cma_id->device));
 	if (!newxprt)
-		return;
+		return 1;
 	newxprt->sc_cm_id = new_cma_id;
 	new_cma_id->context = newxprt;
 	svc_rdma_parse_connect_private(newxprt, param);
@@ -268,6 +272,7 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 
 	set_bit(XPT_CONN, &listen_xprt->sc_xprt.xpt_flags);
 	svc_xprt_enqueue(&listen_xprt->sc_xprt);
+	return 0;
 }
 
 /**
@@ -291,8 +296,7 @@ static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
 
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

