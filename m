Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59FBF2E764D
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 01:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788917481; cv=none; b=MB5NTiU+rImQUncGGG/SntVPNnQgkHxeeDFP6fFYgFnlVc4uZ5i9bg7YBe0tIO+qE8Bsd6NGxB5QtFOuE/jbQRLAtwRIFV2kz86PvOwuCnF5ZJdfwr5DI5DDS0ffCSILdKMfYEzHERb0hJqN54Dfw0IovStw+WYHz7m+yaYVFYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788917481; c=relaxed/simple;
	bh=TcilNVpagzQZZQGB3928kRIfSN+2Fwsb7aHHiJAi19w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrMyyNln7TQWCKJd9n1KTQVFy8JS5ItzjO/Fqcn0XJYcC7J6WEfVCNcPChaxjEf5v/em73plou6AhnkzP1cQ1jBqM+uZiApkO+zKBWz5PSGjAmkrklexm/hr+KXZ8YViyXXwomQgqyPpFnAUnIf5gm+TxqRE8H4Zv/Xc9ohZQjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NoZ3UWIy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NoZ3UWIy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9E81F00A3E;
	Wed,  9 Sep 2026 01:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788917479;
	bh=qWfHlTfL/RK7ukUP8hdhykVo+XJU4xJ/Sz9G0BteZNs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NoZ3UWIyp6gCw4xgWUsy2t55hynEPJsHkFE8XOd5XPNcZ4LFbR727qXipdcg1K2Ap
	 lT6LKjRuw/lJltGN0HcDSSfdjkM/2sA526X3V3c4PTBMIBSpaeNc4PCKg37vus27kB
	 ob1uNyzzYTuPv+VFAziXchH1dylfOLHO13W3C2Ucoh55TWG6Ez5FtII9P2gFw3bKcA
	 tCmHGLyWQgcJJtWRc3lFsval09JDq23OE90RXrGP0x+cKPf+xvyPoNQoqL9mqpYDkr
	 JWgBYrW0VeAelKEVjrVeo4gPKEZmd9+wa47s8VeD/GE/CP+3Rjjof9PgivpxOCriO8
	 ZYWWfdxakfI6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/4] svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
Date: Tue,  8 Sep 2026 21:31:15 -0400
Message-ID: <20260909013116.888180-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909013116.888180-1-sashal@kernel.org>
References: <2026090343-customize-gorgeous-909c@gregkh>
 <20260909013116.888180-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 81381d1a90dea186ce4585d9bd3cdc40b50e9c48 ]

Allow allocation of more entries in the rc_pages[] array when the
maximum size of an RPC message is increased.

Reviewed-by: Jeff Layton <jlayton@kernel.org>
Reviewed-by: NeilBrown <neil@brown.name>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Backport to the stable allocation path: retain kmalloc_node() while
sizing the context with struct_size() and svc_serv_maxpages(). This tree
initializes the required context fields explicitly, including resetting
rc_page_count in svc_rdma_recv_ctxt_get(), so the upstream switch to
kzalloc_node() is not needed here.

Keep the flexible rc_pages array and initialize rc_maxpages before the
context can be used. The matching Write/Reply segment upper bound is
needed for target 9808eb765666 ("svcrdma: Reject Write/Reply chunks with
segcount 0") to apply unchanged. No new functions are introduced.

Stable-dep-of: 9808eb765666 ("svcrdma: Reject Write/Reply chunks with segcount 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h         | 3 ++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 4ba48bccb7993..6485a60ede659 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -147,7 +147,8 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_pcl	rc_reply_pcl;
 
 	unsigned int		rc_page_count;
-	struct page		*rc_pages[RPCSVC_MAXPAGES];
+	unsigned long		rc_maxpages;
+	struct page		*rc_pages[] __counted_by(rc_maxpages);
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index a6eecdc592412..7214a3a7e1b83 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -127,12 +127,16 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
 	int node = ibdev_to_node(rdma->sc_cm_id->device);
 	struct svc_rdma_recv_ctxt *ctxt;
+	unsigned long pages;
 	dma_addr_t addr;
 	void *buffer;
 
-	ctxt = kmalloc_node(sizeof(*ctxt), GFP_KERNEL, node);
+	pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
+	ctxt = kmalloc_node(struct_size(ctxt, rc_pages, pages),
+			    GFP_KERNEL, node);
 	if (!ctxt)
 		goto fail0;
+	ctxt->rc_maxpages = pages;
 	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
 	if (!buffer)
 		goto fail1;
@@ -487,7 +491,7 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	 * a computation, perform a simple range check. This is an
 	 * arbitrary but sensible limit (ie, not architectural).
 	 */
-	if (unlikely(segcount > RPCSVC_MAXPAGES))
+	if (unlikely(segcount > rctxt->rc_maxpages))
 		return false;
 
 	p = xdr_inline_decode(&rctxt->rc_stream,
-- 
2.53.0

