Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410523;
	b=GMgtNq5ZunA9SWEG/HtIbA/Elk3CwfYjQ3MAVWbHC08kZQuO/pklU85VH2E2bLh5wd54
	 io0UUOXaQuQ6Cb+UTlwn6IJBtUWJutLQWCDyzpzLXDbdXrMQMbXthXcqSWHWqWZFaIFgE
	 chZw6SsqWJQTAIORsNfm+AyiEEVGiyERfRkYad40Jy4p6TgQNTZZK0TVWSDDCejEMXcgG
	 zsbh9UJBNmPaVG4Ot48XVAvJWmSlsGVDvQ/RPJGNQNUxpyQTxJp0evH+oTT0jGkeZYAAe
	 nW877aqCPRs5OA2To5cmS2is+pzV9R5y1RzqZd9YIFBTp93AVtKsMpye1/PUGELmmKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410523;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=83AijDFiKvka1U60CUSjmnP36j06f9/2sqU+mmrsOaM=;
	b=AWqwdAXoC61DgypTKKYI+N8gOsxt9f6EoVEf2EiZMzr3mhEAMvDrRgF6351yoMnSQMcn
	 GFVaeqRe+3uqo4oNFqE9agynE6rMFP0JVX9WyrecoMEGzwpLP3Y8goc+FPM7Wjmwzkbgt
	 /5P2q0GWjXwb65pu9tv7HxLxvqLT9QR7sa/TIjMhFrrcMwHhDz2/NICq4UN0E6lcVzKiK
	 8Vqsop59rmo71ngwjR/zViL5zJpEM8xUQaNuVzzrgaHU9tOI+ar5lcwz3mlDosA71xYTU
	 kS7xWpdrgzYIo9/bobbY122EnKi03v4lvgSVYl044rwpQsZ5cYfoHrewkahDiE7dDQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksaT6vmT;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B97606A339
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ksaT6vmT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120161F00A07;
	Wed, 11 Nov 2026 15:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410522;
	bh=83AijDFiKvka1U60CUSjmnP36j06f9/2sqU+mmrsOaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ksaT6vmTiHGGP8CpBQy37P5fqp0BWtMSA221Mx9bAxJyqiAL9N6hXTnVVrlYBw5SH
	 g1jzpSbBvOCXMzrFMcPmRVbD/96VBt1jpA/xU1a/7iDN9NK08fPPa/MmkKLHwAyJhz
	 yBd2vCNnFjfWZZaNmqr642C8pMxbXplVT+m7ptoTfD0rmWyGMXZt7aNzPPxBdCA/b7
	 iyuoFwVHgu+9SHE6Kh5tMDTsRCB0b09ExHpPT55DMGCSB+dAIfiMZKvFEFUUcXWPU8
	 Sx/3SzDT/Z235/rMVnzfo/buA0uYR2gAMfpFbc+swX1AESf1YHJQJsNsV8X4FL19Ad
	 77mDGT1UxAt3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] drm/ttm: return an error when kmapping a BO without pages
Date: Wed, 11 Nov 2026 10:22:00 -0500
Message-ID: <20261111152139.2597907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060349-failed-5.15-fd485d47437b@kernel.org>
References: <20261107060349-failed-5.15-fd485d47437b@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit fd485d47437ba1700dd47205a63b9f389a00aa36 ]

ttm_tt objects for imported sg tables (ttm_bo_type_sg, set up by
ttm_sg_tt_init() with TTM_TT_FLAG_EXTERNAL) only have DMA addresses and
no pages array. ttm_bo_kmap() and ttm_bo_vmap() still dereference
ttm->pages for them, so a driver that tries to CPU map such a BO oopses
instead of getting an error:

  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:ttm_bo_kmap+0x26c/0x300 [ttm]
  Call Trace:
   amdgpu_bo_kmap+0x89/0xb0 [amdgpu]
   amdgpu_userq_fence_read_wptr+0x116/0x170 [amdgpu]
   amdgpu_userq_signal_ioctl+0x3fe/0xbb0 [amdgpu]

Return -EINVAL in that case, like ttm_bo_kmap_try_from_panic() already
checks for a missing pages array.

Fixes: 75a57669cbc8 ("drm/ttm: add ttm_sg_tt_init")
Cc: stable@vger.kernel.org
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Link: https://patch.msgid.link/20261009103419.4122940-1-Jesse.Zhang@amd.com
[ sashal: Moved the API documentation updates to the existing header declarations. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 7 +++++++
 include/drm/ttm/ttm_bo_api.h      | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index abf2d7a4fdf1a..1c582e4824e6a 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -312,6 +312,10 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
+	/* Imported sg tables only come with DMA addresses, no pages to map. */
+	if (!ttm->pages)
+		return -EINVAL;
+
 	if (num_pages == 1 && ttm->caching == ttm_cached) {
 		/*
 		 * We're mapping a single page, and the desired
@@ -429,6 +433,9 @@ int ttm_bo_vmap(struct ttm_buffer_object *bo, struct dma_buf_map *map)
 		if (ret)
 			return ret;
 
+		if (!ttm->pages)
+			return -EINVAL;
+
 		/*
 		 * We need to use vmap to get the desired page protection
 		 * or to make the buffer object look contiguous.
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 36f7eb9d06639..ada4d625bf8f7 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -474,7 +474,7 @@ static inline void *ttm_kmap_obj_virtual(struct ttm_bo_kmap_obj *map,
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_kmap(struct ttm_buffer_object *bo, unsigned long start_page,
 		unsigned long num_pages, struct ttm_bo_kmap_obj *map);
@@ -500,7 +500,7 @@ void ttm_bo_kunmap(struct ttm_bo_kmap_obj *map);
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_vmap(struct ttm_buffer_object *bo, struct dma_buf_map *map);
 
-- 
2.53.0

