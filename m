Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579056;
	b=I9AEQKuC3/y+4ctYabKUR2tKPUV1T0jW6LG6fy6p2JUWLxA2Ct8XPTUTYJqmg5sLnkv8
	 qqrvyFvUAWWUkHg+2Yu1X8RwzYduBdSfxqqUhXqJ+bnrLd9ehcTK0KDw55IZluA2RF/mV
	 WOnAyK1zEo1Q2fygo9JqVUmUIEgrTj40ln480FPj2qVxDYHIWx0qoXmjaXNu3GlrizLfn
	 a85S95NHnPB+V2cDSKwbQpouDQDfJN4oxzrfS2l1DFVRrmWS1j6YY65q1BHkyd3Iw78Ca
	 1Cc+aqZSXqt3qeV6nB6q5TAtcLLt6aTXvZ+JIKW6deSwdyiOQsRMi6I87l5Gwltk7WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579056;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=LDRgz2uzdKVx1zD0b+jG3MjBUvDdj74hrv8/c3G+ofs=;
	b=n8KG9+RTqrPgVPpeB7V1Wtzytaaf1QvyzBVfmjyXpccyW+jYeWBPjidwNUP1CCii30l1
	 whNlVtrJq057xkFrKGkfZOjgK/ZUIiuVqE84b6i3MX3y9StLCbvcpQv0EyXjTpEkoVfyN
	 Wbq7tTxYETb8g6KoSwflxpiv7RU/f8YFQw686JVhKkmg4yVo0+K6iNGbDbZw3y7TZR8Ik
	 /7YwMzNRp2ywUqp01m5KQx/KboB5lU7Mr2kwKAI15UGbcTjh/JLKgvC8cVoz9S9hXU3QQ
	 4yCjicq8pFb2C09VeRfCg+bb6BYVBwLWs7opqPC/+hO7LLrPeADNnLQNa4ELQXv1kPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aQDRyema;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B20606A881
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07B20606A881
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aQDRyema
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCEBDY1248478
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LDRgz2uzdKVx1zD0b
	+jG3MjBUvDdj74hrv8/c3G+ofs=; b=aQDRyemaRc+i6pF4vqZhpWKdQdJURpfCf
	YKNt9gGmLdIo7kdVyk3dI7ZhH4U5Tz3eps0MkVmX40RNL2D/XkLQr2XRuxdoaSlK
	ETsuUn5XDgG21O2NM2Fy/WAAnh6LvTVnP0ap9NDdBvmD1owbE1y9P18R0S1dgk02
	bNKU4dVqb55MigfvfAurTXyKJ01qoR3KMjDjHr/UFQgPN3IzF95ZCQDuW9w5wGFX
	7Y32YRknKk6VwYv3bvKLCWHShHG2PnM/e2msQB4o7kSDjbStmKYfqMS0TVz3kNWo
	LpeAYCwCobyFoUkeqYv/7h/1RdLqpH3ZTJCJOZC+O835yN9kidc+Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntm1u8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:55 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADC5FxJ2213388
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hwegfc3t0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:54 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAr8a31130122
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:53 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1BF2158057;
	Fri, 13 Nov 2026 14:10:53 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C9ED558058;
	Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:52 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 07/20] s390/vfio-ap: force-unpin surviving NIB pages when KVM is unset
Date: Fri, 13 Nov 2026 09:10:29 -0500
Message-ID: <20261113141049.3747719-8-akrowiak@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX5vz5D67WlY2X
 byaM86XqtneKXJlR0IzEoVaF/np0dBh1HwsCK72Onrg8GevN4NwQzYMbvqYyOQBro54blL2x/YA
 Bi1KZTNzaHQJATLvheeP/85TamSnurzeWG7sCjInxEt7IcIcvlcWbT0NjomlBOQrerjxZsGPu6p
 3fo4Gr+R/Z7/HiIZO70ftXzFS0YhXkWMUNw/JmTvhcWB04vBVioXvbeMubiOJmNUabNM0NodGT1
 JSlaPlazg8ra1hUkteel2UOhxpeqIz4GeclulTsJQGjEDuiyjODQkvm8+I4W5qscfWqTs/1FlJE
 YLz48cLrQS6QWi75WuKU6lA7mN0V47IC3jdCOL7oYAcBTpB6BL8tnYyBs7b8SBaTrrbThMBFsHJ
 mJXGAG+SpofFkJf6voaWq5CJlW1ufbV/RnZnXoUWu1BDL2kN4PldJ1Rxa3h0yL8IyTsZjUmL5iV
 U6k++oGeumOYkOoqqZA==
