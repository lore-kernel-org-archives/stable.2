Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA6A38F255
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 20:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567252; cv=none; b=NdyEMzZgoezG8DaQmb4SagA/Zf1aLrPxp2ik6h4U4FiqQSYYHxHklhRQbk7ph0XQYKUFoZyOwCwgWYEBx3DMAAyVy+1dBtkOP2LhHVMde6fF+gKqvF128ZaQWGTFKHeHApZIaq0fxOh7pNHUX7wFX12nGyhkCx19kJSNgVpBLuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567252; c=relaxed/simple;
	bh=NISMi94O9WqdKRANGT1ieBkqqfu9sIz3eJW6miIa9FU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZShPijFnPuHyZa+9pAFgRoMOyTY9DVZSu98yUkBhiXoklUL59y2fQTGntF0JBdcJfujVzsu2FxKRkpkvjlhFSkePo7iJdYFlWjgV0inV7+RMcUOVMAXnxqhwWFk8DskTaIXjVkmaok6rz2fLAnLM248xT87B8EZEciBfrJBz5Tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XGhH/n5e; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XGhH/n5e"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2sk9323317;
	Wed, 12 Aug 2026 20:40:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=F8WmfPBuxpAjE7n10
	SS8zeCFPprZpH+J8k6dUZ00ORc=; b=XGhH/n5e+ZtHYoWEYkMN8ILG5ZH2epTWk
	a+uTh5g4EvG0KxETOJGF17UaNKVAlmLQoRdvLbNvUH/s3BCdRUZcIWeNUfgeJAs0
	iKAFBFq/uMBQ15JmiJ8VqD/HkfhhC317P+nG4UfeKAnZmheW4ipTelYhc8I35d0i
	pcmNj4AJC4gJxP5RMGDtplBaERRMRnJYauWiqevgzi2jKAPx6W8WEckyqwUyRC4d
	bvy8w+8SYRXAUBX97VwO5Fye/F+pcsiCj2su/Tlk29QHSZl5JNPpT9LZ33z8rytr
	OFMGojkLxLKlbLaOFLo4WsRpG40UGhYS0BzoGT4/V3TkRDx+Qeh0Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwbrp9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:40:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CKQG1O004409;
	Wed, 12 Aug 2026 20:40:47 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h7wa6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:40:47 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CKekZ732834152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:40:46 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8564358059;
	Wed, 12 Aug 2026 20:40:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 09AA658055;
	Wed, 12 Aug 2026 20:40:46 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:40:45 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 3/4] KVM: s390: pci: Fix resource leak on IRQ registration failure
Date: Wed, 12 Aug 2026 13:40:42 -0700
Message-ID: <20260812204043.2536-4-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812204043.2536-1-alifm@linux.ibm.com>
References: <20260812204043.2536-1-alifm@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cda50 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=TYCmRUurIKQ9kozAUfwA:9
X-Proofpoint-GUID: _VLcqHZYMNXim_lKiEX29skpRjFaNB0z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfXx9XSn8EWgIuf
 E1hX4/1fS+VB1O0QcWZm6H9WvyxvzLgniSycrHe+y5HvPM/wAbKUQaO2s3unC14gmL7gskXSLj5
 2s1vGwMRIwISkiAcbs5tpv/izknV461HOpbaF9R0CyP4yd+t2MPCdv5ayUMHx1lpKv9YPhwISiE
 TnH3d8izQfvawdNMwyhYUpVhO+WePkeGMIIB+1uqQqkJMsnxc5AwkvAjzGUQXaSEkI1363op0eu
 qoJIvEuFaOITH987nfQRQWMFfGfy2VpGnsA79pZCjBd5xQRj47f8cfBjOSbaqof0S2MqhfV5Aiv
 HHC+yI4eLnKZiyLL1WambRCjYyiMA0Mhx1KU+mcJkYP4wQxG9pfDjf6swgJc18XQXCDXI/Ih5Qh
 ccmYu7v5qbJYkDYgTh4JWnptYNOU1H7tc+CVrGANz245qIoWDsFaroWgGyyaVDphcGXghert2lZ
 /cjzNtEmtn5IsTN6c1w==
X-Proofpoint-ORIG-GUID: _VLcqHZYMNXim_lKiEX29skpRjFaNB0z
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfX627Xq8H+6oHv
 NQTWSV+r8TUSlECcC2IdcusxMJvctBTW6a2gJUPs4XVd4zkFgn+i6VUjuNZD6CVlVX98C+KAoGW
 QeobUiagN4coXFNH9RyIRFSEbF0Z1YI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120165

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

