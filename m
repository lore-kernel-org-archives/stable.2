Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795618043;
	b=zoxjsvJrZUROUqRH54ZB7JQ3DxdkRl3Qn9grHtOkQVOcBSzSRDSYA5hi8MNWM3XLlpaS
	 2CrNP3R94AMUTAiMR0TDzmsDPBrUDsKJBla6m5P+v+sXIHgPxaX8tjaKJHdV5BlVWmBp/
	 6mBu/LzSBf79DkIkM7Fzanb6sSnmzIxrvYm0oWhKt3QFXnjfHW4xEH82SxgL7wcBonO7w
	 0q87aH9vc+O3q0vTiBfGh7iOf86d5MDwTAIWLwUxRnz2f76jUzK53mtWKIwO/2WSrIGHM
	 toA3U87X2QsPRuvc7UJgH5A6KXlA/x89hwauLXDffFgct36cbR090Qg/Rzx+ffXLZeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795618043;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pzOyiqmk8vOVYTUz/e5PR1CsjXHgNafQ7mmBH3pCevI=;
	b=ApXb0ui09nmbe976ax9F8OkbbHdDZTzSaJEPCUZrnfR/O1EwQpoGyj2CqS+cPbJNUqd0
	 iyoVdnB8kt2jE6OQdxD8d0h7uTD5lzbvxykbm97SlGF+dKpxu4cFFRwAtfHL+1TI2rTUO
	 Pk/UvuqLFDfZpc1psLNd4qbDpw4WL+Ps5rFu9XD4p7S2uEDlrE5yrVoAZtFYKCFwflecV
	 5tGoHSHLZs53t7BHZHJ43/HuyEfIse39G7cYHvufxBZQ32OSGozDMpwVmhcYUo7sMZOlu
	 0wEG/+6JCuNyiwQyq++V+7IhSGr0rtGW9K2OnE7YYALluVJRTq4E9ncXcmcoObH50mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7keC8Dv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC494606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=g7keC8Dv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D0E1F000C6;
	Wed, 25 Nov 2026 14:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795618043;
	bh=pzOyiqmk8vOVYTUz/e5PR1CsjXHgNafQ7mmBH3pCevI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=g7keC8Dv5mQ+rtS0EkpuaEf+3Vy2yp29Sst7Imo2vSayC/RSUhj1C9hRWX+NdsSgH
	 4SHabpmI8lkuyjpNa9T7KXN/dyICvg9fUCHbLHCXZ1cC/DmLTvUtsFGjz0LbOlReSF
	 apHV8Y+1v6sgUCBBdMGqfffe6b30Qo4vbApB6rXliIWH/uAe7SQ7l88nPVdzO7ZgL+
	 2LwygaBEJ7lnlzZhbCKfb4fXGsTsM/s5qOWvssY4GZwrBoKyVFDCHyfVqXVwuOSxN5
	 7QgfKsTtKp4Qfl6ZcXYNWTeX28Dqd5Cr8BfPulAv3W4p9Yu01ki+b1CrmxLppCegFL
	 H4Qty4c+EqAeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] xprtrdma: Decouple frwr_wp_create from frwr_map
Date: Wed, 25 Nov 2026 09:47:19 -0500
Message-ID: <20261125144713.4170491-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112556-maker-tabloid-5d68@gregkh>
References: <2026112556-maker-tabloid-5d68@gregkh>
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

