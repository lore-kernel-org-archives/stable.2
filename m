Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A850A3655E6
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 20:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567253; cv=none; b=GCFzMLI4cZGu9G+a2XsWqQph2YF8DfLcxqrHljYLjaveZJo0fZaUEsi1j+oiTfBEoa3PhNcBdHDEzPdcDEBgyB5sagtSJ1JlAMFMVbFYdKRgJUl4gItqdpigi/H4ShqjRhj7+l1fsHIrbAxlDbyysiy64it1tCfK+CsO3TBxeH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567253; c=relaxed/simple;
	bh=QCI6saZnS8XE0yeN3Gd61Gz9oHZB0IlqCbAAUb+4psA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ulQAAbj62X4birXBQdzKS+GKI4FAi/RTIocf/Udtpu4ZfW8ZalQNcKJWR6EAQwZ1ulh+4BUpgMMOPVVesW60NrqrJPfbEd5Mn2bnHVW6GeFzpGgfFR0Dw2KMqIgpLXFgFYoDBCqFNt7UOrnSYfb5QFZcd0/a70EkgWqArU4K66c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jow3boML; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jow3boML"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2dRP291736;
	Wed, 12 Aug 2026 20:40:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LdaElW2fjsYZ4sS7m
	d+wfVBMiAAFOnLH9/coga1UTUQ=; b=jow3boMLkAree0BsfUV76d3aPlMMB+8f/
	xWtWuNgFcwbEr3JEGOs7f2pyA/gjyJbf/+eUAy8eUDgva78cSwWjxFS/8teYcrW+
	fAyzVb7xa/XQWoklRDv4zVdWzgQ/gI/arC9ArMDcWWEGVATzTOdzvXmgWfzw8feU
	rOvl64EXdCNF0hyDB1xf6NQyfmowx2d9V5VvKPfGczOJOVyM2wzUvC3UnVNSuMMM
	kFfI0xc2fynb1HMyYLDQ2WtFq8y33i2f70/5j3aEthpTw2NnMZIKp9lTKcaAZDXu
	A5tEcU/0O7aTD4Z+2ur+S5lq7ejSTHZsCrGkH3lz6EwICwhhuQlzw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9vpvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:40:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CKQJII026749;
	Wed, 12 Aug 2026 20:40:48 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5w82uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:40:48 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CKelVL5505740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:40:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4087858043;
	Wed, 12 Aug 2026 20:40:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A564458055;
	Wed, 12 Aug 2026 20:40:46 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:40:46 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 4/4] KVM: s390: pci: Fix aisb calculation
Date: Wed, 12 Aug 2026 13:40:43 -0700
Message-ID: <20260812204043.2536-5-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204043.2536-1-alifm@linux.ibm.com>
References: <20260812204043.2536-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfX0RbJckJjYiP4
 564vDIljlMDGixrKdwYtveCGFF7tBSutU5KE6DzLjehekZ+1j+FV/RwtkXJ4NN4CN+P1a8+ZZlz
 EpoHEX1k6sYlb70+x4z8XP9T1jwvFyKTQs/8whKuv5oQssCcA9axzwqTh/G9ZK44ymXHHwHgve6
 jm9ntBQj1a7ZCB/YlJm6zuogyehSI7R1HwkMisPgKd3qJaXIZAqc+NDEP65nI1CV4W06pOjavBb
 S7pPQcS8ppsWfXVYvnLMqOik3m9jcVH2J6itkDewmv2CZZbpvxTROfvEfNms1btKRvEXSVDOGUK
 ku4crYIoQNLMOSWEgEgjdMaUNCh7rNDVXfuTCxfpYAp8dASfNDVbGHRmdhb8sPqfHscO0J1Xj1/
 kSzJiz6Co2SM2UTFu5s/MAm08Vligcc9/Bt2f6DMxgxqdlCT6gWkfcZzBjmLpyg1fw0mnqyHhPY
 H4xE5s82dLpULUQK/pA==
X-Proofpoint-ORIG-GUID: 59N2HJt0VHqxY-ZLNe5VQ7CC8FvYI-Wb
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfX05RMmC5ptPWo
 1Esn6svaZSLN0b1/Ddi18plsiMnDICgpNepxi2gGpLgi3ronzyWW675chVoIOLv+YFOPJqpX8RK
 dn7HH8HxhbYgqx16C8qh+haHJbDZq58=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7cda51 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=Kdkv-2UG5BF8DrlVkd8A:9
X-Proofpoint-GUID: 59N2HJt0VHqxY-ZLNe5VQ7CC8FvYI-Wb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120165

From: Matthew Rosato <mjrosato@linux.ibm.com>

The current implementation of aisb calculation will erroneously index
via an unsigned long * as well as multiply by 8B for every 64-bits in
the offset; only one or the other is required.  This throws off aisb
calculations once the number of devices exceeds 64, and can result
in out-of-bounds access as well as failure to indicate summary bits
associated with those devices in guests.

Fix this by converting to a physical address before applying the
offset, as is already done in arch/s390/pci/pci_irq.c.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 0cfe660559e857d7c00ab86c73e4510ce069086f)
[alifm@linux.ibm.com: Resolved merge conflict]
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 61489016e425..d9fcbf41025e 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -167,7 +167,7 @@ static int kvm_zpci_set_airq(struct zpci_dev *zdev)
 	fib.fmt0.noi = airq_iv_end(zdev->aibv);
 	fib.fmt0.aibv = virt_to_phys(zdev->aibv->vector);
 	fib.fmt0.aibvo = 0;
-	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
+	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
 	fib.fmt0.aisbo = zdev->aisb & 63;
 	fib.gd = zdev->gisa;
 
-- 
2.43.0

