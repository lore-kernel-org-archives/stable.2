Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CEF3515CA
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 22:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785796837; cv=none; b=PzUBho09q+YM9Zspak5N8h5xaWaiOJ5gtTi7Jf1JKpQ/J78hv6WuK/yn718WXPZJ4SAaASaGDTMAk4Z95O3StKedHRQN1kf8E0S5GUOx4DmjYeAeL7vT8A+zQWzFkz+cMZw2MRLhMl2Z5IIyakNA98/qw988F+VEcdEyyjzf1qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785796837; c=relaxed/simple;
	bh=6Go4fUb6eczzq34zvvuA177QcMs7n5eZiGo6vrb/6yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M2LacJcuNsEQ8TKTxOCTDxVTFTo4hWTqwMVU1lUSeIKu4CTbob/VDalDOtwjMlNWwahcB3uvFz0pEJmOQnhsvgetzzO8UrQo8xBaBtaYTc9M9A4tnSvaXXbgDUB0JJXHKuUAJCg4DRiCbvX5h3DJ/qlNaOvTJFsqQGfDzCKjNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SK7neU4J; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SK7neU4J"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673JlZbe2994267
	for <stable@vger.kernel.org>; Mon, 3 Aug 2026 22:40:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=k7RRNCTc/DlsnNSvULum1lPZtzI1SX1djZRoM5+3K
	ck=; b=SK7neU4Jlqa7yDoKk0aEedE8agCGCjclBSY/xpJl9SZyL5JWp+V2U4HDK
	rMGGUrEyOLy+k8YyGQLzC8VK2u/uJ5i14RPyro/mdU/Ob3OFaG+6BB53jbGxel2H
	agt/PuxlwY4StJcw4VEHO5imVbB22tcfcz/nG3A3D4rHX+QFkS1NRdxF/YOxGrlP
	wuBIRr2/rZQZqO6SJkY03mI6pR7uP29BX3xH80YKIGsVOXQysfKCR75tVAZSCqJv
	jdOdp8gaFC2+rzpKiL8UouzNNtsdXNWbQmjEtaKVilvdyTO10y0817yMff9I1O59
	ojd8QwFIG0oSfP8C8VOGGtZ+KtQhw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4u3pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 22:40:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673MQIvA030447;
	Mon, 3 Aug 2026 22:40:33 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fsu4qfkbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 22:40:33 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673MeW2121430852
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 22:40:32 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 588CF58054;
	Mon,  3 Aug 2026 22:40:32 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 141775805C;
	Mon,  3 Aug 2026 22:40:31 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.67.105.130])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 22:40:30 +0000 (GMT)
From: Gaurav Batra <gbatra@linux.ibm.com>
To: maddy@linux.ibm.com
Cc: sbhat@linux.ibm.com, ritesh.list@gmail.com, vaibhav@linux.ibm.com,
        harshpb@linux.ibm.com, ltc-dev@lists.linux.ibm.com, npiggin@gmail.com,
        Gaurav Batra <gbatra@linux.ibm.com>, stable@vger.kernel.org
Subject: [PATCH v2] powerpc/pseries/iommu: switch to Default DMA window during kdump
Date: Mon,  3 Aug 2026 17:40:29 -0500
Message-ID: <20260803224029.60538-1-gbatra@linux.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE5NiBTYWx0ZWRfX2vGAiNP6Al7j
 1oCNrtmsofOiHRHwos36upy+LOs1LA0V0SVLa/H20uq/gWMTjFZEGbCYXYNUce4ljps+WG+brzs
 peAcpu1vT6bQ2txtPFfax1zVGosTCKY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE5NiBTYWx0ZWRfX9YmTssqJ2ko/
 KZWYwLUHRMiQopxZwB2CJ/UV9+i1MGNslaboC3BiYi6CTsfWDFtbC6G6im5VhE/98QnkQhydAph
 EXiSz0AuEcz8Wz9pvsEtJjNb+hJT163UyhsPRrpyKH85NMHaJ7tVPntriFd6JG9Xo1Fo8XmgpaQ
 qvRIT0D3OzyQuhaIXAyAYVtizSdwysHrxYCVw+xYvZklJ0bCyadBFItN91N6oaNNvp7Ev/bsqFT
 AJ25x5wPJY2QHKizw0Cl/RA9NSquHO0tirZE0f4Rou9llrcJxuEe2Dtes54yz2Cqz5Wzp7P5N4M
 Agcp0UUiDjDL3xGi7sLTPgwl4IVcVczyq6wvIfJm+QmHnCArWmblTB8q89HBNQ1cc+FW2iFlywo
 redeN5imtUV9AJRgwr3BK5unOFN22l3DwzpGGa+ApPUBQ3tlDVbDxaCkXdtqcUBHLqvCzGa2Pg+
 ctjJ3h2jVY3W12LLUMA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a7118e3 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=Cugy0JS6tUXJvBfQomMA:9
X-Proofpoint-ORIG-GUID: 0uW7D04yKryxFd1GCGHFJpwNY8pxFlts
X-Proofpoint-GUID: dcQVI81vEEJZ7zTlq4wYuAko4sJ5MJ8a
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_05,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030196

