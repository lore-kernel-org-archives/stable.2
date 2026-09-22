Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A18E1544D5B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089944; cv=none; b=mchVIvUlyKb/jju2x3OT0X1WphzVfCi0Q0vTXzJix55J1Rw9wBbf3Icmpi4+KMjs9csRtS5/8PjdDIm7SO+T+dLGPS2BwxS5qCVYyzIS3dSmlnqW7MH1EX+HHjeeFUDKXbnO4PAIadeYyZAaffSZ9XHQIxZMSlUIjzqjmBaFYTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089944; c=relaxed/simple;
	bh=TJW7htUV6ZYZJmCYz4jjhXfg+HfE9RqvGBbonTpj51I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=uJtdt8hiw1I20gTUFMxMH+jUh+JUma15uI5auvIYDIZHca40edAw0v3HVnCafhMpi93IV5RzM4LPLFowhv2f/sYwk8zTtnK861Jp/Sa1F3zQts+O0qYgPuSteDXT+kaY3wnmWhewRF1u8lpvwBu9P+p+bYGv+hloHI14eshole8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qUdPdA7k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qUdPdA7k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739871F000FF;
	Tue, 22 Sep 2026 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089942;
	bh=Gtrm4fBi+EOhkMiPgqzawmtuIx/dK9Co1eDTHzMIZ48=;
	h=Subject:To:Cc:From:Date;
	b=qUdPdA7k9rLSAieF354Uiw55mlRtWJtdudbY6wHRj2R2H/9m8TQ7saPY1EGUx3CKk
	 TY9Ibxx81T4kcwFxPaMWTRiv4Oj0LRU5Md3132n14ghkex3GzfUJZ+QyQ8QEigAVha
	 ff+5gB5PuOuAYuZu9UJMJ3XT/3T3iZz7SoDItRZI=
Subject: FAILED: patch "[PATCH] drm/ttm: fix swapped-out resources never leaving their" failed to apply to 7.2-stable tree
To: bub4z0r@gmail.com,christian.koenig@amd.com,thomas.hellstrom@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:02:53 +0200
Message-ID: <2026092253-dimness-unethical-2515@gregkh>
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
git cherry-pick -x 3db7d7d583419f7b1f2e141e36418802dbb25cf8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092253-dimness-unethical-2515@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 3db7d7d583419f7b1f2e141e36418802dbb25cf8 Mon Sep 17 00:00:00 2001
From: Vadim Nikitushkin <bub4z0r@gmail.com>
Date: Wed, 9 Sep 2026 23:50:28 +0300
Subject: [PATCH] drm/ttm: fix swapped-out resources never leaving their
 bulk_move range
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Link: https://lore.kernel.org/r/20260909205028.13799-1-bub4z0r@gmail.com

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index ef56c18ded1b..a12af5b38a31 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -532,7 +532,7 @@ static int ttm_bo_alloc_at_place(struct ttm_buffer_object *bo,
 		ret = ttm_resource_try_charge(bo, place, &alloc_state->charge_pool,
 					      force_space ? &alloc_state->limit_pool
 							  : NULL);
-		if (ret) {
+		if (ret > 0) {
 			/*
 			 * -EAGAIN means the charge failed, which we treat
 			 * like an allocation failure. Therefore, return an

