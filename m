Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F1C48E0CB
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789051013; cv=none; b=AY1jKzEhG5GnFzp0GRX1GOcs7+nxCRBgqoVwXW/mAUlWvEYS1cSwubLTht4GqhuC6IEsap4n9swcfuoi6QT4VfuKjj8PJ0tf5G41pE/hJ8Y20Bgw+G5Qy+L+bG0hHjgIMiXLEsDWKiM44z3f34mqavR6YbCiwiFpHq5pueuJ2+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789051013; c=relaxed/simple;
	bh=44++hIkP5myLEtGQXIFd/CtlqyOT1Q2AyIHZpmKSjvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rEbOicTpPtEYek+7w4p3K2IuMII6DPmLvHqtmaFXiH2XcbsxQkdEk+OvEyDL6t+N8DdwbE645QTb0ZMZiGTbIC6CgxvlSdmVh2FxQv8wI6veOhu4pwsFiwyCurG4XT+ksPBV7Ty1/wmHB2AcXJoBjjC/rlM14g8HZntkaSXMjGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndWKrZ5J; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndWKrZ5J"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2637dd37c1so703511766b.0
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789051010; x=1789655810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=orC8VUg8M5+c5rSP9eN2LigrAsxa02qw3fBkTWfZG5o=;
        b=ndWKrZ5JAjB5G6iuzNo741KncDzAzpJ1jMnadG/XLjo5S2SXnKrge9jMiu0vkqRXul
         02R542PRx2VIdx19mzyq7eG8oep8y0PvuPycoGVYn27v4Tslh28jwwIUgOFqGAYW+1qR
         9BVnJlDJn0+yE3xZ9iv2qiy3Cf3T1J0A4HfN9zAZipwdWQarykmlovSOhr5eG/56kPU9
         VQIRT1tg7aD0k6w1P3YbLbLd6SzIvuRA+0Tj70h9AJ2BZUW4F26HNbZEScZFxhfpSAfo
         odp0I8hiYhAwukNMu4QkEwTSZBvRP5liONDIvXiesFGCQsw5j4XYvbmbZ5cyrMj/O+Z3
         vTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789051010; x=1789655810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=orC8VUg8M5+c5rSP9eN2LigrAsxa02qw3fBkTWfZG5o=;
        b=hNfp56gc4zmQlp9Xeek8wREbVnJD8aXgtF2LZyG8g21UuPYxOzt8OHKtPzN/gGt0nz
         yhdwSYkxNdbKRbl0S9WA8nZx3EqphPutxxwVAvo+l3I5VlvGtU8qwv5j/figrg8++WXC
         QElGIFnUWjnH9MVYR2tvwh6YHRAzo0MJN+yz3VLe0lVI5j4bounhBTD/htIlGgZo8YdG
         0O75EtfldEHds9+x0UFVyjBXLGlNqoeYMTsMM5CnYy1Tole2/Ai/KR6RFwQtyuoUX483
         59ivmGDuxQKfDVZwEm0+xn7t5y+7epqIzgvQmyqmrIQsPGz9x2EWRXKZ1+L3XrxLfiqi
         MuHw==
X-Forwarded-Encrypted: i=1; AKwUvBx2ceSFnnqR8UPBtPNdcgbCYHp3arKToTLeW3I4lArhlzXZeWO9RCSJUAmr1dQowAuRugTVxik=@vger.kernel.org
X-Gm-Message-State: AFuF++kCHcQ9suTWJlTzXiPC/i/m62AOoSE6JSSeUkVSDw510+fEspdQ
	D9eDYErqvVkvukqhGM8UKaepmvy5l/sSgCbwGU9z9H/CWlmKbFCnQUtR
