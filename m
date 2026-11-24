Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516845;
	b=B6nL+ltt/P8Yl1vk9SvRJDwbCby5GvmKgXkT6b7e7AZhyOhReKUhEezpKEkuJrKpqwG8
	 6AGBvBC1jnoMrJbA3aLj9yrGJMiWKToWTC/P4SCnSN4ko4Tll44OgEk6LQzhFgr3sOEBh
	 GGKSeKZbqCoF6YOpf5bn8ClxIzV/t23hvgddxOIQIeRK1YLxemPs+sLe5s/tOjv7ibpLv
	 vbUnhwBJlK+yBcKLJo0W2ihRxWwT3iOgNgCAEEP7Pl8Qugf5D6mf7loCzro30L8Izsgur
	 4LQ/DfKivRODP79PlWvcwi62aPtaz8qqp9secVLkHRE/p28uOMQFOOhIfJrv9NXfETg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516845;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=TTYBFpA6ANP+rywyUM8DAtQ6+CXyfuYHwjJjMX1FnNg=;
	b=RGO+62DoL7oSVEACWoklQM+BUkx2DaCjb4fxKFDIydCsJox8AAvPL8CzqB3PkxMN/a0q
	 WCyY2HIjNAcA/PQ5obV+pT4LBKaig9QIQso2hJjJcJEzzBuE4dFVcGl125zXBEvtqUaYM
	 QXAVwMOzjItGFMjX6qh5jCviYNTpFOH1yIUCKHzYy8IZwU1ZhgtDI3RmqJiJo2rhQax56
	 uFh+WiiXah1x22rQPuAOQ1xoAIMBCeBtiRcN3551qrNWDDfykOHVw+YFR9uk68cPJ90BN
	 ql8Ela3Xa78T/2PG63A5S9zbu1opirxk4r5jElJOBl6ynUnIg3+Q76C98ejbzr/fRFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=vExjUJ8w;
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCF8606A337
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 10:40:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5CCF8606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=vExjUJ8w
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Tue, 24 Nov 2026 11:40:40 +0100 (CET)
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
	stable@vger.kernel.org,
	Slawomir Stepien <sst@poczta.fm>
Subject: [PATCH v8 bpf 5/7] veth: update mem type in xdp_buff
Date: Tue, 24 Nov 2026 11:40:14 +0100
Message-ID: <20261124104016.532341-6-sst@poczta.fm>
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
	t=1795516842; bh=TTYBFpA6ANP+rywyUM8DAtQ6+CXyfuYHwjJjMX1FnNg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=vExjUJ8wjVGR91D2H5PKU2AE0+lwG7DttRak+L2k+ST6bIsP2ni9UPmWgpFjoO1vH
	 Q2G2Z0OnamKzFvadpamC+m8GpgNyBDpLvPfxkaqX9/LK3eSOvOhLv3E4yacSMMfYiS
	 ThtBslTYvVZBEg1QAwH7Ve+pFxY6EPK6gw/nGBq4=

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

When skb's headroom is not sufficient for XDP purposes,
skb_pp_cow_data() returns new skb with requested headroom space. This
skb was provided by page_pool.

For CONFIG_DEBUG_VM=y and XDP program that uses bpf_xdp_adjust_tail()
against a skb with frags, and mentioned helper consumed enough amount of
bytes that in turn released the page, following splat was observed:

