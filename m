Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795617548;
	b=FxVP9X+YA+zxAk3punM2fRhDDDBj6oz5AXgJKHhqSg72e0UKAf8ueve1c43iCzfKLUeb
	 o0jKNw/EkUJkSnXk6JfH05NJ1lqx7aiEONt2SojRRyR0SPucHlk1+If70ei8XDL9/GRlc
	 Qslfa27wrcvzVT/hT+Bh45pgyEM/AvcoScyWU7Ptn5AinX+Iy3t0joGrq8TAwACcuPSA6
	 FTFaruSqqJNYwYgkZCBkHYjwt4a1ZB+RoKFPHeKgTa5RlLeJGXptu1n6YqidPRWc2TGDi
	 tXqJXZ1eS9TtGeizZT9gwbUJ/EKUf9ys7j3RqQjLeUb6owXe5A5YhPdrV62bWxveSHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795617548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=wb+Qnwk95vzDa/h93bX0XAD6djLJFfKISUF3AANGo9c=;
	b=DlEbKx4bsoCB5r7Nlq23gAVNfF9SincwX7+uP6wtWKUMNMiZeL2hzCmoUud+FlnXNk6N
	 kkBc6Dvpb629j1z7iC0j9s17PlPuMIHJwEQkHGuVG4nto/B2W0ZI5RNAjgjYdroDWWZiW
	 qi+pP3TBF+gvBq+K+M2tx0WdbDtdUH2xC7cu83RV0RXLh51HDJlf3hP+D4EA4jZOxzArM
	 mpZ/65zWiP5X8tXOCPUNiHj7iUveQcaWHc2c7rHGjI8x+eukY1fKwPw1ML20QvziO+oOn
	 RX+70glYA07SN67Kf3d4tTjZuGbdKVZHQGlNfZJ7th8pABYyFal0SBgaR4wyeJtOXOQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTWFH9GT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E05606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HTWFH9GT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 428CD1F000C4;
	Wed, 25 Nov 2026 14:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795617547;
	bh=wb+Qnwk95vzDa/h93bX0XAD6djLJFfKISUF3AANGo9c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HTWFH9GT+Kr7tfCIeFLl/zwXzb+gz6doQ+sjftGqW+D1+0KkhYilskIamSPduvJfW
	 uofyLQCrHU9eK2Tlk4UOQftyuiLmNHzol8wL0UpgoVHB3bhSQ261CcG5e2SgefVilp
	 6UmXp6ruGIy8ai5BccEcYGGdt1xpjQqEGpmxfX69GBf1sKSO7pahQqyf+GJtV2O6Q2
	 WTp+wVUSPsqTW2CLiS42M4ghyRSAT4U+u2Be1xqwKIsCTH7k/KYDla09D/E6KUYvS1
	 qSoMRCpVEXZaZNUxSImmpyWeXWojXFHdmosxTYOnQgvcOzTXayM/XcEWoQO+3jQfPN
	 O4gffc05DmVFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jerome Mohm <jrmmhm.kernel@eldare.de>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] vsock/virtio: clear vqs[] to avoid a UAF on a failed PM restore
Date: Wed, 25 Nov 2026 09:39:06 -0500
Message-ID: <20261125143844.4147434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112539-sudoku-footbath-dbe4@gregkh>
References: <2026112539-sudoku-footbath-dbe4@gregkh>
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

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

[ Upstream commit 2a24ba1694f14299fbde3fa107e5d56629f2f8b6 ]

virtio_vsock_vqs_del() frees the virtqueues but leaves vsock->vqs[]
pointing at them. If virtio_vsock_restore() then fails, the driver
stays bound with a dangling vqs[], and the next freeze or unbind
passes a freed virtqueue to virtqueue_detach_unused_buf():

  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
   virtio_vsock_remove
  Freed by task ...:
   vp_del_vqs
   virtio_vsock_freeze

Clear vqs[] after del_vqs() and when virtio_find_vqs() fails. Return
early from virtio_vsock_vqs_del() when vqs[] is empty: the detach
loops would pass NULL to virtqueue_detach_unused_buf(), and a second
del_vqs() would free virtio-mmio's IRQ again, which only WARNs in
free_irq() ("Trying to free already-free IRQ").

Found with the help of Anthropic's Claude and reproduced on virtio-pci
and virtio-mmio by failing the restore with failslab, without other
kernel changes; the virtio-mmio WARN was found by the netdev Sashiko
review and reproduced with v1 of this patch. With this patch neither
report appears on virtio-pci or virtio-mmio guests, and the vsock
vmtest.sh single-VM tests pass. A find_vqs() failure after some
virtqueues were set up was not exercised.

Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Link: https://patch.msgid.link/20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ sashal: Adapted the virtio_find_vqs() call context, which here takes separate callbacks and names arrays instead of a vqs_info array. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index b4b09d0b04325..433e77db6d2be 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -559,8 +559,10 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 
 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, callbacks, names,
 			      NULL);
-	if (ret < 0)
+	if (ret < 0) {
+		memset(vsock->vqs, 0, sizeof(vsock->vqs));
 		return ret;
+	}
 
 	virtio_vsock_update_guest_cid(vsock);
 
@@ -621,11 +623,19 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 	vsock->event_run = false;
 	mutex_unlock(&vsock->event_lock);
 
+	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
+
 	/* Flush all device writes and interrupts, device will not use any
 	 * more buffers.
 	 */
 	virtio_reset_device(vdev);
 
+	/* After a failed restore no virtqueues are live, and a second
+	 * del_vqs() would free virtio-mmio's IRQ again (a WARN in free_irq()).
+	 */
+	if (!vsock->vqs[VSOCK_VQ_RX])
+		return;
+
 	mutex_lock(&vsock->rx_lock);
 	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
 		kfree_skb(skb);
@@ -636,10 +646,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 		kfree_skb(skb);
 	mutex_unlock(&vsock->tx_lock);
 
-	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
-
 	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
+
+	memset(vsock->vqs, 0, sizeof(vsock->vqs));
 }
 
 static int virtio_vsock_probe(struct virtio_device *vdev)
-- 
2.53.0

