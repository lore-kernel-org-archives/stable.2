Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795619116;
	b=oSkI95w5CXGvpGFfGqnRhxdeUHDxl7xqgj8wXEb693V/G2CV4VvXx5e2jOx/C15PN+FM
	 KoZ5RJ13eEXQ2PnEXmZOro+sDblcawl0UstEhjJyUVJiuOGB0eauXLpG2F/JpgxF7rSxZ
	 Q9e0+VBMsemc6y8nNjOdZCNLQv76UTHwHXzs+UBMpPKiMkLPr7BgpA2+Be4wIhlKkycil
	 WVbkwQkxsQ7GelJqOroBnSok7pV9qtv3CbYyWEcRLvm7dpcWpY5Wun1I4VwmEDWaatXYT
	 hMK3106k8nO8nVbIH8eHqoTB2s7gJ63dQpwvJLTezpQkiL6m3xmevMnI4e1XO3+ce8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795619116;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=pzOyiqmk8vOVYTUz/e5PR1CsjXHgNafQ7mmBH3pCevI=;
	b=YZWBVgkvh+23asUV2O2slfFchbi/M90nQAbzsOwfHovQ05zkCrF7LR6+p/9T6FSCdE98
	 Ve4X2AjLn0VMKStPXnz+r1nHQfUlTYZ1qz/V+qgr4xTLGp7KqUBpST0f1lztq0KROZmFq
	 QqTczY4sflfdfIbMs8tfJN48r2fbOojgeYJOiL3wubm/N31nQdhnxWDS79TROTFiCAg0s
	 iiKi5vV8GDrimFs+/ro12d83eOV2eX20RiYuROD0p3BFblN+VBFMymemfl8AFIJvAzs9u
	 jpiZAFWHNhXRQNWxDXcLWY1jXLCavWkp2X9WMhxcSETOV1Q3/GuFDqwFtsAlONhm/pw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT+I2VuJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B813606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 15:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KT+I2VuJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC7B1F000CA;
	Wed, 25 Nov 2026 15:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795619116;
	bh=pzOyiqmk8vOVYTUz/e5PR1CsjXHgNafQ7mmBH3pCevI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KT+I2VuJBloA3Pwy2IkRXxLIGOsV63bGx6KPqPT79cLEvl2s7VKTk78Ac1/WQTUnQ
	 Sjs71ATvTmdrAZdYNQDpCuJ9mUkRj4qht1xjq8fI7endiNETTFxYcErEf85fyAD7pm
	 APaVvAU22wGm3FMBn9zYryVgnhf/2IwKKL7viWlRTQFUBW7zED5boSSG/Sh72T6+QC
	 2OjN8k0zkbHbK9oB0AzG8l0mewwEdlBKoTnKH7pMf7RjE4m+M8RbYzT9e83XIEw6oz
	 GxYaVkJk27/Lcx2XFTByN3iDEFp/b9VrZRVN+/SewGM3J4D59PPodRk/EVmxTin7D4
	 D4K1vE2wWLd8Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Trond Myklebust <trond.myklebust@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/4] xprtrdma: Decouple frwr_wp_create from frwr_map
Date: Wed, 25 Nov 2026 10:05:10 -0500
Message-ID: <20261125150506.11963-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261125150506.11963-1-sashal@kernel.org>
References: <2026112557-renewal-pyramid-fc9e@gregkh>
 <20261125150506.11963-1-sashal@kernel.org>
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

