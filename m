Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 867CB54A7F3
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955626; cv=none; b=Lnh9wWEa32EmXmeB9JHkhIdV1eWkIWIqLkz96o8WTjE0Xk0DDq+EaE0Eey3vhRmYa+q/tOpDkl9lVc9I6hCjF8OgEgwLPJC5guvbr8YVbzZBml/4B69VEUkDPv5/XFI8dvwXVdb9dNUbllu6uOGfyt/XFqPKxeoeSN2nsHEgbtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955626; c=relaxed/simple;
	bh=VopqaViIYxiWDcY7+26YnUSGz6cpx11Npw/qe3ylM0Y=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dyl1aZ3kMCW+GYiKpI7Twjsz8o2VVOFCgtClVjFPaDDjt3QKd8t7SCE88S0yreDzJZ8OFXIk407i5FGYHlD4G/EMcQCMW67mWDWVRcxF8s9gEt+R/Mww0BRbKh4qQ5pL8idpCJeL4YlmUYnZc0ssaUhx8c0fUDGF/IoReP7e5WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OlYF4YHL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OlYF4YHL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 906351F00A3D;
	Wed,  9 Sep 2026 12:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955625;
	bh=ntPwbwVcDbG9fhg6WIrkpQtjUjzuWHpYhqJdn0maB5g=;
	h=Subject:To:Cc:From:Date;
	b=OlYF4YHLOeH6T5AUKeTzodfFVi91Bv2XHds3JMCMOLW+IX2+zA+TmoUSLFcYSmBim
	 Zicl1uNomFB0Eyow94ogZw8EGpMMkFmDZXhAGdJSMRCNv7aZAlK7gn5OTgbgY3YGD0
	 0B/lD2FkQHFlmxGrFAVpITkWSeBX0dgWAGlpZbGc=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix autosuspend cleanup during removal" failed to apply to 5.15-stable tree
To: lgs201920130244@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com,superm1@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:57:19 +0200
Message-ID: <2026090919-halt-gusto-67b7@gregkh>
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
git cherry-pick -x ef5fcf2a6c320676bf8be2dadac93d9023b468b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090919-halt-gusto-67b7@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ef5fcf2a6c320676bf8be2dadac93d9023b468b7 Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Sat, 8 Aug 2026 20:09:34 +0800
Subject: [PATCH] drm/amdgpu: fix autosuspend cleanup during removal

amdgpu_pci_probe() calls pm_runtime_use_autosuspend(), but
amdgpu_pci_remove() does not call the matching
pm_runtime_dont_use_autosuspend().

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped and usage_count remains
unbalanced.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() call to the remove
path.

This issue was found by manual code inspection.

Fixes: d38ceaf99ed0 ("drm/amdgpu: add core driver (v4)")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
Link: https://patch.msgid.link/20260808120934.2813010-1-lgs201920130244@gmail.com
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0ab380ca7e64..5c33c19fd9bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2557,6 +2557,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	if (adev->pm.rpm_mode != AMDGPU_RUNPM_NONE) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	amdgpu_driver_unload_kms(dev);

