Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87F0403E8D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571642; cv=none; b=oUsL5cQKI6a7Ua9qolIaYESc2U0sv/5StN4LomT6iEQYuXaVD4K4bP0AUWpuLbvA5NzU4ROwSL2J67yqZaNu7Of5Omxa1u+uP3F8Bs0cH/qSz42MYy6umlWu0ZkCalXxEp58XNUqdMfRLTmitAqiYnsN/s2Prj7ByZjy+RQ+VU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571642; c=relaxed/simple;
	bh=dYXw7ile65o7F8XSCgQmq+LtwHRQLvDCOeDOhIUBv2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JEGlV/yzfIIEB2EVRXodG/759EDR4v19c+ffqtCrfPYQIBGdzxuPm2I1BcHytoRveyD/EPqyh0VpTORRo4fo05g8Qxnes3ukJzy/j7rDsey7hLbSeKeqeggdJPkVDdsN90uYJFW4/ri5YfrOc0TxR1C+yBqVt5Rnbbju47JbAqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gYNi5/5n; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gYNi5/5n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53511F000E9;
	Wed, 12 Aug 2026 21:54:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786571641;
	bh=LS9XGCL6kRcDf0bEXIGYgWc/DM2qjyFe9wVO3s61K3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gYNi5/5ninKjesX+42AZP+MMLtmlSy01Q0e1Q8z9sjZ6086YLZCKEFUEhDYMhtw/o
	 kcbCg6ZhkEcAsd0/nKV0G4Dz7ps5yTmUlPpwdyjH8mzel81Szs1OxKgUlutHiRyDz0
	 I9LBeWFo61fUslyyEF4ivxKlpKA3JCI2ybVR1lQSbgBCHWYQtqec/4J/1Ubbk7IchW
	 wouLGczq8gRUq2jzoupW8jErD3QMS3WYQ1HtymhBuKPM8xeGwPvL6If7iU4rRNPWhx
	 lputIPjWLTA6lJeLrQcbXU2f/bpA+j6GknJYSKLJjtlG3cffushWP8jZu+UAsid4s8
	 Jp49aptcvNmOA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/pm: fix pptable use-after-free
Date: Wed, 12 Aug 2026 17:53:59 -0400
Message-ID: <20260812215359.2398452-1-sashal@kernel.org>
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
index caf2cabeca6d0..674b4f0f0c525 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1183,17 +1183,28 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
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
index 94c534c1d0bed..8dcbb0206ae60 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -556,25 +556,19 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	char *table = NULL;
 	int size, ret;
 
 	ret = amdgpu_pm_get_access_if_active(adev);
 	if (ret)
 		return ret;
 
-	size = amdgpu_dpm_get_pp_table(adev, &table);
+	size = amdgpu_dpm_get_pp_table(adev, buf, PAGE_SIZE - 1);
 
 	amdgpu_pm_put_access(adev);
 
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
index b0bbb23929bf7..13a834575ed77 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -487,7 +487,8 @@ int amdgpu_dpm_get_pp_num_states(struct amdgpu_device *adev,
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

