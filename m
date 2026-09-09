Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804E7212550
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 00:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788914197; cv=none; b=aFXjAQ9954W6PcM9SYq7ayZx+ORUZx37xiQhNrGdZBWvUaET6q3dwTIX1NiDC6eH0oRPBlPNBXGF8NkGrOVbX/YvEFNqEsTJXOaB7pPT02C9pmRtjGear6iA9i4q6HySMd9LOOSBvWVy2i2PosgGvEsBUH34Y8RL89bv0xSjasE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788914197; c=relaxed/simple;
	bh=srg8NpiV0bv6WJF3si+o7rtSSXCcPPS3ne/WjN90teg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZaVxCsstHTAxmj4oyOjSrqUcYO/I35UgdKzBry/pdaYxkjHDGICPVonsEYvHwZfRSEq8v40RsVQgw0pRUfXwsEmn84NOzyN7iGl4UlOJfJ/kSt46QOh5QRvtU3DLq2OXrANAOlQMVp0LGy0cALRE9iQtAQmA0Y8Da2KDbtooOu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dGcEv5hL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dGcEv5hL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2ECF1F00A3F;
	Wed,  9 Sep 2026 00:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788914196;
	bh=RFaqGhRnkVy48D1nLmozKVhZDnrqwxFhgnfjL2WiLiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dGcEv5hLnIbOVWoR3FxTC4x4oND1ifesXI5JEvGyauf0ZRiUQKeIlaF0K7+1MkiIU
	 A3K9Y/hN1G1Sncr+oePUCy3RY69zAawQgf+nt7dV0ivBRuFZ9+c2wQyaXgVZlWUZ5v
	 o5PQnqGEwlGny4LLPbCjJmHznqImN5XiS60JQulRN/trvg//dWmcsNj2RqPBd6sVe9
	 1qqxVHMSNl48Dms5OlIB2UvXpiV5eo65MeWzO6S+vl+F4kqAI2ZNfWS9fBjULiac3f
	 hzUp5ABpd0lzT5h3JzcxANyllGbfUknSFgNvuiao7sD5QvbVKAvw67szqP6CXAguil
	 LDCgUFFwvOpjA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
Date: Tue,  8 Sep 2026 20:36:32 -0400
Message-ID: <20260909003633.747471-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909003633.747471-1-sashal@kernel.org>
References: <2026090342-canary-synopses-a220@gregkh>
 <20260909003633.747471-1-sashal@kernel.org>
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
Stable-dep-of: 9808eb765666 ("svcrdma: Reject Write/Reply chunks with segcount 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h         | 3 ++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 619fc0bd837a8..1016f2feddc4b 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -202,7 +202,8 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_pcl	rc_reply_pcl;
 
 	unsigned int		rc_page_count;
-	struct page		*rc_pages[RPCSVC_MAXPAGES];
+	unsigned long		rc_maxpages;
+	struct page		*rc_pages[] __counted_by(rc_maxpages);
 };
 
 /*
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index 292022f0976e1..e7e4a39ca6c65 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -120,12 +120,16 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
 	int node = ibdev_to_node(rdma->sc_cm_id->device);
 	struct svc_rdma_recv_ctxt *ctxt;
+	unsigned long pages;
 	dma_addr_t addr;
 	void *buffer;
 
-	ctxt = kzalloc_node(sizeof(*ctxt), GFP_KERNEL, node);
+	pages = svc_serv_maxpages(rdma->sc_xprt.xpt_server);
+	ctxt = kzalloc_node(struct_size(ctxt, rc_pages, pages),
+			    GFP_KERNEL, node);
 	if (!ctxt)
 		goto fail0;
+	ctxt->rc_maxpages = pages;
 	buffer = kmalloc_node(rdma->sc_max_req_size, GFP_KERNEL, node);
 	if (!buffer)
 		goto fail1;
@@ -497,7 +501,7 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	 * a computation, perform a simple range check. This is an
 	 * arbitrary but sensible limit (ie, not architectural).
 	 */
-	if (unlikely(segcount > RPCSVC_MAXPAGES))
+	if (unlikely(segcount > rctxt->rc_maxpages))
 		return false;
 
 	p = xdr_inline_decode(&rctxt->rc_stream,
-- 
2.53.0

