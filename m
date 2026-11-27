Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773713;
	b=IrL32H7aHXtI1gmfbggLKL76tZjYOEvVhNIAZqkOFOxNtg3JGOYZJLpnjHjib7S2U5To
	 e7QYz1eDkoF6tX27K2E5Ui/ftcj1VRMPfIOHq/yNFJW34aDMN18DZyFwP0AatwHne6FSa
	 Aumjea9x3lBzaMaZmTlDWG9b0/ALzYEIkz6+3ymSyguXCdLzCFcKZ90w0nu2ObIGBP4bt
	 Rn7eDQgL7D3PuNSDvx6vFsHAj+XxV9y+xu6T2N4/jbRoepCoRAB51LzMOaRanK3QEncYT
	 bBn+zObxlbNoKM8MPSEiUMp6tWOCjmvptWz1Q/VjWnDYAoBOTCGfCOFTZz4tsfag6kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773713;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=Zr4yKurBbJelpOngPtC+67Rtv8zo+CQ9Rq0c+P0wYE8=;
	b=dr9ikw47bvaghMbWc92pYqZ17j20hL29xvC0Km7/IOImJf5+158+/xoTsqLKswoQzDw3
	 NAKPj30VD/S0WV5bzu2Yw/kAzj+vUqpmYG9MaexsEunGZTYtHahhIBMKXivxP8sQJMCr9
	 7jzNmE64Mfr2gI2iVR4FA/Ec78N1lLuK00NeOYTF4dWZwYtvBjT7q3ylPy1dTDYOEAAvs
	 dnP5bkKL7EqsrvnOW7bgMlV3QXJVOgspF/4I5q8x+N+h7dspIJ/EaNNDPgOliHALVv/6J
	 gWQQwlRLP0TuUr1ELdRsQ4v6FxSoh0vcQ/Eo8JRF+wTaT0aofxXYgrQeQT8BCMG6Ilw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=qwE3di27;
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEF8A606A337
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DEF8A606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=qwE3di27
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri, 27 Nov 2026 11:01:48 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	Dudu Lu <phx0fer@gmail.com>,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Octavian Purdila <tavip@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>,
	stable@vger.kernel.org
Subject: [PATCH net v9 3/6] veth: use the frame mem type when running XDP on an xdp_frame
Date: Fri, 27 Nov 2026 11:01:29 +0100
Message-ID: <20261127100132.1977890-4-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127100132.1977890-1-sst@poczta.fm>
References: <20261127100132.1977890-1-sst@poczta.fm>
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
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=poczta.fm; s=dk;
	t=1795773710; bh=Zr4yKurBbJelpOngPtC+67Rtv8zo+CQ9Rq0c+P0wYE8=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=qwE3di27p5b1zSI/KDwAibwb+r/tgHoOqM/ufJMl9oSdEcVXIQQ8J7rSvMvOIumPP
	 zXbmDrySu4BdGqoubQsSk7IqMi6quq0M3dV/Z7MNV9vrPI9lla12WV94PM0VNSjkho
	 FNw+BHEt5D9ZTm0lSWZz+mLpWLl4ZYbgdWP2GAYc=

veth_xdp_rcv_one() runs the program on an xdp_frame with rq->xdp_rxq,
whose mem type is MEM_TYPE_PAGE_SHARED, and copies the frame's mem type
into it only for XDP_TX and XDP_REDIRECT, after the program ran. That is
too late: the program itself can free frags, and bpf_xdp_shrink_data()
frees them according to xdp->rxq->mem.type. When the program shrinks a
frag of a page_pool frame away, bpf_xdp_shrink_data() frees the
page_pool page with page_frag_free(). The mem type stored for XDP_TX and
XDP_REDIRECT also stays in rq->xdp_rxq, so later packets on the queue,
skbs and frames, run with the mem type of that frame.

Do not store into rq->xdp_rxq. Run the program with an rxq info on the
stack of veth_xdp_rcv(), and set its mem type to the frame's one before
the program runs. The queue index is the one veth_enable_xdp_range()
registers rq->xdp_rxq with.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/all/DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com/
Cc: <stable@vger.kernel.org>
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/net/veth.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index faa837acea7b..cce253b58c2b 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -642,6 +642,7 @@ static int veth_xdp_tx(struct veth_rq *rq, struct xdp_buff *xdp,
 }
 
 static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
+					  struct xdp_rxq_info *rxq,
 					  struct xdp_frame *frame,
 					  struct veth_xdp_tx_bq *bq,
 					  struct veth_stats *stats)
@@ -657,7 +658,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 		u32 act;
 
 		xdp_convert_frame_to_buff(frame, xdp);
-		xdp->rxq = &rq->xdp_rxq;
+		rxq->mem.type = frame->mem_type;
+		xdp->rxq = rxq;
 		vxbuf.skb = NULL;
 
 		act = bpf_prog_run_xdp(xdp_prog, xdp);
@@ -669,7 +671,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 			break;
 		case XDP_TX:
 			orig_frame = *frame;
-			xdp->rxq->mem.type = frame->mem_type;
 			if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 				trace_xdp_exception(rq->dev, xdp_prog, act);
 				frame = &orig_frame;
@@ -681,7 +682,6 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 			goto xdp_xmit;
 		case XDP_REDIRECT:
 			orig_frame = *frame;
-			xdp->rxq->mem.type = frame->mem_type;
 			if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 				frame = &orig_frame;
 				stats->rx_drops++;
@@ -914,6 +914,11 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct veth_xdp_tx_bq *bq,
 			struct veth_stats *stats)
 {
+	struct veth_priv *priv = netdev_priv(rq->dev);
+	struct xdp_rxq_info rxq = {
+		.dev = rq->dev,
+		.queue_index = rq - priv->rq,
+	};
 	int i, done = 0, n_xdpf = 0;
 	void *xdpf[VETH_XDP_BATCH];
 
@@ -928,7 +933,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct xdp_frame *frame = veth_ptr_to_xdp(ptr);
 
 			stats->xdp_bytes += xdp_get_frame_len(frame);
-			frame = veth_xdp_rcv_one(rq, frame, bq, stats);
+			frame = veth_xdp_rcv_one(rq, &rxq, frame, bq, stats);
 			if (frame) {
 				/* XDP_PASS */
 				xdpf[n_xdpf++] = frame;
-- 
2.56.0

