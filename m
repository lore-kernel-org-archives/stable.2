Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C88347536
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787252590; cv=none; b=GJZzDcwVsyWulxAIWrjpO2fgWAyqGnejEx5xgmB0Itm7gcSkbcj9WeUwy5ES2eTdvGTzV5SJ7yz/IjRbGgTychIpNUVdvdBuE+YbS5MMCvCspkeYZhi8lauTbGprCkb7mB8hxACaIlvYwdq2Cx+MZ94OmiYunNRbbcHqdzN1TjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787252590; c=relaxed/simple;
	bh=XaJ/mKhNk/Nn2qZQbiQOGH3wRXJp+mKdp4tJ1CtNReY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fZYa7r9M878X3KAr1QonZdXtOxKvMWZgb6JqEii5RLYJGnAPQ2P06xSMQDBs9xXG8Q5QDesLeVj5m8mgdspaybrcqyO9OOET6EZZTuV3dIefI06S6Gaku5hlsXtBiF4rbe2Ti2xmv7FenKL1l7h4mYFWm37K9m4nutOH18ApviM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=J49i3I/6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="J49i3I/6"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KIVxN73233122
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:03:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=O0+oqX6cK3c9QG53D
	O87tabIauERmc1+oMn+dHffDIE=; b=J49i3I/6E4L8cZmf8ezqpxzdHTIRoxa+H
	fkRxO9YiA4u1d8EX+AASGdgmvybd8P4RO5bsTDnkXos5DFs1GapDg39jmsdK2ZOw
	fUNQnWfVnIfaLJPXfpZ+L551csanBs99yCvxXijT5Pq0fXOF+oZ5cjPt7oGGsSXT
	wY2o7HkUvVu1oxufbQzg8SnOEjRO1zj4CrrFHDKs5MSlJNaUxv2IvSxdO5G8C8lD
	gMVvbc66MrLOVoVmoAwd7yRoRDxSKBWFh7mwc7rjwiKdOEz6+HXViuXphEdb1HeT
	1uKW+we8jZQ8fJMNsyR78dJsPknbOX1ZW+NuKEaGiXrVAgM992B2g==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu4cc5n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:03:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KIuJfC026751
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:03:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xhgawr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 19:03:03 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KJ32h69634356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 19:03:02 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EC1125805D;
	Thu, 20 Aug 2026 19:03:01 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 85D3158043;
	Thu, 20 Aug 2026 19:03:01 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown [9.61.78.161])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 19:03:01 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 6.6.y] s390/vfio_ccw: Ensure first IDAW remains constant
Date: Thu, 20 Aug 2026 15:02:55 -0400
Message-ID: <20260820190255.2688721-1-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082009-hankering-carded-0ce5@gregkh>
References: <2026082009-hankering-carded-0ce5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfX1WaFPEcl9Upd
 jCivHk6LYxp6g6JBkYcdD1qzCyVdBsjGTyH+pGsjl6XYuKsTbj6SEVFlb78Wa4yaDCK1awWooDm
 j4vW6tSzp1Xq0NWwFtO3qLks0L8M/q8=
X-Proofpoint-GUID: uLOdaq1EaiqfxACBhwoyYZy5-v46Yh77
X-Proofpoint-ORIG-GUID: uLOdaq1EaiqfxACBhwoyYZy5-v46Yh77
X-Authority-Analysis: v=2.4 cv=RPmD2Yi+ c=1 sm=1 tr=0 ts=6a874f67 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=KgjiO0RTK6bxKwqfJKkA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDE0MyBTYWx0ZWRfX9zymzvKTv3Py
 R4ID0pLnDIgKsiRNJLcaRiqr9jJ6oOpgpG4t316h0D8mVkVpMm3nsW8EVGle4adpxAIAvK62sCj
 wkYygNhXSTuY+eTLsDwWHFb0nafVNP544pzq3qAbaqune8opIMRwpBI7UIgr4pPGwJSZVD5rbMo
 Nypqmfa4pk6S5xN2InTsZihRo1ybvNb7OZsVDFLKouZ7hT2akKilTowUGY2Ze7tr5otaAquQxeP
 ZZdzvZYbn7iAeHJnFhyCCDpQ7lzSrPpTKqzRrc21z9/c4kEk4mgJCbPizQFLKRkiZKCsE2h4w74
 sNdUEauvYRPhp/EesukYn/+AtimljLFe5Gtfy99qW607468vtIgzLmzKtfToFk3/MWFBCxvRAs6
 5YqFA2syws57/cPVL97ti5d6Bb2j2lW/VmJohnl6O5qKuo1JWFe57RVjqTZ7pkhRfiy36evKl6l
 2MMLBBbbVw0sSkx5hpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-20_01,2026-08-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200143