[   32.204881] BUG: Bad page state in process test_progs  pfn:11c98b
[   32.207167] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x11c98b
[   32.210084] flags: 0x1fffe0000000000(node=0|zone=1|lastcpupid=0x7fff)
[   32.212493] raw: 01fffe0000000000 dead000000000040 ff11000123c9b000 0000000000000000
[   32.218056] raw: 0000000000000000 0000000000000001 00000000ffffffff 0000000000000000
[   32.220900] page dumped because: page_pool leak
[   32.222636] Modules linked in: bpf_testmod(O) bpf_preload
[   32.224632] CPU: 6 UID: 0 PID: 3612 Comm: test_progs Tainted: G O        6.17.0-rc5-gfec474d29325 #6969 PREEMPT
[   32.224638] Tainted: [O]=OOT_MODULE
[   32.224639] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.14.0-0-g155821a1990b-prebuilt.qemu.org 04/01/2014
[   32.224641] Call Trace:
[   32.224644]  <IRQ>
[   32.224646]  dump_stack_lvl+0x4b/0x70
[   32.224653]  bad_page.cold+0xbd/0xe0
[   32.224657]  __free_frozen_pages+0x838/0x10b0
[   32.224660]  ? skb_pp_cow_data+0x782/0xc30
[   32.224665]  bpf_xdp_shrink_data+0x221/0x530
[   32.224668]  ? skb_pp_cow_data+0x6d1/0xc30
[   32.224671]  bpf_xdp_adjust_tail+0x598/0x810
[   32.224673]  ? xsk_destruct_skb+0x321/0x800
[   32.224678]  bpf_prog_004ac6bb21de57a7_xsk_xdp_adjust_tail+0x52/0xd6
[   32.224681]  veth_xdp_rcv_skb+0x45d/0x15a0
[   32.224684]  ? get_stack_info_noinstr+0x16/0xe0
[   32.224688]  ? veth_set_channels+0x920/0x920
[   32.224691]  ? get_stack_info+0x2f/0x80
[   32.224693]  ? unwind_next_frame+0x3af/0x1df0
[   32.224697]  veth_xdp_rcv.constprop.0+0x38a/0xbe0
[   32.224700]  ? common_startup_64+0x13e/0x148
[   32.224703]  ? veth_xdp_rcv_one+0xcd0/0xcd0
[   32.224706]  ? stack_trace_save+0x84/0xa0
[   32.224709]  ? stack_depot_save_flags+0x28/0x820
[   32.224713]  ? __resched_curr.constprop.0+0x332/0x3b0
[   32.224716]  ? timerqueue_add+0x217/0x320
[   32.224719]  veth_poll+0x115/0x5e0
[   32.224722]  ? veth_xdp_rcv.constprop.0+0xbe0/0xbe0
[   32.224726]  ? update_load_avg+0x1cb/0x12d0
[   32.224730]  ? update_cfs_group+0x121/0x2c0
[   32.224733]  __napi_poll+0xa0/0x420
[   32.224736]  net_rx_action+0x901/0xe90
[   32.224740]  ? run_backlog_napi+0x50/0x50
[   32.224743]  ? clockevents_program_event+0x1cc/0x280
[   32.224746]  ? hrtimer_interrupt+0x31e/0x7c0
[   32.224749]  handle_softirqs+0x151/0x430
[   32.224752]  do_softirq+0x3f/0x60
[   32.224755]  </IRQ>

It's because xdp_rxq with mem model set to MEM_TYPE_PAGE_SHARED was used
when initializing xdp_buff.

Fix this by using new helper xdp_convert_skb_to_buff(). Unlike generic
XDP, veth turns the xdp_buff into an xdp_frame on XDP_{TX,REDIRECT}, so
the head is later released through the mem type as well and the
helper's frags-only reasoning is not enough here. Advertise
MEM_TYPE_PAGE_POOL only when the whole buffer was just copied into
rq->page_pool by skb_pp_cow_data(); otherwise keep the queue's original
MEM_TYPE_PAGE_SHARED model. An skb that skips the CoW has no frags, so
nothing can be released through the mem type while the program runs.

XDP_{TX,REDIRECT} no longer reset the mem type to the queue's original
model before the buff is converted to a frame, as the frame has to
carry the type chosen above. Nothing needs to be restored afterwards
either: the previous patch makes the frame path set its own mem type
and every skb sets it here. Add a page_pool variant of veth_xdp_get()
so that we avoid refcount underflow when draining page frag.

