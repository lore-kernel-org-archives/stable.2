Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857CA3FF1B5
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571646; cv=none; b=E71eQCIRQGP18ywD6L2baLD1rQ6OF52AG7OFgSKa+S7nryGe4UcApC0ahi1Y0BJnx5MSKn2uvRkBIapiKiZbXo2jcC9FCF5Zdpdm2XcSwCG40TlNBiSjWenUmaYMSQnz5uc5vuRSdBPQ2IK0hqXfonWoSTBjpUiQrYHg5d+LeEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571646; c=relaxed/simple;
	bh=9Qmps1cGgKcGNDJoXcM8R0RQw84xGNQBxYS0mMrKjbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IjMRlLkL/AL4+FFP6PNOXWwz5xD3WTsdcw4wi7rHw/LqWYZp5X5zDKJyigRBFwGc2kP6TWL8NRxpz98YYwtsROEWuo+AF7rhQjzkHxfiIOc8e47rrD5ruhZiLmdoGnvy1KUu2NtR+faYFSHLd66Yf4LsUUNl1qUL6XZvWmG4cwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZrXGQuCi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZrXGQuCi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E261F00A3A;
	Wed, 12 Aug 2026 21:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786571645;
	bh=scmmGuyT4OS9HzyiEfY9vJe+V0uQaXXF7B/W63v5Itg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZrXGQuCio8lea5m1lrn73FxStoIcZaO/qZYE7GZ54B8Dr/Gv7NGk6F5bSog7Gjulh
	 Xh4pPNnDQHp8hh8L4CC2ADBZo5O0w7O4qpdxaAST4JwBlYFYFoI52NoA6J0gf9a6wi
	 /xPVa0RoBlRegoYkbY28lo0OrRImNWCARfIXnl2jAmYdR940DEEEleZDIvlvNwFP32
	 2h0V5V8A3MR7nvM/dKB3ltUW8tj1lAEsO7o/nwiTMRAu8r0T5RIBUkcsMalouGrr78
	 USS+qccx1XaM7FPfqHf74gMN/pCUAnm0c7denu0QjA1ck6bq83rEhL8A2y5+HkPeqf
	 kiAhMv8w3Q0Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] drm/amd/pm: adjust the visibility of pp_table sysfs node
Date: Wed, 12 Aug 2026 17:54:02 -0400
Message-ID: <20260812215403.2398676-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080537-truck-divisibly-d15d@gregkh>
References: <2026080537-truck-divisibly-d15d@gregkh>
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
index caf2cabeca6d0..c3b0f3167a342 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1188,8 +1188,11 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
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
@@ -1721,7 +1724,10 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
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
index 94c534c1d0bed..4c8bd36d45932 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -2502,7 +2502,7 @@ static struct amdgpu_device_attr amdgpu_device_attrs[] = {
 	AMDGPU_DEVICE_ATTR_RO(pp_num_states,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RO(pp_cur_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
 	AMDGPU_DEVICE_ATTR_RW(pp_force_state,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
-	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF),
+	AMDGPU_DEVICE_ATTR_RW(pp_table,					ATTR_FLAG_BASIC),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_sclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
 			      .attr_update = pp_dpm_clk_default_attr_update),
 	AMDGPU_DEVICE_ATTR_RW(pp_dpm_mclk,				ATTR_FLAG_BASIC|ATTR_FLAG_ONEVF,
@@ -2639,6 +2639,15 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
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
index 554492dfa3c00..a16fcca3576c4 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -634,9 +634,12 @@ static int pp_dpm_get_pp_table(void *handle, char **table)
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
index cfa4ff5d21b27..53d071eddbf44 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c
@@ -620,7 +620,7 @@ static int smu_sys_get_pp_table(void *handle,
 		return -EOPNOTSUPP;
 
 	if (!smu_table->power_play_table && !smu_table->hardcode_pptable)
-		return -EINVAL;
+		return -EOPNOTSUPP;
 
 	if (smu_table->hardcode_pptable)
 		*table = smu_table->hardcode_pptable;
-- 
2.53.0

