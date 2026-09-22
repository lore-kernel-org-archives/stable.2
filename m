Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37D6559CB7
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790091277; cv=none; b=oqtK4V7dvOJMEuz6hPFQ+YFn7LTV17Q3uNtdAazDleOnH3BAULEIBwQCzYKi0xXN8S9EfxVB4k4qrYMIL5EZXUkvLraQ+WZqbsRITpaFNxxIToot3NKZANuqPthLFIc7A56sR2XVYfiRH5VgHYpNWXiaWnITbgoToXNcb4kqlyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790091277; c=relaxed/simple;
	bh=6e8xt0qDiGDgPIVCvPiLiACnTIXW/UAJW4Lcp864Cpk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HO/bH368kxCwsOTyV55RV1RKyvpG78o9jkULsuh+pxnHtohEiKijZ1m+1Q76aE503kd21dGwQ3UfSjtofGQ2/wcKEM5iQw6iV2vZw/eXJEOiBN7PUF6UNiqBJYECHAQpo2WPtbbJNMYrsoKPs4dz28S6WF9npKp7S36JhRQI+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T1QA7esm; arc=none smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T1QA7esm"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a985fba28bso5268247a12.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:34:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790091274; x=1790696074; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KqNXgwrnC6/yf8ldr9VODDt8z7mpX7HYSVueoRJSAsQ=;
        b=T1QA7esmWDTFrS3cZfYWRaaJy6hRqqUArXo9B0MyPFfzuJckg5+3AMoRKBpB7qtJQb
         98rx8RF2yX/kCP3QVQ2VVOxAmB4+oma6V9+c1rMgrtAwxyt0+82C5e8MI7UWMAO1imNP
         T6RSdSA4htxZEokb4OksEYBVmRWmG3Q/weEhanMW7BjCz/yT9IqZNc0Ji6iyxXhIWWiy
         c8GtK5IJhUqy/av7Pl7W7qgWAUGsFl9zwzaUbsszQlQBJbkbVeWmclWwfdlhYr8Q/Px4
         shOXVfkgGcRG/343awB+JLEOybQm2foQQvDw2DXZurI2zGhbkCvWqIQT/qonR0t27/ey
         OEpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790091274; x=1790696074;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KqNXgwrnC6/yf8ldr9VODDt8z7mpX7HYSVueoRJSAsQ=;
        b=wOohWPsXYp07Wwmy0cNTJ9ecEaQ0wPX8TQkxojXkN1e8VnnVkVhOohu78KBbflIf3+
         f+pjwxKsnAZXbLWIqmmQWsRrlI8NQgzaK6HLQNrKI00T0YsY3KMTLnoporYEWGJcihMW
         ZtWgJEnzkQlI0ISGoEkYfE1soHDPBcXGgBKzeOX+/5s4E6wDZi4Nn7bHNTIka1qutPcc
         WoSdCCbUipas69Bn5cI3LYpSdHebfBE0df4fzrM0Iu6leddLjdDRvVVjI4vfmOHHBU7f
         QsBdUeu093jNd5FclWK3+Bm+RvqtiLuk6yFuWKPZBxiA32g1DSeioxIWzkELjoj1N4VM
         q7Og==
X-Gm-Message-State: AFuF++musD9aOZGuumH/s2c3ikjXOtAa/x9AHczl3YcHwRMwjEea2fIw
	s8/mXDvo3ErQAtQUuSpkcuUoI9t9iS5D2ptOHwunO5ND3630Vv5TFHvXhG35xrUHaRvbZg==
X-Gm-Gg: AYBFou0SUD/Lw8a+0xtymnfX2EJGqkYSGLaqCISI/KJuDUKIx8TAgYv23D3pE3LsH9W
	pV4VdsdWUDc8V6fRSKfPxQ0KZlWJhl8tfta5M6W8j8g5k3yGPSR883drvCC6LOfmREJvRRj0QQx
	+gtQUUym+TNfulL9DkP2LA8vB+8rWR3jvAEboIxvtGG1f0XgrxZ4L4MFf9IC/tuGUj+9vnV65fw
	ye4gFU032ZRI8JWIRl/xPHUEkiuMX9ksbaaIO469b+XFnkJwmatPvmJKrzC/4Ttc1bjZZlmV83Q
	MEwvXaenspViCXXy8fY5cTSfSXYUkPxAev6xmXYe1zquFeHmVtaVOfZtPTQREn69Veepzzq8gGC
	BLjvdWboJFtww8NuGhxlAlSCgtGlaMpnDR47Z+B4kmCFl1pPQQzHtU+uVlwh++c3AlF7nWfqUbG
	DY1OxrrrglKMftcfjSUggoUXrjVM0DltBheBqpvRcHQvcIGYLgceZ24VRLTizgZ5rhHPzQqb3EH
	Gdd24ixx2jmaUQ=
X-Received: by 2002:a05:6402:13d0:b0:6aa:a01e:f177 with SMTP id 4fb4d7f45d1cf-6aaa01ef223mr3266486a12.21.1790091273890;
        Tue, 22 Sep 2026 08:34:33 -0700 (PDT)
Received: from bbzr-mini (cool-t.fvds.ru. [103.137.251.133])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6aaa450c4basm1272517a12.20.2026.09.22.08.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 08:34:33 -0700 (PDT)
From: Vadim Nikitushkin <bub4z0r@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	christian.koenig@amd.com,
	thomas.hellstrom@linux.intel.com,
	dri-devel@lists.freedesktop.org,
	skainsworth@gmail.com,
	Vadim Nikitushkin <bub4z0r@gmail.com>
Subject: [PATCH 7.2.y] drm/ttm: fix swapped-out resources never leaving their bulk_move range
Date: Tue, 22 Sep 2026 18:33:34 +0300
Message-ID: <20260922153334.136648-1-bub4z0r@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092253-dimness-unethical-2515@gregkh>
References: <2026092253-dimness-unethical-2515@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 3db7d7d583419f7b1f2e141e36418802dbb25cf8 upstream.

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
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20260909205028.13799-1-bub4z0r@gmail.com
[ Squashed with commit fcfe64715b425262af1b36f498f9197f3537ceed
  ("drm/ttm: apply the swapout bulk_move fix to the intended condition"):
  upstream 3db7d7d58341 was applied to the "if (ret)" after
  ttm_resource_try_charge() in ttm_bo_alloc_at_place() instead of the
  "if (!ret)" after ttm_tt_swapout() in ttm_bo_swapout_cb(), and
  fcfe64715b42 restored the former and changed the latter. 7.2.y has no
  ttm_resource_try_charge() (dmem cgroup charging is 7.3 material), so
  neither commit applies on its own; the net effect of the two is the
  single hunk below, which is the change the changelog describes. ]
---
 drivers/gpu/drm/ttm/ttm_bo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index bcd76f6..ca6fc5c 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -1178,7 +1178,7 @@ ttm_bo_swapout_cb(struct ttm_lru_walk *walk, struct ttm_buffer_object *bo)
 
 	if (ttm_tt_is_populated(tt)) {
 		ret = ttm_tt_swapout(bdev, tt, swapout_walk->gfp_flags);
-		if (!ret) {
+		if (ret > 0) {
 			spin_lock(&bdev->lru_lock);
 			ttm_resource_del_bulk_move_unevictable(bo->resource, bo);
 			ttm_resource_move_to_lru_tail(bo->resource);
-- 
2.53.0

