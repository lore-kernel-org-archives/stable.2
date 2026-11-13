Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579055;
	b=jUtEwJ0SAsn0ikPtsYWE3rK4bbf8KkV4VrlsI1YShqvtDafIncX5AjwMpbR4BqLQwulN
	 CkBlH0I1ffWhR33CZesZzNse+QqynhMed80Yg0X1bMBaA+eqZj/BZGlS80Z43ZgVfKDoO
	 baxrpE3Q8OjfCCjNVD0z957Dsc33JTdQBAtde3KSEbWN9HX0IspRK5VEdwHJWPqvmMHkP
	 4qneT61zBHMrmfefq8Tgkq7EqsErQh39qsLeFzyPVGRDV+o5UWCUmDMdwjxgcd8+jFIxw
	 hK8bJjcpY8+l/PocYikO5QZTDMmR+w01qgNvjTiyNrIh+eO0bXUS8Zi47R8eh3jODLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579055;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=W0GKfzzngVGRnbcC5Y/DB4YXqpd6wWj4rBYfjDkPi0U=;
	b=AMRQPQvmRkBC0z7F84OqtJGUBtWxWBjmsI1F4HPQyOsIQ+tAin9i7vG63wl+dxPgDUp9
	 O2T8UO6oNai02sCBzKF+njSAJish3lZU0GlepAiCAeJrItiL3S66kqRWfIZO6uL0qmrTZ
	 Gv2073NpIkmrmMHhJE28SUQX90pObOA0OD6rUztsAPF32Q+5frCwO/r6DIKJjBh88fmoa
	 866cecKU5oVZmTpemzRGCY7RZrZiAb/N2/lE2ZKQdwtojG1Y7xbQdmrYc13fz43iaR8OD
	 ibIqLjtVsio/pkeQrKnA4xeoA+TIvdzO3NhgZi7IHxpgIIgTZr2pDbfPaX2EQrDENhQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HOeU+cPa;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2656606A337
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2656606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=HOeU+cPa
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCE8nG3086403
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W0GKfz
	zngVGRnbcC5Y/DB4YXqpd6wWj4rBYfjDkPi0U=; b=HOeU+cPaba8K7+pKefuiaL
	AKmp8wLz5RvAb/Sb6/wvHsaCvuwumFK3eBz9HY5kLhbt0GWrunMLv8fEefGRtlrV
	l1jjJtVEWOssr7qW3dAI/yv5tXz5JcO9OiKEF8U2kU8vNJZ/YsXy+mmzcW66sdM9
	fwIo66FGJ15YudAQfUIt+XCQ5+I1F1vj+PAdFaMsOUo6sZ4Iz14hihTLah02roGN
	bhAH4V8s8ymLrCAetuOEmp3TDNBXoShuS6xtm2m5e5r2/BVEM+95yz964GqygLTx
	SaZPneCimuj+w6K11qxfiAa2G5YntSfYLnQp56vqZZ2lSqM8kaZ3nXkw/DqS5UsQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6m0v2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5YqT1149596
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hx26k8hg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAqeG33292950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48A3258057;
	Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02C8358059;
	Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:51 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 05/20] s390/vfio-ap: unpin the NIB page from the container that pinned it
Date: Fri, 13 Nov 2026 09:10:27 -0500
Message-ID: <20261113141049.3747719-6-akrowiak@linux.ibm.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZkmoiEkwqC--zMRE0ElEUc6mlCyid0og
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af71a6d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=UqIOGKD97U9EQMlU0C8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: ZkmoiEkwqC--zMRE0ElEUc6mlCyid0og
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX/OMg60gZBOJZ
 3VpruYrfDmWjjIBI9VLsMjzaLMF/GfkUTPqF5of1s/En+o2iPnAm6Y7ECzSJWcckniR5WIKAja7
 eom3BIHETyBazUjWfF8+G9D8UYuOJYYIaQKsYNBcpn90REliusLUSPvLt3Eve3eVqrIzvFibKpu
 JyoF98ve+DkhaS3p8mXwOPZgbmDoszxikYqOexPGAVwQmNH/up+g8iWCwap6QwwsgOWzaeFOB3m
 4WQ9vQfdYa0t6tpTM9F4vM/0ikNWv8MVxzg3N5HYeohdeY6KKCAEbT78ScSZqnESzkiHMzXkZdY
 18O1eQaIgKkP2tuscjX5y7FRoaViMVjvoMbIbeB4zabFo6H47N9i7uZiLHyDI2R6lLq4/C+pXci
 YoFagTjJHGeuVGz//RilUhMm90IwIpiwEka8PSAgbTKf6qZM20j1h5bVJsAq70lIV3C0m3WGA9L
 mZvJXaKZDAXsNJMeeAQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXzj5oJGaXPhYU
 +CwsmsEXdaPymQsyZmdjZZxDVCF56TTsivoe210LXE+ujAj1tJeaOERcNmz+M8gY1e8g2Gc5FiS
 vYWRpY4NXP37NQ+/8LMIxkQr90Ki2aE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

