Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579057;
	b=tDcPRxBkzNX948YtIEBSovzxJGlBqVLDj1Yhv4SqvpTZIrAz/zUiLwmEcruauASHGMyt
	 aazJYPKMUNm/kMfw3chaGdKTRiMzssYM87lZ/Oi4+aFD75kQ84d7twdYDtvQGKBn/u1Kn
	 OjpCvkfDJrZqFmKhYrpc4ONJyVjowpXuRMFtaxEzRHVB3MXsYCmPpiijhYpleslwn/JsX
	 J1JTyteX+HZa/cHh3K4zGTdvaMHFu9MxAYOk0MSnQ+e/M3yxz/nZ/hRCy1zc2X1dCLwGW
	 3Z7SoEeXpqSygT+PWxSSaL3P7a2xraif7/PJEgkOPteIOryfJdM8F1htjOQTg0xLbRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579057;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2vZW84i9mrPy2931ozVGVH/o2iAKRMfS/8duy7CKiJc=;
	b=zix0JTV4bOi4aExQwb35wkFZOlf/gLYWKUVq4HeqjIsRYRxog4GFZIbmMEuPGVTFG2ma
	 Zvn0oPB8WwQ0y7dF0IvUjLneU/cVHg8d6D7wDne1DsZhB4ao/YKaOT4vzQxflsXpXg0D4
	 bQEmqFJLuDmyggJlDG0HDS1L7b8fxAP+fkhQCzTqGYKoDpRULoCHkS0ZYb7cvC4gj0YGI
	 Ki0lEnh1a/NWU3ySfsvIhOdF22Z55lZ6+rsx6QuH1BeHhWVSv2cLf/GHG4NTdsB2OT9FF
	 kewOOpCUpmfGhtqFzJr+2pHbrz0tggmR1ADJ2hs3ziypY1sbOUGzy4kpAosywUYbiyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="oa/uyq6K";
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8361F606A891
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8361F606A891
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=oa/uyq6K
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEEve2893541
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2vZW84i9mrPy2931o
	zVGVH/o2iAKRMfS/8duy7CKiJc=; b=oa/uyq6KXinoaDmp7XVTHVBDft51TMWEp
	oTn+MRlH5mSJkt6QqjX0YZjFSg+tYV/P2Diu7IKNDprokDk8Fpy2S7pB9zQOJCoz
	yonmD/6YJ1ctrM1FUsrIOyEO/WtaFCAkKK3UyJTnNTSU7TxeqqkSVIZFZdsf2Vuv
	jZH1r3ode7KQfp2sViUo3YprL//PMw2DdTm6dDBVbuxHmkqNeIMS08ylYJCuf6p6
	wvk9MUZxL/6meyWaAb4s49+QfxZDxYv9TMxf0YaWO0ckj7c1lGox4pTJTYj6pTGW
	VQzWrUX2Rq5mriQmuNSay2lMfoWR9MOfRObw2UeB/pJKA5pK/H6Bw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumvamw5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5GhF2213407
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfc3t1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEArxn29229662
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:54 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DD6AB58059;
	Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A01A58058;
	Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 09/20] s390/vfio-ap: free AQIC resources when unlinking a queue from its mdev
Date: Fri, 13 Nov 2026 09:10:31 -0500
Message-ID: <20261113141049.3747719-10-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXyWMH/R6srJ90
 eMV6GLFTnCNFL5BDrADtPc62FhN11os5yPnj93/E4Oa47iUM5ib18qcdY1/1y6wW8LXTfl7jZb7
 Xb9siMu2u/oUodsXsDbPw4XzSde//jY=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af71a6f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=9BP5yx_-W10PkVfpcqMA:9
