Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794511018;
	b=A85nWiJC1Ie4NMPgUErB/IrPrRWOb2ehdnxVtiTMc8kkmmtJva7JuPdcpRJl+uFOlRYu
	 i6sbDrVVjECsXiDS3CW8QT/V5+wAe25vAOK8D/A9zFZ3Hrml+mXvhT4d1l9WqkUnTUfx4
	 Wj5QQDU+xkbLyQjLvSAxeRnsCoRYngPJG/7dpvXBO2TcuDEQuEo96z0K5cI43dl05IVat
	 8QWSDd5xAy8X9QFju0k66AZynDk1pSMb6r2MtbnfP/6d4jkGozu1cHYaBV0tgrza6n434
	 BQAcjWW+TcXxH1W8i1jhFJRmWB051hhpEn+Fj2tfDB1LgwXiNn3aOx3bEkJRtt6H2mA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794511018;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QifT63FLPlBaRBfMwdlPD9GRxtpIvQpF5WAaBnQtQ4E=;
	b=sX6FWcdqfQvZdCN7RTveZ5qw7Y2cudbmushwIS7MvxsepHAX2ro3sTYgg3vpn2SXgp9Q
	 KDKTdD7LIXk5uFH73O7JfM5pUsKuzR9sivYD9weBc9BLUc7KdOvl/wDE61E8IswGhko+j
	 ShHWIgRWaVVxpW27edvYR/BwdYV8DveE7QlF6Qb3SbuUi55QSkYc+b9dbVVtsT+Pzlbu8
	 M2QOpUKpbKlGiK2IbAmDtYH7/4EhJrDzMnWH5KkidWhs3k+CEMMrKw/FNPLcvQXDnMEhO
	 SVMcXUReitmmVYUlUIS6KVwNDjYZjj65QD3lRMXYv8TqqAhQxMs6e7tIHrHAjy2HUgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f6izSXpD;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EC23606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 19:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EC23606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f6izSXpD
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1b07c3c5fso1485205e9.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 11:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794511016; x=1795115816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=QifT63FLPlBaRBfMwdlPD9GRxtpIvQpF5WAaBnQtQ4E=;
        b=f6izSXpDRyh3kiKQZeMzK0o3Gql7daLptZvL/v5DX5yMW0HUOn3k09Fr2S0QkhZDey
         ObUBUELIZrpKUdd00lcmjH0dhhaDuuMwRFGrApC3lrNdVH6fvCzX79qBjj2lCEVUuuos
         H6G8Odw82ODNw3z/D135vixZtxZhXj2CV8mwGdUiyJVOY7cwzwEUBpS/JK4kKR7Hr0Mp
         aiZTjianHYond80JJtPSorJ5c3ySawtyljcRNKCbuvu6gZ1uwf3TxEy8eO71UYMde/ri
         K/iY6ZN61U5MhkMOURtAEffpXKpAiU0ZoJf1qyz63hbs2QX/XWnLg93Ek6xGa7xw3XGh
         h/ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794511016; x=1795115816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QifT63FLPlBaRBfMwdlPD9GRxtpIvQpF5WAaBnQtQ4E=;
        b=0HCISQTAHyqEeXIMFK31LMrkmQFDlxrHVyouOrRSIDni5KzqyuAQXcunETcGRltiVv
         dvYSLrwOpwDJTiAxtjLTpK9TDN1HP3x6ExR7tC65zZ5x9s9hWZeIJv46KXWBu09oQAJn
         CTsh/0+RBwiAH20SA+lW4UoygO5TQ7zAav09iKqPFF9EMBIdS0k4u/Vu3rxpl9fDFlyd
         894T1rQ2iZduIz13fcW+M447hMyMnG0bnI/Vom3GXahVIwxupmy/TGNtBZ5e4VYFcgUa
         9ISFnYmEyqs1YRmGLYP5DtqTqLLiA/afki60lfPBGOvwQ5EfHPibsaPclv13SdcPQ4He
         kubg==
