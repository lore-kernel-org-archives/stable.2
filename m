Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273257;
	b=qRBSLnKrqQJju5MAe/j60zcddcd7fovQvfL8FYZr4BLdxocX4O+phPEI9BZqLY16Wq32
	 9w4wJSx0MGgc3dRA0klVW699igwe0P1yNxAbtUAWIAv2SfqY3lqhJEdYFK1fltO1bG+XU
	 tonA2TuvU0HxcGhb1JQUl1AtsxrMNwVLJN2I4bV5u49jbg6ob7B/jJb6Wu6Ct7r+Czakh
	 6iwGJukkIc+T26cZGKyoWPwQzBMdqvxcEEstAO+1/E2wTA32Iow8Y2/8NmbGcI2tTTgDP
	 CXI2ITCCQv2OXIt05mM5GGAdpA3GQjvQB4kQ41jxQs3CERMxxZQAos3bXeBhFSWuXow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273257;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WmkTPLPjaEXizfka+wmNm4t9oCsz1iByA+fiUwZ40gM=;
	b=b/3t9pyLW1lywq6R39isSAyfoNoYG9D6X/2UWwG5iT/lk/b4abDiwFJoYjS5xM2QfND3
	 L0BK4U4cTpnh9P8TwWrfLX8pza959KDjLATSb0RW4qtp02jj0tviOt+xAg8mA77d10fTv
	 dfHVyfwWoZzC0I/STfpnNrM73/+EPCQAD4ssM1tsPP4lZBGAzL1fKHFj/LAt0UUp2Qp36
	 RWQE/5/XC6v22/Rjb+TYky5fg04whR9HWA0B/EN5GSpyFtBU35CJOdipkMQ8JLZ6zTkzi
	 YX7r/e3gMlx7IbmkKsi9IMmTQF5EuR/JkX9Iqv1OU8hohPwev59avIaEReGkd9+XfCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hj36QFoB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A28CB606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hj36QFoB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAAF41F0089F;
	Tue, 10 Nov 2026 01:14:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273256;
	bh=WmkTPLPjaEXizfka+wmNm4t9oCsz1iByA+fiUwZ40gM=;
	h=From:To:Cc:Subject:Date;
	b=hj36QFoBHXGNfIPbGldA0LJJ9uLK1+FR1Vc3My/eN8HLVEHUmLG5Jq5vOHi1C2UbN
	 31r1Dy464y3E3KJuK6ri7emi1JG6e39H3AE7i1NzcMzmI3uveySTe9ovUVociVU0pA
	 zyoAXHD+tCR1b+AaYf7yha/KjZwVZHAy1Eu7/2BxcD13xmwSitsVYeFxMDVdIDzY+I
	 iQg3JSeFbF5vGgOdaakzdK10bdK55B6O0yjzJ+31wb7mEfnRk48+7zKb91XcSAWwW9
	 KBm70Zrmjl/5Cc3Q6FJSu9/Wpu+XnDSAeSUEKoni9+nnBFxbAh8adEsZJ83PtVCGVR
	 ubOXlc/z5jglg==
From: Sasha Levin <sashal@kernel.org>
To: 4ncienth@gmail.com,
	sgarzare@redhat.com,
	mst@redhat.com,
	pabeni@redhat.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] vhost/vsock: size receive SKBs from declared payload" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:14 -0500
Message-ID: <20261109201414-failed-6.6-d5e912448cd9@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d5e912448cd98b261eba8e35ab838f2dc69a79f5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201414-failed-6.6-d5e912448cd9@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From d5e912448cd98b261eba8e35ab838f2dc69a79f5 Mon Sep 17 00:00:00 2001
From: Daehyeon Ko <4ncienth@gmail.com>
Date: Mon, 5 Oct 2026 08:51:01 +0900
Subject: [PATCH] vhost/vsock: size receive SKBs from declared payload

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
---
 drivers/vhost/vsock.c | 34 ++++++++++++++++------------------
 1 file changed, 16 insertions(+), 18 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 0cb87971d7491..88a310390eb0a 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -360,7 +360,7 @@ static struct sk_buff *
 vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
-	struct virtio_vsock_hdr *hdr;
+	struct virtio_vsock_hdr hdr;
 	struct iov_iter iov_iter;
 	struct sk_buff *skb;
 	size_t payload_len;
@@ -378,34 +378,32 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 	    len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM)
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
 
 	if (skb_copy_datagram_from_iter(skb, 0, &iov_iter, payload_len)) {
-- 
2.53.0




