Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.37.83.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325120;
	b=LUJguFI/f9qO26cts2BHLoLOAapjA8MyHpXBEjIkVn5vUhuEBV92CB/TF2gZnjPSASHF
	 uIhxYPC08BauunkDddum1FtH3cTyvyTe5ctukVrKHPP00rWj23Mh7jiaTAg0D8V7+WPRn
	 JVNcmKdEmdQMNhyPccPlBKGrLsrEn8ZOI/S0nNRswTBu0qd8WVgXJQsPNnVKf/DK4ahDD
	 4BnUrONIlK5YjQaiY7zcvp5+Y7rdt+Ff7eCuJCWaFek2rKvqFWLHjfShoLnbXgG8BHcEj
	 WRk+u2UUfIHGIwV7/uy/WUxBA/0unJHRY7Edwi+kTzYRdcPy68hm1QWPL5XrONqG1cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325120;
	h=DMARC-Filter:DKIM-Signature:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=a+b6plMgXSXLiuUlwRC4rMTwgZnel2CSaDqDpaJt/Vg=;
	b=sj9qa3O21fRjRr3Yr92F2jT0wHRSdaTGku9kyL5PwYWufcOXyYZHIFF3ScBRMnKOO17j
	 WZ6i96ThZ4XNDiIp+ETGr1nZ1Imu6eLcbgGQby73IyUc9ye/b45ewoUvkAn8MFfC6j3JZ
	 dmAel2msoe2W6dt36tGePQUdVjstBynBCwzVipNozAcWaY1JNCmY929kbMHFv48JOoD4U
	 LqwB9+OF+w/5ZJ7xAwrRYcWeru3Y2tYNMopf9EM9DGabcHuqoa9b69fiifjDsEbZvUecF
	 Y72yQ/cuzHhJzVjMsZeyIgjvGoiTFgtCAFaw+Y6CpzQdDnAAOd3ziseVTqmsbg5h0AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dfb.sh;
	spf=pass smtp.mailfrom=dfb.sh;
	dkim=pass header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=dkGYE3PV;
	arc=none smtp.remote-ip=54.37.83.207
