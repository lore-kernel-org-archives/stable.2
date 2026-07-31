Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCA474503EC
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515135; cv=none; b=gD6jQ34A15iniNb4FnSvcRpa3oDwxABG+Z1q7MZ1IITxUJEhRHQBkNVPBeGKoGmE+aOmp0JsRE0ppT0LLOYVCTdYemZOZBD/EU8Zhn95Y/B8H8NxGNwbUG24KW0w3/90QQUwEMTXrK4Lf1jJCz/MNCeClUBqDD0+M4zFlasvGwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515135; c=relaxed/simple;
	bh=IGrLBDvmeFiqxdoY252pzuetPy2bz5vnofnD2G91fv4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VNgbPkLnD6GVXSwKZQ/kw07sm/ZoKyQEQRfQQesVX8xnSAAB9o7SzehM+OQVnyXgV8ytyUcJQaJYauHIlcXAmXKEyrXYGvZ10CubPt4oYo4dHdiWJTPZvkn7/sPAGswQL91gXt3tPak831j13Lo4w+SD4+6MHyicsqj/Vcuuj4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNsiNog+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNsiNog+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD8421F00AC4;
	Fri, 31 Jul 2026 16:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515133;
	bh=RJhG0x6yeKLsbB5EupaXK+TDggrSoFndG/JBiVyuUN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LNsiNog+rBo4jIHj+lSIDboAwP+jtHLRKPtipUAHwVm3VJXYoqhydHy6dDCVY2sFj
	 UmCkFQm2AuvAfVTkeDGoSYRGww+hjb7Kvw1Y3wr/QUZ1ekyGln0NUnRaZU+za3Hh0j
	 ULYF9OowZWDTwArigX6piYcb4IrBgp7lY94cbiOlGMqlBaaBn8ljh4uYLqQMMRHRgQ
	 ErJx34CD71CW8ZbYWJZwOysYe0nh10TpQ2kEQlxlMqAi2afr3jjktuVqBNrWCPPMA0
	 BmTkDmXMlX+xLfELDFRY6oF1waEmMsxghiJFnSZAsZACfmVB+sx8i4tj0gfRI/cBnS
	 wQsjlzj6XB9qw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Chengming Gui <Jack.Gui@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: Fix context pstate override handling
Date: Fri, 31 Jul 2026 12:25:30 -0400
Message-ID: <20260731162530.789974-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072934-jasmine-ripcord-e42d@gregkh>
References: <2026072934-jasmine-ripcord-e42d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

[ Upstream commit c1dc4ccb82c9e56325d8e7514ca4c90bd1efb351 ]

There are several problems in the context pstate handling code.

The most serious ones are potential use-after-free and NULL pointer
dereferences at context initialization time. Both are due
amdgpu_ctx_init() not holding the adev->pm.stable_pstate_ctx_lock, which
is otherwise used from both sysfs and the context code itself for
modifying and clearing the stored context pointer.

Second issue is that context fini can trample over the pstate
configuration set via sysfs. This is due the restore state
(ctx->stable_pstate) being saved at context init time, and not if, or when
the context actually changes the pstate. As the context exits it will
therefore incorrectly restore to what was set before the sysfs override
was requested.

The simplest fix is to drastically simplify how the state is tracked, by
clearly defining the points at which pstate ownership is taken and
released, and to handle all transitions under the correct lock.

Instead of at context init time, the previous state is saved only at the
point the context overrides the current state, and is restored on context
exit only if the context is still the owner of the current override state.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Fixes: 79610d304133 ("drm/amdgpu: fix pstate setting issue")
Cc: Chengming Gui <Jack.Gui@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 1b5e413713c0a93bc1818394d0ce49aaad21bd27)
Cc: <stable@vger.kernel.org> # v6.1+
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 71 +++++++++++++++----------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index c43d1b6e5d66..6e59a4c56e4f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -321,7 +321,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 			   struct drm_file *filp, struct amdgpu_ctx *ctx)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	u32 current_stable_pstate;
 	int r;
 
 	r = amdgpu_ctx_priority_permit(filp, priority);
