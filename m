Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD182443303
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391501; cv=none; b=KP3yJxNUiJ30QsXwdew2JD7uxrkcYLqGUKoXF7RddVBovkz7fxg78oHfDD9Z0Epd4vCecU8qz0pJitArDG7WYV63cSTV0PLas11ZOFdIZLtKhVy/OCxUwRLB6oJrzhVdDELk3dbEXADwxFLKS+s/9luXGl5k3RQSKZWSF7w6nzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391501; c=relaxed/simple;
	bh=9V7xmBojvV77JwTxGk79rdJpFqDeD6dhma+cxOoHygo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BAI6vHH+xyDQKMHxJkZIX9FXQE4CqsvVS+crqvZ/QqHm7i0fuwz9c2ZtFH1zcvL3SrlZvmb5Jyyk0agVdaIykPEtMl1LZPS3l3KSWWnzPS/Y86i45wI0CYFSIrUhFfKQNJnRLh8P3qQg07FBAz2a3Ol6GPr7UJeaJQUog7Y+o5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n3YNtdLn; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n3YNtdLn"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2Ix92513345;
	Mon, 10 Aug 2026 19:51:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AeFVPAY9p6tj2SWm8
	8/ygmPkeUAwleDxtFT5RJFggzs=; b=n3YNtdLn/x5/hybX/8jXhRZzeyyFsILhb
	iNEbDltaXuxhtpwRJR+BSWpolUThQKeVzUTEoZ7/O84ZMVPAL1q5nZg5I2hMN3kW
	ubu/JkpngXEu6rDEGLGQG7z17TLnjVdSywvwSEkXbGQU+fi4vfsa2tn7otXI+Znx
	EIhjsYzoUh78ES6AAnnQlldlWh8Rc3p/yGwszVL5mhQA6FmnhWW8gEO/bnNubWLo
	EPmxP8WRQZ7Tm+wWyBURVnxSfNuYoKcyVVGOSp9SlxvYHU6Fejyll8FvpXFH8m4t
	FP9AvTm3jQVhbtgesfWh4AT8vDhNpgLeh8/rBr53HcVucjbUOQfyw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw1b7r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJfLKh003635;
	Mon, 10 Aug 2026 19:51:36 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfxx09g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:36 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJpYtX29688410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:51:35 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C88FE58045;
	Mon, 10 Aug 2026 19:51:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0E09A58050;
	Mon, 10 Aug 2026 19:51:34 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:51:33 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v1 5/7] KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
Date: Mon, 10 Aug 2026 12:51:26 -0700
Message-ID: <20260810195128.7861-6-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7a2bc8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VpFnpj6RERqEfYQjrFkA:9
X-Proofpoint-GUID: GvjOmSX5Vyiu7a6qmHzXTlXsQUmEXExo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX4ggWluIQKTht
 Z+WaY7awOwcqnZaUzXZ9BTwKwNVLS3Bxg8kkXqLJi4eYNMWHQe7fJJDDNAZDWkBbkoG7FDn8k9a
 SboEtIyY8iJ4OgQlfUxDj1LlWipRWteFYFl8NAFj/H4nx8PVRv7PWJY3AzsOEtq38Uq9RalfEnM
 /oobzSYNKonvdIjCNzH4cUK+PLCvFFzlQNMuu1XWCxPoCltyOkW1CbL0VahcynvpF0jiE2wWz7C
 ZupKPk7z45TKcpDSLHZLbAiCdtwpFilQ7VkJL+IYKux7pvi1+5AY1bUm4vrYpGNV8qZeAIlu5FP
 mmOyngf24jQQ5cmN7ByTbB1zpXz5xOrt+9jiO/NR4KdTlAsDCsAxI/76KBTiyXUpTGNi02roA4Q
 VBT8owSmfNHh8dar2/hvHtcqOOjdOmy0EA2B8sPAgU9HZ5Git+sEjwDh0As7hxAmwzXyIbYSJEq
 9rJcxxBJY4Ag2/c1z5A==
X-Proofpoint-ORIG-GUID: GvjOmSX5Vyiu7a6qmHzXTlXsQUmEXExo
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX/QwpayAGqD4j
 Ok0FcOSMLZe4QKniLsBHGa51MyHiquWWiPaXWJZsyvZTDWPs5bG9lH2ODPMqqjv5mBfL/D2JQ+v
 lHQL1jliIoghtG+XYW5bnCJD0v7d25U=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100166

The airq_iv_create() can return NULL on failure, but the return value was
never checked. If it fails, zdev->aibv will be NULL and fail when
dereferenced in kvm_zpci_set_airq(). Add a NULL check and free the
previously allocated AISB bit and zdev->aisb on failure.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 8bf09b9b7d3232806df95f409581f8a9fd99a3fa)
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 0100c445c08a..2a94c4d9f050 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -318,6 +318,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 				    AIRQ_IV_GUESTVEC,
 				    phys_to_virt(fib->fmt0.aibv));
 
+	if (!zdev->aibv) {
+		rc = -ENOMEM;
+		goto free_aisb;
+	}
+
 	spin_lock_irq(&aift->gait_lock);
 	gaite = aift->gait + zdev->aisb;
 
@@ -354,6 +359,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	rc = kvm_zpci_set_airq(zdev);
 	return rc;
 
+free_aisb:
+	airq_iv_free_bit(aift->sbv, zdev->aisb);
+	zdev->aisb = 0;
 unlock:
 	if (pcount > 0)
 		unaccount_mem(zdev->kzdev, pcount);
-- 
2.43.0

