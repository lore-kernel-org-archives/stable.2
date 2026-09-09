Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F026D582B9A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788987080; cv=none; b=XqtFxXXwE+sSXQTcUge4XXuVAxuMHn9/mlCKtZPvsS4jr7JlpL4cfyM5FkqViboQHiob3cbFYAIR/PnwtnV1XCMtNs1tE8A/o1edRGDHRnweBK6hi2etntJhQggGzUkQ29eezl9AtBP0CHs6MlTey/NbXYN2EYtO9YmkRCag00Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788987080; c=relaxed/simple;
	bh=SQTj5lF1Zme4heu6m043jfxGx9HTFzHgmW83Z8v52XI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lWAtsKvmuv+WOGMQP4L3SmEH8LS/LhD89/z/bZ7UMBn3rzUIqnoMcFhWSDLi6vLUwSrbogosM2FZchru1LQlImIpDr7pVD9joPYcq1sFfFzDlounzGFo11Zm7bDsVEmzACxakvTUSHUVRBjkgY/rUj7aOyO1oVIGGpNoKP6NqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTLHceE3; arc=none smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTLHceE3"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c2940ff2313so49919566b.1
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 13:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788987066; x=1789591866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eJxZDDzOzotiu9MIMPs18NtUcg846lKcSJ1Zq48T8/E=;
        b=DTLHceE3nFbtM/ocrMT8DKX3opbW51+Zkn1iBMjZjjNEjpPGKEdnRHvY7ocEY6vpdc
         bwpV5Udc6q2KF47IxkyK5lzYptdgMry5Lui0Iq+t3JVEleAONom48Zd8mFnW3KtQ3F2V
         YdN6B21OuIf7OrbYseKaRM4GCGqfrykRO/GwAoXtBz2W7deCtEL+3pDThdijKrYNTYGP
         S5ProvvAwA+AuBi2Ip7zKsJ4mTDDRN4mokJBNT/7nABU/Xq3iQTq/mizriMZOD4s/EDO
         meEwklMTmfcAlMipbtKWVLojX26v5UaLIOCmiQ9FBdFApnDa/uNEwCf47RdP+WXH6HOA
         uKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788987066; x=1789591866;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eJxZDDzOzotiu9MIMPs18NtUcg846lKcSJ1Zq48T8/E=;
        b=FCeOtUq3jmVpseNV6lAQ0/0fg6Ahs+4QGsz/AHyZi4nVK5J4gCFQJchZoUSawql2J3
         3v5wN5TMwlV6rQXbNnwHYJdk0SezQITtz66/muLzjab5TLjgmHuoG+hPy5JT2nIKe67M
         yeY2rIWQmLa2VbXXSSHQGWt0UBKy2zWMoPiSqIXTYT0H6Sm39kX1whGh13damHsACvhw
         qhz+YkbnQj342aFYZHxERlis3yiynmff+lp6fFPx0hOC0wTorAS3qKLs32USiAqV36fQ
         2yzL1roFFkjSvxZzMwqe5qaIeW5iVkbCFp5XYgnPhxsQ57x98JpTr+XGINEjRQVdVxtH
         /06w==
X-Forwarded-Encrypted: i=1; AKwUvByb4R2k3UC/+OYMINU8VzV93e8sP4IFdSdpnPR0cO+xWF3gFCIldeOn3tMpuM/9ghXgc0S0Qkw=@vger.kernel.org
X-Gm-Message-State: AFuF++kvVfXpPnFcB4NDsl/3kBvH141mTWcYlkfNUgNa6im+pwQdnwA4
	RVCHBVEt04sO345MK2kIt42Oe7q7WNFzk3iQoOcTAKWPMy6sZedaeZPn
X-Gm-Gg: AYBFou0S4gnoZZi0nCU/Nw/QJYgaC26kMDxEhrZk/hRximHhCAU/vSSP2BrzgCKdFWT
	0pt1UtrJQpa+5o8FdSw3a4k9GWmd5wKaOeE4g2Q5CAqLwWaQfaxRMQRFzip9kNxM5AYJDHR4ypf
	vH44JC7gkPz9V2wjoBl4KQLKh1vp9y68TFPCI1sVl1EfViYf9eYcxyNivh6z8onng6T3AQru5/f
	4v+NnSxIAfC8AQN12NFhtB/T7qK2nXh4jdb/bL7LZI1s1e7gHeGQ9ATj6lvfQQAsNZIwqfyCWjT
	DZdPIiEWsvnolWQdJpBgXlQ5+9eEEXqb4Bby7uMy704rCTCLxK7jEZ8/sRA5JOcuIhL1H9mqltS
	Jd7aL6uIPlMRwttWi1CgWxNn96YqZyIvCdSuFMCpi32yCvgRE7XhNLdOUJiKGW9FzfVKs7Z9w2Q
	/91dVP7bXKtzIFUDdpVBUwf938/Mo80tKc8qI9FWiAJiKe0/39t3tE/fSqK8Q1r5YBtsoHhdiGy
	+uJwA==
