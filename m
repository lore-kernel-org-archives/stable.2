Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7440E31F985
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 19:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786130543; cv=none; b=b+cbXKG/UJJJWdEXjK8ukNs1w/STf6R+xN0bMPRGbFnO9C9OHiA5439Cx4bQF2I3q4uexhEA5MPjFGbApL2IIC/3OT0Z1/DQtvZiCmYLmx0OjDk3gk3e/SfTRH83nNKSjrxsZ+icpUR797RSY5yV1RwiBIOo0IR3NEV8PdzKsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786130543; c=relaxed/simple;
	bh=4pjN3+gTSVACqPH06ZfQa79QHh1HVozT8SVxLg/MG58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rgrV4vQeg5I4Gpx6vIOHMQfIwX25KmmruVk6l70iwCxrKj+2tzb4d3Zq1t69nKftaUATm+uyvPwSJEDBTlsJtj7qzmXrqTijGMi1ldiAtBzYMCbyQM39GTUWb+hvBTK8baoOhalXQy8Wm3ylN5msxsbHvUPO2D0bmLxldzzAgUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rqTYnxaM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rqTYnxaM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677ImZeZ2187638
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 19:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wXuSu3EPG6tTYbNsU
	kAevhKItI9H/kXMNuGgU/AjCnc=; b=rqTYnxaMCqmBL2CTyDcB9jm4To8cpvuai
	KFM/5YCj7NXO/HGrrDK8ZvvC+wion3Gp8uBBndXLLSKwbwGyAsBZQNOmF8A4Ta2f
	Fa3KgvT9mW4+CIEgYdtUNhtrZ0E+UwUB1KPntyalluJQXQVr26Ug8CQVjbGiKeOi
	jizF5vodQZ8XJsnW7eEnnkeOcSrBXerSZhS/ENGk2Eb3zlIxi91sCnzIdI35BZ16
	BvmlA8LhYCJv2CcJj6T6HcgEfxCe6AecstWS+0SZkxK/9hXki+XvYc6iSw1i1d4k
	DiDup4gzbLv02jnzNKpqCtx706LuQgRAhUwFOrBbdd1IoFuwJVoqQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02dcnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 19:22:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677JBJcg028750
	for <stable@vger.kernel.org>; Fri, 7 Aug 2026 19:22:20 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswu00ujk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <stable@vger.kernel.org>; Fri, 07 Aug 2026 19:22:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677JMIjH29164180
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 19:22:18 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8ACE858055;
	Fri,  7 Aug 2026 19:22:18 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A79A58043;
	Fri,  7 Aug 2026 19:22:18 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.14])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 19:22:18 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 6.18.y] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Fri,  7 Aug 2026 12:22:18 -0700
Message-ID: <20260807192218.3563-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2026080528-moisten-subheader-b32d@gregkh>
References: <2026080528-moisten-subheader-b32d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a76306d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TYCmRUurIKQ9kozAUfwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE1MSBTYWx0ZWRfX1L3j4IYrPVB6
 QE9FVKeXJAMEhH4ujQQn/tHuhGVH/CJSdXKfRuVvvlGLAzvuS/qnatxF8vXAB/Idoh/meOQsN2/
 x6xVZy93hEL6VK0fkfFxgcMUxgFgdp+h3WyO+A++gyF2PVnYTfScgxOTlEBtOJemyFrPWggYXaa
 0qQ5k+RarzHtBKHjJmznxAmtztjNAcA+1h/zPetWTf4ekOFyUfy+6GM7Ou1G5jwBQMMC0FUVwxY
 xeR47oM+rSphtoAGVagEOSmKOPYgMvzqZSq2/Gr3q95s/5facXsVY5maSUoBNX+GIcnV8ovFxIf
 GC9d4qy4an3qozN2KuK/8rFI1CtmP+4xsTFJgcGATEt5WOKo8TF2p+R+2E43+atOV/PAnHhV+yy
 n7u6rXEEfSn+1J0Cuf2LTRYKpM+Y9jJngEMdEzvkkgMolOMwnBJr2W7ZoQzV+MU4gZrAP7I+9Cr
 E7aJCvdk5U9/KfLcXBw==
X-Proofpoint-ORIG-GUID: BUEWuB9kY7955cPGsdtpzqAVb7E2DXCm
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE1MSBTYWx0ZWRfX8mhDO09Ns2/T
 9mMNTidwHEXD3JqGdEsp3zjUzlhDE7z8xEIOXKg4xaTjct3CU5+PB9Jtp/0EBNJAstWr38w96iX
 wyU5eqpavpKD/hCOdhwAMclxmsQC+MY=
X-Proofpoint-GUID: BUEWuB9kY7955cPGsdtpzqAVb7E2DXCm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_04,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070151

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
index 20f738fa6556..b8c2d028a8b7 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -312,19 +312,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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
 
 unlock:
 	mutex_unlock(&aift->aift_lock);
-- 
2.43.0