The first IDAW in a list does not need to be on a 2K/4K boundary
like all others, and so is read separately to accurately calculate
the size of the buffer needed to read the full IDAL.

Verify that the address found in the first IDAW is unchanged between
reads, to ensure a consistent set of IDAWs being worked with.

Fixes: 01aa26c672c0 ("s390/cio: Combine direct and indirect CCW paths")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Eric Farman <farman@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 565bef268d75bf7df665bce6923a88cd0eb74592)
[farman@linux.ibm.com: resolved merge conflict]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 18 +++++++++++++++++-
 drivers/s390/cio/vfio_ccw_cp.h |  2 ++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 7b7ccaf2afaf..22bbdfa7076b 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -478,7 +478,7 @@ static int ccwchain_loop_tic(struct ccwchain *chain, struct channel_program *cp)
 	return 0;
 }
 
-static int ccwchain_build_ccws(dma32_t cda, struct channel_program *cp)
+static int ccwchain_build_ccws(u32 cda, struct channel_program *cp)
 {
 	struct ccwchain *chain, *temp;
 	int ret;
@@ -521,6 +521,7 @@ static unsigned long *get_guest_idal(struct ccw1 *ccw,
 		&container_of(cp, struct vfio_ccw_private, cp)->vdev;
 	unsigned long *idaws;
 	unsigned int *idaws_f1;
+	u64 first_idaw;
 	int idal_len = idaw_nr * sizeof(*idaws);
 	int idaw_size = idal_is_2k(cp) ? PAGE_SIZE / 2 : PAGE_SIZE;
 	int idaw_mask = ~(idaw_size - 1);
@@ -537,6 +538,18 @@ static unsigned long *get_guest_idal(struct ccw1 *ccw,
 			kfree(idaws);
 			return ERR_PTR(ret);
 		}
+
+		idaws_f1 = (unsigned int *)idaws;
+		if (cp->orb.cmd.c64)
+			first_idaw = idaws[0];
+		else
+			first_idaw = (unsigned long)(idaws_f1[0]);
+
+		/* Unexpected mismatch from earlier read */
+		if (first_idaw != cp->guest_iova) {
+			kfree(idaws);
+			return ERR_PTR(-EINVAL);
+		}
 	} else {
 		/* Fabricate an IDAL based off CCW data address */
 		if (cp->orb.cmd.c64) {
@@ -598,6 +611,9 @@ static int ccw_count_idaws(struct ccw1 *ccw,
 		iova = ccw->cda;
 	}
 
+	/* Save the read address for later */
+	cp->guest_iova = iova;
+
 	/* Format-1 IDAWs operate on 2K each */
 	if (!cp->orb.cmd.c64)
 		return idal_2k_nr_words((void *)iova, bytes);
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index a9b1d8dbc6f6..9af98ff12d67 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -35,6 +35,7 @@
  * @initialized: whether this instance is actually initialized
  * @guest_cp: copy of guest channel program
  * @ccwchain_count: number of channel program segments (linked by TIC)
+ * @guest_iova: first data address of a guest channel program
  *
  * @ccwchain_list is the head of a ccwchain list, that contents the
  * translated result of the guest channel program that pointed out by
@@ -46,6 +47,7 @@ struct channel_program {
 	bool initialized;
 	struct ccw1 *guest_cp;
 	unsigned int ccwchain_count;
+	u64 guest_iova;
 };
 
 int cp_init(struct channel_program *cp, union orb *orb);
-- 
2.55.0

