Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE2D53D0B1
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089947; cv=none; b=QbicrLRsqb7IBlFlqjFnJ6RdnnRi2tfQF15YdkOaLjGXAit+B4cSKYuHT8eIsCeGpvEtqoj7GtAHWpX3HFg+FXIm/bE2UmB4t0q3GeTkColZeSzoW+qnFAPujRlJrdykDHHCRzTahUeev8fm9/CUAZHkjnvtXniMDK7Y4Kr2Voo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089947; c=relaxed/simple;
	bh=yfltf5UfM0YalRYtfcSsSqZM4d5TWs7XZ/Mww9nKmt8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=CSuD3ZU9CO+fOPH7i0M26dIW3i8d4NzAjJhhNlCjK9mOzxhi0+Kbpu65ac0lT/6Ilqfca0Uz7b5Fc+DcheKo+uYMUi6/ATTxcyDYDsqGm89j1PrvQDKBZIelrP3JePAJW6BQ4fCAdUBphLXqH3XjrcJuwwDvL6NMu5WdD6Ol12M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UeZGvu38; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UeZGvu38"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEE71F000FF;
	Tue, 22 Sep 2026 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089945;
	bh=jwITBfHMs4VEWJhS/vWFJvDZVSU6ybPvSacyGCvLlMw=;
	h=Subject:To:Cc:From:Date;
	b=UeZGvu38AZIRaR8G50FkhyOCFVx6ith9Ocv2r5aCP7kRImUEQtGxKTWkx9t0Gtxa2
	 BwCK695q4sC0eoKTz+5/3CxujeJTjG6fy6pQXHiYoyfEX9p7kJhEkj3vl3gT8M5Kmb
	 j/wvFTsmHjusTQ+UkSIdDfnujt8WaNeUj0U6LgWU=
Subject: FAILED: patch "[PATCH] drm/ttm: apply the swapout bulk_move fix to the intended" failed to apply to 7.2-stable tree
To: bub4z0r@gmail.com,christian.koenig@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:03:01 +0200
Message-ID: <2026092201-stimulus-author-8bd8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x fcfe64715b425262af1b36f498f9197f3537ceed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092201-stimulus-author-8bd8@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From fcfe64715b425262af1b36f498f9197f3537ceed Mon Sep 17 00:00:00 2001
From: Vadim Nikitushkin <bub4z0r@gmail.com>
Date: Thu, 10 Sep 2026 17:34:51 +0300
Subject: [PATCH] drm/ttm: apply the swapout bulk_move fix to the intended
 condition
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20260910143451.65853-1-bub4z0r@gmail.com

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index a12af5b38a31..9b85b5f388d4 100644
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

