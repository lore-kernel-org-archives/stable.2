Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1138B4A5C28
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105644; cv=none; b=FtyUpSoLLouzglnliV55ScVNXnQfX8ibdaIZJEX089Lfi+Dcs+svYVOtfgSBDDvTAXGQyl8HygD5nON/fRvFyLocn9t+WjmpQTeJuyuSUrQWM9JmSle1OPo1NjzhRbeHZztfxZAfOT/i1hHaRETjNbpzszvhA9tRBOIWGcfUrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105644; c=relaxed/simple;
	bh=BbrU0ovAwjzr00C8/rcZDyQqkD7R7aOjCpH4YSu+5rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N6joF39SVeIU5B8yj4oH+lq9fn+kjypryuCZFLYLyKV1h8bbSUFjHdmJeSrLV+mse6h8musqiUoL4XaOxaVJNwrZZ32W/mbRbhBGem5/01Bl/xhUyb79ijPxhwJuqaX5sPHkqca15QLrYxQLJuSJfdBmh4eRjLQEsn8P3dQMth0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnMq4Qbu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NnMq4Qbu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBC91F00893;
	Tue, 22 Sep 2026 19:34:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790105643;
	bh=bBTkjakmAkenRG+gOix0L6f9KSo39sug78pL2rKJGnE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NnMq4QbudsW1laNrnLnCoJknCmtq2tTeI0HmjlznUFr4ME/3W0rWU4moCa2JBdnCM
	 TJoqi07cx3d/Jw8oCb1i+ZB90aWql0bFXzNL0Kk9F4tgWvtcR4O2l4bzvUQKRcAlyM
	 ZMVl4fk5kDxvsfQepmcct5nP2uSCN/3uLgnHuUYQIwbjhuJDTVzAbEFogEQ+btmLOM
	 CKQqu6tiOwL4QxFyOQgCb/X8LwQNWb4W9vFXy8urrdGc4pDF8VfQaJZuqK+0UOxr3q
	 llA569r4jo7xfMr5Q2hOOKJBzGB4N2Vfi0ajM+uGrG3Z6PBLmVzVtbPa3G/gHM2GXm
	 yva6XAFGwIf3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 2/2] drm/amdgpu: Fix GPU PCIe link capability reporting
Date: Tue, 22 Sep 2026 15:34:00 -0400
Message-ID: <20260922193400.4156340-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260922193400.4156340-1-sashal@kernel.org>
References: <2026092210-sprinkled-coherent-e132@gregkh>
 <20260922193400.4156340-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

[ Upstream commit 04de4007d32385b8b6a5dd72bff3146dfdc592c3 ]

Commit eb53125a7ad9 ("drm/amd: Add dedicated helper for
amdgpu_device_find_parent()") made amdgpu_device_gpu_bandwidth() query
the first device outside the dGPU. That is the host side of the
physical link, not the GPU side.

As a result, the ASIC and platform capability masks can both be based
on the host port. drm_amdgpu_info_device then exposes the host
capabilities to userspace, such as Gen5 x16 for a Gen4 x8 GPU.

Cache both ends of the physical link during device initialization.
Use link_dev for the GPU capability and link_partner for the platform
capability and _PR3 detection.

Reported-by: "Marek Olšák" <maraeo@gmail.com>
Closes: https://lore.kernel.org/amd-gfx/CAAxE2A4VhsAzzO1QjBjUg+NgnbD04ZzMyN6xsUJxjKJHH6hxiw@mail.gmail.com/
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Fixes: eb53125a7ad9 ("drm/amd: Add dedicated helper for amdgpu_device_find_parent()")
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 7ea6a47224e2c6e89a3a682d7fbaace4817a55aa)
Cc: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 48 ++++++++--------------
 2 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7b09410d6d8f0..6b0c1ad5a0534 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -822,6 +822,9 @@ enum amdgpu_enforce_isolation_mode {
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
+	/* The two ends of the physical PCIe link outside the device. */
+	struct pci_dev			*link_dev;
+	struct pci_dev			*link_partner;
 	struct drm_device		ddev;
 
 #ifdef CONFIG_DRM_AMD_ACP
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 5934fe1b295b3..0a4b1de315955 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2045,18 +2045,17 @@ static void amdgpu_uid_fini(struct amdgpu_device *adev)
 	adev->uid_info = NULL;
 }
 
