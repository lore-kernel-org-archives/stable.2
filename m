Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD8C4D0CDB
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 17:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789580118; cv=none; b=O4hBV3S//++AbZwduDxkmRQGhjqB3ByqjCpah+cYKfjdqRsKj/77Ra8slSBm8tHmvvZSWKpgty/8wSEwb5j6w/RBXgrmIHaH4EiHKKQeGJxNLGgXY6F73b0guKalvBaw6EvPHbuQkcDc52cTJVlM9vG7zjlwLzxNxGZav+o3S1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789580118; c=relaxed/simple;
	bh=awrlIELMLgcWIuZwcdk9oXlb1SPFcvPQyalFSSfOOmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFo+Jc6xAoq5JXABArJWXTKxp7SUjctVDEn4c64UE7hd6BF/mUk45TReC21XvvIz9tW6N3p6StKhBqtOC4NHsX9gi8rnTEP0E5egmXHokI6sZvX/yvTjfxgzGeA+BRcX3vaZF/LR/owr7LsYYHFMjg36dQ5gr+HhgCoKPPSG86k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3f4dRS0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3f4dRS0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FA81F00893;
	Wed, 16 Sep 2026 17:35:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789580103;
	bh=lbWhBE4MMcqfwczWErmReqCseXH3XD88LVSSu4zWeE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3f4dRS0jeRB7lwbzzQeC2CDNAATODU+sa2FxcOxn8lhlPf/ilHYU69dHbzDBJwhN
	 QQB4p7FTTP1MjRzZo2NqoqJFgPx1AZaUhDe3KHyjXVKmfvrHDrqE8gMZA17+zT+pXt
	 zYT3SW2qOBYwe+doMeUyejWTgFFB2L/VUwUpvmKJsPxcfYDhc4LYl7KKn0PnICHFr1
	 ZjpyzHXQ2oKwUdOuIIrE1BAGRr5WhxTUZEPnrQfGy5bWjot0QEZZSktK9cyD5syOxM
	 ebkT9f1HDH8MU9LpqHQRem7u6xgXIPE/IdB5LXDg8a2XDjPKB/NiyOSQLO5vULc0e/
	 slLqMs9KEz1mQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiong Weimin <xiongweimin@kylinos.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] virtio_mmio: disable IRQ wake before free_irq
Date: Wed, 16 Sep 2026 13:35:00 -0400
Message-ID: <20260916173500.1132874-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916173500.1132874-1-sashal@kernel.org>
References: <2026091638-remorse-obliged-6c4a@gregkh>
 <20260916173500.1132874-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xiong Weimin <xiongweimin@kylinos.cn>

[ Upstream commit d14d693adb055e98ca705822ba6daebc18602d9a ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/virtio/virtio_mmio.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
index 7909d4aec8a6e..6395b8fba0050 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -86,6 +86,9 @@ struct virtio_mmio_device {
 
 	void __iomem *base;
 	unsigned long version;
+
+	/* True if enable_irq_wake() succeeded for the shared IRQ. */
+	bool wake_irq_enabled;
 };
 
 /* Configuration interface */
@@ -318,11 +321,17 @@ static void vm_del_vqs(struct virtio_device *vdev)
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
@@ -445,8 +454,9 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
 	if (err)
 		return err;
 
-	if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-source"))
-		enable_irq_wake(irq);
+	if (of_property_read_bool(vm_dev->pdev->dev.of_node, "wakeup-source") &&
+	    !enable_irq_wake(irq))
+		vm_dev->wake_irq_enabled = true;
 
 	for (i = 0; i < nvqs; ++i) {
 		if (!names[i]) {
-- 
2.53.0

