Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.63
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794451;
	b=3kxvFPjcpXTQ5+PmkrM/Fi108uLexQFuTtPmUef2PeUsUA44h/YUsR9in7oOJjuHbYD3
	 zg5FaKbrxv/RrZo5FkeBBoVPrQam+csYbwf3jskVnR9QUxfVt2rSiWatYo+c3fB7yGRpc
	 8UNwkutVmd+2m+TE56VNKkL8SKWRTcm4OjUzgqOMrjBMTDuWvIqKpg4VOUA+MQUIxQXmx
	 hYd3hZY+stF99h/vzEGc4sIyFLh+fa2N+UuDwVTul8vvbHsObYRn3OO0MIGqdS/3OymD2
	 faCneG1kKJ2WmRBVhSzi7lJliCVbbkptIahcHUO+/tM8TrfcCcjEQlvRfJDTPw+xkng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794451;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=I0SvXnnBFzW/xvbEzHzlb1uvVM4j+mzr2uJqd0jseEE=;
	b=xSBr2gQpQIMqoA6YVPSic1kpIF1XxCLI47OQqnyp8B6s8sLCAU8bqRWcnfP9t+yh2o18
	 GwxUcJGiz/SdkV9Uew03TDhDlCXmdi5vK1GA2vZ7P5JBsWSZh0zO/AP1kG4HzBr6K6cBX
	 nI3+9fnBfgtTZgfbGPJm+1ddHh+qkwiN1rRAFNUoagVYBXOGiXfj3Bf5JBULjWNLl3h8d
	 WPPVx5u01Ebob/Y02GAbbX2U+FH77o0Xfpz+C7Le94xcyLheXCo1eRQAf7iSDI/rKQMmi
	 3hXN20azQsr9vkOoaJKH1WOcFagDSWwlc6RLw+1FtCbQXOM2XdqRaL2wbRZITe2kEZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=HxwDk1MU;
	arc=none smtp.remote-ip=217.74.67.63
Received: from smtpo63.interia.pl (smtpo63.interia.pl [217.74.67.63])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B9F606A328
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 73B9F606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=HxwDk1MU
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Wed,  4 Nov 2026 13:14:05 +0100 (CET)
From: Slawomir Stepien <sst@poczta.fm>
To: ast@kernel.org,
	daniel@iogearbox.net,
	davem@davemloft.net,
	kuba@kernel.org,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	magnus.karlsson@intel.com,
	aleksander.lobakin@intel.com,
	ilias.apalodimas@linaro.org,
	toke@redhat.com,
	lorenzo@kernel.org,
	ihor.solodrai@linux.dev,
	tavip@google.com,
	maciej.fijalkowski@intel.com,
	sst@poczta.fm,
	stable@vger.kernel.org
Subject: [PATCH v6 bpf 3/3] veth: update mem type in xdp_buff
Date: Wed,  4 Nov 2026 13:13:16 +0100
Message-ID: <20261104121316.1155680-4-sst@poczta.fm>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104121316.1155680-1-sst@poczta.fm>
References: <20261104121316.1155680-1-sst@poczta.fm>
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
	t=1793794447; bh=I0SvXnnBFzW/xvbEzHzlb1uvVM4j+mzr2uJqd0jseEE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=HxwDk1MUYVcIj9/PcQINoL7JSFd+5oA97Tacp2i2pnaOfhNuRfGscuBf6LUofiXfO
	 RLW3yzX5CFJh9kKkqakTw2vAIZAsoPd9ij0GGWYPGzI834UEadNSMvKMiIFAc9QZI3
	 JQXHgSUojrTInfyi/2tLw6ULa3zk0BLCrkGz1hUI=

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
that commit has to come first when backporting.

Fixes: 0ebab78cbcbf ("net: veth: add page_pool for page recycling")
Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/CAADnVQ+bBofJDfieyOYzSmSujSfJwDTQhiz3aJw7hE+4E2_iPA@mail.gmail.com/
Cc: <stable@vger.kernel.org> # 6.4.x: b3ca872947ef: bpf: Use the frame mem type in devmap egress XDP
Cc: <stable@vger.kernel.org> # 6.4.x
Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
[sst: rebased onto bpf/master; claim MEM_TYPE_PAGE_POOL only after CoW into
 rq->page_pool; take page_pool refs on compound heads via netmem helpers;
 drop the rq mem model restores as every path sets its own mem type now;
 dropped Reviewed-by as the code changed]
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/net/veth.c | 52 +++++++++++++++++++++++++++++++---------------
 1 file changed, 35 insertions(+), 17 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index afae2c6533b9..e159f0e00ddb 100644
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
@@ -768,21 +792,17 @@ static int veth_convert_skb_to_xdp_buff(struct veth_rq *rq,
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
+	/* Unlike generic XDP, XDP_{TX,REDIRECT} turn the buff into an
+	 * xdp_frame, which later releases the head via mem.type as well.
+	 * Only claim page_pool memory when the whole buffer was copied into
+	 * rq->page_pool above; an skb that skipped the CoW is linear.
+	 */
+	if (!pp_cow)
+		rq->xdp_rxq.mem = rq->xdp_mem;
 	*pskb = skb;
 
 	return 0;
@@ -830,7 +850,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_TX:
 		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
 		if (unlikely(veth_xdp_tx(rq, xdp, bq) < 0)) {
 			trace_xdp_exception(rq->dev, xdp_prog, act);
 			stats->rx_drops++;
@@ -842,7 +861,6 @@ static struct sk_buff *veth_xdp_rcv_skb(struct veth_rq *rq,
 	case XDP_REDIRECT:
 		veth_xdp_get(xdp);
 		consume_skb(skb);
-		xdp->rxq->mem = rq->xdp_mem;
 		if (xdp_do_redirect(rq->dev, xdp, xdp_prog)) {
 			stats->rx_drops++;
 			goto err_xdp;
-- 
2.56.0

