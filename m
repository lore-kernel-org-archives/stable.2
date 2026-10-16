Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BA945D91D;
	Fri, 16 Oct 2026 09:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792141601; cv=fail; b=jAmPJPjDx8syfCAGE1rydNz1lXUsQbx+/EmzVEftPijZieBWh2vEr30RMDOuUvbwJnwtoWxwOWbK/LdXpehWA1jeWByURuowAaF+XhlUUfsxFoRXjJYeNtLyDFEsW8aU6eKp16GSA6We1ALlcMRBqrhJYXLmBTII6RJShwM2ZTk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792141601; c=relaxed/simple;
	bh=OSWsIzlUJ53ggqeT6kdouQ7n6XuVmGCrSN6lmU4lF3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KUXfGqQm8WOBsMyZVwwJjYCOVmU2otWOK04K8/pI7MOIrYNrxe7wa5sUDGEABx/FGLmLmHHHCYZGDq4QODYHMmv3jUm+X/jGC/s+OvyiAwVQfU2bBl3GX9NUVuJ6BrT4PxSLJaIGBbOxmIXL954diL4kRj8HCVegE6Rmns4JoVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dLdmNZS8; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dLdmNZS8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PxSCOfFHWD4++2Snbup3XEIurTn7fJ+oFys3iQzo/63RQ3MsagcpfQyG0z+3CKjLkWWDde6wWWd/Tw8CX0EZoZ7tGZ+9L/2Bh89cuvZq+8P4zSf9PSDQG0O6DS1rDhI4Zp2omt0hmoNNZusbAlAKNU3h/NXZPvpEJTAUSunQvB23UabDN+5irrklWEHadtLPcmNlMawojuDDGNG+QF/UEifgSCH5e4KjU7guZtogKTCeyKQggNNJ/xuDuOOvIFVhPa0YDjLgXyyQVC0Nk2b6WoD0nRc0qODrr/m2GbezMCrK182UsPvi9q7VtwyA72XqCSeWngOBDdboavPDN3uMPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=67Qd+Hn3mlFECaHiNwH6YdnrkC8NFKlW9e2afFBUp14=;
 b=uUSJSPvojYlrQIrTULnb7NLDHpb+cPaexcl/5AaHX1/ZhfXOAi2zkYQA422WJqasasdbi3hSDBgCpdooY0ZsEtkTjVoh8mO03TL9So9K9d3QmETpyx9YeVUNJiU13hvNPpHlgqP6LmJUXC4YkWqnavmTYajKeXVb8355ohSJZtUsRFa5ENbPqJKlPmyWpOSz/6ioJryhiinWKi9HvH3E6773zgkBVyd6sNEPd5G910My4z2epPTdwQeMa0q6YNfrBaqObID13qV1XQMknxHZj9KZUOjlF5S5weQ0IBdtj1UOyObQoHUoBDLgsJw8wdlq4nHubiGp0p+cYLhKkgUV4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=67Qd+Hn3mlFECaHiNwH6YdnrkC8NFKlW9e2afFBUp14=;
 b=dLdmNZS8lK4fXaHqWTijQwyd+mpOpg1iSTIEuo2nOEpqhCQEiY3MTe3x/pSM5AHQDLzMLlzhWGEOWhplXBRoPextB5nbwLtwgxBfxKGw9UCanLaz/HIlxxGgKihUSvPb1BlcGJVid9sPya5ZWU9tFDrnadEgh1cpP73Srq29grU=