In PowerPC (pseries) a non-virtualized adapter will have 2 DMA windows -
2GB default and a larger Dynamic DMA Window (DDW). DDW is large enough to
map total RAM to a device.

During normal functioning of OS, since RAM is pre-mapped, 2GB default
window is not used. The only scenario it might get used is when buffers in
pmemory are mapped to the device for DMA.

As of today, during kdump, during early device discovery, pci_dma_find()
finds that the device has 2 DMA windows. It selects to use DDW. This is a
kdump path and DMA window is needed for IO to the device.

Although commit 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not
initialized for kdump over SR-IOV") fixed an issue during kdump with SR-IOV
case, but this also made the kdump prefer DDW over the default DMA window
when both are present (dedicated adapter case). Since the DDW is fully
mapped by the previous kernel, iommu_table_clear() can free only
KDUMP_MIN_TCE_ENTRIES (2048) TCEs for use by kdump kernel.

This is not enough when the dump device is NVMe over Fibre Channel.
Because nvme-fc driver DMA-maps the cmds and resp IUs of every
pre-allocated request and each such mapping consumes roughly:

    32 (IO queues, one per cpus = nr_cpus) *
    64 (queue_depth, blk-mq kdump limit) *
    2 (cmd+resp) = 4096

This is already double of what we have without counting admin queues and
lpfc driver's own allocations / mapping requirement. Hence this results
into iommu_alloc failures like -

lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 00000000d814df0b npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.
lpfc 0153:70:00.0: iommu_alloc failed,
tbl 0000000034ebcf5e vaddr 000000009779e4d2 npages 1
lpfc 0153:70:00.0: FCP Op failed - cmdiu dma mapping failed.

iommu_map_phys+0x1c4/0x1f0 (unreliable)
dma_iommu_map_phys+0x54/0xa0
dma_map_phys+0x3f8/0x590
__nvme_fc_init_request+0x110/0x300 [nvme_fc]
nvme_fc_init_request+0x60/0xb8 [nvme_fc]
blk_mq_alloc_map_and_rqs+0x388/0x510
blk_mq_alloc_tag_set+0x2a4/0x5f0
nvme_alloc_io_tag_set+0xe0/0x1e0 [nvme_core]
nvme_fc_connect_ctrl_work+0x85c/0xdac [nvme_fc]
process_one_work+0x1e4/0x5a0
worker_thread+0x1ec/0x3e0

Increasing the number of free TCE entries in iommu_table_clear() will
increase the probability of hitting EEH since there could still be some
active IOs from the previous life of the kernel.

Hence this patch partially reverts the previous fixes commit and
switches the kdump's default back to 2GB default DMA window instead of
DDW window. This window will mostly be empty. Or, could be slightly used
if buffers in pmemory were mapped for IO.

Fixes: 09a3c1e46142 ("powerpc/pseries/iommu: IOMMU table is not initialized for kdump over SR-IOV")
Cc: stable@vger.kernel.org
Signed-off-by: Gaurav Batra <gbatra@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
Change log:

V1 -> V2

1. Ritesh: Add more details to commit message that previous patch
   is partially reverted.

   Response: Incorporated changes


 arch/powerpc/platforms/pseries/iommu.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 3e1f915fe4f6..272e9aab66d4 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -812,18 +812,11 @@ static struct device_node *pci_dma_find(struct device_node *dn,
 
 	/* parse DMA window property. During normal system boot, only default
 	 * DMA window is passed in OF. But, for kdump, a dedicated adapter might
-	 * have both default and DDW in FDT. In this scenario, DDW takes precedence
-	 * over default window.
+	 * have both default and DDW in FDT. In this scenario, default window
+	 * takes precedence over DDW. For a dedicated adapter, default window will
+	 * potentially have more unused TCEs.
 	 */
-	if (ddw_win) {
-		struct dynamic_dma_window_prop *p;
-
-		p = (struct dynamic_dma_window_prop *)ddw_prop;
-		prop->liobn = p->liobn;
-		prop->dma_base = p->dma_base;
-		prop->tce_shift = p->tce_shift;
-		prop->window_shift = p->window_shift;
-	} else if (default_win) {
+	if (default_win) {
 		unsigned long offset, size, liobn;
 
 		of_parse_dma_window(rdn, default_prop, &liobn, &offset, &size);
@@ -832,6 +825,14 @@ static struct device_node *pci_dma_find(struct device_node *dn,
 		prop->dma_base = cpu_to_be64(offset);
 		prop->tce_shift = cpu_to_be32(IOMMU_PAGE_SHIFT_4K);
 		prop->window_shift = cpu_to_be32(order_base_2(size));
+	} else {
+		struct dynamic_dma_window_prop *p;
+
+		p = (struct dynamic_dma_window_prop *)ddw_prop;
+		prop->liobn = p->liobn;
+		prop->dma_base = p->dma_base;
+		prop->tce_shift = p->tce_shift;
+		prop->window_shift = p->window_shift;
 	}
 
 	return rdn;

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.52.0

