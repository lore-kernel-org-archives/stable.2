Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.74.67.75
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095076;
	b=ylpleegKjXSyyQv416EMTUEm7gTZjon2u3m5iOQ1Swa7GFpjxHyMu96H6YSvzvVPm/Pj
	 Or+VKuyDxk/3H5KlVPaomDVcoQWMhki4+liYZ1cnDWrwIGuaVNCIUg/iadvyoQwu9fA9C
	 7PxDin2hqzA0sWYLLkAWy0rXHDYP3HDkDe7bjRv7qAlDImUoKVlhhRpGnqHqHsTG6cvu4
	 fcnr1y5i2QrGbCgCAITWHC2yDMU9Ivd2ZPQi9H9wgG0GLAt2PfdsGjqdb7vIIJOGwOj9x
	 EU1Ib433ij3cbe0bbtpFn3TNBDhmy7Cmv8yOtNLrAU/Nz0Uq1QkSl62e0izYjgqxAnw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095076;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:
	 DKIM-Signature;
	bh=2uWzEdc4+3D2nuz716csecNj9j3gypnz+uLwQ5ya93w=;
	b=vWBNLDvcwzFoqAIINxN7Bw2v5syCz4FMV1b7UzSIcKXJ4M8OBIjC4Cw6ftSP8oPxwMax
	 mWID2kS4WD1uGzNGcaggSC29/b55iJH8kSGGaZ0/QYqR1uB+LwVLW/LGdaS167C8+a3QO
	 6VPEjSf9b6y6VA7rrP8q44SKc4gXsvkMNaG4NEY545a6v+/8MtNnlKo8w6PnQbwt4IJXG
	 5SX3qZv3HmVBmNPagup+nIB2vYU6V0jAw09/4d7H6plfQOSJw5Oy39tOzuqjvYv/MwYxd
	 QiAOJRKJlnWIdBgddLSuedPXIc5SX2Oe3j8MXYAqfwZiHDitjTOZDpAcA9KCC3UEKLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=poczta.fm;
	spf=pass smtp.mailfrom=poczta.fm;
	dkim=pass header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=MkXm29xI;
	arc=none smtp.remote-ip=217.74.67.75
Received: from smtpo75.interia.pl (smtpo75.interia.pl [217.74.67.75])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5881A60A2625
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5881A60A2625
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=poczta.fm
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=poczta.fm
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=poczta.fm header.i=@poczta.fm header.a=rsa-sha256 header.s=dk header.b=MkXm29xI
Received: from localhost (unknown [80.68.231.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by poczta.interia.pl (INTERIA.PL) with ESMTPSA;
	Thu, 19 Nov 2026 14:31:03 +0100 (CET)
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
	Slawomir Stepien <sst@poczta.fm>,
	stable@vger.kernel.org
Subject: [PATCH v7 bpf 3/5] veth: use the frame mem type when running XDP on an xdp_frame
Date: Thu, 19 Nov 2026 14:30:30 +0100
Message-ID: <20261119133032.2015656-4-sst@poczta.fm>
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
	t=1795095066; bh=2uWzEdc4+3D2nuz716csecNj9j3gypnz+uLwQ5ya93w=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=MkXm29xIMnppXhWn/eoPH3H3nfyKotWZrp++PZMNKbg1L3l1KT9Auz0mSPu1YX8JW
	 dli44fT9j/PyDUKgL0g3Hnn4bP/8CGwGis9W3GZtByzcGkcPxTMYGbeI9Mh2RnJBcq
	 wMstIXTBVju92xA5WLSUGGqtsWEHcGiw+kOBKNX4=

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
Reviewed-by: Tianyi Gao <tianyi@cloudflare.com>
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

