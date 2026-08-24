Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648B430CE5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 14:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787580349; cv=none; b=upHq6ww2vhhTmEe/oIbfG8A+mehH4eYLAwAgD2GEQ4tGhBLCQtpe3DwqohHOvbl1yjf6W39btI38gtZ7GaBfKPFhgbosfT05GyHLC2YA24p1sbHnRO6Wv0JWYapx7Xpz6xXG+ARgdCDg2LAP92+06Xcd0HDMIW4XbwtYQqljsqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787580349; c=relaxed/simple;
	bh=US0mn8aNJEEymDQoSTBLp9M/Ahz9i3asacG9RooBUEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=McA/yBjTloctYoc5hFtUZ6JrTvOFlOfF/QjKNFS/nwCNrJwlc4bUIGExZEJCYoAyjoPW2/cz5bugqAdX1GmNouuuyss64BzDNEZNMwDhiNPMwyk+B0gEGwu3emiXuC+ZQDIDcj5OwOsCqxbTrS4tx4cYupii+pFljOMZcrTvWzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L2/2ttzB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L2/2ttzB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22E541F000E9;
	Mon, 24 Aug 2026 14:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787580347;
	bh=fqriEm0hjRPcxWpAzfCR+HiU2k9ZzB1l43ObQ/CAkCs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=L2/2ttzB4ex774rGSwsOYv0bvodfeG4ADc+HC7MT6NsNtm15TyoQe+dzfGXMf9opg
	 ExXz5VlkTZZyTatC5waqGZ4XCSjpqoTbTEehp0wQOziwyInCzdWXefR0aGHgOpwhw2
	 uKGqvzYGimlwxe//5bvZayB/GNlFR5myzEU90aIiCISoVhGTPpYgHWEpbg3MCIl1UF
	 pqcTBMSm+vvS9J3mmcQZuAvsGYHkMVVmKkSCNfs/+qzNZdTzeJyLD2SYszUD8fhas2
	 8oOobwwVybC3eNKW4qkOtylHMWRUMI/DeDpAQJNJAhuUlEnit/3F1dXGrNqCNVbWAV
	 2i6PORVbmAfow==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/xe: Fix DPT allocation paths.
Date: Mon, 24 Aug 2026 10:05:45 -0400
Message-ID: <20260824140545.3097335-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082004-haphazard-giggling-e1f0@gregkh>
References: <2026082004-haphazard-giggling-e1f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maarten Lankhorst <dev@lankhorst.se>

[ Upstream commit fc648757908304aedbad74f74bf58192aec383db ]

Remove the fallback for VRAM to system memory, I tested it and that
doesn't work at all, only a black screen with pipe fault errors were
observed.

On systems with media GT, extra latency is added when accessing stolen
memory when the GT is in MC6. Since we additionally aren't counting how
much memory is used for stolen and we could in theory fill up the
entire stolen area with DPT's, avoid using stolen and only use the
default memory region.

Using stolen may also result in random system hangs under load.

Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
Cc: <stable@vger.kernel.org> # v6.12+
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Link: https://patch.msgid.link/20260630135523.1775379-2-dev@lankhorst.se
Signed-off-by: Maarten Lankhorst <dev@lankhorst.se>
Acked-by: Matthew Brost <matthew.brost@intel.com> #teams
(cherry picked from commit a196406a3831291598fe8e73245914f7acffdfe0)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
[ adapted `pin_params->alignment` to `alignment` and renamed `XE_BO_FLAG_FORCE_WC` to `XE_BO_FLAG_SCANOUT` for the pre-rename flag name ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c | 32 +++++++-------------------
 1 file changed, 8 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index b18d15cc3c53d..5bf00505dab59 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -101,30 +101,14 @@ static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
 		dpt_size = ALIGN(intel_rotation_info_size(&view->rotated) * 8,
 				 XE_PAGE_SIZE);
 
-	if (IS_DGFX(xe))
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size, ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_VRAM0 |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   alignment, false);
-	else
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size,  ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_STOLEN |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   alignment, false);
-	if (IS_ERR(dpt))
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size,  ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_SYSTEM |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   alignment, false);
+	dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
+					   dpt_size,  ~0ull,
+					   ttm_bo_type_kernel,
+					   XE_BO_FLAG_VRAM_IF_DGFX(tile0) |
+					   XE_BO_FLAG_GGTT |
+					   XE_BO_FLAG_PAGETABLE |
+					   XE_BO_FLAG_SCANOUT,
+					   alignment, false);
 	if (IS_ERR(dpt))
 		return PTR_ERR(dpt);
 
-- 
2.53.0

