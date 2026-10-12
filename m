Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4A84A3F0C
	for <stable@vger.kernel.org>; Mon, 12 Oct 2026 15:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791819144; cv=none; b=pa7Nqo7jLC4cZMtqPTPx6WQMeubOxH+ul397a7CVPVfSCt50GpBIxtghVWdhgfBaqlLKB3bL7h9718Gfw5sHfM1NEZBP3TwbHFr6nH4s5trD71Zl09qhbpRbPa1e6E8+ay3FJcfVdsA7vJhGmf5zL5qCT0MvwD9g8SNYCMTO3Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791819144; c=relaxed/simple;
	bh=EPqi4HNOoL4O1leECbbFoW86XbmF1isQ3ewOvRvqvbU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dmYjzPcUXPJSnzJ5CpDWleW7XQXiiuaVujjb8hV9OxT7UmiZBj+t7mpdcPWsuDwQrpyOgVxRECdnf+x7tp/0xmncjxrUR0yiQ1l3yXzzdBLmRIJ2FzBvPpS4Jn8e9KKA5t6XYROlmD7SQn/B8NsofYkv6ysh6szn1JFfYFZD0yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zEPBAKG1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zEPBAKG1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3AFA1F0089B;
	Mon, 12 Oct 2026 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791819142;
	bh=50qqZMfAmYcwsRzUPrVJCFo3b85OL5m8MS0SGUhtvso=;
	h=Subject:To:Cc:From:Date;
	b=zEPBAKG1ZVhEGrk/zbnAOBWoYuDJc6/E1aHDrgL4o0YXpW6w4oS4I5ARWM+FcWeX5
	 3xQJcA4BN+2+pxiJr9JkLZ63zMurBLgJUY3N+dP1s4yy3kJks9k1ZCmsOIGwJMWpCO
	 E0P82f3TWrKMEJJ3AnaubSqK0esEkCA4l8nQpBUo=
Subject: FAILED: patch "[PATCH] drm/xe: Fix stale pinned_link entry when fb-pin performs the" failed to apply to 6.12-stable tree
To: thomas.hellstrom@linux.intel.com,himal.prasad.ghimiray@intel.com,maarten.lankhorst@linux.intel.com,matthew.auld@intel.com,rodrigo.vivi@intel.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 12 Oct 2026 17:31:45 +0200
Message-ID: <2026101244-tumble-gizzard-1421@gregkh>
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
git cherry-pick -x cf238c067eaae1cbfb00738e29219b9568d2313e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026101244-tumble-gizzard-1421@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cf238c067eaae1cbfb00738e29219b9568d2313e Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Date: Fri, 2 Oct 2026 12:08:30 +0200
Subject: [PATCH] drm/xe: Fix stale pinned_link entry when fb-pin performs the
 final unpin
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

xe_bo_pin_external() and xe_bo_unpin_external() maintain the bo's
pinned_link list membership in xe->pinned.late.external, based on
whether the current call is the outermost pin or the final unpin.
However, the same external bo's pin_count can also be raised and
lowered directly by __xe_pin_fb_vma()/__xe_unpin_fb_vma(), which pin
the bo as a display scanout buffer without going through
xe_bo_pin_external()/xe_bo_unpin_external() at all, and have no
notion of, or ownership over, pinned_link.

If a bo is pinned both externally (e.g. dma-buf export) and as an fb,
and the external unpin happens first, xe_bo_unpin_external() correctly
observes pin_count > 1 and leaves the bo on pinned_link. When the fb
unpin later performs the true last unpin (pin_count 1 -> 0), it never
touches pinned_link, leaving the bo linked on xe->pinned.late.external
indefinitely. Once the bo is subsequently freed, this stale list entry
points into freed memory, corrupting the list and risking a
use-after-free the next time the list is walked or spliced.

The backup object pin/unpin sites in xe_bo_notifier_prepare_pinned()/
xe_bo_notifier_unprepare_pinned() have the same bypass characteristic,
though they never add their bo to a pinned list, so are not affected
by this particular list-corruption issue.

Move the pinned_link removal into xe_bo_account_unpin(), which already
runs on every unpin path (kernel, external, framebuffer, backup
object) right before the true 1 -> 0 pin_count transition. Since
list_del_init() only operates on the node itself, this removal is
list-agnostic and safe to perform regardless of which list (external
or kernel_bo_present) the bo happens to be linked on, or which code
path is performing the final unpin. Drop the now-redundant explicit
list_del_init() calls in xe_bo_unpin_external() and xe_bo_unpin().

v2:
- New patch

v3:
- Rebased on changes to previous patch.

Fixes: 44e694958b95 ("drm/xe/display: Implement display support")
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v6.8+
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Reviewed-by: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Assisted-by: LLM
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Link: https://patch.msgid.link/20261002100830.12297-3-thomas.hellstrom@linux.intel.com
(cherry picked from commit ca58d36a1f93af586ee93b340c9f9fd81312cc01)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index f85d5f9b5fce..7b95ce0445a9 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -495,12 +495,27 @@ static void xe_bo_account_pin(struct xe_bo *bo)
  * ttm_bo_unpin(), so that the check against the true 1->0 transition sees
  * the pin count that is about to be released. See xe_bo_account_pin() for
  * why imported bos are excluded.
+ *
+ * On the true last unpin, also removes @bo from whichever pinned-bo list
+ * (external or kernel_bo_present) it may currently be linked on, since a
+ * bo's final unpin can happen through a pin path (e.g. framebuffer,
+ * backup object) that has no notion of, or ownership over, that list.
+ * This is safe and list-agnostic: list_del_init() only needs the node
+ * itself, not knowledge of which list it is threaded through, and is a
+ * no-op if @bo is not linked.
  */
 static void xe_bo_account_unpin(struct xe_bo *bo)
 {
 	struct xe_device *xe = xe_bo_device(bo);
+	bool last_unpin = bo->ttm.pin_count == 1;
 
-	if (bo->ttm.pin_count == 1 && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm) &&
+	if (last_unpin && !list_empty(&bo->pinned_link)) {
+		spin_lock(&xe->pinned.lock);
+		list_del_init(&bo->pinned_link);
+		spin_unlock(&xe->pinned.lock);
+	}
+
+	if (last_unpin && bo->ttm.ttm && ttm_tt_is_populated(bo->ttm.ttm) &&
 	    !xe_ttm_bo_is_imported(&bo->ttm))
 		xe_ttm_tt_account_add(xe, bo->ttm.ttm);
 }
@@ -3315,11 +3330,6 @@ void xe_bo_unpin_external(struct xe_bo *bo)
 	xe_assert(xe, xe_bo_is_pinned(bo));
 	xe_assert(xe, xe_bo_is_user(bo));
 
-	spin_lock(&xe->pinned.lock);
-	if (bo->ttm.pin_count == 1 && !list_empty(&bo->pinned_link))
-		list_del_init(&bo->pinned_link);
-	spin_unlock(&xe->pinned.lock);
-
 	xe_bo_unpin_account(bo);
 
 	/*
@@ -3338,10 +3348,7 @@ void xe_bo_unpin(struct xe_bo *bo)
 	xe_assert(xe, xe_bo_is_pinned(bo));
 
 	if (mem_type_is_vram(place->mem_type) || bo->flags & XE_BO_FLAG_GGTT) {
-		spin_lock(&xe->pinned.lock);
 		xe_assert(xe, !list_empty(&bo->pinned_link));
-		list_del_init(&bo->pinned_link);
-		spin_unlock(&xe->pinned.lock);
 
 		if (bo->backup_obj) {
 			if (xe_bo_is_pinned(bo->backup_obj))

