Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794589948;
	b=lzk1UWcQxzMkTwWCUf4ipt7FWVlIsf2fPxSHtdiieRjfYbDSOjU+jRQdp3nUKmiKPmjZ
	 tjVBogOHMJMlZVbhuLHJBufDZHSxW/TCF4A3HlPcNBb49fvQDWxNEcTxotetT5eQAQ8bs
	 dFiFjeiH0CrD8KEEllOC0zZHYDVKjrrnKzyhlhHlKj+qQlvwyo3MsOvS9izcpo3gBLgrF
	 3Tsg+KbCSE8gcC/ezVXhwtlQdUMdNBOqk+vICEEmwtJX9xOK1pHIrX7NLQVzujyMGJ/Ed
	 +yx6Imam0J7NoDY0dooaXzI927uTEhXAYItyvzDemdoFxeVwnZDzt9u4J9R0xHS1Dhg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794589948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=xv91mbpY6CHl9oZ10SuH7nK8AHihJpvpXeevDfWrpHA=;
	b=4L+MQ23OFcbz57RAf64UyNLqFmMFHgmOmsFBrrgTM9Icw3qwY+QERmOI7ud8uLcnwPWJ
	 jXc/ssvuh7PC9xjeu395C29qlvOjI9FgZTtWsd17IIt1SnsdFZrZOpXVfzffWEad1k1Du
	 bqCwrCbP3UOWyWHt48Vdp+Ow2iVIE8xyEBkgxIQmLjLZwj8W+shG/IBCL4HePxOpa1slp
	 0NlSdg29PNBPC+WyGQnbhSlAqLXrQLEDVGh2pKpQ9eQbYG8+Xhqjx0URP1xAJufgs7nIk
	 SJBSH8juMghkYTNmIBmspruuofxxWExJtVUDtxLWhz7OUOSzCzm4SPTHtYEc+CObD0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dk1vCWfG;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D54606A32D
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:12:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1D54606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Dk1vCWfG
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-36ecc11bd26so160683eec.3
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 09:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794589947; x=1795194747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xv91mbpY6CHl9oZ10SuH7nK8AHihJpvpXeevDfWrpHA=;
        b=Dk1vCWfGcdr5xZdt9dq2I9ypVf/Dr1nhuoKzF69Fy3aGZpE7zPiJYOeUBh4Omt7n6B
         aha6kKwmE7MYPtoRs9WpJ0jd7pv8BR/34CxoeYQgC3Z8qubWhIeYmeHQfXC040+WhEcE
         w4hu2GvDTiFZRumOJPSaERTQdIppzXJ0ePkV617MhpUtwVEg970NAV/BOk747yVlDtp1
         S4G7kJwVnnYp/6OqqzmYFaFW314xB7DGfBmd31sphRPXFTKJqRYn95xEqQZ8jvr1Lq3D
         9mRp+dNr1qR5gqjAKzng6ikGgxkxoxeY6PkimoEiYnpNJ754F5ZjsVwFj9jEufHxaVUE
         RLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794589947; x=1795194747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xv91mbpY6CHl9oZ10SuH7nK8AHihJpvpXeevDfWrpHA=;
        b=BLSIYxluPRdujQ0snYBaPZYfGZWeE5pu5eDCg3BNFtl6O0wAnCvX0I8ayhFLvcdMFR
         6LmCCHc39H0lZJVmM+BNt9rtsGW3Mncpdf5UGr/N5pFnjC/tOGucZZJIuoy4stRD46aS
         is9xkT5wh9pnXi5eBMi4p3awOc+1eIJGOClPj1MKAvYifAC621DVYM2t+dZmVSpUyTBI
         yVLVkZnjAl7f2QgDgXA0IVY7YMWYSygId/rGiPnq5A6m//mNuEvC5KyDWd4Ba7wl7h9t
         Fb2VKB8RDEzt0tBTDz0UpYwYC80Kc3rLT2EfFov8agvDvD5+IXjqrIqmjypNLEKUtzz1
         IFKw==
