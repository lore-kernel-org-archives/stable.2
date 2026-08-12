Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C96D40BCDB
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572759; cv=none; b=thi/e4DTQymQYrIqcAlQjPaZjr908ac1zv1pUj92WboXiTQP55odbrMxW7cc4zcgGmVbE9Zsu5+c2IppDIqSoO2oy/6aiaGlNPByh0fIcebKBgOnMY7RBgcaHvr7QUO59rnWyOJSFdi7Myb/dwvSMLZpajlgIJcWu7hYfi4koBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572759; c=relaxed/simple;
	bh=LC9kuV/M52Im8ezRWoWlYesTESYH46P3c8srdjBhzo4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gxOTv+XGGVRZgptSzCi4AQ8Wfay68aUffH3EAcpbeHqH4av/Xsjba1oXwzbMwffJu5zP00ihuFWzo7p6MKpoScaVgh5MOzm1KwnLNcJOco2HrL4+CjTZRk0/Eoo598vNa/PrHku8nVbwT8TbUPcFpemKD4maNrGMzWuWKNnzJrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BqRMURDw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BqRMURDw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C0F31F000E9;
	Wed, 12 Aug 2026 22:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786572757;
	bh=rPv1krGQ1OqERqU5ldb/SyK4xocBqTh/CxXzS9dAWZQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BqRMURDwDIfw/vQCKJQqO3lM60X6boSt2Lg9jrxXPd+LKP0SenzsjBquWygGpll4J
	 S0KCbk+pX+7+yt2lGYfC1diCwmcDdfJx1URpEpgeg7mrmh1gShOvSoJQTYyd7t7Qy2
	 rAK7v//GYFGJP8/IfHQqUSM/97nqq0mSw8Cj+rGOHHBsLActMPZxV8DqvvgCPJkOzx
	 dI2bSZnlDsl/MxAAo3PbYB5vmAbDxyZx6Cl1m7cxW6/7QJJjdUqglWsBpnNIUrJb5x
	 S9HEG7qC/eWPpFk0SZpEtzz5iVRyHTk4JmuVFHLXEI7qRXg48jZbkMmHkicgSja/qt
	 1ON2YbZIoQYJA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amd/pm: fix torn gpu metrics reads
Date: Wed, 12 Aug 2026 18:12:35 -0400
Message-ID: <20260812221235.2429426-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080525-colonize-polar-b766@gregkh>
References: <2026080525-colonize-polar-b766@gregkh>
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
index 69b51612c39a5..6bc34125ea4eb 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1209,17 +1209,23 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
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
index cdb406690b7e7..457908b399c19 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1705,7 +1705,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	void *gpu_metrics;
 	ssize_t size = 0;
 	int ret;
 
@@ -1720,15 +1719,10 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
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
index 338fce249f5ab..6a459219b0b48 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -489,7 +489,8 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
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

