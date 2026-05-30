Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C87E3A16B6
	for <stable@vger.kernel.org>; Sat, 30 May 2026 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780141253; cv=none; b=eGN1BssXMWiygBRu/IR7r3yKCDUw8QKD9vNguTKiprom3aa2cBFQOD/2tU7jMppFjZAg6b1yhSZq+Y2wxOmn8ANFlS+5R7kQ09TkifQD+OiHLdLLPjmdJ1V9hx+tZOqajQVxnLe+jKXpsLPvgOX5vuRm9By2pnObks3+QxNXDXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780141253; c=relaxed/simple;
	bh=OPMFIE33wi6AXq7tsCianwXoNbfCFGCk7xwduxt5C0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DxjfTyuQ0p4NUsENG2RKfDdNkQypQLGK7EP+EknOFaoisJngVIdmpj7sc5LAWHV5p0mjO3Q5irY7hHkw6HI11l2qh0ufPdOtTmxWH3TJy1koDi3mfTqsRUlQdVwlDp80JGD+bCE0BHG+D5/RVWiHJbQbNKtnOlcAY5ntHKMA6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HIjUkbm6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HIjUkbm6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 784C61F00899;
	Sat, 30 May 2026 11:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780141250;
	bh=OeRyMRZxkHoZwxjnBiTEaH9fgh4AxUnPx0ntCjwwfJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HIjUkbm65Zke8Ws0pf2Nn7ljF8VHVv8Qo7wV5rij2D/tCkLP1fCOZeQe/dz2jRuG+
	 El5JeGiEqi5a8H4WcmuMZBVoVPg9AOoSOR+Pwme8vrkXfBFgN+inLKjJMIOEI3F9u5
	 DfPQv2TstglwIUW3zLRFiZOHqqRY9RGCpO+QeR1iPVwgnytSSIFCDsn4kCSSKojI+T
	 h4Wvb0TgXw7Snl8A5IjU5NHqwTQchMTZ0K8+NoNJH4GLBzSj/kfW0jgjNedaQE0s2i
	 +2UIDMBai6BLr0fOM8h9xOSUuz8bKNelAFz8IfYkxDZh0+5+Hl7mQ4zBMEZHuY/btk
	 RbQ7+/SUXIuWg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/4] virtio/vsock: replace virtio_vsock_pkt with sk_buff
Date: Sat, 30 May 2026 07:40:44 -0400
Message-ID: <20260530114046.1945359-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530114046.1945359-1-sashal@kernel.org>
References: <2026052841-mobility-surgery-8063@gregkh>
 <20260530114046.1945359-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bobby Eshleman <bobby.eshleman@bytedance.com>

[ Upstream commit 71dc9ec9ac7d3eee785cdc986c3daeb821381e20 ]

This commit changes virtio/vsock to use sk_buff instead of
virtio_vsock_pkt. Beyond better conforming to other net code, using
sk_buff allows vsock to use sk_buff-dependent features in the future
(such as sockmap) and improves throughput.

This patch introduces the following performance changes:

Tool: Uperf
Env: Phys Host + L1 Guest
Payload: 64k
Threads: 16
Test Runs: 10
Type: SOCK_STREAM
Before: commit b7bfaa761d760 ("Linux 6.2-rc3")

Before
------
g2h: 16.77Gb/s
h2g: 10.56Gb/s

