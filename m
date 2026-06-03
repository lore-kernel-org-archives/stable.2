Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF56222B8DF
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780501244; cv=none; b=ti7TJf0rr5B1yVqOHBUVldsyik4NrEGQNJ3Hr5URiH4qLie3RuT4UVe899Tp9Vff05QILiV14doBUaWHTCFKNLW3lq6PsO6v1nJxeYxxrC2qNp8LTrOJaJF1NBpTZYsO5EFoN8NX95mJkKOz2bDk6IS3aRFt1FeCYk1TNI7ai4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780501244; c=relaxed/simple;
	bh=DXn5pqlaFDZ7NZsv2d4pufi+7IllvbCZkldL+8kDej8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CggUhZ8FogcAqsiq6S8N+UVoWJoGuIcYDWPLd4J3XBETanjGpmLBiGI1GGYbOj1O1eddrigOdlwSwKeZIpC1ie1YmcAXkITJ6UIQREEoHOU4MzO319lFy0l2gYUEwC0L9kZUzlnU+h+JoRKqy9fel326gSxo/Ef+VzobA1CydJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=ZKDdm41J; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="ZKDdm41J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1780501243;
	bh=hGsMTYHoeQ0TOkj6e86i0hzrq9+4umeDk9Y0LdQv/5U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZKDdm41JXXyDawQMScsfatT63ChPDSp9PKjXnZoYJzrkFL0XtCpHyPyAmsi6mkhPZ
	 EXPivz8nvMRG0e9GLjfsuHkd91rC2DuKe9cye3Fwv8+306Os/mC13mYKFWsgcjR+fe
	 MCjrdf7Fz0quWyxy+zpcR6rq/+T7O9noMm98CHGI=
Received: from stargazer (unknown [IPv6:2408:824e:307:6541:546a:40ae:5851:c0ef])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1109065EC3;
	Wed,  3 Jun 2026 11:40:39 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	amd-gfx@lists.freedesktop.org,
	Rafal Ostrowski <rafal.ostrowski@amd.com>,
	Dillon Varone <dillon.varone@amd.com>,
	Chenyu Chen <chen-yu.chen@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7.0.y v2 8/8] drm/amd/display: Move dml2_destroy to non-FPU compilation unit
Date: Wed,  3 Jun 2026 23:39:20 +0800
Message-ID: <20260603153920.249671-9-xry111@xry111.site>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260603153920.249671-1-xry111@xry111.site>
References: <20260603153920.249671-1-xry111@xry111.site>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[ Upstream commit 8bf0cb97edb697dba2515e6452c17c5245111448 ]

On PREEMPT_RT kernels, vfree() can sleep because spin_lock is
converted to rt_mutex. dml2_destroy() calls vfree() while inside
an FPU-guarded region (preempt_count=2), which is illegal.

dml2_wrapper_fpu.c is compiled with CC_FLAGS_FPU which defines
_LINUX_FPU_COMPILATION_UNIT, making DC_RUN_WITH_PREEMPTION_ENABLED()
resolve to a no-op. This prevents the macro from cycling FPU
context off/on around vfree().

Move dml2_destroy() to dml2_wrapper.c (non-FPU compilation unit)
where DC_RUN_WITH_PREEMPTION_ENABLED() properly cycles DC_FP_END/
DC_FP_START around vfree(). This pairs it with dml2_allocate_memory()
which already lives there.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 .../drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c   |  4 ++--
 drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c  | 11 +++++++++++
 .../gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c  | 10 ----------
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
index 7398f8b69adb..8bed59e976d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_wrapper.c
@@ -58,8 +58,8 @@ bool dml21_create(const struct dc *in_dc, struct dml2_context **dml_ctx, const s
 
 void dml21_destroy(struct dml2_context *dml2)
 {
-	vfree(dml2->v21.dml_init.dml2_instance);
-	vfree(dml2->v21.mode_programming.programming);
+	DC_RUN_WITH_PREEMPTION_ENABLED(vfree(dml2->v21.dml_init.dml2_instance));
+	DC_RUN_WITH_PREEMPTION_ENABLED(vfree(dml2->v21.mode_programming.programming));
 }
 
 void dml21_copy(struct dml2_context *dst_dml_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
index f4d45875d0be..6e3611a05c83 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper.c
@@ -107,6 +107,17 @@ bool dml2_create(const struct dc *in_dc, const struct dml2_configuration_options
 	return true;
 }
 
+void dml2_destroy(struct dml2_context *dml2)
+{
+	if (!dml2)
+		return;
+
+	if (dml2->architecture == dml2_architecture_21)
+		dml21_destroy(dml2);
+
+	DC_RUN_WITH_PREEMPTION_ENABLED(vfree(dml2));
+}
+
 void dml2_reinit(const struct dc *in_dc,
 				 const struct dml2_configuration_options *config,
 				 struct dml2_context **dml2)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
index 66624cfc27b1..a14e3004a7b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml2_wrapper_fpu.c
@@ -548,16 +548,6 @@ void dml2_apply_debug_options(const struct dc *dc, struct dml2_context *dml2)
 	}
 }
 
-void dml2_destroy(struct dml2_context *dml2)
-{
-	if (!dml2)
-		return;
-
-	if (dml2->architecture == dml2_architecture_21)
-		dml21_destroy(dml2);
-	vfree(dml2);
-}
-
 void dml2_extract_dram_and_fclk_change_support(struct dml2_context *dml2,
 	unsigned int *fclk_change_support, unsigned int *dram_clk_change_support)
 {
-- 
2.54.0