X-Proofpoint-GUID: DcO82clOe8T-Hb-cPxirL8VgMkPWB755
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX2daYhzVT6cNZ
 raGZNMbgVkRh6Lo48Zd4v6nXZwImh02pGBooJVGcjf7ZKNi+MHOc3UQUj3U9WMAMkvMnimmh4FG
 AkuQbEVbql5qnDmUiblIKGeSAQTtVKO8SkoTsyGpSEXGDfeYNeKNH7N6phhpT4Q/lxTxubLNty9
 sS/ltHUaLfMpkESqpv/X6Gku02ek5w7LjbSratFjS82WM9LZ6gjK2EZMWEYSGLVJ2wnpNbgMqoq
 bAiPO1RudovTesr3iCRk+tAU4hvTSeA1LeGxtCLpddBFnq94EsD19wRaIaXVCnDV9xR+WhSSTdn
 rXkrVQ90OuRRUsc4A0KFUJtGbqYt//Yzci4wTMV1e+1mF0VthUzHJomfU4nLw4k86HBJkjhIcx4
 97BYc8x6Yv3PazjifbjyhgHt0tVqZUr4DY09rtG2tgROYOdRInXYicgp30EQACsFXDa7lFn/rkn
 iv/icAKqz8NeoGOk14Q==
X-Proofpoint-ORIG-GUID: DcO82clOe8T-Hb-cPxirL8VgMkPWB755
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

A queue that is unassigned from a running guest (hot unplug of an
adapter or domain) is removed from the mdev's queue table and is
no longer visited by unmap_iova() or by the loop in
vfio_ap_mdev_unset_kvm(). If its reset does not complete, its NIB
remains pinned with nothing able to find it, and the next
VFIO_IOMMU_UNMAP_DMA of that page hits BUG_ON(++retries > 10) in
the type1 backend.

Free the AQIC resources in vfio_ap_unlink_mdev_fr_queue() before
the queue is dissociated from its mdev, logging a pr_crit message
if a pinned NIB must be force-unpinned. It is the same trade-off
as in unmap_iova() and vfio_ap_mdev_unset_kvm(): a host panic is
worse than the theoretical risk of a wild DMA write from hardware
whose reset already failed.

Use vfio_ap_unlink_mdev_fr_queue() in
vfio_ap_mdev_unlink_fr_queues() so that every queue is handled the
same way, and document the function.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2695ae08a9b5..a618dceb31c8 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -927,8 +927,31 @@ static void vfio_ap_unlink_queue_fr_mdev(struct vfio_ap_queue *q)
 	hash_del(&q->mdev_qnode);
 }
 
+/**
+ * vfio_ap_unlink_mdev_fr_queue - dissociate a queue from its matrix_mdev
+ * @q: the vfio_ap_queue
+ *
+ * Frees the queue's AQIC resources and dissociates @q from its matrix_mdev.
+ * This prevents a use-after-free if a reset did not complete (which retains
+ * the AQIC resources) and the mdev is subsequently freed before the queue is
+ * destroyed.
+ *
+ * If the reset did not complete (timeout, worker -EIO, unexpected ZAPQ rc),
+ * the NIB is still pinned. Once the queue is unlinked from its mdev, neither
+ * unmap_iova() nor vfio_ap_mdev_unset_kvm() can find it, and a later
+ * VFIO_IOMMU_UNMAP_DMA of that page would hit BUG_ON(++retries > 10) in
+ * type1. The NIB is therefore force-unpinned here, while the vdev
+ * snapshotted at enable time is still valid, for the same reason as in
+ * unmap_iova() and vfio_ap_mdev_unset_kvm().
+ */
 static void vfio_ap_unlink_mdev_fr_queue(struct vfio_ap_queue *q)
 {
+	if (q->aqic_resources.iova)
+		pr_crit("APQN %02x.%04x: NIB page at %pad could not be safely unpinned after queue reset failure; force-unpinning to prevent kernel panic\n",
+			AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
+			&q->aqic_resources.iova);
+
+	vfio_ap_free_aqic_resources(q);
 	q->matrix_mdev = NULL;
 }
 
@@ -943,7 +966,7 @@ static void vfio_ap_mdev_unlink_fr_queues(struct ap_matrix_mdev *matrix_mdev)
 			q = vfio_ap_mdev_get_queue(matrix_mdev,
 						   AP_MKQID(apid, apqi));
 			if (q)
-				q->matrix_mdev = NULL;
+				vfio_ap_unlink_mdev_fr_queue(q);
 		}
 	}
 }
-- 
2.53.0

