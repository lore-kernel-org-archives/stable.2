Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012005.outbound.protection.outlook.com [40.93.195.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2600C39281B
	for <stable@vger.kernel.org>; Fri, 16 Oct 2026 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.5
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792116576; cv=fail; b=XR5BPv1vht6hV/3OFIEm4iB8DFgtRxa/uGyzKCwTbwS+1gh5nTK0zoqgfDDAQinPQHjBjIPhlxp+KaaKpiTud2a1ZHFMOmXXWit4OTSoM/WwVjFHhFMwrbs+uecLkPPFUa0egVbQhBlir1kZbjaZhY7D5TFvv4tf9ntlEeWijYA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792116576; c=relaxed/simple;
	bh=mJhQ7UQBqaL5NK0TEHSidtKGQt4LZxkgivbZsOTWHgw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lr7HvsMjraATlbo37Mq7x37AMQyw5TGBr5j3iz/bppzhTzs1la3q6RPtDOW7Bg+bde/P5lTIdDJzje9BbbokR7sm7JwamXEznc4D80y1fz+ZKazxztAvLPcnKbFIN+OkN+062Oh70BpU5DU8F7paL2KzJco4uCGz3NzSnXilhBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kDN8k5W+; arc=fail smtp.client-ip=40.93.195.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kDN8k5W+"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qepbR2avf5+58Kd6/+fqBrk4lLkaT9YYnjpH+Q5J5x/BXPW1EKxdPVm3JXScMdd5LP6WsjzdYFfypx4+Za/vtt9HHAjgqmcs2Vj48oceWVfy1y5cB48AbsaBCBOxhDjM0YY7FFBi2tj8pd5855xlQCDHvxYaoyDZqF0FkoM/R/Ts0FL7Tl7nuEGnDRblpzPo9ulfZ5EoYJVRCzMWXRNplumJxx11DGtzgEx0NzlaKno3Nxvfd1z7wDj6ee/AWqomskPMdkWjMpVwGrK0fUReFDreCPWXyZknsfR5plUYqPaj6u9MAMuDX8G43QTdg3X/qqoeuoW3KF6Ob1j+Q2gvCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4j/42kh3kFmHfwqY6J7rwiscX6YCfuYbJpgYJoA0s4w=;
 b=Ptmtz6X3KqS4wGvSExS13yeucHTMlQKdmoSnc2PEK22hXpDLp9tcyVLx0/z7Mx3rFuNCSQhejwPpK7N/37OhM3YQfUzm85dX34jYmfkV+6Ly7ie37Q0iJwORUKXXNxnscXfh9rSR+4ZdrGAHHWKXPpesCBjdrnnupWe+5e+9uvU4u96voGnkVmlltmuEHcvFXSvmw3KYNCVwKpq7uc0sInFCz5JB0zupwsz4yiJb3/tYWTeP/mfm7o91Q/bEqRND6E/Wv6veyUy/rkGImjOTtT3lypUJpz5bS0F02f6DQDRZZ1epRZUi0houmvTvqxFAEJI/iAiG3TmHIJl9mq7b1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4j/42kh3kFmHfwqY6J7rwiscX6YCfuYbJpgYJoA0s4w=;
 b=kDN8k5W+cHRdOQDi5eCOVjZP10GyITSqSmHL/jiH33MbaIFfdOoaT46DrUpYmDEoZohYvCDJrDd/N5znB8sbrHx9MwFMwqYJhT3VJl1vW21c03Fzn3i5TZr///ErbIS1w5UpiV30EO+U/Z7eGl/ZUOJTTC+pJgEcoLEnVdU4dJ0=
Received: from MN0PR05CA0012.namprd05.prod.outlook.com (2603:10b6:208:52c::35)
 by SA5PPF5EA4322E1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8cc) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 02:09:29 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:52c:cafe::5a) by MN0PR05CA0012.outlook.office365.com
 (2603:10b6:208:52c::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Fri, 16
 Oct 2026 02:09:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.0 via Frontend Transport; Fri, 16 Oct 2026 02:09:28 +0000
Received: from danielhuang-HP-EliteBook-845-14-inch-G10-Notebook-PC.amd.com
 (10.180.168.240) by satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.53; Thu, 15 Oct 2026 21:09:20 -0500
From: Daniel Huang <danielhu@amd.com>
To: <danielhu@amd.com>
CC: <stable@vger.kernel.org>
Subject: [PATCH] drm/amdkfd: disable SVM when the GPUVM aperture cannot cover CPU addresses
Date: Fri, 16 Oct 2026 18:09:18 +0800
Message-ID: <20261016100918.35589-1-danielhu@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|SA5PPF5EA4322E1:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a43d58a-c252-4be6-45c4-08df2b2a828d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|36860700016|1800799024|82310400026|56012099006|5023799004|261009223027099003|11063799006|10067099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	AXi6G9mP0mws3Twy23GeAQIGj3NQxRrRVZwNtjLqV3tCvfZZwdK6fnJI2uhWEon7eyQ2SKfgIiESItTuL0i8NuR0ypoYsC75OpGHiiPXwi8h7SngZObFPRvtXF4qGCF0p94Adz0eZfqr9R9EMAfZSnES8hzeIgN2KhrQdv/5CIajacqs/1aGsZ0x28QbgygcWVZXMDAPBGNao8MOfPx3V7SLM/GmGOZ+sE3ProovfGznv7j7AtmtuSV6g1tY5z0PedX+MQm3Xv72WYIcMmu8mSMlrR6V+rhqQVFuNvkr0oKGdb8tNBW58rG3xjRRJCLTlkQ6w0JKHu5CEYAqugrEsAZQKijVRiJNgX+bKU7iq1GYvLdp2eXjyPmXaC2WIabChJUHcHXSbx0CmxoCy1ikT7kbctVIuxkmeVZN6uriPhDziDM9MA6orv3vkbMTqcrycbJQ8EXVXqHNriobnbM1BuGB34VKVSQ6dUt5hgXWMlCVlLnIsa2IOuWvaRt+zliFwGuwOfRE+so5Ta0yKigc/UciNhXhlqONMEo+oALj/+K3NUBKMQXTAOgA2y8C/ylbiPC13OF08ooxcb0Uy86tOFG49G0ZnqcONYnzSShlk71Pg6Lv8QFCNyQEoT+8C8/j2tC9zRpmWYRoAXsdP7oBHg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(36860700016)(1800799024)(82310400026)(56012099006)(5023799004)(261009223027099003)(11063799006)(10067099003)(18002099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	f9brhJeXWfHCyQBnayot5Gw33MF80zfTbbBQxv52W3khCeh9Vt9u5Na6BYsWYaecQ5a4YqsvLXWkQwOEtSclY7o8QHZo3N4PkuuT11KLI+fZmkvlBjoRnFIj/AMvMjS/BhMRB+teECYuzJ0BBQdChqqrUrdDYn+WFZeHDtsEQGZMCdok7s6p++x+pwDdoYa47bS8HKsQgTvZGt+wDGDJ6nZRtwOquyEvdXe7bWoo7DoXjy71battFCieNa2hK+kYeskHALjoMigEviqlMxju2r/6aA+BjR2x/fcpxIlESBq+Cr5Z3YMRCHXxo4IeKlLpxqnEcOVQeN1j3eWp/eIRWhmj5p4bzyrBrJoN8NiiPPUdK77V9lxrVOAg96poX8iBdyHpmZyVCP+HLE/xXdbQIbTpKIvDtDyrIyfZVhPYP1cl9tz03whrk+K7msZxyxCW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 02:09:28.8378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a43d58a-c252-4be6-45c4-08df2b2a828d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF5EA4322E1

SVM maps memory at the CPU virtual address, so svm_range_map_to_gpu()
hands amdgpu_vm_update_range() a PFN derived straight from a userspace
address.  Nothing on that path compares it against vm_manager.max_pfn.

The buffer object path does compare.  amdgpu_vm_bo_map() and friends go
through amdgpu_vm_verify_parameters(), which rejects an lpfn at or above
vm_manager.max_pfn.  The page table walk relies on that check having
happened: amdgpu_vm_pt_entries_mask() returns 0xffffffff for levels at
or above the root, so the root index is applied unmasked, while
amdgpu_vm_pt_num_entries() sizes the root directory at only
round_up(max_pfn, 1ULL << shift) >> shift entries.  A PFN at or above
max_pfn therefore indexes past the end of root.entries[] on the first
descent, and the walk carries on through whatever heap follows the
array.

amdgpu_vm_adjust_size() never picks an aperture small enough for a CPU
address to land there -- the min_vm_size every gmc_v*_sw_init() passes
already reaches AMDGPU_GMC_HOLE_START.  An explicit amdgpu.vm_size=
below it does, and nothing rejects it.

Seen on a Radeon 780M (gfx1103) with amdgpu.vm_size=64, i.e. max_pfn
0x1000000 and a 64 GiB aperture.  A hipMallocManaged() loop asked SVM to
map CPU address 0x74bd48000000, 1867 times max_pfn past the end of the
GPU address space.  Under slub_debug=FZPU the out of bounds root entry
read back as the 0x5a5a5a5a5a5a5a5a poison pattern; without it, as
recycled heap.  amdgpu_vm_cpu_update() then dereferenced it:

  Oops: general protection fault, probably for non-canonical address
        0xb6aa2327baea2463: 0000 [#1] SMP NOPTI
  RIP: 0010:amdgpu_vm_cpu_update+0x2f/0x140 [amdgpu]
   amdgpu_vm_pte_update_flags+0xfa/0x1e0 [amdgpu]
   amdgpu_vm_ptes_update+0x38b/0xa00 [amdgpu]
   amdgpu_vm_update_range+0x279/0x930 [amdgpu]
   svm_range_map_to_gpu+0x13d/0x400 [amdgpu]
   svm_range_map_to_gpus+0x15c/0x380 [amdgpu]
   svm_range_validate_and_map+0x8d3/0xaa0 [amdgpu]
   svm_range_set_attr+0x4b6/0x890 [amdgpu]
   svm_ioctl+0x66/0x80 [amdgpu]
   kfd_ioctl_svm+0x64/0x120 [amdgpu]
   kfd_ioctl+0x40a/0x650 [amdgpu]

RSI and R14 both held 0xb6aa2327baea2323, so the garbage is the incoming
vmbo argument itself rather than a field inside an otherwise valid
object.

A UBSAN invalid-load in amdgpu_vm_update_pdes() precedes it on the same
thread, loading 180 for the _Bool amdgpu_vm_bo_base.moved -- the same
out of bounds entry, reached through vm->relocated.

Rejecting the range in amdgpu_vm_update_range() was proposed in [1] and
turned down: the SVM subsystem should refuse to initialize when the
GPUVM cannot represent the addresses, rather than failing every map once
it is already too late.  Do that.  Require an aperture reaching
AMDGPU_GMC_HOLE_START in KFD_IS_SVM_API_SUPPORTED(), so
HSA_CAP_SVMAPI_SUPPORTED stays clear in the KFD topology,
svms->bitmap_supported stays empty, and no SVM range is ever handed to
the page table walker.  Warn at device init so the capability does not
just silently vanish.

Converting the macro to a static inline keeps AMDGPU_GMC_HOLE_START's
implicit use of adev confined to one place.

[1] https://lore.kernel.org/amd-gfx/FIXME-SEPT-2-2026-MESSAGE-ID/

Fixes: f80fe9d3c114 ("drm/amdkfd: map svm range to GPUs")
Closes: https://github.com/ROCm/legacy-rocm-build/issues/6691
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Huang <danielhu@amd.com>
Tested-by: Daniel Huang <danielhu@amd.com>
---
Validated on a Radeon 780M (gfx1103, PCI 1002:15bf), Ubuntu 26.04.1,
kernel 7.0.0-38-generic, ROCm 7.13.0-2 / HIP 7.1.52801, booted with
amdgpu.vm_size=64 amdgpu.no_system_mem_limit=1 throughout.  Workload is
the reporter's reproducer, 24 iterations of hipMallocManaged(1 GiB) /
hipMemset / hipFree, run up to 40 times per attempt.

  stock amdgpu.ko     Oops within ~2 s, every attempt
  patched amdgpu.ko   40/40 runs clean, 594 s
  stock amdgpu.ko     Oops within ~2 s
  patched amdgpu.ko   40/40 runs clean, 584 s

all four within 30 minutes on the same kernel, module identity confirmed
per boot from the taint message and this warning.  With the default
amdgpu.vm_size the patched module does not log the warning and SVM stays
enabled, as expected.  A control run at the default aperture on the same
kernel is also clean, which isolates amdgpu.vm_size=64 as the trigger
rather than the kernel version.

Two things I would like a maintainer opinion on:

- I have read "must fail to initialize" as "do not advertise the
  capability".  If you meant something stronger -- refusing KFD bringup,
  or rejecting the vm_size in amdgpu_vm_adjust_size() -- say so and I
  will respin.

- This gate also catches gmc_v6/v7/v8, where max_bits is 40 and so the
  aperture cannot reach AMDGPU_GMC_HOLE_START at any vm_size.  On those
  ASICs pgmap.type stays 0 (kgd2kfd_init_zone_device() requires gfx9+),
  so only an APU that set apu_prefer_gtt currently advertises SVM, and
  by this patch's argument it is unsound there too.  It is still a
  user-visible change on a whole generation, so flagging it rather than
  burying it.  Happy to restrict the gate to an explicitly configured
  amdgpu_vm_size if you would rather keep the blast radius at the
  reported configuration.

 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |  8 ++++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.h       | 21 +++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -187,6 +187,14 @@ void amdgpu_amdkfd_device_init(struct amdgpu_device *adev)
 			.enable_mes = adev->enable_mes,
 		};

+		/* Say so rather than letting the capability silently vanish
+		 * from the KFD topology.
+		 */
+		if (gpu_resources.gpuvm_size < AMDGPU_GMC_HOLE_START)
+			dev_warn(adev->dev,
+				 "GPUVM aperture 0x%llx cannot represent CPU addresses, KFD SVM disabled (amdgpu.vm_size=%d)\n",
+				 gpu_resources.gpuvm_size, amdgpu_vm_size);
+
 		/* this is going to have a few of the MSBs set that we need to
 		 * clear
 		 */
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.h
@@ -197,11 +197,28 @@ struct kfd_process_device *
 svm_range_get_pdd_by_node(struct svm_range *prange, struct kfd_node *node);
 void svm_range_list_lock_and_flush_work(struct svm_range_list *svms, struct mm_struct *mm);

+/* SVM maps memory at the CPU virtual address, so the GPUVM aperture has to be
+ * able to represent every address the CPU can hand out.  Below that, the page
+ * table walk in amdgpu_vm_ptes_update() indexes the root directory past the
+ * end of its entry array instead of the range being rejected.
+ *
+ * The parameter has to be named adev: AMDGPU_GMC_HOLE_START expands to an
+ * expression referencing adev->vm_manager.max_level.
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
+static inline bool KFD_IS_SVM_API_SUPPORTED(struct amdgpu_device *adev)
+{
+	return (adev->kfd.pgmap.type != 0 || adev->apu_prefer_gtt) &&
+	       kfd_svm_vm_covers_user_va(adev);
+}

 void svm_range_bo_unref_async(struct svm_range_bo *svm_bo);

--
2.43.0

