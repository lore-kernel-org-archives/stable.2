Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794045801;
	b=XwhYh0OW/bKWdw3SvOi5/5HMUdT44FRQg9W0mUhw/EWxtM8mz5cmG1cpfwF2cgg1gAz3
	 eIoGfLoIjUtngU5x+fdscGi2fmL41Q96cToAKxHWslVAOHN7Rl9RYfNGIK6b2xgNB1Vfm
	 ADlppRGsTBg89WGBnlOBMsvxOE8ixjDn5bbNT0eP0HvjnXilgK41Ng7U4Luu+g+ZJAiAs
	 D2tnXshtte0U48w7DbVIqvsUFHzDb3uBx9r0olm9f/3y7V+PNJuKAK/PU/vJMUgfnttPF
	 VM7HC5nGiC9KXEoG/JND7Kn9z+w0EamuaX+JLKItComCpjjlhbhDlMc3UnwsP7XIF6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794045801;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=31WUwSz3MrJUEzBYvQxjLl7hCO9J+2t/dAWOBbbng5w=;
	b=xZE+vZfrEOIYtendqCWyobrrst+vNgUkBozwGfN35ePs5hfZNOmJMzGTNH3Hb6QsTHLM
	 H5tQTtQGPRtwnqYmGTKqARnHYdk9b1rJD4168m1bixFeTcT9LcPEYy99mpZisleNHucQc
	 JIvxWSKK8Ogx67FQfMHmMIOb9egexObV2VKY+ptW990ItPhIaMET6uvVLw77E222cRjbI
	 TVUgCT5XSUKmd/dj9lxt0ljMyhUNNbVM6gbkqs3IfGx6nz8WiMcmc7uHV4VKMVhQdj2H6
	 UW2SE9uL8y3mqaCgr8r5as+PmWOC+4klsKuofCZQB89e93ZAous5rJmxNn1I4rk/2rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erdrLmUA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0498606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=erdrLmUA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEFC11F0089F;
	Sat,  7 Nov 2026 10:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794045800;
	bh=31WUwSz3MrJUEzBYvQxjLl7hCO9J+2t/dAWOBbbng5w=;
	h=From:To:Cc:Subject:Date;
	b=erdrLmUAGztsQidZOc64lH6Mc7OIOKBXvXMtZfo4I0Um5IJX8miLGe7S4cCeNmGgs
	 Km+Q+zUXppf3MI/f6ZnjXorWAr45y2J2MJjaKuJTrMDkhSmrRD72kwgHFDInzLc98x
	 Vk+yJCQfJrsm0Hi96QUsVMKfT/7hmnbx7GTvXCZhrcdyOwTszprfVR/Jwr8s3ftQZk
	 1K1ec2tkoFzOlxgrqkAMj8zfQ96ZXIo7M6188uoDC873ykNj4ngQp1unSucGnoQasa
	 7MLE4qmlfePt+7u8rQBg/KjM7Fy3ceY8uKZLIpE9xuDe8OHXDw7Zd660MFU3fO/wJK
	 JU+daf/92Rz1Q==
From: Sasha Levin <sashal@kernel.org>
To: ckoenig.leichtzumerken@gmail.com,
	christian.koenig@amd.com,
	tvrtko.ursulin@igalia.com,
	tursulin@ursulin.net
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/i915: fix incorrect RCU teardown order" failed to apply to 7.3-stable tree
Date: Sat,  7 Nov 2026 05:03:18 -0500
Message-ID: <20261107050318-failed-7.3-511347955602@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 7.3-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.3.y
git checkout FETCH_HEAD
git cherry-pick -x 5113479556025093bf8133bb2dcaa33be2d50921
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050318-failed-7.3-511347955602@kernel.org' --subject-prefix 'PATCH 7.3.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5113479556025093bf8133bb2dcaa33be2d50921 Mon Sep 17 00:00:00 2001
From: =?UTF-8?q?Christian=20K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Date: Thu, 3 Sep 2026 13:36:21 +0200
Subject: [PATCH] drm/i915: fix incorrect RCU teardown order
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

i915_gem_busy_ioctl uses dma_resv_for_each_fence_unlocked() to iterate
over the fences in an GEM object without holding a reference but only
the RCU read side lock.

What can happen here is that the GEM object is destroyed concurrently
while i915_gem_busy_ioctl is still running. This won't free the GEM
objects memory, but still drops all the dma_fence references.

Now when dma_resv_for_each_fence_unlocked() sees a destroyed dma_fence it
assumes that a new fence list was installed and re-starts the loop.

But in the case of a destroyed GEM object a new fence list is never
installed, only the old one freed and therefore the iteration never
finishes resulting in an endless loop.

The solution is to drop the fence references only after the RCU grace
period.

The fixes tag is not necessary the patch introducing the problem, but the
one making it so worse that we need to address it.

This problem was pointed out by Sashiko-bot.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: 912ff2ebd695 ("drm/i915: use the new iterator in i915_gem_busy_ioctl v2")
CC: stable@vger.kernel.org
Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Signed-off-by: Tvrtko Ursulin <tursulin@ursulin.net>
Link: https://lore.kernel.org/r/20260903113621.54660-1-christian.koenig@amd.com
---
 drivers/gpu/drm/i915/gem/i915_gem_object.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_object.c b/drivers/gpu/drm/i915/gem/i915_gem_object.c
index 5172d39826548..9e01f8b2079ab 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_object.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_object.c
@@ -89,6 +89,7 @@ struct drm_i915_gem_object *i915_gem_object_alloc(void)
 
 void i915_gem_object_free(struct drm_i915_gem_object *obj)
 {
+	dma_resv_fini(&obj->base._resv);
 	return kmem_cache_free(slab_objects, obj);
 }
 
@@ -144,7 +145,6 @@ void __i915_gem_object_fini(struct drm_i915_gem_object *obj)
 {
 	mutex_destroy(&obj->mm.get_page.lock);
 	mutex_destroy(&obj->mm.get_dma_page.lock);
-	dma_resv_fini(&obj->base._resv);
 }
 
 /**
-- 
2.53.0




