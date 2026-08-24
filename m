Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9972B1A6808
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787570539; cv=none; b=bWrIzhcqv5p+EHoGj41I8a9fE/mQsOW+sCuBLeW7ALJC8DXb52pAj1mz7jObALa6OrEVse+2K5JEgfBtHhxzoo0z3extV6goIf3Dw94pKWp6nUEFlQIeSrZRtglZQ3SKyzM/9Mk1zoGTNkLv//fRIa2B+6CwYwVPe3+kz42e+wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787570539; c=relaxed/simple;
	bh=wmneEY+saneeMJOnZnFFvQtNwfp/nLH4MBhMqQKtR70=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iJJU7tNBdyPJwdBe/yrgBy/JPh59ek+c7QHBvbZruk6Jych1k6k2m0u5qFC7AQpp/0WK+Fd4xK6RCcOLLIN5S8k8OuXeQ6Ms21qUzPw64uk0dVGWIPP1z4azCHrtYHJqhtNjaBpdxTmxo/YnpTPHs7lAe4UWEqA8So/i159paSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8BUQJIF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8BUQJIF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F59A1F000E9;
	Mon, 24 Aug 2026 11:22:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787570537;
	bh=KHnJkzx7rE7bymgAadJTIjBw0NDE6UBXxANWpDA4dto=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=f8BUQJIFk2xYGKEgjYP4bptavE2s8S7ydJM5p3q+Gqqd4L0B7db4RThCaJWuUHk5M
	 5/cOh6zG3ggoHyYJ+519ooxS1dA6KgJFwqqj5HP+Oi+vUEIP+CQVUdZcdO164+41gX
	 1XkqWMGi5y3UrQhdA6V3V9hcPvqKPMKXU0V9bTtIeqYzPuYIbO0TcVv299M7GM8QzU
	 APXKjOsz7qecynrsG+RA8yhyvmYwwFP51wvRb7rr1pzj0k4nhIWgEwo/GUFN/e7pQ/
	 BAttn0wXeaYrn5Zf0xljC/X1txJIn1QewQaANm/K+8DWHshU/e8HmlRO1PTNIs+3VH
	 idk4uodkbiAFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y 4/4] drm/xe: Fix DPT allocation paths.
Date: Mon, 24 Aug 2026 07:22:11 -0400
Message-ID: <20260824112212.417899-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824112212.417899-1-sashal@kernel.org>
References: <2026082003-mountain-flaccid-179a@gregkh>
 <20260824112212.417899-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c | 33 +++++++-------------------
 1 file changed, 8 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index a9e62856685af..cacd861ac60c5 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -161,31 +161,14 @@ static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
 		dpt_size = ALIGN(intel_rotation_info_size(&view->rotated) * 8,
 				 XE_PAGE_SIZE);
 
-	if (IS_DGFX(xe))
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size, ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_VRAM0 |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   pin_params->alignment, false);
-	else
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size,  ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_STOLEN |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   pin_params->alignment, false);
-	if (IS_ERR(dpt))
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size,  ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_SYSTEM |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE |
-						   XE_BO_FLAG_FORCE_WC,
-						   pin_params->alignment, false);
+	dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
+					   dpt_size,  ~0ull,
+					   ttm_bo_type_kernel,
+					   XE_BO_FLAG_VRAM_IF_DGFX(tile0) |
+					   XE_BO_FLAG_GGTT |
+					   XE_BO_FLAG_PAGETABLE |
+					   XE_BO_FLAG_FORCE_WC,
+					   pin_params->alignment, false);
 	if (IS_ERR(dpt))
 		return PTR_ERR(dpt);
 
-- 
2.53.0

