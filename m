Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8764D51C34F
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789576396; cv=none; b=HJSNOK+QCRLf468AcKbpl3u85pBwlg2ONxsAVovEgaX2vKyQmDSyYEVCNZO8g2eVhYxiZYx4rWgMNnrzW9hAGlOZovB+T1zgmgoseDb9oMMw/316VKz2kot7GoKPOY8UPloa0gPCqPukgxXd87MBddvshnjdziTWUpN+X5zEIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789576396; c=relaxed/simple;
	bh=7ij4r4eF78s/uaE71EelS8lNJg4TJz+o6VXcnWHw/2g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQoW3VE0K4gKzWATwkv2dy9IGvMfW101K5qJL5FmOJ5fEHcHhln+KLH6GdNkb7Os0L1OxsecV3lDnpREffWjQDPC5IKa1rk4kB7F0gMniJDcxuwOvmxI6ff1DjK4iQxAG562EHX5Hc24kRUCNErezHZfJP5QogldCb9VtWDtoXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mw1kwUWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mw1kwUWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2A421F000FF;
	Wed, 16 Sep 2026 16:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789576393;
	bh=cG+SLAdkEYOEkic+MZtePmWFkPKT5brwTes7L5zfqos=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mw1kwUWDXARrScQG8IMi7BgFeE5g00HYFPABHUybDYjsFtUd/o119MI8gtjkxfhdY
	 JyxyImE94IaHeVWX/9GzkII/SpWGx+ARlZca3NJMxUrrNPq0y9vcbBVovw1rrRoQjw
	 p13loqE+c8eLfIrK96j0az7B515hpRRxOjZH1Oykht2UgBIcFK4Ux4LEoakKD/KIYK
	 6ApdWqNjhLPzBSnRyYlDClYkUCy3ucXNI9Q+j2GUEQj7BO2NVUNcd7GQ4aX7pGL8Ni
	 P2tpe96+LHyVxsMrZuJVqhNWr5iQwq1dqYSDEA5MwlxhbIXuaV6oqkBpdGGXUIgCBN
	 n3n5+F/AeiPZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Viresh Kumar <viresh.kumar@linaro.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] virtio-mmio: Remove virtqueue list from mmio device
Date: Wed, 16 Sep 2026 12:33:10 -0400
Message-ID: <20260916163311.416714-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091636-caloric-bunt-1eeb@gregkh>
References: <2026091636-caloric-bunt-1eeb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Viresh Kumar <viresh.kumar@linaro.org>

[ Upstream commit 564a69ad90d15c782176e1a8c9e1c95661e1aed0 ]

The MMIO transport implementation creates a list of virtqueues for a
virtio device, while the same is already available in the struct
virtio_device.

Don't create a duplicate list, and use the other one instead.

While at it, fix the virtio_device_for_each_vq() macro to accept an
argument like "&vm_dev->vdev" (which currently fails to build).

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
Message-Id: <3e56c6f74002987e22f364d883cbad177cd9ad9c.1747827066.git.viresh.kumar@linaro.org>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Stable-dep-of: d14d693adb05 ("virtio_mmio: disable IRQ wake before free_irq")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mmio.c | 52 +++---------------------------------
 include/linux/virtio.h       |  2 +-
 2 files changed, 4 insertions(+), 50 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index b4422e8c2e939..22fdc6ba6f841 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -65,7 +65,6 @@
 #include <linux/platform_device.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
-#include <linux/spinlock.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <uapi/linux/virtio_mmio.h>
@@ -88,22 +87,8 @@ struct virtio_mmio_device {
 
 	void __iomem *base;
 	unsigned long version;
-
-	/* a list of queues so we can dispatch IRQs */
-	spinlock_t lock;
-	struct list_head virtqueues;
-};
-
-struct virtio_mmio_vq_info {
-	/* the actual virtqueue */
-	struct virtqueue *vq;
-
-	/* the list node for the virtqueues list */
-	struct list_head node;
 };
 
-
-
 /* Configuration interface */
 
 static u64 vm_get_features(struct virtio_device *vdev)
