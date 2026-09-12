Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6093F788A
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230267; cv=none; b=FlvjEtbj1Gp/nEw9gf9Jk71nYLU8EfpZyaQDZ+Il0Q+eBwvpEOryIee4z4zFOCGMIblf1IehDtsXUQ8ybfmXZLtvx6tN8j4zwrmJSocL8OuBv7w17PlthSRkek5KKK7OsYwY9IPzqiJuTvGZHNa8+M4rwMAVvtmtbmj+hP6o4UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230267; c=relaxed/simple;
	bh=9WtbmP58SowM9kA4wyn4RXQ6Q6n0IHgkyUAuI4qgI+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hmrbdzTx96IsTshkBhKRPJ0SeKHqA5igYMSpzlfMSDGbUzI9vI0JZXCUviNQXdWXdEesyiS4vS59WVjP0jPrRSwllroDpL6e3cqIvtmkCtHTE6w0gjO/Y0W0TkcccoiOa0E4fG+jINIrCOdbhjRZ1o8XjZ0oRAxI3EOHM4x4ubM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fo0wX6A4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fo0wX6A4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74DDF1F00898;
	Sat, 12 Sep 2026 16:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230265;
	bh=gw7LCmqBsjlVoPQhlojoVI1RGMPOgKW/7SA+Lk081DA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fo0wX6A4EWh46SdyFZq/neniGJXurAgCLA3Sjg9lD18j3VYQhuMF6hc7IdXHotZDR
	 V2YCwNyDlbxjUfksqCemok/DRkydwiMrlOgVV7bJcZj4raHqTeXkGogirCFKQzGrlc
	 yiz2gnnIx+s7RNFBfQVwX5Oaa4FbnSlBIBIVhGUf+7Ps1Ehgs0OzwoxMY24bVogmtf
	 lmJZTTVcLwe8T4kd2diVmwvHM557WtUdcKCnhjM4rX2OXrqdDIMU4I47HyG0ydw61D
	 yR9+6a7Z6n5WHyDWvxm5AM9IG9+7AVf3Nt2aEhpsXWIEnAiGEGl9sSzKS+9i4gSR6q
	 sJxcbUpgQwLDg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Evan Quan <evan.quan@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] drm/amdgpu: move runtime pm init after drm and fbdev init
Date: Sat, 12 Sep 2026 12:24:22 -0400
Message-ID: <20260912162423.3655323-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912162423.3655323-1-sashal@kernel.org>
References: <2026090919-washstand-timothy-3b64@gregkh>
 <20260912162423.3655323-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit d0d66b8c66d04363eff3a5b09da4074fc1dfc758 ]

Seems more logical to enable runtime pm at the end of
the init sequence so we don't end up entering runtime
suspend before init is finished.

Reviewed-by: Evan Quan <evan.quan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

[5.10 backport: Move the existing runtime PM initialization and teardown
into the PCI probe/remove paths. Keep the 5.10 BOCO/ATPX condition and
DPM_FLAG_NO_DIRECT_COMPLETE policy; amdgpu_device_supports_px() and the
newer SmartShift hooks are not present in this tree. Relocate the existing
audio helper unchanged, without introducing any new functions. Remove the
load-error PM put paired with the get that now only runs during removal.
This prepares the remove path for ef5fcf2a6c32.]

Stable-dep-of: ef5fcf2a6c32 ("drm/amdgpu: fix autosuspend cleanup during removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 61 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 65 +------------------------
 2 files changed, 62 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 0d8c1c318ce89..a75c988b4be89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1103,6 +1103,22 @@ MODULE_DEVICE_TABLE(pci, pciidlist);
 
 static struct drm_driver kms_driver;
 
+static void amdgpu_get_audio_func(struct amdgpu_device *adev)
+{
+	struct pci_dev *p = NULL;
+
+	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
+			adev->pdev->bus->number, 1);
+	if (p) {
+		pm_runtime_get_sync(&p->dev);
+
+		pm_runtime_mark_last_busy(&p->dev);
+		pm_runtime_put_autosuspend(&p->dev);
+
+		pci_dev_put(p);
+	}
+}
+
 static int amdgpu_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -1218,6 +1234,44 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		DRM_ERROR("Creating debugfs files failed (%d).\n", ret);
 
