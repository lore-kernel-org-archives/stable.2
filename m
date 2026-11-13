Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794579061;
	b=XAd+9gkWR/8qdDSuxUuBk/q1u+Xegh6ZV9l8/uQqm3PzqLKFx5Tj+7A7LnTU4ihM/YsI
	 fG0sa67Uz2p7/ZvmE7goFKie8//bGAAx0O26YDurhEk9PEyD6GupBiwsTFWPuLj9h/OUl
	 ux/m/vzPjEiUAYaO3GumaQv4cO5VPLoK6lxjWt26UgZE84SGccCnhJYHRkJhvxVtEmBd2
	 Omsuv5tUPtsg+PfKakptNg/OboylfjSpSh6q45DPiK6iqaD9htOyziXWLVJPZiSpbToFy
	 kqanwmspuhtvARge5lMzStND/CD8zLOqq2/6DbUOdwv0KnBNiPnF76d/EGoSTURw+Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794579061;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=h5jK23s+1GcFPKw3btfKd6KaIgYOv4qBSoQrXdAhZEQ=;
	b=dKQ8X32df33YT17w9YNqFzQPavnxuyZcVg4vc4byR9YvOuQQRj4bp80H9tiC3TmMLQJM
	 DB1uhqaCrAstnXaB66gpOqK1uoW2hNpjtXevtx+5KIhfl7Tgo0+TU8JFtvu3nMKdhAr9Z
	 EeR9ODf+A8mLYgltDmJv8ruUPtmWA5Ax8A4z1WVindBQv9L7GqzKU4l580gy4uvaRcraM
	 0thH6r+57yFUXuVBuCadeWhf98cDVYsRbbL7DP9zxoNBET75uasgU5FlqjQCjpA1iE4CD
	 rg3YPafMdXyZ3dqESSVSVz6pK4TthxwpBZgQswuvxaI42R6J0JaQE2jIcibThFYyw+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dJa01xIh;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9F606A8A4
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEF9F606A8A4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=dJa01xIh
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCE69Y3085797
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:11:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=h5jK23s+1GcFPKw3b
	tfKd6KaIgYOv4qBSoQrXdAhZEQ=; b=dJa01xIh0bXgDb2gZQnZpIrbCa7a0Eszd
	8SOtnFMZ/EklJtpIscxWaJWEl57AJ1IAcTYaNfjxvAygWYhhNEnEQVf4aK1V/Aod
	TbWsarAypwCRqagnDWO75izrgVTV2LznpeuuF36WAI720eAm2Jv35jJP1bBu4nlz
	kU5zS0B2AB76POWq37Rh2PVGE3Rs7D0pFjQxHQrwSELwHlSswTuqE672jGuQIXcR
	C/og7BI6wOouMVbLO6eWz2ETdcm6kofIG+1o+Y3CJCE/dvOK3G0gX+nowjtM8TKC
	g0upKwV0rE3rh123ve5CrjBmaPhgYjpmsiyDbn1TwnPnjdGQr5GwQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsug6m0vp-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:59 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6ADCKInn2305810
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hvkq11jn7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 14:10:58 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6ADEAvtb16056882
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Nov 2026 14:10:57 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93C1758059;
	Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 510BA58057;
	Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
