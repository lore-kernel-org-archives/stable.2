Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095064;
	b=elAfK3Wg/QOnsHsaWLG7HwxOv5q/H1U7cFvjK4KXu6H85V1oPmVirI/M2mkrCOC2j6tN
	 bxc/DZ/f/ZwCnCFWKgWUMq5hqjl/FIqM+IB6WXIkxDmI7P/Q+ZiCCaq64Cz886nsta6h9
	 pgL5zZntOryCWhmX+4fZzN+5YBjX7HkDMaaidIo7oY6h1dfKZbzWRSqdLntkl/LOVDUus
	 BvSytm0l50nocS3cESMGLsCOc0EXsFeV1Euv4k2RadwOfOwKn9II37vhMRG9yTUc3/4LX
	 HwFUJAJTVboN/LmTmq5zUBnY6QDcRFHeYZORZcVovos4VCC++vphnPnCz+8cOYoTj3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095064;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=uT4k0m5sisqIcjF5HDkF+KqUU66geM40OnB6NAlkKVA=;
	b=X75JTvqsYDKx5KdQ7ByVAuQwJyfkG0DvDon0cQ9PSElIh66r1O3phI6YWb2wEqoGnCme
	 4r8tKKZgk6ThClnmWI//rUo8DK/MUz5CrsBaTl6/7h5jqUVgy1UgfHTrPv17swIOLzUq4
	 aXjt/LlkheOjTYLBmS3OhIlIlstNHFd9GHv6XyDmUDwN2RQk/BHuYQ0NSarR0MvNiW58K
	 N/5ZR+zVHkqh1WCO1PKn9a72yD5bnfddVJ5QeVn0KvwwgHBW+bCuEQ+J+6pS2oLXU1brD
	 yauc89iLGtDVl7n6IjjAgBGR3rFb9ENI1j5NnzBePEWLkBEJDanR0+CodIE8CR9EssQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=v3enhKdL;
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 735EC606A334
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:31:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 735EC606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=v3enhKdL
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Thu, 19 Nov 2026 14:30:59 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Tianyi Gao <tianyi@cloudflare.com>,
	Octavian Purdila <tavip@google.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH v7 bpf 2/5] xdp: introduce xdp_convert_skb_to_buff()
Date: Thu, 19 Nov 2026 14:30:29 +0100
Message-ID: <20261119133032.2015656-3-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119133032.2015656-1-sst@poczta.fm>
References: <20261119133032.2015656-1-sst@poczta.fm>
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
	t=1795095061; bh=uT4k0m5sisqIcjF5HDkF+KqUU66geM40OnB6NAlkKVA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=v3enhKdL9AfJ9lnNxbWcvPtYdImDuck98tfHf+o9bVaz8qH8fjcu57R61SdYvUOKj
	 4ks4d7ob8kcwLplOs4xaZh2xNFsDkN96GkuNghkrSX+FkpOiAEG+rCksx+dxgMY/sH
	 nlu4njB/7lKbkUS2JVGY1lHUWxIFZqgsRgQvBbOM=

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Currently, generic XDP hook uses xdp_rxq_info from netstack Rx queues
which do not have its XDP memory model registered. There is a case when
XDP program calls bpf_xdp_adjust_tail() BPF helper, which in turn
releases underlying memory. This happens when it consumes enough amount
of bytes and when XDP buffer has fragments. For this action the memory
model knowledge passed to XDP program is crucial so that core can call
suitable function for freeing/recycling the page.

For netstack queues it defaults to MEM_TYPE_PAGE_SHARED (0) due to lack
of mem model registration. The problem we're fixing here is when kernel
copied the skb to new buffer backed by system's page_pool and XDP buffer
is built around it. Then when bpf_xdp_adjust_tail() calls
__xdp_return(), it acts incorrectly due to mem type not being set to
MEM_TYPE_PAGE_POOL and causes a page leak.

Pull out the existing code from bpf_prog_run_generic_xdp() that
init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
set there the mem type of the rxq info that the xdp_buff points to.
Make it agnostic to current skb->data position.

The mem type is only consulted when the program releases fragments; the
head can not be freed from under the skb. All current users pass skbs
with fragments through skb_pp_cow_data() first, and when the CoW fails
the skb is linearized, so fragments seen here are always page_pool
backed. Hence set MEM_TYPE_PAGE_POOL unconditionally and warn under
CONFIG_DEBUG_NET if a non-linear skb shows up without pp_recycle.

