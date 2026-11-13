Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579055;
	b=QSYlh0DCALlpUvsZkSIYjwAXFbfV9cU1TzCXiPwF/BqTfiSwVfJRQG7aHoKzrZUQmqkV
	 tyCCWiFzAeGfHANrsbAgsuXnicZSfWMSndbmIIsS0yAB/ce0z7LFC18WcTv1+KT1br9yp
	 KDRExp6e94b8fxzsGUZLe4LYW4N7R+Hu7/F+82iVxWEhttMkqgPUv1m1dhxNYDQeA3kzD
	 y2fSjJO2D4j+08PwMol5uUTtJxmfcqWMMqxskMGsQI+8eEI8csYNa3X0qd7osbMkuaZbl
	 NCKGkGKXCPDt8/tDEqb2bhTwzdKMSzXrq9btzJkFs0vs4C/ZSpl5XErW3UPshixtlhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579055;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=zg2eNpfucvqHDhWIDeCkOUro8dKKsyBAxnHB7jsDinU=;
	b=vFWnYv9HgAG6aDNkCF4pYN5FRl/YeT+I69aqPN6P+KnJWVE43wSFNFTRZdl6hoNtjR/T
	 2i28nQqQYSMP8xPa2laIy1BaR3XBNU8T5JG7N50hNwioURsnFWMBTinntGbuGJJ8e2W4r
	 T3m9osbvlW05J/GNl6uzS5EA5I8kN8JuuTgr1weYBB2vFydqAHsi3SFOzxneE6Go3OAUm
	 bTbi6OO8pbpZsLOtDWxve6jvv50uHmsGM6boGSxIxOL1hKD3tAF+3jJDiQsGZQ80C1ZOd
	 Ly4QEAdX4oO1W4yz9rqDMX+SVNOGiPVR1fTJ0SVWWBca57hWM6khZV0Aka3FRj4631g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k3OiSzX9;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E69B606A880
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E69B606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=k3OiSzX9
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCE5S72888804
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zg2eNpfucvqHDhWID
	eCkOUro8dKKsyBAxnHB7jsDinU=; b=k3OiSzX9xPhdp4uklBbnFp1mEO51aWA/X
	Mf6qZKfW+lG04CnD9MVugO/QtfzVwt+mrhk0xfzhfwbBB4TYSli1W4wikKbODjnl
	x4bcNclMrE/NiA8FO2A3TF+8JFSxGVJC4cPGS56hhPb9iJadbnKH8OE/fCdtlXrX
	HliUnI2KiEpOrK/PU0piiPG5pgFUjOtHiVZf95Ps8ewiIJ0WzKT28H2CIZiakTVp
	PhWzfAiFaWq/AlSrl1gAaLMD3Uaw2U9iq1XbAhieesH1fkGiuUyYbWf25hUktc3j
	f0AUnO8TgLGaDOlxr9Ykf8O/P3Q3+3T8LFVdGeBGwBoLmdv3NGuQw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuq7bv5r-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5Yfs1149611
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:52 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hx26k8hg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEApdn25952862
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:51 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2592358058;
	Fri, 13 Nov 2026 14:10:51 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D59C658057;
	Fri, 13 Nov 2026 14:10:50 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:50 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 02/20] s390/vfio-ap: mark queue not passable if reset verification fails
Date: Fri, 13 Nov 2026 09:10:24 -0500
Message-ID: <20261113141049.3747719-3-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX9eHPUuL+XKUD
 M8jRhVSTmPLNkpJ6jK66c7uzK8s9KZVGOWaYdGA+sAYQThZUsPF8oW5Tb0EuWQ/Mjrf/lk0/AY3
 BasrJT13ysrVRjQXw39xcC5iHzHlafc=
