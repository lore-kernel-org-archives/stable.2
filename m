Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EC9A4B8265
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 16:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577340; cv=none; b=hmyIYIvjdGUJrENQHoGjXo7phBCOGyfKoQHOw57xqVfntao2QdTtA2HteS0hu8pFN9MG/uRMMdKzAMQ9hBNzFiLNdP7iAsXaGZmHRmd3MQt0oW/G/5RlWwbeidHfwLgLLivrat5WjHSPXNwLn+0jVjyj3fqEQllJo/auk0OXZNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577340; c=relaxed/simple;
	bh=S/FWPnEZMzRiu83r+fOcewMV9IyR4rbu8ueiMJQrszw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dXaV08T/37AHOTMvzGdYrsEkYOZBSvO8BIUBcw78p61sIsD/Fanyl5nauIsPzc5ABuPiNxj3y4/fEMwxmfrWJCksTcv7i7OHCeuesszSad22A85XUWdivLXMgZFZhGbF96chaVkmwCxi+M+uZP4JaHY1Fm4/63q621nrR10u0VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EaO+jUih; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EaO+jUih"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C1B71F0089F;
	Wed, 16 Sep 2026 16:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577331;
	bh=qf4rY7brb6DTMGp6vMXcEIQc/yjgI7kh66DjeA8g7A0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EaO+jUihnC1bdKB1/UnD2V248vbxrfwItU1cMfsEs8Mi4mWJ0KK5yOc63l8pSbx5A
	 8w15YzQ09YFy4ZuVzrC4u/spJti1C29yNaQZnP7K/iyEJiZuil+HixdzhdNqlOFxHR
	 5sYwe6pVtdVrkV049gAgP+pYsPPsBivtbjqarnaunLYWLa68J2u/Av5OthLyYPq8tQ
	 b8w8N5WaZjRPcBolYAv/jd6Sd5LRKgGFyCueUzPeQ0xWICwjX8cj+8TtYxrC2mDBdS
	 O41gW3b2lYxNbmprTLQXhTSXyPjSpEzj9FHhU7O5FSm3jYQABtX6gOHhXtIK5/ExT7
	 KiOFJISqIEvsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xiong Weimin <xiongweimin@kylinos.cn>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] virtio_mmio: disable IRQ wake before free_irq
Date: Wed, 16 Sep 2026 12:48:48 -0400
Message-ID: <20260916164848.542476-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164848.542476-1-sashal@kernel.org>
References: <2026091637-greeting-apple-1005@gregkh>
 <20260916164848.542476-1-sashal@kernel.org>
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
index 33da642ea962a..649e9d5aa1329 100644
--- a/drivers/virtio/virtio_mmio.c
+++ b/drivers/virtio/virtio_mmio.c
@@ -87,6 +87,9 @@ struct virtio_mmio_device {
 
 	void __iomem *base;
 	unsigned long version;
+
+	/* True if enable_irq_wake() succeeded for the shared IRQ. */
+	bool wake_irq_enabled;
 };
 
 /* Configuration interface */
@@ -329,11 +332,17 @@ static void vm_del_vqs(struct virtio_device *vdev)
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
@@ -462,8 +471,9 @@ static int vm_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
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