vfio_ap_free_aqic_resources() unpins the NIB page through
&q->matrix_mdev->vdev. This is correct on the normal teardown
path, but becomes wrong when a queue reset fails and the AQIC
resources are intentionally retained across a guest lifecycle. If
the mdev is subsequently opened by a new guest (new IOMMU
container), a later call to vfio_ap_free_aqic_resources() would
call vfio_unpin_pages(new_vdev, old_iova), which unpins from the
wrong IOMMU container:

* The iommufd backend hits WARN_ON(!access).

* The type1 backend may silently unpin the wrong page or warn.

* The original pin in the old container is never dropped, causing
  vfio to warn about a non-empty pfn_list at container teardown.

Record the vfio_device that pinned the page in the AQIC resources
when interrupts are enabled, and have vfio_ap_free_aqic_resources()
unpin against it. If no vfio_device was recorded, the page cannot
be unpinned; log a ratelimited warning rather than dereferencing
q->matrix_mdev, which may be NULL.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 23 +++++++++++++++++++----
 drivers/s390/crypto/vfio_ap_private.h |  6 +++++-
 2 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 35399c5a63c7..2e54766ff161 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -266,25 +266,38 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 }
 
 /**
- * vfio_ap_free_aqic_resources - free vfio_ap_queue resources
+ * vfio_ap_free_aqic_resources - free vfio_ap_queue AQIC resources
  * @q: The vfio_ap_queue
  *
  * Unregisters the ISC in the GIB when the saved ISC not invalid.
  * Unpins the guest's page holding the NIB when it exists.
  * Resets the aqic_resources iova and isc to invalid values.
+ *
+ * For the NIB: always use q->aqic_resources.vdev — the vfio_device that owns
+ * the IOMMU container in which the page was pinned — regardless of what
+ * q->matrix_mdev currently points to.
  */
 static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
 {
 	if (!q)
 		return;
+
 	if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID) {
 		if (!WARN_ON(!q->matrix_mdev) && q->matrix_mdev->kvm)
 			kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->aqic_resources.isc);
 		q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
 	}
-	if (q->aqic_resources.iova && !WARN_ON(!q->matrix_mdev)) {
-		vfio_unpin_pages(&q->matrix_mdev->vdev, q->aqic_resources.iova, 1);
+
+	if (q->aqic_resources.iova) {
+		if (q->aqic_resources.vdev)
+			vfio_unpin_pages(q->aqic_resources.vdev, q->aqic_resources.iova, 1);
+		else
+			pr_warn_ratelimited("APQN %02x.%04x: Failed to unpin NIB page at %pad\n",
+					    AP_QID_CARD(q->apqn),
+					    AP_QID_QUEUE(q->apqn),
+					    &q->aqic_resources.iova);
 		q->aqic_resources.iova = 0;
+		q->aqic_resources.vdev = NULL;
 	}
 }
 
@@ -508,7 +521,8 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		 */
 		vfio_ap_free_aqic_resources(q);
 		q->aqic_resources.iova = nib;
-		q->aqic_resources.isc = isc;
+		q->aqic_resources.isc  = isc;
+		q->aqic_resources.vdev = &q->matrix_mdev->vdev;
 		break;
 	case AP_RESPONSE_OTHERWISE_CHANGED:
 		/*
@@ -2536,6 +2550,7 @@ int vfio_ap_mdev_probe_queue(struct ap_device *apdev)
 
 	q->apqn = apqn;
 	q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
+	/* aqic_res.iova, .vdev, .kvm all zero-initialised by kzalloc_obj */
 	memset(&q->reset_status, 0, sizeof(q->reset_status));
 	INIT_WORK(&q->reset_work, apq_reset_check);
 
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index 2794954894bb..e0d620dbd62a 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -132,14 +132,18 @@ struct ap_matrix_mdev {
  *				   interrupts for an AP queue.
  *
  * @iova: the guest DMA address of the notification indicator byte (NIB) page,
- *	  pinned at enable time.
+ *	  pinned via @vdev at enable time.
  * @isc:  the guest interruption sub-class registered with the GIB at enable
  *	  time.
+ * @vdev: the vfio_device whose IOMMU container owns the pin on @iova. Must be
+ *	  used for vfio_unpin_pages() to ensure the correct container is used,
+ *	  even if the queue is later re-assigned or the mdev is reopened.
  */
 struct vfio_ap_aqic_resources {
 	dma_addr_t			iova;
 #define VFIO_AP_ISC_INVALID	0xff
 	unsigned char			isc;
+	struct vfio_device		*vdev;
 };
 
 /**
-- 
2.53.0

