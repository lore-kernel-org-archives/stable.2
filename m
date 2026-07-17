Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C713B19AE;
	Fri, 17 Jul 2026 10:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285872; cv=none; b=GgsZO8XB5kvVVuwQ+0vtVQ9Uh+xi1yNfyHlJiAFUBlQdn8MBzNJLfrlmcfKI6IkzzjR4gVZ1GIcHOO5+KwuvwYwAmPTtl5+V7n0K+kAzTttSfGE3OYnz/zi9mLFkqcpQtafbDylg2ltHQMrLYofcqcuq+Dq5/BUZ4m6snEYWSQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285872; c=relaxed/simple;
	bh=yHWZNYPiSbGfnKPh8DTitlj3VIlwe7CCswYIRcZkyWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iOSyc767K7VOJA1W0jPJnD73+bpC4gDrN3gXp02Dn4R/CM+uhSt6wM3bURoTnY/fUb2BmwghyL6hgPGWCh1G4vjC07Ok9/g9A6x1CmP7srioArLquPZYsyiduKH1ZeHdkC1g87W+WhXgnWX4fFc1LeCx5v1oDC8wJmapH5SuJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VYfb0ZU/; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VYfb0ZU/"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66H5HNoK2298613;
	Fri, 17 Jul 2026 10:57:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=OSJO5
	9Usx5hxvXGtFCKhvK7wJbDESS1j7ZpZ6o6Z/tY=; b=VYfb0ZU/umY4mwkg4KaNr
	Dh7QPiTdAjDMWxWgzT5H5tA0CulirVqiy+fJykcSWnWsi7e01ezflypyq5TbDuvA
	ITnnZQsH7wKvxtLhj/e/YZM0w8tvEWlyfq9X09GscxP5RiYXC6Sj9BTI8JAtZlZk
	TDQZkscxkcYUaoklxVcYz3wF7kAvbFR0BlHiqDnGQXSW4CNgGUjQmlvnj7xprtf1
	oCvHnLD4Qypl5Fs5mOqNRCZBpqzET2DMyhl5WnBjjmznpptOzdAKxDaoaAaB3ZID
	2/FaDbVGJ/qFx7BXbEuh/MMjEvor2x4ieIGKbLvj0wHc/getLtDAgKq9bSaF/uKG
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4fbed8a5ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 10:57:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 66HArDjA032792;
	Fri, 17 Jul 2026 10:57:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4fbc9hevxs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 10:57:27 +0000 (GMT)
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66HAvNDg005954;
	Fri, 17 Jul 2026 10:57:26 GMT
Received: from lmerwick-vm-ol9.osdevelopmeniad.oraclevcn.com (lmerwick-vm-ol9.allregionaliads.osdevelopmeniad.oraclevcn.com [100.100.253.75])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4fbc9hevvq-3;
	Fri, 17 Jul 2026 10:57:26 +0000 (GMT)
From: Liam Merwick <liam.merwick@oracle.com>
To: stable@vger.kernel.org
Cc: vasant.hegde@amd.com, joerg.roedel@amd.com, iommu@lists.linux.dev,
        dheerajkumar.srivastava@amd.com, bp@alien8.de, Michael.Roth@amd.com,
        sashal@kernel.org, linux-coco@lists.linux.dev, liam.merwick@oracle.com
Subject: [PATCH linux-6.12.y v1 2/2] iommu/amd: Use maximum PPR log buffer size when SNP is enabled on Family 0x19
Date: Fri, 17 Jul 2026 10:49:09 +0000
Message-ID: <20260717104909.3850331-3-liam.merwick@oracle.com>
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
X-Proofpoint-GUID: KTAxMZgxzPB4eUhQ4f_aMp954nb4trKD
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDExMCBTYWx0ZWRfXx2OStSUFC779
 ad+Bd2DJxBQR2bR4Yi5d02LWmIkFBGz2Y2AV2bn6aAd/8Kc6LZ6HaRoPrERMplCjbe8TWDgYlg4
 bvij2VuRaVXAY80H1rHwbBJsuGab8Cc73ukrhDnkrgTkzD4HlQ6I
X-Authority-Analysis: v=2.4 cv=JKALdcKb c=1 sm=1 tr=0 ts=6a5a0a98 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=o5oIOnhZENCTenyL_yNV:22 a=zd2uoN0lAAAA:8 a=yPCof4ZbAAAA:8
 a=tY4g_cFqGmKheHVCoEsA:9
