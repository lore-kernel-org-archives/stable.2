Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617525;
	b=S9NBf+e6U5Y/HSXCcRGU98BDqPVO73I8VU7iHRZ0i2hSm0TbUkUN7Xg15RhH5N36ASLH
	 lCS5tYChS8unc+4+T6yS1DYeUQdmcrD1HCKs6qNxjSxkp56Pdww7X59809pCuNcOpsHMT
	 aZ8vICs4gy/2p7sB7CtLpOhtDWI74axcbcNe4RdJUUxRCh4uHxw1P7n6pfrQOOSAnh96p
	 JMjYp39lblmPtSAAn/L4LR5bR0UBJP8jzgJGpdgq/XDKf5oHmw+xevJPJPp4FFlTtNuXR
	 inoC+cNmXVtdlI1cN3GsMNoKZoaPZVQMloYz1J0+7C+T/+RYntMYOxB4tadvfi86JVA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617525;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pzOyiqmk8vOVYTUz/e5PR1CsjXHgNafQ7mmBH3pCevI=;
	b=0PIrxKcKGAkoGihqqGXnxRdqX5nn83Oto4s2ZQ9jJJRlKj7AjVq4xf2TBWhTvhACHhfc
	 Mzg1jwWBb9S6Gmnr/NY186R3rbnPArTCvWbXgJvkaU3bUxxhta7cAiDO97UFySmEXVn78
	 KRDaDeFY2sT1h9ApIA6IdCYwuDUZa4dxbm6EkrkzHaJ9qqVqObL9m/EBpvLlUlxUsWfSb
	 6TISEUrS50yrcUvoOBW7sKgaMzfETXIsqpirEsujdJefOS05OvGACucqS/HS916rMedL3
	 /HRIA+S9gCM3escFJJi7n+1YF/aiy+Or1u9UELafniU0xq7jJ7IvRGM4ii2ldI5Hhww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xjlq9s53;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D87606A32A
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xjlq9s53
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E6391F000D1;
	Wed, 25 Nov 2026 14:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617525;
	bh=pzOyiqmk8vOVYTUz/e5PR1CsjXHgNafQ7mmBH3pCevI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xjlq9s53kQa0So9Wzq1WlRDBh/UGhyr3yLyPu+dLkQ5ZJs3D/1pZr4F4B8KFJEz9C
	 FWneA3MwH2vI93a2geNUCh4uIJVrC/m37b+iF2cu2yYKIp87snYmRdDor9rgWdnwV1
	 kD5h/6GjchOy+grn4vSVfDESJyLfvhsIdpqjHZF+gxL0jUYuFXEUQ+tUgRNX5OhD9L
	 zq5a2GViXVXUCRqVXjb+PD555nH1FgQ5IdKWkzuhJ1lDNYY+1d7R+VEsviMsQsulGJ
	 GydXReTikJ7MjDeFCHo3h3DcCcp6bIcLrrzEf5LLdzgeasmfNPvjlZbc3mi+BE12Ay
	 ho0CNfBgLZNlg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/3] xprtrdma: Decouple frwr_wp_create from frwr_map
Date: Wed, 25 Nov 2026 09:38:41 -0500
Message-ID: <20261125143832.4032030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112555-skid-rage-336f@gregkh>
References: <2026112555-skid-rage-336f@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

[ Upstream commit 6f2e565fb3bd68636e4920223e599d70861f8ba6 ]

frwr_wp_create is the only caller of frwr_map outside the encode
path. It registers a single 4-byte write-pad region from a stack-
local rpcrdma_mr_seg. Inlining the registration logic directly
(sg_init_table + sg_set_page + ib_dma_map_sg + ib_map_mr_sg +
IOVA mangle + reg_wr setup) eliminates the coupling that would
otherwise complicate the removal of rpcrdma_mr_seg from frwr_map's
interface.

The inlined version adds a proper error-unwind ladder: on failure,
the DMA mapping (if established) is released, ep->re_write_pad_mr is
cleared, and the MR is returned to the transport free list. The old
frwr_map-based code relied on rpcrdma_mrs_destroy at teardown to
reclaim partially-initialized MRs.

