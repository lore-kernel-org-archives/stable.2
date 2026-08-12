Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43FC395ACC
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 21:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569852; cv=none; b=enoimZ1rluPp32/NGJDz9Li+9FLcD5v+Y6Es4WZRuwcBrWWVRErOdlacG3rulpcgu3x75tzGz4XCDHkeCXBWnBcGVUGPEFipQIR7A/5qoK7v1SxzRV5M9nXXYti5e/N5qTQQh/cAY/yQEZLKRQd3rLccryPIJs/yol5eiRXAfvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569852; c=relaxed/simple;
	bh=NISMi94O9WqdKRANGT1ieBkqqfu9sIz3eJW6miIa9FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WltQRT7iBDHlQBnwqvb7C48TvV3OfbhOgdqkDFG1i+3v3NwYL++Zo0jl11VcLWaGXWPj1mgq1UzP9VpradRrlr96U+NPhKLFpGKSxvYOiGjADsaRZwcY903pgOgVNtFs+Bz4RaOxPcdGtqfBKg5Sp6xaGftjmzSeWcLcN8HcBXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=atDCRBAl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="atDCRBAl"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2v4X197238;
	Wed, 12 Aug 2026 21:24:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F8WmfPBuxpAjE7n10
	SS8zeCFPprZpH+J8k6dUZ00ORc=; b=atDCRBAl3ZEU9t0PWuSabPeGjJ2LZ7I97
	rzVubdTYVy83YGtA9Qb5cG4gziRQ9AZBKEDckfvnvk2EQxpUAdYsbGIppwqoA57S
	ahAHYDs0ChFFi5/8FQVjKSpmGOpC36CP1OyFF19EHNZzJDThG7NJEknsjEoOReEx
	re362pe1bxq42SHFKcIbjhh8Y+oYVKt6DkjmitCz7g3GF7qRUpv7qlFJ4RI+deQf
	NK2sXMk3orpt3e77U5mZ9rQFFnGLMnsl108i4mgPk2HUBK6xbylmyt42OYCE6H0z
	a3j+lX6z6vnkcCNrcT1TiA9z23Sy+fpQPXqnH9CTE/PQmUZ0i9Clw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp33xja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:24:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CLBGTo005572;
	Wed, 12 Aug 2026 21:24:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gg0bq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 21:24:06 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CLO5lg19858174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 21:24:06 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D32A05805D;
	Wed, 12 Aug 2026 21:24:05 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5268B58043;
	Wed, 12 Aug 2026 21:24:05 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 21:24:05 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 3/4] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Wed, 12 Aug 2026 14:24:02 -0700
Message-ID: <20260812212403.3143-4-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7ce477 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TYCmRUurIKQ9kozAUfwA:9
X-Proofpoint-GUID: 0mWwpzbMf10Mr1idgh1lBBEXTwuUD6Pf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfX5Z3n85dc5r5s
 hkTUvqWHONpBZXAw4b4UH20S7xznGv9aaztcmyBT6+pcQaRw8WW6drSEDt7UPKNR7hg/PjviG4V
 2RSXjAXnJZEwQpqeERRf00H2vzZdHZgm+GOBoiF5Lc2nBb7qJ3v+mIfbObxaRW71FPIGU+1ZAxq
 RTR2/m95nvPsIDijWDy6CdNJyCWD/pWqpt/jyuOjkk3LsKJiDzhAqg8IWPGddEhwRuWHba7rSNk
 23/2z+8DT3MWHzMvEdQzCVIy5lJ0CmTDpttvJxq90yVsQN6fLOmn0dEezIPyNbvFzh9tEDuH9XS
 wQSVZmGVItYzoZs5jvfQo966xVq96WZiYA+QlWl79/MQBWrgKrSllh5/26BUGJJ9hKc9zGAt3FL
 +Nr2hGwl765lkj+f2uS00wHgUNZ+RSZnw/Dz90kQgjjQYOFmBCJY+4T2ZX55fyPpqC6mZFgXQGC
 Q8htIXDtMkWAihrd/Zg==
X-Proofpoint-ORIG-GUID: 0mWwpzbMf10Mr1idgh1lBBEXTwuUD6Pf
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2OSBTYWx0ZWRfX+JF+UHh9XZJq
 X2ML+/IQBHFDZl8xK2QI7ZVhxvuDQ9K5+31IReEge5BVMdAyZAXgkf3MBikmCjFgUOCYTW/08lh
 Lfhg3gu65gVX+Daw0r3GiM5+qRcql4M=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608120169

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
index a20fa27fa030..61489016e425 100644
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

