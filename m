Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794587234;
	b=pyfftQ9TKNXCfaxR+2abhmK/9n6MHvUHyxVOvqqeg02Q6fsML4NTdO0hwSR1b8h9DuLU
	 c/FnlHKlbdg4jnzEiA881A1FTkVhmPbnLNkXDLk3lFboszuJHeKoOefJwLdUusWKRQxHq
	 iypfwJeawwA83lYPjK9pNsegMlIeYATnn8r107uOgBHw6uh57gyrh7oQuAaWNJYHxkYlF
	 Fw3tQ5WkozVbY0SBATwmpStWeUnlLyOI6qawikjNkA/tq8LJEmK+TD87bSX8wenrBdevT
	 TxGfE7saJjYuws+hGDmVEnERLIXZndGSubWr2t/UsyGdv06/srbMw4LJcEob9+XNeYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794587234;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nH+4fuf6JFUHnT4EFq7h99rEDt8N7Ykz0lHqkyH7S6o=;
	b=20i+dcxDYMuie/SkjRLdn+fLdQI0Z/TzOmB6yEI4TWcoFfQu2vsUX9EU5jcmQGfoufI+
	 /NoM4i5XDvwqNtkC0z3VswId/NVjbWrhBGt38ANG4oapCzrbtG3hAqk+z1UlQqWU5MbnY
	 caXIdzMJtnp1LYf3SYSNf74og3+Z73dNs/27xiJ6rSzeSWUNUKHGb1YbQ38U4qDjjIqmU
	 vWyRnBhSGeokAsHukZQdTAo7INmHXUImhqDSRaegqoHHiII75+iH6p0a86s3G3mn9DkPO
	 p4TVpIOytPPmP/ZKbZpj6O9xJgiHm0JDQgEm5s0FkiM3QjWpVxIwORrC0DVT8F4TSkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLRd3oUp;
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F123606BA9F
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 16:27:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F123606BA9F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZLRd3oUp
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ad0c2e71ebso170313a91.2
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 08:27:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794587233; x=1795192033; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nH+4fuf6JFUHnT4EFq7h99rEDt8N7Ykz0lHqkyH7S6o=;
        b=ZLRd3oUpIuGnrFvB1x4yFiEVgk9qDw5/LfvhoJ3PGm1P9Ouo11Rmm9fmcH+9GHtSRS
         611Lyem4MLdavVvPctHeySkJ0AiG0BiABkntSKJP1Q98ooL64h0KvnJVuJABy2NZ5Hj/
         mAUHCdVhTc82gaBIy4aKKnvQ+ergQNABycoTCgMK/LGiFCaOsW3fjwM02edekw22SkU9
         MNY77CFgrkVHXwhnZ56qomkYz1qnlm9MFH49IXlK4QR0K7t5bObUKq7gDAwqafHCCE6Q
         Lz/FkqbaRFKg9tXHmB7rgjmeEi4owFaDpXxf18QUUhAlaEFRwFp0tOoMMjfrJod2y414
         SE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794587233; x=1795192033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nH+4fuf6JFUHnT4EFq7h99rEDt8N7Ykz0lHqkyH7S6o=;
        b=EziAuSLx0tOlgsfxXjlCNFjSEPVUawVpLg+IJvTf8QmWmzcNcVfh1Zzb8LTS5/yYI7
         HTIqEh8m2KglfFfEbxIK8NOa1mKyzl9Me1aWnlf8C32ZZVpiZi3wl85jcsbsnaNq6m44
         XQt66ZGsg0NPuI4zyKl/oLISyE+drLYlhQuta5s9Qwi8upbwT8U3TIJ8VcjfeJe3bS/n
         hIU7dbSEj/1Rm2fRLstia+nf4JJotV7o7MjTouFzicCujbUvReB+CiMFDqrMWOlHoGax
         oKG1WiyUOn1xBzJK7xXmFyyWgzzzD/DiHg0J9+8pAdLM6jGJ7QXQunEElQkK8utKfgMe
         8j5A==
X-Forwarded-Encrypted: i=1; AL+hErG3V/MLJRPI0sjH8lB4uttd3e+nGCfnEPDa6AcLvwZIgptfySZGHDL8KFNjDkp6Egfv9NMZxHA=@vger.kernel.org
X-Gm-Message-State: APuU4Z/fbBxueBXIPMfdrMz5JEbg9j9fjaG5daODodFApszXMLiJiwPI
	VUsiW17CjKg4NhprliG22/Fy4l571X4+R2ucBOikBTuzCA1Yipm6kHae
X-Gm-Gg: AYBFou2/5wRDsuyTwoIKeQCOMpuRipFrlAFw8GSKRH+9dRSm8XtqQYv0tbnZKG0DCGN
	LF/DgsQwBZqeb8q2etQyBDn9zD7tCkDbAGD3REwnXcZpUws12P9mqPissDthm5hNw7lubsabjiR
	/6ZPm6VXW0dHnkQKhqg3Ye8ENapkLByTT8Pd9t1Soy9ZavRg+1QlCGtCQeh0hJBXt9GvTZ1y81z
	4tDnSrv9S6PvrM/t0cG8gEk1gmo1XbG7s3ZXkkI15zHUNowTprakyysXZIFD1ROyETsBdd4ygeQ
	lbUfSdkpmYqsMSYezwE7lgoIGGXHdKaWbVtOyLICESmLXJV3XUDEPusEH/3W5FOLu6I86R/3IXt
	pRSFs7uj7/cOwIZLiXhmNRqTDRf4X+eUcctsfec4QcH50Ln7mJfH90ulBYIWkjzRBKdykH2irak
	KmEtzcC5i1IR5CnjLHPgJGC8bf5r+aSndpKGmM8OpMAIaKYGGcDOKCRX6KDHqNZO2kCLLWW6Rof
	+ZFyT6P6iqnSyi4Eb39AnNWIMe7PtJKwTzgSHYNpEMKWTNSV/0OsneR2kw5Er/E7MjE4rr8SOTY
	BdxWvKQbT1zl4KYlBru/54zfImWAGWtstz5IZLoSUxVYlbm3ymQ7dutFQHotBzddao0OyrZir9z
	zKiU=
