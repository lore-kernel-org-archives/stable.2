Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602850;
	b=HotHSlZYyBQpp+GiMqugL8rbPlJJydX3UGcn8GrUOWbAEotEK+9oLxZyBpnAvsEBtMZP
	 no5NsENlzWnIyfTInpWfCc+uFGh1Giv8wXS0zS0MkIDBkUlSv3V8Cb5SZrpofp++mnYPg
	 yf2kK6SUvTSoMUQdNlNXpRtoOky4Ajqdl6KP72qkyAnt4f6kWsgZioBS4rAWjb8mzapC4
	 tabP4YOqHmOs7YlLuUrBfXiHZoV2EG8g9kmDibN8z6wO6ELYaUi/11M2WCDtNY4k30taw
	 heHFiNshcALKPNFBskAC8glv6LF8VYgowNO/9QjGlXcpmI4hwRZ75XRv8FBduD4OaOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602850;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CeJdUlTarSzl0zOxcgqdgSz/hfHd0m5LVHMetEyWCNA=;
	b=icKTDG3lqK4mFhvfsVhgkspt83fGeHSuR9QKmwQLEKhaBKHi7NeknhhEjsu3rewc36GO
	 pI138gNRru1e4oO+eTP2kWlxJJF845bQCl9DmJqfNcYz1Qz/Ui0vzceiA9XkqfLqUfNC5
	 b6el8JyQYitnmXO6BuaZ7mVzVprZaCKNz8PzTuB9PUrBPn69/nrDsSLe4xYXJHaMqR6Dh
	 L+6bb6uJN5a04NfRT7xMeebkZP+6ByzpJhF91WlTGDtAJz0mX0EC2dp6dcOBrkBwInxjB
	 W+RF3IuEmEsK4ExWvtIgUizIH63/8GCfStnavx3u3ydSfWzQdmZiWDpzKRKkkoZSN3A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HOa0xz5C;
	arc=none smtp.remote-ip=209.85.128.46
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295A0606A32E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 295A0606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HOa0xz5C
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4a60f9474c4so21614225e9.0
        for <stable@vger.kernel.org>; Fri, 13 Nov 2026 12:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794602848; x=1795207648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CeJdUlTarSzl0zOxcgqdgSz/hfHd0m5LVHMetEyWCNA=;
        b=HOa0xz5CaajXNfqsSinjEBnqsTd3zDgusNh1FN+lGgT74mWgIm4hcwwuMzztBbiAAN
         u/iGoCH1rFxlDuqyheK5kTvmTReDP/cZGM6lLsJ2XZgJD/lws+lBV+9Edl77Jsni0l4n
         2B1LP3/1DhN3MvVrqircDS+8C2JAb9lEEKI8UPmZSqWo92a46R4At/DK105OFKnmXpO1
         N90m1p9DWSO6EMGdX91BpffxqI5rCw9tnCCaHmUF3DH6BpBlOPoIFNmRoGVrw1UZF3n1
         LdGf+zJq/3WtF/giNdjextaagZkKp+TQf3dSoM2tdSymFJ59kN0foVdIEA3WrMhDzeit
         K55w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794602848; x=1795207648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CeJdUlTarSzl0zOxcgqdgSz/hfHd0m5LVHMetEyWCNA=;
        b=XkL382wsSkUZy4+BkmGSAkjfUXC2YwJlhL+6zgZCAFVh4OOfVgB6adiSK7hQfN4abt
         jhq3cTfdp9nBZ8PJzaZcIcGzK1YqdGUV3+MUkXo5WL5tcui710gTWCEHxEInCQ8CgRMn
         fXfagCfD4dpVRrZgbIZTc+kKc46IMpdXW7vVpBljzWSQBNZ/s9HUs2qri8khhMViRzbH
         vLG9nxJyl/JRsytKXNPMmhdxMmdK7JUPLeRAcacaJeoRgLYJ5VlzwU9KuPiJDWbLv4up
         qD7/pb0OALddvmtYpdzU9nTX21JstkxB9fiafJQCOGFAM2mw5HgaKwxDh4VYdiW1in14
         xtYw==
X-Forwarded-Encrypted: i=1; AL+hErEOpztfUCAx3ufLDai8X17f1Z7MvJFe6k/JE5lRB+S9+cAJ3NfGZ37HZQm1De+iZ83i7oclQ/Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9j04buxLuAUkvH3LKz9F0zoUGcbB0iNppT0owNpp6hVob/spDN
	B2FP9AjH9B34sTE0SdI+Q9097Fl751RaV+/CrFKxluPmtx4DqwRemGmi
