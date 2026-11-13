Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579058;
	b=eHv8OzkX0LbLnwKcOwrSoUlGhyD+3a6xlq6jN8zBPeihMBftcGQViJ+O7ylakb+d4ygk
	 IZN9208fslj1aZ+uea0JQpHIhi4uowMEjwL1RxEXBjaPNeMcszpqos1ETQGI5cZY/6vwi
	 lbxfdQ2HisxrlObjrw+3CGsLQZkFPezbngDlggHVRH55JbegKY+XXRmAJR+brgf4yQcHn
	 VOBMEVyb0BzwPTMP4mT0Lc3djIK2rWxtIe/53BucFRfa8g0JpiP2K549F+1v+o1Ge5RTj
	 24H2Y+i0bpdSS8zUklc3W53beMAAkmSI4cn+Xp2O7nx8/4xH0GcQpT2Ro22gRvnm4nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579058;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=v7DQWzGydV1/TLKS+9lhZRWJfOwXzC0yKaRgkg3cPDU=;
	b=YUd6rK8YNqVzKEIo4f+M9dT6OO6inmAtqQDUWHQNM1o3a30bDlR3+qHkQHO2LUKEmEUX
	 FDrJLVQUoOqA1L69jAHKdDxJu5PpONuci5lmCeLo2Jh/dLJkrmI1Veaqs1uwJQvl3DwPH
	 dsZtbQjM59idSQZGyyUBaK4EB+G6yxa5SL+VuKafir5Nh7ke77ZWN39NZioeGPLgZRojK
	 QTrSyJT/vT//3LPUFDBP9eY+Ede6rJkT2Ik10xYUB7gpGCxc8pdz+UKoiQOs4d4HsLNzM
	 T75YUrOLTAgDGsyExJ6qWp0q6lSxinJ4n7r6Ban9OmRti9sPT4MKx750w/FyZJVPaMw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bwa+1aNM;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8906F606A891
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8906F606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=bwa+1aNM
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEIcl2835557
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v7DQWzGydV1/TLKS+
	9lhZRWJfOwXzC0yKaRgkg3cPDU=; b=bwa+1aNMSmogDcWZZRRcKRERznb7pUgDm
	tD4vECcXRz6k6uSEhvi302zLayLtWq3ljqOIGUnP4RRJGnyXOLPW5Xsr4KDSQPpE
	ok/LaLszM3md2Dhtl+t1hqeSbPu5ASmzUiMU8aCgWedI+L0HadIz1vk5sp4WHrU/
	o9YcVgTK0ssCvi5EYwwmsjHdkIcEwQxTyQrJJpThG8EiPVM1kS13QJv2CvI6O/56
	v5vAjpltBwoOkZJ0MkRRtOQMSIn+RHOvyB5wC4eo4hov2TL/GaxEXkl0rtszwcFO
	bPOK3ijLQ9vWyXLcnphhAPu0YGykyh/zzNM3W0gmhn1S8KeOkn3ng==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hssdm3dhd-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5FI32213396
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfc3t2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAsBe62652778
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:55 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9B3D58058;
	Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B83458062;
	Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 11/20] s390/vfio-ap: retry PQAP(AQIC) disable while a state change is in progress
Date: Fri, 13 Nov 2026 09:10:33 -0500
Message-ID: <20261113141049.3747719-12-akrowiak@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261113141049.3747719-1-akrowiak@linux.ibm.com>
References: <20261113141049.3747719-1-akrowiak@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=POqaavqC c=1 sm=1 tr=0 ts=6af71a70 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=VPjpLeehNduuY1rU:21 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=nfRqUt65G2hdjZyZGN0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX7446w0uEBjdm
 zFWiBERaiCHN0seCA0pFxFkCYBLz2ThNSwbnlRGMHhFSfcMfXWRsJH4NHV9WOXqgZ/Zd7haJUzN
 Edh3N7mWJlK3jBo+sVxkKt9khXVjTM54h53Im7o9WmGa5rhNe6lBigIzu6WGoK5kgLPx0GyDb3e
 7YEkZxLO6XYYvQGf0MKJAEykVARW+9NhJSFvJlkCpjgSwLsLK0vw/DjoxPtTkdQEVLR6nk8eP/l
 PVjVAFlzxdeX2PSRMQw3cwW0n6WR6DQ9gQXnJ271/6YNuKoMiV6VbiRLu6PVYkqXyhaMaLwiDYm
 U/3Zmsjrhd8Vt1aHrdSO1Vtj+KosPQwj4f9U3noeUyU84IoU6KEdbajUS0Jide3b20wkYDZQQ8A
 o0ad0X6NwyxDz3LUsvZkB7N0pEqBIpOEODfbZ6x+jgJWSEwN6tgONDhGFJHeMgIxV01aOtB27x5
 aLkcl7Kz3YZAVDZUtmw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX6A4Ov5zUEXch
 Yeytpv6H/kjPWD/yKzyGu+WWA/u/89PieDeG8sRI0rYYO9rLPfNSYs4JKO0uBCCFX9DQmgIC4Am
 /wGWjboUtxzvayu+ADFb0NBzUN8H8Ws=
X-Proofpoint-ORIG-GUID: iJYFPiFgCoOsCTQDqlxvR3-mhFYVmmmf
X-Proofpoint-GUID: iJYFPiFgCoOsCTQDqlxvR3-mhFYVmmmf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

vfio_ap_irq_disable() retries PQAP(AQIC) after sleeping 20ms if
the instruction returns AP_RESPONSE_RESET_IN_PROGRESS or
AP_RESPONSE_BUSY. AP_RESPONSE_STATE_CHANGE_IN_PROGRESS (0A) is a
valid response code for PQAP(AQIC) which is just as transient, but
it was not handled explicitly and fell into the default case, which
treated it as a non-operational queue and freed the AQIC resources
without interrupts having been disabled.

Treat STATE_CHANGE_IN_PROGRESS like RESET_IN_PROGRESS and BUSY:
sleep for 20ms and execute the AQIC again.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 97048d9fa2b0..dec69f3ffb8b 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -463,6 +463,7 @@ static struct ap_queue_status vfio_ap_irq_disable(struct vfio_ap_queue *q)
 			goto end_fail;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
 		case AP_RESPONSE_BUSY:
+		case AP_RESPONSE_STATE_CHANGE_IN_PROGRESS:
 			msleep(20);
 			break;
 		case AP_RESPONSE_Q_NOT_AVAIL:
-- 
2.53.0