+	if (adev->runpm) {
+		/* only need to skip on ATPX */
+		if (amdgpu_device_supports_boco(ddev) &&
+		    !amdgpu_is_atpx_hybrid())
+			dev_pm_set_driver_flags(ddev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
+		pm_runtime_use_autosuspend(ddev->dev);
+		pm_runtime_set_autosuspend_delay(ddev->dev, 5000);
+
+		pm_runtime_allow(ddev->dev);
+
+		pm_runtime_mark_last_busy(ddev->dev);
+		pm_runtime_put_autosuspend(ddev->dev);
+
+		/*
+		 * For runpm implemented via BACO, PMFW will handle the
+		 * timing for BACO in and out:
+		 *   - put ASIC into BACO state only when both video and
+		 *     audio functions are in D3 state.
+		 *   - pull ASIC out of BACO state when either video or
+		 *     audio function is in D0 state.
+		 * Also, at startup, PMFW assumes both functions are in
+		 * D0 state.
+		 *
+		 * So if snd driver was loaded prior to amdgpu driver
+		 * and audio function was put into D3 state, there will
+		 * be no PMFW-aware D-state transition(D0->D3) on runpm
+		 * suspend. Thus the BACO will be not correctly kicked in.
+		 *
+		 * Via amdgpu_get_audio_func(), the audio dev is put
+		 * into D0 state. Then there will be a PMFW-aware D-state
+		 * transition(D0->D3) on runpm suspend.
+		 */
+		if (amdgpu_device_supports_baco(ddev) &&
+		    !(adev->flags & AMD_IS_APU) &&
+		    (adev->asic_type >= CHIP_NAVI10))
+			amdgpu_get_audio_func(adev);
+	}
+
 	return 0;
 
 err_pci:
@@ -1229,12 +1283,19 @@ static void
 amdgpu_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
 
 #ifdef MODULE
 	if (THIS_MODULE->state != MODULE_STATE_GOING)
 #endif
 		DRM_ERROR("Hotplug removal is not supported\n");
 	drm_dev_unplug(dev);
+
+	if (adev->runpm) {
+		pm_runtime_get_sync(dev->dev);
+		pm_runtime_forbid(dev->dev);
+	}
+
 	amdgpu_driver_unload_kms(dev);
 	pci_disable_device(pdev);
 	pci_set_drvdata(pdev, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index aa887327aa726..15ca463526a26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -88,11 +88,6 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 	if (adev->rmmio == NULL)
 		return;
 
-	if (adev->runpm) {
-		pm_runtime_get_sync(dev->dev);
-		pm_runtime_forbid(dev->dev);
-	}
-
 	amdgpu_acpi_fini(adev);
 	amdgpu_device_fini(adev);
 }
@@ -122,22 +117,6 @@ void amdgpu_register_gpu_instance(struct amdgpu_device *adev)
 	mutex_unlock(&mgpu_info.mutex);
 }
 
-static void amdgpu_get_audio_func(struct amdgpu_device *adev)
-{
-	struct pci_dev *p = NULL;
-
-	p = pci_get_domain_bus_and_slot(pci_domain_nr(adev->pdev->bus),
-			adev->pdev->bus->number, 1);
-	if (p) {
-		pm_runtime_get_sync(&p->dev);
-
-		pm_runtime_mark_last_busy(&p->dev);
-		pm_runtime_put_autosuspend(&p->dev);
-
-		pci_dev_put(p);
-	}
-}
-
 /**
  * amdgpu_driver_load_kms - Main load function for KMS.
  *
@@ -211,51 +190,9 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 	if (acpi_status)
 		dev_dbg(&dev->pdev->dev, "Error during ACPI methods call\n");
 
-	if (adev->runpm) {
-		/* only need to skip on ATPX */
-		if (amdgpu_device_supports_boco(dev) &&
-		    !amdgpu_is_atpx_hybrid())
-			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
-		pm_runtime_use_autosuspend(dev->dev);
-		pm_runtime_set_autosuspend_delay(dev->dev, 5000);
-
-		pm_runtime_allow(dev->dev);
-
-		pm_runtime_mark_last_busy(dev->dev);
-		pm_runtime_put_autosuspend(dev->dev);
-
-		/*
-		 * For runpm implemented via BACO, PMFW will handle the
-		 * timing for BACO in and out:
-		 *   - put ASIC into BACO state only when both video and
-		 *     audio functions are in D3 state.
-		 *   - pull ASIC out of BACO state when either video or
-		 *     audio function is in D0 state.
-		 * Also, at startup, PMFW assumes both functions are in
-		 * D0 state.
-		 *
-		 * So if snd driver was loaded prior to amdgpu driver
-		 * and audio function was put into D3 state, there will
-		 * be no PMFW-aware D-state transition(D0->D3) on runpm
-		 * suspend. Thus the BACO will be not correctly kicked in.
-		 *
-		 * Via amdgpu_get_audio_func(), the audio dev is put
-		 * into D0 state. Then there will be a PMFW-aware D-state
-		 * transition(D0->D3) on runpm suspend.
-		 */
-		if (amdgpu_device_supports_baco(dev) &&
-		    !(adev->flags & AMD_IS_APU) &&
-		    (adev->asic_type >= CHIP_NAVI10))
-			amdgpu_get_audio_func(adev);
-	}
-
 out:
-	if (r) {
-		/* balance pm_runtime_get_sync in amdgpu_driver_unload_kms */
-		if (adev->rmmio && adev->runpm)
-			pm_runtime_put_noidle(dev->dev);
+	if (r)
 		amdgpu_driver_unload_kms(dev);
-	}
 
 	return r;
 }
-- 
2.53.0

