Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795596638;
	b=APPUsl6vFN8ElFFxLo514MC9QrPPVCNfvivhjrb/7gPnwNC7rqzs3eIWVGB6y/doPC5T
	 V7gtrOLV1hX/icoyyt7VyRr8R4DEY6ihtU5V6HurckjwcDx9pRVxhYzFWZPMEzJrPZhhf
	 DwuMeL0umR4CkKFehhrfoIL3pHd7fB0g4w2VsrtAmPt2wp4JzuRLL/j0+vJ87azUYGPAi
	 dM6+LKp5vRJAE+lrYc2usLzDF7tpsemdcL9d80Gd9TETJI/G+O3qsoJHoxriKq6zSGccb
	 1sVeixuQDn5+9kSD/MFAOPVTGhy4cpLH24cFVnck86xboVmZ32bLnytHUfUhXXdkuNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795596638;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bwzq8xQn5ZJR5o7aGUbK6kgJ4E+HNU1HSvR6dW/JqPk=;
	b=GOTqxoF0USq8Wf03MLiweQOSEoDDOuIhGjpqJciUHnIpoiL8O5gMBUXxHN+V1DueCVpj
	 btIsKTEcgHtTfdE87fRA3wnhRKa2bpt0ogXMdtoy5h4K3G0//ppga9ownbaYZsgwdlEVI
	 yw2VEBrPBoDRFsEevJNzfA67tprMk/NaT31kiSL+fTVOeGli6TUSGnS2JHxb2NaznDj1B
	 lZR+WBnNFKsK/knVzlaC0rgxmjtblzCPewEd/dXXgx8jpcn5+kT+VqNO2JK6Pg8+RJNSx
	 hiu0CgZtlgi9OcmKyTSbH2D7x7LyuEn403Jmo9X2f22QYMPLUTINEQ9bbcZqtNBJZfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zpqkSkHo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7ED606A32D
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 08:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=zpqkSkHo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEC11F000C0;
	Wed, 25 Nov 2026 08:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795596637;
	bh=bwzq8xQn5ZJR5o7aGUbK6kgJ4E+HNU1HSvR6dW/JqPk=;
	h=Subject:To:Cc:From:Date;
	b=zpqkSkHoS/iJ15hUWXA1GKpeUWqCzddvfIgQEss9wDa3TJcgBqjQyoOCW/ARXkgY+
	 xK996keZmKlg2fYVzceWXxhp7dIlz9GfjppCz1woI878fexAFD0F2euRYfxcFiUXLH
	 W3235URjFd3asbGAWFtB5/nNggM26mk+dFcq5NA8=
Subject: FAILED: patch "[PATCH] vsock/virtio: clear vqs[] to avoid a UAF on a failed PM" failed to apply to 6.1-stable tree
To: jrmmhm.kernel@eldare.de,kuba@kernel.org,sgarzare@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 09:47:39 +0100
Message-ID: <2026112539-sudoku-footbath-dbe4@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 2a24ba1694f14299fbde3fa107e5d56629f2f8b6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112539-sudoku-footbath-dbe4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2a24ba1694f14299fbde3fa107e5d56629f2f8b6 Mon Sep 17 00:00:00 2001
From: Jerome Mohm <jrmmhm.kernel@eldare.de>
Date: Mon, 9 Nov 2026 20:39:24 +0100
Subject: [PATCH] vsock/virtio: clear vqs[] to avoid a UAF on a failed PM
 restore

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

