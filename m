Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9064534B3
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931285; cv=none; b=UvrR27jxAJze0Q67tYccYk2wljXU+peBcMuqdCG7upg+awgQLfl7gYCEN8c2tCD81abXjvqNZm4lgBkrOqTTqTuNmvLStJnZvmY4ZGjnAif+jnWCRdHWQC9P2hN18PXg98pE4hLngh1QcYYS9r+D3HC2t7hKX6+ZUZOUdG0tW0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931285; c=relaxed/simple;
	bh=7SBKsqG7OsPREYt+XqWCRcfJsRHpF9fDPAP3N20IyU0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=k5KaJ8YnMzXQBd8daXyXrRh3zRgYuIcGhla8GvJoRO3WPPC9Fjd3qoYp4/wkqk/1MkYkU5u10QmoLCFQ1kwDPwlbabJo22WX9XWWBtTss1FWt/8vDL0uvMxJDvZiKiAEtOcz3G5CnIb/CsZDYY3GM4Ig5MsMPldts52+6d6Ald0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ol2h9F3B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ol2h9F3B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054331F000E9;
	Wed,  5 Aug 2026 12:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931284;
	bh=cCYHo+qVOCllO42aH1VDUWcQM5oJeyOQ6rvCWuDEBG0=;
	h=Subject:To:Cc:From:Date;
	b=Ol2h9F3BN/PuCbEs59WGAwkcGbmGgFDrVimBQmXG2cz6wtBWCr8niuo9i13jG0Y2e
	 fMJXV3lUjGEzmsuvendf4HMgrtiqULqsSblIyXwlAO5Q4FyGNInIQiHhcSpQJDmaKy
	 jAxFN95Vomysfx39DYjbkch6fwThsFntyaYb08Sc=
Subject: FAILED: patch "[PATCH] drm/amd/pm: fix torn gpu metrics reads" failed to apply to 5.15-stable tree
To: kevinyang.wang@amd.com,alexander.deucher@amd.com,kenneth.feng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:59:25 +0200
Message-ID: <2026080525-manor-gully-805a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 048f4541b71fb19645fb79d6e62e6e4da23a4035
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080525-manor-gully-805a@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 048f4541b71fb19645fb79d6e62e6e4da23a4035 Mon Sep 17 00:00:00 2001
From: Yang Wang <kevinyang.wang@amd.com>
Date: Thu, 23 Jul 2026 23:18:33 +0800
Subject: [PATCH] drm/amd/pm: fix torn gpu metrics reads

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

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index c787e772b3cc..6d1ad4d5b8f0 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1434,17 +1434,23 @@ int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
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
index d94ea54c33c3..763947fbf16f 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -1774,7 +1774,6 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 {
 	struct drm_device *ddev = dev_get_drvdata(dev);
 	struct amdgpu_device *adev = drm_to_adev(ddev);
-	void *gpu_metrics;
 	ssize_t size = 0;
 	int ret;
 
@@ -1782,15 +1781,10 @@ static ssize_t amdgpu_get_gpu_metrics(struct device *dev,
 	if (ret)
 		return ret;
 
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
 	amdgpu_pm_put_access(adev);
 
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
index e95cd22a31cf..8d1b097a3c3c 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm.h
@@ -518,7 +518,8 @@ int amdgpu_dpm_get_power_profile_mode(struct amdgpu_device *adev,
 				      char *buf);
 int amdgpu_dpm_set_power_profile_mode(struct amdgpu_device *adev,
 				      long *input, uint32_t size);
-int amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void **table);
+ssize_t amdgpu_dpm_get_gpu_metrics(struct amdgpu_device *adev, void *buf,
+				   size_t size);
 ssize_t amdgpu_dpm_get_xcp_metrics(struct amdgpu_device *adev, int xcp_id,
 				   void *table);
 ssize_t amdgpu_dpm_get_temp_metrics(struct amdgpu_device *adev,