X-Forwarded-Encrypted: i=1; AL+hErGealP0m/3XEDB08KMjPbjOT7dR2TmTJrxzTSocHHGN7v/9Nv6WEMfzxoi7dfiGzPg4b+94Lps=@vger.kernel.org
X-Gm-Message-State: APuU4Z+5zCUsniOPd65uTWfh4Q6HNaLExjQrd5ftFfjgJpJnNlvz7j7i
	aZOXQ7iNuIjY+z4GgRzIMUJo9d9xFTXreSg69hR+n+qm3OvBxToBx2LA
X-Gm-Gg: AYBFou1WNxPaYSx+7Rim2PUtPGX2vyqrFZ6Qik4tuBLd55Ejjw/MHbyth23ZwSQrqm8
	ne5buqE8O5LBLghlFFHF9ci6S60CKIgOoTMhitL+a85dJCkSv0D5fBFC6CQckVgNwxV/poeLqhv
	7SQ8+m2iIOO0wmaiGsT8vfGCwb/G448nLo8DgRC0L5ti6n8WFgP5nYbp7wx1CvJqoH/L0qIAOgc
	dBFA0+G12gBTffuH5TQ01dqblF+7JIrPgFxc1Otcb7Oo1N/Wh5rL5flp8oDmJwtkf4bJwaEDjG6
	Sl85dyL2eh3QPonI9J+/VHcfFv2D4y3kw4ITrnVXirswai7WOhAdJz8YHCh3ypRIz95/PuKlr54
	ijVexubNecYGFevahk87VNlGDizpcoobRxnwDYNyaTPJRIpDvaWkWlzB5uKISEwOzgBfoEjbgAu
	j3I5SukBeejuh0dF72vvA8FqI8gz7Rg4IFfTnEQ3dOepcEnBkh9K77IrF5Qt+qVqzDA9+An2azE
	a/1qRf4QJdZOpSoqPNkb2H1U+mqXCiG+fwNFiXNTjh6nlLN/dp9l44NQrnH2+/DWZCTadeSoahM
	UwztljDtvHS7dIxzbyCY87y+8vcv98CNNRPzhxuQQicenEWeS8+SAheanTLM/cg=
X-Received: by 2002:a05:600c:1d03:b0:4b1:4017:c4f4 with SMTP id 5b1f17b1804b1-4bb55a58e1amr4456295e9.20.1794511016325;
        Thu, 12 Nov 2026 11:16:56 -0800 (PST)
Received: from osama ([2a02:908:186:df80:da60:20d5:2c9a:fdcd])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55afb6absm2821045e9.15.2026.11.12.11.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 11:16:55 -0800 (PST)
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
Subject: [PATCH] drm/panthor: Fix race when retrieving the new chunk in panthor_heap_grow()
Date: Thu, 12 Nov 2026 20:16:50 +0100
Message-ID: <20261112191650.735850-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.53.0
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
instead of looking it up afterwards.

Fixes: 9cca48fa4f89 ("drm/panthor: Add the heap logical block")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5.5
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_heap.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_heap.c b/drivers/gpu/drm/panthor/panthor_heap.c
index 99311abdf1e9..d80f514366fd 100644
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
@@ -181,6 +182,15 @@ static int panthor_alloc_heap_chunk(struct panthor_heap_pool *pool,
 
 	panthor_kernel_bo_vunmap(chunk->bo);
 
+	/*
+	 * Retrieve the GPU VA before the chunk becomes visible in the heap
+	 * chunk list: once heap->lock is released, a concurrent grow or
+	 * return_chunk on the same heap can modify the list, and the chunk
+	 * can be freed.
+	 */
+	if (chunk_gpu_va)
+		*chunk_gpu_va = panthor_kernel_bo_gpuva(chunk->bo);
+
 	mutex_lock(&heap->lock);
 	list_add(&chunk->node, &heap->chunks);
 	heap->chunk_count++;
@@ -216,7 +226,7 @@ static int panthor_alloc_heap_chunks(struct panthor_heap_pool *pool,
 	u32 i;
 
 	for (i = 0; i < chunk_count; i++) {
-		ret = panthor_alloc_heap_chunk(pool, heap, true);
+		ret = panthor_alloc_heap_chunk(pool, heap, true, NULL);
 		if (ret)
 			return ret;
 	}
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

