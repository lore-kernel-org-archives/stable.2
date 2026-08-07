Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3A6137B00F
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 18:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786127903; cv=none; b=Z80BiH565D9qrjlp7JjV9UtbhCGprhg4Y5Y3NNXS99F4JNUhA3NnaXNWgn/5mRBUd4vG/T/k3TnNGeMT4jXxgJ8F7RzReRAJo7nVq/KGyIWg78vOZdo/CxEzu7/GJrZVhyL0ust8hO6uByjwJ4b+9Y9NEJKMUM8CFxq95FhF8k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786127903; c=relaxed/simple;
	bh=aubyfu6lGSVqRrCcWw1o6hsZFHPDnDOwBXK+kF/7KDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNzlPTIQX5HiObZ8X8N6AN5beN2cMauckdhAZnu2cC04hvMRJ/yvMnGS31uGL1Jn8Fo2Ktv3HzxUPCrFsewqY8+FxR/+90wdifV/XK1nITiUhDdzDzc3SBRHIMnvrPSygZ+D+EH4+7JaGQ2CWs2vXFY9tmkVBGFM+o/j442QYMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BRYYZQze; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BRYYZQze"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 677GlanR154025;
	Fri, 7 Aug 2026 18:38:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=0P53vGtWG9KL39eU7
	IMPPUNzhOpG3jC3EZR0hC4djrU=; b=BRYYZQzebgPLX0zMImgSEc5zmD9FFa0D5
	8WN1KpAhalc/bKe5zQBERRQO3rrS3Goud9xUqKOhMsbOTjjhI+W/yD+RIsiuGj6e
	MHTLAV+zSdGziQ3Neik+RVD6R14LnihQ8ztIx6jBJkvCVomRrKKgqrIF3u++Nu0S
	Lru79sqI/uhbk+K1J6sC5hLx08kmEv7soSCEcUNxtwIEOJyECqCnIVw6IC/AGAr9
	fFjmuPwBVHqUW4VTUKyoFKs05akMlsyXVkn6gDErhqtPPgQkeSEpIlh+DQ2FTC5p
	7ML+R+GNL2qbP+UmMFxu1cFnq/KPJht6ggD4qse2gqLYXvudE/e3Q==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy01nbyx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:38:19 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677IQFX8001857;
	Fri, 7 Aug 2026 18:38:18 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgrqad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 07 Aug 2026 18:38:18 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677IbdA626608172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 18:37:39 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5378958045;
	Fri,  7 Aug 2026 18:38:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7F0BB58054;
	Fri,  7 Aug 2026 18:38:16 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.250.14])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 18:38:16 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 3/3] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Fri,  7 Aug 2026 11:38:13 -0700
Message-ID: <20260807183814.3035-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260807183814.3035-1-alifm@linux.ibm.com>
References: <20260807183814.3035-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: jBKQM63LtdJVQ-epjYkgLOs5XdJFLSxl
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX/h9lBybAff9K
 Hhc3AWzBnoaXdppO+C9Vne+2ljAqWlkhPoCuViCtz2qS+VQoC/u5JIueLbvJmBFUOz/0X7sdAaA
 nunBAXDEsUTz3ysCD1p80jAFrfvJhx4=
X-Proofpoint-ORIG-GUID: jBKQM63LtdJVQ-epjYkgLOs5XdJFLSxl
X-Authority-Analysis: v=2.4 cv=afNRWxot c=1 sm=1 tr=0 ts=6a76261b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TYCmRUurIKQ9kozAUfwA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDE0MyBTYWx0ZWRfX/sOa58qp5zDW
 A+Qr96x3/dqa5kqwHVFd8+Nk7HePX0RXvjKdyhR0jg5mjEvxlmtcuzvLJ7K3eyuamV3w5c0GaQD
 O7bWNMvQVj/2ZkPwpT6zuhiqlae1ysS/Ac/+Ark78woaM38E0f2IAlLkbMudXU77V79obP24uM2
 HfqtHk/q5XbUawrq55HsDHb4ASfIQZk9O59sCCCSCdZ09FETZ8mZNIZnHiVWTbIQDbf2+T1seOl
 Xyd22Wp6ymgqhdr/pQOFHsOBk9hYJsmrc78iEkLETLQqb8Ql8DGaSzfYvQ+aJfNkei3wBjusjmq
 CN40/1rHaTy92N6sslFslKb2B2ySPCEukrTXbV9Y9YP7oqYVKruD0t6JgeBSUzpbn6NKB3RsbPR
 V5/d1/D6hz5s/23393N36eVTNJyNgzW1B21dz9FPIPS3Yw7x6NJQLUdVKtMK3+qABWdeFT7fJBw
 ayFxSx4ZEwlAJo74pvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070143

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
index 7ee1f892c7fd..8ac383e3def5 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -336,19 +336,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fib *fib,
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
 	if (pcount > 0)
-- 
2.43.0

