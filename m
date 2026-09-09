Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF53438837A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788948944; cv=none; b=l6iCOosEi2hDXD7tWgxPiwJA5zxK2eUet+HIC2aJpk4MXHT0tl6xR3Bz9dr8fbGe872NcdywBSDN+gRXrhGbw9wIf0VsCoIjyL7zq4gAGHVgNNAbftu0b/DFzQD68lLur90/wJwCWVGCusPCW9F66XiYUQ9ockufvrIPFKSqVc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788948944; c=relaxed/simple;
	bh=J0GqMoWgRVDxJAE6if6K3tBc9C/UZGT3v2I7HCW8hzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wr+qS/fUK0SzBLPdh8JrbbfjN4hO7i0KqobDK3t0Afgxwx90o9cNRa5flP8j6igOd66W11OcwODXQTbldc3g4YmT+8b+KcteS4nJz58oti9Vmu3kXRHCAnAH9NpXxQ+q/hUaaTMphZwfVpaX3ctEgDMnQGjNNiwqfv+nSs/hjAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b2b9lw8R; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b2b9lw8R"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5438A1F00ADB;
	Wed,  9 Sep 2026 10:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788948938;
	bh=XE7qDztbQTlfGmgcZwMcl3wU+YMspCwe0mQnTGkuzhQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b2b9lw8RmH4kpzBBTPumxyQuBMEcsbog14gmHkPrQsn8B2B3aQpcZI8KCzDobR6yw
	 uoyoM/+Av/9+D2Ip/xy3u4JXCJVzjYfRaQChUFKXxCVfcromov5PTb24EtfhtgQ5b6
	 1QQHMrF0TKnNuuuN1OAIlO0UFvqNZvgp1CTlO7loKwKhbAk+rUMGSd5Xn5VFFFbYze
	 Cd/fr04/ETg8O2nYfq0zW+sjul1xpqsz2SUdd+5BhYvpuBLXI1cLKkkkR9F70j/NqW
	 mcmF5Low/ndEAgCkxekIVwmEe6KAZ/tIjWgpRvnOo8oORr401Koo3RYcqGc28vYv3c
	 8qn35xoFRAHIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Jeff Layton <jlayton@kernel.org>,
	NeilBrown <neil@brown.name>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] svcrdma: Adjust the number of entries in svc_rdma_recv_ctxt::rc_pages
Date: Wed,  9 Sep 2026 06:15:35 -0400
Message-ID: <20260909101536.1481226-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909101536.1481226-1-sashal@kernel.org>
References: <2026090344-perfume-python-398c@gregkh>
 <20260909101536.1481226-1-sashal@kernel.org>
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

For the 5.15 backport, keep the existing kmalloc allocation policy and
size the flexible rc_pages array with RPCSVC_MAXPAGES. This tree retains
fixed-size RPC request page arrays and does not have svc_serv_maxpages(),
so using the existing limit preserves both allocation capacity and the
accepted segment-count upper bound without adding a helper function.
Omit __counted_by, which is not available in this tree.

Retain rc_maxpages and use it in xdr_check_write_chunk() so that target
9808eb765666 ("svcrdma: Reject Write/Reply chunks with segcount 0") applies
without changes. Initialize rc_maxpages before the context is published.

Include linux/pagemap.h explicitly for release_pages(). The preceding
rc_pages backport added this call without its declaration, causing an
implicit-function-declaration build error on this stable tree.

Stable-dep-of: 9808eb765666 ("svcrdma: Reject Write/Reply chunks with segcount 0")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/sunrpc/svc_rdma.h         | 3 ++-
 net/sunrpc/xprtrdma/svc_rdma_recvfrom.c | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

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
index cf673cf9584d5..7d3b8fea9c682 100644
--- a/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
+++ b/net/sunrpc/xprtrdma/svc_rdma_recvfrom.c
@@ -92,6 +92,7 @@
  * are transferred from the svc_rdma_recv_ctxt to the second svc_rqst.
  */
 
+#include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <asm/unaligned.h>
@@ -126,12 +127,15 @@ static struct svc_rdma_recv_ctxt *
 svc_rdma_recv_ctxt_alloc(struct svcxprt_rdma *rdma)
 {
 	struct svc_rdma_recv_ctxt *ctxt;
+	unsigned long pages;
 	dma_addr_t addr;
 	void *buffer;
 
-	ctxt = kmalloc(sizeof(*ctxt), GFP_KERNEL);
+	pages = RPCSVC_MAXPAGES;
+	ctxt = kmalloc(struct_size(ctxt, rc_pages, pages), GFP_KERNEL);
 	if (!ctxt)
 		goto fail0;
+	ctxt->rc_maxpages = pages;
 	buffer = kmalloc(rdma->sc_max_req_size, GFP_KERNEL);
 	if (!buffer)
 		goto fail1;
@@ -486,7 +490,7 @@ static bool xdr_check_write_chunk(struct svc_rdma_recv_ctxt *rctxt)
 	 * a computation, perform a simple range check. This is an
 	 * arbitrary but sensible limit (ie, not architectural).
 	 */
-	if (unlikely(segcount > RPCSVC_MAXPAGES))
+	if (unlikely(segcount > rctxt->rc_maxpages))
 		return false;
 
 	p = xdr_inline_decode(&rctxt->rc_stream,
-- 
2.53.0

