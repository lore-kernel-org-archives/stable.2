Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B5411689
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572815; cv=none; b=Ru/5PFs0E1zJNsYR33VEPkylHNXHUWDNyDvpcgr8H5zEF5wfSgQxphNwLu3/jkewxIxUXhcum/V0eSG20Dv9Sb/voOrTk3jFaCinqgIbtmDMX6RJFaw9VFquOGQ58E0V3IqEUWsFrNVb8bNzX9ryURljdZariwfOJPKabkRQxnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572815; c=relaxed/simple;
	bh=3Zb4Rcd9UhK2rcgizlvYh9SW91KqHZ4idy5YFweeT+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EH7Ee69fAxWkfwAq2RoUD3SBUQT0t6L6vRIPzuKU7v1/lLhZeyajThCaKQDuolGBIqYcffcEjleI9rW57R25vVURZe1w+aaIzwjPLqpGcvAwrJCjnTaA3ah1iPZxfh7Rt5Tqm99sH8SdXkCW5H4iblMv75BxRs+KK8C+ZL2IIKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=by9k5iko; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="by9k5iko"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2ZNc2612878;
	Wed, 12 Aug 2026 22:13:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=8psY4me6ccst09oSy
	axpzI3FIStlkt0gNxrSDHY9U9s=; b=by9k5ikobX9FGwo+h9eGjfyTqUXsP5CtA
	EMNP3rs0SP/ZtbDQWEqqFJgHrdBE3qu50GgiRXMn0QOlCJWyZiXqF80siFgv7NT6
	LVlNGWmwriNuKlLy/9ibCn45Wry6oNRQztCc3Fxnwhbz0gdfLFtMNT6D1ICc2D63
	qlu3uqWKW/k6tZPN+bagYfEC9b7QRAGReXAoA9ZpofTzkRnA8yFQHR2L7gJQrEx8
	qBABZJeiQqFI0Pmsy7G51SuURBsLpBSIB98yE/tTDbpTf+sacXAnqQcRwzdNwSEM
	Ke3XvYoS8ybzXaKxbpNS+o8/WipJF+u1ZojYB3NHi2JWFqGL8S7ew==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk050re-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMBFD8009160;
	Wed, 12 Aug 2026 22:13:30 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq8frq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMDSjl25100978
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:13:28 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AA855803F;
	Wed, 12 Aug 2026 22:13:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1526058056;
	Wed, 12 Aug 2026 22:13:28 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:13:27 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 7/8] KVM: s390: pci: Validate AIBV and AISB before pinning guest pages
Date: Wed, 12 Aug 2026 15:13:22 -0700
Message-ID: <20260812221323.3645-8-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812221323.3645-1-alifm@linux.ibm.com>
References: <20260812221323.3645-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfXxNk7/MvgPlOf
 2JYXyvGHYr4a/IC+ktX5M22ERENi3bQ7dUeCWsjhIE+9dUv4+MqAzdxfBZORF2OwcZV51CTPujm
 O8no/KAxGnYsQxt14lbIdcAooZV/XKxAwrYkzjSvQHv+eddv1PQCJkr7OWS8Awc/m/bmKNZGoJD
 SK+a/TeFjnmy06ttWOgvHr+Dy1HCPuq5gqY42YSANZVuwI78HH1Llou3/PLmX8x1TRJi295qt2v
 HDrLtXBvhXE114E3uRjyTfj/+Qrp3PHSogPWtEzWJtns6x+f2KIfhMbImxEs8IAQn922aGd9SAu
 1qnsXiXeT0m3slXhq6RUobI/DDcvbygNlQwQtCDVKBj/XBKbP/O+du+illzDpvMk2uWOmtXkuwY
 ZYdMuT6ueVCffxPg6z+XhzXJmsBx9QrHfi+DvAXJypyU/nhKMNciN1KQobpcvzfqN5aJOuJ9G+U
 Yi5/K5l2iZ916wCNsQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX3lg9rcNSl6ip
 ih09BzvhsWOcFQ+zQ74mxg0pawkd/+gp5RQvq+ySmhSVWO9UyNJ4GJnioQ79mo1Hb8uYHnpsvlp
 2O6xj+bRKswHoXLpz+3otyWnaansF3Y=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7cf00b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=i8wI3NWYBEf5A6oN4S0A:9
X-Proofpoint-GUID: t9gQfoLUEjEubXHnM3Z10Bgh7h3h-_AC
X-Proofpoint-ORIG-GUID: t9gQfoLUEjEubXHnM3Z10Bgh7h3h-_AC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120177

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