X-Forwarded-Encrypted: i=1; AL+hErHbb75ZFPiu9423E/t07en/kTMWt0qYK6pM0egVmoujyYmxvjkvK+sAhdfvdRK8f/QbTO4TqE0=@vger.kernel.org
X-Gm-Message-State: APuU4Z++rbJHt4bEWAiAE+b/OM7XdnYlr+QWqwYgASYJtr5cAySNLnSt
	RWyybbS2MLJAh1oUOQjeh/V152DaLAJzt3nxY6GwLaxtCIdesACuILhm
X-Gm-Gg: AYBFou0rKL/HqcI1zQN6m3ojgNtCwbLPcVd0SGAie+6czGs2afd6MqhspWvqg/bLr95
	d0uTWwGktyQioCSJb+ulNxpR/hqGzxOBKA8jI4VSKxplgy5LLO1FOn4learoW3oNAgAnVf7RIXn
	nQ8B+nEkLlhiZS3TP/KlcKAwWbRu3i40hIh9H9+cWcgbdfUWXWQuBzC4eGtUerEA7sN3fS5LksH
	OJ8ZwNruxloqM63YagZb/6M0i/Zvs5sOu6HQgzU4cRE+ckXQYk3pZPbHEVxk2g2i0bMzYRiqYwl
	AScpl/Zzf8jEMbRzBK8YsfMQmgvYyyKHlYnWn8z1eXvxbD+syScL5LwybEqAzpuc+KfPoBXfbzQ
	1r4ojd2DfkqTblajscArXYY5dEv7kakPJ5zBn/V1jZySxOcokZp9RjWb3cqF1uEGRdW6GVHUzZ0
	gv6Nfe4Z1C4VutLr8lbHLm/J2xlZIXQsH9g9InTW3hzFRNZaBAcwPNxWdA4R2r+GTTyEwgZ2hsB
	6yQ7V7agt3Jk6TI6RznrBqvEpwUEwZSPhVJGjB/oTuU7Q47/D6rNGu1XpqXQn/ct8a7P79wfmpI
	WDEZZjhaDxOM3ELT6KLNsh6PfptoZsZzRtg7+syY+PQXfIF4ps1tY2biX1ndf/vN7OB7h28JX/o
	Ltcc=
X-Received: by 2002:a05:7022:7f04:b0:1a1:9106:cfff with SMTP id a92af1059eb24-1b503097baamr4481535c88.2.1794589946743;
        Fri, 13 Nov 2026 09:12:26 -0800 (PST)
Received: from DESKTOP-CJ1L666.localdomain ([211.198.99.62])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b505b5bf76sm5975999c88.10.2026.11.13.09.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 09:12:26 -0800 (PST)
From: Jiwoo Kim <arpe1618@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>
Cc: =?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Akash Goel <akash.goel@arm.com>,
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
Subject: [PATCH] drm/panthor: Fix unlocked pool->vm access in panthor_heap_create()
Date: Sat, 14 Nov 2026 02:12:14 +0900
Message-ID: <20261113171211.836427578-1-arpe1618@gmail.com>
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

panthor_heap_create() takes a reference on pool->vm under pool->lock,
because the pool can be destroyed concurrently, and the initial heap
chunks used to be allocated in that VM. Since commit c63c3bfdde26
("drm/panthor: Avoid sleep locking in the internal BO size path"),
panthor_alloc_heap_chunk() takes the pool instead and reads pool->vm
itself. panthor_heap_grow() calls it with pool->lock held, but
panthor_heap_create() does not, so pool->vm is read without the lock
for every initial chunk.

If TILER_HEAP_CREATE races with VM_DESTROY on the same VM,
panthor_vm_destroy() calls panthor_heap_pool_destroy(), which sets
pool->vm to NULL, and panthor_kernel_bo_create() can then be called
with a NULL VM, which hits its drm_WARN_ON(!vm) and fails with
-EINVAL.

