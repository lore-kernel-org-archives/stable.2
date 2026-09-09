Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7915E472764
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 12:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788955624; cv=none; b=HABs55k8MTWEwo5AM3Skq33e9YwHqT+AHeQUJalouZk74Wm8kVwvL6aTgcCZwDaLLhJU7oZZGTm0XuOYXpnerDq+W0bkDHGFm9sH3ZcZ1elYUqluM3qITm0wn+fZ3Mx6xCTF9KKD6lUZSZbXfnoXusB+/MeAAumnGoVgqrGgBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788955624; c=relaxed/simple;
	bh=BDBvNt2hkDrz9khO7xDzKTgIR0PTp8UohYew874MQbQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=pTJQQM7SLrm1L4OiimVMzDLKvuZGwclmFDlnOVp8IFlzeLF4e6kQPV4qZT5KzjiiGxisxeXQ6ys2qhxljXZDWnEseFPjl44dfLKqLhBN3M+7dIay2tofA4r/cZKdsP81DKRRdojURR4wUgGkQIZPTKONnTM3iNpbnP6dirN4GdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0d12PpZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0d12PpZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9FBC1F00A3A;
	Wed,  9 Sep 2026 12:07:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788955622;
	bh=sXCOj9XGGJMObR2Q6OtLXxRopaHtiAOpRMa+VG78myo=;
	h=Subject:To:Cc:From:Date;
	b=0d12PpZERzI/3abu1Ll5XiXMSThGLsfhe5KDtG6xO9LL74L95UJZETkuFl13lDgAm
	 +oZYntxb3s6f2geJG6UzYHv1NcwJHnaxgEjlCG6I7vb+uNLXTcjnJ9qlikgsRqeR4P
	 Wn/k9oE3xHWp+2oeZI8E2S/1JdoLot0up9QhJK6s=
Subject: FAILED: patch "[PATCH] drm/amdgpu: fix autosuspend cleanup during removal" failed to apply to 5.10-stable tree
To: lgs201920130244@gmail.com,alexander.deucher@amd.com,mario.limonciello@amd.com,superm1@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 13:57:19 +0200
Message-ID: <2026090919-washstand-timothy-3b64@gregkh>
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
git cherry-pick -x ef5fcf2a6c320676bf8be2dadac93d9023b468b7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090919-washstand-timothy-3b64@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

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

