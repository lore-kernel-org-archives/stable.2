Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793809605;
	b=QmwDsYYB7FWzMsY3e4kZgUe6KLJ0OiaXUSt3RB8KjgW6c8OHhhH6/mIHBGB4tKsmajKT
	 wN2laiSaJixycawP8pS38OLUVMwMDijRl244q8fjvpTOzxgY69feFiQGgJEAvtwhwFPNq
	 zK4qksoQ9EKCCIBJam0sQjVo/F3wOMT0RL5RCAXZHBG1fAApdFudX1KuldMrcQoAhCixS
	 +CG6BE4jQBUKLLP0aE4LS9mXrtue+MDoUN88ZbF81bDrnBtmwzs+ujd0SaWVJlocto7FZ
	 hjZpR12NjqNSjZxvssV+mXfF29nQOV3s5tNebzfXX0mseMOS2TvmyEOsx3q1dbwWuew==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793809605;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XqcOSoI2kRENMhOfGA/ODIWysXZLeFgrpZu657FzjSs=;
	b=nppq6DXj9zKyS4PkzVV6eqSBbLQjv6fKGgh09JQmfc3/16KU6MtkaIP0g7eimw+vRJB3
	 b0EZrAc6waFZr5JlbTJOZynVJeqKqhzzuIp1F0nq5Q5Cd2se+RFhL2Dg28HmTcC/UjriK
	 ju6hCzlOfXv8JS349Ho23mSM/7CxU0iVbyZegy1F9LuLhiRoM+JK4Jc/5CAfNXlEM3iKW
	 IgwJ4OLnWVAUm3jGACtS+zq4cWH6Sx9UqRXuO4cd79m4QsnKZjWi5j7ocYBOfMhmfVsGL
	 hXpoiSBWEN12BS5GgPbeLSV1ah7qwJFBPUvbrnwKYF7fVO+91sBHWWUXA4evAs6JQTQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CM13evda;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90486606A326;
	Wed,  4 Nov 2026 16:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CM13evda
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793809605;
	b=WxZPwbTLs0KLHl+Y7/bDq5EeiH32pOSyFk4P09lXBH9dF2seUJu44p470se3wsI74tzT
	 WcrquxfneGGiRT+n8IU1aHg6U1AuCa2emIBcA3cLfdUtaYcw9fpilDTtYTuh+9OnyGr07
	 EeZb9wpSm3f4TDphS0BMzr3r1Q8i6qZLk3Yjp4Cg4CoCx/5hCML9aHELHpWOmm9a00lZL
	 j+OBnXWZOUmfGHBgqeQhHUtNoXHRGVsMjy7k05+9m3YtsSsjCD3TOGLQnHUJ7WqIaWTPY
	 Ex6KQ2cCpp1aTFS9+cMvjDEQEiucO/K2EI6oqsug9RjD9azs3fGXcLRM4EwPLmQUIww==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793809605;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XqcOSoI2kRENMhOfGA/ODIWysXZLeFgrpZu657FzjSs=;
	b=NNbH7XPwzJfIQjpan58x1x/Hrab8LGKgPFEytOcIfBePGX5XMDMkyMmBBmlKFQs4/+T4
	 pOtx2a4bvpbVSAN0dzXNJlHzvEHBKnmo9tbmXwoZjYB659YpBmbNMzQZIDm5KBDBSqGWP
	 BgM/s3udsrf2igTOTUfntD0Rmv7SLiUXLB+Ei5w6X9TlvMCQfEnfbhp7vuoFmhHLMookp
	 8ZGAn59if6nEwjzxyTC8++mYo3ucsLBmUciRXuqL2Dm7+xFI/MRQXanbIkDM0ZB6xZCMG
	 gIht11bAi8S7bcfSDb0hTPkzeuMqx5iw9sEkHrNKGho/r2M+zvYb7cRaeik1ksqv6zQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B45F11F000C1;
	Wed,  4 Nov 2026 16:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793809605;
	bh=XqcOSoI2kRENMhOfGA/ODIWysXZLeFgrpZu657FzjSs=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=CM13evdaMJmOZ/jza3wRt04swqYZGmtAK3y2WcUtsY/MgxRFQVipTGnzvkFwlj1I8
	 VsU3wwImJsiWAsXZDVB9dUB0ExaApWNna0zqOwUhGmQ18PwDszl1TyaQdRtPucoPt2
	 HDLXYRPa8fRQOywziLUJZcWGZC7c4mi8Q8tjj9/eis6O7Fwu1nQPfRTLFL8qLocTDM
	 mjrQRFLg9LxFyjDNX2+SJHm92HHsnFh775dE5sbCE6Jdd5LgA+rIMTTbXN5NQczRmg
	 1TNWzqMUEmHiJwG2FbVQtLzHEaPEHAUbKMRlPjuKS+5WPOSg9MGYJD+8hCz6TRBCUx
	 SK4fR2wZOg4Ew==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 13AC946EB7;
	Wed,  4 Nov 2026 16:26:44 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Wed, 04 Nov 2026 17:26:43 +0100