Pass the VM to panthor_alloc_heap_chunk() and
panthor_alloc_heap_chunks() again: panthor_heap_create() passes the VM
it holds a reference on, and panthor_heap_grow() passes pool->vm, which
it reads under pool->lock. In the race above, the initial chunks are
then created in the destroyed but still referenced VM, and
panthor_heap_create() frees them and fails with -EINVAL when it finds
the pool destroyed under pool->lock, as it did before that commit.

The problem was found through AI-assisted source code review. The fix
is compile-tested only and there is no reproducer, as I don't have
Mali CSF hardware.

Fixes: c63c3bfdde26 ("drm/panthor: Avoid sleep locking in the internal BO size path")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Jiwoo Kim <arpe1618@gmail.com>
---

Notes:
    This is the follow-up mentioned in "[PATCH] drm/panthor: Don't access
    gpu_contexts of a destroyed heap pool":
    https://lore.kernel.org/all/20261113162648.110226253-1-arpe1618@gmail.com/
    The two patches are independent and apply in either order.
    
    It conflicts with Osama Abdelkader's pending "drm/panthor: Fix race
    when retrieving the new chunk in panthor_heap_grow()", which also
    changes the panthor_alloc_heap_chunk() arguments. I can rebase on top
    of it if it lands first.

 drivers/gpu/drm/panthor/panthor_heap.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1..46f53699a2 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -137,7 +137,12 @@ static void panthor_free_heap_chunk(struct panthor_heap_pool *pool,
 	kfree(chunk);
 }
 
+/*
+ * @vm must be pool->vm read under pool->lock, or a reference taken from it
+ * under that lock: panthor_heap_pool_destroy() clears pool->vm.
+ */
 static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
+				    struct panthor_vm *vm,
 				    struct panthor_heap *heap,
 				    bool initial_chunk)
 {
@@ -149,7 +154,7 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
 	if (!chunk)
 		return -ENOMEM;
 
-	chunk->bo = panthor_kernel_bo_create(pool->ptdev, pool->vm, heap->chunk_size,
+	chunk->bo = panthor_kernel_bo_create(pool->ptdev, vm, heap->chunk_size,
 					     DRM_PANTHOR_BO_NO_MMAP,
 					     DRM_PANTHOR_VM_BIND_OP_MAP_NOEXEC,
 					     PANTHOR_VM_KERNEL_AUTO_VA,
@@ -209,6 +214,7 @@ static void panthor_free_heap_chunks(struct panthor_heap_pool *pool,
 }
 
 static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
+				     struct panthor_vm *vm,
 				     struct panthor_heap *heap,
 				     u32 chunk_count)
 {
@@ -216,7 +222,7 @@ static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
 	u32 i;
 
 	for (i = 0; i < chunk_count; i++) {
-		ret = panthor_alloc_heap_chunk(pool, heap, true);
+		ret = panthor_alloc_heap_chunk(pool, vm, heap, true);
 		if (ret)
 			return ret;
 	}
@@ -315,7 +321,7 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
 	heap->max_chunks = max_chunks;
 	heap->target_in_flight = target_in_flight;
 
-	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count);
+	ret = panthor_alloc_heap_chunks(pool, vm, heap, initial_chunk_count);
 	if (ret)
 		goto err_free_heap;
 
@@ -473,7 +479,7 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 	 * further jobs in this queue fail immediately instead of having to
 	 * wait for the job timeout.
 	 */
-	ret = panthor_alloc_heap_chunk(pool, heap, false);
+	ret = panthor_alloc_heap_chunk(pool, pool->vm, heap, false);
 	if (ret)
 		goto out_unlock;
 

base-commit: bafda823590ddf7031ecb765d673572fae7ab44a
-- 
2.43.0