This is a one-time setup path; duplicating ~20 lines is a reasonable
tradeoff for decoupling the write-pad registration from the data-
path MR registration.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
Stable-dep-of: 1fa415883c37 ("xprtrdma: serialize unmap_sync with xprt_disconnect")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/sunrpc/xprtrdma/frwr_ops.c | 57 +++++++++++++++++++++++++++++-----
 1 file changed, 50 insertions(+), 7 deletions(-)

diff --git a/net/sunrpc/xprtrdma/frwr_ops.c b/net/sunrpc/xprtrdma/frwr_ops.c
index a82eefe5e6b58..d2c7ac5f4e016 100644
--- a/net/sunrpc/xprtrdma/frwr_ops.c
+++ b/net/sunrpc/xprtrdma/frwr_ops.c
@@ -669,9 +669,13 @@ void frwr_unmap_async(struct rpcrdma_xprt *r_xprt, struct rpcrdma_req *req)
  */
 int frwr_wp_create(struct rpcrdma_xprt *r_xprt)
 {
+	struct rpcrdma_buffer *buf = &r_xprt->rx_buf;
 	struct rpcrdma_ep *ep = r_xprt->rx_ep;
-	struct rpcrdma_mr_seg seg;
+	struct ib_reg_wr *reg_wr;
 	struct rpcrdma_mr *mr;
+	struct ib_mr *ibmr;
+	int dma_nents;
+	int ret;
 
 	mr = rpcrdma_mr_get(r_xprt);
 	if (!mr)
@@ -679,11 +683,39 @@ int frwr_wp_create(struct rpcrdma_xprt *r_xprt)
 	mr->mr_req = NULL;
 	ep->re_write_pad_mr = mr;
 
-	seg.mr_len = XDR_UNIT;
-	seg.mr_page = virt_to_page(ep->re_write_pad);
-	seg.mr_offset = offset_in_page(ep->re_write_pad);
-	if (IS_ERR(frwr_map(r_xprt, &seg, 1, true, xdr_zero, mr)))
-		return -EIO;
+	sg_init_table(mr->mr_sg, 1);
+	sg_set_page(mr->mr_sg, virt_to_page(ep->re_write_pad),
+		    XDR_UNIT, offset_in_page(ep->re_write_pad));
+
+	mr->mr_dir = DMA_FROM_DEVICE;
+	mr->mr_nents = 1;
+	dma_nents = ib_dma_map_sg(ep->re_id->device, mr->mr_sg,
+				  mr->mr_nents, mr->mr_dir);
+	if (!dma_nents) {
+		ret = -EIO;
+		goto out_mr;
+	}
+	mr->mr_device = ep->re_id->device;
+
+	ibmr = mr->mr_ibmr;
+	if (ib_map_mr_sg(ibmr, mr->mr_sg, dma_nents, NULL,
+			 PAGE_SIZE) != dma_nents) {
+		ret = -EIO;
+		goto out_unmap;
+	}
+
+	/* IOVA is not tagged with an XID; the write-pad is not RPC-specific. */
+	ib_update_fast_reg_key(ibmr, ib_inc_rkey(ibmr->rkey));
+
+	reg_wr = &mr->mr_regwr;
+	reg_wr->mr = ibmr;
+	reg_wr->key = ibmr->rkey;
+	reg_wr->access = IB_ACCESS_REMOTE_WRITE | IB_ACCESS_LOCAL_WRITE;
+
+	mr->mr_handle = ibmr->rkey;
+	mr->mr_length = ibmr->length;
+	mr->mr_offset = ibmr->iova;
+
 	trace_xprtrdma_mr_fastreg(mr);
 
 	mr->mr_cqe.done = frwr_wc_fastreg;
@@ -693,5 +725,16 @@ int frwr_wp_create(struct rpcrdma_xprt *r_xprt)
 	mr->mr_regwr.wr.opcode = IB_WR_REG_MR;
 	mr->mr_regwr.wr.send_flags = 0;
 
-	return ib_post_send(ep->re_id->qp, &mr->mr_regwr.wr, NULL);
+	ret = ib_post_send(ep->re_id->qp, &mr->mr_regwr.wr, NULL);
+	if (!ret)
+		return 0;
+
+out_unmap:
+	frwr_mr_unmap(mr);
+out_mr:
+	ep->re_write_pad_mr = NULL;
+	spin_lock(&buf->rb_lock);
+	rpcrdma_mr_push(mr, &buf->rb_mrs);
+	spin_unlock(&buf->rb_lock);
+	return ret;
 }
-- 
2.53.0

