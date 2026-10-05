Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09DF04BB283
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 15:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212526; cv=none; b=nfWxbUu0GlNjcEuLWUm2edONXuu7BjF2QwhorsXQXeZ9RBKFn7VSxJle4a3zAWh2sFF3hw7JRthZAmyOBFpkSLkDfhIsqwegLWvOqJ1Gbr6BT4rdmtdZhsWcMs7TSlhkL0MGNLuOsh4ev+ER60KqRMhwkTfIQmKG3FNb1hc6te0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212526; c=relaxed/simple;
	bh=bZjjr54Q/oxdRNtOISVh7Nwq8yV0yKX6RftZHPHoFgk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjP/h8EztFn4PyZdGGRWuiM2d4HgdSf9Iqr+qCEMHkHrpsZT+IrdU1kYhOwe/D3YgtBUtSzPbAcDh3x3gCj5x3MZwUz05sqGeOhI8mP0rg3ei88kbTVPSqInBXdlkwCKFV3z8J9w9rOlTpozQV5dIz2LrvZHB7gvC5QZl8qiCKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CbBycsqd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CbBycsqd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6C81F00893;
	Mon,  5 Oct 2026 15:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212524;
	bh=pxync+ER/HicMdR+lYxcZAbRHJL0b40W2+wXfqPKRBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CbBycsqdZ1mB+AEztphCV1zJ3RCOZkVJhmSj71ZmfOtj22PJ34yKwPA8nurKW345U
	 LukvE2AOXQczMOnao3lBgHoqVAP6b6B+MIBsTXJvKA8y0hvV4kkgnnk+wxP30l89AT
	 uGcR1nRyafzIfclE4vC7Ry9NOTACwDGPQO2GGLe2hmyBg1vzh+wRC8xXXWO3ZyBxhV
	 TiXPv1Shp5I+qtuT2jxcALykuLmDrLrKI0FrTtyaj/G/MXkHYg7SuoT7pWE7W1hzzY
	 8lXiwU6i2Nne/9L54gNcy3GUdlubkpMnwlv3jYhoCw66bWjRj0ZN/SW/aMust+vqsb
	 fKN1C2R0IG20A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Frederick Morlock <me@freddy.us>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] drm/amdgpu: reset VI ASIC on MacBookPro15,1
Date: Mon,  5 Oct 2026 11:02:00 -0400
Message-ID: <20261005150142.3024473-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100531-defraud-otter-4082@gregkh>
References: <2026100531-defraud-otter-4082@gregkh>
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
index 2e030a308b6e6..39c51dc897879 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1058,10 +1058,30 @@ static uint64_t vi_get_pcie_replay_count(struct amdgpu_device *adev)
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

