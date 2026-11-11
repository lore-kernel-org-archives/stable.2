Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794410969;
	b=2rHcsuu3Y1tueBGlULLZsoOyig87YTmcGL6KGdvyhIOBorm1sEkmi4ta0KBuWO698YD8
	 nxgqG4KvdYjjTitWwcofGH9dOlzl2w2x07EmpN0IH2iWAuENz2T2O7Z0wtKB3lKXp3JIQ
	 vZfT+veDW/kGwhrVvEvWDUNuhJLNefHiclia7nLBLph5jtxkJ5773/OT/WrhIVXmst3uL
	 wzjaMvr37ZzG8dj9e0r5IwFkMyLaSMk5jkGDBhx+ol0Q1HvvMbE2cjaAfdhaKhAakj+Po
	 c4NzbyF5X/NsOZv210sgFPRSpmvShWD3tDPQiMODCMsWiTu6H58pkxfbfTBmeQYRY4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794410969;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=JwEJyFgKaTzmUSD/YPwP3XreQszx3Few1LhCxmSmSWI=;
	b=o5xY1jbAV7ZLaYV9rnOaiwklcLBYQNLu2OiuUql9j9q9ZvL2Qtp9NbCoM0eCatTv6nkV
	 YeHIrulaau0PJa4pFzH6hwjD0UwRTOOvvsQv6j0yL29+x16L3zvrWuDfSY6Jbm0mfgPWQ
	 m9HWofLtDjfk28+Alpp7Yuw7LB1saowyumyQ4/s6xhbzkYlaMdUqGIW26RPkgfx66a9u/
	 25XLla0qDhME6eR8P7waPLvmSIavGZqywGTmvtPenLuysRFrWXKTEInGSa8b7QFi6wN8I
	 s6FVG2fpyKS5lxxToD2i4ICObbtoSbAgVIAEIBlMFqOp6YoZ4mCngiP+kHfHwYfBBfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRAibosV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACA2606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jRAibosV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8711F00A05;
	Wed, 11 Nov 2026 15:29:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794410968;
	bh=JwEJyFgKaTzmUSD/YPwP3XreQszx3Few1LhCxmSmSWI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jRAibosVI+7jWFubQUjI/C2/X3jOgozXzm9/v7sK+RD0h1H65ECWekR5Rgj4Ae7ZT
	 heD+1ucid/20eiw07pzOwKG4nnxdEdCm774Zf0CO35C5dFiFBYtthsiijprPPXWizC
	 qARsdPTVU6mfwCYcHymRhv3K72fUsvbGoFzB/veBRncxmIesrEI7ua4vQ27JR+TBVr
	 8ZGCkijPCPHW0KI6wv8UpDvNWBMjWGChQb+8XwVTN0za8iftpMkNOLN/rYoI+Y+Wt5
	 YoDgqtvNf21pKGPu/qBQFAiwOAv/z6JV+5lJYhIC+C99xxC2pQY5RYvBPSzXG90gKQ
	 AYuRSRkRc+Skw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] drm/ttm: return an error when kmapping a BO without pages
Date: Wed, 11 Nov 2026 10:29:26 -0500
Message-ID: <20261111152907.2656961-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062025-failed-5.10-fd485d47437b@kernel.org>
References: <20261107062025-failed-5.10-fd485d47437b@kernel.org>
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
[ sashal: adapted the check to the existing ttm_tt_populate() mapping path. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c | 4 ++++
 include/drm/ttm/ttm_bo_api.h      | 2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 1968df9743fcb..d234200e939bd 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -452,6 +452,10 @@ static int ttm_bo_kmap_ttm(struct ttm_buffer_object *bo,
 	if (ret)
 		return ret;
 
+	/* Imported sg tables only come with DMA addresses, no pages to map. */
+	if (!ttm->pages)
+		return -EINVAL;
+
 	if (num_pages == 1 && (mem->placement & TTM_PL_FLAG_CACHED)) {
 		/*
 		 * We're mapping a single page, and the desired
diff --git a/include/drm/ttm/ttm_bo_api.h b/include/drm/ttm/ttm_bo_api.h
index 09ccfee48fb45..ff46de1dcf0b4 100644
--- a/include/drm/ttm/ttm_bo_api.h
+++ b/include/drm/ttm/ttm_bo_api.h
@@ -523,7 +523,7 @@ static inline void *ttm_kmap_obj_virtual(struct ttm_bo_kmap_obj *map,
  *
  * Returns
  * -ENOMEM: Out of memory.
- * -EINVAL: Invalid range.
+ * -EINVAL: Invalid range or the BO has no pages to map.
  */
 int ttm_bo_kmap(struct ttm_buffer_object *bo, unsigned long start_page,
 		unsigned long num_pages, struct ttm_bo_kmap_obj *map);
-- 
2.53.0

