Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497CA42465C
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786809330; cv=none; b=GmG8k/WDvQtj2wFF1Z6vkeWg03Tk1oox4MPQgPcnUVZP2NO6BHvm7VnfEhIIrMP446k01gJh4qzoK68ciIQnBexj1+c8h/bWGie8GxugE6ZFsNcJ8qqcCnSeFNdouE7vp13gshM/7D/wRpliLgz5SpNAzOpYk3bniYDbICQ+du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786809330; c=relaxed/simple;
	bh=sjL4cTctKYKXWSw+OMAoaoqLWq0q9/lcKCh/dBoO8Lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Eho3ac7KNYcDW8pQ8oHPVbqcA/8El2t4Bm5KyNW+Odul/JHGSFdkPmlrIsXu3oDffnFkYqBAPziSlWkqWX14hoiahqqGyPyKaV88CYtXBWf+tQH3OqdcaWVHyfW8tSOjFjVr04YPppOnLgllgCR2/icCdFMy/GJbniS++FjFqQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1qnLG0Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1qnLG0Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C7561F000E9;
	Sat, 15 Aug 2026 15:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786809328;
	bh=XiOnCeRwth46fV4MnVd5b2n6r4IetDpBTdWmJ0qNlIw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I1qnLG0QGTT1lPHjQI/bK6HX/ekVTS1cseNQsnQ1glMOvhwsq6JwRkQ7rSK2LvFgb
	 Z6LvyPowC7YmUSAbDgojwzAGQohuMHR0wS6cGbZ8dHpKUw6Nr7ENJKvQOOhiKzeC/L
	 G6UQ5AoLrz/o5DvN9M0XgQkn8kgTEXxuMrfESsm0eb0yyuUMCChAqVZ2UHkck89cd0
	 D2OaoZ1hN36y5QAyQszfLpZwAjdA9iZq1dZ7mDzE5otnUi5KohjWBolF28KlOYYcyn
	 gce2Ehuchajkx8YjIEmGemjfIdj2PhkTqhzcQaDccbDbISeEEYXvO+ewPuEwARd72A
	 ziwJZkpE0uFDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Zack Rusin <zack.rusin@broadcom.com>,
	Ian Forbes <ian.forbes@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/vmwgfx: take fman->lock around fence list mutation in fifo_down
Date: Sat, 15 Aug 2026 11:55:25 -0400
Message-ID: <20260815155525.787016-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080517-bouncy-bobtail-de7d@gregkh>
References: <2026080517-bouncy-bobtail-de7d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zack Rusin <zack.rusin@broadcom.com>

[ Upstream commit 250af2e8c3e90dc978e062a936b633870a22e660 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_fence.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
index 588d50ababf60..4c8466a85a90d 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_fence.c
@@ -658,9 +658,14 @@ void vmw_fence_fifo_down(struct vmw_fence_manager *fman)
 		ret = vmw_fence_obj_wait(fence, false, false,
 					 VMW_FENCE_WAIT_TIMEOUT);
 
+		spin_lock(&fman->lock);
 		if (unlikely(ret != 0)) {
+			bool cookie = dma_fence_begin_signalling();
+
 			list_del_init(&fence->head);
-			dma_fence_signal(&fence->base);
+			dma_fence_signal_locked(&fence->base);
+			dma_fence_end_signalling(cookie);
+
 			INIT_LIST_HEAD(&action_list);
 			list_splice_init(&fence->seq_passed_actions,
 					 &action_list);
@@ -668,7 +673,10 @@ void vmw_fence_fifo_down(struct vmw_fence_manager *fman)
 		}
 
 		BUG_ON(!list_empty(&fence->head));
+		spin_unlock(&fman->lock);
+
 		dma_fence_put(&fence->base);
+
 		spin_lock(&fman->lock);
 	}
 	spin_unlock(&fman->lock);
-- 
2.53.0

