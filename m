Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702105;
	b=ZVwSOF4cTGum8e48RYCRA00qMoEZyoOoG3U3kaTRFjo5rv2G/z5if7W5VxLBEEj7hC4C
	 +N3rgzjCQmYn99BWrH2rctOZG6wPZexTJORCeZNQn5bCZKMmaG5txMprpdEDvVKEuViJU
	 ilL7RizRa2fyohTrP7NX5vzTatihVlFeOBeSE+FwDmq9MPa/7S1xmu3uhRyq2/+8TyvKK
	 kjtEy06+Z4eRoKCz9Y+A2/y70qh6GKLWbgPVhZcnNBbNJfvxK3qmI9080wR0qs71SUODG
	 0T7k8LcqgRu5zMfw0YFTAfGdUOONBbywUQMxjGO0d1NYKUVpEEoi8sPlNv8LOghO2yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702105;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9Rfc6EWNAUE+Box8JThlJy486Viui4E/MQlJqsiGxD8=;
	b=LOYiKh4KUFPUJbx4r6B15O9ysTgbRwV04aNKJlpuY++85QtHmf+shBQg58USCNG3C+Cv
	 C+LWzcec3qEhva0xOpY+gOG69tSW8XIpPH1rjbE90A8RuYdL1MPRgMZn43+jdgY8YE+oX
	 ySXLwOH5+ZUhR7UfSfIBbv0XkAaf7I6IMPIzBUjYHwhakMF07eponL4MT4FHpKQB16tSW
	 5orsMJMS111Ae5XnD5WjMd62a/6fw40gufiBcrZWReGPR0Mic5YQ6mXcg9/E19g81JIlY
	 9TWJO7T4Q+u+/tvw/zq5lhnczpkGj3ESJvGeQVrEPcJXTNN3HUyjHr8boJiK13jkR0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDhHBETA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34150606A329
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDhHBETA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343111F000C4;
	Sun, 15 Nov 2026 00:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702104;
	bh=9Rfc6EWNAUE+Box8JThlJy486Viui4E/MQlJqsiGxD8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iDhHBETA9wF2Xu463mKDAERteFgqKNCLSG55+PIICIbQP+kaUn2gezxmNv5sSPGU7
	 D52EMG640ggOA7Qwj3fpiOOXV/s+WOAo+ZzX2o2R8NuWC26MQfkEvgGe6Sa0uGGClN
	 qlW/xmZSOtYWnd2EsGcs2NdHPp21WNP6l38yAI0jqb/WBsVWLelUBfXDgwrjgzverj
	 d9Vi87PRNIaNDCcsGbfXwZcpYz0ypQ8vVXkrlTST/nyLCo3rO+QDb9mmhr8ZwJwBdD
	 6EoGEppTpsEYX1wOs6d7s0EaEg0oFo+rQbwn8a5nTCQnOnKPiqwJpgNkbrzzY5XohD
	 g+FfHdNJIuISw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daehyeon Ko <4ncienth@gmail.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] vhost/vsock: size receive SKBs from declared payload
Date: Sat, 14 Nov 2026 19:21:41 -0500
Message-ID: <20261115002130.534693-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115002130.534693-1-sashal@kernel.org>
References: <20261109201414-failed-6.6-d5e912448cd9@kernel.org>
 <20261115002130.534693-1-sashal@kernel.org>
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
index f197f0c28022e..b67ccae915464 100644
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