X-Proofpoint-ORIG-GUID: KTAxMZgxzPB4eUhQ4f_aMp954nb4trKD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDExMCBTYWx0ZWRfXyPG4ooHqA3D+
 jxnF5ngAX8FuOCSSCMLrGjxEFDgDgkP7ySZLR9gbMH9VmxxkNodZ70IveKbox+iFGP7UTQcX7hB
 wN58BSXTnkVSsHhkB+T39cjNJwnE0S3htd0D278BpTGliq2ixTUdb1hGcdgiP8ApWIq4vEMTKpd
 iJS9pPlm/eHjZB7vgFAvFAsrhdRa785gJ2l3q+SiB2WZC55hA7ZYSpKdVsk9MoiQstwPlc5aBa9
 /ohuRQxe5Df40Tz5w9iVRmffoexntVrZddXC0wNxQKcwQ5if35Bu6xPWoGs58AGgAgW5qinE1SX
 2aeNniskkJi8RqHt6va150mffS6l3LFE8IBXK4wPxrm+prWcgq76UTTegMx4nQZ/EfJ+8uEFq+X
 vvU7wFTYdOnYSuFrsGxVkaqnVdP7HPNOgYVA/J/iQMWQ+aYjE7lyIYzve6ILHaE/fhnpMHeTiuL
 2qKJ5u84sHjdbeIfBrw==

From: Vasant Hegde <vasant.hegde@amd.com>

commit 1f44aab79bac31f459422dfb213e907bb386509c upstream.

Due to CVE-2023-20585, the PPR log buffer must use the maximum supported
size (512K) on Genoa (Family 0x19, model >= 0x10) systems when SNP is
enabled, to mitigate a potential security vulnerability. Note that Family
0x19 models below 0x10 (Milan) do not support PPR when SNP is enabled.
Hence the PPR log size increase is only applied for model >= 0x10.
All other systems continue to use the default PPR log buffer size (8K).

Apply the errata fix by making the following changes:

- Introduce global new variable (amd_iommu_pprlog_size) to have PPR log buffer
  size. Adjust variable size for Genoa family.

- Extend 'amd_iommu_apply_erratum_snp()' to also set the PPR log buffer
  size to maximum for Family 0x19 model >= 0x10 when SNP is enabled.

- Rename PPR_* macros to make it more readable.

Link: https://www.amd.com/en/resources/product-security/bulletin/amd-sb-3016.html
Cc: Borislav Petkov <bp@alien8.de>
Cc: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
Tested-by: Dheeraj Kumar Srivastava <dheerajkumar.srivastava@amd.com>
Signed-off-by: Joerg Roedel <joerg.roedel@amd.com>
(cherry picked from commit 1f44aab79bac31f459422dfb213e907bb386509c)
[ Modify amd_iommu_free_ppr_log() due to different iommu_free_pages() API. ]
Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
---
 drivers/iommu/amd/amd_iommu.h       |  1 +
 drivers/iommu/amd/amd_iommu_types.h | 11 ++++++-----
 drivers/iommu/amd/init.c            | 13 ++++++++++++-
 drivers/iommu/amd/ppr.c             | 10 ++++++----
 4 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/drivers/iommu/amd/amd_iommu.h b/drivers/iommu/amd/amd_iommu.h
index af734668386f..6118487a69e0 100644
--- a/drivers/iommu/amd/amd_iommu.h
+++ b/drivers/iommu/amd/amd_iommu.h
@@ -12,6 +12,7 @@
 #include "amd_iommu_types.h"
 
 extern int amd_iommu_evtlog_size;
+extern int amd_iommu_pprlog_size;
 
 irqreturn_t amd_iommu_int_thread(int irq, void *data);
 irqreturn_t amd_iommu_int_thread_evtlog(int irq, void *data);
diff --git a/drivers/iommu/amd/amd_iommu_types.h b/drivers/iommu/amd/amd_iommu_types.h
index d622fa0091a5..09131d067a8a 100644
--- a/drivers/iommu/amd/amd_iommu_types.h
+++ b/drivers/iommu/amd/amd_iommu_types.h
@@ -248,11 +248,12 @@
 #define EVTLOG_LEN_MASK_MAX	(0xFULL << EVTLOG_SIZE_SHIFT)
 
 /* Constants for PPR Log handling */