-static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
+static void amdgpu_device_init_pcie_links(struct amdgpu_device *adev)
 {
-	struct pci_dev *parent = adev->pdev;
+	adev->link_dev = adev->pdev;
+	adev->link_partner = pci_upstream_bridge(adev->link_dev);
 
-	/* skip upstream/downstream switches internal to dGPU */
-	while ((parent = pci_upstream_bridge(parent))) {
-		if (parent->vendor == PCI_VENDOR_ID_ATI)
-			continue;
-		break;
+	/* Skip upstream/downstream switches internal to the dGPU. */
+	while (adev->link_partner &&
+	       adev->link_partner->vendor == PCI_VENDOR_ID_ATI) {
+		adev->link_dev = adev->link_partner;
+		adev->link_partner = pci_upstream_bridge(adev->link_dev);
 	}
-
-	return parent;
 }
 
 /**
@@ -2072,7 +2071,6 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ip_block *ip_block;
-	struct pci_dev *parent;
 	bool total, skip_bios, early_full_gpu_access = false;
 	uint32_t bios_flags;
 	int i, r;
@@ -2168,10 +2166,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 	    !dev_is_removable(&adev->pdev->dev))
 		adev->flags |= AMD_IS_PX;
 
-	if (!(adev->flags & AMD_IS_APU)) {
-		parent = amdgpu_device_find_parent(adev);
-		adev->has_pr3 = parent ? pci_pr3_present(parent) : false;
-	}
+	if (!(adev->flags & AMD_IS_APU))
+		adev->has_pr3 = adev->link_partner &&
+			pci_pr3_present(adev->link_partner);
 
 	adev->pm.pp_feature = amdgpu_pp_feature_mask;
 	if (amdgpu_sriov_vf(adev) || sched_policy == KFD_SCHED_POLICY_NO_HWS)
@@ -3863,6 +3860,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	adev->shutdown = false;
 	adev->flags = flags;
+	amdgpu_device_init_pcie_links(adev);
 
 	if (amdgpu_force_asic_type >= 0 && amdgpu_force_asic_type < CHIP_LAST)
 		adev->asic_type = amdgpu_force_asic_type;
@@ -6126,11 +6124,9 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
 	*width = PCIE_LNK_WIDTH_UNKNOWN;
 
 	if (amdgpu_device_pcie_dynamic_switching_supported(adev)) {
-		struct pci_dev *parent = amdgpu_device_find_parent(adev);
-
-		if (parent) {
-			*speed = pcie_get_speed_cap(parent);
-			*width = pcie_get_width_cap(parent);
+		if (adev->link_partner) {
+			*speed = pcie_get_speed_cap(adev->link_partner);
+			*width = pcie_get_width_cap(adev->link_partner);
 		}
 	} else {
 		/* use the current speeds rather than max if switching is not supported */
@@ -6152,21 +6148,11 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
 					enum pci_bus_speed *speed,
 					enum pcie_link_width *width)
 {
-	struct pci_dev *parent = adev->pdev;
-
 	if (!speed || !width)
 		return;
 
-	/* use the device itself */
-	*speed = pcie_get_speed_cap(adev->pdev);
-	*width = pcie_get_width_cap(adev->pdev);
-
-	/* use the link outside the device */
-	parent = amdgpu_device_find_parent(adev);
-	if (parent) {
-		*speed = pcie_get_speed_cap(parent);
-		*width = pcie_get_width_cap(parent);
-	}
+	*speed = pcie_get_speed_cap(adev->link_dev);
+	*width = pcie_get_width_cap(adev->link_dev);
 }
 
 /**
-- 
2.53.0

