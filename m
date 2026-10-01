Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195193E2ADF;
	Thu,  1 Oct 2026 17:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790874826; cv=none; b=hI7tqh+NWTZBTSxtBY1KNkQqZOQtmiq4wrOIzjobU9/G3aRhm7k/s+I76CkoklqH2qofEjyf9bRg1U4LYw/EtN303qnliked8khsgc+ewiPFnn+nAHp6Pzkh3e7gE4ZBzgc2hEz0yZLROZvJfJ2WQROMVPlLueCuW1iTGbOSkvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790874826; c=relaxed/simple;
	bh=lhq8JKa61aTi2bOedB2Rr/BQnnWBa3OKYCB3YEzC3dc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HyPXwG5VkKkughA55khicV8K6VfMLJeXZa0KbRRSkUj/TiyJsTtiK7ScUckzZ3fWg/XiNEsFwcH/FcjRv3/qk9nLjc/LyIaDGl21M+ilh4cYEYPZ4L/cMby/IEuQcvxQoa0dEKRPCpLKMI0MSxG69J/FthSfaMiBrLeb1EMJXFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pu4Nr4N0; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pu4Nr4N0"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 146D6C2BCC7;
	Thu,  1 Oct 2026 17:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790874825;
	bh=lhq8JKa61aTi2bOedB2Rr/BQnnWBa3OKYCB3YEzC3dc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Pu4Nr4N0SCi9iwuahSsPUdyfOR56ompJLH+Bhfm1/eFG/ix/XPZD6JJArSmt0gYPx
	 0OSN1c5VQh4CiC1ZWcR7USgV4SGLLH/P1LvrvfMEQ2lnmbP3C40b697yUI2/NAA7k0
	 DKWoDz7giesPUpqTnzO9lgEoArUVlUVuq+9wECDdnWbju7PrLr9yyJLS76GQxVOqH8
	 fxmwqMuiXmQ/grX6JecJF0x3kAdTLSS9s2St5jL7az3Z4jnghisaxDFhFe8c99Cxym
	 5w7/z/8G0DTvp+IjcXyAACjmQiKrXA7nl9hdghlwUujCbxWUK7BAt/d8orpNDPxepI
	 4ax8ZceHlJ6Ww==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E308BCA5FD4;
	Thu,  1 Oct 2026 17:13:44 +0000 (UTC)
From: Jerome Mohm via B4 Relay <devnull+jrmmhm.kernel.eldare.de@kernel.org>
Date: Thu, 01 Oct 2026 19:13:29 +0200
Subject: [PATCH net] vsock/virtio: clear vqs[] to avoid a UAF on a failed
 PM restore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261001-vsock-restore-uaf-send-v1-1-5da60f707506@eldare.de>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0QrCMAwAf2Xk2UAzYaK/Ij50bapRaCXpxmDs3
 +3c4x3crWCswga3bgXlWUxKbkCnDsLL5yejxMbQu34g5whnK+GDylaLMk4+oXGOSClcztcheRo
 jtPirnGT5j++QucLjkDaNbw51X8K2/QCBE6SYfwAAAA==
X-Change-ID: 20261001-vsock-restore-uaf-send-1fc7396fa1bd
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Jerome Mohm <jrmmhm.kernel@eldare.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790874824; l=4969;
 i=jrmmhm.kernel@eldare.de; s=20260928; h=from:subject:message-id;
 bh=OzDITxghnCYWCrZYjn50doFti2WNlSPFkziXexLwJqE=;
 b=gJV0ZugB4Fep9rZp+kEVHlD38YYd8UmQENkr+fukRe8g1yhWWzWG6WECTSs6uOS/yFvZZY7R9
 ORFIua46Ha4Aa1Cz94X/RmyKurU7eskGPowCKDtVwxCAjCLjlIM8ofH
X-Developer-Key: i=jrmmhm.kernel@eldare.de; a=ed25519;
 pk=xRCxNXbnNottaHpmvPDAOC9NuMJxqKo24abkehKRVlo=
X-Endpoint-Received: by B4 Relay for jrmmhm.kernel@eldare.de/20260928 with
 auth_id=1075
X-Original-From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Reply-To: jrmmhm.kernel@eldare.de

From: Jerome Mohm <jrmmhm.kernel@eldare.de>

