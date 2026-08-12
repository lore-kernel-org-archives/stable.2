Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2EF40F72D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572814; cv=none; b=rp0i78+cX6PCfHqYtiC6zInPs6YEXaq8dUPlHKi8dOSAV2mrwp/kZrce4O246anYdqcoEsW3UvWvmbTUZ9d4jE2kzH2cb62FkbGkXLu0TV0X3tOwcWXvXd22BepZXXM7AWsRQg4B74SIxQJbMRvidqHzLqjB3oLBI+bHfmih0VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572814; c=relaxed/simple;
	bh=9V7xmBojvV77JwTxGk79rdJpFqDeD6dhma+cxOoHygo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m1vROD6sxDIXpiK1malKYgWseHDsrVRsnAb2tQiaGo9L68kGJ8hmldY3EoNNlMrRhxxj0Tx8CxFKtBHH7gxANHcCeUozwHNWkcXx8F/MTV5/RegDjpEJaJRtX1L0GXZh2xk4EnpsO3wLbta37qTooqyok69GFpoA3OOfloCe2Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MQFjk0w9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MQFjk0w9"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2t7d323350;
	Wed, 12 Aug 2026 22:13:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=AeFVPAY9p6tj2SWm8
	8/ygmPkeUAwleDxtFT5RJFggzs=; b=MQFjk0w9R7JqtOdUn8lnjvDgAdFN4o164
	x4fxGjbrhmcXL6xrHdxSw7Y8ARSeRuJiYNxa/4n81WmYz2gVnp7dM6HW1wRbGrhR
	aLb/KE1NAGgUlyQ+N96j2LfFiY8hWj7s2hoeI8eGWA5pC7FZe1+UJT8/Gy/z/KRH
	oB8KWjJtBJHJmD4wzD9PLFrigEDduhLZjeO1eIzWU6PYpp7vlUaVBBvWjt+K2dXp
	mNJyuA9GvWD8d5rKTHb3Fo99SdV8NKRgvZ21QWMUlFZdC1S9xP/i/CdAOVfLsfHF
	5j9wgVTc8o0RYHcB/dzFjd7/l4r9kz55/M3xnRcUkEndtM0P+HLiw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwc428-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:29 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMBFVO014171;
	Wed, 12 Aug 2026 22:13:29 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gg6a1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMDRqC25297542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:13:27 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CE6E5803F;
	Wed, 12 Aug 2026 22:13:27 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D776A5805A;
	Wed, 12 Aug 2026 22:13:26 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:13:26 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Christian Borntraeger <borntraeger@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v2 5/8] KVM: s390: pci: Fix NULL dereference on AIBV allocation failure
Date: Wed, 12 Aug 2026 15:13:20 -0700
Message-ID: <20260812221323.3645-6-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cf00a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=VpFnpj6RERqEfYQjrFkA:9
X-Proofpoint-GUID: d4231OPpWJrJi_v_k6I6ftzokb4jZpIx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX+mzGx+1Cki4Q
 CBiLaFj8jUi3zizDRR+YbmCdd+ppXr35okPeg2PEidCYCoOIuPAQmP9W+6gv7Y2nW9bhtLgyOpC
 yZvf/AKcbXCdM2opXlNqi0Vdrdvmaa1d6clQ8xheydsILIGQzg+NqnZTrnXTovFrA/QyIIvX5Ed
 XOL027TBY34SPa07IjMAD7OgGJDVgicuSbMh7CS33CooUJzYSvcjF0T82RGfspIuAz3nDsABj7I
 NqcFiHbw2S4tyRvo6bUrWyK0rEO04Bbgh9qqFFjaYDF5Bf6B8dELmcDKnMeoK1R8eybIJZFX1NI
 ZAfV/uTewkl8T3OeGcPHNsTuOIAUWupOcrTgvZu5EFSSYK/rozhkYRMLcGAzPZsRPtBGJKGgHwh
 NDb9Q9uKZR68A38DbS/NoRVsaYDnVhaIk5QWxHSo8Z9rKNktYnWn6sB0L1xsCWsXAUxPidz2AWB
 2DRufnk5m7V5jwn7zlQ==
X-Proofpoint-ORIG-GUID: d4231OPpWJrJi_v_k6I6ftzokb4jZpIx
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX1prnQgNjjRC8
 3l68o5+BrpeSwL+uFBwZMhsEtAZdLCIGEpKkk7ZlBcnKE+kAQ5ho5BOk4pQb2LEuKXsY9yO/w4n
 HEAQyaEr2JHNMFS4sH0tL8oQTJeC8B0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120177

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

