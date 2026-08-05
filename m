Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442C245FFB9
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 12:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785931332; cv=none; b=PqAOkv8ngyEraAjye1Gb1eZXX84yexwnv/xkX/RRQy++8FKLTrcnQMprtISxupwfXj29t9G/mBy3lIiR7eqwfbM3szWIyJhWC6NXcRqgr3dY7vuYgXGD2IdWA+30Gl/Io8V3ML8bH7bgxQddIo3G/z3jqkJgsmwrYUkHAyuqS4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785931332; c=relaxed/simple;
	bh=Jord3G32az3IkONJsdIX31NW1aPqVQMfkDosoK6QDgM=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RhlKJzeaGs6p//8pADcKIYCXo3imbrVhVYGbR93AjBT5UtZi+/A7Stz19ETbjCxpjXeUIiOT6GxoikQcGl3h6ZJK6YbvaMGjE6lX4pq7G6YcMhHsHM8NPJSDui9m/09VpXB6Vaw6/LgfE+46gYQ5HGWBr7j/dFVMmQLGnRHE6O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mI9Z26sc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mI9Z26sc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DDC1F01579;
	Wed,  5 Aug 2026 12:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785931305;
	bh=SOBKX5VLjLVt2rO0cdTYQVI6tUIixsct28hkIoGMLN8=;
	h=Subject:To:Cc:From:Date;
	b=mI9Z26scRPOmihO/RtfhfBj3uaGaot9lThnUkA5yTO7TD26+k+RXUS5BEM7enTNYe
	 OED1C3YzZv8PfBlIuaGRas8ujIGK+JKGx28Kev+wXT/+deqwlG5wU5Y2p/2jA9IDGe
	 81qGp29QXvxTCgoPrmQFaiQ/vq9SzdLUuB9guuS4=
Subject: FAILED: patch "[PATCH] drm/amd/pm: hide pp_table sysfs on APUs" failed to apply to 5.10-stable tree
To: kevinyang.wang@amd.com,alexander.deucher@amd.com,asad.kamal@amd.com,kenneth.feng@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 05 Aug 2026 13:59:48 +0200
Message-ID: <2026080548-spender-upcoming-b6c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x a65f5179d3f0c93da31b450aeb416eaa22f1912b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026080548-spender-upcoming-b6c4@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

