Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795773716;
	b=D+fXsnc2XLRwBc2GZ/t5s1YiSG7jUsGbjaIo8PTl+I/gQLyfhL04KdmS4WvUKg6sPbsJ
	 iHOZcNjwOW38a4VjRdsvAytn+JhYOJDK8cHt7MAiSMaFxkRfeguIAAsQ0dw4pXxu1MZAe
	 3E0siEsvevndPZcUg+pyI0CRhCHTnyoT+oV8z/ITRN5srIx7b7/ppkLylpqACiCHiaOu2
	 VUJDCLOSAadSsws9DtE+EAANYhdLJ6PaVLaLfKEieJ/Y7h6vS2Lb2QduNLIB/ue9jc0eC
	 yTfHPkkqR+8QNlbsfdiSnkxe+n92HSzd2QdfDLH42c4SffAhmhq2NG+gnCtnjmNjulg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795773716;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=2hox/6FsL37XfcxXgIzevvPPYWQ3idO8skHBlGN5CmI=;
	b=y2RVsGVkGtyhaxYaFTFkBr5hnmwaGiVhrDa3uoAaS1ccFkuBLJEvK+13+atAjMFGuwQa
	 3XfTS1Ktb7YSDjplpXd9qPB5Qj1tATUsgjNAjuIk9mxR8AO6RiZRzr97i5c7/SY6c05Ax
	 dGOGKq9wIP1kcZ1jLFVQkRYXZQRTZ8VT0JWM6NJkCDkqUos4MEuWbaaFPRk4HAFuWqPCz
	 aFkb1CMfltcqXJ0BzZM5ixnopKZ4m3SWvotbEqQkoL7gfTQe0PeXNJ52Xr3SoZyVfYE2k
	 YGL+6aNlfNxh8tNre6aig45AHTj6jOMAT8vKckb4XIkdNHu85D2Kcol0HTqMj4+orsw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=j0ZpbYHA;
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56181606A6A1
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 10:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 56181606A6A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=j0ZpbYHA
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Fri, 27 Nov 2026 11:01:50 +0100 (CET)
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
Subject: [PATCH net v9 4/6] veth: use the page_pool mem type when running XDP on an skb
Date: Fri, 27 Nov 2026 11:01:30 +0100
Message-ID: <20261127100132.1977890-5-sst@poczta.fm>
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
	t=1795773713; bh=2hox/6FsL37XfcxXgIzevvPPYWQ3idO8skHBlGN5CmI=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=j0ZpbYHAORDkdKzW7VdO+oT4hyh247Crv7r2SfNHFlWX5VQbPabbnmCHBjLp6LtEs
	 H4dP19ViTPUgTrh1wDjiX3Tz+5RZGUOs8/g/yGlQ2pZfNm9EEgktrcNe4J0459hoZV
	 rnFG2Pj8pn/5UAkYt0dIaSKMKUMu46w62bkjyDU4=

