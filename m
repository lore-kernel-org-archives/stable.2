Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3B53033E8
	for <stable@vger.kernel.org>; Sat, 30 May 2026 14:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780150771; cv=none; b=jU7N1NFZpu4twec7CgdyVzDQg4rY/thcZbJ550avJR5TPUpS0boNU8nviGg/kbnwNKHs4q+wixY/1GD2hmwF3McwZPoBtqMqhdgjk9X2u0/EJjdRRCVuaDX1amkcKcH5jCY/peDaNTi5pR/0E1y3g7HjVPv2SZFZl46ncy6R/70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780150771; c=relaxed/simple;
	bh=I9KB3Ix8W/5YFd70VX18aXDnZLwYVuvH0uI0skQuE9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJ4lIe+aohy5BY+YZ5M+z08QG5yhUi/2jWo7AGTLqhXEhZl9dVAQH0n0781R8RzttISaq6Hqxmx9DzImarw40AlWEEVQnurzeksKZcj8brQrb7l/YhQnReXApzvCoc0Gw2zMP4xbnVtLcOBGNm5jk2NN1vdOc5gGD8HJH88vdoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZMC98Bjx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZMC98Bjx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E27D1F00898;
	Sat, 30 May 2026 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780150770;
	bh=PnZu+qz5uxmLVWToi80cgAonBxeML4FZbTBJRb3obo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZMC98BjxIN/DR/nnF2O4Tsb57if8rEyb5UGPFa4zrpkkx3OkeoliUG3Dj0URvphWm
	 g1uDf6kS/W6mwcOK0Ng6MML3RJy4ihkJZx04Xx+EnuHj9Jf/DoioCk5SFSqT+2iJcU
	 wdDSt1Wntz02fbLMlBEh0LV1DTT4mC1Tv6aM8sUeBab0WNxQHT15rgc6kBY1FwGBPW
	 gJTj9jSB/fr7YfnkoIscqCvRzn8jBknI4eg3853DiU/pfl4Ylgg7/jvjBG0Z80HLom
	 X0v4BgXJ5FGWaWJG0MQ2k+Yst9yalRi2yd8cDsYbFPdl34pjTOmHk+Zq/Mkrnf8Xq5
	 yXhknGhvrJ6GQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arseniy Krasnov <avkrasnov@sberdevices.ru>,
	Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>,
	"David S. Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/4] virtio/vsock: don't use skbuff state to account credit
Date: Sat, 30 May 2026 10:19:25 -0400
Message-ID: <20260530141926.2406669-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530141926.2406669-1-sashal@kernel.org>
References: <2026052842-catering-overfeed-07a0@gregkh>
 <20260530141926.2406669-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arseniy Krasnov <avkrasnov@sberdevices.ru>

[ Upstream commit 077706165717686a2a6a71405fef036cd5b37ae0 ]

'skb->len' can vary when we partially read the data, this complicates the
calculation of credit to be updated in 'virtio_transport_inc_rx_pkt()/
virtio_transport_dec_rx_pkt()'.

Also in 'virtio_transport_dec_rx_pkt()' we were miscalculating the
credit since 'skb->len' was redundant.

For these reasons, let's replace the use of skbuff state to calculate new
'rx_bytes'/'fwd_cnt' values with explicit value as input argument. This
makes code more simple, because it is not needed to change skbuff state
before each call to update 'rx_bytes'/'fwd_cnt'.

Fixes: 71dc9ec9ac7d ("virtio/vsock: replace virtio_vsock_pkt with sk_buff")
Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Stable-dep-of: a4f0b001782b ("vsock/virtio: reset connection on receiving queue overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport_common.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 96476230c29b7..52a8a7ffacf5c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -226,21 +226,18 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
 }
 
 static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
-					struct sk_buff *skb)
+					u32 len)
 {
-	if (vvs->rx_bytes + skb->len > vvs->buf_alloc)
+	if (vvs->rx_bytes + len > vvs->buf_alloc)
 		return false;
 
-	vvs->rx_bytes += skb->len;
+	vvs->rx_bytes += len;
 	return true;
 }
 
 static void virtio_transport_dec_rx_pkt(struct virtio_vsock_sock *vvs,
-					struct sk_buff *skb)
+					u32 len)
 {
-	int len;
-
-	len = skb_headroom(skb) - sizeof(struct virtio_vsock_hdr) - skb->len;
 	vvs->rx_bytes -= len;
 	vvs->fwd_cnt += len;
 }
@@ -378,7 +375,9 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
 		skb_pull(skb, bytes);
 
 		if (skb->len == 0) {
-			virtio_transport_dec_rx_pkt(vvs, skb);
+			u32 pkt_len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
+
+			virtio_transport_dec_rx_pkt(vvs, pkt_len);
 			consume_skb(skb);
 		} else {
 			__skb_queue_head(&vvs->rx_queue, skb);
@@ -935,7 +934,7 @@ virtio_transport_recv_enqueue(struct vsock_sock *vsk,
 
 	spin_lock_bh(&vvs->rx_lock);
 
-	can_enqueue = virtio_transport_inc_rx_pkt(vvs, skb);
+	can_enqueue = virtio_transport_inc_rx_pkt(vvs, len);
 	if (!can_enqueue) {
 		free_pkt = true;
 		goto out;
-- 
2.53.0

