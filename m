Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85ED7211A28
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 00:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784247886; cv=none; b=AcylFhskQIJ+QjAlB4njB6U3NS/XWOikrbXnsEfd/mqHEnBNljoIop4gYd2CPGF1Ron1d+VKuMT9lkIiukjNZuaHDATRbter+iushtqaT36OvhHRv6pnf4x+8jqg1XVLomt1jNID2C+FmltmIwhldPvgW7pA1UWc7xucl910J5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784247886; c=relaxed/simple;
	bh=JCyh+AtN6PAa02kmcYI4QuJSIXU7zu3BHW7iW+Zlpy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pEC+GWgbE4QeIWtRu65K07r1tqzaPeJeEi0CBREXMoUbWNI2bf2Yr6eHtaEUlKbMR9pJBi6QjSVkal57otluxJL6K0SGcVx5ESz0qqfT2QOapFdvtoXX2ZSekzZ1JKMWy6ZrAZC3lfkTPCE3eqvnYLO51pBJ+RWKI/WP47Zc2+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZI4yXMxc; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linkl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZI4yXMxc"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-38dd87656d3so6167665a91.2
        for <stable@vger.kernel.org>; Thu, 16 Jul 2026 17:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784247884; x=1784852684; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kvV/YUs48FxJuWf2yjxeyeKt50HRM0qCcCCbR1JgotU=;
        b=ZI4yXMxc8fFcATYQWBJmXgjV6gRM5jQ1EMNnri10Vxc2LAAaYNMP2/PgYx5QLOum94
         Cxj5O1s8zrH1MTOcvujOcaElCGAAJSLG1Cj/B7hkFoNAHtNkCuA729tMK9cDd1hB9P9u
         polwWFeF5+F1bw1mIMCXjJJfLfWp+ujy0uqQ5Xi8F24FK/4tFDWNrSu1loUs+pmzo+qm
         uc18QTxPfARafGRh+NzarTy0JxZMPl7u4TCc8+EokUEJN7quEaf/VtAnwOxHBndFc0RD
         UtaA4AIyyBxf3B0PdL47QawgjnVuW8TYHrglyMMmTgerMPhpNmBu0nFXC/8j+x9u79V0
         2JYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784247884; x=1784852684;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kvV/YUs48FxJuWf2yjxeyeKt50HRM0qCcCCbR1JgotU=;
        b=hbwO4DJJfmxh6EO7RXZw01RaE/7aPUGnl9ojRQBsuwFIjXJLGI+3LSh5AnaqnSepqS
         F0tF19BHDh0T9XbZTlckpvI7yYULykKtao7OZhDp7Qt2VJ9rAFXgib6BCmZFOVmlAFTJ
         oWjN4hOQ3tWcq/I5orA34YPFlRuDGJNk9R6rc1P0fIwdoHRWgY0Ebx3IA/SXNFT9vtX2
         H80FWtpc644DV/sS0oGbkyvwWFR2V9cvthSCGEeCPQmmx0vXscFH8AO+6kTs/SmOJr/Y
         eiiMktiGDsAbHCNp1/YP9za48WjW9/FZDCv/pYkRdOLb0dyf41NlwWuTwXbz5tVz80ye
         pVWQ==
X-Forwarded-Encrypted: i=1; AHgh+RqRr6neyR13V+lPTYry+XF28jEKcaXZtlU1sf9LzMA5wJUmbq0FSAPPibeMr8+wlzbJh0xdytE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPhae8YEDkhNrX1PCtQ//dniecs+WPzEKKZzmU9Pxr8CWs1qZM
	UY0nmhTMzKiyQZCTS98ANvCeU0TjS2+khG8ZmeWhP2emTEWSD31Nh90U1kS6wvF0tKSbcsTgBa1
	C0g==
