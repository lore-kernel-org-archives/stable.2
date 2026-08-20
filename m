Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE753F8ECD
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787224467; cv=none; b=C7orPPF9NWZ7Q+AnYnR30hstuHe6wxeEjfS95Olgcjq+1m+aUaNeejagnhcjdmyq0ZTnIXO+LBbenxoOQ/fVeD4lhXaGivX+EAMZIJ1gxdamIBeiTZWY+oEWEt9wBmmkE2wveo1NsGQ7Oeej6TXCEyELNuCfZ1eT8Z1eFtADcyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787224467; c=relaxed/simple;
	bh=7j2YHcjPAFPZ4qg8FCyLX8c7TbS8C+cb7HbcTWlA1vY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bK9WVk+GefTKh3zrxL+z2yqdsnSEfOr0Rfcf5QY1SsHfQJkqrtjvWnqfaNYhCOxs/xJhcW4oEw97cLoz5Rh+k5rleKG45okqYtj0vJF8nYdxusZFKUBIi8X7DZE6nyxYNFd3w3x/WtHcUXzBOugiX1eM98/g646X22p/a+aswXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KY2+ZUl1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KY2+ZUl1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00351F000E9;
	Thu, 20 Aug 2026 11:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787224466;
	bh=zQvNu/0kcYRU3AaxYCNw0p4jnrpuyGdqLKCfJ40eX90=;
	h=Subject:To:Cc:From:Date;
	b=KY2+ZUl18BPnrEK/8df3K4nDehVJxpKNyxfZ/qS6cBXJl9aqMh3HzAWT8QnCcf9X0
	 AL/3KiiwurC2P0wpSJ5HK8H6FrxHYIxmp8s5/xKTcHnW6r4qZVsfPU7pd432DWnrTR
	 PZsgS3RHvLcf4rflxnzQ8xVb8kCqvKD3l8ZINe0U=
Subject: FAILED: patch "[PATCH] drm/xe: Fix DPT allocation paths." failed to apply to 6.18-stable tree
To: dev@lankhorst.se,matthew.auld@intel.com,matthew.brost@intel.com,stable@vger.kernel.org,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:14:04 +0200
Message-ID: <2026082004-haphazard-giggling-e1f0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x fc648757908304aedbad74f74bf58192aec383db
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082004-haphazard-giggling-e1f0@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fc648757908304aedbad74f74bf58192aec383db Mon Sep 17 00:00:00 2001
From: Maarten Lankhorst <dev@lankhorst.se>
Date: Tue, 30 Jun 2026 15:55:20 +0200
Subject: [PATCH] drm/xe: Fix DPT allocation paths.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index 5f4a0cd8deca..73469ea5f333 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -164,31 +164,14 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
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
 

