Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794253173;
	b=42qNF0G67NHWsp0eNYUNOu/gT3sQeix7dwl9yXCCC41Lc8dvvKRSVS2fQ5GMqAuwyAHB
	 5s9Q4eRzu8GluAAxGxNh87rNCBIGgFwpL/LY6a6E5NQvgXoz6ugfRaCyL1zZ37/wxGN9T
	 g8UuGNqi/1mMtZYi+ztW8H6q3sEZ5x8S5cM5bEwmsFTvVBVdt4bqYebDsAd13pRpvgUAR
	 2ezJpntpgxmLNAup5HtcnlPCh2DQvrh2Cy6z62YsK4twpgHzPCBz+aWI20g+iQzkA4qfS
	 Wcgs2V0Mbw20AoIEHb9SpMraZKIQ75chBbVZ37WJ7cPKuC1Na58NIxYmAH5VXVJDe7g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794253173;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+SpHWuB6zKKOg3YMCGBS0eIDV2dpGhp+lFZvfVQEXG8=;
	b=3FSFvVhzv/Jk3Wlgb9+Hg6YT1HKZ90q+IZY+spG/WG+JmvbwYS+C7Pjh8uFS1z/B5+0t
	 l2UXTKRybKMWvGBgDgo4KYOTAEtvrjbWZeEYuBlRgEKvxu02d4C08lf9jGkHndgQXhnXi
	 zp4NedTJ+q5ZOrO0MmGPDa2fwiuodEgX+cpDg1kBT15odlWWBuHc2gKtfPWuvKcID+TTN
	 qrQwt31fL4tERZgVTeBDvujRc1sBmcbPAMav8coxR5Vki1X+V0rwnW+5RBaa8F79L3SpZ
	 sZl7avOdx35ecPt7UUNnB14EZtdCS/0EXKjUGpO+iAnOojgbsYWNWyMQSEgxy3nzTWQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZNrmWxW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DF5606A31C;
	Mon,  9 Nov 2026 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DZNrmWxW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794253172;
	b=0NmJiQoL9uCY9dXfVNem3nvUDAD46sX4u6F+096w9DsfoF7wbMcYPCSXwEohn0UZMFdB
	 KURk5DvuW6OSoupH2MlVBngnEpVizIcbrc+eaEtUbcvxC9gmrY511wK2GDpwEh49wqXXG
	 LIjW/yXoVY66GjErXSWf25qS3iwLiFpQ7f0ZpVZDMj4BPbS0pVY/Os7qxZO1lvCrwkAjQ
	 OskYGMHWjPP2yxsHCPC2+6qtll7HvHB685pvknT7HzEfJhQMdubOzKuap/B1sX8mY2jge
	 H/ITbjq1FByjNQDJWZvhjxapb4sGTpKqk8Qqz8LO19H5rjThaRg6JaYcarl7oTmwgOw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794253172;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+SpHWuB6zKKOg3YMCGBS0eIDV2dpGhp+lFZvfVQEXG8=;
	b=0G+/98hUvMBhFEquEe83GkDDcxReMkRpc+AJQUVCf4+TMwWLmmBz0OIeRqoZP4TnCQw2
	 J+jYlmtC1vEJwXj/O0u6ZkYZ0QPfglQ3zL2VdLRws9XZxaCCLO9++132ZMxVujBAjinGc
	 r89cem3qQB6Vu81ohhMCFMdFKVaJNc13pktpzlruyCJ1uoMgfMP9kWPnyaXNwS2Je0FUP
	 7PiR0sNjmcBLXEWSPI9VREAPBA07L4sGgREgbk7703U5lT9/nroxqifILlIQK8fLA7JTM
	 /U7KFDIuBD17bHNFDOPu09HGryysmi1/BSmMU8Ic3GlZD8CVO4CcfYUBDDusQVYrUSw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id A21B11F0089F;
	Mon,  9 Nov 2026 19:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794253172;
	bh=+SpHWuB6zKKOg3YMCGBS0eIDV2dpGhp+lFZvfVQEXG8=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=DZNrmWxWOFiKrNxNxneZOqnZ+6ZfXGIc2bp0EmcEtOWokJYPqrGYWXVW6O+1G1IzJ
	 EeQuOmkqbhNbh1/wJnArvzqFVvDFSat/Yj0FZbBfqla51Ju9WYjajWhQFFK37u7Bei
	 YCPnnBSIPZ2Len/+3zGdiD4Yvd2vn0Zp9QMJ9MKmuQc9vUIFmqbzKsFBACX7ouKQNb
	 VTANWBzcNiYIm3kPNWimYOFABUsSk9b/OvoBzTXGUsei6MGAGUVFcyfO6+b58TmObM
	 sHcHmrVqK1WQMOmB+FNAb2bKmQmceAymL45u9NyjhVMNvXMz/wTGzI8OIZTEtQRjou
	 vWHeYR6V4j9Cw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F291048619;
	Mon,  9 Nov 2026 19:39:30 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Mon, 09 Nov 2026 20:39:24 +0100
