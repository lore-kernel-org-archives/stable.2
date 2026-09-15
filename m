Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA83A3C3BFE
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 16:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789488595; cv=fail; b=qPvtP1JaH28kvDih2wP7C2/zRxZKD3xYcTVUuL6dD6Gb2WUMs5Jon6wrxzoUe4ZniZL/7STlQyuwFhN2dFHxTw7xN/alADX07Im0sfNsWKE2gQLyKXrt8WHfFWKiuk/6XJ+D0jp9ASE8OUTtfvQ5WPfYo2EeVxwzdkwci8fGPSE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789488595; c=relaxed/simple;
	bh=J6aRXp5cgD9wqk2W3VxKvOSDAJKKq1tFvQFdOjEGgFU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=muNpcJQANBVVhFhN6V0h6bXnKbSd0hQgPqc9Anq25p2YDtOBPHz6DC7PDAwRoOxwCxQDwWh6DWzh1x+DghEDgmzwLQs6MgF271H38EPK1ONNpvZ/uoJO9cix3Ao0VhP2eUcMs/CfkunDWIZosiNPKu/8Ua65vLyq1Eh1j8BSYmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tUDga1J5; arc=fail smtp.client-ip=52.101.56.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tUDga1J5"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cQQu5fZlRrxO6dftnBrc4Zdh/3CMe41FMCCQLPsatQtGUnsjtDS/lnl+C5idYFiATgCRiqB/h73wWnFaYNZu12Mj4fPE4CTNSk7mzGGIb8Z3hbL9ymiXjYsvf9gmMqSvwkkOSBUq6PsbzMRDB07PMBgx0KXbOyItZ1+GCty1GdHKbGhcu4J0IrW7QuIq5SsV42MIOQSHFj4EAWiA0CH5YRaR4L2GLV+K6wSfNPIWUdy+Y05SvjWOBqDZRQmvOlwzuz0uavvF3zSk8tjwtewNsDe4TLWiOwj8/IfZbtA/LA4xpfF+CX/mJ/VZb9nUtLqVAGpqGVoHQ2g7ucX837/06Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tcsNaHRrYvPPwX29woGQjk78uCrvjt570VTVgMu/4kg=;
 b=aMzc3n1yBZomcCNP1bQcT0JXzqT+cWR+k3K+AX/L5knpogWKDx0QO/Q2/pMsun9wu0qCqhlcCEgD1Y9iQbt0ZgyrHw+aFRSH1kg2y+7hYGHObFlKhqF7UfKJMZ+MabcysjuA0iiXR3qZsOsieJg1ECG83KQfZbuLJz1/DZw4eknkJNRUQrKwNnJ3FzjERC2jaWHz2qArOGkkH41ml8jISum6ZRw6WefRyGLoMaFR4hTvAmqmxkMwQMk8VvBxsRPWYg7xKmnmkf2OYnh8Vgfd7n/vcbHw5o6F0AFIoda/CEqoDf3oYlag/mZnk7UQmDqA/36jerJiJmVvBZmHTI3b4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tcsNaHRrYvPPwX29woGQjk78uCrvjt570VTVgMu/4kg=;
 b=tUDga1J56Amx7kL1QK7u6aZZF/r8OrbaqxIEi/3+wMDLQAd4RDGBFZIGoE8JgzvyPb7b4ZY0uieAy+3jyw7bp+if7C2kt9dkjOOqetOoiNBNdfJWzTp0a0R7fDjWZyTLRe5kgR1uVLzaxU46BvapeJHNk1/j3k1/Ml0Qfcto9is=
