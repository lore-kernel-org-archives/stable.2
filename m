Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794702611;
	b=dapQH6D1eUe9CCwD3XZbIrj1L0jwMKox1CDHaKsiFX4uqXvbwT9Kjq8LzPR07NgLYJFI
	 sZIJ2lcbRrBQjGr5+MkKjTZ6r5KZmN/XDibU7nB3biucyXS37NxH3wzvAfDD0oNYGhM/b
	 3dKRZodU0DLyJGXgSb+aBNhu9DmSJdAkolsIbSudYSqQSykf28o2zwCGTkYUC4USwOgzG
	 vU84G7VOIQsi0/moGs12J+ckpDByiRDMdKyiP7iGrPUk/rwrlflHrO/YTLMhMNcmyO3xx
	 Mj056ss+3mwwul6tdQ+ueNwYx3YZ3wRpZLK7LUdB3UhT3Rbj5WQtuy6aOyaGOZh51eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794702611;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CeZiAIXrXH7mdSwpHglUqpM6dIiDl/+1vI8PioJpFmY=;
	b=rISh6eztM3IvvULwXX4IscHQYfWBPMC1vLL2WsTcxth/0NM4kzUXzX5ranbAUjxd/R0T
	 UKwE27u5w2PkOvhXE6k3gRK3KjTRNladZFsq54lS9zSowe3hFyez1nYKxzcKL8OzOI9Mn
	 DdNy2VpxlmiC0Btx9K6+tPOrs2Ro1qsGKmL3/zgpSF9BfqZSwvqigENn606k5KrDbv6SF
	 sEB10vVSh+fRVquXFIsOy1vhLL8djnm2M4Kpcd9HaBsvgVa40ihKt/NQ4bvq2dsu+UYld
	 m3fY3yft/97GjcJZOtBO6SA2M5Y0NRgfyjeJgFKxtC3A4B0X14B7bYKPir69l3xHyRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6bqtlan;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7568E606A886
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 00:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P6bqtlan
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60F7A1F000C7;
	Sun, 15 Nov 2026 00:30:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794702611;
	bh=CeZiAIXrXH7mdSwpHglUqpM6dIiDl/+1vI8PioJpFmY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P6bqtlan5vXtu3m+BSeb/eF5uUXSzh5jJ+SAADaI0sKh5YP1ZXfFfLcwl1EidiFqC
	 0p7oW0ACNECG1WahXldFsz/GEEzPocIZHWupA3ocu6+VA6qHb7r2eLdCkZY/S7WHav
	 3Zd+gVSGNfT22zbnuvb735NYME5rUKSpaZ9C/VBBokrNb+/3avQBXIVZObvHTR3hFd
	 t8s/vagdcp3GloZFSteV4zZ3K69MgFMFTNfd/olcUXTenCG7aS1d0eZMO46KWndWsx
	 nsF0TMS/0zuXgKR0KQa6HCNil024xtcTm7pRBfKqBm7Wb6imAkSxwVy+VtgAfxvnfD
	 4BLZo1JKvJiOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Will Deacon <will@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] vsock/virtio: Rename virtio_vsock_skb_rx_put()
Date: Sat, 14 Nov 2026 19:30:07 -0500
Message-ID: <20261115002958.559603-2-sashal@kernel.org>
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
index c08eb6774c427..1fc03038e5543 100644
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
index 3b97af88edbca..f62ec310059b2 100644
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
index feda96522b4f6..b4b09d0b04325 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -528,7 +528,7 @@ static void virtio_transport_rx_work(struct work_struct *work)
 			}
 
 			if (payload_len)
-				virtio_vsock_skb_rx_put(skb, payload_len);
+				virtio_vsock_skb_put(skb, payload_len);
 
 			virtio_transport_deliver_tap_pkt(skb);
 			virtio_transport_recv_pkt(&virtio_transport, skb);
-- 
2.53.0