X-Proofpoint-ORIG-GUID: 9ls3SAb6MvRqaXRDAmTYTcXJC-rfARab
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX/f1PXEWBFJr5
 RQolLHCCB2/OPxaERhvbbUHIKyYH4C9rbTPOetATcH8Dm1UajFx+865lXFR3jH/WYQBqE2ziJVG
 KJqvFxjzUY/wsejKnskzUDQAyAPQLPc=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af71a6f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=vjmUaXboXwjIuJzrYPcA:9
X-Proofpoint-GUID: 9ls3SAb6MvRqaXRDAmTYTcXJC-rfARab
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

vfio_ap_mdev_unset_kvm() resets the mdev's queues, but the reset
may not be able to confirm that all queues were zeroized (for
example, the worker gets -EIO or an unexpected response code from
ZAPQ). The AQIC resources of such a queue, including the pinned
NIB page, are then retained.

The vfio contract requires every pinned page to be released
before close_device() returns. After close_device() returns, vfio
core removes the device from iommu->device_list. A subsequent
VFIO_IOMMU_UNMAP_DMA will find the pin in dma->pfn_list, receive
no response from the empty device list, retry 10 times, and hit
BUG_ON(++retries > 10) in the type1 backend.

The same applies if userspace closes the container fd without
calling VFIO_IOMMU_UNMAP_DMA first: vfio_remove_dma() hits
WARN_ON(!RB_EMPTY_ROOT(&dma->pfn_list)) for any pin that was not
released.

To prevent this, force-unpin any NIB pages that survive the reset,
logging a pr_crit message, and drop the VM file reference and
clear the ISC held in the AQIC resources, since the KVM of the closing
session is no longer a valid target for releasing them. A
guaranteed host panic is worse than the theoretical risk of a
wild DMA write from hardware whose reset already failed. The loop
runs after flush_work() has drained all reset workers.

Fixes: ec89b55e3bce ("s390: ap: implement PAPQ AQIC interception in kernel")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 43 +++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 227f18ccc822..2d27c56a376e 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -1972,6 +1972,8 @@ static void vfio_ap_mdev_dma_unmap(struct vfio_device *vdev, u64 iova,
 static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 {
 	struct kvm *kvm = matrix_mdev->kvm;
+	unsigned long apid, apqi;
+	struct vfio_ap_queue *q;
 
 	if (kvm && kvm->arch.crypto.crycbd) {
 		get_update_locks_for_kvm(kvm);
@@ -1983,6 +1985,47 @@ static void vfio_ap_mdev_unset_kvm(struct ap_matrix_mdev *matrix_mdev)
 
 		release_update_locks_for_kvm(kvm);
 	}
+
+	/*
+	 * The reset above may not have been able to confirm that all queues
+	 * were zeroized (e.g. worker -EIO, unexpected ZAPQ rc). Any queue
+	 * that still has iova set holds a pin in the IOMMU container that is
+	 * about to go away. The vfio contract requires every pinned page to
+	 * be released before close_device() returns: vfio core removes the
+	 * device from iommu->device_list after close_device() returns, after
+	 * which vfio_notify_dma_unmap() becomes a no-op and a later
+	 * VFIO_IOMMU_UNMAP_DMA will hit BUG_ON(++retries > 10) in type1.
+	 *
+	 * Force-unpin any surviving NIB pages now, while vdev is still valid.
+	 * This carries the same theoretical wild-DMA risk as the force-unpin
+	 * in unmap_iova(), and is chosen for the same reason: a guaranteed
+	 * host panic is worse than a theoretical risk on already-misbehaving
+	 * hardware.
+	 */
+	for_each_set_bit_inv(apid, matrix_mdev->matrix.apm, AP_DEVICES) {
+		for_each_set_bit_inv(apqi, matrix_mdev->matrix.aqm, AP_DOMAINS) {
+			q = vfio_ap_mdev_get_queue(matrix_mdev,
+						   AP_MKQID(apid, apqi));
+			if (!q)
+				continue;
+
+			if (q->aqic_resources.iova) {
+				pr_crit("APQN %02x.%04x: NIB page at %pad could not be safely unpinned after queue reset failure; force-unpinning to prevent kernel panic\n",
+					AP_QID_CARD(q->apqn),
+					AP_QID_QUEUE(q->apqn),
+					&q->aqic_resources.iova);
+				if (q->aqic_resources.vdev)
+					vfio_unpin_pages(q->aqic_resources.vdev,
+							 q->aqic_resources.iova,
+							 1);
+				q->aqic_resources.iova = 0;
+				q->aqic_resources.vdev = NULL;
+			}
+
+			vfio_ap_aqic_put_kvm(q);
+			q->aqic_resources.isc = VFIO_AP_ISC_INVALID;
+		}
+	}
 }
 
 static struct vfio_ap_queue *vfio_ap_find_queue(int apqn)
-- 
2.53.0

