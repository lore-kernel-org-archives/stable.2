Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2150C282
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789568204; cv=none; b=Jcq1UDCfxuDks1X+htNX+Fym4BABPH12XC7398yUnlxFzGi8mW/SkBSx5cp/IHy2xzGUbSPzLr6CzD1O1T2d9MilQ8ZoNEtDXprWFwVaV1r7/S4EvtiouogGWEW/BCAKdBBcbZkzLCsC63HP+UTZyq5CWGgQsXIoadrdtUQwDyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789568204; c=relaxed/simple;
	bh=egq42kucDhVxN2QhepAXYUzrY7mJFTjozTHojZ4DfnM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=u0CIOLkfML9TnKhXlxf4gdXDteNZWqpae343HqUZ8wLrKI45oxNee35iyUCR0f6NjsK1onkO/63IbDqNgjiBNxHvRhAtBF54SceF3W2viPBvJfOOiHJZ/QV1VT8blWyHuvffSH38tSDNkheoGFe9A23iJsTmTPuNlLDW4c6RMBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mZeDrKrO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mZeDrKrO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C3551F000FF;
	Wed, 16 Sep 2026 14:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789568203;
	bh=EfU6zBOAVKzQ4RTxWdo4j3CSESJjwKzy4USym9zwBmo=;
	h=Subject:To:Cc:From:Date;
	b=mZeDrKrOJyReGu+vIZsJ30Ue7RxQRqE924SBf4S10l3cKuK6IBXxyUMCrw5TGMaW6
	 xktfqxkMQaWTMYxuJgoqMllaQB2K4v6VoPjAsJfzzmpkacuBtUSCmBd201AT21q9YF
	 cptPs9TGgmvITAo2GEZqnPUYX2fQiSA6iGdeSSLE=
Subject: FAILED: patch "[PATCH] virtio_mmio: disable IRQ wake before free_irq" failed to apply to 6.1-stable tree
To: xiongweimin@kylinos.cn,mst@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 15:14:38 +0100
Message-ID: <2026091638-remorse-obliged-6c4a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
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
git cherry-pick -x d14d693adb055e98ca705822ba6daebc18602d9a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091638-remorse-obliged-6c4a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

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