X-Gm-Gg: AYBFou0Drjndi2d5kQvylnJ+lne8tRhySNeGE0UXFgD+qo4JM51FEsIfFB7pcxSBErF
	oG2bu5RsmdwSIqy12iLm/83BARFLxMrEXUrRkGFPZCAeDh9792dLrbMuwUdDuFu/9YkNP1mYL4T
	tPqIwb2ev5hVymOidIwyp1RxVMZinCo52pcnMUGbT0oHKf7LjMG64bKDOSiKf9826tG4Iu2LHBZ
	3kM444don7emqG2T34AvhSEyZ3hMcIG3lkrzNrWV0Rg3wKCL5rxiLhuu/Y2xx/zeQJmyEW77eUV
	3d+U7y8YlsBFL1Q3o9mhiTx94E6r+zVkwOhEvNqOCxpcMt5rmL49kFn4YnOGKvVUSaB7yga+MM1
	ez7wJXZjQ3RanC3mD9bVmyxf3X6Er3Lm4ahQQygyWGEhTdNjt2E7EkpjibLBgej9hgnGDe/uaUf
	O6JBd9uyNUSNHwuT85LPRs8mfmA/S/IvQkLRG+4XX1JSowgFr9PM2AqRyE/i+DkLU6YGPAYjPjl
	tjQun+VZ/TiwUz/gGUYrgYmWpcIP/Gyh+bHXTP2rJKfo0NFkJs+ik8yXrm/qhUqlu0sDIz0/aG0
	uModuI5XhHbRuANo+YnxYtDVBNtaFWdi1klfg+PgHKhmSouwlphNzrkA+2rdKXAR8IJXZU2XCuR
	sw5RZpr7D
X-Received: by 2002:a05:600c:3b9d:b0:4bb:5dbf:af06 with SMTP id 5b1f17b1804b1-4bb5dbfb103mr44986715e9.9.1794602848265;
        Fri, 13 Nov 2026 12:47:28 -0800 (PST)
