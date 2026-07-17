Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77A7388386;
	Fri, 17 Jul 2026 10:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285873; cv=none; b=cBvizqe7LQsw1apSldDAhhYuvWqoGAsdtvBohnUFKuFa0W1ezVyeUyY9IgZZL3SMiS3oiDd09pKrYEuxVYMVRTnS5u0reW5yDtndN/tI9LEtQA6bNO9gZADXN5GInBMBbEUlUT/J28zEdy/dvoF/AkcRjxRMnBDahP7YT1Gy9zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285873; c=relaxed/simple;
	bh=rlDaOpJ3brj9PVGYbhicmJdaymyTayYBOcoMLkCwnGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nB+MYie6beJsOrh6Q0dmEwhDAwCb62eXddkS8ZZP+eko/Hx4fEh6fXzwmu9fycguGpBfZu9GtXJQsnSZfx3V2/9UKMUJ+uEVJ0dbNpNmnQ/UZqVBQG6KTKvjPdgXiWXjirifFwvAtQnk386u6e794sma9yk0zuwD6piG+ES2Yq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bK2bm1Tb; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bK2bm1Tb"
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H3DXDa2865095;
	Fri, 17 Jul 2026 10:57:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=NDZG9
	+GvP5eqnT5HOFqwCtpnFuPTx4l2ndZkEl2ZWnY=; b=bK2bm1TblrmHbAWOaV5Qo
	lt9Oqp4TsDPYRS1OKlVbqw6H3Q7OE2KkuVdsMn3g5RiRTOLpY5qJDJXpHSWIbMkS
	dFqViP6LsCCaqeE0MeW93PFzA5H6XsO6eHsRTXvvS9C5urIAR76skzzNBz5sXm8j
	ZoZOkwX/fkxA0+JMUP/x/IsGoLWOISY7KDCJL1+d3Tqjuuctekatlz8S0zZUVIJS
	GPfDD73wm/nQEaR4wp90GnyC4jklMONn71EeC4/rkhvJrW2W34GutfiZk141KCmS
	K+0UuW3CQrVj4hUcweV8osmkkcZNDGxODtGQmhNrQ0UYo7NnwEKagywbugsr9ISX
	A==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fdhn0ek75-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 10:57:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66HArCJi032716;
	Fri, 17 Jul 2026 10:57:26 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9hevx3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 10:57:25 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66HAvNDe005954;
	Fri, 17 Jul 2026 10:57:25 GMT
