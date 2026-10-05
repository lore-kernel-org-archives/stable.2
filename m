Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E8864A0133
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 14:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791210306; cv=none; b=oNpcca8aGuz2EfijifLy+nZrwpM7jgNRAt4RuCwoMZ6mL4IuxKh1vjJoY1V/p1PWxWOgEY+0XrkmmH9vkQjbA5m20EXB3dvoc807Acz47Dpvqqd5VIvDJfplvAJkjT+2e8euwvYH1HR+m67kT7R3JIHs6z1jtnQ5q+jobb0iRLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791210306; c=relaxed/simple;
	bh=ANUr8EB1IMGrC+TSg6e8HhCMttdLk3xGVNODeH45Gqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipvlE0atlMXMW91lzFwvuUSXZ3QYDUxIfhFnCgW2eamafj6EhIClv5Xm9AyVy7t4fSiYlEhfIONS4oLGEbcRvSm3SQqTgTQbIK66fa0XLx2us9YDbHP+r8BZKumPFk2FgDSCqp44y5zfoT1fCqeH7sRJGW6vwHHp+2j9k+XjoTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7wwWmNU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7wwWmNU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4350F1F00899;
	Mon,  5 Oct 2026 14:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791210299;
	bh=RN9jnd9BTQO99jvoCvl520b0zD8yUbALctAdVZ2Hcmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N7wwWmNU9oyWuaFXkEQcSdE2aCkeRXXeQMlOw7Fd1DQKWbiM77H40pR44hhppNefw
	 XdSjj5BABRds1ktW6VYH3/dvzqcO3En60EZ4nz63nN6S4fpBq2lzMudhdAIeIKtmzf
	 3zcfE0/5PO2XgSsSf5f4RHfym07A55CuEgxL54l4T5JPnm2jlRLkoY2JeMJ4g58dmV
	 8nXDyr4rAgoN/KnUEb1vJFVNNuRtkMfQzyGiPMvVjb+rohB4yWeuy+PNR9YaTs0KDG
	 KPiCVXXtOeA4sg0vu9Y5zHFbRHO7WxSljDniSHq8TEBJ1ULzWC/qlhidVFFfAHMKPD
	 P6+usELFTpCOw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Frederick Morlock <me@freddy.us>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] drm/amdgpu: reset VI ASIC on MacBookPro15,1
Date: Mon,  5 Oct 2026 10:24:55 -0400
Message-ID: <20261005142441.3002030-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100529-unstirred-endurance-7a1b@gregkh>
References: <2026100529-unstirred-endurance-7a1b@gregkh>
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
index 1bfd7b49fe9c3..c6f77e5207be6 100644
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

