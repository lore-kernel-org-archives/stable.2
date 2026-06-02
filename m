Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C983019C8
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 16:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780417347; cv=none; b=CLzjzOHlbqWbQ2Ki1chb5XHy8ISjKIp/mZBz8h8Pk4o1UBljIBMyukgTXbjLFj2xDQV+mj3zLSavogcoOV1TORv6VWWJcGZ4xRBQvcrQBnrayRkhyhNNZ18LspLJnjAbS3c0R/ZWBr2jBR1aLeaqXy49XdCcdrDhMkdXyf94KT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780417347; c=relaxed/simple;
	bh=xkACl9+sxI4tZzPlLFqW3qwnBP+2W7m/4w12GQDnqGE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U8YbaptQUqH7LsyWk6mxcIx5v/lxKMgfoFbhpoGRzQ5AMWc1nGdkClrjsEJ6z+foSA9g70gampzyV5g+3bKupORdro0G+HD1Zfx71ArROz6N/FFhVJIcM+KImaLOgn0ehyCnxuP4AWK40k1YNt07GTbetrVtXSsDgw+e8JTlhWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BQACcOwW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BQACcOwW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 652EmYrQ063649
	for <stable@vger.kernel.org>; Tue, 2 Jun 2026 16:22:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=GIxTNrJCFu+FyccwF
	UDBdqLTHOr2ehkyRnMGiq/dn0Y=; b=BQACcOwWFJqj5/JC3bZu/5lH3VCLyk4wv
	aCnjBy3uDFvgevUB+NIiL23/TptcX1WSigNhqQH4rGpd2vB5dDVm5446exhPNLIa
	hA8gVP6t6pIqpnXxf/mnKzdUuHOQOqUQyOJUkTZMNloTBVJyifwxFsYDqq7xIGXF
	T5TgDmtTNMQRchFKp9rJ1inuAC0JtH8dEOWUM1g4g6HftGcBROejLCs3/UGlH90n
	eggfBmxif3cOHG7xti0BdPlD/MJKfAVnHCJ7Kl7O5NpJRpiDa0K71m4XTvTns5nO
	twvNSvlgc0Tsd8W3N2hkpEI9pm65XDcJc4AUT0hKuEPamCVyiN4sg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4efqm4xuxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 02 Jun 2026 16:22:25 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 652G992a017311
	for <stable@vger.kernel.org>; Tue, 2 Jun 2026 16:22:24 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4egcwybs1n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Tue, 02 Jun 2026 16:22:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 652GMM0e49480066
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <stable@vger.kernel.org>; Tue, 2 Jun 2026 16:22:22 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A9292004D
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 16:22:22 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 685F12004F
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 16:22:22 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP
	for <stable@vger.kernel.org>; Tue,  2 Jun 2026 16:22:22 +0000 (GMT)
From: Peter Oberparleiter <oberpar@linux.ibm.com>
To: stable@vger.kernel.org
Subject: [PATCH 6.18.y] s390/cio: Restore GFP_DMA for CHSC allocation
Date: Tue,  2 Jun 2026 18:22:21 +0200
Message-ID: <20260602162221.988946-1-oberpar@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052823-pavement-affirm-22a2@gregkh>
References: <2026052823-pavement-affirm-22a2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: UdyxtYE2bmb7rsKaVa-Kb0CVec0XdLL4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE1NSBTYWx0ZWRfX42bxqj84n6iP
 hmo6Xh9Nil2a+mZef2AI62i1OxDM6IhoFIuzcf26APCm+0GhbLWFOwBupqWGEpsc3Z3Yt/YKnxZ
 VIXRHWOHpZjJS1sAVqRExXqPCNS72KfqfnLlOMpT602la7OeM6GNFnj63d9Hi4T4LwVV1k+UQfQ
 MVsAZ7wSmtDsvrzgZWj+3X0hqhdbDr4YAeClFShXe+XX3lWoNqEO5eJICJ0eTFqAJpI/0XyhwjH
 f9t9aL+BgF9BvAR2NkWyZDtOfNwIWDAdkum6i90mGJTA0i3YmOBFjcs+Fhj1bIWnAwBirpNlB8D
 x01tQmjrCprW4yiosw6njPqZ5t4kuWg/VMiQgBXC/P/Uy+L26HQ4miJ4klNxGE8N51d9/R7AyQ1
 PiZVmJZf6kwuiw/r218z+7PPmevigBudtZnGs+GNcdAU1PmdSXAwv0pX52J+jMFKCdKOD/cZWzs
 Hoch79rBYd80rdpkrjA==
X-Proofpoint-ORIG-GUID: UdyxtYE2bmb7rsKaVa-Kb0CVec0XdLL4
X-Authority-Analysis: v=2.4 cv=Vf3H+lp9 c=1 sm=1 tr=0 ts=6a1f0341 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=8SZ3sY9okZyLWmRNyBMA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 adultscore=0 bulkscore=0 impostorscore=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020155

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
index 239c92d4ec11..b5f6eb18ebad 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1143,8 +1143,8 @@ int __init chsc_init(void)
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
index 9b4da237a0ed..f4faa38a4b17 100644
--- a/drivers/s390/cio/scm.c
+++ b/drivers/s390/cio/scm.c
@@ -229,7 +229,7 @@ int scm_update_information(void)
 	size_t num;
 	int ret;
 
-	scm_info = (void *)__get_free_page(GFP_KERNEL);
+	scm_info = (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
 	if (!scm_info)
 		return -ENOMEM;
 
-- 
2.53.0

