Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=34.218.115.239
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795197363;
	b=tmBlthxKZ29gvZq8L3MbJGWhX4j353g0Mh7Deg64KYWb+Or8UICyz0HfTkpFjf2cwuiz
	 5UpcoXMxbQwk0HSBDzCNCMQ86EMVl7uc1+G47LbhIu5mSG2psy4QSF0bzxOgdt/RdlGkX
	 4LaVRd9vB4qvYmzYD0iUJO0lyLnjB+3V78oGstfV70XPfA1aagwCgr+Xh/o8hqwLbFbhi
	 1E2BEts66Dea3bgh0cBeCYv6POyAbRtAKcKoP7uEqxNTBmHZGTfT59N3RaeoDf1kjFbid
	 qlndGUcHaNReHcvsIxcmusGwrz4BgUdNjfzfQLjnt+VKjxDoekdiB29T71CWastD/9w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795197363;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:Received:Received:X-Farcaster-Flow-ID:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=TQA1t/z07MHDgwRvVNmYH44lQ4Hq2Vg1kB4U9sqhCnw=;
	b=mdpOTA9KNfIYjerJY2sUZ7++cRlyAMvjC0131s6xHot5DRRDfLBhGsiwjXhKrbWlHgq6
	 oxIJXc15qtmj4nUIycBAfxv2YaXIk1+LQ2+1l8PzeFo21CkACmSR+X8OYD5+YMAecIagd
	 ffFAz6patzxpWloSnmITPqACGAwiJ0I9bnI2+JOpLgJdOujQN6MOEF+d/kGK4IYNvGHg4
	 3eUlxsk5bphryoNmln202p9asstH4CBmBynqbVGECMW0DmgZhlkHjS3WwYnua5kBT9/sd
	 r1amDtqbPlgjr2pJKr3VPyRze3Fy7jDT6Ustu0ntA2jz7nHsb9eQ6INke6kbgQy5S0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amazon.de;
	spf=pass smtp.mailfrom=amazon.de;
	dkim=pass header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=mCPGSUsy;
	arc=none smtp.remote-ip=34.218.115.239
Received: from pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com (pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com [34.218.115.239])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CAF606A829
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 17:55:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70CAF606A829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=amazon.de header.i=@amazon.de header.a=rsa-sha256 header.s=amazoncorp2 header.b=mCPGSUsy
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazoncorp2;
  t=1795197356; x=1826733356;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TQA1t/z07MHDgwRvVNmYH44lQ4Hq2Vg1kB4U9sqhCnw=;
  b=mCPGSUsyRqvKuyIuPszugivnKsRKOqPxVp8XRVhenoenP7zB1PytSiZU
   +bT5vLHe9Rnc8YRK4wzSFz/LXHBCAdaX1b+ZRa+JM1j8kKmafgOMd5sVV
   A3hY2WRTTW+F7Wt4QoeS3Gs+02d87nnGakjBgvZ8a3gq65kMnXj6UPKdA
   9eYLcD1PIrG0SzmI1CFtnvhXHAhnkKhhWXT2Q6Iyv5ERmXaD8G/opz1Rp
   1XAxW1+eGA2kucO/UrvPwCBmCG5O27fi/6unmGeRdDv92gtGzfT7sKutp
   Y+SXdyW7N3oxWIG0FAcBQM8pP/FGPqZX0Mqyab9uwZt402B4RhBQd56/2
   Q==;
X-CSE-ConnectionGUID: UpktH0I7T8aEnCkIaCr1Hg==
X-CSE-MsgGUID: I5c/bu4IRZ+paHbfnEBlrg==
X-IronPort-AV: E=Sophos;i="6.27,223,1787011200"; 
   d="scan'208";a="34516653"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
  by internal-pdx-out-013.esa.us-west-2.outbound.mail-perimeter.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2026 17:55:54 +0000
Received: from EX19MTAUWA001.ant.amazon.com [205.251.233.236:27920]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.50.116:2525] with esmtp (Farcaster)
 id c6b91c2e-d03d-4de0-bad7-700200c06897; Fri, 20 Nov 2026 17:55:53 +0000 (UTC)
