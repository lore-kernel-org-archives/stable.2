Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA38C35DA6E
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 01:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790127619; cv=none; b=dsOBSIXbgX2Dm8zN6hSjIJcp0GoU111m+Ae1PIgMQTTb7RlM9eLR5X8Roq4VP76eHegYZOUtWok14PfSZyRenex9OvWeqSPF9Y4gxbIXtwxTZqAzxFDiQDTwwIGy8SuLXK8azNXr3nFnqDuex9UtPwl+5rnJwUMncugUQUyaFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790127619; c=relaxed/simple;
	bh=2JYEA/moREkffLXsFqurthT+a2Pu1kbpqmt+o2A6hTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JvdcPYOlTwNCJVNkCxNr41uacdC3/hAC8iTAzgaxghRhdqDnjDeE9Gpe6C3CiOK371yxI1YklnbbZR7+rKFJWgdZfDAR/PGBtoSUVGg+4mZpBA98BYSBmRYnzRf2NFeLkI6d3dGevBz/jBE8P7ykz/NG8wvRI7BTlWWO7GUGrA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FegJu0ve; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FegJu0ve"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 374161F00898;
	Wed, 23 Sep 2026 01:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790127617;
	bh=sLQj/5YYNmtLTfXKt25ajru/ViKiIu2Q6FankAdsQm0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FegJu0vel3gKw1s7ZzThz5CjSLeIO9OnBBNOGUVmXvPqssk9FwZvqg70wEX+bKywE
	 LkcDs/x54ddASNVuNsngNRMuGLVQxaltMd8kzkKmlAdOW5806vD13kK9Zs7OcXBa2N
	 WmIIPHl5qxM9zaouc9jHL17Z8QYVAAj2fxUsYfEHfKCr5UrNei9vJwRH80Gq0/HaxN
	 wgbemK3JrZLykmUZkTLgtm051+Lt2X1aM5CiOFfWCfWu7UVV182BhauA994fXPliUM
	 PTp+dJg1Oi6LJPyEXA+bBBN1E50QaNDZxnIUL7/GXNO7pbNjwKBz/SxxoaZeqW+i7N
	 g4UCemKFa08Xw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chengjun Yao <Chengjun.Yao@amd.com>,
	Asad Kamal <asad.kamal@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] drm/amdgpu: fix rmmio iounmap skipped on device removal
Date: Tue, 22 Sep 2026 21:40:14 -0400
Message-ID: <20260923014014.880066-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923014014.880066-1-sashal@kernel.org>
References: <2026092242-mantis-dragonfly-bdca@gregkh>
 <20260923014014.880066-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chengjun Yao <Chengjun.Yao@amd.com>

[ Upstream commit 5155002b03b24ba3ef91c5c313b8cf0171b24904 ]

amdgpu_pci_remove() calls drm_dev_unplug() before fini_sw(), so
drm_dev_enter() is already false there and the iounmap() guarded by it
is skipped. This .remove path runs on both hot-unplug and plain rmmod,
so the register BAR ioremap mapping leaks one instance per unload.

Unmap rmmio unconditionally (guard only on non-NULL) and drop the now
unused idx.

Fixes: 62d5f9f7110a ("drm/amdgpu: Unmap MMIO mappings when device is not unplugged")
Signed-off-by: Chengjun Yao <Chengjun.Yao@amd.com>
Reviewed-by: Asad Kamal <asad.kamal@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit dd6f86a97260e5207d3329ad03aa89fdad61b1e6)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index a61573a1c0c40..81f1fbee94ba4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4147,7 +4147,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
-	int i, idx;
+	int i;
 	bool px;
 
 	amdgpu_device_ip_fini(adev);
@@ -4180,11 +4180,9 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_unregister(adev->pdev);
 
-	if (drm_dev_enter(adev_to_drm(adev), &idx)) {
-
+	if (adev->rmmio) {
 		iounmap(adev->rmmio);
 		adev->rmmio = NULL;
-		drm_dev_exit(idx);
 	}
 
 	if (IS_ENABLED(CONFIG_PERF_EVENTS))
-- 
2.53.0

