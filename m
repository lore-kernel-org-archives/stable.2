Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579056;
	b=Q1exLpS8eJJ3SGbDIMSFZDl0Es3+PrbBkCC3IsfNsAqSGbWJ7w7X7IkJpxAZIfeL/3VP
	 y5kVdJ7GDc9uX2+zfJgkmZajr0RuO7VUTCw+DhXQQHmY8CtJBuolByAYZT6KSKas4+AnM
	 xQyWZPJ6obdFO2YDkB/69Z6F4ew1bRJ3+vqkfY+Dx92kaPgXIfdDSAkQNyll3lXwVl1WP
	 r/ZEiCxtHJdO4ELpAsEm+KgBM8nNCCKTBHKwzkbuvNXvixgN/qXEvmoDvdi4QMa4A8QDI
	 DNXkQZ+U4cSeHU1NRheo7zu/TCDZVtWa7u+2u59Vm9xA+OFl4nDyH76K7gQLNzgnnZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579056;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=p66WTshRvdSrFZhhlOvSOhmqPId0hAqPBp1OsYmOGRs=;
	b=mi59cyDe+xvvpDfosEbIWCWRpsMogX9eeSMjVCMgr3x+JYi7r2MIFcpPc53fjYzlekHz
	 /wZw6bYtgvy3bBjVY/EI3O5HTIipzRQYfYnHDNTyRCTERlRaOAb6YRgnevWZhi3DaJUpA
	 pfwI8afQZZWgCbGPvWwU0iIVZoJjODMOwQ2HY2Nw5f6Br+zx1K1wJEN3kEUGgCTJ2ztxi
	 8oYZlkX1oXRiCLtjoNC+e0erzjNRNZR2u8yRPbInyCbjCf7O+ECIKy/+wMWMSq8TqnZPh
	 dljzZoBOTXkGaPuspzebJLpK3scyHk1N1jSq0eCwDXZBKmW0/epgWBThWD+qT5bpbXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UbVhz8sX;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38540606A88E
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 38540606A88E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UbVhz8sX
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEF9I2893567
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=p66WTshRvdSrFZhhl
	OvSOhmqPId0hAqPBp1OsYmOGRs=; b=UbVhz8sXTbFWeLXgKMo9w9JqasCgk+Kxk
	9W/g8BcSd2smTPwUNfrdCg5L46pz/Mk3BWq+tn1x080S8mMv1NbztMFIypU7amG7
	2Lqi2fFUaBqhj7M0qa0yn/qXnQAX/no3WSSf97eR7RuZkIZ35XGAXb8yeaOHrHWq
	XOlxTDjC6SEZfMU1cw7hiVh8UCdVmqXVs1fyIlBH/xYkmJJcBVVFUFdkb059GEW6
	HkPUB/syYGMc6xTOiOmjZpJ56Qm2pkBh3Oe0FNgvToPMzmG/+U1nsmKVaXZYpQTB
	B6lN5oOL55HBiNk4Knw5XZ6xUEOfbKqk7gY1BMYtf08HXIqPFbP0g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumvamw3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5ZN41149622
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hx26k8hg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEArZj29229660
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D29958057;
	Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3929358058;
	Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 08/20] s390/vfio-ap: reset queue if NIB cannot be unpinned on DMA unmap
Date: Fri, 13 Nov 2026 09:10:30 -0500
Message-ID: <20261113141049.3747719-9-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX9tjjqAp8VZZc
 Om9GuTGgVS0nKbRyRaNGDnXgAJWdiUjGhokqb9O+Cd6fj0ejBVKRLdrtz8iHUjIrCJaV1euYeWG
 Bmwu9cx5OtaEYeNXltoKa3SZrYjRjn0=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af71a6f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=wwRYo4IcpO_ja5H4RAcA:9