X-Received: by 2002:a17:907:3f0d:b0:c25:f7db:4bec with SMTP id a640c23a62f3a-c2945eecb04mr57074466b.18.1788987065689;
        Wed, 09 Sep 2026 13:51:05 -0700 (PDT)
Received: from bbzr-mini (cool-t.fvds.ru. [103.137.251.133])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c260d03644bsm825646266b.6.2026.09.09.13.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 13:51:05 -0700 (PDT)
From: Vadim Nikitushkin <bub4z0r@gmail.com>
To: christian.koenig@amd.com,
	ray.huang@amd.com,
	matthew.auld@intel.com,
	matthew.brost@intel.com,
	thomas.hellstrom@linux.intel.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	skainsworth@gmail.com,
	alexander.deucher@amd.com,
	bernardomagri21@gmail.com,
	Vadim Nikitushkin <bub4z0r@gmail.com>
Subject: [PATCH] drm/ttm: fix swapped-out resources never leaving their bulk_move range
Date: Wed,  9 Sep 2026 23:50:28 +0300
Message-ID: <20260909205028.13799-1-bub4z0r@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ttm_tt_swapout() returns the number of pages swapped out on success and
a negative error code on failure; for a populated ttm it never returns
zero. Commit b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU
walk on swapout failure") moved the bulk_move bookkeeping in
ttm_bo_swapout_cb() under "if (!ret)", so the
ttm_resource_del_bulk_move_unevictable() / ttm_resource_move_to_lru_tail()
pair is now skipped on every successful swapout. The equivalent change
for the shrinker in commit 1d59f36e95f7 ("drm/ttm: Fix ttm_bo_shrink()
infinite LRU walk on backup failure") tests "lret > 0", which is what
was intended here as well.

Before b2ed01e7ad3d the resource was taken off the bulk_move before the
swapout; since then a swapped-out resource stays inside its BO's
bulk_move range (and on the manager LRU) although it is unevictable.
When it is later freed or the BO leaves the bulk_move
(ttm_resource_free(), ttm_bo_set_bulk_move() via amdgpu_vm_bo_del()),
ttm_resource_del_bulk_move() skips it because of its
!ttm_resource_unevictable() guard, so a range endpoint in pos->first /
pos->last is left pointing at freed memory. The next
ttm_lru_bulk_move_tail() or ttm_resource_add_bulk_move() on that cursor
is a use-after-free, seen as the resv WARN in ttm_lru_bulk_move_add(),
"list_del corruption" in ttm_resource_move_to_lru_tail() or a NULL
dereference in ttm_resource_manager_next() -- minutes to hours after a
hibernation, or at process exit / reboot following one. Samuel
Ainsworth's analysis of drm/amd issue 5387 (see Link) identified the
dangling cursor; the missing removal at swapout time is the reason it
dangles.

Testing the condition for success restores the removal. On an AMD
Phoenix APU (ASUS UM3406GA, gfx1103) running suspend-then-hibernate on
a 7.0.y stable kernel carrying the backport (Ubuntu 7.0.0-31) the bug
crashed 5 of 18 hibernation cycles; a function profile of one
hibernation showed 336 ttm_tt_swapout() calls and zero
ttm_resource_del_bulk_move_unevictable() calls. With this change the
removal happens for every swapped-out resource and 12 further cycles
were clean.

Fixes: b2ed01e7ad3d ("drm/ttm: Fix ttm_bo_swapout() infinite LRU walk on swapout failure")
Cc: stable@vger.kernel.org # v7.1+
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/5387
Link: https://lore.kernel.org/dri-devel/CAHYiNPa6aVacJoLOje-qZ1GyYx-9p0tN4NuP8D_eSL+UJeevXw@mail.gmail.com/
Signed-off-by: Vadim Nikitushkin <bub4z0r@gmail.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index ef56c18..9b85b5f 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
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

