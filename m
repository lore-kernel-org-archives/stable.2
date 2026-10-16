Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013041.outbound.protection.outlook.com [40.107.201.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5272E3A785D;
	Fri, 16 Oct 2026 06:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792133529; cv=fail; b=HR7jfBwoKZKsuB8YbXFw1geVA0hiby67SFdY3tRcJZKydhiHom6S1x4X0HwPHRFky5+cDW/FcxWUf/titJGhQVJMHhMpvbN67eLr/PeEbA6CM8HRrWTaUmMlCyKGiiXhh1gg2xtrozK5EzdomhX1/nQsMOPd8MQhXSpH8dfZB1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792133529; c=relaxed/simple;
	bh=FGB1riuyTsKXqAEGLZn+YVyR7wKXTrtPdePDWXHVqNU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pjeghuZpGhP6WBAP+0BZFMEupV43yM7xQk7sRoZ93NmV/j51cCY5+dkLJPSnYDkSytQ8PPEkSN8+FKxlKXp/cnIAxaxiLfIS9nqFNMtFKXrVwtvMcITY8ODSEKDOoLauJNhm2ATtpk70lywt0D0tOmE3i721OxAaWTvW1OVzo5c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JAT4qwXG; arc=fail smtp.client-ip=40.107.201.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JAT4qwXG"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXbqNvvNe1jh8N/PKOrVYR8siieUn07Sgx2Vii8zZQHFsmriUVDClYt8J9o5FV1fd5w/ZJtgaMJUpQdsVu6Fw1bjyMSXIxWD+Ct1hUdz2HrlUnPQ50Tpf9JWpwobrSFHtvSd6d24INuklJXLmywzWnHSkAe/fe1OJkER2HOePs3fojHt20bSzyePTuwd/u7ifJ+xLTixtveNbCK0v3set1Bg5q28PUPhK3ncDinbCwSRoTvfZlAcmaX74zWyIXTZA15VfUfRAlw5CC4zzo9Sp+k5T9/HgQ6iBqGTEKETZNG8s1/B0loh9SaFCspRNJynOSeIbaQfULlft1eZNHEIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ed62jcrSjphzHHtIlogIbWMAmxdh0UqTt53U+fczllY=;
 b=OfdGu1iZtRs4PcKzEUvtJpQZA0V6hYbb5/+9lzGw/vtO3p+B+b5s+NWx/AL/uRYFSW3c+66FgsGgS/2BSfp+tfEKAtRNObQYSmg6C44itN1Qfz2SzmxBKxUSbwV0Sw+Bfixg3nwHFkhAUj7pjt8PDPd3U6MCh70MSDzFvaQL7EJoFpX4m3ZUBlYKoOW+VFFE3oBfJL+YJsZSRHi/pZeVeUdvcAgAt53j4bswaZP8xOLnv94TpBYZ/h3IluGVk+F1iHOWBAVwE/N8WpRYlK6lAJ12xYR5rS1avSBpRYl8GCqODwJ6FEVGcNBOdOuklmOyU6bNRbQljb1gfXe2zjxHXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ed62jcrSjphzHHtIlogIbWMAmxdh0UqTt53U+fczllY=;
 b=JAT4qwXGHLdZVoINVTBoP+KaPOcSGnOMpYq7gsAC0atHzyTUoxxT2dfEabO3uTd2HBAdN/RZDgdEFZ52jTRYCnx8vpb7XDpU4Is9AJrQVfOAtH7UO0COaVpc1OhVEwNP/Ph6x+C0k+Fv1/mo1amqC5zGv8sYHaPYLTGRtXuJVpk=
Received: from BN9PR03CA0149.namprd03.prod.outlook.com (2603:10b6:408:fe::34)
 by DS0PR12MB8441.namprd12.prod.outlook.com (2603:10b6:8:123::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Fri, 16 Oct
 2026 06:52:02 +0000
Received: from BN7PEPF000000A6.namprd05.prod.outlook.com
 (2603:10b6:408:fe:cafe::92) by BN9PR03CA0149.outlook.office365.com
 (2603:10b6:408:fe::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Fri, 16
 Oct 2026 06:52:01 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF000000A6.mail.protection.outlook.com (10.167.245.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 06:52:01 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 16 Oct 2026 01:51:52 -0500
From: Daniel Huang <danielhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <alex.sierra@amd.com>, <Philip.Yang@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Daniel Huang
	<danielhu@amd.com>
Subject: [PATCH] drm/amdkfd: disable SVM when the GPUVM cannot cover CPU addresses
Date: Fri, 16 Oct 2026 22:51:29 +0800
Message-ID: <20261016145129.69645-1-danielhu@amd.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF000000A6:EE_|DS0PR12MB8441:EE_
X-MS-Office365-Filtering-Correlation-Id: a12bf397-3aaa-465a-6fc5-08df2b51fb52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|376014|82310400026|23010399003|56012099006|11063799006|261009223027099003|18002099003|10067099003|6133799003|3023799007|13003099007;
X-Microsoft-Antispam-Message-Info:
	kC4ggiO3U9EB3k5DFWibMAglywpu23WzuFS317jykxsRWaff2OsDsm74/wkNtBMajML4fRvtmGJlDpLv58/NGNeB2GCFvE97p3TXykwFBaacS9ye7B6oTujEu4bWpGrxbLbcNtTDJNsJinWaO6lVWzXMZrULQlRXLUkTDUCORDoGwpCj3mEFZjCo0y69NcEZpBg3HJ1RjtZvBtQmZcnsPdC/oAv23gOJHYY9I69yhUsyakj8NG4Kgpc8HiIqyi+cvtlOKkwaH2xF1G1iHyspucQvJHqB9LEyU5wpz1gJfgYE3a9F72TPpgVfdvCUaYiE0E3fmTrvfbGs7j/C3BrlQO3j5mCXn+eEtH2OapglVY8ycZYy3FQ8b8IlfZ6VwvPkpQQW0FYfPksHyMYOlohMOZUEjff24IsevDLTCKDX2/W1zugO4IfEJPxphURR8hOZUzndodCfiirnysZyqMmpwiZHklGV+UYIXGe0aqVNsZSBsf+SMy3e4ud3WTdtQcvvJXgduRlPEzyYRZJFmvxK23dDzMq2xF7cMyaah29HObVwwbpeY56rNMAvD4covYc3qbjuo0uwk+KvDDRWdtBFzP2LsDMvCOMbIhZcIf8qaTllRMU5aiIhp8A42wGNFmUVOPfdkHuZesHakcYRcRYywA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(376014)(82310400026)(23010399003)(56012099006)(11063799006)(261009223027099003)(18002099003)(10067099003)(6133799003)(3023799007)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xdA24JGafpRcEYlqPIRH6+cW1vzhk9jhSpaHBdTHR7QxSOxcS2qUY280QD8Q9Ct7hFpeixIsaSDFl7iSC7cvxCPQd/fkICEtYyipjrXEMsZocmKSG1DQKajOOqAEMtfnV0uE1pR8m6BROj4AzGk/dn53XmtbvHmIIjTUIh510NCGYVH+7eoriNvSmvBlWA3snu3IpkrNlT7aowEnkzBe8l13sUSWBt3BHsRPy9QpHcRYCJ7XyKu9thLlyTG4XfbyxWzf2wmdmQbAZ9D4D7e2WH2jp6AFiPar/rDz+haRMfvJ+kXkrvTcYchNSnkPKGYCsC6X1sjRygG5utlQipONxYm6Ht489lREEHwJ67Ioj/Je/mtx23BUIttVmYXn+DqJMDFpbdAdrN5yF7l3cBS/z4wGFSSJ3BkmhlPA0ZBPi9yfeBgkEPerAr5zK24SF3WR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 06:52:01.8336
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a12bf397-3aaa-465a-6fc5-08df2b51fb52
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF000000A6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8441

KFD SVM maps memory in GPUVM at the same virtual address used by
the CPU. However, svm_range_map_to_gpu() passes the corresponding
PFNs to amdgpu_vm_update_range() without checking them against
vm_manager.max_pfn.

If the GPUVM address range is smaller than the CPU address range,
the page-table walker can index beyond the allocated root page-table
entries. Unlike the SVM path, the BO mapping path validates the
address range through amdgpu_vm_verify_parameters().

An explicit amdgpu.vm_size override can trigger this condition by
configuring a smaller GPUVM than the driver would normally select.

Reproduced on a Radeon 780M (gfx1103) with amdgpu.vm_size=64.
Repeated hipMallocManaged() allocations attempted to map CPU
address 0x74bd48000000, well beyond the 64 GiB GPUVM limit.
The out-of-bounds root entry contained SLUB poison with
slub_debug=FZPU and recycled heap data without it, resulting in
a general protection fault:

  RIP: 0010:amdgpu_vm_cpu_update+0x2f/0x140 [amdgpu]
   amdgpu_vm_pte_update_flags+0xfa/0x1e0 [amdgpu]
   amdgpu_vm_ptes_update+0x38b/0xa00 [amdgpu]
   amdgpu_vm_update_range+0x279/0x930 [amdgpu]
   svm_range_map_to_gpu+0x13d/0x400 [amdgpu]
   svm_range_validate_and_map+0x8d3/0xaa0 [amdgpu]
   svm_ioctl+0x66/0x80 [amdgpu]
   kfd_ioctl+0x40a/0x650 [amdgpu]

As discussed in [1], rejecting out-of-range PFNs in
amdgpu_vm_update_range() is too late. SVM must not be initialized
when the GPUVM cannot represent the required CPU addresses.

Prevent this by disabling KFD SVM support when the GPUVM address
range is smaller than AMDGPU_GMC_HOLE_START. This prevents
affected devices from advertising SVM support and excludes them
from SVM mappings. Warn from kfd_update_svm_support_properties(),
which runs after the device memory pgmap is registered, so that
only devices that would otherwise have advertised SVM report the
loss of the capability.

[1] https://lore.kernel.org/amd-gfx/da43b0e3-5bd9-4aa1-86d3-b733f3bad108@amd.com/

Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
Closes: https://github.com/ROCm/legacy-rocm-build/issues/6691
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Huang <danielhu@amd.com>
---

Tested on a Radeon 780M (gfx1103, PCI 1002:15bf), kernel
7.0.0-38-generic, and ROCm 7.13.0-2.

The reproducer performs 24 iterations of hipMallocManaged(1 GiB),
hipMemset(), and hipFree() per run, with 40 runs per attempt.

With amdgpu.vm_size=64:
- Stock module: kernel Oops within approximately 2 seconds on
  every attempt.
- Patched module: completed 40/40 runs in two attempts, with
  stock and patched modules tested alternately on the same kernel.

With the default GPUVM size, the patched module preserved SVM
support, emitted no warning, and completed the same test.

Two questions for maintainers:

1. I interpreted "SVM must fail to initialize" as disabling
   the SVM capability for affected devices rather than failing
   KFD initialization or rejecting the vm_size override.
   Would a different approach be preferable?

2. This check also affects GMC v6/v7/v8, whose GPUVM address
   ranges cannot reach AMDGPU_GMC_HOLE_START. Although these
   devices do not register device-private memory, an APU with
   apu_prefer_gtt can currently advertise SVM support.

   Should the check apply to these devices as well, or should
   it be limited to explicitly configured amdgpu.vm_size
   overrides?
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h      | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdkfd/kfd_topology.c | 14 +++++++++++++-
 2 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index c7d7adae4476..6235ce0f988e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -203,11 +203,25 @@ struct kfd_process_device *
 svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
 void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);
 
+/*
+ * SVM uses CPU virtual addresses for GPU mappings. Disable SVM if the GPUVM
+ * address range cannot cover the required CPU address range.
+ *
+ * The parameter must be named adev since AMDGPU_GMC_HOLE_START references
+ * adev->vm_manager.max_level.
+ */
+static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
+{
+	return (adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT) >=
+		AMDGPU_GMC_HOLE_START;
+}
+
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
  */
-#define KFD_IS_SVM_API_SUPPORTED(adev) ((adev)->kfd.pgmap.type != 0 ||\
-					((adev)->apu_prefer_gtt))
+#define KFD_IS_SVM_API_SUPPORTED(adev)					\
+	(((adev)->kfd.pgmap.type != 0 || (adev)->apu_prefer_gtt) &&	\
+	 kfd_svm_vm_covers_user_va(adev))
 
 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
index 35b3abe57b80..5de19fa27d12 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_topology.c
@@ -2471,8 +2471,20 @@ void kfd_update_svm_support_properties(struct amdgpu_device *adev)
 				sys_props.generation_count++;
 			else
 				dev_err(adev->dev, "Failed to update SVM support properties. ret=%d\n", ret);
-		} else
+		} else {
+#if IS_ENABLED(CONFIG_HSA_AMD_SVM)
+			/* Report it rather than letting the capability
+			 * silently vanish from the KFD topology.
+			 */
+			if ((adev->kfd.pgmap.type || adev->apu_prefer_gtt) &&
+			    !kfd_svm_vm_covers_user_va(adev))
+				dev_warn_once(adev->dev,
+					      "GPUVM size 0x%llx is too small for KFD SVM; SVM disabled (amdgpu.vm_size=%d)\n",
+					      adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
+					      amdgpu_vm_size);
+#endif
 			dev->node_props.capability &= ~HSA_CAP_SVMAPI_SUPPORTED;
+		}
 	}
 	up_write(&topology_lock);
 }
-- 
2.53.0