Received: from frkn.dfb.sh (frkn.dfb.sh [54.37.83.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E07E606A323;
	Tue, 10 Nov 2026 15:38:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8E07E606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dfb.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfb.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=dkGYE3PV
DKIM-Signature: v=1; a=rsa-sha256; s=frkn; d=dfb.sh; c=relaxed/relaxed; r=y;
	h=To:Message-Id:Subject:Date:From; t=1794325108; bh=a+b6plMgXSXLiuUlwRC4rMT
	wgZnel2CSaDqDpaJt/Vg=; b=dkGYE3PVuh9Glbed+E1/a2dx1Pow0Yz6xZ3+ygBiwSvXrIWLYg
	kNAy7uZhQXVS1F1PXOt43Fk7/tuLkpNvjq/DFI4PyI5vg0nLGkot7YgZr9aQ9uLfjbaEF8h2j8I
	XJc/OK4PjIJbh8dM44ENH38GdGsOiHxT+o06N285xTLTP/ruNAJyJRGg+kYn++RVGPVBA4bNJ3N
	YbadWyBMeKoLqZvYrDk312y3R5nsK/IkfjOJTbx9gE32rtLRSlaCjyp5aX6UN3a72I6mWeR9Nz1
	VE9jkCeRQdZicVssCpspV4n3gw5Q8x5ukhzjqUIJ6YpAEXhZTSLCaJZqezt4aLOjp6Q==;
From: Vladimir Petrzhikovskii <vladimir@dfb.sh>
Date: Tue, 10 Nov 2026 16:38:27 +0100
Subject: [PATCH net v2] virtio_net: check RX buffer length before DMA sync
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-b4-virtionet-rxlen-v2-1-6ec5aa0edf9f@dfb.sh>
X-B4-Tracking: v=1; b=H4sIAHI682oC/32OQQ6CMBBFr0JmbZUCCrjyHoZFW6Z2jBbT1gZDu
 Lst7l3+P29e/gIeHaGHc7GAw0ieJptCtStAGWFvyGhMGaqyOnFedkw2LJILCcPA3PxAy4SWuh7
 7HutOQnp8OdQ0b9IrJAyGX+nf8o4qZF3GpPDIpBNWmVwl8PAUZPPJkA+T+2yrIt88/wZEzjgry
 7ZTRyFb5M1l1HLvDQzrun4BgE2meuMAAAA=
X-Change-ID: 20261108-b4-virtionet-rxlen-afbf3d99e38b
To: netdev@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Vishwanath Seshagiri <vishs@meta.com>, virtualization@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Nikolai Kalinin <nikolai@kalinidze.me>, 
 Vladimir Petrzhikovskii <vladimir@dfb.sh>
X-Mailer: b4 0.15.2

An RX queue that uses the DMA API (rq->use_page_pool_dma, for example
with VIRTIO_F_ACCESS_PLATFORM) syncs each received buffer with
page_pool_dma_sync_for_cpu() using the length the device wrote to the
used ring, and checks that length against the posted buffer only after
the sync.

With SWIOTLB bouncing (swiotlb=force, or a confidential-computing
guest), the sync copies from the shared bounce buffer into the guest's
private page, so an oversized length also copies the bytes the device
wrote past the posted buffer over the neighbouring page pool fragments.
The later check drops the packet, but the copy has already happened. A
malicious device, such as a host the confidential guest does not
trust, can overwrite guest kernel memory next to an RX buffer with
bytes it chooses, which is enough to take an unprivileged guest
process to root.

Check the length before the sync in the per-fragment loops.
receive_buf() has to sync the header before the length check, because
the mergeable error path reads num_buffers from it, so limit that sync
to the posted length. A device that reports correct lengths sees no
change.

The driver has synced with the device's length since
commit 295525e29a5b ("virtio_net: merge dma operations when filling
mergeable buffers"), at first in virtnet_rq_unmap(). Commit 24fbd3967f3f
("virtio_net: add page_pool support for buffer allocation") moved the
sync to the page_pool call sites that this patch changes, so the patch
applies to v7.1 and later. Older kernels need a separate backport that
limits the sync in virtnet_rq_unmap().

Found by an LLM code review agent auditing users of the DMA API; the
fix and this changelog were also written with an LLM coding assistant
and reviewed by us. Reproduced in QEMU with swiotlb=force and
iommu_platform=on, a test-only device change that reports a used length
64 bytes past the posted buffer and writes a marker there, and a guest
kprobe module that reads the buffer after the sync: without this patch
the marker reaches the guest page for small and mergeable buffers; with
it the packets are dropped and counted in rx_length_errors. The
virtio_net selftest basic_features.sh passes with and without mergeable
buffers.

Fixes: 295525e29a5b ("virtio_net: merge dma operations when filling mergeable buffers")
Cc: stable@vger.kernel.org
Co-developed-by: Nikolai Kalinin <nikolai@kalinidze.me>
Signed-off-by: Nikolai Kalinin <nikolai@kalinidze.me>
Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>
---
The QEMU change and the guest probe are available on request.

We also have a working exploit for an unmodified v7.3-rc7 guest with
KASLR and IBT enabled: a malicious backend takes an unprivileged
process in the guest to root in the guest's initial user namespace.
We can share it privately with the maintainers on request.

An alternative is one sync helper bounded by the posted length for all
four call sites; we kept the per-site change to keep the net and
stable backport small.
---
Changes in v2:
- Fixes: now names 295525e29a5b, which introduced the sync with the
  device's length; 24fbd3967f3f only moved it (Sashiko review).
- Say in the changelog that kernels before v7.1 need a separate
  backport.
- No code change.
- Link to v1: https://patch.msgid.link/20261108-b4-virtionet-rxlen-v1-1-0078c5ab7e14@dfb.sh
---
 drivers/net/virtio_net.c | 63 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 43 insertions(+), 20 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index dd2c41ef6fbe..5aee4351dc4b 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -792,19 +792,32 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
 	return (unsigned long)mrg_ctx & ((1 << MRG_CTX_HEADER_SHIFT) - 1);
 }
 
-static int check_mergeable_len(struct net_device *dev, void *mrg_ctx,
-			       unsigned int len)
+/* Length of the mergeable buffer that add_recvbuf_mergeable() posted. */
+static unsigned int mergeable_ctx_to_buflen(void *mrg_ctx)
 {
-	unsigned int headroom, tailroom, room, truesize;
+	unsigned int headroom, tailroom, room;
 
-	truesize = mergeable_ctx_to_truesize(mrg_ctx);
 	headroom = mergeable_ctx_to_headroom(mrg_ctx);
 	tailroom = headroom ? sizeof(struct skb_shared_info) : 0;
 	room = SKB_DATA_ALIGN(headroom + tailroom);
 
-	if (len > truesize - room) {
-		pr_debug("%s: rx error: len %u exceeds truesize %lu\n",
-			 dev->name, len, (unsigned long)(truesize - room));
+	return mergeable_ctx_to_truesize(mrg_ctx) - room;
+}
+
+/* Length of the small buffer that add_recvbuf_small() posts. */
+static unsigned int small_buflen(const struct virtnet_info *vi)
+{
+	return vi->hdr_len + GOOD_PACKET_LEN;
+}
+
+static int check_mergeable_len(struct net_device *dev, void *mrg_ctx,
+			       unsigned int len)
+{
+	unsigned int buflen = mergeable_ctx_to_buflen(mrg_ctx);
+
+	if (len > buflen) {
+		pr_debug("%s: rx error: len %u exceeds buffer length %u\n",
+			 dev->name, len, buflen);
 		DEV_STATS_INC(dev, rx_length_errors);
 		return -1;
 	}
@@ -1797,15 +1810,15 @@ static struct page *xdp_linearize_page(struct net_device *dev,
 		p = virt_to_head_page(buf);
 		off = buf - page_address(p);
 
-		if (rq->use_page_pool_dma)
-			page_pool_dma_sync_for_cpu(rq->page_pool, p,
-						   off, buflen);
-
 		if (check_mergeable_len(dev, ctx, buflen)) {
 			page_pool_put_page(rq->page_pool, p, -1, true);
 			goto err_buf;
 		}
 
+		if (rq->use_page_pool_dma)
+			page_pool_dma_sync_for_cpu(rq->page_pool, p,
+						   off, buflen);
+
 		/* guard against a misconfigured or uncooperative backend that
 		 * is sending packet larger than the MTU.
 		 */
@@ -2165,15 +2178,15 @@ static int virtnet_build_xdp_buff_mrg(struct net_device *dev,
 		page = virt_to_head_page(buf);
 		offset = buf - page_address(page);
 
-		if (rq->use_page_pool_dma)
-			page_pool_dma_sync_for_cpu(rq->page_pool, page,
-						   offset, len);
-
 		if (check_mergeable_len(dev, ctx, len)) {
 			page_pool_put_page(rq->page_pool, page, -1, true);
 			goto err;
 		}
 
+		if (rq->use_page_pool_dma)
+			page_pool_dma_sync_for_cpu(rq->page_pool, page,
+						   offset, len);
+
 		truesize = mergeable_ctx_to_truesize(ctx);
 		xdp_frags_truesz += truesize;
 
@@ -2446,15 +2459,15 @@ static struct sk_buff *receive_mergeable(struct net_device *dev,
 		u64_stats_add(&stats->bytes, len);
 		page = virt_to_head_page(buf);
 
+		if (check_mergeable_len(dev, ctx, len))
+			goto err_skb;
+
 		if (rq->use_page_pool_dma) {
 			offset = buf - page_address(page);
 			page_pool_dma_sync_for_cpu(rq->page_pool, page,
 						   offset, len);
 		}
 
-		if (check_mergeable_len(dev, ctx, len))
-			goto err_skb;
-
 		truesize = mergeable_ctx_to_truesize(ctx);
 		curr_skb  = virtnet_skb_append_frag(rq, head_skb, curr_skb, page,
 						    buf, len, truesize);
@@ -2574,12 +2587,22 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
 
 	/* Sync the memory before touching anything through buf,
 	 * unless virtio core did it already.
+	 *
+	 * len comes from the device and is checked against the buffer
+	 * only later, so never sync past the buffer posted to the device.
+	 * The sync still covers the header, which receive_buf() and the
+	 * mergeable drop path read. Big buffers never come from the page
+	 * pool, so a buffer here is either mergeable or small.
 	 */
 	if (rq->use_page_pool_dma) {
 		struct page *page = virt_to_head_page(buf);
 		int offset = buf - page_address(page);
+		unsigned int buflen = vi->mergeable_rx_bufs ?
+				      mergeable_ctx_to_buflen(ctx) :
+				      small_buflen(vi);
 
-		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset, len);
+		page_pool_dma_sync_for_cpu(rq->page_pool, page, offset,
+					   min(len, buflen));
 	}
 
 	/* About the flags below:
@@ -2655,7 +2678,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 	buf += VIRTNET_RX_PAD + xdp_headroom;
 
 	ctx = mergeable_len_to_ctx(alloc_len, xdp_headroom);
-	err = virtnet_rq_submit(rq, buf, vi->hdr_len + GOOD_PACKET_LEN, ctx, gfp);
+	err = virtnet_rq_submit(rq, buf, small_buflen(vi), ctx, gfp);
 
 	if (err < 0)
 		page_pool_put_page(rq->page_pool, virt_to_head_page(buf), -1, false);

---
base-commit: 30c71476d842b094651bd7712f6c8ee8716147d0
change-id: 20261108-b4-virtionet-rxlen-afbf3d99e38b

Best regards,
--  
Vladimir Petrzhikovskii <vladimir@dfb.sh>