-#define PPR_LOG_ENTRIES		512
-#define PPR_LOG_SIZE_SHIFT	56
-#define PPR_LOG_SIZE_512	(0x9ULL << PPR_LOG_SIZE_SHIFT)
-#define PPR_ENTRY_SIZE		16
-#define PPR_LOG_SIZE		(PPR_ENTRY_SIZE * PPR_LOG_ENTRIES)
+#define PPRLOG_ENTRY_SIZE	0x10
+#define PPRLOG_SIZE_SHIFT	56
+#define PPRLOG_SIZE_DEF		SZ_8K	/* 512 entries */
+#define PPRLOG_LEN_MASK_DEF	(0x9ULL << PPRLOG_SIZE_SHIFT)
+#define PPRLOG_SIZE_MAX		SZ_512K	/* 32K entries */
+#define PPRLOG_LEN_MASK_MAX	(0xFULL << PPRLOG_SIZE_SHIFT)
 
 /* PAGE_SERVICE_REQUEST PPR Log Buffer Entry flags */
 #define PPR_FLAG_EXEC		0x002	/* Execute permission requested */
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 570471e10586..7fa340281b9f 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -134,6 +134,7 @@ struct ivhd_entry {
 } __attribute__((packed));
 
 int amd_iommu_evtlog_size = EVTLOG_SIZE_DEF;
+int amd_iommu_pprlog_size = PPRLOG_SIZE_DEF;
 
 /*
  * An AMD IOMMU memory definition structure. It defines things like exclusion
@@ -3265,6 +3266,16 @@ static void amd_iommu_apply_erratum_snp(void)
 	amd_iommu_evtlog_size = EVTLOG_SIZE_MAX;
 	pr_info("Applying erratum: Increase Event log size to 0x%x\n",
 		amd_iommu_evtlog_size);
+
+	/*
+	 * Set PPR log buffer size to max.
+	 * (Family 0x19, model < 0x10 doesn't support PPR when SNP is enabled).
+	 */
+	if (boot_cpu_data.x86_model >= 0x10) {
+		amd_iommu_pprlog_size = PPRLOG_SIZE_MAX;
+		pr_info("Applying erratum: Increase PPR log size to 0x%x\n",
+			amd_iommu_pprlog_size);
+	}
 #endif
 }
 
@@ -3906,7 +3917,7 @@ int amd_iommu_snp_disable(void)
 		if (ret)
 			return ret;
 
-		ret = iommu_make_shared(iommu->ppr_log, PPR_LOG_SIZE);
+		ret = iommu_make_shared(iommu->ppr_log, amd_iommu_pprlog_size);
 		if (ret)
 			return ret;
 
diff --git a/drivers/iommu/amd/ppr.c b/drivers/iommu/amd/ppr.c
index 7c67d69f0b8c..42d895bd1c44 100644
--- a/drivers/iommu/amd/ppr.c
+++ b/drivers/iommu/amd/ppr.c
@@ -20,7 +20,7 @@
 int __init amd_iommu_alloc_ppr_log(struct amd_iommu *iommu)
 {
 	iommu->ppr_log = iommu_alloc_4k_pages(iommu, GFP_KERNEL | __GFP_ZERO,
-					      PPR_LOG_SIZE);
+					      amd_iommu_pprlog_size);
 	return iommu->ppr_log ? 0 : -ENOMEM;
 }
 
@@ -33,7 +33,9 @@ void amd_iommu_enable_ppr_log(struct amd_iommu *iommu)
 
 	iommu_feature_enable(iommu, CONTROL_PPR_EN);
 
-	entry = iommu_virt_to_phys(iommu->ppr_log) | PPR_LOG_SIZE_512;
+	entry = iommu_virt_to_phys(iommu->ppr_log);
+	entry |= (amd_iommu_pprlog_size == PPRLOG_SIZE_DEF) ?
+			PPRLOG_LEN_MASK_DEF : PPRLOG_LEN_MASK_MAX;
 
 	memcpy_toio(iommu->mmio_base + MMIO_PPR_LOG_OFFSET,
 		    &entry, sizeof(entry));
@@ -48,7 +50,7 @@ void amd_iommu_enable_ppr_log(struct amd_iommu *iommu)
 
 void __init amd_iommu_free_ppr_log(struct amd_iommu *iommu)
 {
-	iommu_free_pages(iommu->ppr_log, get_order(PPR_LOG_SIZE));
+	iommu_free_pages(iommu->ppr_log, get_order(amd_iommu_pprlog_size));
 }
 
 /*
@@ -201,7 +203,7 @@ void amd_iommu_poll_ppr_log(struct amd_iommu *iommu)
 			raw[0] = raw[1] = 0UL;
 
 		/* Update head pointer of hardware ring-buffer */
-		head = (head + PPR_ENTRY_SIZE) % PPR_LOG_SIZE;
+		head = (head + PPRLOG_ENTRY_SIZE) % amd_iommu_pprlog_size;
 		writel(head, iommu->mmio_base + MMIO_PPR_HEAD_OFFSET);
 
 		/* Handle PPR entry */
-- 
2.52.0

