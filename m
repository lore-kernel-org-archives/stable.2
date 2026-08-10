Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0315E355F57
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388577; cv=none; b=MTBTONeO1XLfrFnloEsMnBvO6r6hMIprL58E8w11hwVkYvEisAa8TwV/kFAyWFwaYc/eUOzgSV8PTIa4kL8G3UoaCkU9bSp6srs4Sv46K4RteMwGCaL4DFFdOaNi0YWKKu2zMwIRNtNXxc6gMDZ09ZV/41Ek6XwMg9dpCLFXKRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388577; c=relaxed/simple;
	bh=E+yRqXZIs5ODktFgnNOcdiis9W8qkoE6TjCFFsKScoE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iV2izEdKCoNqiUESOISvKUhLQgdfKHy9ju/rTjWNTUCQ7czuwcJFOP3IqdLHLMtVH6crAmB0/Gikwzlc0DtqyjafwvPcPvS5GjqVHGdVUX3fX7/nAJbterq9whkYUhJ0Ee+pvAgc3r4uWGe+bYZ6+MZcO6fSapgpCmbWvmMpCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BoqceTDd; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BoqceTDd"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2Fl82513288;
	Mon, 10 Aug 2026 19:02:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Ty9LnBJu1b9cOE0q7
	ON1YrYFrlcBFTqe/b0dXb1rLiE=; b=BoqceTDd7f6C+j1tIqBnlAuqvI+CmEZia
	cyKcIMjTH3rYUyyevSzOACZLXQ/Eg2Gnhcg9cwyKUhDbGNbIngVkhU2UMm+MBFGQ
	oSgd7JH9RC86hvm0NooiYQpVCSisTmCREU/M2PBFJFLcKScICDFGhBOB1SvCzNr8
	/E2UWhrNHwJKPS1m41QBt2JQWUPeueUcYXg7M/+0b2a3NfO+znjQSrHWDalVd9El
	/xA6V7nabDv2MXFZGKNFN9bsoCHkKqejI2wpVaZifUjns1u4ofbK/R6meiyeuJsC
	cFYTIJBgTV3loan7NtW/zOcEcvtY24S80yqQYFaY2tl0tj7gwhhfw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnw165h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:02:52 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AIfKJL022881;
	Mon, 10 Aug 2026 19:02:52 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjp30v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:02:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJ2oxp13304322
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:02:50 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8F41758059;
	Mon, 10 Aug 2026 19:02:50 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C65DA58063;
	Mon, 10 Aug 2026 19:02:49 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:02:49 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 2/3] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Mon, 10 Aug 2026 12:02:46 -0700
Message-ID: <20260810190247.6344-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260810190247.6344-1-alifm@linux.ibm.com>
References: <20260810190247.6344-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7a205c cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eJt398lxKxdzswCBiD4A:9
X-Proofpoint-GUID: _fblKhO8vZ-jbIkyVEzHZohwR4dPfVYR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfXyQCl2usbEmKZ
 xhfmwzG2GZ4Z2AMEwgO6ilZjcDVjYdEv5DZzxGxaNe3qt9VlSudwcnBdwNQC/FkA5N7lrYhECa5
 20j/ctiICEjWUd5zIR3EKcHpDwlXMjsyUBfOE5cHral3hsptqUfpZPYSfUy3jqKX60XX7HQrUyB
 BDEk14AyealDSIp5kTHt96j3jKyuU80l1IRkKzpx9ahkdQu4yH2oivrfCDHvc5CScgt88DCEH8O
 eq8UGXYl3vItmrp+6+pD3qjVlxJKpHEQRLyoRmSZYZpey6FQP1ffI9CwihO7uTNzlBlZJ3dYVJb
 VcC+4p9ZXoOUxXcglNj1rRoC6WkeK3wWAaPZBnKfyFCvh3AxOw3r2epcHCu4sxO8KpwOGABXPWe
 l0K76k503Z1YkpD/kHAMUxVG9eM6922+N5rIbbwSM75LB+kJTgXlZ/lyEha5W7zDGfh6TDTtsTr
 72Hq+6G0HyfW8p9/C3A==
X-Proofpoint-ORIG-GUID: _fblKhO8vZ-jbIkyVEzHZohwR4dPfVYR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2MiBTYWx0ZWRfX+BcWWUgjTXX6
 O4hNbJFec64zTi+7ezs84+7zt+aSM5kVJQlUPx5qyH65QvtFfPKybhYgZXlDRRlzAR9pDKcasTT
 6K9CFYUxkkNqgigmJT70vT7bnfZRzMI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608100162

In kvm_s390_pci_aif_enable() two error paths failed to set an error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating an error code on
failure and calling unaccount_mem() in the cleanup path.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit f86842e4d6c482300f4567f492d512c9ccf5bc4f)
[alifm@linux.ibm.com: Resolve merge conflict]
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 54a7a2f38c69..56a19c00d3b7 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -316,14 +316,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	}
 
 	/* Account for pinned pages, roll back on failure */
-	if (account_mem(zdev->kzdev, pcount))
+	rc = account_mem(zdev->kzdev, pcount);
+	if (rc)
 		goto unpin2;
 
 	/* AISB must be allocated before we can fill in GAITE */
 	mutex_lock(&aift->aift_lock);
 	bit = airq_iv_alloc_bit(aift->sbv);
-	if (bit == -1UL)
+	if (bit == -1UL) {
+		rc = -ENOMEM;
 		goto unlock;
+	}
 	zdev->aisb = bit; /* store the summary bit number */
 	zdev->aibv = airq_iv_create(msi_vecs, AIRQ_IV_DATA |
 				    AIRQ_IV_BITLOCK |
@@ -375,6 +378,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	airq_iv_free_bit(aift->sbv, zdev->aisb);
 	zdev->aisb = 0;
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0