Received: from lmerwick-vm-ol9.osdevelopmeniad.oraclevcn.com (lmerwick-vm-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fbc9hevvq-2;
	Fri, 17 Jul 2026 10:57:24 +0000 (GMT)
From: Liam Merwick <liam.merwick@oracle.com>
To: stable@vger.kernel.org
Cc: vasant.hegde@amd.com, joerg.roedel@amd.com, iommu@lists.linux.dev,
        dheerajkumar.srivastava@amd.com, bp@alien8.de, Michael.Roth@amd.com,
        sashal@kernel.org, linux-coco@lists.linux.dev, liam.merwick@oracle.com
Subject: [PATCH linux-6.12.y v1 1/2] iommu/amd: Use maximum Event log buffer size when SNP is enabled on Family 0x19
Date: Fri, 17 Jul 2026 10:49:08 +0000
Message-ID: <20260717104909.3850331-2-liam.merwick@oracle.com>
In-Reply-To: <20260717104909.3850331-1-liam.merwick@oracle.com>
References: <20260717104909.3850331-1-liam.merwick@oracle.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2606160000 definitions=main-2607170109
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExMCBTYWx0ZWRfX6JsdPUJGvXYZ
 SWKYuN0vG/PmqU7MnKxYVYnONcP+ptE551I2rBoUUVTk4Q6cMNMR0XxyrUDBiHsPighUBbP2Qy0
 /eg/hCUgyGgC8oXG8sIAmRl4Vr6T08ZSWaDoc3Va7mAfisetuve7
X-Proofpoint-GUID: UXcFiAF0BMGwMIbj_3Sz9AXeM06uepuJ
X-Authority-Analysis: v=2.4 cv=ddewG3Xe c=1 sm=1 tr=0 ts=6a5a0a97 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=BqU2WV_vvsyTyxaotp0D:22 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8
 a=9YkXxvhO1m2ERweVmJcA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExMCBTYWx0ZWRfX3EEOJiMFmN1b
 PHmc3yaw6pAoENdDyEUWcDtj3/mIHW4zbM7FwOWVYirE/I7PSuI8/4ZnVLldqYxmE+VHq+bpdad
 nlbSwi3+ZO1j10U3EoQfOhfnBoHs1DS6eFx+5Is0GIkcLhXqe5bmdCpEi1h6v9hbWm44efS+c7S
 TLymguK87XQS5GI8r15JZgxwyZRUapVkUh5BpKtQV+meiZ8YnMlb+hsCzMM/TKhZqp6M4LA+3+6
 EsxldaNwnf1r5rRWTuDf4qJuJ18FIO6wyn8OfOyyZXjo3x7oy2HrgMDb0Y/QKS/7FqnIh+073mM
 E/q7S5ULyXymSI3JgqaoK0lEfFMJaH+JljB4VtIhqrbmCOGFewTNfkxNuJDKrGVd8D93xFg+vaL
 CPx+pkshPa7oH3zWDsLOyQJzRzIvijvW+k+sFvNTE0YsUNfJy0i6rp81JCfwiYuK00terrXCGym
 QsnMF6q0ruhY4pxOzZw==
X-Proofpoint-ORIG-GUID: UXcFiAF0BMGwMIbj_3Sz9AXeM06uepuJ

From: Vasant Hegde <vasant.hegde@amd.com>

commit 58c0ac6125d89bf6ec65a521eaeb52a0e8e20a9f upstream.

Due to CVE-2023-20585, the Event log buffer must use the maximum supported
size (512K) on Milan/Genoa (Family 0x19) systems when SNP is enabled,
to mitigate a potential security vulnerability. All other systems continue to
use the default Event log buffer size (8K).

Apply the errata fix by making the following changes:

* Introduce new global variable (amd_iommu_evtlog_size) to have event log
  buffer size. Adjust variable size for family 0x19.

* Since 'iommu_snp_enable()' must be called after the core IOMMU subsystem
  is initialized, it cannot be moved to the early init stage. The SNP errata
  must also be applied after the 'iommu_snp_enable()' check. Therefore,
  'alloc_event_buffer()' and 'iommu_enable_event_buffer()' are now called
  in the IOMMU_ENABLED state, after the errata is applied.

* Adjust alloc_event_buffer() and iommu_enable_event_buffer() to handle
  all IOMMU instances.

* Also rename EVT_* macros to make it more readable.

Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3016.html
Cc: Borislav Petkov <bp@alien8.de>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
(cherry picked from commit 58c0ac6125d89bf6ec65a521eaeb52a0e8e20a9f)
Conflicts:
	drivers/iommu/amd/init.c
[ Conflicts in alloc_event_buffer() and iommu_enable_event_buffer()
  due to lack of upstream AMD IOMMU kdump buffer reuse code.
  Similarly, do not add a kdump check when allocating an
  event log buffer in state_next(). ]
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 drivers/iommu/amd/amd_iommu.h       |  2 +
 drivers/iommu/amd/amd_iommu_types.h | 10 ++--
 drivers/iommu/amd/init.c            | 77 +++++++++++++++++++++--------
 drivers/iommu/amd/iommu.c           |  2 +-
 4 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index 6fac9ee8dd3e..af734668386f 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -11,6 +11,8 @@
 
 #include "amd_iommu_types.h"
 
+extern int amd_iommu_evtlog_size;
+
 irqreturn_t amd_iommu_int_thread(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_pprlog(int irq, void *data);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index 7f13b314abbc..d622fa0091a5 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -15,6 +15,7 @@
 #include <linux/mutex.h>
 #include <linux/msi.h>
 #include <linux/list.h>
+#include <linux/sizes.h>
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/irqreturn.h>
@@ -132,7 +133,6 @@
 #define MMIO_STATUS_GALOG_INT_MASK		BIT(10)
 
 /* event logging constants */
-#define EVENT_ENTRY_SIZE	0x10
 #define EVENT_TYPE_SHIFT	28
 #define EVENT_TYPE_MASK		0xf
 #define EVENT_TYPE_ILL_DEV	0x1
@@ -240,8 +240,12 @@
 #define MMIO_CMD_SIZE_512 (0x9ULL << MMIO_CMD_SIZE_SHIFT)
 
 /* constants for event buffer handling */
-#define EVT_BUFFER_SIZE		8192 /* 512 entries */
-#define EVT_LEN_MASK		(0x9ULL << 56)
+#define EVTLOG_ENTRY_SIZE	0x10
+#define EVTLOG_SIZE_SHIFT	56
+#define EVTLOG_SIZE_DEF		SZ_8K /* 512 entries */
+#define EVTLOG_LEN_MASK_DEF	(0x9ULL << EVTLOG_SIZE_SHIFT)
+#define EVTLOG_SIZE_MAX		SZ_512K /* 32K entries */
+#define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
 
 /* Constants for PPR Log handling */
 #define PPR_LOG_ENTRIES		512
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 78e9ceda2338..570471e10586 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -133,6 +133,8 @@ struct ivhd_entry {
 	u8 uid;
 } __attribute__((packed));
 
+int amd_iommu_evtlog_size = EVTLOG_SIZE_DEF;
+
 /*
  * An AMD IOMMU memory definition structure. It defines things like exclusion
  * ranges for devices and regions that should be unity mapped.
@@ -855,30 +857,41 @@ void *__init iommu_alloc_4k_pages(struct amd_iommu *iommu, gfp_t gfp,
 }
 
 /* allocates the memory where the IOMMU will log its events to */
-static int __init alloc_event_buffer(struct amd_iommu *iommu)
+static int __init alloc_event_buffer(void)
 {
-	iommu->evt_buf = iommu_alloc_4k_pages(iommu, GFP_KERNEL,
-					      EVT_BUFFER_SIZE);
+	struct amd_iommu *iommu;
 
-	return iommu->evt_buf ? 0 : -ENOMEM;
+	for_each_iommu(iommu) {
+		iommu->evt_buf = iommu_alloc_4k_pages(iommu, GFP_KERNEL,
+						      amd_iommu_evtlog_size);
+		if (!iommu->evt_buf)
+			return -ENOMEM;
+	}
+
+	return 0;
 }
 
-static void iommu_enable_event_buffer(struct amd_iommu *iommu)
+static void iommu_enable_event_buffer(void)
 {
+	struct amd_iommu *iommu;
 	u64 entry;
 
-	BUG_ON(iommu->evt_buf == NULL);
+	for_each_iommu(iommu) {
+		BUG_ON(iommu->evt_buf == NULL);
 
-	entry = iommu_virt_to_phys(iommu->evt_buf) | EVT_LEN_MASK;
+		entry = iommu_virt_to_phys(iommu->evt_buf);
+		entry |= (amd_iommu_evtlog_size == EVTLOG_SIZE_DEF) ?
+			EVTLOG_LEN_MASK_DEF : EVTLOG_LEN_MASK_MAX;
 
-	memcpy_toio(iommu->mmio_base + MMIO_EVT_BUF_OFFSET,
-		    &entry, sizeof(entry));
+		memcpy_toio(iommu->mmio_base + MMIO_EVT_BUF_OFFSET,
+			    &entry, sizeof(entry));
 
-	/* set head and tail to zero manually */
-	writel(0x00, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
-	writel(0x00, iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
+		/* set head and tail to zero manually */
+		writel(0x00, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
+		writel(0x00, iommu->mmio_base + MMIO_EVT_TAIL_OFFSET);
 
-	iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
+		iommu_feature_enable(iommu, CONTROL_EVT_LOG_EN);
+	}
 }
 
 /*
@@ -891,7 +904,7 @@ static void iommu_disable_event_buffer(struct amd_iommu *iommu)
 
 static void __init free_event_buffer(struct amd_iommu *iommu)
 {
-	iommu_free_pages(iommu->evt_buf, get_order(EVT_BUFFER_SIZE));
+	iommu_free_pages(iommu->evt_buf, get_order(amd_iommu_evtlog_size));
 }
 
 static void free_ga_log(struct amd_iommu *iommu)
@@ -1828,9 +1841,6 @@ static int __init init_iommu_one_late(struct amd_iommu *iommu)
 	if (alloc_command_buffer(iommu))
 		return -ENOMEM;
 
-	if (alloc_event_buffer(iommu))
-		return -ENOMEM;
-
 	iommu->int_enabled = false;
 
 	init_translation_status(iommu);
@@ -2754,7 +2764,6 @@ static void early_enable_iommu(struct amd_iommu *iommu)
 	iommu_init_flags(iommu);
 	iommu_set_device_table(iommu);
 	iommu_enable_command_buffer(iommu);
-	iommu_enable_event_buffer(iommu);
 	iommu_set_exclusion_range(iommu);
 	iommu_enable_gt(iommu);
 	iommu_enable_ga(iommu);
@@ -2812,7 +2821,6 @@ static void early_enable_iommus(void)
 			iommu_disable_event_buffer(iommu);
 			iommu_disable_irtcachedis(iommu);
 			iommu_enable_command_buffer(iommu);
-			iommu_enable_event_buffer(iommu);
 			iommu_enable_ga(iommu);
 			iommu_enable_xt(iommu);
 			iommu_enable_irtcachedis(iommu);
@@ -2928,6 +2936,7 @@ static void amd_iommu_resume(void)
 	/* re-load the hardware */
 	enable_iommus();
 
+	iommu_enable_event_buffer();
 	amd_iommu_enable_interrupts();
 }
 
@@ -3242,6 +3251,23 @@ static void iommu_snp_enable(void)
 #endif
 }
 
+static void amd_iommu_apply_erratum_snp(void)
+{
+#ifdef CONFIG_KVM_AMD_SEV
+	if (!amd_iommu_snp_en)
+		return;
+
+	/* Errata fix for Family 0x19 */
+	if (boot_cpu_data.x86 != 0x19)
+		return;
+
+	/* Set event log buffer size to max */
+	amd_iommu_evtlog_size = EVTLOG_SIZE_MAX;
+	pr_info("Applying erratum: Increase Event log size to 0x%x\n",
+		amd_iommu_evtlog_size);
+#endif
+}
+
 /****************************************************************************
  *
  * AMD IOMMU Initialization State Machine
@@ -3278,6 +3304,17 @@ static int __init state_next(void)
 	case IOMMU_ENABLED:
 		register_syscore_ops(&amd_iommu_syscore_ops);
 		iommu_snp_enable();
+
+		amd_iommu_apply_erratum_snp();
+
+		/* Allocate/enable event log buffer */
+		ret = alloc_event_buffer();
+		if (ret) {
+			init_state = IOMMU_INIT_ERROR;
+			break;
+		}
+		iommu_enable_event_buffer();
+
 		ret = amd_iommu_init_pci();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
 		break;
@@ -3865,7 +3902,7 @@ int amd_iommu_snp_disable(void)
 		return 0;
 
 	for_each_iommu(iommu) {
-		ret = iommu_make_shared(iommu->evt_buf, EVT_BUFFER_SIZE);
+		ret = iommu_make_shared(iommu->evt_buf, amd_iommu_evtlog_size);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 65d61b9c7382..f87db7a39d2f 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1003,7 +1003,7 @@ static void iommu_poll_events(struct amd_iommu *iommu)
 		iommu_print_event(iommu, iommu->evt_buf + head);
 
 		/* Update head pointer of hardware ring-buffer */
-		head = (head + EVENT_ENTRY_SIZE) % EVT_BUFFER_SIZE;
+		head = (head + EVTLOG_ENTRY_SIZE) % amd_iommu_evtlog_size;
 		writel(head, iommu->mmio_base + MMIO_EVT_HEAD_OFFSET);
 	}
 
-- 
2.52.0

