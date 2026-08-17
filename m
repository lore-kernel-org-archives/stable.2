Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D003BA225
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997779; cv=none; b=bgu5AAZmRKR7/I8QZvlP++sawCOqWF4rvjhKSX9uYqBBH33IR6L37zGZtOi9sFaEtJSiPPySaC2++WjU6HVxKs0wZw26PB0NGsITyCHpMNelEMirEC0X0E3rAfLu5RjfOtFp4S3Yv2xvd6mBghReDMFyDwmCcr8F+Y7PxzgCUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997779; c=relaxed/simple;
	bh=fX96jEaFLO586uFvO33aHR2BkAh9Kc3rBV5rfCrrHXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Urg4guPeNpdn5eXUrigoYCctd3GQHVv5Slzqd9Wlx6gCN3BRb8J0f6ewKRg+P/ZMLLT12fJ4illafGN0IisuvmViR88aENfeyK/ahgTUakGoxu2TFi7kq5xCZLYAg9s5n56XZOUQP1Bnnfow31JXHBEMYnLQyGSQx3vekXK69NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZEjydCo4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZEjydCo4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIVkir2076224;
	Mon, 17 Aug 2026 20:16:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Q1Q9cteXc1CQbZbxI
	2qKHkIQOrzF8JnqFPCcJwyo744=; b=ZEjydCo49JYYSZbtLvl/rV46x/9B2U9lw
	xdp7/rd+9yw5SnlDHMd4j/Je63464vvCv5lRXRmZ6PKy9yfdmSc2YzoKz1lLBnt6
	uRxrIsJkzRx/aBhgC/m+CZGCBRE6ZrIbj5A/xwvIUamF+4uc/R/GuOb4HSax7bQR
	pJiT8Tc0Q+uAB+rOwYWe+NCR51hTTWPaCXBUZtyqpir11+UWUG/MQk9T5M4R1zOO
	VWHJb4EBxdLYFYmmzIOIRgy8GAVfMiIbppS+qeeqn3vCZSyoLnhZxqXYF+FAwwLt
	q+69Qe0FRrt38dcSZJHspfiEi0ukIYB4Y9ZWOjY1P7qXdeUTDWCwg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkv3d5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:14 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HKBImp013321;
	Mon, 17 Aug 2026 20:16:13 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng7cbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HKGCVh11338362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 20:16:12 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B577F58056;
	Mon, 17 Aug 2026 20:16:12 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3789058052;
	Mon, 17 Aug 2026 20:16:12 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.120])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 20:16:12 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 4/5] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Mon, 17 Aug 2026 13:16:05 -0700
Message-ID: <20260817201606.3194-5-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX2wBTyvxoicdU
 HvO1o+Z/gFEFqnPXhODKK6XQsNcyb/U5IuSEZbVmZ7QI7IeS2/IRWAEMG6XwnTSMMzQvYs24cHE
 PS+CxiV/ug1Y4k4F7TxHH9Mtz0Qwh4EnEg+uRH+1TBBbdBGEjRw5d8SjcJVKCxk/qk7kd+3flGr
 eGqHRP2HXrnbshq5xTJcKVrvlVVDB4+qFVdqvKNsOqVe2Ju4sjInRACAA9uQJH77gtPlv9aK69C
 YPSXCgrmq8MGh3rnCQ/RHCxIKsqK0TBnyzB0k+g0My1u7K/iePtlHjTG+wxwrqPwSCIA8XsWLNg
 +eWRaq1+qE9Dbw0CrABrfrE7Vw3OVvFuv1kjcRAo+3yL8oB3+k5DMK0ru3MJA8B6ql36nMdt+UU
 4EJakuF6571qXIk0CosaBJQEMkmN+xR4MFP+OwaXkVR1Eq5GwMLSubODzJHCSSi7MmpL9CynDJ1
 7L8bs0HxkmLgofOkMtg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX4v165HVp/orR
 SjQsat5g5+REATPd8j3UswArCPCuS6jA9taCk1jrHhvlV5wXMhMnzUuhsxLC8TGyB+tY3rIAVsE
 2Lt+/AOAr0t6vtUlZp16zqRuXWbnWzc=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a836c0e cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TYCmRUurIKQ9kozAUfwA:9
X-Proofpoint-ORIG-GUID: Vt3jy9RCNLtSGN27zH2sYfxh7CjA7MMy
X-Proofpoint-GUID: Vt3jy9RCNLtSGN27zH2sYfxh7CjA7MMy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170153

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages. While at it, remove dead code that stored FIB
values that were never referenced.

As part of the cleanup, we are also holding the aift_lock a bit longer, as
we hold the lock while executing the MPCIFC instruction. Though this is not
strictly necessary, it means we don't have to drop and re-acquire in the
error case.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
Tested-by: Matthew Rosato <mjrosato@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 5580c9858f1e00f60191eb09c3add359836d60b6)
[alifm@linux.ibm.com: Resolved merge conflict]
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index a6f6d5ddb0e3..8b91f289226b 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -359,19 +359,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
 	aift->kzdev[zdev->aisb] = zdev->kzdev;
 	spin_unlock_irq(&aift->gait_lock);
 
-	/* Update guest FIB for re-issue */
-	fib->fmt0.aisbo = zdev->aisb & 63;
-	fib->fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
-	fib->fmt0.isc = gisc;
-
 	/* Save some guest fib values in the host for later use */
-	zdev->kzdev->fib.fmt0.isc = fib->fmt0.isc;
+	zdev->kzdev->fib.fmt0.isc = gisc;
 	zdev->kzdev->fib.fmt0.aibv = fib->fmt0.aibv;
-	mutex_unlock(&aift->aift_lock);
 
 	/* Issue the clp to setup the irq now */
 	rc = kvm_zpci_set_airq(zdev);
-	return rc;
+	if (!rc) {
+		mutex_unlock(&aift->aift_lock);
+		return rc;
+	}
+
+	/* Start cleanup */
+	zdev->kzdev->fib.fmt0.isc = 0;
+	zdev->kzdev->fib.fmt0.aibv = 0;
+
+	spin_lock_irq(&aift->gait_lock);
+	gaite->count--;
+	gaite->aisb = 0;
+	gaite->gisc = 0;
+	gaite->aisbo = 0;
+	gaite->gisa = 0;
+	aift->kzdev[zdev->aisb] = NULL;
+	spin_unlock_irq(&aift->gait_lock);
+
+	airq_iv_release(zdev->aibv);
+	zdev->aibv = NULL;
 
 free_aisb:
 	airq_iv_free_bit(aift->sbv, zdev->aisb);
-- 
2.43.0

