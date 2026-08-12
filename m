Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBDD2BCF46
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571652; cv=none; b=A5Oc8vjZOL6GhLuQQv4vvj7Q0FkelXxSutM8pPjrBF/Lgi0XGmTsvcvrVPeqRf23ud7S4oNrwm0BG9TVpLCHFfxBNi1HnYXUx6ZfZTyBL8/uYDX/x+w3q/ek1uOW/dpbEOPBKcnN0sbpXokkAuzYANsHDI21MsfHtmtJZ4Ggl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571652; c=relaxed/simple;
	bh=beONkH5TW8YZcLtPfJODaHHgmRalwz62NuE+GTkpEIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VL8sNNBsqt7/p9QXBV0lbien2nuct+g1O+mt1M8/MPosWcxJdWwubH0cq75pMbPUWopK0CDDqs9rvx/Dq4oYYMtFL5Q2U+JmxQpplckKSjprHg/Gq4kiZzjihvV7Z2rqnz+Vljen8cmic6OlUjbsA2muke5zlIfmNPjKqCEkTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdDOOIOc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdDOOIOc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307401F000E9;
	Wed, 12 Aug 2026 21:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786571650;
	bh=7IHqSAKVfNA70s1gQCeEMOTo2Vag5ppY/PysI4o4Qp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AdDOOIOcdqYoXEVdFU4+aQD5CDHPyDgOId7ijm+WOpMFidbeVD6GoAXnS1X7kwTF0
	 f/i/NULQPwvFegk439YQJDOlI8agqZMttFtVY4Z/U3u0plH3d2e0pg0LIgEiUJXIiT
	 ThdAg/x562f6ScMQ5Ad7kof3mA1dfdtePDolrTt6Rto7J2x1AZF1IVgCwCRU0LjiYl
	 X1qNENhkj7+vA2mnIoCkh7k2e5LE09VL0zaopLidVO0vM9KszCmwSb6BQzq85/PptF
	 NG6pGPaz+xB4gDwugK2Rym0GKCfqxjwYxMTHLaRwY8/7BPtnn6SsQ+M6LQ2pwrTs0F
	 K/AvvK7FrS43A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/pm: fix torn gpu metrics reads
Date: Wed, 12 Aug 2026 17:54:08 -0400
Message-ID: <20260812215408.2399072-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080524-perennial-dazzling-f3ae@gregkh>
References: <2026080524-perennial-dazzling-f3ae@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yang Wang <kevinyang.wang@amd.com>

[ Upstream commit 048f4541b71fb19645fb79d6e62e6e4da23a4035 ]

amdgpu_dpm_get_gpu_metrics() returns a pointer to the shared metrics cache
after dropping adev->pm.mutex. The sysfs path then copies from that pointer.
Another reader can refresh the cache in place during the copy and return a
snapshot containing data from two generations.

Pass caller-provided storage through the DPM interface and copy the metrics
while the mutex is held. This keeps the cache pointer private and makes each
sysfs read observe one complete sample.

Fixes: 25c933b1c4fc ("drm/amd/powerplay: add new sysfs interface for retrieving gpu metrics(V2)")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 862333bb48693ecafcae25af0c9d9ec31015ac77)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm.c     | 12 +++++++++---
 drivers/gpu/drm/amd/pm/amdgpu_pm.c      |  8 +-------
 drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h |  3 ++-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 078aaaa531628..0e1e6c6ab190d 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1255,17 +1255,23 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 	return ret;
 }
 
-int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table)
+ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void *buf,
+				   size_t size)
 {
 	const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
-	int ret = 0;
+	void *table;
+	ssize_t ret;
 
 	if (!pp_funcs->get_gpu_metrics)
 		return 0;
 
 	mutex_lock(&adev->pm.mutex);
 	ret = pp_funcs->get_gpu_metrics(adev->powerplay.pp_handle,
-					table);
+					&table);
+	if (ret > 0) {
+		ret = min_t(ssize_t, ret, size);
+		memcpy(buf, table, ret);
+	}
 	mutex_unlock(&adev->pm.mutex);
 
 	return ret;
diff --git a/drivers/gpu/drm/amd/pm/amdgpu_pm.c b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
index 93fe215986d39..5009872cf9a51 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1781,7 +1781,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	void *gpu_metrics;
 	ssize_t size = 0;
 	int ret;
 
@@ -1796,15 +1795,10 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 		return ret;
 	}
 
-	size = amdgpu_dpm_get_gpu_metrics(adev, &gpu_metrics);
+	size = amdgpu_dpm_get_gpu_metrics(adev, buf, PAGE_SIZE - 1);
 	if (size <= 0)
 		goto out;
 
-	if (size >= PAGE_SIZE)
-		size = PAGE_SIZE - 1;
-
-	memcpy(buf, gpu_metrics, size);
-
 out:
 	pm_runtime_mark_last_busy(ddev->dev);
 	pm_runtime_put_autosuspend(ddev->dev);
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index 42172b00be66d..95f56f12ba126 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -493,7 +493,8 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 				      char *buf);
 int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 				      long *input, uint32_t size);
-int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
+ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void *buf,
+				   size_t size);
 int amdgpu_dpm_get_fan_control_mode(struct amdgpu_device *adev,
 				    uint32_t *fan_mode);
 int amdgpu_dpm_set_fan_speed_pwm(struct amdgpu_device *adev,
-- 
2.53.0

