Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C879F408607
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786571648; cv=none; b=IqCGC0jiw2O5jo6pQfkLRkpkkCQBugjRZyGchCK4Vj3RY1pagTldOJOQvZBkpSO6F3Gy1UzHZsCsuqe/UecK2njrlgkCBTIHc7yj/OieJRjU2xzJzZBVgFz8pUM9DToXHcXys/fFYx8zCl6JibXZNToSqb0yx1x2etvQAVdQDdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786571648; c=relaxed/simple;
	bh=u3m5l80YZ4jPE7flLfXu9ZikZirIpF/V5A2ooLsRdEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L2vTSp+ZxNP1g+RBF5nJWI05FIiSHzJu6J7H8wk/2KFctsv/RegrZTtxUVmKZtkPG/jMp+VCRUNDA9IK9kWcT4ycB/O/K82/CrH1EztXzxJhu3HfKGvlrSZshUq9liFapVWDbxuncnfmA0qMLzMPTddEy386wK0HBEfg92BA4lE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HwXpv6Gw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HwXpv6Gw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE881F00A3D;
	Wed, 12 Aug 2026 21:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786571646;
	bh=tJmpIR6XLyfCgdI9VWguibJwZ6/MCiYBK7nIbbzWir0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HwXpv6Gwpru6onyicvLpdlmexm60J4C6EJtpbVeGbSx+RCnEFnwksts8AbUicy/Ey
	 YCibiJYHQlXjmtit55FwePgj6CXG40X7K10zYS9E1h3DNBBJSJZxETer5sn6qCFlkd
	 RTJkfZYkiETjlMIxQjRUkmq9jIhqZEEZ1sX4nYyzXaN9iGlAfW6twhRV/lsLDEkNWq
	 gINHiyOgrXNyQZv1tPIlAcPeVuZb/49de0yGM5LlE3frtPt0b2r9gKwLqjiEfyrr5d
	 AERFSqlWqjLrDw2jXwBHdgSh4r8sIRZ0yoDz50sUT91of6qQfRjrakf0ksB8cASle3
	 maboLsbskdXgA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] drm/amd/pm: fix pptable use-after-free
Date: Wed, 12 Aug 2026 17:54:03 -0400
Message-ID: <20260812215403.2398676-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260812215403.2398676-1-sashal@kernel.org>
References: <2026080537-truck-divisibly-d15d@gregkh>
 <20260812215403.2398676-1-sashal@kernel.org>
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
index c3b0f3167a342..3830c3b72d4b1 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1183,12 +1183,14 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
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
@@ -1196,7 +1198,13 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char **table)
 
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
index 4c8bd36d45932..db7296567c85f 100644
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
 
@@ -2641,10 +2635,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
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

