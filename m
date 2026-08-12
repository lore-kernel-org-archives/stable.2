Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609CE47885C
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 15:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549474; cv=none; b=tLCmkIPnfGPEt8JMMJAx/jLIGPLQ67QBMGYAay9+mohQ/BMnHvbsdhnXmJ0S5f6wOCV8Vn9qG6WoA0aY/eEDqSNz6qryp/2kmpcu7qbBXyHVmDSOL6gJVDHWy85VUgcKJy+30NS1fom3QpMJ+KJZU7aof0w1LevDEMBtlZK6y+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549474; c=relaxed/simple;
	bh=0vDMMKjdtR0wL+xt/FYS2IwQKKQcep6IoLMJ3JC6N9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gznA47Zuy8Nm7LNuGVvY+poK5Lt56lPjZLy5jhf9iq0QKyRZ88gf3k0EefqhC49WKXcBh45FIJ5F0nxNrhU9r4/hWzXUlnxkQZNgxuCaCm76D71gk+khr1ClF0sNnkYCy2XXD0YBugFcN9Juotc81GNdTdvKjPcF842WK64n9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Glyc/DqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Glyc/DqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 615991F00A3A;
	Wed, 12 Aug 2026 15:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549473;
	bh=eg1DztLYEtz+dacK4xoI1Q2FFoY2qvE594TTT0DkuDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Glyc/DqZTfAPnUsoOeZ5Am0DeGkMLromn0KAwN9/N14U23W2GoK/Dl+6BwHFnU9OO
	 RaWxSYswb9dZ5OvWxelJGOMXOthlSprt7cGwX+oltfzBe2T3HuP4dI1cIRLNKv1Au6
	 nqK/KUeDu0HIbHA74IWvLC8r1XB1DPKtt2tiEO5xIuGN/nHR55Ug0uRKpTLzWf0lkr
	 OwLtYcMPLCzFR7hRxEhBmepKwLlPn1Wob+Ow0KrNEqc5nzYsjen+mH0f2lOHFQ2mdB
	 jF17EYbZb4FWQKqUPuOj1cU/PkYglRkkQ9D29hKQjG/f9ehtKggJpDN+2g0FEv7l0y
	 kf04vmDSVCmsQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] drm/amd/pm: fix torn gpu metrics reads
Date: Wed, 12 Aug 2026 11:44:28 -0400
Message-ID: <20260812154428.2235665-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812154428.2235665-1-sashal@kernel.org>
References: <2026080524-joystick-anagram-33dc@gregkh>
 <20260812154428.2235665-1-sashal@kernel.org>
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
index 9dc82f4d7c937..bab0b2e92b6b4 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1318,17 +1318,23 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
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
index 2252c054c7ddd..af196800196c2 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1889,7 +1889,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	void *gpu_metrics;
 	ssize_t size = 0;
 	int ret;
 
@@ -1904,15 +1903,10 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
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
index f5bf41f21c412..63074a95c4277 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -513,7 +513,8 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 				      char *buf);
 int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 				      long *input, uint32_t size);
-int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
+ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void *buf,
+				   size_t size);
 
 /**
  * @get_pm_metrics: Get one snapshot of power management metrics from PMFW. The
-- 
2.53.0

