Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794443;
	b=xWaQbDXhOMytuIisc1h8Ls44g62yaJPMH50vW+BmJGUc3m9J+oBhB/T9DJuvn8ysHk1O
	 a/1XZx5t7rvlwyTSPichwbx8Z5YF3uO+xPJQ9a6ylD+SWagS4hqk47u32+pnMPtUKmCoL
	 Q7TXw0PJU1pzJXU2lRxDRhpxbXPjgRAc8+VRC0PPs/LunDmKjD6R2mOtg3rCPvL4NBq6I
	 jIom1y7EVvz/mH9B9UCVkKhmUEpDRxoZ6I3T49aqf9SwBRnXDgKBh0nYpzsMHRG7MJ/f+
	 nc4Rn2DNis52xvM9yH7EClHlZJk77wd+VABVlVCW3UYH5v26bVGtRMX8cQwtPaIPWyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794443;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=PbmnlnAyeGvsQHIBAQdFQ1q7JjDNG6VlV5GGU5ISfPk=;
	b=261DQ73iIK4tDVaiqTrzvmIU+8HeGCvjTnVOBX5x0YUyvOcYkPsvezbXgNiWtzsESt+u
	 bg27c6BmealEIuehmUtsoUd18S9DyLn83yfKEIDbUcyzooNoZ1T5n7d2Icf9nYDrBHAVC
	 MDPqvM+y9RxpbbY8APRyq/z08rcXaTRVmS5eRhb/nBgxvUSnxq5rLT31bTuxu008qe2ZY
	 s75w2g9RcfjrmkEbdD7t7sHmBdFwIcp9kquAB+H68lva+EP9lu6tUoSNtxQQBWbSlYJ/z
	 pvd7cabV/nPBWpfaxs2/ClnGZlr8PGy5PYTdGx7VTDS9w9DNGHmc5CCdA1IFGOwAjnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=Q9HvYtSG;
	arc=none smtp.remote-ip=217.74.67.49
Received: from smtpo49.interia.pl (smtpo49.interia.pl [217.74.67.49])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1C7606A330
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 12:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D1C7606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=Q9HvYtSG
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Wed,  4 Nov 2026 13:13:59 +0100 (CET)
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
Subject: [PATCH v6 bpf 2/3] veth: use the frame mem type when running XDP on an xdp_frame
Date: Wed,  4 Nov 2026 13:13:15 +0100
Message-ID: <20261104121316.1155680-3-sst@poczta.fm>
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
	t=1793794440; bh=PbmnlnAyeGvsQHIBAQdFQ1q7JjDNG6VlV5GGU5ISfPk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=Q9HvYtSGIz0k36ZXAJF8zLsxAHkmwvrpkSbhULZb4yG44Z25Pi7r0JeDgHFCUXKWo
	 fmgTS//byDO3OACMGy7P5KIWb0LFGNhSogSmHsIB4WgvJPwBiav4AiTTase/iGmHpn
	 B6Lglo8gQrRXtcVV56jokqNKc9PR1bb9ZiphVfro=

veth_xdp_rcv_one() runs the XDP program on frames queued by
ndo_xdp_xmit(), i.e. redirected to veth or sent back by the peer with
XDP_TX. The xdp_buff points at rq->xdp_rxq, whose mem type is whatever
the previous packet left there: the queue's MEM_TYPE_PAGE_SHARED, or
the type of an earlier frame or skb. frame->mem_type is copied in only
for XDP_TX and XDP_REDIRECT, after the program has run.

bpf_xdp_adjust_tail() and bpf_xdp_pull_data() release whole frags with
the rxq mem type. For a MEM_TYPE_PAGE_POOL frame and a stale
MEM_TYPE_PAGE_SHARED rxq, page_frag_free() drops the reference owned by
the page_pool:

  BUG: Bad page state in process ping  pfn:2244a
  page dumped because: page_pool leak
   bad_page.cold+0x58/0x6b
   __free_frozen_pages+0x837/0x1280
   page_frag_free+0x1a4/0x200
   __xdp_return+0x3a8/0x9c0
   bpf_xdp_adjust_tail+0x8a0/0xd10
   bpf_prog_007aa02d10594afa_xdp_trim_drop+0x8f/0xd8
   veth_xdp_rcv_one+0x389/0x10e0
   veth_xdp_rcv+0x1c5/0xb20
   veth_poll+0x33d/0xe00
  ...
  kernel BUG at ./include/linux/mm.h:1820!

The reverse, a MEM_TYPE_PAGE_SHARED frame after a page_pool one, hands
pages that are not page_pool backed to page_pool_put_full_netmem().

Set the rxq mem type from the frame before running the program, as
cpumap and devmap do, and drop the now redundant updates in the XDP_TX
and XDP_REDIRECT paths.

The splat above is from two veth peers with the next patch applied:
one bounces multi-buffer packets with XDP_TX, the other trims all frags
of the resulting frames. Page pool backed frames from other drivers
can hit the same path today.

Fixes: 718a18a0c8a6 ("veth: Rework veth_xdp_rcv_skb in order to accept non-linear skb")
Cc: <stable@vger.kernel.org>
Signed-off-by: Slawomir Stepien <sst@poczta.fm>
---
 drivers/net/veth.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 3eca92d3dc60..afae2c6533b9 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -658,6 +658,8 @@ static struct xdp_frame *veth_xdp_rcv_one(struct veth_rq *rq,
 
 		xdp_convert_frame_to_buff(frame, xdp);
 		xdp->rxq = &rq->xdp_rxq;
+		/* The program may release frags, do it the frame's way */
+		xdp->rxq->mem.type = frame->mem_type;
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
-- 
2.56.0