Since commit 0ebab78cbcbf ("net: veth: add page_pool for page
recycling") veth_convert_skb_to_xdp_buff() copies the skb into pages
from rq->page_pool when the program cannot run on the skb as it is, for
example when the skb is non-linear or has too little headroom. The
program still runs with rq->xdp_rxq, whose mem type is
MEM_TYPE_PAGE_SHARED, so when it shrinks a frag away,
bpf_xdp_shrink_data() frees the page_pool page with page_frag_free():

  BUG: Bad page state in process ping  pfn:6aa02
  page dumped because: page_pool leak

Run the program with the rxq info on the stack of veth_xdp_rcv() and
set its mem type to MEM_TYPE_PAGE_POOL. The program can free only frags
and they always come from skb_pp_cow_data(). On XDP_TX and
XDP_REDIRECT, veth_xdp_get() takes plain page references and the skb is
consumed, so the buff holds plain page references from then on: set the
mem type to MEM_TYPE_PAGE_SHARED there, which the frame keeps, as it
does today. rq->xdp_rxq is not changed any more, so rq->xdp_mem, which
restored it, can go.

Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
Suggested-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/all/DN3QVHST3PUQ.3NINFUW0FL9IW@gmail.com/
Cc: <stable@vger.kernel.org>
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/net/veth.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index cce253b58c2b..8bb015c13376 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -63,7 +63,6 @@ struct veth_rq {
 	struct napi_struct __rcu *napi; /* points to xdp_napi when the latter is initialized */
 	struct net_device	*dev;
 	struct bpf_prog __rcu	*xdp_prog;
-	struct xdp_mem_info	xdp_mem;
 	struct veth_rq_stats	stats;
 	bool			rx_notify_masked;
 	struct ptr_ring		xdp_ring;
@@ -746,6 +745,9 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 	int i;
 
+	/* the buff holds plain page references from here on */
+	xdp->rxq->mem.type = MEM_TYPE_PAGE_SHARED;
+
 	get_page(virt_to_page(xdp->data));
 	if (likely(!xdp_buff_has_frags(xdp)))
 		return;
@@ -755,6 +757,7 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 }
 
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
+					struct xdp_rxq_info *rxq,
 					struct xdp_buff *xdp,
 					struct sk_buff **pskb)
 {
@@ -773,7 +776,9 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 	/* SKB "head" area always have tailroom for skb_shared_info */
 	frame_sz = skb_end_pointer(skb) - skb->head;
 	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
+	/* the prog can free only frags and they came from skb_pp_cow_data() */
+	rxq->mem.type = MEM_TYPE_PAGE_POOL;
+	xdp_init_buff(xdp, frame_sz, rxq);
 	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
 			 skb_headlen(skb), true);
 
@@ -794,6 +799,7 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 }
 
 static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
+					struct xdp_rxq_info *rxq,
 					struct sk_buff *skb,
 					struct veth_xdp_tx_bq *bq,
 					struct veth_stats *stats)
@@ -815,7 +821,7 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	}
 
 	__skb_push(skb, skb->data - skb_mac_header(skb));
-	if (veth_convert_skb_to_xdp_buff(rq, xdp, &skb))
+	if (veth_convert_skb_to_xdp_buff(rq, rxq, xdp, &skb))
 		goto drop;
 	vxbuf.skb = skb;
 
@@ -830,7 +836,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_TX:
 		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
 		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 			trace_xdp_exception(rq->dev, xdp_prog, act);
 			stats->rx_drops++;
@@ -842,7 +847,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_REDIRECT:
 		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
 		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 			stats->rx_drops++;
 			goto err_xdp;
@@ -948,7 +952,7 @@ static int veth_xdp_rcv(struct veth_rq *rq, int budget,
 			struct sk_buff *skb = ptr;
 
 			stats->xdp_bytes += skb->len;
-			skb = veth_xdp_rcv_skb(rq, skb, bq, stats);
+			skb = veth_xdp_rcv_skb(rq, &rxq, skb, bq, stats);
 			if (skb) {
 				if (skb_shared(skb) || skb_unclone(skb, GFP_ATOMIC))
 					netif_receive_skb(skb);
@@ -1154,9 +1158,6 @@ static int veth_enable_xdp_range(struct net_device *dev, int start, int end,
 						 NULL);
 		if (err < 0)
 			goto err_reg_mem;
-
-		/* Save original mem info as it can be overwritten */
-		rq->xdp_mem = rq->xdp_rxq.mem;
 	}
 	return 0;
 
@@ -1185,7 +1186,6 @@ static void veth_disable_xdp_range(struct net_device *dev, int start, int end,
 	for (i = start; i < end; i++) {
 		struct veth_rq *rq = &priv->rq[i];
 
-		rq->xdp_rxq.mem = rq->xdp_mem;
 		xdp_rxq_info_unreg(&rq->xdp_rxq);
 
 		if (delete_napi)
-- 
2.56.0