Received: from osama ([2a02:908:186:df80:be86:db23:a9d4:f15e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c609c8a77sm7282165f8f.49.2026.11.13.12.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 12:47:27 -0800 (PST)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Akash Goel <akash.goel@arm.com>,
	Karunika Choo <karunika.choo@arm.com>,
	Lukas Zapolskas <lukas.zapolskas@arm.com>,
	Chris Diamand <chris.diamand@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Heiko Stuebner <heiko@sntech.de>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/panthor: Fix race when retrieving the new chunk in panthor_heap_grow()
Date: Fri, 13 Nov 2026 21:47:16 +0100
Message-ID: <20261113204717.35195-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113110217.6c1513be@fedora1.home>
References: <20261113110217.6c1513be@fedora1.home>
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

panthor_heap_grow() allocates a new chunk with panthor_alloc_heap_chunk(),
which adds the chunk at the head of heap->chunks under heap->lock, and
then drops the lock. panthor_heap_grow() then assumes the head of the
list is the chunk it just added, and reads its GPU VA through
list_first_entry() without holding heap->lock.

panthor_heap_grow() and panthor_heap_return_chunk() only take pool->lock
in read mode, and tiler OOM events of different groups are processed in
parallel on the unbound heap_alloc_wq. If two groups use the same heap
context, they can modify the chunk list concurrently:

  group A OOM work                     group B OOM work
  alloc C_A, list_add()
                                       alloc C_B, list_add()
  list_first_entry() -> C_B
                                       group scheduled out:
                                       panthor_heap_return_chunk(C_B)
                                         list_del(), destroy BO, kfree()
  C_B->bo                              <- use-after-free

Even without the free, both groups end up being handed the same chunk,
and the chunk allocated by group A is never linked to the heap context.

Fix this by having panthor_alloc_heap_chunk() return the GPU VA of the
chunk it allocated, retrieved before the chunk is published in the list,
instead of looking it up afterwards. Do the same for the initial chunks
allocated by panthor_heap_create(), so the first chunk GPU VA is
returned by panthor_alloc_heap_chunks() rather than retrieved from the
list.

Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v2:
- Always write chunk_gpu_va in panthor_alloc_heap_chunk().
- Have panthor_alloc_heap_chunks() return the first chunk GPU VA, and drop
  the list_first_entry() lookup in panthor_heap_create().

 drivers/gpu/drm/panthor/panthor_heap.c | 39 +++++++++++++++-----------
 1 file changed, 23 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1e9..febc18b43af8 100644
--- a/drivers/gpu/drm/panthor/panthor_heap.c
+++ b/drivers/gpu/drm/panthor/panthor_heap.c
@@ -139,7 +139,8 @@ static void panthor_free_heap_chunk(struct panthor_heap_pool *pool,
 
 static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
 				    struct panthor_heap *heap,
-				    bool initial_chunk)
+				    bool initial_chunk,
+				    u64 *chunk_gpu_va)
 {
 	struct panthor_heap_chunk *chunk;
 	struct panthor_heap_chunk_header *hdr;
@@ -181,6 +182,14 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
 
 	panthor_kernel_bo_vunmap(chunk->bo);
 
+	/*
+	 * Retrieve the GPU VA before the chunk becomes visible in the heap
+	 * chunk list: once heap->lock is released, a concurrent grow or
+	 * return_chunk on the same heap can modify the list, and the chunk
+	 * can be freed.
+	 */
+	*chunk_gpu_va = panthor_kernel_bo_gpuva(chunk->bo);
+
 	mutex_lock(&heap->lock);
 	list_add(&chunk->node, &heap->chunks);
 	heap->chunk_count++;
@@ -210,13 +219,19 @@ static void panthor_free_heap_chunks(struct panthor_heap_pool *pool,
 
 static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
 				     struct panthor_heap *heap,
-				     u32 chunk_count)
+				     u32 chunk_count,
+				     u64 *first_chunk_gpu_va)
 {
 	int ret;
 	u32 i;
 
+	/*
+	 * Chunks are inserted at the head of the list, so the last chunk
+	 * allocated is the first chunk of the heap.
+	 */
 	for (i = 0; i < chunk_count; i++) {
-		ret = panthor_alloc_heap_chunk(pool, heap, true);
+		ret = panthor_alloc_heap_chunk(pool, heap, true,
+					       first_chunk_gpu_va);
 		if (ret)
 			return ret;
 	}
@@ -280,7 +295,6 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
 			u64 *first_chunk_gpu_va)
 {
 	struct panthor_heap *heap;
-	struct panthor_heap_chunk *first_chunk;
 	struct panthor_vm *vm;
 	int ret = 0;
 	u32 id;
@@ -315,15 +329,11 @@ int panthor_heap_create(struct panthor_heap_pool *pool,
 	heap->max_chunks = max_chunks;
 	heap->target_in_flight = target_in_flight;
 
-	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count);
+	ret = panthor_alloc_heap_chunks(pool, heap, initial_chunk_count,
+					first_chunk_gpu_va);
 	if (ret)
 		goto err_free_heap;
 
-	first_chunk = list_first_entry(&heap->chunks,
-				       struct panthor_heap_chunk,
-				       node);
-	*first_chunk_gpu_va = panthor_kernel_bo_gpuva(first_chunk->bo);
-
 	down_write(&pool->lock);
 	/* The pool has been destroyed, we can't create a new heap. */
 	if (!pool->vm) {
@@ -437,8 +447,8 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 {
 	u64 offset = heap_gpu_va - panthor_kernel_bo_gpuva(pool->gpu_contexts);
 	u32 heap_id = (u32)offset / panthor_heap_ctx_stride(pool->ptdev);
-	struct panthor_heap_chunk *chunk;
 	struct panthor_heap *heap;
+	u64 chunk_gpu_va;
 	int ret;
 
 	if (offset > U32_MAX || heap_id >= MAX_HEAPS_PER_POOL)
@@ -473,14 +483,11 @@ int panthor_heap_grow(struct panthor_heap_pool *pool,
 	 * further jobs in this queue fail immediately instead of having to
 	 * wait for the job timeout.
 	 */
-	ret = panthor_alloc_heap_chunk(pool, heap, false);
+	ret = panthor_alloc_heap_chunk(pool, heap, false, &chunk_gpu_va);
 	if (ret)
 		goto out_unlock;
 
-	chunk = list_first_entry(&heap->chunks,
-				 struct panthor_heap_chunk,
-				 node);
-	*new_chunk_gpu_va = (panthor_kernel_bo_gpuva(chunk->bo) & GENMASK_ULL(63, 12)) |
+	*new_chunk_gpu_va = (chunk_gpu_va & GENMASK_ULL(63, 12)) |
 			    (heap->chunk_size >> 12);
 	ret = 0;
 
-- 
2.53.0

