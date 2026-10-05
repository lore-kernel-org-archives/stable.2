Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88584A2618
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210865; cv=none; b=bQx2x61uHOJno6xaQhDEqcTFWur3piHxA5UvuJIRey5WHyUhit16ESXXTIKnU6AaByvDjojdxzN/ZNE0JTWlV3I5agixeQbSA1PG+xNuveegtZCTcGWyp3x4d1sSbtNs47GEtJDfteesjkxwRidZgldhK+vTx2TqHIzgz9lFLBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210865; c=relaxed/simple;
	bh=0+xXGXrVKxHH8pfKWeLz85u9laS+ZKeHTdp0+kxFGnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nTff5uyq6DcLK+L7UQJXBs5RYPoEsTS8ofnc9Ri01pi9Y2eZXPiqBA6198es5ZHG+avEw5yrArMj//yN3blTjIORbLKvq9g3iAez1Xb913KgNxl6Yfkt4ssDDLGZhXnFU6+tyT5YYCFt3ezT5S6MjaJU8ReM2+qaqj2H3bH8YK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWlUfjk0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWlUfjk0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD9A21F00898;
	Mon,  5 Oct 2026 14:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210862;
	bh=Z+uoihT9ZLmVgMetXw89J6+sLfLUbCRIyntLoUBjJLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BWlUfjk0MO/XHLqy7sMDX6vueeKovrWqPsSwBwbNFNVAY9KBBn2AGSf4N6UPGJerl
	 jQGcAIaYqCaYBHZqcmYXP1O6KfXJWDsAUX+zlm+ep4eayN0X79X7jGhLZWpOBJKCtr
	 ZeKRq98tAohA34iNzJPBparbOi7NFcJ1TfOU8QWqQEUIGldxusufpkGTk60RrJxi7Z
	 137r7cQT6ynwwcOZGZL3xaeblruvWpngeZCPaF30R61pSyFfDhnPzuFnD8OBZnHiMa
	 5Qd69aV9LOeYar0H4fQbkCV2fQx69tmzPdgG82jKzOrYxEattq9s/2I5JHHLQ9Vye8
	 SV8n0K+xr4gvw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Frederick Morlock <me@freddy.us>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] drm/amdgpu: reset VI ASIC on MacBookPro15,1
Date: Mon,  5 Oct 2026 10:34:17 -0400
Message-ID: <20261005143404.3017125-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100530-delay-deceiving-2b8e@gregkh>
References: <2026100530-delay-deceiving-2b8e@gregkh>
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
index 6d64d603a97a0..c394be0ac5fa7 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1432,10 +1432,30 @@ static uint64_t vi_get_pcie_replay_count(struct amdgpu_device *adev)
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

