Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9DF485515
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569851; cv=none; b=XPz4CdlpI5EIPMDRqCyiNmGSWn52LytmnDnM3JKM2XVRQsg8NjqAU2h/l9EFVKamq3gpuNZeuLppd2nZ/PU+YBuKI5HwqHi6N06DMhDKJztzT6ingff8XIFgtA5U+jOfVQKynLxUH9w4xCNCrRJCso98cdhYuClEr/mDorJDjAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569851; c=relaxed/simple;
	bh=9/9SxQuDFlSuyk3oBCBhkhP6UsGmnQqNny+UZK2ZPy4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uL0/Lk/nsaMcvVCI+q6xnVANAtBT76CqV7bp1RaaaHdSoxqk72T44fmHISFyg8tfT4n3br4ooP6GLmvH0q/HhOJUNJe9I/pPd1Zv3ysmf8ojHuid5Kx8yO+GN7oFzeN0KoBNsWb8bXOfKSje2+fL9fSgTmEHlgiNi3X1Hp9ZjFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PmOAYq4D; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PmOAYq4D"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2b3d242390;
	Wed, 12 Aug 2026 21:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9nGw4e3mKRTU4aFgA
	GFHNjx41F91fAu2bsidnXeZSfY=; b=PmOAYq4D8t8W0MPRMT8p/uBnkzx2FpnM1
	1eluE5vJTMaVVuCGDkQ7dFjtg0N6Yvz4yMmOTs4FB0WQhJ+Wy99ou/D160ArLXWR
	bbEje7jtTb/5qRfs/XIz0paV+QwbMMs/4Cj5IcQCeAq7FHNXelZUKsI+1f/FpiLc
	9ld7d1Xu8u/2+iimaL1TOgTOH6ZfyxFqI5ZUOvSL3jSTmBJdBMD3T8FBoz1Fi96e
	YJTrc+1m4Hin2aAx+PLkUbfjlTVOqAagtsu6HYmAl42m98CRvo0QcG4D8Qt9YT3v
	b3DjVjWDz4u2AjyDN7iV8D9jP17W4qSVJ9xtAbvv6PIrlNwEHz9BA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvq9mt8j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:24:07 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CLBIK2028009;
	Wed, 12 Aug 2026 21:24:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h82pg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:24:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CLO5lx5767828
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 21:24:05 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 360D958055;
	Wed, 12 Aug 2026 21:24:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ACF5D58043;
	Wed, 12 Aug 2026 21:24:04 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 21:24:04 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 2/4] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Wed, 12 Aug 2026 14:24:01 -0700
Message-ID: <20260812212403.3143-3-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812212403.3143-1-alifm@linux.ibm.com>
References: <20260812212403.3143-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: c7DfA6xONTBDtynEZpSEOyOebHzzfakg
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a7ce477 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=eJt398lxKxdzswCBiD4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfXxFOW/WXRaGxD
 YYKjb90DD+/cy6ePV3KDzozxDPgcByTA4Iy7SBOpS1RPRH8bljiFa5+f15EGkv56N0fDTxWDTk4
 YZFQV2nHfNlc6Lx8vcGTf0hgWNXmFGGQH5jeXwUlEfghLqZoCIm8+54SzMtLEj+8xRWd+ZWtrB7
 tar9t9gCItc3QFPTBGKmB0W/yP1bgXpnvN/Bu0AJCEDVCDbRyHO7XAtok2LOl8aDFOgU9D7V349
 qhevA87VHwZrxBGQE3wGz1vI+a+NR/WC0yY16aPNzf6/SzjKk75PR6MIq3+P2LsqkWHr9VXgCL+
 dnLqjS+grmPtZk/orVGRjjvmQx/gVkoSd2MjUBSmbiCeI3qidV0zywAXSX9C9JBUCNt0FCvnfoH
 eAshT8ZD85kxsjAawvTGn6o3SoPzFCrsJ8ZrTdgL0qXH/cSAwF6NlrG+RsBfCnYe5C6GjQjCCsB
 MIlvN2GuODZrdKP9s4g==
X-Proofpoint-ORIG-GUID: c7DfA6xONTBDtynEZpSEOyOebHzzfakg
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfXzzB2UpD46+HS
 do9Jxivt+qMS2+Sji2eym4eiDAnAOMj//Laa2WZpzBThpTPgHYAKvl3M/erHtjCfGYMNENRsobr
 /dp9DnTOzaQ8h5hAJwwobx3gjkEPvCg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120169

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
index f887e11b0f1e..a20fa27fa030 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -315,14 +315,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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
@@ -374,6 +377,8 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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

