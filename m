Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82FAA39E9D5
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568201; cv=none; b=PdbkoOuZktGsWyK61IXscOLojZ7i3l94q+slu+r8ME4yM/oE1Uu2Rzj4133xIIgHJHKgZbkr+xtTsoXiJMJLDllBU+80fmnDzSLu5UVGY2FK3Rm7TfP9woIyH6FbwDYdCcj/vB3LuXBzAzCm9/ij63cn8RtGuPRo3YoAfpgleEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568201; c=relaxed/simple;
	bh=LiBm61wgchOP40bJisbYxkwfu2DKZNjpyMIVOZC94PU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a39dP7nb3x1WY5o0b8ckbWmwgz9bQ6Q1N7gBg7cjeqkdhcpHEjZprtgbx0sTGZ9zcp1/ksSk3rKXzTfxM/8Oy2h3kizA8WX1rX/L69GRDI7GtsaQLgBt7axNrIBAjbebECq16irjlyfYAT1bEG1+UOjl1FN7sqfHHLZVDMqLfr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v6J4Refw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v6J4Refw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91A5D1F000FF;
	Wed, 16 Sep 2026 14:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789568200;
	bh=AoL1CPBVDg7UPwfkbi0yg6uskA+LrMueUXKtznB9WsE=;
	h=Subject:To:Cc:From:Date;
	b=v6J4RefwAyjaVWg9nFDmmF0kbxQd6R5aHY8/4l5TkTjSAZ/4bHkkDVXErmOx+LzDI
	 voaUaymqTyRt7pkclKkR+c2GtIBehlJBUdUDA/woZkk2bhhVTkGmGFxveX1atOFtM7
	 qbdfm07pRoniQPMVBnM4/eUWnU+ynNa0qd/sW358=
Subject: FAILED: patch "[PATCH] virtio_mmio: disable IRQ wake before free_irq" failed to apply to 6.6-stable tree
To: xiongweimin@kylinos.cn,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 15:14:37 +0100
Message-ID: <2026091637-greeting-apple-1005@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x d14d693adb055e98ca705822ba6daebc18602d9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091637-greeting-apple-1005@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d14d693adb055e98ca705822ba6daebc18602d9a Mon Sep 17 00:00:00 2001
From: Xiong Weimin <xiongweimin@kylinos.cn>
Date: Wed, 5 Aug 2026 11:29:37 +0800
Subject: [PATCH] virtio_mmio: disable IRQ wake before free_irq

When the DT node has "wakeup-source", vm_find_vqs() calls
enable_irq_wake() on the shared IRQ, but vm_del_vqs() freed that IRQ
without a matching disable_irq_wake(). That leaves a wake reference
behind and can warn on later free_irq()/request_irq() cycles.

Record whether enable_irq_wake() succeeded, and disable it in
vm_del_vqs() before free_irq().

Fixes: 02213273f72a ("virtio_mmio: add support to set IRQ of a virtio device as wakeup source")
Cc: stable@vger.kernel.org
Signed-off-by: Xiong Weimin <xiongweimin@kylinos.cn>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-ID: <20260805032937.1606737-1-xiongweimin@kylinos.cn>

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 316f03b97356..faae58e3401a 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -88,6 +88,9 @@ struct virtio_mmio_device {
 
 	void __iomem *base;
 	unsigned long version;
+
+	/* True if enable_irq_wake() succeeded for the shared IRQ. */
+	bool wake_irq_enabled;
 };
 
 /* Configuration interface */
@@ -336,11 +339,17 @@ static void vm_del_vqs(struct virtio_device *vdev)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	struct virtqueue *vq, *n;
+	int irq = platform_get_irq(vm_dev->pdev, 0);
 
 	list_for_each_entry_safe(vq, n, &vdev->vqs, list)
 		vm_del_vq(vq);
 
-	free_irq(platform_get_irq(vm_dev->pdev, 0), vm_dev);
+	if (vm_dev->wake_irq_enabled) {
+		disable_irq_wake(irq);
+		vm_dev->wake_irq_enabled = false;
+	}
+
+	free_irq(irq, vm_dev);
 }
 
 static void vm_synchronize_cbs(struct virtio_device *vdev)
@@ -467,8 +476,9 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	if (err)
 		return err;
 
-	if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-source"))
-		enable_irq_wake(irq);
+	if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-source") &&
+	    !enable_irq_wake(irq))
+		vm_dev->wake_irq_enabled = true;
 
 	for (i = 0; i < nvqs; ++i) {
 		struct virtqueue_info *vqi = &vqs_info[i];

