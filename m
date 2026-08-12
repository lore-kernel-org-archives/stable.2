Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0A240861E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572755; cv=none; b=PKNv6Yn8l9uO0q2l/CJoY5GtT+ebF9OjeoIpWa1HguZyOp7RTcn8/LBVNx0K5iqNSWhULZ5Uts+dGVMLVEs924CA5ZqapJePaQeRNGj0M6qhlExPvYpmyNFXB6TtfmHwgClQOIFpwXiGNuFGDPu95RQpGD2TmzSWiiS+ggvEHMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572755; c=relaxed/simple;
	bh=91SDyzLVpLsiMWrBUKw6clIoVeYSDIOtakztA70lBJE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gtnlf2NgsRAVrW6n04N4xs5AFYyRueMtDRTUZMSov7Jq5JjXlq84sdaVwgAkfqpn9JYnJB5QZfVEX1Hqe/7Ih0zs2tKSeybCH4doeABc19epPzi5NOfzXLmUDLNyK/hZnWCL4M8iPZpJSoplhcbieqGUfmbexL5hcU41qNKiTDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gZPKOKqb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gZPKOKqb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 304791F000E9;
	Wed, 12 Aug 2026 22:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786572753;
	bh=LNdT1mcUfWE1PDwkYgv8lfMaKDS4lM5erLzH8GkfQZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gZPKOKqbmRX3SapFm4yENiyBKrH1usDvtXaxL+2XArnuOHuJ8w2MVhE7oUvQUSade
	 98OKfUKVtX323n4g09gWIb7AZGpxRBjUueWyeFgTZSSD9adQ1uZXNZk2hOWGISpRkP
	 8GKtvb3Ux+Nuz14QfQIZL00ZTrxkhjaALchvp7tZFhCYyf93beFqxVZDwTN9RCgLFc
	 l7AJ2UhUzn0OAReXsWcEWioX88ZiH/taD8us5Hd59B1PJQ0WFejfs4kRYPT8RYawAo
	 StbLVGDqB2Uo75BRBY0HkdSYd7/id+Uiso0TAXGSiUwubPRqB/Upsl0km7Is/6H1++
	 OWuYT0YMCLjFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yang Wang <kevinyang.wang@amd.com>,
	Kenneth Feng <kenneth.feng@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amd/pm: fix pptable use-after-free
Date: Wed, 12 Aug 2026 18:12:31 -0400
Message-ID: <20260812221231.2429158-1-sashal@kernel.org>
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
index 9dc82f4d7c937..e99a9fe295e6b 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1059,17 +1059,28 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
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
index 2252c054c7ddd..1f68fe85e801c 100644
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