Received: from LV3P220CA0025.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:234::35)
 by MN0PR12MB6198.namprd12.prod.outlook.com (2603:10b6:208:3c5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Fri, 16 Oct
 2026 09:06:16 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:408:234:cafe::63) by LV3P220CA0025.outlook.office365.com
 (2603:10b6:408:234::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 09:06:16 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC9.mail.protection.outlook.com (10.167.248.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 09:06:16 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Fri, 16 Oct 2026 04:06:07 -0500
From: Daniel Huang <danielhu@amd.com>
To: <Felix.Kuehling@amd.com>, <alexander.deucher@amd.com>
CC: <christian.koenig@amd.com>, <alex.sierra@amd.com>, <Philip.Yang@amd.com>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Daniel Huang
	<danielhu@amd.com>
Subject: [PATCH v2 2/2] drm/amdkfd: validate SVM ranges against the target GPU address limits
Date: Sat, 17 Oct 2026 01:05:46 +0800
Message-ID: <20261016170546.88570-3-danielhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|MN0PR12MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e4213e-80ac-441d-027d-08df2b64bc70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|10067099003|56012099006|11063799006|5023799004|261009223027099003|18002099003|22082099003|13003099007|3023799007;
X-Microsoft-Antispam-Message-Info:
	Xxa46185TpWuNHXvJzbI93E3oTcaND8DubtwGQhmy3J+eljT55GxoB7eevoL1nduN5oQONTdaoqK4PQtkyGiIgZ8xEs+r7aNMpDgiJB/t8JL20KZ47HwKcewodH36cmqF2jYJYLDpqaPd/yumwxCZmTbf+EtQqgK5SlBVcnO7v+VoeHMoHWTCBCqR4JdLcszqPc5U6OOEFnvnRM5Tf6X4GrE3wtDHnbVpSpIGwJdULccA7EuEm/BUY+6qQULyvHQiOEsKQ9siWMReR7/cbHVoSyXcLyDL89977olL+FjbEpI5v4f/A1om8bFfmgUp+MEqkz3p4BmG+fUPRztPz0qAzuJxv6hN3Xduj2ujwQ+pKOFmInFgDD7j+5qlH3sH74oizsUT9IO6veeASKWwfCEQfaQA+B2b6RQKCq0KB2vNIzJ7dNjY87vkU3bOWt5zAPqs+PT3o+lpTOl1CC3fwwQmlcFg8r04oWrC7yqYVm/bcEfGOnn4vO9ITAm7YkkfixszpK3AjPnCIn5kisMZ0sxxhRXOS/cRnE/Qc+PIWKeRCAoFK4+BDYVy+OtbdoRM823DNVT1iN+rDnqziZI9Zn3xxL8cNuqSYfk1oNTYdAWlmjBpoPrrHZnk1J6a5fnLAjmg3z/mPv+FILeq5Kkj98xnw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(10067099003)(56012099006)(11063799006)(5023799004)(261009223027099003)(18002099003)(22082099003)(13003099007)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ylaB23IPecu0XzTFNfeDfoU4edbixeqj44sw2z7VKtDf65S3bhLNb2WIEB38NkH0iLNKLXvh6IJD5xkP/iOdaSTxNegYmzHfaMX85h9p+Lzxec3cfcsByHpMbP0gvGRytM7XRiqapeEj0OdgQcnNN/4PI2FR28cch2b1pvotdj6ksFitkSKO9DY4fgtxbMVnhYH19WzYkRTR9VQ7CQ0ANdN0WGZRRPb960mlB3HwIpS6yV2vkmlzzGnldYuJYTUb8Nb0BJTVb3O2BtB0MQqL9SFCRRmTqktc5a9icmt2JvoxuSGv+lu5ro4BQwC1qmllFcOjSreD8rtAysDhp4DFrolv5D6HrNwIRTpAQ3cYWX1zz61LWo6tzJF1zZOCjkX6YJTk38BGkUpxJGbpG003xpgskGfjZHFGmJ3sA0qktsvDputG4QA7PsQ3x8hlRySj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 09:06:16.7650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e4213e-80ac-441d-027d-08df2b64bc70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6198

KFD SVM maps memory in GPUVM at the same virtual address used by the
CPU, but nothing bounds that address against what the target GPU can
represent. kfd_ioctl_svm() checks only page alignment and a non-zero
size, so the PFNs reach amdgpu_vm_update_range() unvalidated. Unlike
the SVM path, the BO mapping path validates the address range through
amdgpu_vm_verify_parameters().

Disabling SVM when the GPUVM cannot cover AMDGPU_GMC_HOLE_START closes
the case where the GPUVM is globally too small, but it compares the
GPUVM against the GPU's own address hole. When the CPU address space
is larger than the GPU's, the comparison succeeds and SVM stays
enabled while individual addresses can still fall outside the GPUVM.

On a 5-level paging CPU with a 4-level GPU, mmap() returns addresses
above the GPU limit when userspace passes a hint above
DEFAULT_MAP_WINDOW. Passing such an address to KFD SVM indexes beyond
the allocated root page-table entries in amdgpu_vm_pt_descendant().

This gap was found by the Sashiko AI review bot, during review of the
first patch in this series.

Validate every range against the limits of the GPU it is being mapped
on, using both vm_manager.max_pfn and the GPUVM address hole, and
check the end of the range rather than only its start.

GPUs in one process can have different address limits, so the range is
checked per GPU. svm_range_validate_and_map() skips the GPUs that
cannot represent the range instead of failing the whole mapping,
matching how it already skips GPUs outside the XGMI hive.
svm_range_map_to_gpu() keeps a hard check so that no out-of-range PFN
can reach amdgpu_vm_update_range() through any caller.

Page fault recovery is rejected early in svm_range_restore_pages(), and
svm_range_unmap_from_gpu() skips ranges that were never mappable rather
than returning an error, since unmap also runs on the eviction and
process teardown paths.

Link: https://sashiko.dev/#/patchset/20261016145129.69645-1-danielhu%40amd.com
Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Daniel Huang <danielhu@amd.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c | 42 ++++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h | 27 ++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index cfb428c72686..c3e4f0367522 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1427,6 +1427,16 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -EINVAL;
 	}
 
+	/* Such a range was rejected by svm_range_map_to_gpu() and so was
+	 * never mapped. Skip it rather than failing, since unmap is also
+	 * used on the eviction and process teardown paths.
+	 */
+	if (!kfd_svm_range_fits_gpu(adev, start, last)) {
+		pr_debug("CPU[0x%llx 0x%llx] exceeds GPUVM, skipping unmap\n",
+			 start, last);
+		return 0;
+	}
+
 	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
 				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
@@ -1504,6 +1514,16 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		return -EINVAL;
 	}
 
