Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702104;
	b=WQeFCEfMqcmGlixurwqpluuLgg4+QPf2RBjkMzTuHc1q8KqS/DeV5e60wvdqM+aQBvlD
	 E18T8YMyx/tRCo/XGfMbRIRN6lRR++3hq+e6P6oZ4sRAtydFYMXpXZu49UmR2aIimL4Md
	 PzsZk6Yeoau/QCy2nbrdXER1I53GvboDJvPo4+cCBsHRbnzYvA5K/OWrU5ssuxTv4JHrY
	 wGY5qcH9NT6O6Kcntj11fpoTstSwC6vWZfoHwbYCpWUPJMBQe5o/1Aaw90SRHo9sjvgg3
	 XQq/sKWJg5ZArJE0Fs2d9FFLzZxQbCxsWrgZS7yYrMDA0Ppp+9My6Ur4TwbpQjpGdng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702104;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=cPsLxRgsvsgxkqnHrid3RKlFBrKDcJXHJeHkXBAeUHM=;
	b=fF5ae5l7UlLNe7xGiPu4Dl4gtMhaeVTj/00HdzCpFTuGua/Tkq4S2oICqv47FQ+qoDvp
	 O7CSg0WhUo0QkqyQ2OaZiN8RtInTUoTLZazDkAQZJd81lHfJd5UIlZtTCxCP13za3RobH
	 DIfr2Y6aCTZNOqdfZiXlEGlYpgfUbX7rDWoUp7CEbWI7Crm6OoznmcnmWmZnC0U+45UJm
	 ypY02scvXUvlPmaPoKJmDrPfJI6pEDmi3tlFNERzn/VSe7LhT+SoxsqY/jahTrXXLJqWy
	 rgDbWCZFWgvXBRmBM2RkDAfEVZ8hZ5DurQzsw3bYTvfsxxXYshkoKbOT8gM66RK8DqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIlfrTyr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FFA606A330
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CIlfrTyr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCFF1F000C5;
	Sun, 15 Nov 2026 00:21:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702103;
	bh=cPsLxRgsvsgxkqnHrid3RKlFBrKDcJXHJeHkXBAeUHM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CIlfrTyrKP+UW91aLTYdDZuMRDYp5+UdyG/bbzt8fpUQhTkVctkQvxTacqo1MVcBl
	 7DLJpZ51U5U9rnQG+ppyXdItSQp0wpCDKGYHvti7ZFalRZDdHHHEzlmVwWxrizARy4
	 L8/4ycPLw6EgHkEacQ7vFTHBAOHynD0V5zpuvsCbI2bFRas4nh4A/lF2VHw8NpMKTN
	 8vUcqxmzgoLD8w0tgfVQU7DEtGNhDMOpcOjOD5OeI0ef3hbdIuHVIFD+JzyUJHqY0Y
	 usMjURo2tVhT2/Tt7+3wv5Jw1FBYlbB6lWL01PBM0EJyittZjGmLFF2/sRWofnCLGm
	 GD2NtSaZ7IwVA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] vsock/virtio: Rename virtio_vsock_skb_rx_put()
Date: Sat, 14 Nov 2026 19:21:40 -0500
Message-ID: <20261115002130.534693-2-sashal@kernel.org>
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

From: Will Deacon <will@kernel.org>

[ Upstream commit 8ca76151d2c8219edea82f1925a2a25907ff6a9d ]

In preparation for using virtio_vsock_skb_rx_put() when populating SKBs
on the vsock TX path, rename virtio_vsock_skb_rx_put() to
virtio_vsock_skb_put().

No functional change.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Will Deacon <will@kernel.org>
Message-Id: <20250717090116.11987-9-will@kernel.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Stable-dep-of: d5e912448cd9 ("vhost/vsock: size receive SKBs from declared payload")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vhost/vsock.c            | 2 +-
 include/linux/virtio_vsock.h     | 2 +-
 net/vmw_vsock/virtio_transport.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index a5bbbb5d0273e..f197f0c28022e 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -372,7 +372,7 @@ vhost_vsock_alloc_skb(struct vhost_virtqueue *vq,
 		return NULL;
 	}
 
-	virtio_vsock_skb_rx_put(skb, payload_len);
+	virtio_vsock_skb_put(skb, payload_len);
 
 	nbytes = copy_from_iter(skb->data, payload_len, &iov_iter);
 	if (nbytes != payload_len) {
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index 3e91cde041037..a8ebcb04d0c80 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -46,7 +46,7 @@ static inline void virtio_vsock_skb_clear_tap_delivered(struct sk_buff *skb)
 	VIRTIO_VSOCK_SKB_CB(skb)->tap_delivered = false;
 }
 
-static inline void virtio_vsock_skb_rx_put(struct sk_buff *skb, u32 len)
+static inline void virtio_vsock_skb_put(struct sk_buff *skb, u32 len)
 {
 	skb_put(skb, len);
 }
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index fb7acdf4ad2b3..1fc8025bfb06d 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -531,7 +531,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			}
 
 			if (payload_len)
-				virtio_vsock_skb_rx_put(skb, payload_len);
+				virtio_vsock_skb_put(skb, payload_len);
 
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
-- 
2.53.0

