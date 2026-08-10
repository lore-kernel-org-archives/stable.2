Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544ED43F091
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391503; cv=none; b=QoDMU9Ts1hqzoOhMR/gCmiqys6Hdlga0+QRDjZW/ROIKf47U5/UwplTBziO/mWqVHWM1wdelbUFfnjg+eVCfJair+cZVod+pp+KzxeHZEgR2EgLcB2/1MaYBXPN2aDKRn50Gwh5N7njJD5YeN8C0HfduFPTDBGuygbndynbeOX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391503; c=relaxed/simple;
	bh=3Zb4Rcd9UhK2rcgizlvYh9SW91KqHZ4idy5YFweeT+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyKJhBfEoH5kg3ENw2Ss9XdlXGlH2ZfuyRtV+QhochoPgrWYqtX9SsSnzfyHpxOx1I97a+WbEYuiX2UMx40+iBVsz1/FL6cFThugHYc2C/ZUlPYIWeshddSgFfkCNk1ug1Hf41dbPypJ/EGvkL+7DdNW9vglZn2QHGgWbgC+d7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IqpKDqwE; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IqpKDqwE"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2dEo2392934;
	Mon, 10 Aug 2026 19:51:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8psY4me6ccst09oSy
	axpzI3FIStlkt0gNxrSDHY9U9s=; b=IqpKDqwEn4bh0p8Uw8S3qAK1ZpFOlOrEb
	OigC/IXfxg1VYDS8OFOT/8wjuSSTgbutliW7nHOIZ/8xkDvEtF7kkIGN62FVZZkO
	FVfh/6PAy+VvrhrDem31/nfCbafTM+EU4M4jKl4p2mkLowWFTTKaCHp3u4JPkX/i
	SXRRoNxoVxCQ5ZEuLMksG8YaE5ZnqBbcFKGXQPzuwSLls6YDmov8npGe2SPSwap9
	bgjyZmy7jhRKOP+mTaOKDRoOYQzdLKxgu+w9heqsrcHnGlMQOIFOo8Ijf2+LVXAq
	U3t0mekIMuF9yfuQE4qBQ+oea3TOTvwCa6s45x86GA4MxiFDUPqdQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2sbpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:39 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJfJlN003617;
	Mon, 10 Aug 2026 19:51:38 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxx09h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:38 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJpaCO49873228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:51:36 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C69245805F;
	Mon, 10 Aug 2026 19:51:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1498558050;
	Mon, 10 Aug 2026 19:51:36 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:51:35 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v1 7/7] KVM: s390: pci: Validate AIBV and AISB before pinning guest pages
Date: Mon, 10 Aug 2026 12:51:28 -0700
Message-ID: <20260810195128.7861-8-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810195128.7861-1-alifm@linux.ibm.com>
References: <20260810195128.7861-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7a2bcb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i8wI3NWYBEf5A6oN4S0A:9
X-Proofpoint-GUID: k9X3sLzIvxVm7hh0VMtG4p5JQ6i6bh7P
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfXwfvChMKtqla+
 iC+Z9adHJZZQWyAO/9vDJTyPnBJQK2lZz56llhEfd+k9QaxTgS4oisB3cu0mPIvJQ8myWjAnZiF
 0XRX1ZQaQXMO++iVUOL/hoLQhlfimM0gbzHXhB007aEZ9ePP9BXBmM09LSLHBB6HH3Tlvm+M0Pl
 W5mrvUwqe8AydhQzxkAv+mL0vdrFnMPzjVZYJJHgfgA6BzbuwwyaWJIHGmy+nvX1dfY3q8crQwH
 0u6dWM/I9fVxvk7ZSU2JakwqqgsndIUREE87bQubkRJ5NgwgF8jh7hMmJeUYv/21dCD7ROPu9OT
 ws4WbB82Ybx4B9/Vk7a/Fzfy/7BzCPJZ0tNf5ZXoh4igf7jrz6xCfHFu5ZihtmERjjruaXLEu/u
 dWxNCrN/lZB8FtWjX59czW9A0R7pu2GFH4DjRvTnzpuUg4/9M+wfJOOn349p0Y+hHQ6yxB2JtB3
 FgRooXbup5BJigPRTkQ==
X-Proofpoint-ORIG-GUID: k9X3sLzIvxVm7hh0VMtG4p5JQ6i6bh7P
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX8tfGY2PmmlAs
 Dcirli8hbk5nCwOkIpIP3NfntgFLLp8/BhV+ZJoymTc5Pcn95pRaiMNw6eXosQA8Gjgmz7FwY6j
 DD88NR7NVy5rWu1hqT2WJC68m9MoatU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100166

The AIBV holds one bit per MSI-X vector for a given function. The size of
the bit vector is derived from the NOI and the AIBVO. If the size of the
AIBV exceeds a single page boundary, then reject the request as we cannot
safely pin the guest AIBV.

Similarly reject the request if the AISB address is not 8-byte aligned as
the architecture requires doubleword alignment for the summary bit address.
Since the AISBO can address up to 64 bits, the size of the AISB can only be
8 bytes for the function. This also ensures the AISB doesn't exceed a
single page boundary.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 868d32ac72cba21c5c6d8a66a814b7c25a3a5c01)
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index d7a2822ee4a0..8b91f289226b 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -245,7 +245,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				   bool assist)
 {
 	struct page *pages[1], *aibv_page, *aisb_page = NULL;
-	unsigned int msi_vecs, idx;
+	unsigned int msi_vecs, idx, size;
 	struct zpci_gaite *gaite;
 	unsigned long hva, bit;
 	struct kvm *kvm;
@@ -272,6 +272,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 		return gisc;
 
 	/* Replace AIBV address */
+	size = BITS_TO_LONGS(msi_vecs + fib->fmt0.aibvo) * sizeof(unsigned long);
+	npages = DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE);
+	/* AIBV cannot span more than 1 page */
+	if (npages > 1) {
+		rc = -EINVAL;
+		goto out;
+	}
+
 	idx = srcu_read_lock(&kvm->srcu);
 	hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
 	npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, pages);
@@ -287,6 +295,12 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 
 	/* Pin the guest AISB if one was specified */
 	if (fib->fmt0.sum == 1) {
+		/* AISB must be dword aligned */
+		if (fib->fmt0.aisb & 0x7) {
+			rc = -EINVAL;
+			goto unpin1;
+		}
+
 		idx = srcu_read_lock(&kvm->srcu);
 		hva = gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aisb));
 		npages = pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM,
-- 
2.43.0

