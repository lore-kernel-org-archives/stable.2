Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD446AA7D
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931321; cv=none; b=dcq8kbE7ilHGAr5SHEaUdl/TAgkAiBPED2dliigIRgSHzti67Lo1Wlzpx1hkgc3tfUj0i251p5j2UbB3U8p2XHFBapmdIT6F3wHmFtDg07B9ijO7mSFsnb8ww3yXGdSVemCzSkN+Wp7Snz1M3n+T8CFTBkEkYMHJmE2nbE484yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931321; c=relaxed/simple;
	bh=GOeJKA/XKOr7D5u3KEacAsiUNoFDI4UVsH0UPGuRCtM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=VRf226+V5XqeZUyxNRf78wD0p+A3d/6cPt75ZoBR7iKfrcm/CEdSJq3trlERAxW80DPsVSceQNF9YVLmr21Jy99efHw2pFsZk5J4fnFB7ZkHM9AvglEegxnuSlMF3qAUVvA+uorIPFNsl+NDEoBPaXobeahWTKpA1dnm5musKUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=C0ZOzwwW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="C0ZOzwwW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B9D71F01811;
	Wed,  5 Aug 2026 12:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931300;
	bh=5CksVeIonnEsarNFSy8E5KaYQ4YkkQdGiQN/RVifnmY=;
	h=Subject:To:Cc:From:Date;
	b=C0ZOzwwWpnv0Z89e+NT+KtnQLLfqwFVT9ejHCUTftm0916TNKkm2VNUF5Pj5DyDMN
	 xNGA6CkONIdE5jYMZpclpa0oWNnwtP8Q6xsymbmoA3cALI2iCpXFa1fJ1qxavavPcu
	 hCNNl0uB+dhUzudgBSbDgUqCjQA5m9OfYJvHZeBw=
Subject: FAILED: patch "[PATCH] drm/amd/pm: hide pp_table sysfs on APUs" failed to apply to 6.12-stable tree
To: kevinyang.wang@amd.com,alexander.deucher@amd.com,asad.kamal@amd.com,kenneth.feng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:59:47 +0200
Message-ID: <2026080547-hatbox-badge-6ca1@gregkh>
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
git cherry-pick -x a65f5179d3f0c93da31b450aeb416eaa22f1912b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080547-hatbox-badge-6ca1@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From a65f5179d3f0c93da31b450aeb416eaa22f1912b Mon Sep 17 00:00:00 2001
From: Yang Wang <kevinyang.wang@amd.com>
Date: Wed, 29 Jul 2026 15:56:46 +0800
Subject: [PATCH] drm/amd/pm: hide pp_table sysfs on APUs

APUs use firmware-owned DPM tables and do not support replacement through
pp_table. Generic callbacks can nevertheless expose the sysfs file and
accept an upload before resetting the power management stack.

Treat pp_table as unsupported on APUs. Use the same platform check in the
get and set paths to hide the file and reject uploads.

Fixes: 289921b03fe5 ("drm/amd/powerplay: implement sysfs of pp_table for smu11 (v2)")
Signed-off-by: Yang Wang <kevinyang.wang@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 74f28db2db69777cd2f059d50fe34e365ddd5add)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
index 6d1ad4d5b8f0..e5e89294958a 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm.c
@@ -1183,6 +1183,13 @@ int amdgpu_dpm_dispatch_task(struct amdgpu_device *adev,
 	return ret;
 }
 
+static bool amdgpu_dpm_is_pp_table_allowed(struct amdgpu_device *adev)
+{
+	return !amdgpu_sriov_vf(adev) &&
+	       !(adev->flags & AMD_IS_APU) &&
+	       !adev->scpm_enabled;
+}
+
 int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
 			    size_t size)
 {
@@ -1193,7 +1200,8 @@ int amdgpu_dpm_get_pp_table(struct amdgpu_device *adev, char *table,
 	if ((!table && size) || (table && !size))
 		return -EINVAL;
 
-	if (amdgpu_sriov_vf(adev) || !pp_funcs->get_pp_table || adev->scpm_enabled)
+	if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
+	    !pp_funcs->get_pp_table)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);
@@ -1717,7 +1725,8 @@ int amdgpu_dpm_set_pp_table(struct amdgpu_device *adev,
 	if (!buf || !size)
 		return -EINVAL;
 
-	if (amdgpu_sriov_vf(adev) || !pp_funcs->set_pp_table || adev->scpm_enabled)
+	if (!amdgpu_dpm_is_pp_table_allowed(adev) ||
+	    !pp_funcs->set_pp_table)
 		return -EOPNOTSUPP;
 
 	mutex_lock(&adev->pm.mutex);

