Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795616857;
	b=TypAVTRjGmkolPBKMHvQua9dUlBkGRNYXeOTaKgzLzt7aYJ8r8FIWoCbldl4MTxBQvLG
	 3QTOfiZCVffzco+gGu8ILOXDdRrrjvkyTg9q+yRGzcYZ08wjbIqwqG41JME3bONAWUK1Y
	 phs+YYFnD9XzdZhEBjV9UmoMlK5DQXTD12AIOdu2mVfsQgXinVpp1aDbCKbsuIM4dbOT6
	 ij61gI3o3n/aoh50awXvmDi/OdpekTf1dM2CuyEIQ5r/k1l0lvL6uu1Ctlpt3U99LsRge
	 pPSmzuoD84A6TRSTSv5ranYQFshaiGdxP3oo8WVtBnd7qlGDDLPjka60AaKbZyMcSWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795616857;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nM7FaR+E6/odjSFI4nweG0OaYKTzHmswjZC1hXLNBrU=;
	b=kE0tIePLIVUIiNqO9GaV0ptoSDMtZVTTVP0s00cfKJdgsVRPDlG75xQ8Qlm5WboRBUpe
	 sQ2RJ2qkxdWtI5NucilDIBNgyeEjpb4luzRnp+N+gBz3NKHHSoqkdYAd7oJPsqfznfrzq
	 nZVMlEhrmijEYF1zxwDRJy9OJXk9FIAcPACiD0whqj9k6aAXJFV5ejzU5OuShRAqqn8AX
	 Onp5S7RwCHp7b5G573uJkI2p63A5Gg2kmkJK/TI0hcT8m07Ulltxm63bTk4rwFq7Tnyd7
	 hQJWH/h8hmqcD1zAX7CruTnEOoEBwkjOVyKF9yvTCa5whPWxsvD5cUdtAgBISVbDKAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyYNq5sY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D477B606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 14:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OyYNq5sY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72C11F000CA;
	Wed, 25 Nov 2026 14:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795616857;
	bh=nM7FaR+E6/odjSFI4nweG0OaYKTzHmswjZC1hXLNBrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OyYNq5sYXcSOFcWClaMMKMQIRjBJHnbqWcdzOUetpF5jalrqzh8uPRP9j4IRS8zBq
	 mFqC4QH96Xcjs2l7nzatHHoJOFjRCz+/+XRLqUZiUtm1h3gna60MDrI6V0KLPLN1TK
	 UgqttjJmwikDQ2bW7i9JjeEOBrS5ZblUZjTpgtNq5ii/4LAGLJ9x6VJuT8S4+Mdv7r
	 BzKfYjT+njYB+i7a0OpHRCKuCSPZdLeoYMzFTwlHuA1WYceJ04A+suZXX3P8WohYTc
	 Rn/mNljbZZ/fzoclEX7p5LaHTWA1wmlUKfb4cgoOTLxVzIk0ZjK1G1RF8PY0Muwos+
	 SInasy85+CeIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jerome Mohm <jrmmhm.kernel@eldare.de>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] vsock/virtio: clear vqs[] to avoid a UAF on a failed PM restore
Date: Wed, 25 Nov 2026 09:27:35 -0500
Message-ID: <20261125142717.4035076-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112539-founder-small-f4da@gregkh>
References: <2026112539-founder-small-f4da@gregkh>
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
[ sashal: adjusted the virtio_find_vqs() hunk context, keeping the old callbacks/names call and omitting the rx_buf_nr and queued_replies resets that this tree lacks, while applying the same braces and memset. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 1fc8025bfb06d..15b5a918918b6 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -562,8 +562,10 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 
 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, callbacks, names,
 			      NULL);
-	if (ret < 0)
+	if (ret < 0) {
+		memset(vsock->vqs, 0, sizeof(vsock->vqs));
 		return ret;
+	}
 
 	virtio_vsock_update_guest_cid(vsock);
 
@@ -624,11 +626,19 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
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
@@ -639,10 +649,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
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

