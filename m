Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CF40F721
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572757; cv=none; b=Ha5IcljgD1rjZ22Ar40ceAyNbVqpJwoQ2djMwdOmHMiau0/rQcds33OAsWiIrslgO16UYxaGso/D38ZsDPAM5+t0DGLm71UveObEy2ZdjkpOA06HkajI1LCDJabDcceYBIz7dQg1a1QX4Lm9F8nwvHcsZgOF4BMg6BNrMg4CHac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572757; c=relaxed/simple;
	bh=YCFn6u1QaSZjBbIoOveXyAKzbGYYU4AgAhqw6PJmQoM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g5gFn1VHwAAr9sfonzF5/lWdWs3fHriSmR77/L2iUoVBJITanAt2ixkGA4KXr/NWmfX02WUaIrGiYwkTG0Knd+mYh63cOc6V6nyznU3qwD4pwLzNhFZUMImI1rb3qxsqZUct/dqm9qTemr8l4NSDLS/8v45l+028/ke5jiFXmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BhNOUn/k; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BhNOUn/k"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF14E1F00A3A;
	Wed, 12 Aug 2026 22:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786572755;
	bh=nbKKeSUK+kZvMWm1a9dLY4zR3deLE+yuN4a+3CAkl3U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BhNOUn/k00/2qz8UYjmItgA87Jnpo3XO5becsO38D/0ToQvFi000it734HoGFk4pt
	 58nkkKJvcF8/CFMbVtqa0ZXLPz/7M/cEGIENQZY4ob2sIgL2wyJME4mjZ5Jf73VrfJ
	 Fx3UqS1aom0NMlO3Sd9RZbU3jjzc8sBUrOkVZN1Z0k5I9hKXpixOfIlgkLGKSIH35X
	 fhGo27QiuF0en73KLl5pUns8fIxOeKYwSSUaonmqcTcXk8+XlnGbMYjMKMSdtrPm9G
	 66gjSnhrb/WtWdAILuY/kG9jKjjR0xv/sbD40BrA6oGEDwOlfAR40o0YKHvEMiPrf+
	 cPrUni9Aeykig==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/amd/pm: adjust the visibility of pp_table sysfs node
Date: Wed, 12 Aug 2026 18:12:32 -0400
Message-ID: <20260812221233.2429285-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080537-safehouse-registrar-bd15@gregkh>
References: <2026080537-safehouse-registrar-bd15@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 5de8ce0f3709ad93ca5a579aa45cf1b52d72bc90 ]

v1:
- make pp_table invisible on VF mode (only valid on BM)
- make pp_table invisible on Mi* chips (Not supported)
- make pp_table invisible if scpm feature is enabled.

v2:
move pp_table invisible code logic into amdgpu_dpm_get_pp_table() function.

v3:
add table buffer pointer check both on powerplay & swsmu.

Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: bb493058c35c ("drm/amd/pm: fix pptable use-after-free")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c              | 12 +++++++++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c               | 11 ++++++++++-
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c |  5 ++++-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c        |  2 +-
 4 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 9dc82f4d7c937..4a14358b9b52d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1064,8 +1064,11 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (!pp_funcs->get_pp_table)
-		return 0;
+	if (!table)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
+		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
@@ -1569,7 +1572,10 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
 	int ret = 0;
 
-	if (!pp_funcs->set_pp_table)
+	if (!buf || !size)
+		return -EINVAL;
+
+	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 2252c054c7ddd..f2feb04598033 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2408,7 +2408,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
 			      .attr_update = pp_dpm_clk_default_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
@@ -2535,6 +2535,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 		if (amdgpu_dpm_get_apu_thermal_limit(adev, &limit) ==
 		    -EOPNOTSUPP)
 			*states = ATTR_STATE_UNSUPPORTED;
+	} else if (DEVICE_ATTR_IS(pp_table)) {
+		int ret;
+		char *tmp = NULL;
+
+		ret = amdgpu_dpm_get_pp_table(adev, &tmp);
+		if (ret == -EOPNOTSUPP || !tmp)
+			*states = ATTR_STATE_UNSUPPORTED;
+		else
+			*states = ATTR_STATE_SUPPORTED;
 	}
 
 	switch (gc_ver) {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 78721bce42fd5..32839355a1845 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -650,9 +650,12 @@ static int pp_dpm_get_pp_table(void *handle, char **table)
 {
 	struct pp_hwmgr *hwmgr = handle;
 
-	if (!hwmgr || !hwmgr->pm_en || !hwmgr->soft_pp_table)
+	if (!hwmgr || !hwmgr->pm_en || !table)
 		return -EINVAL;
 
+	if (!hwmgr->soft_pp_table)
+		return -EOPNOTSUPP;
+
 	*table = (char *)hwmgr->soft_pp_table;
 	return hwmgr->soft_pp_table_size;
 }
diff --git a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
index a6683a8cebf2b..bc5d3758fbf67 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -580,7 +580,7 @@ static int smu_sys_get_pp_table(void *handle,
 		return -EOPNOTSUPP;
 
 	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (smu_table->hardcode_pptable)
 		*table = smu_table->hardcode_pptable;
-- 
2.53.0