X-Received: from pjbds23.prod.google.com ([2002:a17:90b:8d7:b0:389:a1f7:c74d])
 (user=linkl job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1345:b0:37f:9ce1:cdb0
 with SMTP id 98e67ed59e1d1-38e4b55aeccmr247935a91.30.1784247883538; Thu, 16
 Jul 2026 17:24:43 -0700 (PDT)
Date: Fri, 17 Jul 2026 00:22:21 +0000
In-Reply-To: <20260717002311.681748-1-linkl@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717002311.681748-1-linkl@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260717002311.681748-3-linkl@google.com>
Subject: [PATCH v2 2/2] virtio_balloon: avoid shrinker execution during PM suspend
From: Link Lin <linkl@google.com>
To: Andrew Morton <akpm@linux-foundation.org>, Vlastimil Babka <vbabka@kernel.org>, 
	"Michael S . Tsirkin" <mst@redhat.com>, David Hildenbrand <david@kernel.org>
Cc: virtualization@lists.linux.dev, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, prasin@google.com, rientjes@google.com, 
	duenwen@google.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com, 
	Ammar Faizi <ammarfaizi2@openresty.com>, jiaqiyan@google.com, ahwilkins@google.com, 
	Greg Thelen <gthelen@google.com>, Alexander Duyck <alexander.duyck@gmail.com>, jthoughton@google.com, 
	stable@vger.kernel.org, Link Lin <linkl@google.com>
Content-Type: text/plain; charset="UTF-8"

During PM freeze (e.g. S4 hibernation), virtballoon_freeze() calls
remove_common() which resets the virtio device and deletes all virtqueues.
However, the balloon shrinker remains registered with core MM.

If memory pressure occurs during S4 hibernation image creation/saving, MM
invokes virtio_balloon_shrinker_scan(), which attempts to reclaim free
pages. Although return_free_pages_to_mm() only frees pages back to MM,
reclaiming free pages under memory pressure can trigger page reporting
which might access the deleted reporting virtqueue if it is not yet
frozen, or interact with other parts of the driver in a teardown state.

Avoid this by adding a `suspended` flag to `struct virtio_balloon`. Set
this flag to true in virtballoon_freeze() and false in
virtballoon_restore(). Check this flag in both shrinker callbacks (scan
and count) and return 0 if the device is suspended, preventing any
shrinker execution while virtqueues are deleted. Wrap the lockless reads
in READ_ONCE() and writes in WRITE_ONCE() to prevent compiler
optimization issues and KCSAN data race warnings.

Fixes: 71019de8219b ("virtio_balloon: Add free page hinting support")
Cc: stable@vger.kernel.org
Acked-by: David Rientjes <rientjes@google.com>
Signed-off-by: Link Lin <linkl@google.com>
---
 drivers/virtio/virtio_balloon.c | 49 +++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 088b3a0e6c..38e1166a64 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -68,6 +68,8 @@ struct virtio_balloon {
 	/* Prevent updating balloon when it is being canceled. */
 	spinlock_t stop_update_lock;
 	bool stop_update;
+	/* Prevent shrinker from running while device is suspended. */
+	bool suspended;
 	/* Bitmap to indicate if reading the related config fields are needed */
 	unsigned long config_read_bitmap;
 
@@ -471,9 +473,9 @@ static inline s64 towards_target(struct virtio_balloon *vb)
 	return target - vb->num_pages;
 }
 
-/* Gives back @num_to_return blocks of free pages to mm. */
-static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
-					     unsigned long num_to_return)
+/* Helper: must be called with free_page_list_lock held */
+static unsigned long __return_free_pages_to_mm(struct virtio_balloon *vb,
+					       unsigned long num_to_return)
 {
 	unsigned long num_returned = 0;
 	struct page *page, *next;
@@ -481,8 +483,6 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
 	if (unlikely(!num_to_return))
 		return 0;
 
-	spin_lock_irq(&vb->free_page_list_lock);
-
 	list_for_each_entry_safe(page, next, &vb->free_page_list, lru) {
 		list_del(&page->lru);
 		__free_pages(page, VIRTIO_BALLOON_HINT_BLOCK_ORDER);
@@ -490,11 +490,27 @@ static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
 			break;
 	}
 	vb->num_free_page_blocks -= num_returned;
-	spin_unlock_irq(&vb->free_page_list_lock);
 
 	return num_returned;
 }
 
+/* Gives back @num_to_return blocks of free pages to mm. */
+static unsigned long return_free_pages_to_mm(struct virtio_balloon *vb,
+					     unsigned long num_to_return)
+{
+	unsigned long ret;
+
+	spin_lock_irq(&vb->free_page_list_lock);
+	if (vb->suspended) {
+		spin_unlock_irq(&vb->free_page_list_lock);
+		return 0;
+	}
+	ret = __return_free_pages_to_mm(vb, num_to_return);
+	spin_unlock_irq(&vb->free_page_list_lock);
+
+	return ret;
+}
+
 static void virtio_balloon_queue_free_page_work(struct virtio_balloon *vb)
 {
 	if (!virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
@@ -871,6 +887,9 @@ static unsigned long virtio_balloon_shrinker_scan(struct shrinker *shrinker,
 {
 	struct virtio_balloon *vb = shrinker->private_data;
 
+	if (READ_ONCE(vb->suspended))
+		return 0;
+
 	return shrink_free_pages(vb, sc->nr_to_scan);
 }
 
@@ -879,6 +898,9 @@ static unsigned long virtio_balloon_shrinker_count(struct shrinker *shrinker,
 {
 	struct virtio_balloon *vb = shrinker->private_data;
 
+	if (READ_ONCE(vb->suspended))
+		return 0;
+
 	return vb->num_free_page_blocks * VIRTIO_BALLOON_HINT_BLOCK_PAGES;
 }
 
@@ -1089,8 +1111,11 @@ static void remove_common(struct virtio_balloon *vb)
 	update_balloon_size(vb);
 
 	/* There might be free pages that are being reported: release them. */
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
-		return_free_pages_to_mm(vb, ULONG_MAX);
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
+		spin_lock_irq(&vb->free_page_list_lock);
+		__return_free_pages_to_mm(vb, ULONG_MAX);
+		spin_unlock_irq(&vb->free_page_list_lock);
+	}
 
 	/* Now we reset the device so we can clean up the queues. */
 	virtio_reset_device(vb->vdev);
@@ -1133,6 +1158,10 @@ static int virtballoon_freeze(struct virtio_device *vdev)
 	 * The workqueue is already frozen by the PM core before this
 	 * function is called.
 	 */
+	spin_lock_irq(&vb->free_page_list_lock);
+	WRITE_ONCE(vb->suspended, true);
+	spin_unlock_irq(&vb->free_page_list_lock);
+
 	remove_common(vb);
 	return 0;
 }
@@ -1148,6 +1177,10 @@ static int virtballoon_restore(struct virtio_device *vdev)
 
 	virtio_device_ready(vdev);
 
+	spin_lock_irq(&vb->free_page_list_lock);
+	WRITE_ONCE(vb->suspended, false);
+	spin_unlock_irq(&vb->free_page_list_lock);
+
 	if (towards_target(vb))
 		virtballoon_changed(vdev);
 	update_balloon_size(vb);
-- 
2.55.0.229.g6434b31f56-goog

