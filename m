Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497851CEAC2
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 15:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780415345; cv=none; b=L6W4mlpOn1QHBY610efVMBGJC+S3N3FnaRuYfuN3P78m07lDtS60DMdXwmQYeMpujB7buUOPs8SOw3MaphYOF1/rF+2uJr9t8Lk4oOD5y0O5H2xLyyqXcl+ewY7qKDj99Gc2RyeTlmYkQ6ISN2W1HvFXFvxleNTidlQh9GsByq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780415345; c=relaxed/simple;
	bh=+eLvSsYQyFCJQ7bO5gQHkRjfmAWoQUcHPEOZme3fZrw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cGLe1Zb/2lHKsDf9Bbu3ehS6Z1eUeZZlkoXuB2zaEJsMo2DdAdtnELJirKg8HCEaLG7LFQN3Cp+MXeB6Y7yzA9VrQurlxqqzR4j+nS3RDndxSblvA9XtnebaQGH+tUTOJ5nfbN8xu+YJ3QItcVwqhDf9CQP1JjtC7FRjnMR+vyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ns7qlyFS; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ns7qlyFS"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6528S6sU2708324
	for <stable@vger.kernel.org>; Tue, 2 Jun 2026 15:49:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=c4TvMJWoEycB0OtTw
	+glbO0CqV0SQo6y3MjbUtH+hAg=; b=ns7qlyFSvfU0z2ICfYe/b/auAIrRZ8Ek9
	V13yreohw4vPHU1vNLCRcjBFtvEc3XIEt08SoqrkhM641OH5yqkknyVqKUm37Rz/
	KpmtRebTBTS9ex3f+vZu9upHz2oQkArWmeDlmb4KU+r1UjiTAQ9vayicBvTQUAhn
	rYSohJTbJKii6ju6y+tzfAr1isa8Yh7Hu7ReQJ+rl334dV1h+lh2q/sGAc6u7zY5
	iS3rgDL6B1JcHPkJ1a/2WdTijXr/CJCoNpUAEAbuyKB+vICLeabdVh0aoBJybhsd
	vmYZNotZFN64DGUb2Go6OxfCtZCKhHKsiAgDXaZ8A33V9NsyaMGzw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efnahpgf4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 02 Jun 2026 15:49:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652FdBSc031223
	for <stable@vger.kernel.org>; Tue, 2 Jun 2026 15:49:02 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4egbqhbusy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 02 Jun 2026 15:49:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652Fn0ni29688142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 2 Jun 2026 15:49:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C9352004B
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 15:49:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE77120040
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 15:48:59 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 15:48:59 +0000 (GMT)
From: Peter Oberparleiter <oberpar@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.12.y] s390/cio: Restore GFP_DMA for CHSC allocation
Date: Tue,  2 Jun 2026 17:48:55 +0200
Message-ID: <20260602154855.365104-1-oberpar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052823-removing-pretended-b7d6@gregkh>
References: <2026052823-removing-pretended-b7d6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE1MCBTYWx0ZWRfXyJrLl2O8pic+
 cA/JFFFhib1FJhjBrO/MrT1OCrrkHqOqUyUmKwnwO8CEkalsUDzR/9nADBAwNQSQxZ4lkCQKXLT
 esTXpcnB4FTKKiYYt4/4uu9+vFsMbYlIBo2yv/JmE0xJ6QuQvdmsV8Am+FAnZhZKM2GCJiIl6Gr
 tBs14tdYDgpzG8EGvDDXqQx1T9c+kvTL4tBGYU+6s2CXtA73SXA/ZphYsk1nwHR2o3vgC6ZIFA6
 UvtIQ2Mr0ENDAbNF292EuLFWKi1Y2/c+Hbc0MzeCznkvjMkqd38SU+mL7nb5+VdPMppLzoG/IZ9
 OQ0Fqn0MDEgcdz3nHDe7sPa0d9JwmjOqQrShd5T3OWLW4HbaLESDGyav07y6A4qfBV1y8Ba1wWZ
 t1xctYOYKXQuCclRcouBmNXRu1MGk+MazZs+eszJ53Q+hcFZzBBh99GZs+CbsDqB+oIDIV+v5d6
 xyZaT6eKMpMkFgJRVQA==
X-Proofpoint-ORIG-GUID: F4vWKkoLL1pd5pCy8JG5BhOHVugk3fC1
X-Authority-Analysis: v=2.4 cv=cOzQdFeN c=1 sm=1 tr=0 ts=6a1efb6f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8SZ3sY9okZyLWmRNyBMA:9
X-Proofpoint-GUID: F4vWKkoLL1pd5pCy8JG5BhOHVugk3fC1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020150

[ Upstream commit ea34567db0a6b3a7ce78ba421592344315c8f90e ]

Re-add GFP_DMA when allocating memory for CHSC control blocks.
On some supported machines, CHSC cannot access memory outside
the DMA zone, causing CHSC command failures.

