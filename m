Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2071470E87
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931338; cv=none; b=BbmTVnUKLTLuuKj9FeuJyAvK0aJd1Ryxt6l1aVGv4ianT9jb0j2tgUplJE/p7ZACeZL2JfopohoUzoUDR3y2Yf04tMxyVecVX2sZi+eyI+Qfs5GrhXmpw2vqGpozq4bWTpUe701seB/v6+TiPqHBrgExQ5rb6p9+NDABIfhC2iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931338; c=relaxed/simple;
	bh=td/7nsDpXq4UJyGD8PWmkJ7958SJB78RcHzNxaJJNqI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=R1TyyLHrMnEiwy306eR9oKYIxiwSnIyVdINFYGfTpab8le8M0/EgFS8WAmjaoH/UyVGRTukle5z57pWiE5QlVeYy4xVsSSvw7MPuSDM6ygxMX0xBz1vYsA3d0M6isBMMUrJsxYpfg2ajzTyIbKgzP9yp8NqY1ftKV9gLnZlZoa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RzZ9jHC+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RzZ9jHC+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E62B1F02825;
	Wed,  5 Aug 2026 12:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931307;
	bh=PCUFgAYz0I9u53YLF6D/LNEnW4Cri1Rglicwj2Z7cvM=;
	h=Subject:To:Cc:From:Date;
	b=RzZ9jHC+9DwpZ4b4mk7soDI7eZIbpEwW6kvA0Jfb06oR05AAhRH2R6jILxp+CgqFN
	 0Fa5lkeDpKKX+a2mBmWEkB+7T0GAIdyrYrEGL0P7j29AYcuIRw6gxCjHwaruEMyhnQ
	 EH5TZM2TPyrNgxpnzAcHrD6DDN94YGTDq1/mGUdg=
Subject: FAILED: patch "[PATCH] drm/amd/pm: hide pp_table sysfs on APUs" failed to apply to 5.15-stable tree
To: kevinyang.wang@amd.com,alexander.deucher@amd.com,asad.kamal@amd.com,kenneth.feng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:59:48 +0200
Message-ID: <2026080548-balsamic-perjury-30a4@gregkh>
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
git cherry-pick -x a65f5179d3f0c93da31b450aeb416eaa22f1912b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080548-balsamic-perjury-30a4@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

