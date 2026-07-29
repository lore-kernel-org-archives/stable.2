Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 959473B38AD
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321333; cv=none; b=OXgNA93aSUKnkpX3VkHTW8B0D/YpwctC6uAoa4DkMh2LEdmHl5pdd6l8e09hGG4IoeR6ip46soq/6PwrLOlZbq+yGcgJXRYsz/dNWcyHGWqE7M2aWOLhsoPbhvJ+eAWnie+nRbkYdiBAvJYT6JH/5j2Aa8e+1LMXAjWFRIQVhf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321333; c=relaxed/simple;
	bh=mtv52JBqoor73k/tysa9kUsCChj6a3TzcU/E1EEYCD8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LowERddkU+gld00GISLF/bm9tTJZg0ReL9002L3Ft6uNbUMDSsT8X0TBrDSGYJmQO2s1ri/hh6tPEgRZPwZabkyufK4RvRBVjE8igp6daRSy2rur82xVbXCNgf9/qPtsE+WYl/NAGRjWuqeiV+ZrtsGrmOW1YSbSHOZASnlLozg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=m3sH8DfM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="m3sH8DfM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61851F000E9;
	Wed, 29 Jul 2026 10:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321332;
	bh=9W7gjImVRvW3jfqX3rYLRfBjcfY9rtjMIOO2oH/4KOs=;
	h=Subject:To:Cc:From:Date;
	b=m3sH8DfMiUXfBmzoevOm3lgDk06I1dZT9zhyjrZEtBWuA3SwHaR2a5cmX/lCLU3X+
	 kcTajC99tQB/O6s7mt0yGiB6to5op1FhCNGNzUw/yd9y3IRKI8X3tbZhotMgxBR8WO
	 Db6rnCrPCKqbSjuxwmlLTYyQRL3D8O0tpyBl1QbY=
Subject: FAILED: patch "[PATCH] drm/msm: Restore second parameter name in purge() and evict()" failed to apply to 7.1-stable tree
To: nathan@kernel.org,dmitry.baryshkov@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:35:18 +0200
Message-ID: <2026072918-splendid-carton-9845@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8de061ca149c94871e41d91a5b2e442ecc26a572
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072918-splendid-carton-9845@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8de061ca149c94871e41d91a5b2e442ecc26a572 Mon Sep 17 00:00:00 2001
From: Nathan Chancellor <nathan@kernel.org>
Date: Mon, 18 May 2026 15:17:14 -0700
Subject: [PATCH] drm/msm: Restore second parameter name in purge() and evict()

After commit 3392291fc509 ("drm/msm: Fix shrinker deadlock"), all
supported versions of clang warn (or error with CONFIG_WERROR=y):

  drivers/gpu/drm/msm/msm_gem_shrinker.c:105:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
    105 | purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
        |                                                          ^
  drivers/gpu/drm/msm/msm_gem_shrinker.c:117:58: error: omitting the parameter name in a function definition is a C23 extension [-Werror,-Wc23-extensions]
    117 | evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
        |                                                          ^
  2 errors generated.

With older but supported versions of GCC, this is an unconditional hard error:

  drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'purge':
  drivers/gpu/drm/msm/msm_gem_shrinker.c:105:35: error: parameter name omitted
   purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
                                     ^~~~~~~~~~~~~~~~~~~~~~~
  drivers/gpu/drm/msm/msm_gem_shrinker.c: In function 'evict':
  drivers/gpu/drm/msm/msm_gem_shrinker.c:117:35: error: parameter name omitted
   evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
                                     ^~~~~~~~~~~~~~~~~~~~~~~

Restore the parameter name to clear up the warnings, renaming it
"unused" to make it clear it is only needed to satisfy the prototype of
drm_gem_lru_scan().

Cc: stable@vger.kernel.org
Fixes: 3392291fc509 ("drm/msm: Fix shrinker deadlock")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Patchwork: https://patchwork.freedesktop.org/patch/725924/
Link: https://lore.kernel.org/r/20260518-drm-msm-fix-c23-extensions-v1-1-0833559418c7@kernel.org
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

diff --git a/drivers/gpu/drm/msm/msm_gem_shrinker.c b/drivers/gpu/drm/msm/msm_gem_shrinker.c
index 6e39e4e578bb..8f118b5185a1 100644
--- a/drivers/gpu/drm/msm/msm_gem_shrinker.c
+++ b/drivers/gpu/drm/msm/msm_gem_shrinker.c
@@ -102,7 +102,7 @@ with_vm_locks(void (*fn)(struct drm_gem_object *obj),
 }
 
 static bool
-purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
+purge(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
 {
 	if (!is_purgeable(to_msm_bo(obj)))
 		return false;
@@ -114,7 +114,7 @@ purge(struct drm_gem_object *obj, struct ww_acquire_ctx *)
 }
 
 static bool
-evict(struct drm_gem_object *obj, struct ww_acquire_ctx *)
+evict(struct drm_gem_object *obj, struct ww_acquire_ctx *unused)
 {
 	if (is_unevictable(to_msm_bo(obj)))
 		return false;

