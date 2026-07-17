Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C323FADFC
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784291847; cv=none; b=Xt+i16BAIZJQraayM/gPq6cipFhziT1nH9DcVaTQOgwe9Zn/vpQ5lHD6R4peycTqTNyehfRytI0MYA+PVI11w/1q3gRCbjsWBa1D0kim3oJYMxUDACxd3p+Mo0s3fpaitEEHYGELY4vQzkyI6tGbTG7lInqUgnivsr4E1LMVpfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784291847; c=relaxed/simple;
	bh=tdkXLx/uIjYRxlxI3SsmfBwUx18merN3vrX4uE+v1gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JkrvhVepZHRZkYVK6eJQnbox1+VcbEJlbDSwnCNZghHDCa5mOa78iZ0hEbUat4KtasWkpIfINTGISKVCucd14hdNqFHdHdXuGGFMJDMF3MTasfKBkBzzDAOM34u+pdeLU8HsVJnbAZLTkYs2m7txKEvanrFFufHNO8cIfVs8kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kQ3VxSSV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kQ3VxSSV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66HAfloM1716084
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:37:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9lOcgZpQ3h2mCH79CZsBZkOvcvMy2vA/lZhmIozLX
	8M=; b=kQ3VxSSVEh9spwtJUvuufjPgijjkQFlRxtMS86OgEQafRvxij7WnnZFyt
	ufN0aUw5A2h/M5i6qFoPPHMj0KPwbWowfGheSEulMdt/mDFe6L22/y6+o28GKoEu
	w1um30ihLrY0EszzcMSR98T/V1wwnZSNjgmbJ5eo8yNGWEsfUCxpIjFTmi/ls0/z
	59mGZlEV2NTJJcm4fjwNHDiF71ATclR0vKfice59rwHrTQJfRb6tY00AXtBAY1fq
	ajm1eEfohMI2WYoLpLRLH+4Qi0QT/0jI9jXbD8EMR/LlHBd8bny9SFWqUR457pTS
	/fZZo53ixhAZPrPhMEgGdp5cnVkfQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2ands5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:37:22 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66HCYd16032293
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:37:21 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qhu59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 17 Jul 2026 12:37:21 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66HCbF4O62325140
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Jul 2026 12:37:15 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4222B20043;
	Fri, 17 Jul 2026 12:37:15 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2486520040;
	Fri, 17 Jul 2026 12:37:15 +0000 (GMT)
Received: from a46lp05.lnxne.boe (unknown [9.87.84.240])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 17 Jul 2026 12:37:15 +0000 (GMT)
From: Eduard Shishkin <edward6@linux.ibm.com>
To: linux390-list@tuxmaker.boeblingen.de.ibm.com, sth@linux.ibm.com,
        hoeppner@linux.ibm.com, oberpar@linux.ibm.com
Cc: stable@vger.kernel.org, Eduard Shishkin <edward6@linux.ibm.com>,
        Volkan Unal <vunal@linux.ibm.com>
Subject: [PATCH] s390/dasd: Fix the leak of references on DASD discipline module
Date: Fri, 17 Jul 2026 14:36:59 +0200
Message-ID: <20260717123659.51834-1-edward6@linux.ibm.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE3MDEyNCBTYWx0ZWRfX1Tb8flDJZzuk
 67T7fXyQJyaHMwr5cQwv6U7kGf/nMn+17sHMnGwhP5b/mbutj+lpCwujm7ufN14OpuF7MyGT2Nu
 rtfEp+/y6/TRtC5cOAnZmZjiKZDtPa0=
X-Proofpoint-GUID: WOMeNIWECqzD2zAYLatpbOUGDM1ZSyz3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE3MDEyNCBTYWx0ZWRfX/atGdDt/pubU
 TYDardxYAYA1/al85QUJhw3oUQDC9HgWNrIU4O5VGenUDjKYizeSzvsj0rxpCgh97uXEoiTHwJR
 EjWTytfXW7UkMSZpW4e5XQaxM7OUAd3Q4R5VGEgiLnC5VPZJyQN3bfNjp1xZg9tLaD98vVZNW1q
 ptLFJHmaNER832RsB0agCHyhQXoGso0sSi863wbrEsApIqcmYJoscJm9v0spPsTxQ+RbkpAVFA0
 0f/zuovyeZI09hXMZNhDwSAHVmUwQ0WecbUZ+Vq1/YX/kjRswDXiKUu+M1QzOUQ/YLr1ntq9PF6
 TC6NOdgAZAumcow8AOf49MQ1HVHoqsWq0KELUrcn+vekcU2PXXOZXFRED2q7YhqaQTYH+1NH1o9
 VN44j4hNktizEIIPm63rjxGnWTV5vGipSHaahEPepkFYnnu+JQdrrNoeliYR7cogbEcO6049/nc
 FBrM8touqiPRGzXGn/Q==
X-Proofpoint-ORIG-GUID: WOMeNIWECqzD2zAYLatpbOUGDM1ZSyz3
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a5a2202 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=6DgnVkiGh2xwanU8t6sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-17_03,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1011 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607170124

In dasd_destroy_partitions() instead of fput() use its synchronous
version __fput_sync(). Otherwise, dasd_delete_device() can be called
before dasd_release(), which makes the last one not release the
captured resources, as the associated dasd_device doesn't longer
exist. In particular, the reference to dasd_eckd_mod is not dropped,
reasons why the module cannot be unloaded.
Steps to reproduce the problem:

\# lsmod | grep dasd
dasd_eckd_mod         180224  0
\# echo 1 > /sys/bus/ccw/devices/0.0.ef01/online
\# echo 0 > /sys/bus/ccw/devices/0.0.ef01/online
\# lsmod | grep dasd
dasd_eckd_mod         180224  1

Fixes: c8e108d80cd8 ("s390: port block device access to file")
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Tested-by: Volkan Unal <vunal@linux.ibm.com>
Signed-off-by: Eduard Shishkin <edward6@linux.ibm.com>
---
 drivers/s390/block/dasd_genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
index 930b47acdb8d..8a878c346799 100644
--- a/drivers/s390/block/dasd_genhd.c
+++ b/drivers/s390/block/dasd_genhd.c
@@ -213,7 +213,7 @@ void dasd_destroy_partitions(struct dasd_block *block)
 	mutex_unlock(&file_bdev(bdev_file)->bd_disk->open_mutex);
 
 	/* Matching blkdev_put to the blkdev_get in dasd_scan_partitions. */
-	fput(bdev_file);
+	__fput_sync(bdev_file);
 }
 
 int dasd_gendisk_init(void)
-- 
2.48.1