Received: from li-4c4c4544-004d-4810-8043-b7c04f423534.ibm.com.com (unknown [9.61.92.80])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 13 Nov 2026 14:10:57 +0000 (GMT)
From: Anthony Krowiak <akrowiak@linux.ibm.com>
To: jjherne@linux.ibm.com
Cc: stable@vger.kernel.org
Subject: [PATCH 18/20] s390/vfio-ap: filter the matrix when KVM is set for an mdev
Date: Fri, 13 Nov 2026 09:10:40 -0500
Message-ID: <20261113141049.3747719-19-akrowiak@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: 1oaZk1Su4zHonr8a3blxxXklt9dWXGIM
X-Authority-Analysis: v=2.4 cv=PeVqFShd c=1 sm=1 tr=0 ts=6af71a73 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=NExPFj37_T3DjFEL6UIA:9
X-Proofpoint-GUID: 1oaZk1Su4zHonr8a3blxxXklt9dWXGIM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfX6cRc4/sqK8Wo
 6Jo3Fhzbp0cVUkeC9YrlfVpyhxSElanxBp49KAWfEucWpc0U1gLihByG3DXGhE9059sul+pBmP9
 QA5jzA6wqvus1cFtND82KnpF/t2LdRzopJ3NyqHpsnoFBMBzMXLbtlslJ6/3INVZL4QY+20toKU
 W2rmAbPVjeO5zvLiwgs10v4lJnptXX6fpIgQEjG1dAYQGus7sejL80d8yD2LT2Y++1mitm7bQjB
 7ULJnwaAoOQQ08sUPVXZHtCxwX38XGbJcDjCisRUVOpYb+OcN7bqosnqBZ/HpvPZXltoX4I6L/y
 kABrBk5IYruvj5DEhRrcIgHa1fYBQuDv2CgFteHVfNHqU+wleI3GVizLKXZ6heLwuxhQBkvnyOh
 qsOFQ/fPb86CxfdgsU2v0a7rTFhQCvf1L3pBfGTvjdmqEcpDWyPh1x51ZMk5AW3Rm8rqpQcpu05
 Tx6uEHWYf4Wor29sU2A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEzMDA1NCBTYWx0ZWRfXzlW/FXa3c7A2
 Ug00O+yc15lj/qmX/794s3VGiI9a52XjwuweM9BhB9z0jBYY217G7l0EzrCUemoWlS8IcqvU0bJ
 uyYl6iVypnB3VbXtHBG9O9lvgOlzsPA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-13_04,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 malwarescore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611130054

The shadow APCB of an mdev reflects which of its assigned queues
were operational the last time the matrix was filtered. A queue
can become operational, or non-operational, after that and before
the guest is started.

Call vfio_ap_mdev_filter_matrix() in vfio_ap_mdev_set_kvm(), before
the guest's APCB is updated, so that a queue which changed state
since the shadow APCB was last updated is correctly admitted to or
excluded from the guest when it boots. Any adapters that are newly
filtered out are reset, as is done in the other callers, to prevent
stale state from reaching the guest.

Fixes: 51dc562af09d ("s390/vfio-ap: allow hot plug/unplug of AP devices when assigned/unassigned")
Cc: stable@vger.kernel.org
Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
---
 drivers/s390/crypto/vfio_ap_ops.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
index 19638fea0ed3..52bfe383cf43 100644
--- a/drivers/s390/crypto/vfio_ap_ops.c
+++ b/drivers/s390/crypto/vfio_ap_ops.c
@@ -2101,6 +2101,8 @@ static const struct attribute_group *vfio_ap_mdev_attr_groups[] = {
 static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 				struct file *kvm_file)
 {
+	DECLARE_BITMAP(apm_filtered, AP_DEVICES);
+
 	struct kvm *kvm;
 
 	if (!kvm_file)
@@ -2119,6 +2121,15 @@ static int vfio_ap_mdev_set_kvm(struct ap_matrix_mdev *matrix_mdev,
 		kvm->arch.crypto.pqap_hook = &matrix_mdev->pqap_hook;
 
 		matrix_mdev->kvm = kvm;
+		/*
+		 * Filter the matrix to ensure the shadow_apcb reflects the
+		 * current operational state of all assigned queues. A queue
+		 * may have become operational (or non-operational) since the
+		 * shadow_apcb was last updated. Any adapters newly filtered
+		 * out are reset to prevent stale state from reaching the guest.
+		 */
+		if (vfio_ap_mdev_filter_matrix(matrix_mdev, apm_filtered))
+			reset_queues_for_apids(matrix_mdev, apm_filtered);
 		vfio_ap_mdev_update_guest_apcb(matrix_mdev);
 		release_update_locks_for_kvm(kvm);
 	}
-- 
2.53.0