Subject: [PATCH net v3] vsock/virtio: clear vqs[] to avoid a UAF on a
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
Message-Id: <20261104-vsock-restore-uaf-send-v3-1-d60d06488b57@eldare.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XNQQ7CIBAF0Ks0sxYD1IK68h7GBYXBooYaaImm6
 d2luOnGuPyTP+9PEDE4jHCsJgiYXHS9z6HeVKA75a9InMkZOOWCUcpIir2+k4Bx6AOSUVkS0Rv
 CrJb1QVjFWgP5+RnQuleBz+BxgMv3GMf2hnpYyKXWucV5l/nESvnfUmKEkcYoQa2ksqHihA+jA
 m4NlpHEVwzf/2R4ZoRslDLCKMl2a2ae5w9qgSuWGgEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793809603; l=3366;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=M5xaSNmFTKxhlPUeiNqMrmM7Ti9uva3s+Lictxc3xSk=;
 b=WiOH3gK7gWMGtImU9UnXdRgEZeOga4gZyBeLDnXYU6u/5UOadx+GaGWSQtbgVTmXTQcBfTXY9
 PGRLQ/f248gDMYpfGRy39AwTlpbiJWq423G3xb7DftydlGoHe0CV4/S
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
early from virtio_vsock_vqs_del() when vqs[] is empty: a second
del_vqs() would free virtio-mmio's IRQ again ("Trying to free
already-free IRQ").

Found with the help of Anthropic's Claude and reproduced on virtio-pci
by failing the restore with failslab; the virtio-mmio IRQ issue was
found by the netdev Sashiko review. With this patch neither report
appears on virtio-pci or virtio-mmio guests, and the vsock vmtest.sh
single-VM tests pass. A find_vqs() failure after some virtqueues were
set up was not exercised.

Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
Changes in v3:
- Shorten the commit message (Stefano, Michael).
- Drop the two comments on clearing vqs[] (Bobby) and shorten the
  remaining one.
- Drop the tool note below "---"; it is in the commit message (Stefano).
- Comment changes only; not rebuilt or retested.
- Link to v2: https://patch.msgid.link/20261028-vsock-restore-uaf-send-v2-1-675aad6da714@eldare.de
---
 net/vmw_vsock/virtio_transport.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..ffe7cd93463d 100644
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
 
@@ -781,6 +783,14 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 	 */
 	virtio_reset_device(vdev);
 
+	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
+
+	/* After a failed restore no virtqueues are live, and a second
+	 * del_vqs() would free virtio-mmio's IRQ again.
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
base-commit: 363c8c79220d0db4d65dcd570529ddda15067cb5
change-id: 20261001-vsock-restore-uaf-send-1fc7396fa1bd

Best regards,
--  
Jerome Mohm <jrmmhm.kernel@eldare.de>


