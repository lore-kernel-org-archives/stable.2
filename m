Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3750538757B
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 15:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790089974; cv=none; b=sBAcvtgUQxigJPv+A+tGb2SSZb9gmG1eqyYTlGSiV2mjoLPFgWl0CHEgMNsUmKtfK20hLkxobUHQu67W10TZfYAFAoLqFZFgVPcAHltDUND+/xmQykQPSoSzzWT/S1cK2361PJPcuTfnTvJxgVO0ZWOiwxPPhirhMSN1XWbE3Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790089974; c=relaxed/simple;
	bh=Vt5INrsJXLby2kL8h7v2YX5QAK+vtKv9qyh7SAJo0pI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=a0QFg+0DlrY4+6sdqX8qgAN/XPs0APaThXZL6TJ8R3jVtoGbrfreXa7CtTAg4f81QJ+jEjnvDbVGh8X8nRZavGcPceFoxbjsPPBGA2ptK2alaHT6of4CeRBFMBzWx95vYjIFiAUg8jY0yHvuqA3ChMJpjgJW8bnKAoi+CTuFkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ge5rz6hA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ge5rz6hA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6951F000FF;
	Tue, 22 Sep 2026 15:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790089973;
	bh=4L8tB57176hXJqmMzqV669z5PEjx1jYreMHJeXocvAI=;
	h=Subject:To:Cc:From:Date;
	b=ge5rz6hAWkquQBmbbKpyAl3kWP5zbi7xkxzOXmiWGBCHf10bqrdfQhJpgJndzNprk
	 hor8hac7LjzFLprxw0cXHfJAJ47UwPOqf66L7McjkWE600sO5UuDSKu0cefV4RpULm
	 vRNgeTNsHQVaeOVrcbfSybsh/menFOE+w0uzBOlM=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Fix GPU PCIe link capability reporting" failed to apply to 7.2-stable tree
To: mario.limonciello@amd.com,alexander.deucher@amd.com,lijo.lazar@amd.com,maraeo@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 22 Sep 2026 17:04:10 +0200
Message-ID: <2026092210-sprinkled-coherent-e132@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.2-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.2.y
git checkout FETCH_HEAD
git cherry-pick -x 04de4007d32385b8b6a5dd72bff3146dfdc592c3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092210-sprinkled-coherent-e132@gregkh' --subject-prefix 'PATCH 7.2.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 04de4007d32385b8b6a5dd72bff3146dfdc592c3 Mon Sep 17 00:00:00 2001
From: Mario Limonciello <mario.limonciello@amd.com>
Date: Tue, 15 Sep 2026 10:59:45 -0500
Subject: [PATCH] drm/amdgpu: Fix GPU PCIe link capability reporting
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 7974f9b7944f..a9c6f5d4a639 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -621,6 +621,9 @@ enum amdgpu_enforce_isolation_mode {
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
+	/* The two ends of the physical PCIe link outside the device. */
+	struct pci_dev			*link_dev;
+	struct pci_dev			*link_partner;
 	struct drm_device		ddev;
 
 #ifdef CONFIG_DRM_AMD_ACP
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 104d1d2cbad9..933804349dbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1954,18 +1954,17 @@ static void amdgpu_uid_fini(struct amdgpu_device *adev)
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
@@ -1981,7 +1980,6 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ip_block *ip_block;
-	struct pci_dev *parent;
 	bool total, skip_bios, early_full_gpu_access = false;
 	uint32_t bios_flags;
 	int i, r;
@@ -2077,10 +2075,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
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
@@ -3776,6 +3773,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	adev->shutdown = false;
 	adev->flags = flags;
+	amdgpu_device_init_pcie_links(adev);
 
 	if (amdgpu_force_asic_type >= 0 && amdgpu_force_asic_type < CHIP_LAST)
 		adev->asic_type = amdgpu_force_asic_type;
@@ -5872,11 +5870,9 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
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
@@ -5898,21 +5894,11 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
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