Cc: stable@vger.kernel.org
Fixes: a3a64a4def8d ("s390/cio: remove unneeded DMA zone allocation")
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
[ adjusted context to account for missing commit bf4afc53b77ae ]
Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
---
 drivers/s390/cio/chsc.c     |  4 ++--
 drivers/s390/cio/chsc_sch.c | 20 ++++++++++----------
 drivers/s390/cio/scm.c      |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index dcc1e1c34ca2..8fe6658dcfe1 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1153,8 +1153,8 @@ int __init chsc_init(void)
 {
 	int ret;
 
-	sei_page = (void *)get_zeroed_page(GFP_KERNEL);
-	chsc_page = (void *)get_zeroed_page(GFP_KERNEL);
+	sei_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	chsc_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sei_page || !chsc_page) {
 		ret = -ENOMEM;
 		goto out_err;
diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
index 1e58ee3cc87d..9131ce3af1b8 100644
--- a/drivers/s390/cio/chsc_sch.c
+++ b/drivers/s390/cio/chsc_sch.c
@@ -293,7 +293,7 @@ static int chsc_ioctl_start(void __user *user_area)
 	if (!css_general_characteristics.dynio)
 		/* It makes no sense to try. */
 		return -EOPNOTSUPP;
-	chsc_area = (void *)get_zeroed_page(GFP_KERNEL);
+	chsc_area = (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
 	if (!chsc_area)
 		return -ENOMEM;
 	request = kzalloc(sizeof(*request), GFP_KERNEL);
@@ -341,7 +341,7 @@ static int chsc_ioctl_on_close_set(void __user *user_area)
 		ret = -ENOMEM;
 		goto out_unlock;
 	}
-	on_close_chsc_area = (void *)get_zeroed_page(GFP_KERNEL);
+	on_close_chsc_area = (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
 	if (!on_close_chsc_area) {
 		ret = -ENOMEM;
 		goto out_free_request;
@@ -393,7 +393,7 @@ static int chsc_ioctl_start_sync(void __user *user_area)
 	struct chsc_sync_area *chsc_area;
 	int ret, ccode;
 
-	chsc_area = (void *)get_zeroed_page(GFP_KERNEL);
+	chsc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!chsc_area)
 		return -ENOMEM;
 	if (copy_from_user(chsc_area, user_area, PAGE_SIZE)) {
@@ -439,7 +439,7 @@ static int chsc_ioctl_info_channel_path(void __user *user_cd)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *scpcd_area;
 
-	scpcd_area = (void *)get_zeroed_page(GFP_KERNEL);
+	scpcd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scpcd_area)
 		return -ENOMEM;
 	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
@@ -501,7 +501,7 @@ static int chsc_ioctl_info_cu(void __user *user_cd)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *scucd_area;
 
-	scucd_area = (void *)get_zeroed_page(GFP_KERNEL);
+	scucd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scucd_area)
 		return -ENOMEM;
 	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
@@ -564,7 +564,7 @@ static int chsc_ioctl_info_sch_cu(void __user *user_cud)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *sscud_area;
 
-	sscud_area = (void *)get_zeroed_page(GFP_KERNEL);
+	sscud_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sscud_area)
 		return -ENOMEM;
 	cud = kzalloc(sizeof(*cud), GFP_KERNEL);
@@ -626,7 +626,7 @@ static int chsc_ioctl_conf_info(void __user *user_ci)
 		u8 data[PAGE_SIZE - 20];
 	} __attribute__ ((packed)) *sci_area;
 
-	sci_area = (void *)get_zeroed_page(GFP_KERNEL);
+	sci_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sci_area)
 		return -ENOMEM;
 	ci = kzalloc(sizeof(*ci), GFP_KERNEL);
@@ -697,7 +697,7 @@ static int chsc_ioctl_conf_comp_list(void __user *user_ccl)
 		u32 res;
 	} __attribute__ ((packed)) *cssids_parm;
 
-	sccl_area = (void *)get_zeroed_page(GFP_KERNEL);
+	sccl_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sccl_area)
 		return -ENOMEM;
 	ccl = kzalloc(sizeof(*ccl), GFP_KERNEL);
@@ -757,7 +757,7 @@ static int chsc_ioctl_chpd(void __user *user_chpd)
 	int ret;
 
 	chpd = kzalloc(sizeof(*chpd), GFP_KERNEL);
-	scpd_area = (void *)get_zeroed_page(GFP_KERNEL);
+	scpd_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scpd_area || !chpd) {
 		ret = -ENOMEM;
 		goto out_free;
@@ -797,7 +797,7 @@ static int chsc_ioctl_dcal(void __user *user_dcal)
 		u8 data[PAGE_SIZE - 36];
 	} __attribute__ ((packed)) *sdcal_area;
 
-	sdcal_area = (void *)get_zeroed_page(GFP_KERNEL);
+	sdcal_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sdcal_area)
 		return -ENOMEM;
 	dcal = kzalloc(sizeof(*dcal), GFP_KERNEL);
diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
index c7894d61306d..375cbfa31b53 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -228,7 +228,7 @@ int scm_update_information(void)
 	size_t num;
 	int ret;
 
-	scm_info = (void *)__get_free_page(GFP_KERNEL);
+	scm_info = (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
 	if (!scm_info)
 		return -ENOMEM;
 
-- 
2.53.0

