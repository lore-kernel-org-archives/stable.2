Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44B3497B6C
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208997; cv=none; b=Jq0s3T8PW9Il6cZdvX+F4iqKgjxK98hHgjmN2yTWEytl2nwU7V0P8vpd8PW8n4uvx05RK6tAoMMLOaKrZRJ/VRCaoZQg+PO4XiF3C6FbLX2PoBTvAmAd6o6cwTvQz9D8USAgc2oAjQZVL8uKadoVKXW63xTb2wf1gmY6vd6DShw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208997; c=relaxed/simple;
	bh=QGJKEn9pD1hcchPUCrMSimcWCk+OZdAKmF31N9Y3Mko=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EdZFrDNnFDKISilygMCFIoqurYgGbwFm1rRXk2vQ1zmmAzOmPEDbnE9rM/rQqhsZKJDmqJwFj5+BzZwd9w+IXAqpA8ZIxbaUc215Pk0XZNmMX1LGaur5dkgkwXcPRisb9jg+8A0HV5ztXHcEaJhMr8IZStqLpwZduA+7wCNoBI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UOe20xhp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UOe20xhp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23DA71F000FF;
	Mon,  5 Oct 2026 14:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208996;
	bh=MM1DPJ59BSEwtGk8ealkbk51u1SDNyQzJ+oLDcEpoeg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UOe20xhpEkJevK0Q2drn6MbviwfR+nkmnB18omuIA7ai8jQikBmLmZgtQbZ98htbK
	 6OUxE1QOp0ZHRtPqUfFDg6gw1+UPx0YzCGaXOYCRLhxTkpqhK1Pyi/Zi+Ua/yZp59I
	 Oy+pIE4mmjJMuWA4EvyqG4fyfMohzyi81El03a2G8717jqszLtUeQ24vzyobmTkMHl
	 tBUg4g9Xo7dgia48llPC5M1oW0q316kdq2Qux2k2IXig9lGZ9au/p9ymPg6e5d2SmH
	 SSFNm4rcmcrXDJY1XU9lkJlOoEk/qtohmUtxWaZCmHCQikwfl/zq+idrYwtpoBIStf
	 yzhpH19lVmEBg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Frederick Morlock <me@freddy.us>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] drm/amdgpu: reset VI ASIC on MacBookPro15,1
Date: Mon,  5 Oct 2026 10:03:12 -0400
Message-ID: <20261005140300.2983832-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100528-almighty-whoopee-38d8@gregkh>
References: <2026100528-almighty-whoopee-38d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andre Eikmeyer <dev@deq.rocks>

[ Upstream commit a5be7ad8f5f0e067613e9197638f216f46252946 ]

After S3, reloading amdgpu on MacBookPro15,1 systems with a Radeon Pro
555X or 560X fails while loading the SMU firmware. The existing SMC
register check does not request a reset because the registers do not
reliably reflect the stale SMU state on these machines.

Frederick Morlock found that forcing a VI ASIC reset allows the driver to
initialize again. This patch limits his workaround to the exact PCI
device, Apple subsystem device and revision combinations used by these
two GPUs, leaving other VI hardware unchanged.

Suggested-by: Frederick Morlock <me@freddy.us>
Signed-off-by: Andre Eikmeyer <dev@deq.rocks>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: a22e5e4f2ebb ("drm/amdgpu: reset VI ASIC on MacBookPro14,3")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/vi.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index 3683a5d9348bf..162077d3bf765 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1409,10 +1409,30 @@ static uint64_t vi_get_pcie_replay_count(struct amdgpu_device *adev)
 	return (nak_r + nak_g);
 }
 
+struct vi_reset_quirk {
+	u16 device;
+	u16 subsystem_vendor;
+	u16 subsystem_device;
+	u8 revision;
+};
+
+static const struct vi_reset_quirk vi_reset_quirks[] = {
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x0190, 0xe3 }, /* Radeon Pro 555X */
+	{ 0x67ef, PCI_VENDOR_ID_APPLE, 0x018f, 0xc2 }, /* Radeon Pro 560X */
+};
+
 static bool vi_need_reset_on_init(struct amdgpu_device *adev)
 {
+	unsigned int i;
 	u32 clock_cntl, pc;
 
+	for (i = 0; i < ARRAY_SIZE(vi_reset_quirks); i++)
+		if (adev->pdev->device == vi_reset_quirks[i].device &&
+		    adev->pdev->subsystem_vendor == vi_reset_quirks[i].subsystem_vendor &&
+		    adev->pdev->subsystem_device == vi_reset_quirks[i].subsystem_device &&
+		    adev->pdev->revision == vi_reset_quirks[i].revision)
+			return true;
+
 	if (adev->flags & AMD_IS_APU)
 		return false;
 
-- 
2.53.0

