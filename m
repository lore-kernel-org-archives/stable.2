Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61B347D935
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 13:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791206611; cv=none; b=NZbp2rvCOrpFmFwVkUHRUK7mOsNQQxkmOHLOYYrC4V/pimRymhBHtgjU41hnJNVShZ7CuXPKu+1LIV6KQh4OVVP+xy5GvxgJZ1Wel2LfEfMHqyOZui3aF5zjuwu9knl/rWPVXBRDXkqE/HROjwXGJSVGdQ9j/ffM7ZNSFQbxE/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791206611; c=relaxed/simple;
	bh=gI8o6MP+5RiY9CXPYhdlU512m+M+/fsxUd1sSEANTY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QvBUnkpKzsU4RBmfM/Jxq+5I+4/S4AjZ/sqGOxuW1CM/yIV7R487xfg9ikm8sr/9ovWcAGgPmXBBDWtXiVIysmLB3nTeqew4wo1iCoHnogmXy5zZyXp6Zy2f/bYT8pDrBQlwmKdvPil9+UV2/hnH8IKufghGiSPwK8tYw01FLBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=foEgahFB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="foEgahFB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 223BB1F000FF;
	Mon,  5 Oct 2026 13:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791206585;
	bh=KP8KVHdScN5MscbWxQTcoZnvFW9pOwJRp0vp+LtGjZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=foEgahFBXKRTKwMmC4rKG/XPPuK0LtAzXPAxQtJt5axQuhcKfBafpihZntuVh4LEx
	 6Qxkc14tq2FLs/QwHm5LidTAU07F7tGACh/sefDF9uPz0h6U+ccwev92nzMMeY7s7X
	 bPB86dZ3LogshHch1hcbGnFIFCoJfREh1iwLjfNN2JfrbUgd5WgqaruY1NmvgE9Lnc
	 HdD3yGw4TbKMM/RA4jXUn8ihSI04qd0cmxOnfF+NVUoYxMeiCnpKppEzH91R7Iru7Q
	 RQhmRai0LTvViyhfO2Xl4pdD1E+fQ5q4brejIEwarMfocl9tzc3WDhu37ilxtJXHQ9
	 6AROdQdslIF2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andre Eikmeyer <dev@deq.rocks>,
	Frederick Morlock <me@freddy.us>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] drm/amdgpu: reset VI ASIC on MacBookPro15,1
Date: Mon,  5 Oct 2026 09:23:01 -0400
Message-ID: <20261005132251.2627312-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100525-showcase-spirited-0675@gregkh>
References: <2026100525-showcase-spirited-0675@gregkh>
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
index a256320b92f33..320c43143e5d3 100644
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