X-Authority-Analysis: v=2.4 cv=HbCB3SE8 c=1 sm=1 tr=0 ts=6af71a6c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mf9qEuthGVhxNuJ0cbgA:9
X-Proofpoint-ORIG-GUID: UsY4KNwB-jzN5MnZkAsJW2QvR00HxVBn
X-Proofpoint-GUID: UsY4KNwB-jzN5MnZkAsJW2QvR00HxVBn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXx5UUGymu7c8H
 hWLuzkjzEBFZUILF7eko7VsFatlRJKAUWxkHzRux7Qbtr5izhfxU40OcT29XxjXHIczmg5W+2EB
 5by9YH/wCErxT2VMETUYgspvkQFeMv7JxviF2+UlbrFuHnwKyj+RLa35TACyNRk1aUF2jiY518E
 u/jav7U82kgEmC6j2pm9ATDt/OQUzBPRm2dKxt3B+uAEedQlnS1B0fe34LqYc6OArQOyhCFCcFB
 OhZR/RBpta1UgzCYqkItxxWouJtnYAQ8P+EN39t5yaMnLyJKtEulXZoUY99yFrFssCM1wy5Cdze
 rNDLKs5UnJQS/RSlFm7Iwx2QfC8IpNaikfye+xxMlhbiWMntoGoJIgucvvrDAZ9KEa2eIl035Zi
 vzjql9oN5mzAIshVC6EEM46lLj06YwKoYN4FWqFWHQUCjwgdeDznr77E0cUvwpLYa0Lt23gyO1p
 lgli8gOqPnrblNySoxA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 bulkscore=0 phishscore=0
 impostorscore=0 priorityscore=1501 clxscore=1015 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611130054

When apq_reset_check() gets an invalid response code from
PQAP(TAPQ) it returns without recording anything in
q->reset_status. That indicates a hardware or firmware problem,
and it cannot be determined whether the queue can still DMA-write
to the NIB, so the AQIC resources are intentionally left
allocated. However, q->reset_status still holds the result of the
ZAPQ that started the reset, which is typically AP_RESPONSE_NORMAL.
As a consequence _queue_passable(), which checks for
AP_RESPONSE_NORMAL, considers the queue passable and it can be
passed through to a guest even though the reset could not be
verified.

Copy the TAPQ status to q->reset_status in the -EIO path so the
queue is marked not passable.

Fixes: 9261f0438835 ("s390/vfio-ap: use work struct to verify queue reset")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 742e42ea0ec0..e6ffdd75af8a 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1969,8 +1969,25 @@ static void apq_reset_check(struct work_struct *reset_work)
 		elapsed += AP_RESET_INTERVAL;
 		status = ap_tapq(q->apqn, NULL);
 		ret = apq_status_check(q->apqn, &status);
-		if (ret == -EIO)
+		if (ret == -EIO) {
+			/*
+			 * TAPQ returned an invalid response code indicating a
+			 * hardware or firmware bug. Since we cannot determine
+			 * whether the queue can still DMA-write to the NIB, the
+			 * AQIC resources are intentionally leaked lest the NIB
+			 * page is reallocated to a new owner. A subsequent
+			 * wild DMA-write to that physical address would corrupt
+			 * the new owner's memory which could crash or compromise
+			 * the host kernel.
+			 *
+			 * Record the TAPQ status so the queue is marked
+			 * not-passable - _queue_passable() checks
+			 * reset_status.response_code == AP_RESPONSE_NORMAL -
+			 * and the queue is not passed through to a guest.
+			 */
+			memcpy(&q->reset_status, &status, sizeof(status));
 			return;
+		}
 		if (ret == -ENODEV) {
 			vfio_ap_free_aqic_resources(q);
 			return;
@@ -2034,6 +2051,15 @@ static void vfio_ap_mdev_reset_queue(struct vfio_ap_queue *q)
 		vfio_ap_free_aqic_resources(q);
 		break;
 	default:
+		/*
+		 * An invalid response code indicates a hardware or firmware bug.
+		 * Since we cannot determine whether the queue can still
+		 * DMA-write to the NIB, the AQIC resources are intentionally
+		 * leaked lest the NIB page is reallocated to a new owner. A
+		 * subsequent hardware wild DMA-write to that physical address
+		 * would corrupt the new owner's memory which could crash or
+		 * compromise the host kernel.
+		 */
 		WARN(true,
 		     "PQAP/ZAPQ for %02x.%04x failed with invalid rc=%u\n",
 		     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
-- 
2.53.0

