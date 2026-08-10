Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C7F24432EC
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786391500; cv=none; b=UusdO5Dkh9uxabZpZxIDcHjltlVzjh08X52D2PVQdrsFGJCLdsq7gdLdoz5fy4MKebGPfd8agwsbCoTXoBkuzcS9LyZ7KfTL0vHRvIBe6Dvl51ddIxqT3FVHm6ljlfi0VRjVh/90vWueCn2LCWfSqoIqnaoQwumYrnaiecfZ5PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786391500; c=relaxed/simple;
	bh=lxcgNJKxIzojkDf0aZ4vcJgeckKS3Gl/PuCGE85A3ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sASDpzU/wztA3aMiV5v8fkaWiaVpWHsz9QUgSgvtIRKHKKC8oVhgZnJFFVCe5YoEKCH+jglBqU3DFu8rtEq49MeyA3uCwg9dojNkBtJmOtlTgoEhksBGoJ2XLY7augKjY2vlSZ5Nt/q0KkyULCWNDbrzKThBwZWcM3LnINtrLkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aXX61zzy; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aXX61zzy"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67AJ2F99613902;
	Mon, 10 Aug 2026 19:51:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jqGVrCMXY7Y1wj/qF
	ZEYFoYZTVXwcTxU/OvmfrSvs5k=; b=aXX61zzyGZmUIf/syyofgkTX9cHMkvmrC
	KigG0RMmFRqc09hbR+BLJwDbtOxhA6Kw2xMBTIrH57QFQ5AKegedcPslbZc0Cs52
	cWqCUg1UV7HkXCbFS70p7ASuVq/rEB5ijYwTkaMJBKhUx5LPs9C0g0OxiYVbnEVc
	3Rs86AyNOajf30mGhD9xoHjhxfRcSAzTKGlAfgDoiEQEOmGQhxvGbKCVLs9qmJFc
	aPUrLlprag9sWC9PtExbGPSS0adKppUT/mPfmlDuZmHlYi+AkcQKyP3KK5gf15Vn
	9dn5eV/B9W+i4zO31SbjnUNxV7M3MZdiPTqmWknjBQw/ZTiAglJag==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjystxa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:36 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67AJfboZ028527;
	Mon, 10 Aug 2026 19:51:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjp7k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Aug 2026 19:51:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67AJpXSD57147782
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Aug 2026 19:51:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6EF458052;
	Mon, 10 Aug 2026 19:51:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 158A358050;
	Mon, 10 Aug 2026 19:51:33 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.246.243])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Aug 2026 19:51:32 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v1 4/7] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Mon, 10 Aug 2026 12:51:25 -0700
Message-ID: <20260810195128.7861-5-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfX3DSupLfSEnjC
 nL1OeolIXFWbqfKv3UAYEPCP3vJHvQsw+pHXdDQzF/F0jA4vX9CVeSwvMFI4UoKSz1DATrMzWbc
 tGq5eiRAe2LyLex6mi4qfoD3/3lrD59JRidAKjjREMxX15nicu55CRk9P6apaGKtYXNotuXKpCH
 ifX2CANB4PVls0UHzDuemwSXl/Akppizzz6nypAnZYH68ZAwDUiwlLU3NdKCSZCjR2SRXB/NDGy
 vmV6x8aG7cN2ts/PGubZNJvcCFXFKIMn1jxNxVNe33zD35oEVl3IrGGXnDNrff3nQ9qfePhGeaS
 c5r+BWkIakAk/aMySMwsTY9z0UjJWBvN/XKRrtgKiMVt+trkMFlyuVRAwIejBtC1Ypg8jGcPpqC
 0hoPbxM1VJqlz8trx7plcCcFMPLurqSY2wsQyX9lf6QakUFauhsienwI0Ls/LEK0/zPFbzs/JTc
 MrbYjFwN8lIj6oBcdJw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEwMDE2NiBTYWx0ZWRfXxmPvYE+acNZH
 Zh5y1nTgt1iKl7q4+Z1sJfQ9VAZitCNDZqcKphvnk/rf1JPqQYsn4py1SuXkBDBa1uj93OKXKBI
 b8184z1vKd05ozot2veiBZMDU34Zuac=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7a2bc8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-GUID: 3G4RB8c5rqa7x2Zpx_y1wWQOifz1uuR9
X-Proofpoint-ORIG-GUID: 3G4RB8c5rqa7x2Zpx_y1wWQOifz1uuR9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-10_05,2026-08-10_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608100166

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
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 0ba9bbbac45d..0100c445c08a 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -301,14 +301,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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
@@ -352,6 +355,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	return rc;
 
 unlock:
+	if (pcount > 0)
+		unaccount_mem(zdev->kzdev, pcount);
 	mutex_unlock(&aift->aift_lock);
 unpin2:
 	if (fib->fmt0.sum == 1)
-- 
2.43.0