X-Gm-Gg: AYBFou1QOk0hto9yIDmX58vrZgo55AIrxheZC2p3LWIV+IWHVccAiNGMdA4onZLTR5N
	Ma3jOPoCaSKNg+/qNuO0ZzjuiqmVEE7CDtFxWJi8XEMRFz98cCCvkowMKBl7mN+YhSNhbuZHX5M
	d+anjeziMv9SaUcS0CspShPhDqinwToICyRbBSuTygVxE8wDQdSADc4oVNTvID98dOxogQfoFPa
	lnj+Yuns5JH7YS7kvoa8qYbriEVCX8i8ysJjMruKPNeNNETIq/GvddAoU2+SNPz+WTGuWBic9xG
	jOwtWXtF92H7JXr85FiLFUg8jm8UWmL6RwFyyfxbbyWcPvGsOMdyuDPBON+f92XOgrGlzM3fHjP
	8zccHpu5grHO7oIe9wJ+TIFffRPiO0CLbMne0YbXh6oEAwpvoOCnKkGa9wCFp+enoIbsluweBEP
	l1fE2guNvyjNl5nJ0wupPOe7bkA0BUUMttjKYr51T1Y+VHIuVUj/nCxsGf6w1dHj/Hl0VMPPTiC
	TA0EbY=
X-Received: by 2002:a17:906:ee88:b0:c29:3711:626f with SMTP id a640c23a62f3a-c2937116522mr422684566b.24.1789051009715;
        Thu, 10 Sep 2026 07:36:49 -0700 (PDT)
Received: from bbzr-mini (cool-t.fvds.ru. [103.137.251.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2945d5ea60sm135441466b.29.2026.09.10.07.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 07:36:49 -0700 (PDT)
From: Vadim Nikitushkin <bub4z0r@gmail.com>
To: christian.koenig@amd.com,
	thomas.hellstrom@linux.intel.com
Cc: ray.huang@amd.com,
	matthew.auld@intel.com,
	matthew.brost@intel.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skainsworth@gmail.com,
	alexander.deucher@amd.com,
	bernardomagri21@gmail.com,
	Vadim Nikitushkin <bub4z0r@gmail.com>
Subject: [PATCH] drm/ttm: apply the swapout bulk_move fix to the intended condition
Date: Thu, 10 Sep 2026 17:34:51 +0300
Message-ID: <20260910143451.65853-1-bub4z0r@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
References: <853fb020-592b-4f85-a9b5-a522aca6a29e@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 3db7d7d58341 ("drm/ttm: fix swapped-out resources never leaving
their bulk_move range") landed in drm-misc-fixes with its one-line
change applied to the wrong "if": the "if (ret)" after
ttm_resource_try_charge() in ttm_bo_alloc_at_place() became
"if (ret > 0)", while the "if (!ret)" after ttm_tt_swapout() in
ttm_bo_swapout_cb() that the patch targeted was left untouched.

ttm_resource_try_charge() returns 0 or a negative error code, so with
"ret > 0" a failed dmem cgroup charge no longer fails the allocation.
Restore that check and apply the intended change: ttm_tt_swapout()
returns the number of pages swapped out on success, so the bulk_move
removal must run for ret > 0.

Fixes: 3db7d7d58341 ("drm/ttm: fix swapped-out resources never leaving their bulk_move range")
Cc: stable@vger.kernel.org # v7.1+
Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
---
Christian, the commit in drm-misc-fixes (3db7d7d58341) ended up with the
change applied to the try_charge condition at line 532 instead of the
swapout one at line 1434; the resulting tree still has "if (!ret)" in
ttm_bo_swapout_cb(). This is a fix-up on top of 3db7d7d58341 since
drm-misc-fixes does not rebase. Sorry for the noise.

 drivers/gpu/drm/ttm/ttm_bo.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index a12af5b..9b85b5f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -532,7 +532,7 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
 		ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
 					      force_space ? &alloc_state->limit_pool
 							  : NULL);
-		if (ret > 0) {
+		if (ret) {
 			/*
 			 * -EAGAIN means the charge failed, which we treat
 			 * like an allocation failure. Therefore, return an
@@ -1434,7 +1434,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 
 	if (ttm_tt_is_populated(tt)) {
 		ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
-		if (!ret) {
+		if (ret > 0) {
 			spin_lock(&bdev->lru_lock);
 			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
 			ttm_resource_move_to_lru_tail(bo->resource);
-- 
2.53.0