X-Farcaster-Flow-ID: c6b91c2e-d03d-4de0-bad7-700200c06897
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57;
 Fri, 20 Nov 2026 17:55:53 +0000
Received: from dev-dsk-gyokhan-1a-87ab81cc.eu-west-1.amazon.com
 (10.253.85.128) by EX19D001UWA001.ant.amazon.com (10.13.138.214) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.57; Fri, 20 Nov 2026
 17:55:51 +0000
From: Gyokhan Kochmarla <gyokhan@amazon.de>
To: <stable@vger.kernel.org>
CC: Mike Rapoport <rppt@kernel.org>, Andrew Morton
	<akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>,
	<linux-mm@kvack.org>, Benjamin Tissoires <bentiss@kernel.org>, Jiri Kosina
	<jikos@kernel.org>, Luis Chamberalin <mcgrof@kernel.org>
Subject: [PATCH 6.18.y 2/2] mm/execmem: make sure ROX cache always contains multiples of PMD_SIZE
Date: Fri, 20 Nov 2026 17:49:19 +0000
Message-ID: <20261120174919.3789837-3-gyokhan@amazon.de>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20261120174919.3789837-1-gyokhan@amazon.de>
References: <20261120174919.3789837-1-gyokhan@amazon.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA003.ant.amazon.com (10.13.139.47) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

commit 569db54d8b7a4ec463a62c444de0d6f5f10e9dc1 upstream.

The ROX cache relies on its chunks being PMD mapped.  For a PMD mapped
chunk, set_memory_rox() updates the direct map alias one PMD at a time and
the large mappings there survive.

When execmem refills the cache, it rounds up the requested allocation size
to PMD_SIZE and tries to allocate that with vmalloc(VM_ALLOW_HUGE_VMAP).
If that allocation fails, execmem falls back to vmalloc() of the original
size.

There are two issues with this approach:
* If huge pages are not available, __vmalloc_node_range() silently falls
  back to base pages. The area execmem gets is virtually contiguous, but it
  is backed by 512 scattered base pages.

  Permission updates on such areas split large mappings in the direct map
  that contain those base pages, up to 512 PMD splits in the worst case.

* execmem's own fallback adds a small base page mapped area to the cache.
  This adds the overhead of cache management to these allocations with no
  benefit of reducing fragmentation either in the vmalloc/modules address
  space or in the direct map.

  Worse, these areas are never freed from the cache, because
  execmem_cache_clean() releases only chunks that are a multiple of
  PMD_SIZE and aligned to PMD_SIZE, exactly to minimize the number of base
  page mappings.

Add VM_REQUIRE_HUGE_VMAP option to vmalloc that fails if the allocation of
huge pages fails or if such an allocation is not possible because huge
page allocations in vmalloc were disabled or the architecture does not
support them.

Use this option when populating the ROX cache.  If
vmalloc(VM_REQUIRE_HUGE_VMAP) fails or vmalloc of huge pages is
unavailable, handle the memory allocation outside the ROX cache with plain
vmalloc().

Since the fallback allocation has to return ROX memory, add an
execmem_alloc_rox() helper and use it for both populating the ROX cache
and dealing with a fallback allocation in a ROX execmem_range.

With that, the cache only ever contains PMD aligned chunks sized as a
multiple of PMD_SIZE, and the PMD checks in execmem_cache_clean() become a
VM_WARN_ON_ONCE() to ensure that the PMD mapping invariant does not
change.

