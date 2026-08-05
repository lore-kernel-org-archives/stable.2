Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6944E660
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785932148; cv=none; b=WJ6Op9WDSR1bDl5FJEFN6bs+3ZK4jxpeXOArOe8y9L9UGEZHtBu0XjEW3ZqTsYLJ90l60c58TG2i6o/MzfLbrA87P4wFqsfsPUjQoYo/WazXI59XVF/QSUzUzFb7FkFsN8d9yH5NLHkxUVIVcbx9z97nemf12iaR3Us7QM//PWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785932148; c=relaxed/simple;
	bh=rfhmY1LYrvTZyVE58I+9A8yUVp/dcj8h5F0q6QsLM4w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QuXii2HiAQyw2i6Cq5sda2m4GnkjPRpTd1jz0mTNyjNaf5PrYSc2rJY8m3lqD/HKxxb4l4Yu31aajY4I3S4ox5wfdhAa+yIHi0T+LCDG7Nu7bIHbvK1qnBg2jLXlC5y2/Phdd8HeIdQXEsqbsOeemyDTL6uFeqvJSvEW0odkYeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n7AEC4iU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n7AEC4iU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8C9B1F000E9;
	Wed,  5 Aug 2026 12:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785932147;
	bh=oZAlLsMj2LcSRnYB/Ml7uKCOBkBE7V3o3dnFcmyxZj8=;
	h=Subject:To:Cc:From:Date;
	b=n7AEC4iUA2tmtsUwE+7JGizO3Fdys9u/KqcXcDkW+PGcJC4dw6kFXOYlQ0+ISSZZC
	 PYqmJPzVN3teb0LG4MENIuiFQfkhw93UbnMe1Mx4MLSFH2eE1hfcsXeJO7lxYyto8p
	 V7G3zsatL1Zzj+x6aaddLsddKhi9ozIaz6ffo3zs=
Subject: FAILED: patch "[PATCH] drm/vmwgfx: take fman->lock around fence list mutation in" failed to apply to 6.12-stable tree
To: zack.rusin@broadcom.com,ian.forbes@broadcom.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 14:15:17 +0200
Message-ID: <2026080517-bouncy-bobtail-de7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 250af2e8c3e90dc978e062a936b633870a22e660
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080517-bouncy-bobtail-de7d@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 250af2e8c3e90dc978e062a936b633870a22e660 Mon Sep 17 00:00:00 2001
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Tue, 5 May 2026 18:22:25 -0400
Subject: [PATCH] drm/vmwgfx: take fman->lock around fence list mutation in
 fifo_down

vmw_fence_fifo_down() drops fman->lock to wait on a fence and, on
timeout, mutates fman->fence_list via list_del_init() and signals
the fence without re-acquiring the lock.  __vmw_fences_update() walks
and removes entries from the same list under fman->lock from any
other waiter, the fence-IRQ thread, or vmw_fences_update(), so the
unlocked list_del_init() can corrupt the list head.

Re-take fman->lock before manipulating fence->head and use
dma_fence_signal_locked().  Wrap the locked signalling in
dma_fence_begin_signalling() / dma_fence_end_signalling() so the
lockdep annotation that dma_fence_signal() previously provided is
preserved (the same pattern as __vmw_fences_update()).

dma_fence_put() is moved outside the lock to avoid a recursive
acquire from vmw_fence_obj_destroy(), which also takes fman->lock.

Fixes: ae2a104058e2 ("vmwgfx: Implement fence objects")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4.7
Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
Reviewed-by: Ian Forbes <ian.forbes@broadcom.com>
Link: https://patch.msgid.link/20260505222728.519626-5-zack.rusin@broadcom.com

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 4ef84ff9b638..384c6736cf6b 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -367,13 +367,24 @@ void vmw_fence_fifo_down(struct vmw_fence_manager *fman)
 		ret = vmw_fence_obj_wait(fence, false, false,
 					 VMW_FENCE_WAIT_TIMEOUT);
 
+		spin_lock(&fman->lock);
 		if (unlikely(ret != 0)) {
+			bool cookie = dma_fence_begin_signalling();
+
 			list_del_init(&fence->head);
-			dma_fence_signal(&fence->base);
+			if (fence->waiter_added) {
+				vmw_seqno_waiter_remove(fman->dev_priv);
+				fence->waiter_added = false;
+			}
+			dma_fence_signal_locked(&fence->base);
+			dma_fence_end_signalling(cookie);
 		}
 
 		BUG_ON(!list_empty(&fence->head));
+		spin_unlock(&fman->lock);
+
 		dma_fence_put(&fence->base);
+
 		spin_lock(&fman->lock);
 	}
 	spin_unlock(&fman->lock);