This problem was triggered by syzbot as well as by the AF_XDP test
suite.

Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Cc: <stable@vger.kernel.org> # 6.4.x
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Octavian Purdila <tavip@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com> # whole analysis, testing, initiating a fix
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com> # commit msg and proposed more robust fix
[sst: rebased onto bpf/master; set MEM_TYPE_PAGE_POOL unconditionally, add
 DEBUG_NET_WARN_ON_ONCE() and kdoc as agreed in v4/v5 review; dropped
 Tested-by/Reviewed-by as the code changed; reworded the description
 of the mem type and dropped the stale BPF CI remark (BPF CI)]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 include/net/xdp.h | 36 ++++++++++++++++++++++++++++++++++++
 net/core/dev.c    | 25 ++++---------------------
 2 files changed, 40 insertions(+), 21 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..28bd78dbef20 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -389,6 +389,42 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
+/**
+ * xdp_convert_skb_to_buff - build an xdp_buff on top of an skb
+ * @skb: skb to describe, packet data is taken from its MAC header onwards
+ * @xdp: xdp_buff to initialize
+ * @xdp_rxq: Rx queue info to attach to @xdp
+ *
+ * The memory type set on @xdp_rxq is only used to release fragments that
+ * the XDP program consumes; the head can not be freed from under the skb.
+ * A non-linear @skb is expected to have gone through skb_pp_cow_data(), so
+ * all of its fragments are page_pool backed.
+ */
+static inline
+void xdp_convert_skb_to_buff(struct sk_buff *skb, struct xdp_buff *xdp,
+			     struct xdp_rxq_info *xdp_rxq)
+{
+	u32 frame_sz, pkt_len;
+
+	/* SKB "head" area always have tailroom for skb_shared_info */
+	frame_sz = skb_end_pointer(skb) - skb->head;
+	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	pkt_len = skb_tail_pointer(skb) - skb_mac_header(skb);
+
+	xdp_init_buff(xdp, frame_sz, xdp_rxq);
+	xdp_prepare_buff(xdp, skb->head, skb->mac_header, pkt_len, true);
+
+	if (skb_is_nonlinear(skb)) {
+		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
+		xdp_buff_set_frags_flag(xdp);
+	} else {
+		xdp_buff_clear_frags_flag(xdp);
+	}
+
+	DEBUG_NET_WARN_ON_ONCE(skb_is_nonlinear(skb) && !skb->pp_recycle);
+	xdp->rxq->mem.type = MEM_TYPE_PAGE_POOL;
+}
+
 static inline
 void xdp_convert_frame_to_buff(const struct xdp_frame *frame,
 			       struct xdp_buff *xdp)
diff --git a/net/core/dev.c b/net/core/dev.c
index 3ac700d37e59..4eeeb0182a6a 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5667,35 +5667,18 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
 u32 bpf_prog_run_generic_xdp(struct sk_buff *skb, struct xdp_buff *xdp,
 			     const struct bpf_prog *xdp_prog)
 {
-	void *orig_data, *orig_data_end, *hard_start;
+	void *orig_data, *orig_data_end;
 	struct netdev_rx_queue *rxqueue;
 	bool orig_bcast, orig_host;
-	u32 mac_len, frame_sz;
+	u32 metalen, act, mac_len;
 	__be16 orig_eth_type;
 	struct ethhdr *eth;
-	u32 metalen, act;
 	int off;
 
-	/* The XDP program wants to see the packet starting at the MAC
-	 * header.
-	 */
+	rxqueue = netif_get_rxqueue(skb);
 	mac_len = skb->data - skb_mac_header(skb);
-	hard_start = skb->data - skb_headroom(skb);
-
-	/* SKB "head" area always have tailroom for skb_shared_info */
-	frame_sz = (void *)skb_end_pointer(skb) - hard_start;
-	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	rxqueue = netif_get_rxqueue(skb);
-	xdp_init_buff(xdp, frame_sz, &rxqueue->xdp_rxq);
-	xdp_prepare_buff(xdp, hard_start, skb_headroom(skb) - mac_len,
-			 skb_headlen(skb) + mac_len, true);
-	if (skb_is_nonlinear(skb)) {
-		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
-		xdp_buff_set_frags_flag(xdp);
-	} else {
-		xdp_buff_clear_frags_flag(xdp);
-	}
+	xdp_convert_skb_to_buff(skb, xdp, &rxqueue->xdp_rxq);
 
 	orig_data_end = xdp->data_end;
 	orig_data = xdp->data;
-- 
2.56.0