@@ -300,9 +285,8 @@ static bool vm_notify_with_data(struct virtqueue *vq)
 static irqreturn_t vm_interrupt(int irq, void *opaque)
 {
 	struct virtio_mmio_device *vm_dev = opaque;
-	struct virtio_mmio_vq_info *info;
+	struct virtqueue *vq;
 	unsigned long status;
-	unsigned long flags;
 	irqreturn_t ret = IRQ_NONE;
 
 	/* Read and acknowledge interrupts */
@@ -315,10 +299,8 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 	}
 
 	if (likely(status & VIRTIO_MMIO_INT_VRING)) {
-		spin_lock_irqsave(&vm_dev->lock, flags);
-		list_for_each_entry(info, &vm_dev->virtqueues, node)
-			ret |= vring_interrupt(irq, info->vq);
-		spin_unlock_irqrestore(&vm_dev->lock, flags);
+		virtio_device_for_each_vq(&vm_dev->vdev, vq)
+			ret |= vring_interrupt(irq, vq);
 	}
 
 	return ret;
@@ -329,14 +311,8 @@ static irqreturn_t vm_interrupt(int irq, void *opaque)
 static void vm_del_vq(struct virtqueue *vq)
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
-	struct virtio_mmio_vq_info *info = vq->priv;
-	unsigned long flags;
 	unsigned int index = vq->index;
 
-	spin_lock_irqsave(&vm_dev->lock, flags);
-	list_del(&info->node);
-	spin_unlock_irqrestore(&vm_dev->lock, flags);
-
 	/* Select and deactivate the queue */
 	writel(index, vm_dev->base + VIRTIO_MMIO_QUEUE_SEL);
 	if (vm_dev->version == 1) {
@@ -347,8 +323,6 @@ static void vm_del_vq(struct virtqueue *vq)
 	}
 
 	vring_del_virtqueue(vq);
-
-	kfree(info);
 }
 
 static void vm_del_vqs(struct virtio_device *vdev)
@@ -375,9 +349,7 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 {
 	struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vdev);
 	bool (*notify)(struct virtqueue *vq);
-	struct virtio_mmio_vq_info *info;
 	struct virtqueue *vq;
-	unsigned long flags;
 	unsigned int num;
 	int err;
 
@@ -399,13 +371,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		goto error_available;
 	}
 
-	/* Allocate and fill out our active queue description */
-	info = kmalloc(sizeof(*info), GFP_KERNEL);
-	if (!info) {
-		err = -ENOMEM;
-		goto error_kmalloc;
-	}
-
 	num = readl(vm_dev->base + VIRTIO_MMIO_QUEUE_NUM_MAX);
 	if (num == 0) {
 		err = -ENOENT;
@@ -463,13 +428,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		writel(1, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
 	}
 
-	vq->priv = info;
-	info->vq = vq;
-
-	spin_lock_irqsave(&vm_dev->lock, flags);
-	list_add(&info->node, &vm_dev->virtqueues);
-	spin_unlock_irqrestore(&vm_dev->lock, flags);
-
 	return vq;
 
 error_bad_pfn:
@@ -481,8 +439,6 @@ static struct virtqueue *vm_setup_vq(struct virtio_device *vdev, unsigned int in
 		writel(0, vm_dev->base + VIRTIO_MMIO_QUEUE_READY);
 		WARN_ON(readl(vm_dev->base + VIRTIO_MMIO_QUEUE_READY));
 	}
-	kfree(info);
-error_kmalloc:
 error_available:
 	return ERR_PTR(err);
 }
@@ -627,8 +583,6 @@ static int virtio_mmio_probe(struct platform_device *pdev)
 	vm_dev->vdev.dev.release = virtio_mmio_release_dev;
 	vm_dev->vdev.config = &virtio_mmio_config_ops;
 	vm_dev->pdev = pdev;
-	INIT_LIST_HEAD(&vm_dev->virtqueues);
-	spin_lock_init(&vm_dev->lock);
 
 	vm_dev->base = devm_platform_ioremap_resource(pdev, 0);
 	if (IS_ERR(vm_dev->base)) {
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index d791d47eb00ed..3ad94d939d281 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -184,7 +184,7 @@ void virtio_reset_device(struct virtio_device *dev);
 size_t virtio_max_dma_size(const struct virtio_device *vdev);
 
 #define virtio_device_for_each_vq(vdev, vq) \
-	list_for_each_entry(vq, &vdev->vqs, list)
+	list_for_each_entry(vq, &(vdev)->vqs, list)
 
 /**
  * struct virtio_driver - operations for a virtio I/O driver
-- 
2.53.0