+	/* Last line of defence before amdgpu_vm_update_range() walks the
+	 * page tables with these PFNs.
+	 */
+	if (npages && !kfd_svm_range_fits_gpu(adev, last_start,
+					      last_start + npages - 1)) {
+		pr_debug("CPU[0x%lx 0x%lx] exceeds GPUVM, canceling map\n",
+			 last_start, last_start + npages - 1);
+		return -EINVAL;
+	}
+
 	for (i = offset; i < offset + npages; i++) {
 		uint64_t gpu_start;
 		uint64_t gpu_end;
@@ -1604,6 +1624,20 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 			continue;
 		}
 
+		/* GPUs in the same process can have different address limits.
+		 * Skip the ones that cannot represent this range instead of
+		 * failing the whole mapping.
+		 */
+		if (npages && !kfd_svm_range_fits_gpu(pdd->dev->adev,
+						      prange->start + offset,
+						      prange->start + offset +
+						      npages - 1)) {
+			pr_debug("device idx %d cannot map CPU[0x%lx 0x%lx]\n",
+				 gpuidx, prange->start + offset,
+				 prange->start + offset + npages - 1);
+			continue;
+		}
+
 		set_bit(gpuidx, prange->bitmap_mapped);
 
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
@@ -3096,6 +3130,14 @@ svm_range_restore_pages(struct amdgpu_device *adev, unsigned int pasid,
 		return -EFAULT;
 	}
 
+	/* addr is a CPU page index here. Reject faults the GPUVM cannot
+	 * represent before any range is looked up or migrated.
+	 */
+	if (!kfd_svm_range_fits_gpu(adev, addr, addr)) {
+		pr_debug("fault address 0x%llx exceeds GPUVM\n", addr);
+		return -EFAULT;
+	}
+
 	p = kfd_lookup_process_by_pasid(pasid, NULL);
 	if (!p) {
 		pr_debug("kfd process not founded pasid 0x%x\n", pasid);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
index 6235ce0f988e..57d4d79a6266 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -216,6 +216,33 @@ static inline bool kfd_svm_vm_covers_user_va(struct amdgpu_device *adev)
 		AMDGPU_GMC_HOLE_START;
 }
 
+/*
+ * A range is mappable on adev only if it lies below both the page table
+ * limit and the GPUVM address hole. start and last are CPU page indices
+ * and are inclusive, matching svm_range.start and svm_range.last.
+ *
+ * Each GPU is checked against its own limits, so a range that only some
+ * GPUs can represent is rejected for those GPUs alone.
+ *
+ * The parameter must be named adev since AMDGPU_GMC_HOLE_START references
+ * adev->vm_manager.max_level.
+ */
+static inline bool kfd_svm_range_fits_gpu(struct amdgpu_device *adev,
+					  uint64_t start, uint64_t last)
+{
+	uint64_t limit;
+
+	/* Rejects empty and wrapped ranges, so last bounds start as well. */
+	if (start > last)
+		return false;
+
+	/* First CPU page the GPUVM cannot represent. */
+	limit = min(adev->vm_manager.max_pfn << AMDGPU_GPU_PAGE_SHIFT,
+		    AMDGPU_GMC_HOLE_START) >> PAGE_SHIFT;
+
+	return last < limit;
+}
+
 /* SVM API and HMM page migration work together, device memory type
  * is initialized to not 0 when page migration register device memory.
  */
-- 
2.53.0

