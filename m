Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3006471249
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789230268; cv=none; b=g3CAV2sniKcC/zruPGKZtyl9JGDS4x6dFR16aS6PA2ZWTiPTuH6D4x2mQP+T4j9WRLiDOzlnG5X4IVHMEVOY+8Jd61CuM68Gbivv+aBW7LAm0ozmUit6l5I39hCXi/NITHLmTtfE/GIGrNnx0oJS5+9zFPbDcJqvdjK1I+xTi00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789230268; c=relaxed/simple;
	bh=WL5lN4qtnFMkoCrQFyHausgNAdqESXih2wYX1Y0I+0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iu3A/UvJT1+jyVtTCd062sA7w58flik+62jEnrbkRatjLgkq3STGvJGzGp0mNxivfj+LkX7fLaWLuLiSh2zhm7dstwJnGPiJxN8Qg3lDMX/7CZ8gaw9VK4vk7e07hUavJGjKovZWNDIA5Vq86J6PLb6YGlidb/7hUFlKvHIkgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rb1SUa5c; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rb1SUa5c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD011F000FF;
	Sat, 12 Sep 2026 16:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789230266;
	bh=8gT66Kj+49eBwyZYcP13OJ4QGjU9L0A4c0M+RpiVcVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rb1SUa5cI6upDj+87fGbAaCHFTwbTF0U+GjKsjLDYLXKwipJglxuFibI75XozIS3s
	 MSF+hNb1fVdkqY8uZBAcQ0RO1zzw0lgqP1keZXfcbieHp6g5RbTMPQPHZ/1CqQsq+F
	 YM76mTV/EtZGeg/YAelXcyMIMgSqueDDYog4OHI4KJosMLImOwT81DoPG10/zSkCDH
	 CZaSqHc7ZjvhVYShKn1kAR5izID36N60a3iqsL2ADnF1LqXbIkdiQqvyc39MvB8aWu
	 DIGVpahGURLR0c/Q6p2QnZBgVR3nNF8+XBULtcA6SYWDQgTa/2K89FMURlYxV5uljw
	 6IpVa/ntYIhAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	"Mario Limonciello (AMD)" <superm1@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 3/3] drm/amdgpu: fix autosuspend cleanup during removal
Date: Sat, 12 Sep 2026 12:24:23 -0400
Message-ID: <20260912162423.3655323-3-sashal@kernel.org>
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

From: Guangshuo Li <lgs201920130244@gmail.com>

[ Upstream commit ef5fcf2a6c320676bf8be2dadac93d9023b468b7 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index a75c988b4be89..ec7c1e44f4cfb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1294,6 +1294,7 @@ amdgpu_pci_remove(struct pci_dev *pdev)
 	if (adev->runpm) {
 		pm_runtime_get_sync(dev->dev);
 		pm_runtime_forbid(dev->dev);
+		pm_runtime_dont_use_autosuspend(dev->dev);
 	}
 
 	amdgpu_driver_unload_kms(dev);
-- 
2.53.0

