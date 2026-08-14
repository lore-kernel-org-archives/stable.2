Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EEFB3C5848
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 17:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786728294; cv=none; b=bb+ha+rIwFKsnXd5fZOilVFi3jY8Fco3FGkOlCzdKAwU19CQ+E9s0FtVL34ZvX5HnkgTSKsZgZ38RFP1mfChbc7ioTJrknKXETJQUNuBnY2C0/FNRaMtoywXwO3Nw3nlC+JC1b3WFKgP+Huvyona3ddrKxNL38G3Pdrp1zRp/N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786728294; c=relaxed/simple;
	bh=nvxLcxHidut6yGGxSOD8tgNlwdeqPcBMLvdqXf+0gwA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q1fuzPKpynuBEeTn8XTR7aFjMGpWz4T9fvVN7gmx/+cMlrNQJSL2r/1eO73nrrIL/mCF/E1qXgf8hdAg+xgjupihnDkWognhTVBTOgMZv6F2jrq+2VlTD9DMBG9wKt3I8CtQjFSBSEOxfE8fk9L26SlUK1ATf//0ribCHcgHBEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk0mQrlF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk0mQrlF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E3F1F000E9;
	Fri, 14 Aug 2026 17:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786728293;
	bh=HLaHDMTFebgOTLCQneWrVnfUPGHWBfCcyVJ+yLhbBz8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kk0mQrlFQI3UsuosbKC48nFh5lUWOh0hteRp7B2+O56F/Iavxy4+Oh6gkBBUV9x4a
	 ETzjsD54k/vs9ye6WIyfrZpUfjEjn8om3nuXKOXcCRAUay3Q2eHlWs4tXpJY1L+zGZ
	 z5O2OhQNnH5ISM6mHUHOEioWwN9AjJyPE+O8lukWjEU/IfNj9MqxjTY296RAqt1x/8
	 194lkc+pu7semeIQUO35XU+il8Mu5OKv9NllGHTHcta2ceBW1Syyl91hDJKRCfvHqo
	 Ikptdb71S9VrCl/m10+h/v8EE7PNZ3DDVpOvzegygOaBOZCOnJnwqtgvXPPINXyGMw
	 2ooDEwo3MKMKA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amd/pm: fix pptable use-after-free
Date: Fri, 14 Aug 2026 13:24:50 -0400
Message-ID: <20260814172450.176584-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080538-overrate-sinuous-c96e@gregkh>
References: <2026080538-overrate-sinuous-c96e@gregkh>
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
[ kept 6.18's existing `if (!pp_funcs->get_pp_table) return 0;` guard instead of upstream's SR-IOV/SCPM `-EOPNOTSUPP` guard and dropped the `default_attr_update()` hunk whose `pp_table` branch doesn't exist yet ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 15 +++++++++++++--
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      |  8 +-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  3 ++-
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 69b51612c39a5..77dda3239c21c 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -950,17 +950,28 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
+int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
+			    size_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
+	char *pptable = NULL;
 	int ret = 0;
 
+	if ((!table && size) || (table && !size))
+		return -EINVAL;
+
 	if (!pp_funcs->get_pp_table)
 		return 0;
 
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
index cdb406690b7e7..229049f21a89b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -532,7 +532,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	char *table = NULL;
 	int size, ret;
 
 	if (amdgpu_in_reset(adev))
@@ -546,7 +545,7 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 		return ret;
 	}
 
-	size = amdgpu_dpm_get_pp_table(adev, &table);
+	size = amdgpu_dpm_get_pp_table(adev, buf, PAGE_SIZE - 1);
 
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
@@ -554,11 +553,6 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 	if (size <= 0)
 		return size;
 
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
-
-	memcpy(buf, table, size);
-
 	return size;
 }
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 338fce249f5ab..a97c27ae9702c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -459,7 +459,8 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
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

