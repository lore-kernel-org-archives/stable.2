Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD2C27A916
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 02:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786070179; cv=none; b=SE4VXK86SSkES0KQKaQLNBSziPMjViNEBfVgVYpnqBF6jQVSnEciBZ05aPZbFejjXMfsp4WtPfrPvMcUgJFsCeC7KGfK3j7d5HwWn7fPZ038ZoyMpdXAlrrvMCyNAzwX5oCRf923aDO0HrCmYneHj1zt9zpRz7G4vATepM8tqRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786070179; c=relaxed/simple;
	bh=zL4yhMtlZd0oE5UEQhDrtUrl55D5LGT2vIChVpDHI/M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yh/j3Z9JrQM7dDkmtwy7nWSDgZ+0adlebyebxjE9W7LEhv8VsuSCLm4N+0EjDjRgkeiFCFJQA7NjE1coJfCoWzRu+73u/Jw4Vsx7Bo9CUyEVkmvdyY3rws0StOgymEuiZ6u6/ceOjQ5aBOP8RP1qbutxhFPu3jyXso3W3fa7Bq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iHywtCyK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iHywtCyK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30D761F000E9;
	Fri,  7 Aug 2026 02:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786070178;
	bh=YOCCy76Y78S+z4x9aYEmmLDnqzgGU23b+Hc1QPtYvd4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iHywtCyKyr5DABWHegcndowWebBXCbCEGiec2F+aNsIo4AKPpz6dkK9Q9976wdiuq
	 qRTs6zE86RecbtP0dupTWVi4LLo7S2xRy6XGJimrTJsGVk3hXUcd05ml4qlNRjFfcO
	 HesgnOfp2JozHvu8ECbVLh3FiWnKtBVjKkSwuK20QPFM0pU2KETPy1KHJo38lNoHDF
	 s5Sr4oF3zFDyE3YTS9bTNm4fb4vICTnwcDqpx7F3fZfMS7ZAun3UNkWgKZnSGy9tW7
	 jUblQjUyBS88AypbZD1qFmG9LOAr3LSK8WRN5+rzsqdJPAgeLhOhiVMknnt/4wwO4K
	 qUX6VflKDJrug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Ido Schimmel <idosch@idosch.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] kmemleak: iommu/iova: fix transient kmemleak false positive
Date: Thu,  6 Aug 2026 22:36:14 -0400
Message-ID: <20260807023615.1684238-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072949-quarry-sleet-f3e6@gregkh>
References: <2026072949-quarry-sleet-f3e6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Catalin Marinas <catalin.marinas@arm.com>

[ Upstream commit 7591c127f3b17d5879f18819cad7058bf3a2e276 ]

