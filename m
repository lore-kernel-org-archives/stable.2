Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516838;
	b=0pJKZjD9aGvUTf3SGcNjpxFa5qQMjGabKdD8dA+zvs2CNQtAdRxKmh3nVJn8PdL1Qxz+
	 0yxFsBu+wPw5knuHNOMq5XyQFk4iKxm9u46VUL9fDr1yBL7/xMlnXh/dHbmjuXJ0XCBZO
	 jtwFvFXMDIQXotDqNLgb7WCLettg5wEYHIGuFR5rqerhK6QZ6C/++0M0GGaiS9pjRtUyl
	 ja95uQRZQyCmtHkqsqPABLghMopfAg8X9+U2tsMeFWs8scInr+cvBdi+cCjm08C/Kochp
	 KScI0Z/+6TNsKxgNUA20L8IQ0U0Miwiw0D9mSWNGErJLziNY1DHsdybR2N+65woIutQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516838;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=xSf99vospGhLMWRMwlZOx2eiye2e9QokuTDJOVrYs20=;
	b=OHEV+MiwazwJzti92pZ48J4pEt2va/b0vO5n5vgP6sdAMJi99CaHY17WnGtU9xlKm7Uf
	 DphCGsdDqhz8H+/Y0yRFoyd5P6PxuOZykT9umbsctJvQRW4yp+qiW45W7zo7rTLveE4CU
	 aKHONJSdHkeyPwa3/3nKwNijM1MwwQQ7HeuRhapEPm+R0SXJS/QX7rzIGuCU+RO/0drsU
	 609dQOG4lStfDq2zsl/rTTpdM3MkZBZLVhVDGECs2spzi4yvWlV/gGZkd1ByIUh/+ECc9
	 pMKCWxIiJ00y8D5zhSM0g6U+o4G7vJZCIW+WNn0rhRBeaYoY6lBO3hES1U5ydxerd9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=f1UXofjF;
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81E606A690
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:40:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C81E606A690
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=f1UXofjF
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Tue, 24 Nov 2026 11:40:33 +0100 (CET)
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
	Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
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
	Emil Tsalapatis <emil@etsalapatis.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com,
	stable@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH v8 bpf 3/7] xdp: introduce xdp_convert_skb_to_buff()
Date: Tue, 24 Nov 2026 11:40:12 +0100
Message-ID: <20261124104016.532341-4-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261124104016.532341-1-sst@poczta.fm>
References: <20261124104016.532341-1-sst@poczta.fm>
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
	t=1795516835; bh=xSf99vospGhLMWRMwlZOx2eiye2e9QokuTDJOVrYs20=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=f1UXofjFrnobtT6wNpXIKXGln0jxL4dQJCqqbeXzumm/FWmMcfrNb/HH7IqD2M7Xk
	 M/G/rhRTTd7WjigSS12FZDZ+qYpfJ/IsVtwQUVAXCIYy3/4MV4enFIZc6pzeQSkCsT
	 8/coZ5QohyoFrCsKrisTlmUhoqxBCjEQSBYluK9g=

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
MEM_TYPE_PAGE_POOL: page_frag_free() drops the page reference that
page_pool holds, while page_pool and other fragments of the same page
may still use it. With page checks enabled (e.g. CONFIG_DEBUG_VM), the
page allocator reports this as a "page_pool leak" and does not free the
page. Without them, the page is freed while still in use, which can lead
to a use-after-free.

Pull out the existing code from bpf_prog_run_generic_xdp() that
init/prepares xdp_buff onto new helper xdp_convert_skb_to_buff() and
set there the mem type of the rxq info that the xdp_buff points to.
Make it agnostic to current skb->data position.

For generic XDP, the mem type is only consulted when the program
releases fragments; the head can not be freed from under the skb. All
current users pass skbs with fragments through skb_pp_cow_data() first,
and when the CoW fails the skb is linearized, so fragments seen here are
always page_pool backed. Hence set MEM_TYPE_PAGE_POOL unconditionally
and warn under CONFIG_DEBUG_NET if a non-linear skb shows up without
pp_recycle.

Callers that turn the xdp_buff into an xdp_frame, like veth on XDP_TX
and XDP_REDIRECT later in this series, release the head through the
mem type too, so they have to set the type that matches the head
after calling this helper.

This problem was triggered by syzbot as well as by the AF_XDP test
suite.

The problem exists since v6.9, see Fixes:. The stable range starts at
6.4.x, because the veth fix later in this series, which goes back to
v6.4, uses this helper. Before v6.9 generic XDP linearizes all skbs, so
there the mem type set here is never consulted.

Reported-by: syzbot+ff145014d6b0ce64a173@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/6756c37b.050a0220.a30f1.019a.GAE@google.com/
Fixes: e6d5dbdd20aa ("xdp: add multi-buff support for xdp running in generic mode")
Cc: <stable@vger.kernel.org> # 6.4.x
Suggested-by: Jakub Kicinski <kuba@kernel.org>
Co-developed-by: Octavian Purdila <tavip@google.com>
Signed-off-by: Octavian Purdila <tavip@google.com>
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
[sst: rebased onto bpf/master; set MEM_TYPE_PAGE_POOL unconditionally, add
 DEBUG_NET_WARN_ON_ONCE() and kdoc as agreed in v4/v5 review; dropped
 Tested-by/Reviewed-by as the code changed; reworded the description
 of the mem type and dropped the stale BPF CI remark (BPF CI); reworded
 the kdoc, described the use-after-free, the stable range and the
 xdp_frame callers (BPF CI); dropped the "# ..." notes after the
 Signed-off-by lines (checkpatch)]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 include/net/xdp.h | 38 ++++++++++++++++++++++++++++++++++++++
 net/core/dev.c    | 25 ++++---------------------
 2 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/include/net/xdp.h b/include/net/xdp.h
index 07231adfb5f8..96ff5067fdaa 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -389,6 +389,44 @@ struct sk_buff *xdp_build_skb_from_frame(struct xdp_frame *xdpf,
 					 struct net_device *dev);
 struct xdp_frame *xdpf_clone(struct xdp_frame *xdpf);
 
+/**
+ * xdp_convert_skb_to_buff - build an xdp_buff on top of an skb
+ * @skb: skb to describe, packet data is taken from its MAC header onwards
+ * @xdp: xdp_buff to initialize
+ * @xdp_rxq: Rx queue info to attach to @xdp
+ *
+ * Sets the memory type of @xdp_rxq to MEM_TYPE_PAGE_POOL; the change stays
+ * on @xdp_rxq after the call. A non-linear @skb is expected to have gone
+ * through skb_pp_cow_data(), so all of its fragments are page_pool backed.
+ * The head is page_pool backed only if the whole skb was copied that way:
+ * a caller that may release the head through the memory type, e.g. by
+ * converting @xdp to an xdp_frame, has to set the type that matches it.
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
index 6140fd9d11cd..46f5fdd7f855 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5681,35 +5681,18 @@ static struct netdev_rx_queue *netif_get_rxqueue(struct sk_buff *skb)
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

