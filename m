Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F29504398F5
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 16:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787588027; cv=none; b=M2fWfSNAK6dt5Ztw53EJ0mpy4atwXAxVdWlOINHytWII1cQPa6TIZ0Qc+N+Inmlgbo68pZGq9R7tshckyaTAusDn8JvmIoF1M2a+7YDSn0RkHw0bSMWBJ+KPUT2oW6NrSCT3pD5EIEbYvb5I4vjBZwyrl8tV/S0xyHdEfOzkvlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787588027; c=relaxed/simple;
	bh=TIEwiATh7T8mtnuXTsmS3Oj6Q8IKR3UhQuLWo46fPRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=irlJGzxV8NePsHgugBCa2EkPYuBezJojy/xDMGdFOXzd0oLChHJmZHbUTMDA7GOcgNPawXC67RiU6sK0+NbRcQQh37ue11yjkKX2jbzXmx/AGi/Sbm035ge5QA/8dUPFr4oblHwXr/bs9L4hpcZe/sr9Ww+9f09/IXrtMt+Z4RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jlu6vxu2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jlu6vxu2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB0D1F000E9;
	Mon, 24 Aug 2026 16:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787588023;
	bh=CycZsPOBkzH/RZqAsGhLxE0AGD/oImVo4VfctfyaJ9I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jlu6vxu2PeidiMGVAemQxs7B/0L70yaYCY6sNMhUI7I6pMQBXitbE2wP0eBk/ISlM
	 WpmeDoT0oV3MkjYsX3xw+Z0CYhGUZDwtVVFHiU3bCHZwsiCXC4gzDPXVYQ3/ufpKRf
	 Qi8oKfu6rTYXdTHHOql0ue08byucgv8PMVRwJpnzSZYupLdB8ZHdjZv3t1uoxejXsF
	 OvMVowYmFd9qbsUtTazABtgv+hGD+CMIziUXFtqKsH9ujT1Pa5lvWrNqWFIl0uyvp+
	 7tZ/KAUdPT8gd2UmTtp+jBT3efnMWk4JpuOl4eyTLC7MLlcp8g2hND5OIisYqJMFbH
	 oMZuftIm08iRw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maarten Lankhorst <dev@lankhorst.se>,
	Matthew Auld <matthew.auld@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/xe: Fix DPT allocation paths.
Date: Mon, 24 Aug 2026 12:13:41 -0400
Message-ID: <20260824161341.4114875-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082005-postbox-draw-4d80@gregkh>
References: <2026082005-postbox-draw-4d80@gregkh>
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
[ Replaced `xe_bo_create_pin_map_at_novm()` with `xe_bo_create_pin_map()`, dropped the alignment argument, and renamed `XE_BO_FLAG_FORCE_WC` to `XE_BO_FLAG_SCANOUT`. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index 0558b106f8b60..75756cc0255c0 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -97,24 +97,12 @@ static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
 		dpt_size = ALIGN(intel_rotation_info_size(&view->rotated) * 8,
 				 XE_PAGE_SIZE);
 
-	if (IS_DGFX(xe))
-		dpt = xe_bo_create_pin_map(xe, tile0, NULL, dpt_size,
-					   ttm_bo_type_kernel,
-					   XE_BO_FLAG_VRAM0 |
-					   XE_BO_FLAG_GGTT |
-					   XE_BO_FLAG_PAGETABLE);
-	else
-		dpt = xe_bo_create_pin_map(xe, tile0, NULL, dpt_size,
-					   ttm_bo_type_kernel,
-					   XE_BO_FLAG_STOLEN |
-					   XE_BO_FLAG_GGTT |
-					   XE_BO_FLAG_PAGETABLE);
-	if (IS_ERR(dpt))
-		dpt = xe_bo_create_pin_map(xe, tile0, NULL, dpt_size,
-					   ttm_bo_type_kernel,
-					   XE_BO_FLAG_SYSTEM |
-					   XE_BO_FLAG_GGTT |
-					   XE_BO_FLAG_PAGETABLE);
+	dpt = xe_bo_create_pin_map(xe, tile0, NULL, dpt_size,
+				   ttm_bo_type_kernel,
+				   XE_BO_FLAG_VRAM_IF_DGFX(tile0) |
+				   XE_BO_FLAG_GGTT |
+				   XE_BO_FLAG_PAGETABLE |
+				   XE_BO_FLAG_SCANOUT);
 	if (IS_ERR(dpt))
 		return PTR_ERR(dpt);
 
-- 
2.53.0