@@ -339,37 +338,22 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 	ctx->generation = amdgpu_vm_generation(mgr->adev, &fpriv->vm);
 	ctx->init_priority = priority;
 	ctx->override_priority = AMDGPU_CTX_PRIORITY_UNSET;
-
-	r = amdgpu_ctx_get_stable_pstate(ctx, &current_stable_pstate);
-	if (r)
-		return r;
-
-	if (mgr->adev->pm.stable_pstate_ctx)
-		ctx->stable_pstate = mgr->adev->pm.stable_pstate_ctx->stable_pstate;
-	else
-		ctx->stable_pstate = current_stable_pstate;
+	ctx->stable_pstate = AMDGPU_CTX_STABLE_PSTATE_NONE;
 
 	ctx->ctx_mgr = &(fpriv->ctx_mgr);
 	return 0;
 }
 
-static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
-					u32 stable_pstate)
+static int __amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
+					  u32 stable_pstate)
 {
 	struct amdgpu_device *adev = ctx->mgr->adev;
 	enum amd_dpm_forced_level level;
+	struct amdgpu_ctx *current_ctx;
 	u32 current_stable_pstate;
-	int r;
+	int r = 0;
 
-	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
-	if (adev->pm.stable_pstate_ctx && adev->pm.stable_pstate_ctx != ctx) {
-		r = -EBUSY;
-		goto done;
-	}
-
-	r = amdgpu_ctx_get_stable_pstate(ctx, &current_stable_pstate);
-	if (r || (stable_pstate == current_stable_pstate))
-		goto done;
+	lockdep_assert_held(&adev->pm.stable_pstate_ctx_lock);
 
 	switch (stable_pstate) {
 	case AMDGPU_CTX_STABLE_PSTATE_NONE:
@@ -388,17 +372,41 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 		level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
 		break;
 	default:
-		r = -EINVAL;
-		goto done;
+		return -EINVAL;
 	}
 
+	current_ctx = adev->pm.stable_pstate_ctx;
+	if (current_ctx && current_ctx != ctx)
+		return -EBUSY;
+
+	r = amdgpu_ctx_get_stable_pstate(ctx, &current_stable_pstate);
+	if (r || current_stable_pstate == stable_pstate)
+		return r;
+
 	r = amdgpu_dpm_force_performance_level(adev, level);
+	if (r)
+		return r;
 
-	if (level == AMD_DPM_FORCED_LEVEL_AUTO)
-		adev->pm.stable_pstate_ctx = NULL;
-	else
+	if (!current_ctx) {
 		adev->pm.stable_pstate_ctx = ctx;
-done:
+		/*
+		 * Serialized by context taking ownership for the first time
+		 * while holding adev->pm.stable_pstate_ctx_lock).
+		 */
+		WRITE_ONCE(ctx->stable_pstate, current_stable_pstate);
+	}
+
+	return 0;
+}
+
+static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
+					u32 stable_pstate)
+{
+	struct amdgpu_device *adev = ctx->mgr->adev;
+	int r;
+
+	mutex_lock(&adev->pm.stable_pstate_ctx_lock);
+	r = __amdgpu_ctx_set_stable_pstate(ctx, stable_pstate);
 	mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 
 	return r;
@@ -424,7 +432,12 @@ static void amdgpu_ctx_fini(struct kref *ref)
 	}
 
 	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-		amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
+		mutex_lock(&adev->pm.stable_pstate_ctx_lock);
+		if (adev->pm.stable_pstate_ctx == ctx) {
+			__amdgpu_ctx_set_stable_pstate(ctx, ctx->stable_pstate);
+			adev->pm.stable_pstate_ctx = NULL;
+		}
+		mutex_unlock(&adev->pm.stable_pstate_ctx_lock);
 		drm_dev_exit(idx);
 	}
 
-- 
2.53.0

