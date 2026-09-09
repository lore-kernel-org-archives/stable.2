Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A583D891E
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 09:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788946000; cv=none; b=a+O/P5hGC4VHpIXLt9UDDHmpKmXtUANZXG6x2Xee/2IHWpD3JhNBCYH69ROJ/ByT55LARoGCDPu3pDY4h3V17ZDPuj0i9X0Nb1XJNa1jozuJ7yvbbC8pDAkkq5dQlYuxh1dsR+rg2743WBj4wFTt1V8J1WOQOPZQ11y3pef1OLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788946000; c=relaxed/simple;
	bh=RoORXS5BP5AgEhjXvIhbm3G7w/ZsCZwi72hJrifKCR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=twIGZzxjRTplbVk0hMFAemvHfItVcLd8xDEK6OjRnipbEvCCB0nQrcch0dph0PQbNyHA+4KQp9zV0tAL9PCOpvQVKw7e570Ycr1RqWkY/D2796loI//Gw38UYg4pOioL0b3RDtD+wcukJ7yJfQTwrF6ymt5QQZ/23gDJ+z2vtsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VvnPMz8N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VvnPMz8N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71C1C1F00A3D;
	Wed,  9 Sep 2026 09:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945999;
	bh=B2Q0XwL9I99ICGrFFVOLwCIaSTK0CbS95jz+O+lc+9U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VvnPMz8Nj4e87HnTFUMT+1SwVrdP7JIrk74gL9Ecpe8Q7IX+V7ftysk6PyOuLZdKY
	 2VtbFYPpl/u2DG1JcQmwYVlB/v68adWUox8UQjr3VL3533q5c6Qc1z363HkL1bmPwZ
	 uVI411wFuv8s5HgPuu7ErXHdkLtxgpEmkULK4OgF1H0D78EjfkuUMMQwK3eTUTDLfp
	 EOB1+4S2MvdS73QBr6hhaDLHVMU3eaCWXdHp58WQqq010JiNZsGVnqtSIqid3C3AP5
	 Wp354V12ttRk/fWviu45TSYz0VBiayZO0LWMjoDmeKEnJz+Z7vdkptY/cdghB8U+i5
	 8thvFb2aUcWbg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
Date: Wed,  9 Sep 2026 05:26:35 -0400
Message-ID: <20260909092636.1296906-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909092636.1296906-1-sashal@kernel.org>
References: <2026090343-runway-amaretto-1501@gregkh>
 <20260909092636.1296906-1-sashal@kernel.org>
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

Backport to 6.1: retain the flexible rc_pages array and rc_maxpages
validation, but allocate RPCSVC_MAXPAGES entries because this tree still
uses a fixed RPC page limit and has no svc_serv_maxpages() helper. Keep
the existing kmalloc allocation policy and omit __counted_by, which this
tree does not provide. The allocation and segment limit therefore retain
the stable tree's existing capacity.

This supplies the rc_maxpages context needed for target 9808eb765666
("svcrdma: Reject Write/Reply chunks with segcount 0") to apply unchanged,
without adding functions or importing the newer server sizing and NUMA
allocation changes.

Stable-dep-of: 9808eb765666 ("svcrdma: Reject Write/Reply chunks with segcount 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h         | 3 ++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/sunrpc/svc_rdma.h b/include/linux/sunrpc/svc_rdma.h
index 2bfc32337bc2e..bab8d45fcb58c 100644
--- a/include/linux/sunrpc/svc_rdma.h
+++ b/include/linux/sunrpc/svc_rdma.h
@@ -148,7 +148,8 @@ struct svc_rdma_recv_ctxt {
 	struct svc_rdma_pcl	rc_reply_pcl;
 
 	unsigned int		rc_page_count;
-	struct page		*rc_pages[RPCSVC_MAXPAGES];
+	unsigned long		rc_maxpages;
+	struct page		*rc_pages[];
 };
 
 struct svc_rdma_send_ctxt {
diff --git a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
index ec759cfecbcde..f49bff8bf8b26 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -129,9 +129,10 @@ svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 	dma_addr_t addr;
 	void *buffer;
 
-	ctxt = kmalloc(sizeof(*ctxt), GFP_KERNEL);
+	ctxt = kmalloc(struct_size(ctxt, rc_pages, RPCSVC_MAXPAGES), GFP_KERNEL);
 	if (!ctxt)
 		goto fail0;
+	ctxt->rc_maxpages = RPCSVC_MAXPAGES;
 	buffer = kmalloc(rdma->sc_max_req_size, GFP_KERNEL);
 	if (!buffer)
 		goto fail1;
@@ -491,7 +492,7 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	 * a computation, perform a simple range check. This is an
 	 * arbitrary but sensible limit (ie, not architectural).
 	 */
-	if (unlikely(segcount > RPCSVC_MAXPAGES))
+	if (unlikely(segcount > rctxt->rc_maxpages))
 		return false;
 
 	p = xdr_inline_decode(&rctxt->rc_stream,
-- 
2.53.0

