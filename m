Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 357AD3803C8
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785322364; cv=none; b=qDbDJD2XK2j+sitBYrEGYRdA4xI5FLSuJdJW8dH15GwBOLleEvKgaqTJNOU0t+6aSvA80IB0StN6ZHYJrw+7E2GkPUd/PPGf6D6hvW9c3uztCVVhaF/LNJmrYidCMZ3oRSZqV15IUjiGfKt7BTb5Vb6CT6lSc/53DQDTXM3kTuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785322364; c=relaxed/simple;
	bh=49zpsQJP3PncHag7DWVmyWAAlTwCtPlwbDSXSumQkEk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pWwM3EwhibXmu1sGbu9DvksT5Gpm1P5A9av9rQBzHAQi3QCH6lLQ9ocJjD7oUC37o+Rr3hUSv/C+xxzyvPQjQeubOyN3t2EBSwL4C+mhDSrcQJ0QkUAu6pEyzFg1C9NrAT2dLQTobfUUw9gqrAZq0XfGCRucCfC/ek3LGzRpK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bN3/1pIt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bN3/1pIt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4507D1F00A3D;
	Wed, 29 Jul 2026 10:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785322355;
	bh=YMpHQkKxZu7mlQOZarlojO/LVoiJSWpE29E3v4RHKn8=;
	h=Subject:To:Cc:From:Date;
	b=bN3/1pIthkHfv5bd/fGcz2D+7IZtQm0hLEWvFkLP+jD5/wCGV2vX9mvoggaucRIFp
	 bCGuAwbS3g/armrMDrl2ZDqV5e5tUqmeVJSZpzq0cqyBCrlH62O9GVB18gU8Ks72tS
	 OjdWv7gjodK6HOC8CdiSIXNv8f5s5YktagR6Njh0=
Subject: FAILED: patch "[PATCH] drm/xe/display: skip FORCE_WC and vm_bound check for external" failed to apply to 6.12-stable tree
To: matthew.auld@intel.com,dev@lankhorst.se,matthew.brost@intel.com,stable@vger.kernel.org,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:52:22 +0200
Message-ID: <2026072921-darn-curator-859f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x d472497265374e895e31cf2af8a2c5f650019889
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072921-darn-curator-859f@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d472497265374e895e31cf2af8a2c5f650019889 Mon Sep 17 00:00:00 2001
From: Matthew Auld <matthew.auld@intel.com>
Date: Fri, 12 Jun 2026 18:05:02 +0100
Subject: [PATCH] drm/xe/display: skip FORCE_WC and vm_bound check for external
 dma-bufs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, xe_display_bo_framebuffer_init() unconditionally attempts to
apply XE_BO_FLAG_FORCE_WC to the buffer and rejects the FB creation with
-EINVAL if the BO is already VM_BINDed.

However, for imported dma-bufs (ttm_bo_type_sg), this check doesn't seem
to make much sense since CPU caching policy is entirely controlled by
the exporter. Plus there is no place to set this flag, in the first
place. Also this is not rejected if not yet vm_binded, but that seems
arbitrary since setting or not setting FORCE_WC should a noop either
way, at this stage, and whether it is currently VM_BINDed makes no
difference.

Currently if we run an app and offload rendering to an external dGPU,
like NV or another xe device, the dma-buf passed back to the compositor
(igpu) will be an actual external import from xe pov, and it will be
missing FORCE_WC, and if the compositor side did a VM_BIND before
turning into it into an fb the whole thing gets rejected.

So it looks like we either need to reject outright, no matter what, or
this usecase is valid and we need to loosen the restriction for sg
buffers.  Proposing here to loosen the restriction.

Assisted-by: Gemini:gemini-3.1-pro-preview
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7919
Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Maarten Lankhorst <dev@lankhorst.se>
Cc: <stable@vger.kernel.org> # v6.12+
Reviewed-by: Maarten Lankhorst <dev@lankhorst.se>
Link: https://patch.msgid.link/20260612170501.550816-2-matthew.auld@intel.com
(cherry picked from commit 3e493f88c84088ccd7b53cdd23ac5c875c9a60dd)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>

diff --git a/drivers/gpu/drm/xe/display/xe_display_bo.c b/drivers/gpu/drm/xe/display/xe_display_bo.c
index 7fbac223b097..8953da0136dc 100644
--- a/drivers/gpu/drm/xe/display/xe_display_bo.c
+++ b/drivers/gpu/drm/xe/display/xe_display_bo.c
@@ -48,7 +48,8 @@ static int xe_display_bo_framebuffer_init(struct drm_gem_object *obj,
 	if (ret)
 		goto err;
 
-	if (!(bo->flags & XE_BO_FLAG_FORCE_WC)) {
+	if (!(bo->flags & XE_BO_FLAG_FORCE_WC) &&
+	    bo->ttm.type != ttm_bo_type_sg) {
 		/*
 		 * XE_BO_FLAG_FORCE_WC should ideally be set at creation, or is
 		 * automatically set when creating FB. We cannot change caching
diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index f93c98bec5b5..5f4a0cd8deca 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -331,7 +331,8 @@ static struct i915_vma *__xe_pin_fb_vma(struct drm_gem_object *obj, bool is_dpt,
 	int ret = 0;
 
 	/* We reject creating !SCANOUT fb's, so this is weird.. */
-	drm_WARN_ON(bo->ttm.base.dev, !(bo->flags & XE_BO_FLAG_FORCE_WC));
+	drm_WARN_ON(bo->ttm.base.dev, !(bo->flags & XE_BO_FLAG_FORCE_WC) &&
+		    bo->ttm.type != ttm_bo_type_sg);
 
 	if (!vma)
 		return ERR_PTR(-ENODEV);

