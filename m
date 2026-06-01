Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5443C3AF669
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 14:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.97.179.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780322927; cv=none; b=IpdSqxzySLtRXWztqgdhlinwRnY6VQZvikwGrQFC82YNpN0ZeKkY+gzvk7eGqBoLMHZePzFI18wc+wYF2OlD5EuVGuPD8KocY73PDGhJKwJH4FzSsOMm4sxYvu2emsNLVy3+qBW0qzVuTBdqq/Ho9FyH9/W56+2grTJYdNv2PM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780322927; c=relaxed/simple;
	bh=RKRdqCorzNHds4/fTHcmpnVuFLbmYywGfeRt6yba0Dg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjAdxPbvnGf4PsW4+Dwa/a4wcOBpMUrOLkeB/y+BWSfHkjhbsWjfX5/NS1eiZy0kovCpC/dondUNXpkaA89mtyNlB0hButI+dEAiN4O94VhdZyV9V12aYkvHjzyRGhGhUHu4oHP+BtVqSCdCew5Z1rhjeq1vgmCb9x+yu+M25KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=olEesJo6; arc=none smtp.client-ip=213.97.179.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="olEesJo6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=l0nbWX2wn+DR0ahu/e9SMLJrIvw7VS3J77gXUtlxX10=; b=olEesJo65K/T5c1T3lHr8XKlWk
	4BLfILjPTvbbEpDfbPElK0ay6NPC4c/7o62JYGf25LyNfRDeFHupPr4O03Yj1rnLOxqVu9W+xiShD
	+k6slHR4B36lTbGYC4JVN/3/woMqPXzJqh76eFFzxIoOXrDyuqu9LjTrw4LeiPIWR4jia83B3Jj4y
	VkqNAYtpz2YWxONnlS1THPcqFCIV9+l00vpmr030JWaUT6o19R2K6IBSdGbX9KcsxvVdNXyNgOiY/
	6cypJQfPGEgVZohEZ7XDRLQ7cMWFJkfZoDzx39v3i6rXio3WdArAiktb+01eeAU8gYqHUHTPSh3ga
	n31rxzUw==;
Received: from [90.240.106.137] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1wU3Jj-00B2vA-Qm; Mon, 01 Jun 2026 16:08:35 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Chengming Gui <Jack.Gui@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/7] drm/amdgpu: Fix context pstate override handling
Date: Mon,  1 Jun 2026 15:08:22 +0100
Message-ID: <20260601140828.27779-2-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260601140828.27779-1-tvrtko.ursulin@igalia.com>
References: <20260601140828.27779-1-tvrtko.ursulin@igalia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
Cc: <stable@vger.kernel.org> # v6.1+
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 71 +++++++++++++++----------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 7af86a32c0c5..ff77126c5644 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -326,7 +326,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 			   struct drm_file *filp, struct amdgpu_ctx *ctx)
 {
 	struct amdgpu_fpriv *fpriv = filp->driver_priv;
-	u32 current_stable_pstate;
 	int r;
 
 	r = amdgpu_ctx_priority_permit(filp, priority);
@@ -344,36 +343,21 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
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
@@ -392,17 +376,41 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
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
@@ -428,7 +436,12 @@ static void amdgpu_ctx_fini(struct kref *ref)
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
2.54.0

