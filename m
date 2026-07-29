Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB0D40A924
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 10:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785321342; cv=none; b=OuZ2AgphKy2BQn/5Q1pN2bYcMa4gHs9WuJtvN56cT7lyb8NW4yQ3CB8vkrVekCoY8yMTPrjO45U+y8230FQbzYGArPmb5KfZXLuEsR2x/OsREcgwlM2YRm79Hnf3VYCa/CvemdX/HDBriWgSn5QedzQr9rCbft8VA9ATE9wpVOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785321342; c=relaxed/simple;
	bh=47yBVcMh3NrFWK4mh98WtJSeUA+htIzVt5uEvf5W6K8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=T/4gi4xipfpvpyK8Js/NcLSeUIH6ngokZmuwQdr+ZkmKa3hkGfVov7M883mFEYX8II73kzD4uerPhuUmDzruOuM6DvGY/eF/pEzJA3dp3S+ewRTuMp50V5rFYem3DkiwQ5dcXSge7QqAhCneOTUisTM09bPW387Pl3VB1EnodoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BOGYIdE9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BOGYIdE9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CA21F000E9;
	Wed, 29 Jul 2026 10:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785321340;
	bh=ZcsbjJ4P24F5ElpVXa8CTbxofsAH1fgbHTXvcIGayGY=;
	h=Subject:To:Cc:From:Date;
	b=BOGYIdE9EPmpsP9GrXW4Ouqs/5nX0jvynMPRU3W6i7+pjT+SVzx38CzMZq25wOUcO
	 Go/rlpALa204p1Svidd+EYAuazC1Cjl/q1kLK0QK/pE9PLFbZ705yqQBnrOI4fV+zi
	 8JhHkWjZYJj5bdeV1j0obJwt3jkB9eXr5Npu1Fys=
Subject: FAILED: patch "[PATCH] drm/msm: Restore second parameter name in purge() and evict()" failed to apply to 6.18-stable tree
To: nathan@kernel.org,dmitry.baryshkov@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 29 Jul 2026 12:35:19 +0200
Message-ID: <2026072919-drown-simplify-2be6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 8de061ca149c94871e41d91a5b2e442ecc26a572
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072919-drown-simplify-2be6@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

