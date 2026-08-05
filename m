Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025D246EF91
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931330; cv=none; b=fptvqBgFmn3rLyOXk1kgF1YG7Qb5sYcDafvRQMVfNZ63hBQLUz3x4yPvwtv4PAlKBYUlHvPE/eWA69Hr2n3VOKWkELjPBr0p+v1MaQH1Cx4+mrlxNWthJQt7ffjMd38qJ81yBFL8kC5Uq9TolBwbuJzad1yjSdDoRlK48/lH+UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931330; c=relaxed/simple;
	bh=3qklVlKcA6YJOa5JwomYHfm8X0D41JvTcJLXm8xQL6U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LQopRVbOPLNx3wu0Nfdh2jviSNxsDxktKsXHZDpwxZnunTNsazP3e3A6EPWjlqjP139qnn/pvauQ6uZJVIYa/fRIECKLZHP2iuTHnSq86Xtf5XA5C29inpU/bdE6Ur3ZKhxY62QYVgSeuohwhdUEaZKLMYl6wSUXKUGOh/FTWmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ge6lc4OD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ge6lc4OD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D3761F01818;
	Wed,  5 Aug 2026 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931304;
	bh=lD04//9uGxg70iRjcwJW/AFFAHLiy1g++NcpAyOPEdM=;
	h=Subject:To:Cc:From:Date;
	b=Ge6lc4OD1YhJRkKJxsGMR42skcjlQtEn6SsdtUcWhInm/V4SjrI1fhQbHvqqKq5P1
	 zzNniEERWWBP49Csqr79kI7IcHkobcxDgxHTrkzQwFFcbZY0nJzxEKzFoLwJSGYA+N
	 dv9wcBPhdZVnRIu1DhG8cSfieLmohhfGkQZZvXv4=
Subject: FAILED: patch "[PATCH] drm/amd/pm: hide pp_table sysfs on APUs" failed to apply to 6.18-stable tree
To: kevinyang.wang@amd.com,alexander.deucher@amd.com,asad.kamal@amd.com,kenneth.feng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:59:47 +0200
Message-ID: <2026080547-compost-winking-bfed@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x a65f5179d3f0c93da31b450aeb416eaa22f1912b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080547-compost-winking-bfed@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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