Subject: [PATCH net v4] vsock/virtio: clear vqs[] to avoid a UAF on a
 failed PM restore
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261109-vsock-restore-uaf-send-v4-1-1df8dfb5d5de@eldare.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQW6DMBAF0KtEXsfVjAGbZNV7RFkYZty4iaCyw
 UqEuHsNXRRFirL8oz/vTyJy8BzFcTeJwMlH33c5lPudaC+2+2LpKWehQGkEQJli315l4Dj0geV
 onYzckUTXmuKgncWGRH7+Cez8fYVPouNBnP+OcWy+uR0Wcqld/OI81vmEa/ndUkKJsiKrwRkwF
 ehPvpEN/EG8jiS1YVT9klGZ0aayljRZg+UzU/wzCOVLpsgMaSDQZV03ldky8zz/AjpYukFhAQA
 A
X-Change-ID: 20261001-vsock-restore-uaf-send-1fc7396fa1bd
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: virtualization@lists.linux.dev, kvm@vger.kernel.org, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794253170; l=4147;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=5YFXaOW8KllonSsjF6SOnB8HkwciO73pZwsUjT72k8E=;
 b=o5Ui0yGmlrlsv7s3vDR3Ic3XgYduWqet+IqPcVhgBKc2puHQzgL+jxfeHT/pgfs6jWrU82E9J
 /7KX0+ab2xgBwU5CsrABnE3TPB51T8iCBoYthWQ/phU9iNUse8McHiX
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de
Content-Transfer-Encoding: 7bit

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

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
---
Changes in v4:
- Say why the early return is needed: the detach loops would pass NULL
  to virtqueue_detach_unused_buf() (answering Stefano).
- Say in the message and the comment that freeing virtio-mmio's IRQ
  again only WARNs (Stefano).
- Move the send queue purge before virtio_reset_device() (Stefano).
- Message: the use-after-free also reproduces on virtio-mmio.
- Rebase onto current net; rebuilt and retested on virtio-pci and
  virtio-mmio, and the vmtest.sh single-VM tests rerun on this version.
  The moved purge ran with an empty send queue only; the ns_* tests of
  vmtest.sh were not run (they need root on the host). The reproducers
  are available on request.
- Link to v3: https://patch.msgid.link/20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de
---
 net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..cf63bc99f3cc 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -714,8 +714,10 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 	atomic_set(&vsock->queued_replies, 0);
 
 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
-	if (ret < 0)
+	if (ret < 0) {
+		memset(vsock->vqs, 0, sizeof(vsock->vqs));
 		return ret;
+	}
 
 	virtio_vsock_update_guest_cid(vsock);
 
@@ -776,11 +778,19 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
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
@@ -791,10 +801,10 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
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

---
base-commit: 1d5e2c57e9ffc134e14b3f837c8d7c53b508bd22
change-id: 20261001-vsock-restore-uaf-send-1fc7396fa1bd

Best regards,
--  
Jerome Mohm <jrmmhm.kernel@eldare.de>


