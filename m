Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579056;
	b=QcCdjDhTmO8Dw2e3NJEqBzu1xTB5xsi1u08ULPlyRzJhMZrXM2qHyCR/tU9JW8b8ChF/
	 B7SyMOD2y/cnBLi0Pbg2sejIATj+tqL2AubbRwpbtdDapda1PHx800E9V1E4hxgZkPPC9
	 qdba6MTrHoNgrKWbcG76vp2bpbyjHpWMSg7UenRSI3SWyOTw1vvRdHK0s+ZVRjZA3MBH8
	 +liUsmaYw+cGD+o2Yw2NIsCxqSKHD4FGTsw87dZzBluOu8vXUQVJwha+6JkqfqAwIiy79
	 lvhffdB4r2I734FP8fOKjvZ4dM2y1NN90j274Yjiglfdkp7CQnVTn8Tii1IiXj43jbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579056;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=HBuAy3bytsynmzu3TeeoMa3WyfwVMhNVH12ZV+9AK1E=;
	b=q1aXA+H7zGN4z277J/uf86gpZ9lSA375/ADD52Z6KEc80HHrctTokkJr6kPTGCC4mzse
	 jrB2j5/HJ72NJA5HMn412T116azPtDhzPZUCGMYyIBJEBRmfpyV1LzA4v0UIxChvdOPxF
	 y1CSZQIQF6OS4H5j4ZqgRwYDP4EHToi5Uwfp040pwoG6AXMJ+CmobBywqU99jFZ2wYGeO
	 5hayn6urO8Gu4Q1v9CKWbSzi5hgh7Ht2WgWOJPbIWl9rs1yWegbchrIxcufJbSOoJ+7pm
	 W4gudqNeVoZG0wKroJshssgHL1NdAFuw7g+ML+wm/A+I8O8RGQkKLTgymsQilNoWu8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TTTaJ30o;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E1F606A885
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 95E1F606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=TTTaJ30o
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEHxY2893658
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HBuAy3
	bytsynmzu3TeeoMa3WyfwVMhNVH12ZV+9AK1E=; b=TTTaJ30ovczQKs4LWRF0Vz
	1tyiRBltJr8fkuDf5nSzzzXn6lx62OJOUacqrF5Oz2StmMcROTCsE7alDtgmokBa
	DXwtAXvtPtJ4brh6kseUm/iLJ2SZx1o++cS8no2aRpuBZSRy9TZiySv+l/rCPMGy
	cyDAk+MQdWqFtpiPW63y2+DiRTIJQe02MPwONyDiS6AwNaQmtpz+rYGwG+fRrc0S
	7mA+K3VyMjppfIiIFH4aCTvYlv+ntAZF7e7l11Lw4RZD5uXeEgMGM6TT97e3PCj8
	H7cvPikbLBReX0nbpWZGvZUR+qUwDaQaUcQSii6Bro0Wr5Php7D4C9dooO5yC98Q
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsumvamw2-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5Ns12294394
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:53 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hwjcf35wn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAqm633292954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:52 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD01358057;
	Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6591058058;
	Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 06/20] s390/vfio-ap: unregister the ISC from the KVM it was registered on
Date: Fri, 13 Nov 2026 09:10:28 -0500
Message-ID: <20261113141049.3747719-7-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXzgEKYFXJXJry
 me5AjwAhLFCF/rJMvQw79ioJL/6dQb1rUHdXaRJnK5fcJC7oUGj38GBaR0wk2yKdEWzPtdg3O4/
 +aXG0iYu9un81SHJK5ntsQTpViHRnCY=
