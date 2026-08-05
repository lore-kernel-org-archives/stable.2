Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820E5459AC1
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931299; cv=none; b=fm86GklaQZTyw4ueE6z6dnP9g2G1gFgjTSh3wYWDkpWPxd6Dl+ocCG6laIaX5+5br5DHKIHN+w5HrSobEtqdEeaUGQcqFAKvOJ8vm4r0qsToVen7iTKiK+s2C76+jxZyIyuZOstZEQj+QCuYa6OjS35JK2AivDOlaOnNxcU1lY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931299; c=relaxed/simple;
	bh=SMqzW2aq5LXuKFm4d4vOXjeMMsr0swV17qQ4IfXKmqk=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UVvBuVGkAv9zJ60KXBJv41U7dXyHO70Is22xawhxuoqQov4kqMbiNQHhlk0oRJ5T5FSCgKkfNdcRUSroDCGHvyYd4pFDaIE3C4ImWiHgCwQCjSzMOYE2IrCjB8/Ww6pdrdW+J9xOdBFPX+yxjq7nlYuJeZdH9d1F5UbBXCCzic0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O22AkwPV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O22AkwPV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4521F0182E;
	Wed,  5 Aug 2026 12:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931291;
	bh=yunyTkepX0aUDzu5r8fIrb8F94g9X4SxbiGeDrikIMU=;
	h=Subject:To:Cc:From:Date;
	b=O22AkwPVQYYC1XGhI60DM+oFAWyMaUKfcOk91BgAnOenR9/x3arHiASt4u8Qsh4yw
	 ruCTVNhDe9kQXnIwinMYTeE0EaSe2Z2QOSVVoQ2Q2NHb6aRd+TjX0F9W8ztJB49Lp0
	 QNFdbOZDwNl6U3DmXRopYrGUtHan45WvLtr4a+6U=
Subject: FAILED: patch "[PATCH] drm/amd/pm: fix pptable use-after-free" failed to apply to 6.12-stable tree
To: kevinyang.wang@amd.com,alexander.deucher@amd.com,kenneth.feng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:59:37 +0200
Message-ID: <2026080537-safehouse-registrar-bd15@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x bb493058c35c8676e48269ab6732688ea733d23c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080537-safehouse-registrar-bd15@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From bb493058c35c8676e48269ab6732688ea733d23c Mon Sep 17 00:00:00 2001
From: Yang Wang <kevinyang.wang@amd.com>
Date: Fri, 24 Jul 2026 07:41:29 +0800
Subject: [PATCH] drm/amd/pm: fix pptable use-after-free

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

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index f76ba6753551..c787e772b3cc 100644
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
index 97da01aff76c..d94ea54c33c3 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_pm.c
@@ -564,25 +564,19 @@ static ssize_t amdgpu_get_pp_table(struct device *dev,
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
 
@@ -2726,10 +2720,9 @@ static int default_attr_update(struct amdgpu_device *adev, struct amdgpu_device_
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
index aa3f427819a0..e95cd22a31cf 100644
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

