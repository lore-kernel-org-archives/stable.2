Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD2B3FF1B4
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572813; cv=none; b=LbfJjAvXnaoCaQeS3GdUvV6TtgHcZYo1bfy6/egwJ+sKkknN5KUrh1Fk5XQemp80ILMjD2xMb88c4Dg8mwg4DQi2cp2+MZuzeZyQZhQXQsGNetaho1ITgOJaIF8w29vUEw3ihajf69lRiui1ZMjSkAmWAzFqNsmqEJC28UeT1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572813; c=relaxed/simple;
	bh=lxcgNJKxIzojkDf0aZ4vcJgeckKS3Gl/PuCGE85A3ZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O+jU6Z0dhpFs1kUlHcCATGj2kaxpFoPLx6ZmBgJAM9q4mpSrSf5t088O/FnrliTfRZJq9fAMHKfj7zcuvVa2sfw6pnJBB2q156h1GuqJpSwpIHRoNYRf825SK0R/iPm0BqVvV0tyXknkgOx0ABBTGoatUKAk9ka7AT6cxeiUcEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=poMRwbAk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="poMRwbAk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2vKM323419;
	Wed, 12 Aug 2026 22:13:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=jqGVrCMXY7Y1wj/qF
	ZEYFoYZTVXwcTxU/OvmfrSvs5k=; b=poMRwbAktySnxmtBHwHbEefIFbLLAK5Bl
	+f2C6ukut1SGZB6wpPfOu2SyZQL/tpX/V50H+ZpgbMxFK89F/0L37G05mpYxvCll
	8JADktKN9LAlykR7oPgNWZfn2SFilq+uI8Gnn2vbFW4LLzR+ZQpt8i1QpOvX4+q3
	ZH8MVStJThy7Po2a+mWQj2M71xX4EPevmAiBJD5/pQczRnCM431GfuborClF2gEe
	u2nEBQd1c9GRWSSB7Z1NfzOeN954B5hlQ8MCinqxlp7I8SPRMEpRW9WfHmZ22Hpg
	i/6Tpz1WrZqaOiHpFKowVaCtj7N39aFEOW2sP63olRow+rFgHjcHQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwc427-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:29 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMBH5E009190;
	Wed, 12 Aug 2026 22:13:28 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq8frj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMDQ6A28246734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:13:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA03058056;
	Wed, 12 Aug 2026 22:13:26 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 409675803F;
	Wed, 12 Aug 2026 22:13:26 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:13:26 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 4/8] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Wed, 12 Aug 2026 15:13:19 -0700
Message-ID: <20260812221323.3645-5-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cf009 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-GUID: X_yi2l9pmEnkiV6iGDzh-4egabSjpGbR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX/kmYf280iCsd
 rmj4bvntZ8BM//RvBzIHr4QxN6FId8WcUro3bSH+xyTGjyVi7WDjtE3fCmmmAgsa6eCYFemWYI3
 hfpmFsstE4BTkWIFGYI+8FTjE8JySwwIzVS2AmNA+xcL+v4lDbPSuT+DJzi4Dfn/eptNddNnMCm
 lBQ3DCSA/IV+oeh08oMOp63Dp+Jy7COhB61qMQTKdausLg//serFfJl7/wYpHhJz1dSvXjD15n/
 R3/Y1r1WLGgCteEpLoAUW55GnzRxBxRLNvk8xtx24h8z2Uo+KFUZJPERTIhrh2Xcy+16nYbqOg7
 3VYCQGGnWyxq7wmDBbxAOm3wum9KmOYxRWZFqFdcR1Kt4s8A3IKiD1QNQz+kj8X8h9ovN4xuF1R
 M59NfksULdYsjr6O8t1MEmu4W84xOZRZGHCCqpNIRd8ZBFSmZ88CuywOrkHVpXWc4Z79IkiDXAU
 MVr0YoJeBVIwSy2vBMw==
X-Proofpoint-ORIG-GUID: X_yi2l9pmEnkiV6iGDzh-4egabSjpGbR
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX5tcwHS5o/i3z
 H6sZwAnLZ/3ShsFklxya8D1LiNcvMYPq+MDKyqto/y3LHrwEWWPzdTNuVxL++TptT1CWq16/hlw
 LWltxEPyS8s5Grhb/WGIgxzk8L5SfJg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120177

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