The introduction of iova_depot_pop() in 911aa1245da8 ("iommu/iova: Make
the rcache depot scale better") confused kmemleak by moving a struct
iova_magazine object from a singly linked list to rcache->depot and
resetting the 'next' pointer referencing it.  Unlike doubly linked lists,
the content of the object being referred is never changed on removal from
a singly linked list and the kmemleak checksum heuristics do not detect
such scenario.  This leads to false positives like:

unreferenced object 0xffff8881a5301000 (size 1024):
  comm "softirq", pid 0, jiffies 4306297099 (age 462.991s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 e7 7d 05 00 00 00 00 00  .........}......
    0f b4 05 00 00 00 00 00 b4 96 05 00 00 00 00 00  ................
  backtrace:
    [<ffffffff819f5f08>] __kmem_cache_alloc_node+0x1e8/0x320
    [<ffffffff818a239a>] kmalloc_trace+0x2a/0x60
    [<ffffffff8231d31e>] free_iova_fast+0x28e/0x4e0
    [<ffffffff82310860>] fq_ring_free_locked+0x1b0/0x310
    [<ffffffff8231225d>] fq_flush_timeout+0x19d/0x2e0
    [<ffffffff813e95ba>] call_timer_fn+0x19a/0x5c0
    [<ffffffff813ea16b>] __run_timers+0x78b/0xb80
    [<ffffffff813ea5bd>] run_timer_softirq+0x5d/0xd0
    [<ffffffff82f1d915>] __do_softirq+0x205/0x8b5

Introduce kmemleak_transient_leak() which resets the object checksum
requiring another scan pass before it is reported (if still unreferenced).
Call this new API in iova_depot_pop().

Link: https://lkml.kernel.org/r/20241104111944.2207155-1-catalin.marinas@arm.com
Link: https://lore.kernel.org/r/ZY1osaGLyT-sdKE8@shredder/
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Reported-by: Ido Schimmel <idosch@idosch.org>
Tested-by: Ido Schimmel <idosch@nvidia.com>
Acked-by: Robin Murphy <robin.murphy@arm.com>
Cc: Joerg Roedel <joro@8bytes.org>
Cc: Will Deacon <will@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: 79c37ae3733e ("mm/kmemleak: fix checksum computation for per-cpu objects")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/dev-tools/kmemleak.rst |  1 +
 drivers/iommu/iova.c                 |  6 +++++
 include/linux/kmemleak.h             |  4 +++
 mm/kmemleak.c                        | 39 ++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/Documentation/dev-tools/kmemleak.rst b/Documentation/dev-tools/kmemleak.rst
index 2cb00b53339fe..7d784e03f3f9d 100644
--- a/Documentation/dev-tools/kmemleak.rst
+++ b/Documentation/dev-tools/kmemleak.rst
@@ -161,6 +161,7 @@ See the include/linux/kmemleak.h header for the functions prototype.
 - ``kmemleak_free_percpu``	 - notify of a percpu memory block freeing
 - ``kmemleak_update_trace``	 - update object allocation stack trace
 - ``kmemleak_not_leak``	 - mark an object as not a leak
+- ``kmemleak_transient_leak``	 - mark an object as a transient leak
 - ``kmemleak_ignore``		 - do not scan or report an object as leak
 - ``kmemleak_scan_area``	 - add scan areas inside a memory block
 - ``kmemleak_no_scan``	 - do not scan a memory block
diff --git a/drivers/iommu/iova.c b/drivers/iommu/iova.c
index 16c6adff3eb7b..5b5400efb6577 100644
--- a/drivers/iommu/iova.c
+++ b/drivers/iommu/iova.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/iova.h>
+#include <linux/kmemleak.h>
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
@@ -673,6 +674,11 @@ static struct iova_magazine *iova_depot_pop(struct iova_rcache *rcache)
 {
 	struct iova_magazine *mag = rcache->depot;
 
+	/*
+	 * As the mag->next pointer is moved to rcache->depot and reset via
+	 * the mag->size assignment, mark it as a transient false positive.
+	 */
+	kmemleak_transient_leak(mag->next);
 	rcache->depot = mag->next;
 	mag->size = IOVA_MAG_SIZE;
 	rcache->depot_size--;
diff --git a/include/linux/kmemleak.h b/include/linux/kmemleak.h
index 6a3cd1bf4680b..93a73c076d169 100644
--- a/include/linux/kmemleak.h
+++ b/include/linux/kmemleak.h
@@ -26,6 +26,7 @@ extern void kmemleak_free_part(const void *ptr, size_t size) __ref;
 extern void kmemleak_free_percpu(const void __percpu *ptr) __ref;
 extern void kmemleak_update_trace(const void *ptr) __ref;
 extern void kmemleak_not_leak(const void *ptr) __ref;
+extern void kmemleak_transient_leak(const void *ptr) __ref;
 extern void kmemleak_ignore(const void *ptr) __ref;
 extern void kmemleak_scan_area(const void *ptr, size_t size, gfp_t gfp) __ref;
 extern void kmemleak_no_scan(const void *ptr) __ref;
@@ -93,6 +94,9 @@ static inline void kmemleak_update_trace(const void *ptr)
 static inline void kmemleak_not_leak(const void *ptr)
 {
 }
+static inline void kmemleak_transient_leak(const void *ptr)
+{
+}
 static inline void kmemleak_ignore(const void *ptr)
 {
 }
diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 0aecd537645a5..13726533b7c5e 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -950,6 +950,28 @@ static void make_black_object(unsigned long ptr, unsigned int objflags)
 	paint_ptr(ptr, KMEMLEAK_BLACK, objflags);
 }
 
+/*
+ * Reset the checksum of an object. The immediate effect is that it will not
+ * be reported as a leak during the next scan until its checksum is updated.
+ */
+static void reset_checksum(unsigned long ptr)
+{
+	unsigned long flags;
+	struct kmemleak_object *object;
+
+	object = find_and_get_object(ptr, 0);
+	if (!object) {
+		kmemleak_warn("Not resetting the checksum of an unknown object at 0x%08lx\n",
+			      ptr);
+		return;
+	}
+
+	raw_spin_lock_irqsave(&object->lock, flags);
+	object->checksum = 0;
+	raw_spin_unlock_irqrestore(&object->lock, flags);
+	put_object(object);
+}
+
 /*
  * Add a scanning area to the object. If at least one such area is added,
  * kmemleak will only scan these ranges rather than the whole memory block.
@@ -1218,6 +1240,23 @@ void __ref kmemleak_not_leak(const void *ptr)
 }
 EXPORT_SYMBOL(kmemleak_not_leak);
 
+/**
+ * kmemleak_transient_leak - mark an allocated object as transient false positive
+ * @ptr:	pointer to beginning of the object
+ *
+ * Calling this function on an object will cause the memory block to not be
+ * reported as a leak temporarily. This may happen, for example, if the object
+ * is part of a singly linked list and the ->next reference to it is changed.
+ */
+void __ref kmemleak_transient_leak(const void *ptr)
+{
+	pr_debug("%s(0x%px)\n", __func__, ptr);
+
+	if (kmemleak_enabled && ptr && !IS_ERR(ptr))
+		reset_checksum((unsigned long)ptr);
+}
+EXPORT_SYMBOL(kmemleak_transient_leak);
+
 /**
  * kmemleak_ignore - ignore an allocated object
  * @ptr:	pointer to beginning of the object
-- 
2.53.0