After
-----
g2h: 21.04Gb/s
h2g: 10.76Gb/s

Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c                   | 216 +++++-------
 include/linux/virtio_vsock.h            | 129 +++++--
 net/vmw_vsock/virtio_transport.c        | 149 +++------
 net/vmw_vsock/virtio_transport_common.c | 424 +++++++++++++-----------
 net/vmw_vsock/vsock_loopback.c          |  51 +--
 5 files changed, 498 insertions(+), 471 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 235cb8dee1b66..ccd9dcb24f006 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -51,8 +51,7 @@ struct vhost_vsock {
 	struct hlist_node hash;
 
 	struct vhost_work send_pkt_work;
-	spinlock_t send_pkt_list_lock;
-	struct list_head send_pkt_list;	/* host->guest pending packets */
+	struct sk_buff_head send_pkt_queue; /* host->guest pending packets */
 
 	atomic_t queued_replies;
 
@@ -109,40 +108,31 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 	vhost_disable_notify(&vsock->dev, vq);
 
 	do {
-		struct virtio_vsock_pkt *pkt;
+		struct virtio_vsock_hdr *hdr;
+		size_t iov_len, payload_len;
 		struct iov_iter iov_iter;
+		u32 flags_to_restore = 0;
+		struct sk_buff *skb;
 		unsigned out, in;
 		size_t nbytes;
-		size_t iov_len, payload_len;
 		int head;
-		u32 flags_to_restore = 0;
 
-		spin_lock_bh(&vsock->send_pkt_list_lock);
-		if (list_empty(&vsock->send_pkt_list)) {
-			spin_unlock_bh(&vsock->send_pkt_list_lock);
+		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
+
+		if (!skb) {
 			vhost_enable_notify(&vsock->dev, vq);
 			break;
 		}
 
-		pkt = list_first_entry(&vsock->send_pkt_list,
-				       struct virtio_vsock_pkt, list);
-		list_del_init(&pkt->list);
-		spin_unlock_bh(&vsock->send_pkt_list_lock);
-
 		head = vhost_get_vq_desc(vq, vq->iov, ARRAY_SIZE(vq->iov),
 					 &out, &in, NULL, NULL);
 		if (head < 0) {
-			spin_lock_bh(&vsock->send_pkt_list_lock);
-			list_add(&pkt->list, &vsock->send_pkt_list);
-			spin_unlock_bh(&vsock->send_pkt_list_lock);
+			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
 			break;
 		}
 
 		if (head == vq->num) {
-			spin_lock_bh(&vsock->send_pkt_list_lock);
-			list_add(&pkt->list, &vsock->send_pkt_list);
-			spin_unlock_bh(&vsock->send_pkt_list_lock);
-
+			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
 			/* We cannot finish yet if more buffers snuck in while
 			 * re-enabling notify.
 			 */
@@ -154,26 +144,27 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		}
 
 		if (out) {
-			virtio_transport_free_pkt(pkt);
+			kfree_skb(skb);
 			vq_err(vq, "Expected 0 output buffers, got %u\n", out);
 			break;
 		}
 
 		iov_len = iov_length(&vq->iov[out], in);
-		if (iov_len < sizeof(pkt->hdr)) {
-			virtio_transport_free_pkt(pkt);
+		if (iov_len < sizeof(*hdr)) {
+			kfree_skb(skb);
 			vq_err(vq, "Buffer len [%zu] too small\n", iov_len);
 			break;
 		}
 
 		iov_iter_init(&iov_iter, ITER_DEST, &vq->iov[out], in, iov_len);
-		payload_len = pkt->len - pkt->off;
+		payload_len = skb->len;
+		hdr = virtio_vsock_hdr(skb);
 
 		/* If the packet is greater than the space available in the
 		 * buffer, we split it using multiple buffers.
 		 */
-		if (payload_len > iov_len - sizeof(pkt->hdr)) {
-			payload_len = iov_len - sizeof(pkt->hdr);
+		if (payload_len > iov_len - sizeof(*hdr)) {
+			payload_len = iov_len - sizeof(*hdr);
 
 			/* As we are copying pieces of large packet's buffer to
 			 * small rx buffers, headers of packets in rx queue are
@@ -186,31 +177,30 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 			 * bits set. After initialized header will be copied to
 			 * rx buffer, these required bits will be restored.
 			 */
-			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
-				pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
+			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
+				hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
 				flags_to_restore |= VIRTIO_VSOCK_SEQ_EOM;
 
-				if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR) {
-					pkt->hdr.flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
+				if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR) {
+					hdr->flags &= ~cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
 					flags_to_restore |= VIRTIO_VSOCK_SEQ_EOR;
 				}
 			}
 		}
 
 		/* Set the correct length in the header */
-		pkt->hdr.len = cpu_to_le32(payload_len);
+		hdr->len = cpu_to_le32(payload_len);
 
-		nbytes = copy_to_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
-		if (nbytes != sizeof(pkt->hdr)) {
-			virtio_transport_free_pkt(pkt);
+		nbytes = copy_to_iter(hdr, sizeof(*hdr), &iov_iter);
+		if (nbytes != sizeof(*hdr)) {
+			kfree_skb(skb);
 			vq_err(vq, "Faulted on copying pkt hdr\n");
 			break;
 		}
 
-		nbytes = copy_to_iter(pkt->buf + pkt->off, payload_len,
-				      &iov_iter);
+		nbytes = copy_to_iter(skb->data, payload_len, &iov_iter);
 		if (nbytes != payload_len) {
-			virtio_transport_free_pkt(pkt);
+			kfree_skb(skb);
 			vq_err(vq, "Faulted on copying pkt buf\n");
 			break;
 		}
@@ -218,31 +208,28 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 		/* Deliver to monitoring devices all packets that we
 		 * will transmit.
 		 */
-		virtio_transport_deliver_tap_pkt(pkt);
+		virtio_transport_deliver_tap_pkt(skb);
 
-		vhost_add_used(vq, head, sizeof(pkt->hdr) + payload_len);
+		vhost_add_used(vq, head, sizeof(*hdr) + payload_len);
 		added = true;
 
-		pkt->off += payload_len;
+		skb_pull(skb, payload_len);
 		total_len += payload_len;
 
 		/* If we didn't send all the payload we can requeue the packet
 		 * to send it with the next available buffer.
 		 */
-		if (pkt->off < pkt->len) {
-			pkt->hdr.flags |= cpu_to_le32(flags_to_restore);
+		if (skb->len > 0) {
+			hdr->flags |= cpu_to_le32(flags_to_restore);
 
-			/* We are queueing the same virtio_vsock_pkt to handle
+			/* We are queueing the same skb to handle
 			 * the remaining bytes, and we want to deliver it
 			 * to monitoring devices in the next iteration.
 			 */
-			pkt->tap_delivered = false;
-
-			spin_lock_bh(&vsock->send_pkt_list_lock);
-			list_add(&pkt->list, &vsock->send_pkt_list);
-			spin_unlock_bh(&vsock->send_pkt_list_lock);
+			virtio_vsock_skb_clear_tap_delivered(skb);
+			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
 		} else {
-			if (pkt->reply) {
+			if (virtio_vsock_skb_reply(skb)) {
 				int val;
 
 				val = atomic_dec_return(&vsock->queued_replies);
@@ -254,7 +241,7 @@ vhost_transport_do_send_pkt(struct vhost_vsock *vsock,
 					restart_tx = true;
 			}
 
-			virtio_transport_free_pkt(pkt);
+			consume_skb(skb);
 		}
 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
 	if (added)
@@ -279,28 +266,26 @@ static void vhost_transport_send_pkt_work(struct vhost_work *work)
 }
 
 static int
-vhost_transport_send_pkt(struct virtio_vsock_pkt *pkt)
+vhost_transport_send_pkt(struct sk_buff *skb)
 {
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vhost_vsock *vsock;
-	int len = pkt->len;
+	int len = skb->len;
 
 	rcu_read_lock();
 
 	/* Find the vhost_vsock according to guest context id  */
-	vsock = vhost_vsock_get(le64_to_cpu(pkt->hdr.dst_cid));
+	vsock = vhost_vsock_get(le64_to_cpu(hdr->dst_cid));
 	if (!vsock) {
 		rcu_read_unlock();
-		virtio_transport_free_pkt(pkt);
+		kfree_skb(skb);
 		return -ENODEV;
 	}
 
-	if (pkt->reply)
+	if (virtio_vsock_skb_reply(skb))
 		atomic_inc(&vsock->queued_replies);
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
-	list_add_tail(&pkt->list, &vsock->send_pkt_list);
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
-
+	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
 	vhost_work_queue(&vsock->dev, &vsock->send_pkt_work);
 
 	rcu_read_unlock();
@@ -311,10 +296,8 @@ static int
 vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 {
 	struct vhost_vsock *vsock;
-	struct virtio_vsock_pkt *pkt, *n;
 	int cnt = 0;
 	int ret = -ENODEV;
-	LIST_HEAD(freeme);
 
 	rcu_read_lock();
 
@@ -323,20 +306,7 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	if (!vsock)
 		goto out;
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
-	list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
-		if (pkt->vsk != vsk)
-			continue;
-		list_move(&pkt->list, &freeme);
-	}
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
-
-	list_for_each_entry_safe(pkt, n, &freeme, list) {
-		if (pkt->reply)
-			cnt++;
-		list_del(&pkt->list);
-		virtio_transport_free_pkt(pkt);
-	}
+	cnt = virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
 
 	if (cnt) {
 		struct vhost_virtqueue *tx_vq = &vsock->vqs[VSOCK_VQ_TX];
@@ -353,12 +323,14 @@ vhost_transport_cancel_pkt(struct vsock_sock *vsk)
 	return ret;
 }
 
-static struct virtio_vsock_pkt *
-vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
+static struct sk_buff *
+vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		      unsigned int out, unsigned int in)
 {
-	struct virtio_vsock_pkt *pkt;
+	struct virtio_vsock_hdr *hdr;
 	struct iov_iter iov_iter;
+	struct sk_buff *skb;
+	size_t payload_len;
 	size_t nbytes;
 	size_t len;
 
@@ -367,50 +339,48 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
 		return NULL;
 	}
 
-	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-	if (!pkt)
+	len = iov_length(vq->iov, out);
+
+	/* len contains both payload and hdr */
+	skb = virtio_vsock_alloc_skb(len, GFP_KERNEL);
+	if (!skb)
 		return NULL;
 
-	len = iov_length(vq->iov, out);
 	iov_iter_init(&iov_iter, ITER_SOURCE, vq->iov, out, len);
 
-	nbytes = copy_from_iter(&pkt->hdr, sizeof(pkt->hdr), &iov_iter);
-	if (nbytes != sizeof(pkt->hdr)) {
+	hdr = virtio_vsock_hdr(skb);
+	nbytes = copy_from_iter(hdr, sizeof(*hdr), &iov_iter);
+	if (nbytes != sizeof(*hdr)) {
 		vq_err(vq, "Expected %zu bytes for pkt->hdr, got %zu bytes\n",
-		       sizeof(pkt->hdr), nbytes);
-		kfree(pkt);
+		       sizeof(*hdr), nbytes);
+		kfree_skb(skb);
 		return NULL;
 	}
 
-	pkt->len = le32_to_cpu(pkt->hdr.len);
+	payload_len = le32_to_cpu(hdr->len);
 
 	/* No payload */
-	if (!pkt->len)
-		return pkt;
+	if (!payload_len)
+		return skb;
 
-	/* The pkt is too big */
-	if (pkt->len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) {
-		kfree(pkt);
+	/* The pkt is too big or the length in the header is invalid */
+	if (payload_len > VIRTIO_VSOCK_MAX_PKT_BUF_SIZE ||
+	    payload_len + sizeof(*hdr) > len) {
+		kfree_skb(skb);
 		return NULL;
 	}
 
-	pkt->buf = kvmalloc(pkt->len, GFP_KERNEL);
-	if (!pkt->buf) {
-		kfree(pkt);
-		return NULL;
-	}
-
-	pkt->buf_len = pkt->len;
+	virtio_vsock_skb_rx_put(skb);
 
-	nbytes = copy_from_iter(pkt->buf, pkt->len, &iov_iter);
-	if (nbytes != pkt->len) {
-		vq_err(vq, "Expected %u byte payload, got %zu bytes\n",
-		       pkt->len, nbytes);
-		virtio_transport_free_pkt(pkt);
+	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
+	if (nbytes != payload_len) {
+		vq_err(vq, "Expected %zu byte payload, got %zu bytes\n",
+		       payload_len, nbytes);
+		kfree_skb(skb);
 		return NULL;
 	}
 
-	return pkt;
+	return skb;
 }
 
 /* Is there space left for replies to rx packets? */
@@ -497,9 +467,9 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 						  poll.work);
 	struct vhost_vsock *vsock = container_of(vq->dev, struct vhost_vsock,
 						 dev);
-	struct virtio_vsock_pkt *pkt;
 	int head, pkts = 0, total_len = 0;
 	unsigned int out, in;
+	struct sk_buff *skb;
 	bool added = false;
 
 	mutex_lock(&vq->mutex);
@@ -512,7 +482,7 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 
 	vhost_disable_notify(&vsock->dev, vq);
 	do {
-		u32 len;
+		struct virtio_vsock_hdr *hdr;
 
 		if (!vhost_vsock_more_replies(vsock)) {
 			/* Stop tx until the device processes already
@@ -535,28 +505,28 @@ static void vhost_vsock_handle_tx_kick(struct vhost_work *work)
 			break;
 		}
 
-		pkt = vhost_vsock_alloc_pkt(vq, out, in);
-		if (!pkt) {
+		skb = vhost_vsock_alloc_skb(vq, out, in);
+		if (!skb) {
 			vq_err(vq, "Faulted on pkt\n");
 			continue;
 		}
 
-		len = pkt->len;
+		total_len += sizeof(*hdr) + skb->len;
 
 		/* Deliver to monitoring devices all received packets */
-		virtio_transport_deliver_tap_pkt(pkt);
+		virtio_transport_deliver_tap_pkt(skb);
+
+		hdr = virtio_vsock_hdr(skb);
 
 		/* Only accept correctly addressed packets */
-		if (le64_to_cpu(pkt->hdr.src_cid) == vsock->guest_cid &&
-		    le64_to_cpu(pkt->hdr.dst_cid) ==
+		if (le64_to_cpu(hdr->src_cid) == vsock->guest_cid &&
+		    le64_to_cpu(hdr->dst_cid) ==
 		    vhost_transport_get_local_cid())
-			virtio_transport_recv_pkt(&vhost_transport, pkt);
+			virtio_transport_recv_pkt(&vhost_transport, skb);
 		else
-			virtio_transport_free_pkt(pkt);
+			kfree_skb(skb);
 
-		len += sizeof(pkt->hdr);
 		vhost_add_used(vq, head, 0);
-		total_len += len;
 		added = true;
 	} while(likely(!vhost_exceeds_weight(vq, ++pkts, total_len)));
 
@@ -699,8 +669,7 @@ static int vhost_vsock_dev_open(struct inode *inode, struct file *file)
 		       VHOST_VSOCK_WEIGHT, true, NULL);
 
 	file->private_data = vsock;
-	spin_lock_init(&vsock->send_pkt_list_lock);
-	INIT_LIST_HEAD(&vsock->send_pkt_list);
+	skb_queue_head_init(&vsock->send_pkt_queue);
 	vhost_work_init(&vsock->send_pkt_work, vhost_transport_send_pkt_work);
 	return 0;
 
@@ -777,16 +746,7 @@ static int vhost_vsock_dev_release(struct inode *inode, struct file *file)
 	vhost_vsock_flush(vsock);
 	vhost_dev_stop(&vsock->dev);
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
-	while (!list_empty(&vsock->send_pkt_list)) {
-		struct virtio_vsock_pkt *pkt;
-
-		pkt = list_first_entry(&vsock->send_pkt_list,
-				struct virtio_vsock_pkt, list);
-		list_del_init(&pkt->list);
-		virtio_transport_free_pkt(pkt);
-	}
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
+	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	vhost_dev_cleanup(&vsock->dev);
 	kfree(vsock->dev.vqs);
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 35d7eedb5e8e4..3f9c166113063 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -7,6 +7,109 @@
 #include <net/sock.h>
 #include <net/af_vsock.h>
 
+#define VIRTIO_VSOCK_SKB_HEADROOM (sizeof(struct virtio_vsock_hdr))
+
+struct virtio_vsock_skb_cb {
+	bool reply;
+	bool tap_delivered;
+};
+
+#define VIRTIO_VSOCK_SKB_CB(skb) ((struct virtio_vsock_skb_cb *)((skb)->cb))
+
+static inline struct virtio_vsock_hdr *virtio_vsock_hdr(struct sk_buff *skb)
+{
+	return (struct virtio_vsock_hdr *)skb->head;
+}
+
+static inline bool virtio_vsock_skb_reply(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->reply;
+}
+
+static inline void virtio_vsock_skb_set_reply(struct sk_buff *skb)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->reply = true;
+}
+
+static inline bool virtio_vsock_skb_tap_delivered(struct sk_buff *skb)
+{
+	return VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered;
+}
+
+static inline void virtio_vsock_skb_set_tap_delivered(struct sk_buff *skb)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = true;
+}
+
+static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
+{
+	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
+}
+
+static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
+{
+	u32 len;
+
+	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
+
+	if (len > 0)
+		skb_put(skb, len);
+}
+
+static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
+{
+	struct sk_buff *skb;
+
+	if (size < VIRTIO_VSOCK_SKB_HEADROOM)
+		return NULL;
+
+	skb = alloc_skb(size, mask);
+	if (!skb)
+		return NULL;
+
+	skb_reserve(skb, VIRTIO_VSOCK_SKB_HEADROOM);
+	return skb;
+}
+
+static inline void
+virtio_vsock_skb_queue_head(struct sk_buff_head *list, struct sk_buff *skb)
+{
+	spin_lock_bh(&list->lock);
+	__skb_queue_head(list, skb);
+	spin_unlock_bh(&list->lock);
+}
+
+static inline void
+virtio_vsock_skb_queue_tail(struct sk_buff_head *list, struct sk_buff *skb)
+{
+	spin_lock_bh(&list->lock);
+	__skb_queue_tail(list, skb);
+	spin_unlock_bh(&list->lock);
+}
+
+static inline struct sk_buff *virtio_vsock_skb_dequeue(struct sk_buff_head *list)
+{
+	struct sk_buff *skb;
+
+	spin_lock_bh(&list->lock);
+	skb = __skb_dequeue(list);
+	spin_unlock_bh(&list->lock);
+
+	return skb;
+}
+
+static inline void virtio_vsock_skb_queue_purge(struct sk_buff_head *list)
+{
+	spin_lock_bh(&list->lock);
+	__skb_queue_purge(list);
+	spin_unlock_bh(&list->lock);
+}
+
+static inline size_t virtio_vsock_skb_len(struct sk_buff *skb)
+{
+	return (size_t)(skb_end_pointer(skb) - skb->head);
+}
+
 #define VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE	(1024 * 4)
 #define VIRTIO_VSOCK_MAX_BUF_SIZE		0xFFFFFFFFUL
 #define VIRTIO_VSOCK_MAX_PKT_BUF_SIZE		(1024 * 64)
@@ -35,23 +138,10 @@ struct virtio_vsock_sock {
 	u32 last_fwd_cnt;
 	u32 rx_bytes;
 	u32 buf_alloc;
-	struct list_head rx_queue;
+	struct sk_buff_head rx_queue;
 	u32 msg_count;
 };
 
-struct virtio_vsock_pkt {
-	struct virtio_vsock_hdr	hdr;
-	struct list_head list;
-	/* socket refcnt not held, only use for cancellation */
-	struct vsock_sock *vsk;
-	void *buf;
-	u32 buf_len;
-	u32 len;
-	u32 off;
-	bool reply;
-	bool tap_delivered;
-};
-
 struct virtio_vsock_pkt_info {
 	u32 remote_cid, remote_port;
 	struct vsock_sock *vsk;
@@ -68,7 +158,7 @@ struct virtio_transport {
 	struct vsock_transport transport;
 
 	/* Takes ownership of the packet */
-	int (*send_pkt)(struct virtio_vsock_pkt *pkt);
+	int (*send_pkt)(struct sk_buff *skb);
 };
 
 ssize_t
@@ -149,11 +239,10 @@ virtio_transport_dgram_enqueue(struct vsock_sock *vsk,
 void virtio_transport_destruct(struct vsock_sock *vsk);
 
 void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct virtio_vsock_pkt *pkt);
-void virtio_transport_free_pkt(struct virtio_vsock_pkt *pkt);
-void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt);
+			       struct sk_buff *skb);
+void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb);
 u32 virtio_transport_get_credit(struct virtio_vsock_sock *vvs, u32 wanted);
 void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
-void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt);
-
+void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
+int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
 #endif /* _LINUX_VIRTIO_VSOCK_H */
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 0b41028ed544a..8a4e28826e1f6 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -42,8 +42,7 @@ struct virtio_vsock {
 	bool tx_run;
 
 	struct work_struct send_pkt_work;
-	spinlock_t send_pkt_list_lock;
-	struct list_head send_pkt_list;
+	struct sk_buff_head send_pkt_queue;
 
 	atomic_t queued_replies;
 
@@ -101,41 +100,31 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 	vq = vsock->vqs[VSOCK_VQ_TX];
 
 	for (;;) {
-		struct virtio_vsock_pkt *pkt;
 		struct scatterlist hdr, buf, *sgs[2];
 		int ret, in_sg = 0, out_sg = 0;
+		struct sk_buff *skb;
 		bool reply;
 
-		spin_lock_bh(&vsock->send_pkt_list_lock);
-		if (list_empty(&vsock->send_pkt_list)) {
-			spin_unlock_bh(&vsock->send_pkt_list_lock);
+		skb = virtio_vsock_skb_dequeue(&vsock->send_pkt_queue);
+		if (!skb)
 			break;
-		}
-
-		pkt = list_first_entry(&vsock->send_pkt_list,
-				       struct virtio_vsock_pkt, list);
-		list_del_init(&pkt->list);
-		spin_unlock_bh(&vsock->send_pkt_list_lock);
 
-		virtio_transport_deliver_tap_pkt(pkt);
+		virtio_transport_deliver_tap_pkt(skb);
+		reply = virtio_vsock_skb_reply(skb);
 
-		reply = pkt->reply;
-
-		sg_init_one(&hdr, &pkt->hdr, sizeof(pkt->hdr));
+		sg_init_one(&hdr, virtio_vsock_hdr(skb), sizeof(*virtio_vsock_hdr(skb)));
 		sgs[out_sg++] = &hdr;
-		if (pkt->buf) {
-			sg_init_one(&buf, pkt->buf, pkt->len);
+		if (skb->len > 0) {
+			sg_init_one(&buf, skb->data, skb->len);
 			sgs[out_sg++] = &buf;
 		}
 
-		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, pkt, GFP_KERNEL);
+		ret = virtqueue_add_sgs(vq, sgs, out_sg, in_sg, skb, GFP_KERNEL);
 		/* Usually this means that there is no more space available in
 		 * the vq
 		 */
 		if (ret < 0) {
-			spin_lock_bh(&vsock->send_pkt_list_lock);
-			list_add(&pkt->list, &vsock->send_pkt_list);
-			spin_unlock_bh(&vsock->send_pkt_list_lock);
+			virtio_vsock_skb_queue_head(&vsock->send_pkt_queue, skb);
 			break;
 		}
 
@@ -164,32 +153,32 @@ virtio_transport_send_pkt_work(struct work_struct *work)
 }
 
 static int
-virtio_transport_send_pkt(struct virtio_vsock_pkt *pkt)
+virtio_transport_send_pkt(struct sk_buff *skb)
 {
+	struct virtio_vsock_hdr *hdr;
 	struct virtio_vsock *vsock;
-	int len = pkt->len;
+	int len = skb->len;
+
+	hdr = virtio_vsock_hdr(skb);
 
 	rcu_read_lock();
 	vsock = rcu_dereference(the_virtio_vsock);
 	if (!vsock) {
-		virtio_transport_free_pkt(pkt);
+		kfree_skb(skb);
 		len = -ENODEV;
 		goto out_rcu;
 	}
 
-	if (le64_to_cpu(pkt->hdr.dst_cid) == vsock->guest_cid) {
-		virtio_transport_free_pkt(pkt);
+	if (le64_to_cpu(hdr->dst_cid) == vsock->guest_cid) {
+		kfree_skb(skb);
 		len = -ENODEV;
 		goto out_rcu;
 	}
 
-	if (pkt->reply)
+	if (virtio_vsock_skb_reply(skb))
 		atomic_inc(&vsock->queued_replies);
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
-	list_add_tail(&pkt->list, &vsock->send_pkt_list);
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
-
+	virtio_vsock_skb_queue_tail(&vsock->send_pkt_queue, skb);
 	queue_work(virtio_vsock_workqueue, &vsock->send_pkt_work);
 
 out_rcu:
@@ -201,9 +190,7 @@ static int
 virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 {
 	struct virtio_vsock *vsock;
-	struct virtio_vsock_pkt *pkt, *n;
 	int cnt = 0, ret;
-	LIST_HEAD(freeme);
 
 	rcu_read_lock();
 	vsock = rcu_dereference(the_virtio_vsock);
@@ -212,20 +199,7 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 		goto out_rcu;
 	}
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
-	list_for_each_entry_safe(pkt, n, &vsock->send_pkt_list, list) {
-		if (pkt->vsk != vsk)
-			continue;
-		list_move(&pkt->list, &freeme);
-	}
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
-
-	list_for_each_entry_safe(pkt, n, &freeme, list) {
-		if (pkt->reply)
-			cnt++;
-		list_del(&pkt->list);
-		virtio_transport_free_pkt(pkt);
-	}
+	cnt = virtio_transport_purge_skbs(vsk, &vsock->send_pkt_queue);
 
 	if (cnt) {
 		struct virtqueue *rx_vq = vsock->vqs[VSOCK_VQ_RX];
@@ -246,38 +220,28 @@ virtio_transport_cancel_pkt(struct vsock_sock *vsk)
 
 static void virtio_vsock_rx_fill(struct virtio_vsock *vsock)
 {
-	int buf_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE;
-	struct virtio_vsock_pkt *pkt;
-	struct scatterlist hdr, buf, *sgs[2];
+	int total_len = VIRTIO_VSOCK_DEFAULT_RX_BUF_SIZE + VIRTIO_VSOCK_SKB_HEADROOM;
+	struct scatterlist pkt, *p;
 	struct virtqueue *vq;
+	struct sk_buff *skb;
 	int ret;
 
 	vq = vsock->vqs[VSOCK_VQ_RX];
 
 	do {
-		pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-		if (!pkt)
+		skb = virtio_vsock_alloc_skb(total_len, GFP_KERNEL);
+		if (!skb)
 			break;
 
-		pkt->buf = kmalloc(buf_len, GFP_KERNEL);
-		if (!pkt->buf) {
-			virtio_transport_free_pkt(pkt);
+		memset(skb->head, 0, VIRTIO_VSOCK_SKB_HEADROOM);
+		sg_init_one(&pkt, virtio_vsock_hdr(skb), total_len);
+		p = &pkt;
+		ret = virtqueue_add_sgs(vq, &p, 0, 1, skb, GFP_KERNEL);
+		if (ret < 0) {
+			kfree_skb(skb);
 			break;
 		}
 
-		pkt->buf_len = buf_len;
-		pkt->len = buf_len;
-
-		sg_init_one(&hdr, &pkt->hdr, sizeof(pkt->hdr));
-		sgs[0] = &hdr;
-
-		sg_init_one(&buf, pkt->buf, buf_len);
-		sgs[1] = &buf;
-		ret = virtqueue_add_sgs(vq, sgs, 0, 2, pkt, GFP_KERNEL);
-		if (ret) {
-			virtio_transport_free_pkt(pkt);
-			break;
-		}
 		vsock->rx_buf_nr++;
 	} while (vq->num_free);
 	if (vsock->rx_buf_nr > vsock->rx_buf_max_nr)
@@ -299,12 +263,12 @@ static void virtio_transport_tx_work(struct work_struct *work)
 		goto out;
 
 	do {
-		struct virtio_vsock_pkt *pkt;
+		struct sk_buff *skb;
 		unsigned int len;
 
 		virtqueue_disable_cb(vq);
-		while ((pkt = virtqueue_get_buf(vq, &len)) != NULL) {
-			virtio_transport_free_pkt(pkt);
+		while ((skb = virtqueue_get_buf(vq, &len)) != NULL) {
+			consume_skb(skb);
 			added = true;
 		}
 	} while (!virtqueue_enable_cb(vq));
@@ -529,7 +493,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 	do {
 		virtqueue_disable_cb(vq);
 		for (;;) {
-			struct virtio_vsock_pkt *pkt;
+			struct sk_buff *skb;
 			unsigned int len;
 
 			if (!virtio_transport_more_replies(vsock)) {
@@ -540,23 +504,22 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				goto out;
 			}
 
-			pkt = virtqueue_get_buf(vq, &len);
-			if (!pkt) {
+			skb = virtqueue_get_buf(vq, &len);
+			if (!skb)
 				break;
-			}
 
 			vsock->rx_buf_nr--;
 
 			/* Drop short/long packets */
-			if (unlikely(len < sizeof(pkt->hdr) ||
-				     len > sizeof(pkt->hdr) + pkt->len)) {
-				virtio_transport_free_pkt(pkt);
+			if (unlikely(len < sizeof(struct virtio_vsock_hdr) ||
+				     len > virtio_vsock_skb_len(skb))) {
+				kfree_skb(skb);
 				continue;
 			}
 
-			pkt->len = len - sizeof(pkt->hdr);
-			virtio_transport_deliver_tap_pkt(pkt);
-			virtio_transport_recv_pkt(&virtio_transport, pkt);
+			virtio_vsock_skb_rx_put(skb);
+			virtio_transport_deliver_tap_pkt(skb);
+			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}
 	} while (!virtqueue_enable_cb(vq));
 
@@ -624,7 +587,7 @@ static void virtio_vsock_vqs_start(struct virtio_vsock *vsock)
 static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 {
 	struct virtio_device *vdev = vsock->vdev;
-	struct virtio_vsock_pkt *pkt;
+	struct sk_buff *skb;
 
 	/* Reset all connected sockets when the VQs disappear */
 	vsock_for_each_connected_socket(&virtio_transport.transport,
@@ -651,23 +614,16 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 	vdev->config->reset(vdev);
 
 	mutex_lock(&vsock->rx_lock);
-	while ((pkt = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
-		virtio_transport_free_pkt(pkt);
+	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
+		kfree_skb(skb);
 	mutex_unlock(&vsock->rx_lock);
 
 	mutex_lock(&vsock->tx_lock);
-	while ((pkt = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_TX])))
-		virtio_transport_free_pkt(pkt);
+	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_TX])))
+		kfree_skb(skb);
 	mutex_unlock(&vsock->tx_lock);
 
-	spin_lock_bh(&vsock->send_pkt_list_lock);
-	while (!list_empty(&vsock->send_pkt_list)) {
-		pkt = list_first_entry(&vsock->send_pkt_list,
-				       struct virtio_vsock_pkt, list);
-		list_del(&pkt->list);
-		virtio_transport_free_pkt(pkt);
-	}
-	spin_unlock_bh(&vsock->send_pkt_list_lock);
+	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
@@ -704,8 +660,7 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
 	mutex_init(&vsock->tx_lock);
 	mutex_init(&vsock->rx_lock);
 	mutex_init(&vsock->event_lock);
-	spin_lock_init(&vsock->send_pkt_list_lock);
-	INIT_LIST_HEAD(&vsock->send_pkt_list);
+	skb_queue_head_init(&vsock->send_pkt_queue);
 	INIT_WORK(&vsock->rx_work, virtio_transport_rx_work);
 	INIT_WORK(&vsock->tx_work, virtio_transport_tx_work);
 	INIT_WORK(&vsock->event_work, virtio_transport_event_work);
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index ffd4db198bdf5..0742653e2b915 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -40,53 +40,56 @@ virtio_transport_get_ops(struct vsock_sock *vsk)
 	return container_of(t, struct virtio_transport, transport);
 }
 
-static struct virtio_vsock_pkt *
-virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
+/* Returns a new packet on success, otherwise returns NULL.
+ *
+ * If NULL is returned, errp is set to a negative errno.
+ */
+static struct sk_buff *
+virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
 			   size_t len,
 			   u32 src_cid,
 			   u32 src_port,
 			   u32 dst_cid,
 			   u32 dst_port)
 {
-	struct virtio_vsock_pkt *pkt;
+	const size_t skb_len = VIRTIO_VSOCK_SKB_HEADROOM + len;
+	struct virtio_vsock_hdr *hdr;
+	struct sk_buff *skb;
+	void *payload;
 	int err;
 
-	pkt = kzalloc(sizeof(*pkt), GFP_KERNEL);
-	if (!pkt)
+	skb = virtio_vsock_alloc_skb(skb_len, GFP_KERNEL);
+	if (!skb)
 		return NULL;
 
-	pkt->hdr.type		= cpu_to_le16(info->type);
-	pkt->hdr.op		= cpu_to_le16(info->op);
-	pkt->hdr.src_cid	= cpu_to_le64(src_cid);
-	pkt->hdr.dst_cid	= cpu_to_le64(dst_cid);
-	pkt->hdr.src_port	= cpu_to_le32(src_port);
-	pkt->hdr.dst_port	= cpu_to_le32(dst_port);
-	pkt->hdr.flags		= cpu_to_le32(info->flags);
-	pkt->len		= len;
-	pkt->hdr.len		= cpu_to_le32(len);
-	pkt->reply		= info->reply;
-	pkt->vsk		= info->vsk;
+	hdr = virtio_vsock_hdr(skb);
+	hdr->type	= cpu_to_le16(info->type);
+	hdr->op		= cpu_to_le16(info->op);
+	hdr->src_cid	= cpu_to_le64(src_cid);
+	hdr->dst_cid	= cpu_to_le64(dst_cid);
+	hdr->src_port	= cpu_to_le32(src_port);
+	hdr->dst_port	= cpu_to_le32(dst_port);
+	hdr->flags	= cpu_to_le32(info->flags);
+	hdr->len	= cpu_to_le32(len);
 
 	if (info->msg && len > 0) {
-		pkt->buf = kmalloc(len, GFP_KERNEL);
-		if (!pkt->buf)
-			goto out_pkt;
-
-		pkt->buf_len = len;
-
-		err = memcpy_from_msg(pkt->buf, info->msg, len);
+		payload = skb_put(skb, len);
+		err = memcpy_from_msg(payload, info->msg, len);
 		if (err)
 			goto out;
 
 		if (msg_data_left(info->msg) == 0 &&
 		    info->type == VIRTIO_VSOCK_TYPE_SEQPACKET) {
-			pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
+			hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOM);
 
 			if (info->msg->msg_flags & MSG_EOR)
-				pkt->hdr.flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
+				hdr->flags |= cpu_to_le32(VIRTIO_VSOCK_SEQ_EOR);
 		}
 	}
 
+	if (info->reply)
+		virtio_vsock_skb_set_reply(skb);
+
 	trace_virtio_transport_alloc_pkt(src_cid, src_port,
 					 dst_cid, dst_port,
 					 len,
@@ -94,19 +97,18 @@ virtio_transport_alloc_pkt(struct virtio_vsock_pkt_info *info,
 					 info->op,
 					 info->flags);
 
-	return pkt;
+	return skb;
 
 out:
-	kfree(pkt->buf);
-out_pkt:
-	kfree(pkt);
+	kfree_skb(skb);
 	return NULL;
 }
 
 /* Packet capture */
 static struct sk_buff *virtio_transport_build_skb(void *opaque)
 {
-	struct virtio_vsock_pkt *pkt = opaque;
+	struct virtio_vsock_hdr *pkt_hdr;
+	struct sk_buff *pkt = opaque;
 	struct af_vsockmon_hdr *hdr;
 	struct sk_buff *skb;
 	size_t payload_len;
@@ -116,10 +118,11 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	 * the payload length from the header and the buffer pointer taking
 	 * care of the offset in the original packet.
 	 */
-	payload_len = le32_to_cpu(pkt->hdr.len);
-	payload_buf = pkt->buf + pkt->off;
+	pkt_hdr = virtio_vsock_hdr(pkt);
+	payload_len = pkt->len;
+	payload_buf = pkt->data;
 
-	skb = alloc_skb(sizeof(*hdr) + sizeof(pkt->hdr) + payload_len,
+	skb = alloc_skb(sizeof(*hdr) + sizeof(*pkt_hdr) + payload_len,
 			GFP_ATOMIC);
 	if (!skb)
 		return NULL;
@@ -127,16 +130,16 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	hdr = skb_put(skb, sizeof(*hdr));
 
 	/* pkt->hdr is little-endian so no need to byteswap here */
-	hdr->src_cid = pkt->hdr.src_cid;
-	hdr->src_port = pkt->hdr.src_port;
-	hdr->dst_cid = pkt->hdr.dst_cid;
-	hdr->dst_port = pkt->hdr.dst_port;
+	hdr->src_cid = pkt_hdr->src_cid;
+	hdr->src_port = pkt_hdr->src_port;
+	hdr->dst_cid = pkt_hdr->dst_cid;
+	hdr->dst_port = pkt_hdr->dst_port;
 
 	hdr->transport = cpu_to_le16(AF_VSOCK_TRANSPORT_VIRTIO);
-	hdr->len = cpu_to_le16(sizeof(pkt->hdr));
+	hdr->len = cpu_to_le16(sizeof(*pkt_hdr));
 	memset(hdr->reserved, 0, sizeof(hdr->reserved));
 
-	switch (le16_to_cpu(pkt->hdr.op)) {
+	switch (le16_to_cpu(pkt_hdr->op)) {
 	case VIRTIO_VSOCK_OP_REQUEST:
 	case VIRTIO_VSOCK_OP_RESPONSE:
 		hdr->op = cpu_to_le16(AF_VSOCK_OP_CONNECT);
@@ -157,7 +160,7 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 		break;
 	}
 
-	skb_put_data(skb, &pkt->hdr, sizeof(pkt->hdr));
+	skb_put_data(skb, pkt_hdr, sizeof(*pkt_hdr));
 
 	if (payload_len) {
 		skb_put_data(skb, payload_buf, payload_len);
@@ -166,13 +169,13 @@ static struct sk_buff *virtio_transport_build_skb(void *opaque)
 	return skb;
 }
 
-void virtio_transport_deliver_tap_pkt(struct virtio_vsock_pkt *pkt)
+void virtio_transport_deliver_tap_pkt(struct sk_buff *skb)
 {
-	if (pkt->tap_delivered)
+	if (virtio_vsock_skb_tap_delivered(skb))
 		return;
 
-	vsock_deliver_tap(virtio_transport_build_skb, pkt);
-	pkt->tap_delivered = true;
+	vsock_deliver_tap(virtio_transport_build_skb, skb);
+	virtio_vsock_skb_set_tap_delivered(skb);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_deliver_tap_pkt);
 
@@ -195,8 +198,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	u32 src_cid, src_port, dst_cid, dst_port;
 	const struct virtio_transport *t_ops;
 	struct virtio_vsock_sock *vvs;
-	struct virtio_vsock_pkt *pkt;
 	u32 pkt_len = info->pkt_len;
+	struct sk_buff *skb;
 
 	info->type = virtio_transport_get_type(sk_vsock(vsk));
 
@@ -227,42 +230,47 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
 		return pkt_len;
 
-	pkt = virtio_transport_alloc_pkt(info, pkt_len,
+	skb = virtio_transport_alloc_skb(info, pkt_len,
 					 src_cid, src_port,
 					 dst_cid, dst_port);
-	if (!pkt) {
+	if (!skb) {
 		virtio_transport_put_credit(vvs, pkt_len);
 		return -ENOMEM;
 	}
 
-	virtio_transport_inc_tx_pkt(vvs, pkt);
+	virtio_transport_inc_tx_pkt(vvs, skb);
 
-	return t_ops->send_pkt(pkt);
+	return t_ops->send_pkt(skb);
 }
 
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
-					struct virtio_vsock_pkt *pkt)
+					struct sk_buff *skb)
 {
-	if (vvs->rx_bytes + pkt->len > vvs->buf_alloc)
+	if (vvs->rx_bytes + skb->len > vvs->buf_alloc)
 		return false;
 
-	vvs->rx_bytes += pkt->len;
+	vvs->rx_bytes += skb->len;
 	return true;
 }
 
 static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
-					struct virtio_vsock_pkt *pkt)
+					struct sk_buff *skb)
 {
-	vvs->rx_bytes -= pkt->len;
-	vvs->fwd_cnt += pkt->len;
+	int len;
+
+	len = skb_headroom(skb) - sizeof(struct virtio_vsock_hdr) - skb->len;
+	vvs->rx_bytes -= len;
+	vvs->fwd_cnt += len;
 }
 
-void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct virtio_vsock_pkt *pkt)
+void virtio_transport_inc_tx_pkt(struct virtio_vsock_sock *vvs, struct sk_buff *skb)
 {
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
+
 	spin_lock_bh(&vvs->rx_lock);
 	vvs->last_fwd_cnt = vvs->fwd_cnt;
-	pkt->hdr.fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
-	pkt->hdr.buf_alloc = cpu_to_le32(vvs->buf_alloc);
+	hdr->fwd_cnt = cpu_to_le32(vvs->fwd_cnt);
+	hdr->buf_alloc = cpu_to_le32(vvs->buf_alloc);
 	spin_unlock_bh(&vvs->rx_lock);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_inc_tx_pkt);
@@ -306,29 +314,29 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
 				size_t len)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
-	struct virtio_vsock_pkt *pkt;
 	size_t bytes, total = 0, off;
+	struct sk_buff *skb, *tmp;
 	int err = -EFAULT;
 
 	spin_lock_bh(&vvs->rx_lock);
 
-	list_for_each_entry(pkt, &vvs->rx_queue, list) {
-		off = pkt->off;
+	skb_queue_walk_safe(&vvs->rx_queue, skb,  tmp) {
+		off = 0;
 
 		if (total == len)
 			break;
 
-		while (total < len && off < pkt->len) {
+		while (total < len && off < skb->len) {
 			bytes = len - total;
-			if (bytes > pkt->len - off)
-				bytes = pkt->len - off;
+			if (bytes > skb->len - off)
+				bytes = skb->len - off;
 
 			/* sk_lock is held by caller so no one else can dequeue.
 			 * Unlock rx_lock since memcpy_to_msg() may sleep.
 			 */
 			spin_unlock_bh(&vvs->rx_lock);
 
-			err = memcpy_to_msg(msg, pkt->buf + off, bytes);
+			err = memcpy_to_msg(msg, skb->data + off, bytes);
 			if (err)
 				goto out;
 
@@ -355,39 +363,40 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 				   size_t len)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
-	struct virtio_vsock_pkt *pkt;
 	size_t bytes, total = 0;
+	struct sk_buff *skb;
+	int err = -EFAULT;
 	u32 free_space;
 	u32 fwd_cnt_delta;
 	bool low_rx_bytes;
-	int err = -EFAULT;
 
 	spin_lock_bh(&vvs->rx_lock);
-	while (total < len && !list_empty(&vvs->rx_queue)) {
-		pkt = list_first_entry(&vvs->rx_queue,
-				       struct virtio_vsock_pkt, list);
+	while (total < len && !skb_queue_empty(&vvs->rx_queue)) {
+		skb = __skb_dequeue(&vvs->rx_queue);
 
 		bytes = len - total;
-		if (bytes > pkt->len - pkt->off)
-			bytes = pkt->len - pkt->off;
+		if (bytes > skb->len)
+			bytes = skb->len;
 
 		/* sk_lock is held by caller so no one else can dequeue.
 		 * Unlock rx_lock since memcpy_to_msg() may sleep.
 		 */
 		spin_unlock_bh(&vvs->rx_lock);
 
-		err = memcpy_to_msg(msg, pkt->buf + pkt->off, bytes);
+		err = memcpy_to_msg(msg, skb->data, bytes);
 		if (err)
 			goto out;
 
 		spin_lock_bh(&vvs->rx_lock);
 
 		total += bytes;
-		pkt->off += bytes;
-		if (pkt->off == pkt->len) {
-			virtio_transport_dec_rx_pkt(vvs, pkt);
-			list_del(&pkt->list);
-			virtio_transport_free_pkt(pkt);
+		skb_pull(skb, bytes);
+
+		if (skb->len == 0) {
+			virtio_transport_dec_rx_pkt(vvs, skb);
+			consume_skb(skb);
+		} else {
+			__skb_queue_head(&vvs->rx_queue, skb);
 		}
 	}
 
@@ -424,10 +433,10 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 						 int flags)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
-	struct virtio_vsock_pkt *pkt;
 	int dequeued_len = 0;
 	size_t user_buf_len = msg_data_left(msg);
 	bool msg_ready = false;
+	struct sk_buff *skb;
 
 	spin_lock_bh(&vvs->rx_lock);
 
@@ -437,13 +446,18 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 	}
 
 	while (!msg_ready) {
-		pkt = list_first_entry(&vvs->rx_queue, struct virtio_vsock_pkt, list);
+		struct virtio_vsock_hdr *hdr;
+
+		skb = __skb_dequeue(&vvs->rx_queue);
+		if (!skb)
+			break;
+		hdr = virtio_vsock_hdr(skb);
 
 		if (dequeued_len >= 0) {
 			size_t pkt_len;
 			size_t bytes_to_copy;
 
-			pkt_len = (size_t)le32_to_cpu(pkt->hdr.len);
+			pkt_len = (size_t)le32_to_cpu(hdr->len);
 			bytes_to_copy = min(user_buf_len, pkt_len);
 
 			if (bytes_to_copy) {
@@ -454,7 +468,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 				 */
 				spin_unlock_bh(&vvs->rx_lock);
 
-				err = memcpy_to_msg(msg, pkt->buf, bytes_to_copy);
+				err = memcpy_to_msg(msg, skb->data, bytes_to_copy);
 				if (err) {
 					/* Copy of message failed. Rest of
 					 * fragments will be freed without copy.
@@ -462,6 +476,7 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 					dequeued_len = err;
 				} else {
 					user_buf_len -= bytes_to_copy;
+					skb_pull(skb, bytes_to_copy);
 				}
 
 				spin_lock_bh(&vvs->rx_lock);
@@ -471,17 +486,16 @@ static int virtio_transport_seqpacket_do_dequeue(struct vsock_sock *vsk,
 				dequeued_len += pkt_len;
 		}
 
-		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM) {
+		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM) {
 			msg_ready = true;
 			vvs->msg_count--;
 
-			if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOR)
+			if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOR)
 				msg->msg_flags |= MSG_EOR;
 		}
 
-		virtio_transport_dec_rx_pkt(vvs, pkt);
-		list_del(&pkt->list);
-		virtio_transport_free_pkt(pkt);
+		virtio_transport_dec_rx_pkt(vvs, skb);
+		kfree_skb(skb);
 	}
 
 	spin_unlock_bh(&vvs->rx_lock);
@@ -619,7 +633,7 @@ int virtio_transport_do_socket_init(struct vsock_sock *vsk,
 
 	spin_lock_init(&vvs->rx_lock);
 	spin_lock_init(&vvs->tx_lock);
-	INIT_LIST_HEAD(&vvs->rx_queue);
+	skb_queue_head_init(&vvs->rx_queue);
 
 	return 0;
 }
@@ -822,16 +836,16 @@ void virtio_transport_destruct(struct vsock_sock *vsk)
 EXPORT_SYMBOL_GPL(virtio_transport_destruct);
 
 static int virtio_transport_reset(struct vsock_sock *vsk,
-				  struct virtio_vsock_pkt *pkt)
+				  struct sk_buff *skb)
 {
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_RST,
-		.reply = !!pkt,
+		.reply = !!skb,
 		.vsk = vsk,
 	};
 
 	/* Send RST only if the original pkt is not a RST pkt */
-	if (pkt && le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_RST)
+	if (skb && le16_to_cpu(virtio_vsock_hdr(skb)->op) == VIRTIO_VSOCK_OP_RST)
 		return 0;
 
 	return virtio_transport_send_pkt_info(vsk, &info);
@@ -841,29 +855,30 @@ static int virtio_transport_reset(struct vsock_sock *vsk,
  * attempt was made to connect to a socket that does not exist.
  */
 static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
-					  struct virtio_vsock_pkt *pkt)
+					  struct sk_buff *skb)
 {
-	struct virtio_vsock_pkt *reply;
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_RST,
-		.type = le16_to_cpu(pkt->hdr.type),
+		.type = le16_to_cpu(hdr->type),
 		.reply = true,
 	};
+	struct sk_buff *reply;
 
 	/* Send RST only if the original pkt is not a RST pkt */
-	if (le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_RST)
+	if (le16_to_cpu(hdr->op) == VIRTIO_VSOCK_OP_RST)
 		return 0;
 
-	reply = virtio_transport_alloc_pkt(&info, 0,
-					   le64_to_cpu(pkt->hdr.dst_cid),
-					   le32_to_cpu(pkt->hdr.dst_port),
-					   le64_to_cpu(pkt->hdr.src_cid),
-					   le32_to_cpu(pkt->hdr.src_port));
+	reply = virtio_transport_alloc_skb(&info, 0,
+					   le64_to_cpu(hdr->dst_cid),
+					   le32_to_cpu(hdr->dst_port),
+					   le64_to_cpu(hdr->src_cid),
+					   le32_to_cpu(hdr->src_port));
 	if (!reply)
 		return -ENOMEM;
 
 	if (!t) {
-		virtio_transport_free_pkt(reply);
+		kfree_skb(reply);
 		return -ENOTCONN;
 	}
 
@@ -874,16 +889,11 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
 static void virtio_transport_remove_sock(struct vsock_sock *vsk)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
-	struct virtio_vsock_pkt *pkt, *tmp;
 
 	/* We don't need to take rx_lock, as the socket is closing and we are
 	 * removing it.
 	 */
-	list_for_each_entry_safe(pkt, tmp, &vvs->rx_queue, list) {
-		list_del(&pkt->list);
-		virtio_transport_free_pkt(pkt);
-	}
-
+	__skb_queue_purge(&vvs->rx_queue);
 	vsock_remove_sock(vsk);
 }
 
@@ -1005,13 +1015,14 @@ EXPORT_SYMBOL_GPL(virtio_transport_release);
 
 static int
 virtio_transport_recv_connecting(struct sock *sk,
-				 struct virtio_vsock_pkt *pkt)
+				 struct sk_buff *skb)
 {
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
-	int err;
 	int skerr;
+	int err;
 
-	switch (le16_to_cpu(pkt->hdr.op)) {
+	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RESPONSE:
 		sk->sk_state = TCP_ESTABLISHED;
 		sk->sk_socket->state = SS_CONNECTED;
@@ -1032,7 +1043,7 @@ virtio_transport_recv_connecting(struct sock *sk,
 	return 0;
 
 destroy:
-	virtio_transport_reset(vsk, pkt);
+	virtio_transport_reset(vsk, skb);
 	sk->sk_state = TCP_CLOSE;
 	sk->sk_err = skerr;
 	sk_error_report(sk);
@@ -1041,34 +1052,37 @@ virtio_transport_recv_connecting(struct sock *sk,
 
 static void
 virtio_transport_recv_enqueue(struct vsock_sock *vsk,
-			      struct virtio_vsock_pkt *pkt)
+			      struct sk_buff *skb)
 {
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	bool can_enqueue, free_pkt = false;
+	struct virtio_vsock_hdr *hdr;
+	u32 len;
 
-	pkt->len = le32_to_cpu(pkt->hdr.len);
-	pkt->off = 0;
+	hdr = virtio_vsock_hdr(skb);
+	len = le32_to_cpu(hdr->len);
 
 	spin_lock_bh(&vvs->rx_lock);
 
-	can_enqueue = virtio_transport_inc_rx_pkt(vvs, pkt);
+	can_enqueue = virtio_transport_inc_rx_pkt(vvs, skb);
 	if (!can_enqueue) {
 		free_pkt = true;
 		goto out;
 	}
 
-	if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM)
+	if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)
 		vvs->msg_count++;
 
 	/* Try to copy small packets into the buffer of last packet queued,
 	 * to avoid wasting memory queueing the entire buffer with a small
 	 * payload.
 	 */
-	if (pkt->len <= GOOD_COPY_LEN && !list_empty(&vvs->rx_queue)) {
-		struct virtio_vsock_pkt *last_pkt;
+	if (len <= GOOD_COPY_LEN && !skb_queue_empty(&vvs->rx_queue)) {
+		struct virtio_vsock_hdr *last_hdr;
+		struct sk_buff *last_skb;
 
-		last_pkt = list_last_entry(&vvs->rx_queue,
-					   struct virtio_vsock_pkt, list);
+		last_skb = skb_peek_tail(&vvs->rx_queue);
+		last_hdr = virtio_vsock_hdr(last_skb);
 
 		/* If there is space in the last packet queued, we copy the
 		 * new packet in its buffer. We avoid this if the last packet
@@ -1076,35 +1090,35 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 		 * delimiter of SEQPACKET message, so 'pkt' is the first packet
 		 * of a new message.
 		 */
-		if ((pkt->len <= last_pkt->buf_len - last_pkt->len) &&
-		    !(le32_to_cpu(last_pkt->hdr.flags) & VIRTIO_VSOCK_SEQ_EOM)) {
-			memcpy(last_pkt->buf + last_pkt->len, pkt->buf,
-			       pkt->len);
-			last_pkt->len += pkt->len;
+		if (skb->len < skb_tailroom(last_skb) &&
+		    !(le32_to_cpu(last_hdr->flags) & VIRTIO_VSOCK_SEQ_EOM)) {
+			memcpy(skb_put(last_skb, skb->len), skb->data, skb->len);
 			free_pkt = true;
-			last_pkt->hdr.flags |= pkt->hdr.flags;
+			last_hdr->flags |= hdr->flags;
+			last_hdr->len = cpu_to_le32(last_skb->len);
 			goto out;
 		}
 	}
 
-	list_add_tail(&pkt->list, &vvs->rx_queue);
+	__skb_queue_tail(&vvs->rx_queue, skb);
 
 out:
 	spin_unlock_bh(&vvs->rx_lock);
 	if (free_pkt)
-		virtio_transport_free_pkt(pkt);
+		kfree_skb(skb);
 }
 
 static int
 virtio_transport_recv_connected(struct sock *sk,
-				struct virtio_vsock_pkt *pkt)
+				struct sk_buff *skb)
 {
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
 	int err = 0;
 
-	switch (le16_to_cpu(pkt->hdr.op)) {
+	switch (le16_to_cpu(hdr->op)) {
 	case VIRTIO_VSOCK_OP_RW:
-		virtio_transport_recv_enqueue(vsk, pkt);
+		virtio_transport_recv_enqueue(vsk, skb);
 		sk->sk_data_ready(sk);
 		return err;
 	case VIRTIO_VSOCK_OP_CREDIT_REQUEST:
@@ -1114,18 +1128,17 @@ virtio_transport_recv_connected(struct sock *sk,
 		sk->sk_write_space(sk);
 		break;
 	case VIRTIO_VSOCK_OP_SHUTDOWN:
-		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SHUTDOWN_RCV)
+		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_RCV)
 			vsk->peer_shutdown |= RCV_SHUTDOWN;
-		if (le32_to_cpu(pkt->hdr.flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
+		if (le32_to_cpu(hdr->flags) & VIRTIO_VSOCK_SHUTDOWN_SEND)
 			vsk->peer_shutdown |= SEND_SHUTDOWN;
 		if (vsk->peer_shutdown == SHUTDOWN_MASK &&
 		    vsock_stream_has_data(vsk) <= 0 &&
 		    !sock_flag(sk, SOCK_DONE)) {
 			(void)virtio_transport_reset(vsk, NULL);
-
 			virtio_transport_do_close(vsk, true);
 		}
-		if (le32_to_cpu(pkt->hdr.flags))
+		if (le32_to_cpu(virtio_vsock_hdr(skb)->flags))
 			sk->sk_state_change(sk);
 		break;
 	case VIRTIO_VSOCK_OP_RST:
@@ -1136,28 +1149,30 @@ virtio_transport_recv_connected(struct sock *sk,
 		break;
 	}
 
-	virtio_transport_free_pkt(pkt);
+	kfree_skb(skb);
 	return err;
 }
 
 static void
 virtio_transport_recv_disconnecting(struct sock *sk,
-				    struct virtio_vsock_pkt *pkt)
+				    struct sk_buff *skb)
 {
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
 
-	if (le16_to_cpu(pkt->hdr.op) == VIRTIO_VSOCK_OP_RST)
+	if (le16_to_cpu(hdr->op) == VIRTIO_VSOCK_OP_RST)
 		virtio_transport_do_close(vsk, true);
 }
 
 static int
 virtio_transport_send_response(struct vsock_sock *vsk,
-			       struct virtio_vsock_pkt *pkt)
+			       struct sk_buff *skb)
 {
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct virtio_vsock_pkt_info info = {
 		.op = VIRTIO_VSOCK_OP_RESPONSE,
-		.remote_cid = le64_to_cpu(pkt->hdr.src_cid),
-		.remote_port = le32_to_cpu(pkt->hdr.src_port),
+		.remote_cid = le64_to_cpu(hdr->src_cid),
+		.remote_port = le32_to_cpu(hdr->src_port),
 		.reply = true,
 		.vsk = vsk,
 	};
@@ -1166,8 +1181,9 @@ virtio_transport_send_response(struct vsock_sock *vsk,
 }
 
 static bool virtio_transport_space_update(struct sock *sk,
-					  struct virtio_vsock_pkt *pkt)
+					  struct sk_buff *skb)
 {
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
 	struct virtio_vsock_sock *vvs = vsk->trans;
 	bool space_available;
@@ -1182,8 +1198,8 @@ static bool virtio_transport_space_update(struct sock *sk,
 
 	/* buf_alloc and fwd_cnt is always included in the hdr */
 	spin_lock_bh(&vvs->tx_lock);
-	vvs->peer_buf_alloc = le32_to_cpu(pkt->hdr.buf_alloc);
-	vvs->peer_fwd_cnt = le32_to_cpu(pkt->hdr.fwd_cnt);
+	vvs->peer_buf_alloc = le32_to_cpu(hdr->buf_alloc);
+	vvs->peer_fwd_cnt = le32_to_cpu(hdr->fwd_cnt);
 	space_available = virtio_transport_has_space(vsk);
 	spin_unlock_bh(&vvs->tx_lock);
 	return space_available;
@@ -1191,21 +1207,22 @@ static bool virtio_transport_space_update(struct sock *sk,
 
 /* Handle server socket */
 static int
-virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
+virtio_transport_recv_listen(struct sock *sk, struct sk_buff *skb,
 			     struct virtio_transport *t)
 {
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct vsock_sock *vsk = vsock_sk(sk);
 	struct vsock_sock *vchild;
 	struct sock *child;
 	int ret;
 
-	if (le16_to_cpu(pkt->hdr.op) != VIRTIO_VSOCK_OP_REQUEST) {
-		virtio_transport_reset_no_sock(t, pkt);
+	if (le16_to_cpu(hdr->op) != VIRTIO_VSOCK_OP_REQUEST) {
+		virtio_transport_reset_no_sock(t, skb);
 		return -EINVAL;
 	}
 
 	if (sk_acceptq_is_full(sk)) {
-		virtio_transport_reset_no_sock(t, pkt);
+		virtio_transport_reset_no_sock(t, skb);
 		return -ENOMEM;
 	}
 
@@ -1213,13 +1230,13 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 	 * Subsequent enqueues would lead to a memory leak.
 	 */
 	if (sk->sk_shutdown == SHUTDOWN_MASK) {
-		virtio_transport_reset_no_sock(t, pkt);
+		virtio_transport_reset_no_sock(t, skb);
 		return -ESHUTDOWN;
 	}
 
 	child = vsock_create_connected(sk);
 	if (!child) {
-		virtio_transport_reset_no_sock(t, pkt);
+		virtio_transport_reset_no_sock(t, skb);
 		return -ENOMEM;
 	}
 
@@ -1230,10 +1247,10 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 	child->sk_state = TCP_ESTABLISHED;
 
 	vchild = vsock_sk(child);
-	vsock_addr_init(&vchild->local_addr, le64_to_cpu(pkt->hdr.dst_cid),
-			le32_to_cpu(pkt->hdr.dst_port));
-	vsock_addr_init(&vchild->remote_addr, le64_to_cpu(pkt->hdr.src_cid),
-			le32_to_cpu(pkt->hdr.src_port));
+	vsock_addr_init(&vchild->local_addr, le64_to_cpu(hdr->dst_cid),
+			le32_to_cpu(hdr->dst_port));
+	vsock_addr_init(&vchild->remote_addr, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
 
 	ret = vsock_assign_transport(vchild, vsk);
 	/* Transport assigned (looking at remote_addr) must be the same
@@ -1241,17 +1258,17 @@ virtio_transport_recv_listen(struct sock *sk, struct virtio_vsock_pkt *pkt,
 	 */
 	if (ret || vchild->transport != &t->transport) {
 		release_sock(child);
-		virtio_transport_reset_no_sock(t, pkt);
+		virtio_transport_reset_no_sock(t, skb);
 		sock_put(child);
 		return ret;
 	}
 
-	if (virtio_transport_space_update(child, pkt))
+	if (virtio_transport_space_update(child, skb))
 		child->sk_write_space(child);
 
 	vsock_insert_connected(vchild);
 	vsock_enqueue_accept(sk, child);
-	virtio_transport_send_response(vchild, pkt);
+	virtio_transport_send_response(vchild, skb);
 
 	release_sock(child);
 
@@ -1269,29 +1286,30 @@ static bool virtio_transport_valid_type(u16 type)
  * lock.
  */
 void virtio_transport_recv_pkt(struct virtio_transport *t,
-			       struct virtio_vsock_pkt *pkt)
+			       struct sk_buff *skb)
 {
+	struct virtio_vsock_hdr *hdr = virtio_vsock_hdr(skb);
 	struct sockaddr_vm src, dst;
 	struct vsock_sock *vsk;
 	struct sock *sk;
 	bool space_available;
 
-	vsock_addr_init(&src, le64_to_cpu(pkt->hdr.src_cid),
-			le32_to_cpu(pkt->hdr.src_port));
-	vsock_addr_init(&dst, le64_to_cpu(pkt->hdr.dst_cid),
-			le32_to_cpu(pkt->hdr.dst_port));
+	vsock_addr_init(&src, le64_to_cpu(hdr->src_cid),
+			le32_to_cpu(hdr->src_port));
+	vsock_addr_init(&dst, le64_to_cpu(hdr->dst_cid),
+			le32_to_cpu(hdr->dst_port));
 
 	trace_virtio_transport_recv_pkt(src.svm_cid, src.svm_port,
 					dst.svm_cid, dst.svm_port,
-					le32_to_cpu(pkt->hdr.len),
-					le16_to_cpu(pkt->hdr.type),
-					le16_to_cpu(pkt->hdr.op),
-					le32_to_cpu(pkt->hdr.flags),
-					le32_to_cpu(pkt->hdr.buf_alloc),
-					le32_to_cpu(pkt->hdr.fwd_cnt));
-
-	if (!virtio_transport_valid_type(le16_to_cpu(pkt->hdr.type))) {
-		(void)virtio_transport_reset_no_sock(t, pkt);
+					le32_to_cpu(hdr->len),
+					le16_to_cpu(hdr->type),
+					le16_to_cpu(hdr->op),
+					le32_to_cpu(hdr->flags),
+					le32_to_cpu(hdr->buf_alloc),
+					le32_to_cpu(hdr->fwd_cnt));
+
+	if (!virtio_transport_valid_type(le16_to_cpu(hdr->type))) {
+		(void)virtio_transport_reset_no_sock(t, skb);
 		goto free_pkt;
 	}
 
@@ -1302,13 +1320,13 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	if (!sk) {
 		sk = vsock_find_bound_socket(&dst);
 		if (!sk) {
-			(void)virtio_transport_reset_no_sock(t, pkt);
+			(void)virtio_transport_reset_no_sock(t, skb);
 			goto free_pkt;
 		}
 	}
 
-	if (virtio_transport_get_type(sk) != le16_to_cpu(pkt->hdr.type)) {
-		(void)virtio_transport_reset_no_sock(t, pkt);
+	if (virtio_transport_get_type(sk) != le16_to_cpu(hdr->type)) {
+		(void)virtio_transport_reset_no_sock(t, skb);
 		sock_put(sk);
 		goto free_pkt;
 	}
@@ -1322,13 +1340,13 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	 */
 	if (sock_flag(sk, SOCK_DONE) ||
 	    (sk->sk_state != TCP_LISTEN && vsk->transport != &t->transport)) {
-		(void)virtio_transport_reset_no_sock(t, pkt);
+		(void)virtio_transport_reset_no_sock(t, skb);
 		release_sock(sk);
 		sock_put(sk);
 		goto free_pkt;
 	}
 
-	space_available = virtio_transport_space_update(sk, pkt);
+	space_available = virtio_transport_space_update(sk, skb);
 
 	/* Update CID in case it has changed after a transport reset event */
 	if (vsk->local_addr.svm_cid != VMADDR_CID_ANY)
@@ -1339,23 +1357,23 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 
 	switch (sk->sk_state) {
 	case TCP_LISTEN:
-		virtio_transport_recv_listen(sk, pkt, t);
-		virtio_transport_free_pkt(pkt);
+		virtio_transport_recv_listen(sk, skb, t);
+		kfree_skb(skb);
 		break;
 	case TCP_SYN_SENT:
-		virtio_transport_recv_connecting(sk, pkt);
-		virtio_transport_free_pkt(pkt);
+		virtio_transport_recv_connecting(sk, skb);
+		kfree_skb(skb);
 		break;
 	case TCP_ESTABLISHED:
-		virtio_transport_recv_connected(sk, pkt);
+		virtio_transport_recv_connected(sk, skb);
 		break;
 	case TCP_CLOSING:
-		virtio_transport_recv_disconnecting(sk, pkt);
-		virtio_transport_free_pkt(pkt);
+		virtio_transport_recv_disconnecting(sk, skb);
+		kfree_skb(skb);
 		break;
 	default:
-		(void)virtio_transport_reset_no_sock(t, pkt);
-		virtio_transport_free_pkt(pkt);
+		(void)virtio_transport_reset_no_sock(t, skb);
+		kfree_skb(skb);
 		break;
 	}
 
@@ -1368,16 +1386,42 @@ void virtio_transport_recv_pkt(struct virtio_transport *t,
 	return;
 
 free_pkt:
-	virtio_transport_free_pkt(pkt);
+	kfree_skb(skb);
 }
 EXPORT_SYMBOL_GPL(virtio_transport_recv_pkt);
 
-void virtio_transport_free_pkt(struct virtio_vsock_pkt *pkt)
+/* Remove skbs found in a queue that have a vsk that matches.
+ *
+ * Each skb is freed.
+ *
+ * Returns the count of skbs that were reply packets.
+ */
+int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *queue)
 {
-	kvfree(pkt->buf);
-	kfree(pkt);
+	struct sk_buff_head freeme;
+	struct sk_buff *skb, *tmp;
+	int cnt = 0;
+
+	skb_queue_head_init(&freeme);
+
+	spin_lock_bh(&queue->lock);
+	skb_queue_walk_safe(queue, skb, tmp) {
+		if (vsock_sk(skb->sk) != vsk)
+			continue;
+
+		__skb_unlink(skb, queue);
+		__skb_queue_tail(&freeme, skb);
+
+		if (virtio_vsock_skb_reply(skb))
+			cnt++;
+	}
+	spin_unlock_bh(&queue->lock);
+
+	__skb_queue_purge(&freeme);
+
+	return cnt;
 }
-EXPORT_SYMBOL_GPL(virtio_transport_free_pkt);
+EXPORT_SYMBOL_GPL(virtio_transport_purge_skbs);
 
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Asias He");
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 169a8cf65b390..671e03240fc52 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -16,7 +16,7 @@ struct vsock_loopback {
 	struct workqueue_struct *workqueue;
 
 	spinlock_t pkt_list_lock; /* protects pkt_list */
-	struct list_head pkt_list;
+	struct sk_buff_head pkt_queue;
 	struct work_struct pkt_work;
 };
 
@@ -27,13 +27,13 @@ static u32 vsock_loopback_get_local_cid(void)
 	return VMADDR_CID_LOCAL;
 }
 
-static int vsock_loopback_send_pkt(struct virtio_vsock_pkt *pkt)
+static int vsock_loopback_send_pkt(struct sk_buff *skb)
 {
 	struct vsock_loopback *vsock = &the_vsock_loopback;
-	int len = pkt->len;
+	int len = skb->len;
 
 	spin_lock_bh(&vsock->pkt_list_lock);
-	list_add_tail(&pkt->list, &vsock->pkt_list);
+	skb_queue_tail(&vsock->pkt_queue, skb);
 	spin_unlock_bh(&vsock->pkt_list_lock);
 
 	queue_work(vsock->workqueue, &vsock->pkt_work);
@@ -44,21 +44,8 @@ static int vsock_loopback_send_pkt(struct virtio_vsock_pkt *pkt)
 static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
 {
 	struct vsock_loopback *vsock = &the_vsock_loopback;
-	struct virtio_vsock_pkt *pkt, *n;
-	LIST_HEAD(freeme);
 
-	spin_lock_bh(&vsock->pkt_list_lock);
-	list_for_each_entry_safe(pkt, n, &vsock->pkt_list, list) {
-		if (pkt->vsk != vsk)
-			continue;
-		list_move(&pkt->list, &freeme);
-	}
-	spin_unlock_bh(&vsock->pkt_list_lock);
-
-	list_for_each_entry_safe(pkt, n, &freeme, list) {
-		list_del(&pkt->list);
-		virtio_transport_free_pkt(pkt);
-	}
+	virtio_transport_purge_skbs(vsk, &vsock->pkt_queue);
 
 	return 0;
 }
@@ -121,20 +108,18 @@ static void vsock_loopback_work(struct work_struct *work)
 {
 	struct vsock_loopback *vsock =
 		container_of(work, struct vsock_loopback, pkt_work);
-	LIST_HEAD(pkts);
+	struct sk_buff_head pkts;
+	struct sk_buff *skb;
+
+	skb_queue_head_init(&pkts);
 
 	spin_lock_bh(&vsock->pkt_list_lock);
-	list_splice_init(&vsock->pkt_list, &pkts);
+	skb_queue_splice_init(&vsock->pkt_queue, &pkts);
 	spin_unlock_bh(&vsock->pkt_list_lock);
 
-	while (!list_empty(&pkts)) {
-		struct virtio_vsock_pkt *pkt;
-
-		pkt = list_first_entry(&pkts, struct virtio_vsock_pkt, list);
-		list_del_init(&pkt->list);
-
-		virtio_transport_deliver_tap_pkt(pkt);
-		virtio_transport_recv_pkt(&loopback_transport, pkt);
+	while ((skb = __skb_dequeue(&pkts))) {
+		virtio_transport_deliver_tap_pkt(skb);
+		virtio_transport_recv_pkt(&loopback_transport, skb);
 	}
 }
 
@@ -148,7 +133,7 @@ static int __init vsock_loopback_init(void)
 		return -ENOMEM;
 
 	spin_lock_init(&vsock->pkt_list_lock);
-	INIT_LIST_HEAD(&vsock->pkt_list);
+	skb_queue_head_init(&vsock->pkt_queue);
 	INIT_WORK(&vsock->pkt_work, vsock_loopback_work);
 
 	ret = vsock_core_register(&loopback_transport.transport,
@@ -166,19 +151,13 @@ static int __init vsock_loopback_init(void)
 static void __exit vsock_loopback_exit(void)
 {
 	struct vsock_loopback *vsock = &the_vsock_loopback;
-	struct virtio_vsock_pkt *pkt;
 
 	vsock_core_unregister(&loopback_transport.transport);
 
 	flush_work(&vsock->pkt_work);
 
 	spin_lock_bh(&vsock->pkt_list_lock);
-	while (!list_empty(&vsock->pkt_list)) {
-		pkt = list_first_entry(&vsock->pkt_list,
-				       struct virtio_vsock_pkt, list);
-		list_del(&pkt->list);
-		virtio_transport_free_pkt(pkt);
-	}
+	virtio_vsock_skb_queue_purge(&vsock->pkt_queue);
 	spin_unlock_bh(&vsock->pkt_list_lock);
 
 	destroy_workqueue(vsock->workqueue);
-- 
2.53.0

