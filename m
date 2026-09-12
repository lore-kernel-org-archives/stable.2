Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD6ECA6F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 15:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789226046; cv=none; b=KY/oB7nH/slaWaurmoobyJ+nU6VPtL6T/6anMk//ThWP9SY1juLmuE15DqOG9LhqPZhDQVw5KhLSN8yRIFQDqLVgxAwNB/lb1FSC+hz9QKmJ/8HOJn6Nwlzo+ZRIfvz/+8NLKN0zPGIbCG2Vnkd7sGEL9TtbZZoxIsaQZwA9oeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789226046; c=relaxed/simple;
	bh=uNkcvNZgkZTOf3TS8c44MSQelRf3Ny5HTsdeth5WZag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k516Mjiai9mK+IG0l5fculP/KZT+P4SGrOZ3DCVxBPTbPRJdcHAEK+bSOm+HxAPIMHMk9M+J80auGpGVaaahBOGPMb9TCdxJbVs/UgUpUrYPksLULGpFLV4u4MYbye8eBUz4P9RJSIq4OeZxkMfCIKTbR9qbG9B0kTRdaEzn8SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MYvEQzrY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MYvEQzrY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE0B1F000FF;
	Sat, 12 Sep 2026 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789226045;
	bh=Fbmicft9ZuYC5qDeNIRCDS8x//GAxEEVj8aNvdG1yjs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MYvEQzrYCcMqOhW5gC+XCXMJ127s9XYbb3sW9hCsRae8Oc34sOjWADWq17jv4W2ki
	 YzDSBa5nqynwwBlCyj3PfLrDnrVqz94aRfSNZsLf8Hmbb6c4IKWcJmo5qH2bevNkRP
	 fZd0nzmlff/aIbq5RcTKa0JNzPkLghrTt2nRxizrP3xfBP6hwpme06doEb0cCUwbDo
	 Djy8wiXsFv7k05LZKeClW/ST+Qz5QWaxr/7M1z2p4Ral5LZ9vqJcDtroqB+pRpSk8Q
	 ULIjKSEMopfJdVVEJAnj2Icj25Lsk4tW0w0anrGKzLUEpzS0PVYCCjQXt1v6VYzppS
	 y9DD7HYujoWTw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Evan Quan <evan.quan@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] drm/amdgpu: move runtime pm init after drm and fbdev init
Date: Sat, 12 Sep 2026 11:14:02 -0400
Message-ID: <20260912151403.3071211-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090919-halt-gusto-67b7@gregkh>
References: <2026090919-halt-gusto-67b7@gregkh>
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

Stable dependency adaptation for ef5fcf2a6c320676bf8be2dadac93d9023b468b7:
Retain only the runtime-PM teardown relocation into amdgpu_pci_remove()
and remove the corresponding load-failure pm_runtime_put_noidle(), since
amdgpu_driver_unload_kms() no longer takes that reference.

The target adds autosuspend cleanup to this removal block. Moving runtime
PM initialization and the audio helper is unnecessary for that fix, so
leave both in amdgpu_kms.c. This also avoids the insertion conflict with
the stable-only amdgpu_is_fw_framebuffer() helper and adds no functions.
Keep the stable adev->runpm condition; the target merges cleanly with it.

Stable-dep-of: ef5fcf2a6c32 ("drm/amdgpu: fix autosuspend cleanup during removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  7 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 11 +----------
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 58292a296875b..7f2e71a51e0e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -2115,8 +2115,15 @@ static void
 amdgpu_pci_remove(struct pci_dev *pdev)
 {
 	struct drm_device *dev = pci_get_drvdata(pdev);
+	struct amdgpu_device *adev = drm_to_adev(dev);
 
 	drm_dev_unplug(dev);
+
+	if (adev->runpm) {
+		pm_runtime_get_sync(dev->dev);
+		pm_runtime_forbid(dev->dev);
+	}
+
 	amdgpu_driver_unload_kms(dev);
 
 	/*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index b8b0b819de72b..d18221f7d17d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -98,11 +98,6 @@ void amdgpu_driver_unload_kms(struct drm_device *dev)
 	if (adev->rmmio == NULL)
 		return;
 
-	if (adev->runpm) {
-		pm_runtime_get_sync(dev->dev);
-		pm_runtime_forbid(dev->dev);
-	}
-
 	if (amdgpu_acpi_smart_shift_update(dev, AMDGPU_SS_DRV_UNLOAD))
 		DRM_WARN("smart shift update failed\n");
 
@@ -273,12 +268,8 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		DRM_WARN("smart shift update failed\n");
 
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