virtio_vsock_vqs_del() frees the virtqueues via del_vqs() but never
clears vsock->vqs[]. If a later virtio_vsock_restore() fails to
reallocate them (its error path is a bare "goto out" that only unlocks
and returns), the driver is left bound with a dangling vqs[]. The next
virtio_vsock_vqs_del() - on a second freeze or on remove/unbind - then
passes a freed vring_virtqueue to virtqueue_detach_unused_buf(), a slab
use-after-free. KASAN on a guest with a virtio-vsock device, after a
restore made to fail by fault injection:

  BUG: KASAN: slab-use-after-free in virtqueue_detach_unused_buf
  Read of size 4 at addr ... by task repro
   virtqueue_detach_unused_buf
   virtio_vsock_vqs_del (net/vmw_vsock/virtio_transport.c:785)
   virtio_vsock_remove
   virtio_dev_remove
   ... unbind_store
  Freed by task ...:
   kfree
   vp_del_vqs
   virtio_vsock_freeze          <- the preceding freeze freed the vq
  Allocated by task 1:
   vring_create_virtqueue
   virtio_vsock_vqs_init
   virtio_vsock_probe           <- original allocation at probe

The object is the RX vring_virtqueue freed during the freeze;
vsock->vqs[RX] still points at it. virtqueue_detach_unused_buf() does
not guard a NULL vq, so a bare NULL-out is not enough on its own.

Clear vsock->vqs[] after del_vqs() in virtio_vsock_vqs_del(), skip the
detach loops when a vq pointer is NULL, and also clear the array when
virtio_find_vqs() fails partway in virtio_vsock_vqs_init() (which can
leave freed pointers behind). This mirrors virtio_blk
commit 0739c2c6a015 ("virtio_blk: NULL out vqs to avoid double free on
failed resume") and virtio_rtc commit 548d2208455f ("virtio: rtc: tear
down old virtqueues before restore"); virtio_console carries the same
stale-pointers-after-failed-restore fix.

Testing: reproduced on a private VM with a KASAN fuzz kernel based on
v7.3-rc5. The restore allocation failure was forced with CONFIG_FAILSLAB
steered by the fault-injection stacktrace filter to the virtio-vsock
restore path only; a guest-root program drives a pm_test=devices
freeze/restore cycle (so .restore returns -ENOMEM) and then unbinds the
device. The unfixed kernel reports the slab-use-after-free above; with
this patch the same run makes restore fail identically yet produces no
KASAN report. checkpatch.pl --strict is clean and the build is
warning-free. The reproducer is available on request.

Fixes: bd50c5dc182b ("vsock/virtio: add support for device suspend/resume")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Jerome Mohm <jrmmhm.kernel@eldare.de>
---
 net/vmw_vsock/virtio_transport.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index 4f9aa9c4c3aa..0553c0641fd2 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -714,8 +714,15 @@ static int virtio_vsock_vqs_init(struct virtio_vsock *vsock)
 	atomic_set(&vsock->queued_replies, 0);
 
 	ret = virtio_find_vqs(vdev, VSOCK_VQ_MAX, vsock->vqs, vqs_info, NULL);
-	if (ret < 0)
+	if (ret < 0) {
+		/*
+		 * On a partial failure virtio_find_vqs() can leave freed
+		 * virtqueue pointers in vsock->vqs[]; clear them so a later
+		 * virtio_vsock_vqs_del() does not detach a freed virtqueue.
+		 */
+		memset(vsock->vqs, 0, sizeof(vsock->vqs));
 		return ret;
+	}
 
 	virtio_vsock_update_guest_cid(vsock);
 
@@ -782,19 +789,30 @@ static void virtio_vsock_vqs_del(struct virtio_vsock *vsock)
 	virtio_reset_device(vdev);
 
 	mutex_lock(&vsock->rx_lock);
-	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
-		kfree_skb(skb);
+	if (vsock->vqs[VSOCK_VQ_RX])
+		while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_RX])))
+			kfree_skb(skb);
 	mutex_unlock(&vsock->rx_lock);
 
 	mutex_lock(&vsock->tx_lock);
-	while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_TX])))
-		kfree_skb(skb);
+	if (vsock->vqs[VSOCK_VQ_TX])
+		while ((skb = virtqueue_detach_unused_buf(vsock->vqs[VSOCK_VQ_TX])))
+			kfree_skb(skb);
 	mutex_unlock(&vsock->tx_lock);
 
 	virtio_vsock_skb_queue_purge(&vsock->send_pkt_queue);
 
 	/* Delete virtqueues and flush outstanding callbacks if any */
 	vdev->config->del_vqs(vdev);
+
+	/*
+	 * del_vqs() has freed the virtqueues. Clear the stale pointers: if a
+	 * later virtio_vsock_restore() fails to allocate new ones, the driver
+	 * stays bound with a dangling vqs[] and the next virtio_vsock_vqs_del()
+	 * would detach a freed virtqueue (use-after-free). Mirrors virtio_blk
+	 * commit 0739c2c6a015.
+	 */
+	memset(vsock->vqs, 0, sizeof(vsock->vqs));
 }
 
 static int virtio_vsock_probe(struct virtio_device *vdev)

---
base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
change-id: 20261001-vsock-restore-uaf-send-1fc7396fa1bd

Best regards,
--  
Jerome Mohm <jrmmhm.kernel@eldare.de>


