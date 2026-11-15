Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702610;
	b=PfV1s7RzNwD9UqpUh5Mc3ZW4AluJo8cTNjcRn5oTsjVw7Jk/7TG+8pkhRk7VTSjYqTL9
	 0oxloTpBcWCM9BR8LRjuQ07EmUUc4DiJ+mJ3DD57KwUzIlD2nhG2LCh5A5Nnqac6w8MN3
	 qR1z24sU8OJ7kO8GGpF0ptgmmNwW8gjMhWOyBeC3Uh/P5wHEYFqry1ZfVsVamJCRBorVN
	 tUo/5PG3fCehB4LWxs8y5/yfvG+OTJysmK/aWSacWpWN4pobBb/rEU6xSYD8oRzID3xhR
	 s+6/Jv7SE5n7t6rBSv7xtaMZIl33k7ltKne7BVjKN5gnQYfy3ken6+22hHlV6syfaLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702610;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=y9OshcKk1ui2/83mlfzbFc6+u0LBvp446Nfr7oGYHes=;
	b=O524HxOQ5ECWM8uyiwybwwQQfe+1iufwPtXQqQiaQuwlRGkNRTVpfkwtXMgrAwO9yG+R
	 mlo4yBUeNkAtYr8EtYlGUCehTS7toXLZGAUepZ7OERn+YAtvk0MGv8Kf1a8Q2jm7jj3bn
	 6wVnWjMUS4F+97mTOKuLMoEe68DtT6v6zGTOdQKx/3D4PJbcjGVLRA81/yPlLAfQwF7wW
	 M4+S2sLzOR4nEgGM0dG0m0zGOpMkArIHputM/Ey8UI4Pms3sXKH/sjuV8orAQemMoJ5bM
	 hZKu5v+7Z33M1Q179jirfWmPpvb3a8+cv80PcEacI75LONJhlCrTg3MmM5rD/muK3RQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhDxuGAV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41619606A32C
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mhDxuGAV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E691F000C6;
	Sun, 15 Nov 2026 00:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702610;
	bh=y9OshcKk1ui2/83mlfzbFc6+u0LBvp446Nfr7oGYHes=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mhDxuGAVEchx4WIpyaA4BR140Dmjr7n3ys5oQx3deU5Bz47IGfXpJRW6akJGIp23S
	 Rl5A31bsszQjAAcg32TcOhoDHj/3R/mkwsscrOMEKSrieFWM8Yzt+e3xaz4HnF20YE
	 osd58TCg/ZuodM07Dd7QxKV7fzyxX6UFzQ4+HLWHaO/njE25mn4JtCNywuaGuNhkAB
	 bVe+0PYF6F8w59iXt1X9HFWxcRfRmuTKHzko6m0DvFYz7oRM8kgRl7K1/PcENP9YsZ
	 nH/h1Sy6OInGCLLOEGHgF0qOKAgpYiCKSLi9filFOGeMfgpDwbqIZf0/w45NdjYxPq
	 nLCExx027WeFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
Date: Sat, 14 Nov 2026 19:30:06 -0500
Message-ID: <20261115002958.559603-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201916-failed-6.1-d5e912448cd9@kernel.org>
References: <20261109201916-failed-6.1-d5e912448cd9@kernel.org>
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

From: Will Deacon <will@kernel.org>

[ Upstream commit 87dbae5e36613a6020f3d64a2eaeac0a1e0e6dc6 ]

virtio_vsock_skb_rx_put() only calls skb_put() if the length in the
packet header is not zero even though skb_put() handles this case
gracefully.

Remove the functionally redundant check from virtio_vsock_skb_rx_put()
and, on the assumption that this is a worthwhile optimisation for
handling credit messages, augment the existing length checks in
virtio_transport_rx_work() to elide the call for zero-length payloads.
Since the callers all have the length, extend virtio_vsock_skb_rx_put()
to take it as an additional parameter rather than fish it back out of
the packet header.

Note that the vhost code already has similar logic in
vhost_vsock_alloc_skb().

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
Message-Id: <20250717090116.11987-4-will@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: d5e912448cd9 ("vhost/vsock: size receive SKBs from declared payload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c            | 2 +-
 include/linux/virtio_vsock.h     | 9 ++-------
 net/vmw_vsock/virtio_transport.c | 4 +++-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index 48002df5ef736..c08eb6774c427 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -372,7 +372,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 	}
 
-	virtio_vsock_skb_rx_put(skb);
+	virtio_vsock_skb_rx_put(skb, payload_len);
 
 	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
 	if (nbytes != payload_len) {
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 689e9fc50e1b8..3b97af88edbca 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -46,14 +46,9 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
 }
 
-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb)
+static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
 {
-	u32 len;
-
-	len = le32_to_cpu(virtio_vsock_hdr(skb)->len);
-
-	if (len > 0)
-		skb_put(skb, len);
+	skb_put(skb, len);
 }
 
 static inline struct sk_buff *virtio_vsock_alloc_skb(unsigned int size, gfp_t mask)
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 2f3e89cd4ebc2..feda96522b4f6 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -527,7 +527,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
 				continue;
 			}
 
-			virtio_vsock_skb_rx_put(skb);
+			if (payload_len)
+				virtio_vsock_skb_rx_put(skb, payload_len);
+
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
 		}
-- 
2.53.0