Received: from CH0PR03CA0325.namprd03.prod.outlook.com (2603:10b6:610:118::31)
 by DS0PR12MB8562.namprd12.prod.outlook.com (2603:10b6:8:164::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 15 Sep
 2026 16:09:42 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:610:118:cafe::55) by CH0PR03CA0325.outlook.office365.com
 (2603:10b6:610:118::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.9 via Frontend Transport; Tue, 15
 Sep 2026 16:09:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.0 via Frontend Transport; Tue, 15 Sep 2026 16:09:41 +0000
Received: from aus0006770c4n-lx01.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 15 Sep 2026 11:09:40 -0500
From: Mario Limonciello <mario.limonciello@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Mario Limonciello <mario.limonciello@amd.com>,
	=?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>, Lijo Lazar
	<lijo.lazar@amd.com>, <stable@vger.kernel.org>
Subject: [PATCH] drm/amdgpu: Fix GPU PCIe link capability reporting
Date: Tue, 15 Sep 2026 11:09:32 -0500
Message-ID: <20260915160932.2118978-1-mario.limonciello@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DS0PR12MB8562:EE_
X-MS-Office365-Filtering-Correlation-Id: 09b5b8cd-09b8-45d4-7e0d-08df1343c014
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|13003099007|4133799003|6133799003|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	g0FC6Z/zoR7KWWiE8jXr0F0bcEPhuUUTC2PXl9WulxSUAWB+FgtU0qDC8dfhBj4Ib2e8jxOvjSffv4j/2GHtmHjSt1DUt8ElTYtRP+yVSB3flG/5AgdMogkiJ89iiJ5n2lJhNYDbnA6sW4Czqn9krBGQyLpGVTlX+g4rWkwf5hkTJo4aOtmyAxOsFpFWM9QuejC8pSjpfe0n01vs9S/R2XZ0PDstC+Tt5pEeQSaGLcLNH6nQlS4nnUkqMqtpjfMFNdGIPgbLX6nuEF88NYSuQq6aBHXEL7F8j4oHIiKSnZX2xP2tNZ1Ci8rwCpsG7E22sqd/Ubw/iLcNmOLkXmuP42RI4mEjMCNjKZ6lo3J2nIU+PjzmUMA/vmzbpEHT72jqIhoiU6Rv4MhA8q8xkOXsroIzjDRIq5GJrVATrIxQGEKBjnO/eXzvqn7Wp4qPdBkct2NFDT1XW4rNURpBcL+6voUpBFKZLg5Xk39EcivIl7QyQftGLQzGTxRNqKqzSnscBA6FE7jXXP8wKZafsy63IQWIEiNGgHjMrGc6qGIQS1wUgXJuyEgUG8t0mPTjlOL80nWH0G0GS2ETdHGFn65WHAeFgJA3WIE867ZEwlnJsxXy9nayJ7sv6QZwnmU0lDhnIz04hrBkieVcJZejmxkK6+kncYRWBt0NgnyqSI5r4QiCNKOygkK2daC6p0huz7M02AjatDA8jtC2gWyuQ9op1Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(13003099007)(4133799003)(6133799003)(10067099003)(18002099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	vhPvEe5Of7+h4450949g+tmil/+M2fY8JBm3rgYsgfqQbDxJghCVuTgVJ0oY51vriV+b79DkDcdSf8zidfI+fPcr2+CmMzoSQNRs2+fRovqlY3DMEr3JLBzyinFiajAQm6H+TVtS+zvmHbd5J/nDd3lFTfyi8idAWcVjh21xL2p88kGNRUNkSCnB1TvYDwmBi20LEWCtW+dMA/cOXv07Eegyxz6XzGCTyiHIHudG8Jv8j9GIZL35Byu/lIfIB0l0NpI0C9sXvnRLUViIs5lmsWhuU10Sw9q0CzVxg34HWSdekZK0QMEjEFq3pjPvuBGKD/bc3Xcl2GRXXQNR+k2+EkWLm8H6jPIOenSNUuao4MZ9K7bnejgsqFaBM1QpXU64mS7u4F/4OpaU2JMTNV+wMbh+zivTPsm3Pqjsl9bmwfsNlPAAVJqXMTHM6MUEHfLg
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2026 16:09:41.5777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09b5b8cd-09b8-45d4-7e0d-08df1343c014
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8562

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
Cc: stable@vger.kernel.org
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  3 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 48 ++++++++--------------
 2 files changed, 20 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 79b69d74eb2e5..3bad7b8f621cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -626,6 +626,9 @@ enum amdgpu_enforce_isolation_mode {
 struct amdgpu_device {
 	struct device			*dev;
 	struct pci_dev			*pdev;
+	/* The two ends of the physical PCIe link outside the device. */
+	struct pci_dev			*link_dev;
+	struct pci_dev			*link_partner;
 	struct drm_device		ddev;
 
 #ifdef CONFIG_DRM_AMD_ACP
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 44091ac12fa9c..0d277516fd55e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -1959,18 +1959,17 @@ static void amdgpu_uid_fini(struct amdgpu_device *adev)
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
@@ -1986,7 +1985,6 @@ static struct pci_dev *amdgpu_device_find_parent(struct amdgpu_device *adev)
 static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
 {
 	struct amdgpu_ip_block *ip_block;
-	struct pci_dev *parent;
 	bool total, skip_bios, early_full_gpu_access = false;
 	uint32_t bios_flags;
 	int i, r;
@@ -2082,10 +2080,9 @@ static int amdgpu_device_ip_early_init(struct amdgpu_device *adev)
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
@@ -3783,6 +3780,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 	adev->shutdown = false;
 	adev->flags = flags;
+	amdgpu_device_init_pcie_links(adev);
 
 	if (amdgpu_force_asic_type >= 0 && amdgpu_force_asic_type < CHIP_LAST)
 		adev->asic_type = amdgpu_force_asic_type;
@@ -5880,11 +5878,9 @@ static void amdgpu_device_partner_bandwidth(struct amdgpu_device *adev,
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
@@ -5906,21 +5902,11 @@ static void amdgpu_device_gpu_bandwidth(struct amdgpu_device *adev,
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
2.43.0

