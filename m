Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C8130648C
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917854; cv=none; b=irWnhWlH5J18TWDyyBviqOlbd0xUu+1ZKFyOT56X8jxjBbcYvQga1LoPzwcVFKC0MalhFYNXGE59ySZafgjDtXn2iIXCkqyj8qmsD7B39m85/J2oU82qkIkCIjchAgy47nXo8EgyOeQskscVoalpXfxOL8jRB1bsKySN72K6eIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917854; c=relaxed/simple;
	bh=C0d1wWhyRvZVxpt9PbnG5wJYusOE9uNbP0WuKmKY+D8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u2kLqd22CHjp2K6qPu2GSp+WJjm0wK7xPb21sbv7XgsOIwD9mxd0vifQ0Ubij0z6ka4NUsLtfNSx+89AL20LYe+CrV8awlnkM+mERHzygjqkRyNoGXPL7hQCOHWjUvoyMkbHDSjE3/h2gKPfWhx8pW2GCKathx6UB/dzS0SDbso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kedj9e+2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kedj9e+2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC0191F00ACA;
	Wed,  9 Sep 2026 01:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917851;
	bh=h9JxX/uiC1iLEXQAVrF9IQM12GTxK0w7E3bA8gl7UTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kedj9e+2QyUgKLnHjdUbh8urWNQua8Lv/NBMzRnLGNsuYg2/IXT6R4atBuSqTwIs/
	 mVML1SU+jQqQQirWH60pTjJ5hoXV1vEDTzQkz9Ufa9/hYkbk9mSZwRXHj/9BlCl2Bj
	 3jYnujt0l05J3wdnP5TYFz6wwQvX3tG7P86qSpIrJZS0TfELmLjg22+BMWwh9N92aF
	 3jLcP14sNQUB4cUXT02oJbM1R+k8ZV9NZiAHC7zcIWF84bBqDf8hzDmRTAY/Cht2fQ
	 9hTSlUCkDvyUgnYPUgFWyYB6oRuUNQY03OQ2HIEbIflSVCJS+hMOcoxDX8QI/7r2jW
	 b5thhs6ShAT+Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/4] svcrdma: Reject connection when transport allocation fails
Date: Tue,  8 Sep 2026 21:37:27 -0400
Message-ID: <20260909013727.906528-4-sashal@kernel.org>
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
index 9adb2ad031e97..38843fd6f35fd 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_transport.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_transport.c
@@ -223,12 +223,16 @@ svc_rdma_parse_connect_private(struct svcxprt_rdma *newxprt,
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
@@ -238,7 +242,7 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 				       listen_xprt->sc_xprt.xpt_net,
 				       ibdev_to_node(new_cma_id->device));
 	if (!newxprt)
-		return;
+		return 1;
 	newxprt->sc_cm_id = new_cma_id;
 	new_cma_id->context = newxprt;
 	svc_rdma_parse_connect_private(newxprt, param);
@@ -272,6 +276,7 @@ static void handle_connect_req(struct rdma_cm_id *new_cma_id,
 
 	set_bit(XPT_CONN, &listen_xprt->sc_xprt.xpt_flags);
 	svc_xprt_enqueue(&listen_xprt->sc_xprt);
+	return 0;
 }
 
 /**
@@ -295,8 +300,7 @@ static int svc_rdma_listen_handler(struct rdma_cm_id *cma_id,
 
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