X-Received: by 2002:a17:90b:568f:b0:3ae:629:ca12 with SMTP id 98e67ed59e1d1-3b1b0b506dbmr4305114a91.3.1794587233028;
        Fri, 13 Nov 2026 08:27:13 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1bfb607e7sm712916a91.3.2026.11.13.08.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 08:27:09 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>
Cc: Akash Goel <akash.goel@arm.com>,
	Karunika Choo <karunika.choo@arm.com>,
	Lukas Zapolskas <lukas.zapolskas@arm.com>,
	Chris Diamand <chris.diamand@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Jiwoo Kim <arpe1618@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: Don't access gpu_contexts of a destroyed heap pool
Date: Sat, 14 Nov 2026 01:26:51 +0900
Message-ID: <20261113162648.110226253-1-arpe1618@gmail.com>
X-Mailer: git-send-email 2.43.0
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

panthor_heap_grow() and panthor_heap_return_chunk() compute the heap
context offset from pool->gpu_contexts before taking pool->lock.

The tiler OOM work holds references on the group, its VM and the heap
pool when it calls these functions, but nothing stops
panthor_vm_destroy() from destroying the pool in the meantime.
panthor_heap_pool_destroy() frees the gpu_contexts BO under pool->lock
and marks the pool as destroyed by clearing pool->vm, but leaves
pool->gpu_contexts pointing to the freed BO. VM destruction doesn't
wait for the work either: panthor_sched_prepare_for_vm_destruction()
only flushes the scheduler tick work, and only when the VM is active,
and evicting the group doesn't help, as group_unbind_locked() uses
cancel_work(), which doesn't wait for a tiler OOM work that is already
running. Such a work can then read the freed BO.

Take pool->lock before dereferencing pool->gpu_contexts, and return
-EINVAL if the pool has been destroyed, as panthor_heap_create()
already does.

The problem was found through AI-assisted source code review. The fix
is compile-tested only and there is no reproducer, as I don't have
Mali CSF hardware.

Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---

Notes:
    This conflicts trivially with Osama Abdelkader's pending "drm/panthor:
    Fix race when retrieving the new chunk in panthor_heap_grow()", as both
    change the local variables at the top of panthor_heap_grow(). I can
    rebase on top of it if it lands first.
    
    While looking at this, I also noticed that panthor_heap_create() reads
    pool->vm without pool->lock when allocating the initial chunks, in
    panthor_alloc_heap_chunk(), so a concurrent VM destroy can make
    panthor_kernel_bo_create() hit its drm_WARN_ON(!vm). That doesn't touch
    freed memory and is left for a separate patch.

 drivers/gpu/drm/panthor/panthor_heap.c | 44 +++++++++++++++++++-------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1..e55f7e648d 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -90,7 +90,7 @@ struct panthor_heap_pool {
 	/** @vm: VM this pool is bound to. */
 	struct panthor_vm *vm;
 
-	/** @lock: Lock protecting access to @xa. */
+	/** @lock: Lock protecting access to @xa, @vm and @gpu_contexts. */
 	struct rw_semaphore lock;
 
 	/** @xa: Array storing panthor_heap objects. */
@@ -371,16 +371,27 @@ int panthor_heap_return_chunk(struct panthor_heap_pool *pool,
 			      u64 heap_gpu_va,
 			      u64 chunk_gpu_va)
 {
-	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
-	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
 	struct panthor_heap_chunk *chunk, *tmp, *removed = NULL;
 	struct panthor_heap *heap;
+	u32 heap_id;
+	u64 offset;
 	int ret;
 
-	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
-		return -EINVAL;
-
 	down_read(&pool->lock);
+
+	/* The heap contexts are gone if the pool has been destroyed. */
+	if (!pool->vm) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
+	heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
+	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	heap = xa_load(&pool->xa, heap_id);
 	if (!heap) {
 		ret = -EINVAL;
@@ -435,16 +446,27 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 		      u32 pending_frag_count,
 		      u64 *new_chunk_gpu_va)
 {
-	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
-	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
 	struct panthor_heap_chunk *chunk;
 	struct panthor_heap *heap;
+	u32 heap_id;
+	u64 offset;
 	int ret;
 
-	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
-		return -EINVAL;
-
 	down_read(&pool->lock);
+
+	/* The heap contexts are gone if the pool has been destroyed. */
+	if (!pool->vm) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
+	offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
+	heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
+	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	heap = xa_load(&pool->xa, heap_id);
 	if (!heap) {
 		ret = -EINVAL;

base-commit: bafda823590ddf7031ecb765d673572fae7ab44a
-- 
2.43.0

