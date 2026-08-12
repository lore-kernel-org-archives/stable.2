Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4940861E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572757; cv=none; b=vEWVjZqCWJa7zmBzt6wP9s0GN5avx440+XWtknUfpSzkObBcScJzydhiU1tIW8IzvPCUnDxvS31A1MtyQaIgnLlOaG8cUn5VCQv2Wq995e62witZjYRu6SN/nXm7sTWfI1MjwdlA1doCKBxXGZEJlx7O8x/4GY8JEV/QxX6REhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572757; c=relaxed/simple;
	bh=5fiPjrnYrzcb/iS9QNFEtkUzSIW2dvua2OPG4q8V7wY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O4jEQH0Zsc+hFmg6gloqIpZBpC9KfLv+CU+qqmXw7kQnwOLv/Il9o0gFQ8Vhf8zXydcnikdu65QM/hfcIHSl9E75GWbzCRKRA9EaEnaE6gUr5ST4DstqjmqeZ8h7sUn4KKifEl0hCGZQCe69Kf7IBqEdvT4TX+kLfWqPCzRc3as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=APlrHh4l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="APlrHh4l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFF91F00A3D;
	Wed, 12 Aug 2026 22:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786572756;
	bh=/vYlxMPi5uC1vjemRxXMLecSsmOiZXKr/wkvwHfQs+8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=APlrHh4lGRswtKChMLxGPpxYr2CRvK8fhNdHeYBCFLM3cnMopZjaFiMboyjpzNdut
	 ypS3hTe09T0aepB+9EU/b5zVHaQALVIyeOHmFbWJjLoNls12AbEKrEBrxkV5Aur9uk
	 +hyFl8zsbOoWps/gnGh75bhCf/njoAv9X8tyFoWKJ0VFVd9EgQmLWS4QXQ3iWAQ2e7
	 qbs9qVTJeUCcoWbnb69SrgEquuAIPlZO4ghu+t1hNLUfihngASoyyX0tPnG1fw9R0D
	 Reu1MtRGXelEn9AMjsYKD1IQhH3aNcJT4JfqKWCP4HHZ9N5WGIzx/AsP0rdL0OibD9
	 PHa6/9yCz6Sfw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] drm/amd/pm: fix pptable use-after-free
Date: Wed, 12 Aug 2026 18:12:33 -0400
Message-ID: <20260812221233.2429285-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812221233.2429285-1-sashal@kernel.org>
References: <2026080537-safehouse-registrar-bd15@gregkh>
 <20260812221233.2429285-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit bb493058c35c8676e48269ab6732688ea733d23c ]

amdgpu_dpm_get_pp_table() returns a pointer to a driver-owned power table
after dropping adev->pm.mutex. The sysfs path then copies from that pointer.
A concurrent pp_table write can replace and free the allocation during the
copy, causing a use-after-free.

Change the DPM interface to copy into caller-provided storage while the mutex
is held. Keep the size-only query for attribute discovery without exposing
the driver-owned pointer.

Fixes: 1684d3ba4885 ("drm/amd/amdgpu: change pptable output format from ASCII to binary")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit f6eed7acfd30099ef7baeb6ba45bb59daad80631)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 14 +++++++++++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      | 13 +++----------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  3 ++-
 3 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 4a14358b9b52d..01b7d3b6b1007 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1059,12 +1059,14 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
+int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
+			    size_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	char *pptable = NULL;
 	int ret = 0;
 
-	if (!table)
+	if ((!table && size) || (table && !size))
 		return -EINVAL;
 
 	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
@@ -1072,7 +1074,13 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_pp_table(adev->powerplay.pp_handle,
-				     table);
+				     &pptable);
+	if (ret > 0 && !pptable) {
+		ret = -EINVAL;
+	} else if (ret > 0 && table) {
+		ret = min_t(size_t, ret, size);
+		memcpy(table, pptable, ret);
+	}
 	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index f2feb04598033..1afbddce99229 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -538,7 +538,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	char *table = NULL;
 	int size, ret;
 
 	if (amdgpu_in_reset(adev))
@@ -552,7 +551,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 		return ret;
 	}
 
-	size = amdgpu_dpm_get_pp_table(adev, &table);
+	size = amdgpu_dpm_get_pp_table(adev, buf, PAGE_SIZE - 1);
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -560,11 +559,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	if (size <= 0)
 		return size;
 
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
-
-	memcpy(buf, table, size);
-
 	return size;
 }
 
@@ -2537,10 +2531,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
 			*states = ATTR_STATE_UNSUPPORTED;
 	} else if (DEVICE_ATTR_IS(pp_table)) {
 		int ret;
-		char *tmp = NULL;
 
-		ret = amdgpu_dpm_get_pp_table(adev, &tmp);
-		if (ret == -EOPNOTSUPP || !tmp)
+		ret = amdgpu_dpm_get_pp_table(adev, NULL, 0);
+		if (ret <= 0)
 			*states = ATTR_STATE_UNSUPPORTED;
 		else
 			*states = ATTR_STATE_SUPPORTED;
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index f5bf41f21c412..b30f34a574b39 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -483,7 +483,8 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
 int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 			      enum amd_pp_task task_id,
 			      enum amd_pm_state_type *user_state);
-int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table);
+int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
+			    size_t size);
 int amdgpu_dpm_set_fine_grain_clk_vol(struct amdgpu_device *adev,
 				      uint32_t type,
 				      long *input,
-- 
2.53.0

