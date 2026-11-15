Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702103;
	b=JBlA3DJose19zyDZ7SFLbNAyJlUKo83+57POhBfSVsrrLNSSilNci4Zj7DD0rPyAvp8X
	 FPZ65yZ2qxhxAzhEFCCP0a0/LXms9zU5Gq6wYI20i5PTJIWh4MbnDXO1I3671VJ98WDvm
	 a7jAfiJlQ+tISKx9JpJ8KLmA2JJEeN2+P7CLsxP02ma14nIidtrqSVZrpqj7CfY3MYTtl
	 hrVn79mC7SUW5fuLYC3KAFL9a/ovZ3OkKyMBcHgDvHGNLIk8QLdUbIafz5f5eJF0Tu4B0
	 Pewb97f99z16DTb1wKieqi/5TIy7dMCdlQM6WzWHGiMOJ0hbJRkJBhWK1h0loIuRoxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702103;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=oIcKgLPbXj+owR4W1dhv40onMpgDm22jw9kb1oLoV5k=;
	b=eDZmm3IORtawhvNTgk1VAXA84ppgnwe7bJd4GPASnPY62ggzwoDKTBbjPQBJY3QqGRje
	 n0uB6sT3AxBTjk9yir5bGBk2bQPRoYS66L7UOAy8ijLSqxQ6Nh/KXDDqqm206G4RRG7fC
	 UBdBQSpV50600i6i+hg3HbAjFYYtlzomgm14C4o/KKidS8Dw4+TzaLSqfDmTbwUmBKzBf
	 uCr2vmU4vqgyNon/ctBih5UshXK+iH8+6YYku9VJmrN8symS5QOS3K+4APDMX3/XjaJ/P
	 MTrQOQwn9pOjcwxhGiWVfUFwKignDhvhe3pze3b3wvuAM1f/fc7oR3tu+4VD8hUpi3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ka4XYxvp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 879C0606A327
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ka4XYxvp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814FC1F000C4;
	Sun, 15 Nov 2026 00:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702103;
	bh=oIcKgLPbXj+owR4W1dhv40onMpgDm22jw9kb1oLoV5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ka4XYxvpMnG3LWQBlMcmmtzPhMcPEWTwWFgSG2jayyVEv1Zathqd4Br6HmKtYnRTQ
	 7tTgCbXkad5pkJOTnwC8C/4BSTcVPUvqOwC+Y3fMzYS5fuJFtBdG4S6ncVt90RidBH
	 n+5Vopu1WcON9KQ0xEHAP0jkBaoAfqr+bx/T8ZKAiUx2bCsYsZikd+dK+T0qYtCktk
	 U5PHduJKp4JCBV5z28geQ2C6/SW2WW/ThyQ8JH6PkvF/CVs2vQWW9q9d0IiAwOAqhU
	 zmb/X3YWo5ExLqK/+K256iACqzoT4uiQEAJ+F882j9LZ3CvGG7rjEASd0LdHASNU7L
	 3ZVrMAJ4Fm5Bg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] vsock/virtio: Move length check to callers of virtio_vsock_skb_rx_put()
Date: Sat, 14 Nov 2026 19:21:39 -0500
Message-ID: <20261115002130.534693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201414-failed-6.6-d5e912448cd9@kernel.org>
References: <20261109201414-failed-6.6-d5e912448cd9@kernel.org>
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
index c3fceb7892988..a5bbbb5d0273e 100644
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
index 5148b035a8f38..3e91cde041037 100644
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
index 6c7221a032ee5..fb7acdf4ad2b3 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -530,7 +530,9 @@ static void virtio_transport_rx_work(struct work_struct *work)
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