X-Proofpoint-GUID: 56Ikk_RZDAjnuuNUOPBaXHRQt4MUBg30
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX+DvAbTg6jidh
 eISun7ci8g8OhqucECeSqfKprOawZaGwF8WWkNwlnowAremk8C9nwD1LTSQqFVuNvde8PAT8zF2
 +YL6Kp2yHgtZmp1spObPr+0bYki24rL4s5dIXoKxETE/SB7ftPE7g5bEHy33yQS0UT4+lsK89Y3
 lMOTYFoY0ZfliB82oo+2Hmaw0aJY2wwWIyCyEhDbQf4/naXedJ03vst8RBptz27VGNp+7XMqTp/
 zYFKDR/kM7ndHmgaMFmjVEJf5eEvEqThcs/dxiAowVQ9fpcRRO+O5tnJ4fJM8/mSlXw9H/AzsnS
 f1TY+ioxKgyP0gzNEX6PZbXH5hGZNMt45u5ogFWnzwNigh6IzKMj3IN9PN4QeeArcIPUcJ8MABu
 n0e6nbHsucntL/JZJoiCmpELCwtYWPMDFPXC5yusl6vo+yqJ7iaasrIcJKa2fVJ9mdNGG+klSAw
 P/Lgz0BojYPOfZhT7AQ==
X-Proofpoint-ORIG-GUID: 56Ikk_RZDAjnuuNUOPBaXHRQt4MUBg30
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

unmap_iova() calls vfio_ap_irq_disable() for a queue whose NIB
lies in the range being unmapped, but does not check whether the
NIB was released. If the interrupt disable failed or could not be
confirmed, the NIB remains pinned. The vfio core requires that the
page be unpinned before the unmap notification returns, or it will
hit BUG_ON(++retries > 10) in the type1 backend after 10
re-notification rounds.

Fall back to a queue reset via ZAPQ, which clears the hardware's
internal NIB address and so eliminates the DMA risk, and wait for
the reset worker to finish. If the reset completes, the worker
frees the AQIC resources. If it fails or times out, force-unpin the
NIB and log a pr_crit message: a host panic is worse than the
theoretical risk of a wild DMA write from hardware whose reset
already failed.

Fixes: 2a54e347d990 ("vfio/ap: Validate iova during dma_unmap and trigger irq disable")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 40 ++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2d27c56a376e..2695ae08a9b5 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1945,8 +1945,46 @@ static void unmap_iova(struct ap_matrix_mdev *matrix_mdev, u64 iova, u64 length)
 	int loop_cursor;
 
 	hash_for_each(qtable->queues, loop_cursor, q, mdev_qnode) {
-		if (q->aqic_resources.iova >= iova && q->aqic_resources.iova < iova + length)
+		if (q->aqic_resources.iova >= iova && q->aqic_resources.iova < iova + length) {
 			vfio_ap_irq_disable(q);
+			/*
+			 * If AQIC disable was unable to confirm that interrupts were
+			 * disabled (IR=0), q->aqic_resources.iova remains non-zero.
+			 * VFIO core requires the mapped pages to be unpinned during
+			 * DMA unmap notifications (the type1 IOMMU backend will
+			 * BUG_ON after 10 re-notification retries if the pin is not
+			 * released).
+			 *
+			 * To satisfy VFIO core safely, fall back to a queue reset
+			 * via ZAPQ. ZAPQ wipes the queue state and clears the
+			 * hardware's internal NIB address register, neutralizing
+			 * pending DMA. Flush the reset worker so that we know
+			 * whether the NIB was released before returning.
+			 */
+			if (q->aqic_resources.iova) {
+				vfio_ap_mdev_reset_queue(q);
+				flush_work(&q->reset_work);
+			}
+
+			/*
+			 * If the NIB is still pinned after the reset (reset failed
+			 * or timed out), force-unpin it anyway. A host kernel panic
+			 * from the VFIO BUG_ON is worse than the theoretical risk of
+			 * a wild DMA write from already-misbehaving hardware, and a
+			 * pr_crit message records that the forced unpin occurred.
+			 */
+			if (q->aqic_resources.iova) {
+				pr_crit("APQN %02x.%04x: NIB page at %pad could not be safely unpinned after queue reset failure; force-unpinning to prevent kernel panic\n",
+					AP_QID_CARD(q->apqn),
+					AP_QID_QUEUE(q->apqn),
+					&q->aqic_resources.iova);
+				if (q->aqic_resources.vdev)
+					vfio_unpin_pages(q->aqic_resources.vdev,
+							 q->aqic_resources.iova, 1);
+				q->aqic_resources.iova = 0;
+				q->aqic_resources.vdev = NULL;
+			}
+		}
 	}
 }
 
-- 
2.53.0

