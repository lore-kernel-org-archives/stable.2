Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E777C44A3F1
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791208087; cv=none; b=IuAQtuqpwwfitzT9cTZ38djD8wXcRQAJ04rIHq1kZhABPOuX1l6BCzIE5AkEByvBRj6rcn+SP2QhzaB8QHs/026gz+XpHunYDHPxbr+XpKzhPsJzZW8GqnfB4zi8zSG2tcPpWbaYpKhOJi2+rusIu1cCs9l5pCU+lEBAbvNZ2FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791208087; c=relaxed/simple;
	bh=/8KAmwsu5QB6uzwRw5JLi67U9Y2n54uBDhI8Wpg0ZJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOM4yv6fvpHr/9R2EPPD86dj/TfJPQ59J8QLnVU9+OykHSw7m0NDquIGEtkTmvmjvnBQXt0wwjNu+wNZYckQx0qrIa+7IpzF/dYYKl3NvDNLBnbNn/qbnxPJ+G8kjoHZ6FpGf5s/CHx5lbR1/DilnA7SrWgOQX5iQjFDI8wDtT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ct9FUKZU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ct9FUKZU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 206561F000FF;
	Mon,  5 Oct 2026 13:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791208085;
	bh=nZTUdTST9uhRTX6gHSSNl1TtvLwzh9fmtAZtqTLu8/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ct9FUKZUVcmThDpMuYinwGFCNXP+nmvbiZZR8TSxmM3MniXwOJL00l6BvBGwSwc5L
	 eigE5q5sPXzzqoIAxQZcOF68/BgF2DmW47sEeBmnw/YnHNl9b49gsx5XP0RapRnOYc
	 A1v6HlnNIGNlg8RbPJzX/yQBn4E3fTtbqYQhH/7ry/Zp0ZbLU2DMhWJFyfqyPyxyoJ
	 NRiqhyk7eKbdw1k41Esu3xVa3eeeBBY608Td0YQDwnBJucEURHV95bNhujPUm7BuZy
	 s+rc15AuRHeBNS1lnbHzfLINPfBZs7af7RJbVWim5lwSIze/OElNHiIEqXGZg71TtR
	 x9ycHxMt53ZlQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Frederick Morlock <me@freddy.us>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/amdgpu: reset VI ASIC on MacBookPro15,1
Date: Mon,  5 Oct 2026 09:48:00 -0400
Message-ID: <20261005134747.2967537-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100527-zealous-puzzling-af30@gregkh>
References: <2026100527-zealous-puzzling-af30@gregkh>
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
index 80d06a7c1db7e..012edca8517ae 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -1408,10 +1408,30 @@ static uint64_t vi_get_pcie_replay_count(struct amdgpu_device *adev)
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

