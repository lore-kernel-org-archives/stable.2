Received: from mta1.migadu.com (out-24.mta1.migadu.com [95.215.58.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948072C21F7
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 23:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790809665; cv=none; b=CVhiaYms3FbGMN/BO4Hc1RmnQylzCj0AdKUZ9bmQc7v++qp98/vgWXYJsGL6qipPkW/mpZFLM06/CaQExC2ChZ4BalFAq2Cb4sIzEq+RY/rq7GzWov18+Nclgh27pg1tlGYUe3o3XHzJfueS3ODUirGJcj+CLS5yLhA5iQ8SwCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790809665; c=relaxed/simple;
	bh=04ieIlc6aU4Ve4Y+NdGSZT+Urd6ATWlIU5xxlRqKmY0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FaJrwQlRtWP4wauaPWKOKcvbXHaI7t8ozfqr7YHqdGVrlUdIEcnZeaiYuxWRDN13d8vI9JkrWU5ZW3BKzHqFkeuCX1I/v5q+PARM78oExBQxwW+ODmRUnENdkNo+C3dH1Kjiz7ZQ+DYVrctMOesjrVbDg/69NCCnLb7oLFj3c8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vOEddTjI; arc=none smtp.client-ip=95.215.58.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vOEddTjI"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=04ieIlc6aU4Ve4Y+NdGSZT+Urd6ATWlIU5xxlRqKmY0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790809658; v=1; x=1791414458;
 b=vOEddTjIRAERxbVyzBLH+HN1cWKmKSf0/AizpuweP1iO4W4ZkdWQsfTbusJYIvyTOAqxqVtJ
 DK+9u4r7Phxrc5DD7KSG2pJelEEHI75HhCViLOLaKK3gYneVvatD6C65x5MbxKz78dmeaf9CSbZ
 6szyX/lL/22yhFL6mbepg2hw=
X-Envelope-To: stable@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id cd417db66a4fe8dc;
	Wed, 30 Sep 2026 23:07:38 +0000
X-Mizu-Trace-ID: cd417db66a4fe8dc
X-Migadu-Flow: FLOW_OUT
From: Atish Patra <atish.patra@linux.dev>
Date: Wed, 30 Sep 2026 16:07:31 -0700
Subject: [PATCH 6.18.y] mm/execmem: make the populate and alloc atomic
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260930-execmem-atomic-6-18-y-v1-1-bd35d4523aab@meta.com>
X-B4-Tracking: v=1; b=H4sIADKWvWoC/x3MQQ6DIBBG4auYWXcMqEHpVZouCPy2s0ANmEZiv
 HuJy2/x3kkZSZDp2ZyU8JMs61KhHw35r1s+YAnV1KnOKNsrxgEfEdntaxTPhvXEhYPV3g4OARi
 ptlvCLMf9fZFp9dQWel/XH6pK1+RvAAAA
To: stable@vger.kernel.org
Cc: Hubert Mazur <hmazur@google.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mike Rapoport <rppt@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Stanislaw Kardach <skardach@google.com>, 
 Michal Krawczyk <mikrawczyk@google.com>, Slawomir Rosek <srosek@google.com>, 
 Atish Patra <atishp@meta.com>
X-Mailer: b4 0.13.0

From: Hubert Mazur <hmazur@google.com>

[ Upstream commit 1871d548fc4feb007644efb6d669c93a4e191254 ]

When a block of memory is requested from the execmem manager it tries to
find a suitable fragment by traversing the free_areas.  In case there is
no such block, a new memory area is added to the free_areas and then
allocated to the caller by traversing the free_area tree again.

The above operations of allocation and tree traversal are not atomic hence
another request may consume this newly allocated memory block which
results in the allocation failure for the original request.  Such
occurrence can be spotted on devices running the 6.18 kernel during the
parallel modules loading.

To mitigate such resource races execute the cache population and
allocation operations under one mutex lock.

Link: https://lkml.kernel.org/r/20260320075723.779985-1-hmazur@google.com
Signed-off-by: Hubert Mazur <hmazur@google.com>
Reviewed-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Stanislaw Kardach <skardach@google.com>
Cc: Michal Krawczyk <mikrawczyk@google.com>
Cc: Slawomir Rosek <srosek@google.com>
Cc: Hubert Mazur <hmazur@google.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Atish Patra <atishp@meta.com>
---
Please apply this fix to the 6.18.y stable tree.

We noticed that kvm module loading failures on intel cooperlake/AMD
Milan hosts recently. This race condition might have contributed to
that. The issue was reproduced with a test module that widened the
window beteen populate-to-allocate interval and queued the
normal execmem cache-clean worker.

On an unpatched 6.18.53 kernel, the forced race reproduced the missing
/dev/kvm failure in 2 of 2 kexec boots.  A parallel module-load test
running five modules for ten rounds produced 15 ENOMEM failures from 50
loads.

With the upstream fix applied, 10 of 10 kexec boots verified successuflly
with no issues with kvm module loading. The same parallel module loading
test completed with 50 iterations.

The patch applies cleanly to v6.18.54 with no changes from upstream.
Please let me know if anybody needs other information.
---
 mm/execmem.c | 55 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 29 insertions(+), 26 deletions(-)

diff --git a/mm/execmem.c b/mm/execmem.c
index 810a4ba9c9243..084a207e4278b 100644
--- a/mm/execmem.c
+++ b/mm/execmem.c
@@ -203,13 +203,6 @@ static int execmem_cache_add_locked(void *ptr, size_t size, gfp_t gfp_mask)
 	return mas_store_gfp(&mas, (void *)lower, gfp_mask);
 }
 
-static int execmem_cache_add(void *ptr, size_t size, gfp_t gfp_mask)
-{
-	guard(mutex)(&execmem_cache.mutex);
-
-	return execmem_cache_add_locked(ptr, size, gfp_mask);
-}
-
 static bool within_range(struct execmem_range *range, struct ma_state *mas,
 			 size_t size)
 {
@@ -225,18 +218,16 @@ static bool within_range(struct execmem_range *range, struct ma_state *mas,
 	return false;
 }
 
-static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
+static void *execmem_cache_alloc_locked(struct execmem_range *range, size_t size)
 {
 	struct maple_tree *free_areas = &execmem_cache.free_areas;
 	struct maple_tree *busy_areas = &execmem_cache.busy_areas;
 	MA_STATE(mas_free, free_areas, 0, ULONG_MAX);
 	MA_STATE(mas_busy, busy_areas, 0, ULONG_MAX);
-	struct mutex *mutex = &execmem_cache.mutex;
 	unsigned long addr, last, area_size = 0;
 	void *area, *ptr = NULL;
 	int err;
 
-	mutex_lock(mutex);
 	mas_for_each(&mas_free, area, ULONG_MAX) {
 		area_size = mas_range_len(&mas_free);
 
@@ -245,7 +236,7 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 	}
 
 	if (area_size < size)
-		goto out_unlock;
+		return NULL;
 
 	addr = mas_free.index;
 	last = mas_free.last;
@@ -254,7 +245,7 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 	mas_set_range(&mas_busy, addr, addr + size - 1);
 	err = mas_store_gfp(&mas_busy, (void *)addr, GFP_KERNEL);
 	if (err)
-		goto out_unlock;
+		return NULL;
 
 	mas_store_gfp(&mas_free, NULL, GFP_KERNEL);
 	if (area_size > size) {
@@ -268,19 +259,25 @@ static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
 		err = mas_store_gfp(&mas_free, ptr, GFP_KERNEL);
 		if (err) {
 			mas_store_gfp(&mas_busy, NULL, GFP_KERNEL);
-			goto out_unlock;
+			return NULL;
 		}
 	}
 	ptr = (void *)addr;
 
-out_unlock:
-	mutex_unlock(mutex);
 	return ptr;
 }
 
-static int execmem_cache_populate(struct execmem_range *range, size_t size)
+static void *__execmem_cache_alloc(struct execmem_range *range, size_t size)
+{
+	guard(mutex)(&execmem_cache.mutex);
+
+	return execmem_cache_alloc_locked(range, size);
+}
+
+static void *execmem_cache_populate_alloc(struct execmem_range *range, size_t size)
 {
 	unsigned long vm_flags = VM_ALLOW_HUGE_VMAP;
+	struct mutex *mutex = &execmem_cache.mutex;
 	struct vm_struct *vm;
 	size_t alloc_size;
 	int err = -ENOMEM;
@@ -294,7 +291,7 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 	}
 
 	if (!p)
-		return err;
+		return NULL;
 
 	vm = find_vm_area(p);
 	if (!vm)
@@ -307,33 +304,39 @@ static int execmem_cache_populate(struct execmem_range *range, size_t size)
 	if (err)
 		goto err_free_mem;
 
-	err = execmem_cache_add(p, alloc_size, GFP_KERNEL);
+	/*
+	 * New memory blocks must be allocated and added to the cache
+	 * as an atomic operation, otherwise they may be consumed
+	 * by a parallel call to the execmem_cache_alloc function.
+	 */
+	mutex_lock(mutex);
+	err = execmem_cache_add_locked(p, alloc_size, GFP_KERNEL);
 	if (err)
 		goto err_reset_direct_map;
 
-	return 0;
+	p = execmem_cache_alloc_locked(range, size);
+
+	mutex_unlock(mutex);
+
+	return p;
 
 err_reset_direct_map:
+	mutex_unlock(mutex);
 	execmem_set_direct_map_valid(vm, true);
 err_free_mem:
 	vfree(p);
-	return err;
+	return NULL;
 }
 
 static void *execmem_cache_alloc(struct execmem_range *range, size_t size)
 {
 	void *p;
-	int err;
 
 	p = __execmem_cache_alloc(range, size);
 	if (p)
 		return p;
 
-	err = execmem_cache_populate(range, size);
-	if (err)
-		return NULL;
-
-	return __execmem_cache_alloc(range, size);
+	return execmem_cache_populate_alloc(range, size);
 }
 
 static inline bool is_pending_free(void *ptr)

---
base-commit: 1b357ecb321392158d507b04672ffee57bfa071d
change-id: 20260930-execmem-atomic-6-18-y-d91c94aedee7

Best regards,
-- 
Atish Patra <atishp@meta.com>

