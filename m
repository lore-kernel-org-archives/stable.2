Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702612;
	b=KKw0daISgLtfazjhRyaD6FclXuVRBzTvIiz0mQSbJYTYYY8qrgJOnpVvbkLQqdWemuPX
	 as/WzZe/csFV4vQU3YYyzxx3gtTItaDD5J6GUCE9Agi//PvuB5WVbFjX3tddQBwv8+bgd
	 Bzs7IABGcIGeF7Cb1DnBNmbiyIA+3ckq4v1IrVpRp8Pi+gT+H+PdedmfkzUTdBSDswgoe
	 LD4NWkvv8P7lsre3U7CU4I1Lmrayh4MA22vekd2pQyMC+ddcGNRaqXOL7R8fGdAFXFWDT
	 OAlnL2nJpsDXqehkU3rR1PMMZpRGfcs5ieJP8/2Vd9fC2TgGdFwTxm7MGNDCVIPnhMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702612;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r5pXDYqqyySUPaSj1BxDDrrJ+ZjjFbGuGtffFtBphqs=;
	b=oaKE862TSP/NjT1aAjt0tAOgJaGUzKm3Y3MohZlHOByExjgtwf5oH2FcUItwpavdp5o6
	 OM4Ykips1mIcQ/TAQnnps0CRqw5tsi9IQvo9qhbL9B5m7J19LuC9t0xzt5Z6CKF2TRrmN
	 5bToFXGZyaCsEOvKxMODE78414hBcYoHrjEXoGZWWgaD/g+bCinm1U0EvIT6SvWKZkrjZ
	 he3Wam3x1MsiMfXceG9AeKsW5M+Z21uuGkPCFATaui+mIQ97g0mKKKn8Dgs6hgPSoB4YC
	 PhG5Ha8s8pds6VBF5wc+6E1YVm80L2InsdNHYsAXe/THHx+fIZ7xwQtptKZ56Xxbrfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUUfBabv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21E99606A331
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eUUfBabv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40C271F000C9;
	Sun, 15 Nov 2026 00:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702612;
	bh=r5pXDYqqyySUPaSj1BxDDrrJ+ZjjFbGuGtffFtBphqs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eUUfBabv2Da2nfPsQsGUKxLRm9z3rc4R5wcO7LxwLBZ6YPJd3SMbapIzmABx5V+DC
	 Q4eof4eyQOp7Tny4/Jw1BrGwIyLEJYdazGyVdZevQ99yS8BZDsITOrho2CvmmU/HR/
	 OijkX8EiFtd8+jSvJW6Y5PEvxunJ73kDDgDLvXcFi5h2ZknJ9RmxGa0slpNVnhx1fS
	 WTZ5o/TFpeTgpDQXUIRAc5PrxPZK23uuQDO95U/9GwkNhIcCUvRIgXVIySEd4nOqct
	 22aSW+HbVye5joXFMVyQXD4gjD405kVuO466Drq4xhOXt1nsWWSToNexs2ttPV2oML
	 xupwQ4/zISqSQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/3] vhost/vsock: size receive SKBs from declared payload
Date: Sat, 14 Nov 2026 19:30:08 -0500
Message-ID: <20261115002958.559603-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115002958.559603-1-sashal@kernel.org>
References: <20261109201916-failed-6.1-d5e912448cd9@kernel.org>
 <20261115002958.559603-1-sashal@kernel.org>
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

From: Daehyeon Ko <4ncienth@gmail.com>

[ Upstream commit d5e912448cd98b261eba8e35ab838f2dc69a79f5 ]

vhost_vsock_alloc_skb() sizes the skb from iov_length(), the total guest
descriptor length.  virtio_transport_inc_rx_pkt() instead adds hdr->len to
rx_bytes and buf_used, and budgets each queued skb as SKB_TRUESIZE(0).  The
guest controls the descriptor length and hdr->len independently.

A guest can therefore provide a 64 KiB descriptor while declaring a zero
payload.  The descriptor-sized skb remains queued, rx_bytes and buf_used
remain unchanged, and only the fixed queue-entry budget limits retention.
This is not a lifetime leak: the skb is freed when dequeued or at socket
teardown.  Repeating this across connections can nevertheless exhaust host
memory.  On Linux v7.2, 455 such descriptors retained 30,255,680 bytes for
a 262,144-byte receive buffer; a full-payload control retained 265,984
bytes.

Vhost previously read hdr->len and allocated pkt->buf from that value.  The
conversion from virtio_vsock_pkt to sk_buff instead allocated receive skbs
from the descriptor length, introducing the allocation-accounting mismatch.

Copy the header into a stack object and validate hdr->len before allocating
the skb.  Size the allocation as sizeof(hdr) + payload_len so descriptor
capacity no longer determines queued memory.  Check payload_len against
len - sizeof(hdr) to avoid addition overflow on 32-bit hosts.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Cc: stable@vger.kernel.org
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Link: https://patch.msgid.link/20261004235101.1464007-1-4ncienth@gmail.com
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 1fc03038e5543..43533ae6ce211 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -327,7 +327,7 @@ static struct sk_buff *
 vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
-	struct virtio_vsock_hdr *hdr;
+	struct virtio_vsock_hdr hdr;
 	struct iov_iter iov_iter;
 	struct sk_buff *skb;
 	size_t payload_len;
@@ -344,34 +344,32 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	if (len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
 		return NULL;
 
-	/* len contains both payload and hdr */
-	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
-
 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
-	hdr = virtio_vsock_hdr(skb);
-	nbytes = copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
-	if (nbytes != sizeof(*hdr)) {
+	nbytes = copy_from_iter(&hdr, sizeof(hdr), &iov_iter);
+	if (nbytes != sizeof(hdr)) {
 		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
-		       sizeof(*hdr), nbytes);
-		kfree_skb(skb);
+		       sizeof(hdr), nbytes);
 		return NULL;
 	}
 
-	payload_len = le32_to_cpu(hdr->len);
+	payload_len = le32_to_cpu(hdr.len);
+
+	/* The pkt is too big or the length in the header is invalid */
+	if (payload_len > len - sizeof(hdr))
+		return NULL;
+
+	/* Allocate only for the payload declared in the header. */
+	skb = virtio_vsock_alloc_skb(payload_len + sizeof(hdr), GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	memcpy(virtio_vsock_hdr(skb), &hdr, sizeof(hdr));
 
 	/* No payload */
 	if (!payload_len)
 		return skb;
 
-	/* The pkt is too big or the length in the header is invalid */
-	if (payload_len + sizeof(*hdr) > len) {
-		kfree_skb(skb);
-		return NULL;
-	}
-
 	virtio_vsock_skb_put(skb, payload_len);
 
 	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
-- 
2.53.0

