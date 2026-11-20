Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=54.37.83.207
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795185619;
	b=vQtcchfRXv6+1vzXDK2L4wHKXWaJpm0x7Ojr3KNZyvQin9t7czznXR6UNsB5ZJBvgqyy
	 akwDQgW00tTAVR0WB8F5HeZ9hnIC+6DtsGEcZJIpvX02Dq+dLUVsS6ALzCqY5wrj+b0Zo
	 5xZXZ1hsgbrkMNb1nH21NRRQycnIuptQ4Rfzg6J97KC3I+jzrhn6CYH+T90zjJTHaiWGe
	 OeSDex7mll5gjtiUK2GYbkt6JimOkXg+tz2Lbz0ERQefXERFP8Ke4cJgoTAQ3jwP0Kjgz
	 ENZhnASj+AcXO3BbUDR08hqyOqS9XtB1V7g/pEEyKkMicgjkHjCEqlGKsVWJllQbkvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795185619;
	h=DMARC-Filter:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=EbsDw6Wx3Asyav1Uh2M9tDyeJeabx+PeT1nQw1bW/Ho=;
	b=HOrNm/TQVJnjRydguVlHQmG8YGw7j5lvkU5bov3Gqxem80MgXJe2iHnhTfSO5Iltnh+p
	 OW6gDDw1B7MKdJS7Bs4C2EBnf0lgSVSxxrAn3+IzQKfyZU1SEzU6IxENklelgsn2XlHuT
	 7zAowbF6jVBArYryqiPXdsqcV4yswUbwuABv/djTTtH9JqcLfrq80J1mRvGEJddLWslL+
	 lYPFSgMmRPZuk6SUv0vBWMyOVvMymw889tZ95oHFpsx9RkdVnXJWLbTP+s4Gj4mCQRL8P
	 HNm+bCzAkyNvyexnR9ePFEaXiQUaHEkwOK2ir2i6UsPJ/yYd5XmPQWkf2Vt7PbcSuFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=dfb.sh;
	spf=pass smtp.mailfrom=dfb.sh;
	dkim=pass header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=PHqYAYeb;
	arc=none smtp.remote-ip=54.37.83.207
Received: from frkn.dfb.sh (frkn.dfb.sh [54.37.83.207])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA4D606A320;
	Fri, 20 Nov 2026 14:40:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DA4D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dfb.sh
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dfb.sh
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dfb.sh header.i=@dfb.sh header.a=rsa-sha256 header.s=frkn header.b=PHqYAYeb
DKIM-Signature: v=1; a=rsa-sha256; s=frkn; d=dfb.sh; c=relaxed/relaxed; r=y;
	h=Message-ID:Date:Subject:To:From; t=1795185595; bh=EbsDw6Wx3Asyav1Uh2M9tDy
	eJeabx+PeT1nQw1bW/Ho=; b=PHqYAYebts/l42eOie+jvcTq99KtAVMm/P6ZEL4TXuIYLca0+3
	C4n2j3D8IZXp1UVJkPB6IkK3ehfszHaMBMYmr49V8T9ieePvIIa2aWS5ghzrz9MfrsFmNeujNl1
	p33xp1Wkp6kVgciznVMLIYj7imzuth+4F0zFkx50kMKi+0a2TMNfWRozSHwJpPFvRloOLQ0J/7j
	l9Luo0TaRBD6yYUFiPLpzY+2I5lySOePqAO6ZfysxqOuJN00QVP75Vx7oJk/38Ciu8/nJQRmkr/
	9KBpfCUlHFlzRf3h2lVWgXh/xMiDFRI+EzKsOgl4rnZ4nxk7EUVsoxWf5ev7P9O9IPA==;
From: Vladimir Petrzhikovskii <vladimir@dfb.sh>
To: stable@vger.kernel.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nikolai Kalinin <nikolai@kalinidze.me>,
	netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.18.y] virtio_net: check RX buffer length before DMA sync
Date: Fri, 20 Nov 2026 15:39:53 +0100
Message-ID: <20261120143953.1560229-1-vladimir@dfb.sh>
X-Mailer: git-send-email 2.54.0
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

[ Upstream commit 29dfa436bc488056a84ee423ba82336db453e2a6 ]

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
Link: https://patch.msgid.link/20261110-b4-virtionet-rxlen-v2-1-6ec5aa0edf9f@dfb.sh
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ vladimir: 6.18.y has no page_pool RX buffers. The driver syncs small
  and mergeable RX buffers in virtnet_rq_get_buf() with the length from
  the used ring, before any length check. Limit that sync to the length
  of the posted buffer; the existing checks then drop the packet. Tested
  with the reproducer described above: without this patch the marker
  reaches the guest page for small and mergeable buffers; with it the
  sync stops at the posted length and the packets are counted in
  rx_length_errors. ]
Signed-off-by: Vladimir Petrzhikovskii <vladimir@dfb.sh>
---
 drivers/net/virtio_net.c | 47 ++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 11 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 34390befdf8a..287099885b50 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -805,19 +805,32 @@ static unsigned int mergeable_ctx_to_truesize(void *mrg_ctx)
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
@@ -965,13 +978,25 @@ static void virtnet_rq_unmap(struct receive_queue *rq, void *buf, u32 len)
 static void *virtnet_rq_get_buf(struct receive_queue *rq, u32 *len, void **ctx)
 {
 	struct virtnet_info *vi = rq->vq->vdev->priv;
+	void *buf_ctx;
+	u32 buflen;
 	void *buf;
 
 	BUG_ON(vi->big_packets && !vi->mergeable_rx_bufs);
 
-	buf = virtqueue_get_buf_ctx(rq->vq, len, ctx);
-	if (buf)
-		virtnet_rq_unmap(rq, buf, *len);
+	buf = virtqueue_get_buf_ctx(rq->vq, len, &buf_ctx);
+	if (!buf)
+		return NULL;
+
+	/* The device chooses *len. Sync only the buffer that was posted, so
+	 * that a larger *len cannot copy over the buffers next to it.
+	 */
+	buflen = vi->mergeable_rx_bufs ? mergeable_ctx_to_buflen(buf_ctx) :
+					 small_buflen(vi);
+	virtnet_rq_unmap(rq, buf, min(*len, buflen));
+
+	if (ctx)
+		*ctx = buf_ctx;
 
 	return buf;
 }
@@ -2687,7 +2712,7 @@ static int add_recvbuf_small(struct virtnet_info *vi, struct receive_queue *rq,
 
 	buf += VIRTNET_RX_PAD + xdp_headroom;
 
-	virtnet_rq_init_one_sg(rq, buf, vi->hdr_len + GOOD_PACKET_LEN);
+	virtnet_rq_init_one_sg(rq, buf, small_buflen(vi));
 
 	err = virtqueue_add_inbuf_premapped(rq->vq, rq->sg, 1, buf, ctx, gfp);
 	if (err < 0) {
-- 
2.54.0