X-Authority-Analysis: v=2.4 cv=GISdgeNK c=1 sm=1 tr=0 ts=6af71a6e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=GBm8L5ovna5_AmtYqwMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Y_R1REEOdUoVGkSmN367CxHAZjUydgPo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX2qC39cYJvb0k
 lRJZ2C4lrbpPO0q0KZtzf2kzv+pccADqyKqDF3nt7esDpC/vdX0Id5D/yP9yJPuVo6HZIo2TQMu
 GmdO5oEDWuBr4QwCKnDN+ClwISwf6ouQZInohWWVDW3UJ72HGdaMFANofGeo60WKHdRtaQeyOew
 kNxUK78LPJnHYZC1Zumh2ylISfQ9O2wlQY5tgBAJ12DH+l6syRDzn73y7ccZLwHBN8QlDyAxGKn
 r81pgJzLnocLc/ZCZJf9+vX/hf5Ma2zlwj5Zcq+ZoN6J/VFxEYr3zEm5eeEH7/zYwYNwDkqoxIZ
 itKoImphgO8WoditGj7rwUY6xPdgSEQh9aKSiHOq32f1w9lkEfZTzNX3XuWCrxd5PKeO9zufdyp
 O48+QJi1eCqt+chmO1oblPmJJ3ML7DCEMlJeUGRtv0JOJts/HLkrXdvYNsLJX3X+/zJ7x/T4eQl
 rPY6JPv+TApSFYWABdQ==
X-Proofpoint-ORIG-GUID: Y_R1REEOdUoVGkSmN367CxHAZjUydgPo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015 adultscore=0
 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

vfio_ap_free_aqic_resources() unregisters the guest ISC using
q->matrix_mdev->kvm. This is correct on the normal teardown path,
but becomes wrong when a queue reset fails and the AQIC resources
are intentionally retained across a guest lifecycle. If the mdev
is subsequently opened by a new guest, a later call to
vfio_ap_free_aqic_resources() would call
kvm_s390_gisc_unregister() against the new guest's KVM. If the old
struct kvm was freed and a new one allocated at the same address
(struct kvm is kzalloc'd and the slab allocator can reuse
addresses), this silently drops an ISC registration the new guest
still needs.

Record the VM file of the KVM instance on which the ISC is
registered in the AQIC resources when interrupts are enabled,
taking a reference on the file with get_file() to guarantee that
the struct kvm remains valid, and have
vfio_ap_free_aqic_resources() unregister the ISC against it. The
file reference is dropped with fput() after the ISC is
unregistered. fput() defers the final release of the file, so it
is safe to call with the matrix_dev locks held and from the reset
worker.

The mechanism that keeps the KVM instance alive is confined to
vfio_ap_aqic_get_kvm() and vfio_ap_aqic_put_kvm(). A kernel that
predates the file-based reference counting of KVM by VFIO needs only
the bodies of these two helpers (and the type of the kvm_file field)
adapted when this fix is backported.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c     | 49 ++++++++++++++++++++++++---
 drivers/s390/crypto/vfio_ap_private.h | 10 ++++--
 2 files changed, 52 insertions(+), 7 deletions(-)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 2e54766ff161..227f18ccc822 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -265,13 +265,48 @@ static void vfio_ap_wait_for_irqclear(int apqn)
 		  __func__, status.response_code, apqn);
 }
 
