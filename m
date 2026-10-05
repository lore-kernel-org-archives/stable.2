Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 570CD48986F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791207367; cv=none; b=EWenSSDLtcCYeOIR27axw5y1X42Dm27BdibcO5++VdWpLtt/a8r1Wc00IIQfD5hFwAbmb5vWjfX6hswximgDQSsrN/1Q2TYuCYjNMpSA5FDsq4Fw8pbmtAq4XJZq6VtrU4BgYA1+ulje9sCB2WD7zl5OnHhx7eJNrJwdY/dLcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791207367; c=relaxed/simple;
	bh=w8CLaTkSvwSNN+TMgBTelX7pAqXNpu6RpzMZcSRNako=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kYSVNQHTvTXhsUwhoxIATp4P9GTYWygZFy5ro0WMDZlTgGly0kuBGKXhG/4PRMcHrEIq9afY7wqh6C3qGh/8FsUCgbx7eAltDtC/5ggJ2BZ+2LhuuD+f/WxAlLn3DGne86yzbaCnL8ApyKtpxQdW6vCBebl9ReHOjIjRbtLWWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dMp3HWwb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dMp3HWwb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E98AF1F00893;
	Mon,  5 Oct 2026 13:36:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791207366;
	bh=4LNsEgKORRDi+5oBFLXT6PkHqeGN3cb8TlYrjTkV2KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dMp3HWwbJ6PURaIlSB4PHH0cN5x7Hw1ocgbQmu3gczJVh2DrBB0UzRZW84MTw0vEO
	 ZM+62uhOWJOVbv4S1b2dQgLcMqgGz30K+Hm0QhFGV0IxzojG6N26DX2cCkdC2xTnbC
	 zpkF0sAgKQeawhqvmkVF1PewL0AFKjeMYODNciJ3aw/cy4yofpvkhGuaIJvkptg90u
	 L8NdHckhlx5eWHdsxQ+12V8G/X+TsFQ95hEihjIg/S/vecnqXMQ6mhIzWbtO4VBGIB
	 iadFnyFupm12qaydvo9KsSZ+XgLEMWBneTantUPrUh9uPKh/sPao9in3fV+Z9yXkhA
	 vsAMM0c2me8Wg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Frederick Morlock <me@freddy.us>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] drm/amdgpu: reset VI ASIC on MacBookPro15,1
Date: Mon,  5 Oct 2026 09:36:01 -0400
Message-ID: <20261005133550.2858536-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100526-imagines-vendetta-1866@gregkh>
References: <2026100526-imagines-vendetta-1866@gregkh>
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
index a611a73451250..add3b30f8edc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1407,10 +1407,30 @@ static uint64_t vi_get_pcie_replay_count(struct amdgpu_device *adev)
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