Link: https://lore.kernel.org/20260903-execmem-rox-cache-pmd-v1-v1-3-11beb2a3d249@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Assisted-by: copilot:claude-opus-5
Cc: Benjamin Tissoires <bentiss@kernel.org>
Cc: Jiri Kosina <jikos@kernel.org>
Cc: Luis Chamberalin <mcgrof@kernel.org>
Cc: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
[ 6.18: 4c4b2ed5b783 ("mm/execmem: use VM_FLUSH_RESET_PERMS for ROX cache
  allocations") and its prerequisite set_area_direct_map() changes are
  absent, so 6.18 still restores the direct map of cache chunks with
  execmem_set_direct_map_valid(). Keep that handling for cache chunks:
  execmem_vmalloc_rox() does not call set_vm_flush_reset_perms(), and the
  populate error path still restores the direct map before vfree().
  The uncached fallback is freed by plain vfree(), so execmem_alloc_rox()
  passes VM_FLUSH_RESET_PERMS, matching the non-ROX execmem_vmalloc() path.
  In mm/vmalloc.c only the kerneldoc context differs; the code hunks are
  identical to upstream. ]
Signed-off-by: Gyokhan Kochmarla <gyokhan@amazon.de>
---
 include/linux/vmalloc.h |  1 +
 mm/execmem.c            | 77 +++++++++++++++++++++++++----------------
 mm/vmalloc.c            | 15 +++++++-
 3 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 380dcc5a470e..f8f3cb2dafab 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -38,6 +38,7 @@ struct iov_iter;		/* in uio.h */
 #define VM_DEFER_KMEMLEAK	0
 #endif
 #define VM_SPARSE		0x00001000	/* sparse vm_area. not all pages are present. */
+#define VM_REQUIRE_HUGE_VMAP	0x00002000	/* huge page mapping or nothing */
 
 /* bits [20..32] reserved for arch specific ioremap internals */
 
diff --git a/mm/execmem.c b/mm/execmem.c
index cce6a2ac66b4..be9b4e5ea37a 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -50,7 +50,8 @@ static void *execmem_vmalloc(struct execmem_range *range, size_t size,
 	}
 
 	if (!p) {
-		pr_warn_ratelimited("unable to allocate memory\n");
+		if (!(vm_flags & VM_REQUIRE_HUGE_VMAP))
+			pr_warn_ratelimited("unable to allocate memory\n");
 		return NULL;
 	}
 
@@ -167,10 +168,9 @@ static void execmem_cache_clean(struct work_struct *work)
 		struct vm_struct *vm = find_vm_area(area);
 		size_t size = mas_range_len(&mas);
 
-		if (vm && get_vm_area_size(vm) == size &&
-		    IS_ALIGNED(size, PMD_SIZE) &&
-		    IS_ALIGNED(mas.index, PMD_SIZE)) {
-			struct vm_struct *vm = find_vm_area(area);
+		if (vm && get_vm_area_size(vm) == size) {
+			VM_WARN_ON_ONCE(!IS_ALIGNED(mas.index, PMD_SIZE) ||
+					!IS_ALIGNED(size, PMD_SIZE));
 
 			/*
 			 * Preallocate to ensure mas_store does not fail
@@ -288,36 +288,41 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 	return execmem_cache_alloc_locked(range, size);
 }
 
-static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t size)
+static void *execmem_vmalloc_rox(struct execmem_range *range, size_t size,
+				 unsigned long vm_flags)
 {
-	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
-	struct mutex *mutex = &execmem_cache.mutex;
-	struct vm_struct *vm;
-	size_t alloc_size;
-	int err = -ENOMEM;
-	void *p;
-
-	alloc_size = round_up(size, PMD_SIZE);
-	p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
-	if (!p) {
-		alloc_size = size;
-		p = execmem_vmalloc(range, alloc_size, PAGE_KERNEL, vm_flags);
-	}
+	void *p = execmem_vmalloc(range, size, PAGE_KERNEL, vm_flags);
+	int err;
 
 	if (!p)
 		return NULL;
 
-	vm = find_vm_area(p);
-	if (!vm)
-		goto err_free_mem;
-
 	/* fill memory with instructions that will trap */
-	execmem_fill_trapping_insns(p, alloc_size);
+	execmem_fill_trapping_insns(p, size);
 
-	err = set_memory_rox((unsigned long)p, vm->nr_pages);
+	err = set_memory_rox((unsigned long)p, size >> PAGE_SHIFT);
 	if (err)
 		goto err_free_mem;
 
+	return p;
+
+err_free_mem:
+	vfree(p);
+	return NULL;
+}
+
+static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t size)
+{
+	unsigned long vm_flags = VM_REQUIRE_HUGE_VMAP;
+	size_t alloc_size = round_up(size, PMD_SIZE);
+	struct mutex *mutex = &execmem_cache.mutex;
+	int err;
+	void *p;
+
+	p = execmem_vmalloc_rox(range, alloc_size, vm_flags);
+	if (!p)
+		return NULL;
+
 	/*
 	 * New memory blocks must be allocated and added to the cache
 	 * as an atomic operation, otherwise they may be consumed
@@ -336,12 +341,16 @@ static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t si
 
 err_reset_direct_map:
 	mutex_unlock(mutex);
-	execmem_set_direct_map_valid(vm, true);
-err_free_mem:
+	execmem_set_direct_map_valid(find_vm_area(p), true);
 	vfree(p);
 	return NULL;
 }
 
+static void *execmem_alloc_rox(struct execmem_range *range, size_t size)
+{
+	return execmem_vmalloc_rox(range, size, VM_FLUSH_RESET_PERMS);
+}
+
 static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
 {
 	void *p;
@@ -469,6 +478,11 @@ static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
 	return NULL;
 }
 
+static void *execmem_alloc_rox(struct execmem_range *range, size_t size)
+{
+	return NULL;
+}
+
 static bool execmem_cache_free(void *ptr)
 {
 	return false;
@@ -478,17 +492,20 @@ static bool execmem_cache_free(void *ptr)
 void *execmem_alloc(enum execmem_type type, size_t size)
 {
 	struct execmem_range *range = &execmem_info->ranges[type];
-	bool use_cache = range->flags & EXECMEM_ROX_CACHE;
+	bool use_rox_cache = range->flags & EXECMEM_ROX_CACHE;
 	unsigned long vm_flags = VM_FLUSH_RESET_PERMS;
 	pgprot_t pgprot = range->pgprot;
 	void *p = NULL;
 
 	size = PAGE_ALIGN(size);
 
-	if (use_cache)
+	if (use_rox_cache) {
 		p = execmem_cache_alloc(range, size);
-	else
+		if (!p)
+			p = execmem_alloc_rox(range, size);
+	} else {
 		p = execmem_vmalloc(range, size, pgprot, vm_flags);
+	}
 
 	return kasan_reset_tag(p);
 }
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 60025b682bc0..747fade971a5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3844,6 +3844,12 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
  * Map them into contiguous kernel virtual space, using a pagetable
  * protection of @prot.
  *
+ * %VM_ALLOW_HUGE_VMAP allocates huge pages when possible and falls back to
+ * base pages if huge page allocation fails.
+ *
+ * %VM_REQUIRE_HUGE_VMAP implies %VM_ALLOW_HUGE_VMAP and fails instead of
+ * silently falling back to base pages.
+ *
  * Return: the address of the area or %NULL on failure
  */
 void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
@@ -3867,6 +3873,10 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		return NULL;
 	}
 
+	/* VM_REQUIRE_HUGE_VMAP implies VM_ALLOW_HUGE_VMAP */
+	if (vm_flags & VM_REQUIRE_HUGE_VMAP)
+		vm_flags |= VM_ALLOW_HUGE_VMAP;
+
 	if (vmap_allow_huge && (vm_flags & VM_ALLOW_HUGE_VMAP)) {
 		/*
 		 * Try huge pages. Only try for PAGE_KERNEL allocations,
@@ -3883,6 +3893,9 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 		align = max(original_align, 1UL << shift);
 	}
 
+	if ((vm_flags & VM_REQUIRE_HUGE_VMAP) && shift == PAGE_SHIFT)
+		return NULL;
+
 again:
 	area = __get_vm_area_node(size, align, shift, VM_ALLOC |
 				  VM_UNINITIALIZED | vm_flags, start, end, node,
@@ -3956,7 +3969,7 @@ void *__vmalloc_node_range_noprof(unsigned long size, unsigned long align,
 	return area->addr;
 
 fail:
-	if (shift > PAGE_SHIFT) {
+	if (shift > PAGE_SHIFT && !(vm_flags & VM_REQUIRE_HUGE_VMAP)) {
 		shift = PAGE_SHIFT;
 		align = original_align;
 		goto again;
-- 
2.50.1