+/**
+ * vfio_ap_aqic_get_kvm - hold the guest's KVM instance for the AQIC resources
+ * @q: the vfio_ap_queue
+ *
+ * Takes a reference on the VM file of the guest to which @q is currently
+ * assigned and saves it in q->aqic_resources.kvm_file. Holding the file keeps
+ * the struct kvm alive until the ISC registered on it has been unregistered.
+ *
+ * All use of the mechanism that keeps the KVM instance alive is confined to
+ * this function and vfio_ap_aqic_put_kvm().
+ */
+static void vfio_ap_aqic_get_kvm(struct vfio_ap_queue *q)
+{
+	q->aqic_resources.kvm_file = get_file(q->matrix_mdev->vdev.kvm);
+}
+
+/**
+ * vfio_ap_aqic_put_kvm - drop the reference taken by vfio_ap_aqic_get_kvm()
+ * @q: the vfio_ap_queue
+ *
+ * The final release of the VM file is deferred by fput(), so it is safe to
+ * call this function with the matrix_dev locks held and from a worker.
+ */
+static void vfio_ap_aqic_put_kvm(struct vfio_ap_queue *q)
+{
+	if (q->aqic_resources.kvm_file) {
+		fput(q->aqic_resources.kvm_file);
+		q->aqic_resources.kvm_file = NULL;
+	}
+}
+
 /**
  * vfio_ap_free_aqic_resources - free vfio_ap_queue AQIC resources
  * @q: The vfio_ap_queue
  *
- * Unregisters the ISC in the GIB when the saved ISC not invalid.
- * Unpins the guest's page holding the NIB when it exists.
- * Resets the aqic_resources iova and isc to invalid values.
+ * Unregisters the ISC from the GIB and unpins the NIB page, using the KVM
+ * instance and vfio_device snapshotted at enable time in q->aqic_resources.
+ *
+ * For the ISC: always call kvm_s390_gisc_unregister() on the KVM that was
+ * passed to kvm_s390_gisc_register() at enable time. A reference is held on
+ * that KVM's VM file (q->aqic_resources.kvm_file) so the KVM is always valid
+ * here. The reference is dropped after unregistering.
  *
  * For the NIB: always use q->aqic_resources.vdev — the vfio_device that owns
  * the IOMMU container in which the page was pinned — regardless of what
@@ -283,8 +318,11 @@ static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
 		return;
 
 	if (q->aqic_resources.isc != VFIO_AP_ISC_INVALID) {
-		if (!WARN_ON(!q->matrix_mdev) && q->matrix_mdev->kvm)
-			kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->aqic_resources.isc);
+		if (q->aqic_resources.kvm_file) {
+			kvm_s390_gisc_unregister(file_to_kvm_s390(q->aqic_resources.kvm_file),
+						 q->aqic_resources.isc);
+			vfio_ap_aqic_put_kvm(q);
+		}
 		q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
 	}
 
@@ -523,6 +561,7 @@ static struct ap_queue_status vfio_ap_irq_enable(struct vfio_ap_queue *q,
 		q->aqic_resources.iova = nib;
 		q->aqic_resources.isc  = isc;
 		q->aqic_resources.vdev = &q->matrix_mdev->vdev;
+		vfio_ap_aqic_get_kvm(q);
 		break;
 	case AP_RESPONSE_OTHERWISE_CHANGED:
 		/*
diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
index e0d620dbd62a..59bc9f8901fe 100644
--- a/drivers/s390/crypto/vfio_ap_private.h
+++ b/drivers/s390/crypto/vfio_ap_private.h
@@ -133,17 +133,23 @@ struct ap_matrix_mdev {
  *
  * @iova: the guest DMA address of the notification indicator byte (NIB) page,
  *	  pinned via @vdev at enable time.
- * @isc:  the guest interruption sub-class registered with the GIB at enable
- *	  time.
+ * @isc:  the guest interruption sub-class registered with the GIB on the KVM of
+ *	  @kvm_file at enable time.
  * @vdev: the vfio_device whose IOMMU container owns the pin on @iova. Must be
  *	  used for vfio_unpin_pages() to ensure the correct container is used,
  *	  even if the queue is later re-assigned or the mdev is reopened.
+ * @kvm_file: the VM file of the KVM instance that owns the GISC registration
+ *	  for @isc, on which a reference is held. Its struct kvm must be used
+ *	  for kvm_s390_gisc_unregister() to ensure the correct guest's alert
+ *	  mask is updated, even if the queue is later re-assigned or the mdev
+ *	  is reopened with a different guest.
  */
 struct vfio_ap_aqic_resources {
 	dma_addr_t			iova;
 #define VFIO_AP_ISC_INVALID	0xff
 	unsigned char			isc;
 	struct vfio_device		*vdev;
+	struct file			*kvm_file;
 };
 
 /**
-- 
2.53.0

