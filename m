Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF22045D91D;
	Fri, 16 Oct 2026 09:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141575; cv=fail; b=acFYn1doIQipZy4hSuyOcLqu6YnVet9Yue6Ni5e8/YINIAXnRmZQqGB9gsh3PyeboK2p1e4oGzrgDI7dD4iADDsrA4AKXpcJyKyQCYrj6J2KGIND1PSRKDZ+HAMlGmCWNmNelDmWYbdcAbMoh+PAeke5e9Hdr3cxy/ewQMRLBZQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141575; c=relaxed/simple;
	bh=eM8+fqbID1EXC4fEyOMHZJ08C09rhqGwqPw+jf8cxGA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X0wphBi00V/k/h+YyVFFIbgN5f6PuMP4qcuCqwuyU1n9SiqUwXV5k2tqVUgQ7JlyMo0LhWa7aF1xHAKluCUC4AO7YxXGtozLRtpuFvxTIJYzVyvcSMIsZ/KzCNm99vKTd23nWhUyHchlaVmOPcsUEK8D5RAqf0TFJ058HIGzE4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i7Ow1nwQ; arc=fail smtp.client-ip=52.101.193.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i7Ow1nwQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CPNFHTihy/TJxAB8rVOILlAhGOJFAgn898sZdLXAQ95rU5TSDoui/2ouvSLSAQhhsygqQysmpNRlGEt9Zp934X7Ae/0gHnRiaXEu3kXT/Lam32tUXCTtKqJOqrxU4O4DVFoDXqdxFYEMvITVlcrZOQP2p3wZnqyGu1T+6ql32owBf48CgJ1/SMnF1V89Fj4fSsGD9u3I9X2yO/OaD0Q5c3HTTZ8WocwZTJrKdyhLv3J95o80vJbxvNSuQT1+BkTGUN5sxk1vgjv4OmugoCFR2eMdJqj7dE7Ydr9l7VWlg4tNdX3NDJdP0UmWttWDkhWM9+dNb+meyJHu7wVOg5Zotw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xs6mxZa40BsJX3ZXEvWdFHxLaAKU1HWGNgkzPn7rVpw=;
 b=UFevS2q6zxViJZRE8G8hBltza1ASgyTS1ZoyjoMMVnO0S7hdNZz8WqQEDbABILMAWm2QtM90E1jUmAlvquP9HAtP61maOjMntcKrs+xnftAxyGTlKo8rfAj5PgzhuMgDm3KxdIv/S7HJ7UoY7ygmRlP2q+kmo/t3WK12rzhEsSa37jVkTvAABte80Jo05yBiIX44iV6gHelh8Q3y8geGr8isFptPHQ1r8eSzHWvsb+6Qw+0Jxx0MJRxxxmvPdvudtI+HH6/hqPeZ7HukoaYQOhwUONm+dG/3xZ+j+ASWZ0pWZXekdGNMroTzjPFzW4BiF0Qc/VMQyMWE2OThqNiYrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xs6mxZa40BsJX3ZXEvWdFHxLaAKU1HWGNgkzPn7rVpw=;
 b=i7Ow1nwQNDlCz48nA7fs/+TKSY8Yic0m1JZHDXriJfA7zTWZrpehvMvo/snD3d6b/vloaU9GvoYbItQj0fYg30OPgwemtglwTj2zKI9w7y2xa4wBvX0XqfnnUo41BHzZh41VQiavhZXz84OLrJN085X1dm9N8/cQrM5kNHQBtAQ=
Received: from LV3P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::31)
 by IA4PR12MB461082.namprd12.prod.outlook.com (2603:10b6:207:10f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.15; Fri, 16 Oct
 2026 09:06:10 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::23) by LV3P220CA0008.outlook.office365.com
 (2603:10b6:408:234::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 09:06:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC9.mail.protection.outlook.com (10.167.248.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:06:10 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 16 Oct 2026 04:06:01 -0500
From: Daniel Huang <danielhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <alex.sierra@amd.com>, <Philip.Yang@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Daniel Huang
	<danielhu@amd.com>
Subject: [PATCH v2 1/2] drm/amdkfd: disable SVM when the GPUVM cannot cover CPU addresses
Date: Sat, 17 Oct 2026 01:05:45 +0800
Message-ID: <20261016170546.88570-2-danielhu@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261016170546.88570-1-danielhu@amd.com>
References: <20261016170546.88570-1-danielhu@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|IA4PR12MB461082:EE_
X-MS-Office365-Filtering-Correlation-Id: ec502769-7902-42b5-376c-08df2b64b894
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|23010399003|6133799003|10067099003|22082099003|18002099003|13003099007|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	CZnEzBSecPFpl7+MZAlrxnJoJPUZPH1VhaNJEYiwvL/gFbrci500Yu75ISiXu5z3bXGqhNXy8YRWkPgrVA0d/tK10QVxjfrtW61hiOTigoU8/UpXs7lQ8+yZFNm3WdduMOwjQOa3QcPOmMFQPoRPfA3dKCrOpeHMr8noyOM3K2LzFDzMSc37KUUbscVZQqgu/+hE2otvXkfIz/Ir/Kh0xOG7htcC/eB2gs8weD5QPEv5fipV9/vgGTFxEUCIPTECu4X4fOSoPF1aWMXhMTa2SxQJYHIllWk2S8phmWrDWpiM9oatgXrFL/ySIe4s144wuEeGA1lLb9mcNVWkw1VN9l7CpS2H074CP4rTH2Y6HzbpkPKK44g7V4XIWzwcwXRD6z4l4k+QMb1PKG6C8voM5T07X/fxuaK8YIdkkVVw4q5V8vlLhrYN0NsQ5WGChcs6W/zRd0X0b/AYKVhYvwieS9CtoeR4zi/r3p61VvnWqO+U5EYaEF1AAxYLK73Dg3ex2Qi50TaVa6wEdo5CuKsvkmlEE+po7nvrZvYcTcJ+XsriXdBSVt/S4oxqGld5ajH1YGF2FJHt5WIUgePzG1d1RjQHActP2N15Utcd7JnswMAMheJJL+7hT2EUj8n/Sij+kq1C/cDLi6w9zdz/bEGrwEn2A6dSy22nQd3v8xrfEm0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(13003099007)(3023799007)(261009223027099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GJUPFX9jGWFPKhXK0EeehpTIpBqzulC3j/Og9fD3/l0ex4Pf0SoXEI46TG+KDuYSNbQureD157YRU5NaeTuoclLt2sHP+dtizdR0377IrCrjLKg8uOYQkGy5DJ24DwXyp06NW5rER3xpjKMOd0luSrf0ifEXeBQ6ONw2WLvAJWP2xeagsqOtV13ooA+rpg5x9UvS/hSBHFRTnwW6CcJfCXhtHThiYUCWwsUQSZKQ6F+BS8XRmgZVwjFZABj931bQ1fYAnYYfaah3hg8zEtBUZWQ49AOojyKIKuqBV8zRqCnBduQ/mCdnBHNeiDBaC2f+I6FmgWW2Q2FRtIYebQc6uda2PcQhUwK/aNd8tzQLCj4j41gE4IgASQWJf5/C8w+OTewDMm0fBNHqJoTMVUGNFEOX35MV2i7Cbq+Gq38217Aof1m1tHhLAkh+6rsm72gr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:06:10.2951
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec502769-7902-42b5-376c-08df2b64b894
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB461082

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
Assisted-by: Claude:claude-opus-5
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

