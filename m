Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C5E3B8BBB
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 20:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997778; cv=none; b=a4vqj2/fYJ/LKAqasHqI6TT6rvoQq1gsAAXPKEi3Kkm5F8YnutyU1URr3SyiAES0TeFguMOhh3wKnEo6o+L74IV1C3nNjPTQD7eV2ofXIFzI59zIy2xx3k2lqJfkdlcW618eLpAwFiWAXf0Jzoq/stuZzvMqoJ3DghCwNtI4Ugw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997778; c=relaxed/simple;
	bh=z9Xp2FJMFMnp/rXbr+3N7lv99vt4q/wQt5NkzuMWpBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wya6VEGcFw+0TM/9DRKk33mVUm3a6fNlti7PmRLrrtj4KvcVMKLzcrivN649GpO/mjeCx4J6cHt+Gb9SsnP13tRs7ioHKORe9nTccb2cp9Ltcp25pi5tby0enjiXuwKteCE+lVFdjiGQ7ypzVpDDwIBqUeLQcw7cL3/pSFQpzi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DqKmkEJR; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DqKmkEJR"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIVcgs307228;
	Mon, 17 Aug 2026 20:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YC1cINmvqCggEJQaW
	1BBPnzalSfeyxe2B+GYf4a0kOs=; b=DqKmkEJRXL1gYWhYC0vNQm4dKlQPZXc+U
	xpYjd9McN1nIX+0Qopc5Qh0ievlejljiFVXZgc/ZPmOTZCfXOKz7yWCX/6JMQBjh
	GMoX9VHKJGy/AQoZq74eqYUgSMv7AFY6gqOqHohl68kD3382n0uyVCaYZamcr++j
	z1SCgGMZufoE2JAAwRE5xYHSbYdlFgGtKnQbDnyFqieA9oMKL4AZdu1kFBn6iono
	VkxaOYmKOT/1662YUWW2XQGZbiGuiueYTKgMUz5kH59rZJC59My4ezuJbU2cTRaD
	2dAeFS+2WKlDdmqlNAzMVt6ckOI+W2GScJ4O8gfyJXXpeyXtb7gKQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqm5qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:13 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HKBH3n015352;
	Mon, 17 Aug 2026 20:16:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32epyr57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HKGCPC27329242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 20:16:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16FBD58056;
	Mon, 17 Aug 2026 20:16:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87F0B58052;
	Mon, 17 Aug 2026 20:16:11 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.120])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 20:16:11 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v3 3/5] KVM: s390: pci: Fix missing error codes and memory unaccounting
Date: Mon, 17 Aug 2026 13:16:04 -0700
Message-ID: <20260817201606.3194-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260817201606.3194-1-alifm@linux.ibm.com>
References: <20260817201606.3194-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfXz06mTXJ6EM+2
 poRXf/50kKd2SKupBiT/3a3Ytld3CIwnOQA4H/0/7w4PO/UZQ+QDbQQAtq70PXe2z86yHRh8Mhf
 lYfaXunDSXGnij4rbrIG2cZhKu2hd4tfSZiUEM29eA8f9w5+68JqQZULhR2F2LwXKj5J/b/Z4LW
 LLYKcCLeQ1qX3cQhGbMRgUsVxbU/Var0nxSOGT20vzBbQh0MsueIzMDcQEsTlAf+26C13I1m/2x
 GyCsPdhnJK7s8Won4cE01QgM9gSS669/reiPCjmvmTh+JeplfcFGSIum1AqR8PuaarFH4HhS11m
 MjH6EGUckqaQleSEngiE301sc2HynlmuONMTUe2UQlkojQ85I/Id9/zom5xAaHL8LHQApuBNC9r
 Xpyni2oFtag7G9H48l2B9SPIMN7j4EKngIHTdImCtDqDuMUxZQFft7NasEaL5MkhtIGFFtu1Mgc
 YNucfBGAHxWilOK7TDw==
X-Proofpoint-ORIG-GUID: 4LBoHKzEBufBgpCNbRh-HH_sLw-MEByF
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfXwVF39t7Sqal/
 FYSDM29LwxZCerJyXkiqGvGUqIgy00Ph5I/JiCFDrxwvwtU03tw9FbGusrTr1fJrdTPv4XBkoha
 JfnxH5soVU4GPGU5XzBz4tgagoxi6Dw=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a836c0d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=g4erIPh_aaDScpLpsJUA:9
X-Proofpoint-GUID: 4LBoHKzEBufBgpCNbRh-HH_sLw-MEByF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170153

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
index 4b1ed363b1ef..a6f6d5ddb0e3 100644
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