Frames redirected out of veth can now be MEM_TYPE_PAGE_POOL. A devmap
egress program only releases their frags correctly since commit
b3ca872947ef ("bpf: Use the frame mem type in devmap egress XDP"), so
that commit has to come first when backporting, as do the previous
three patches of this series: xdp_convert_skb_to_buff() is used here,
dropping the restores relies on the frame path setting its own mem
type, and test_run needs its own rxq info once the helper sets it.
Before v6.9, generic XDP has no frags and xdp_convert_skb_to_buff()
has to be adapted to the older bpf_prog_run_generic_xdp().

Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
Cc: <stable@vger.kernel.org> # 6.4.x: b3ca872947ef: bpf: Use the frame mem type in devmap egress XDP
Cc: <stable@vger.kernel.org> # 6.4.x
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
[sst: rebased onto bpf/master; claim MEM_TYPE_PAGE_POOL only after CoW into
 rq->page_pool; take page_pool refs on compound heads via netmem helpers;
 drop the rq mem model restores as every path sets its own mem type now;
 dropped Reviewed-by as the code changed; list the backport
 prerequisites (BPF CI)]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/net/veth.c | 53 +++++++++++++++++++++++++++++++---------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 80d3c116e757..1a14ce77e4a7 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -741,7 +741,7 @@ static void veth_xdp_rcv_bulk_skb(struct veth_rq *rq, void **frames,
 	}
 }
 
-static void veth_xdp_get(struct xdp_buff *xdp)
+static void veth_xdp_get_shared(struct xdp_buff *xdp)
 {
 	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
 	int i;
@@ -754,12 +754,36 @@ static void veth_xdp_get(struct xdp_buff *xdp)
 		netmem_inc_ref(skb_frag_netmem(&sinfo->frags[i]));
 }
 
+static void veth_xdp_get_pp(struct xdp_buff *xdp)
+{
+	struct skb_shared_info *sinfo = xdp_get_shared_info_from_buff(xdp);
+	int i;
+
+	page_pool_ref_netmem(netmem_compound_head(virt_to_netmem(xdp->data)));
+	if (likely(!xdp_buff_has_frags(xdp)))
+		return;
+
+	for (i = 0; i < sinfo->nr_frags; i++) {
+		netmem_ref netmem = skb_frag_netmem(&sinfo->frags[i]);
+
+		page_pool_ref_netmem(netmem_compound_head(netmem));
+	}
+}
+
+static void veth_xdp_get(struct xdp_buff *xdp)
+{
+	if (xdp->rxq->mem.type == MEM_TYPE_PAGE_POOL)
+		veth_xdp_get_pp(xdp);
+	else
+		veth_xdp_get_shared(xdp);
+}
+
 static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 					struct xdp_buff *xdp,
 					struct sk_buff **pskb)
 {
 	struct sk_buff *skb = *pskb;
-	u32 frame_sz;
+	bool pp_cow = false;
 
 	if (skb_shared(skb) || skb_head_is_locked(skb) ||
 	    skb_is_nonlinear(skb) ||
@@ -768,21 +792,18 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
 			goto drop;
 
 		skb = *pskb;
+		pp_cow = true;
 	}
 
-	/* SKB "head" area always have tailroom for skb_shared_info */
-	frame_sz = skb_end_pointer(skb) - skb->head;
-	frame_sz += SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
-	xdp_init_buff(xdp, frame_sz, &rq->xdp_rxq);
-	xdp_prepare_buff(xdp, skb->head, skb_headroom(skb),
-			 skb_headlen(skb), true);
-
-	if (skb_shinfo(skb)->nr_frags) {
-		skb_shinfo(skb)->xdp_frags_size = skb->data_len;
-		xdp_buff_set_frags_flag(xdp);
-	} else {
-		xdp_buff_clear_frags_flag(xdp);
-	}
+	xdp_convert_skb_to_buff(skb, xdp, &rq->xdp_rxq);
+	/*
+	 * Unlike generic XDP, XDP_{TX,REDIRECT} turn the buff into an
+	 * xdp_frame, which later releases the head via mem.type as well.
+	 * Only claim page_pool memory when the whole buffer was copied into
+	 * rq->page_pool above; an skb that skipped the CoW is linear.
+	 */
+	if (!pp_cow)
+		rq->xdp_rxq.mem = rq->xdp_mem;
 	*pskb = skb;
 
 	return 0;
@@ -830,7 +851,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_TX:
 		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
 		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 			trace_xdp_exception(rq->dev, xdp_prog, act);
 			stats->rx_drops++;
@@ -842,7 +862,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_REDIRECT:
 		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
 		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 			stats->rx_drops++;
 			goto err_xdp;
-- 
2.56.0

