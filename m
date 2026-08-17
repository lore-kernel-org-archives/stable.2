Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3562537DAD5
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 20:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786997779; cv=none; b=eXHFjixV/BddKM23gU8mkHk3WsrC5nyIr8csfZOI4F90+c17bLNjwQcY6arFy8K07bY++IpDfOSM9AhzOmIYoTW0o0AAYSe2adJu//Fp97SG9a4df59O/8jm76Tt1EOmIwhluMo6BHeAPauIUN0AEkYsL1L6Ovm5WR17WmJaDC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786997779; c=relaxed/simple;
	bh=vMGmQiTX2q8TUXxMJ0caXSBgGSkGILCldAytqb7DWBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rdyz73JykfT7ToKVLqGqEOfXP6J5gWkBwGhG9MQyxkxo+5hw0jSnepOf7huqB7fhns4l1FdtXukSR1PNzYzrN4uJ29zXlNFMBB2DORkNQnk4Qos5Jax/uyDoFOT2vFOb5qQixMcOs9FzFVpVawjQfqXe9dAZaRn/obcvXJoaV+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HzTokXJG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HzTokXJG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HIVXK0306895;
	Mon, 17 Aug 2026 20:16:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DmlX7SbJi+adqA0Y4
	i63kr8HUI58f1g3vBNV1Pi8qqE=; b=HzTokXJGWyE2POgiovqwRPDHQZcvlQDq1
	fLHT6TYrCvzD/u+MQ0c9nURipnucSvDA9hsctEGjAF9bkvizLLHqrbul43QcXFXd
	lKkGGFcmpyo6z2omtK9oY3Kfabh65Vs+9N14DSzjDfUcCsbcnJEldW69Cf4QKtXa
	w9uV8mmlTSpq2/PCf4NTL5Z1arO/D40CN1sw2odBy/oAMnlLqdw8IvjsMeHKllOJ
	vQI75MUMAEL1eoWC9EIrwJZKfD+BML3zU2sKDE/k3bSN3LSJfpiK8O3Ec6IpeL1g
	d+z5BvrSXKueoUkS1zFhUpYrQXn856vhJOBjlqerA+hw2L3rGp0YQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqm5qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HJuJi9021007;
	Mon, 17 Aug 2026 20:16:14 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354y7a7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 20:16:14 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HKGD8T29819570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 20:16:13 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 67E0B58056;
	Mon, 17 Aug 2026 20:16:13 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1B7B58052;
	Mon, 17 Aug 2026 20:16:12 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.120])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 20:16:12 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v3 5/5] KVM: s390: pci: Fix aisb calculation
Date: Mon, 17 Aug 2026 13:16:06 -0700
Message-ID: <20260817201606.3194-6-alifm@linux.ibm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfXzo6BzpGsJNt7
 4+08ewkJ9vZZofEbAFn223/x+JSjc5rTzFaExP4xct4QwGIr3porEoQi55roZ8nLW4v3hfOU1h+
 XCDxjQeCGxYhfQ0KAyaZx5Kof1On9tsYXSqz18HvGyFKKqwNvnY0R1PbGwErSZDCpkqLSxjdXTn
 igN9kY51h+C6yrWxuXql9FXkMqmaXICyMfoBLUPFHKdJ1QUawuFaM89ZLn8M0bHP9xXos9inuBb
 gdZ+3ScPpll8trzgLJui+vUq4srM9cYBB13j+KcnBYfAxIshHfJKZ27tSdgsnXjVBcaWzeo2GeS
 yUv47x2lD678OyWD2k+yFt4C6pkLfb8UNEMubG9gNKzhsrINnwdoLVHLLOKMBMN5DupKQO64EZk
 vmnU8tOVl+vIfne87MMd7v08Ghid1SefBWaE69L7EEC2wNqJ9K5maGNHyT2XjAxt+9i7CEDJxyv
 sRK51zjXrqyvwRTZ+3Q==
X-Proofpoint-ORIG-GUID: sAn84rDjtBq1fECt_PiBy-q5jyc1MJdi
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDE1MyBTYWx0ZWRfX4+cKXSF859PL
 VhVKD9mIlM0vzoNRXU/gkD53j0bDB1df+/8M9vpmIrwjjqeHa7mD3RxWYjDwNlsOjInLHnQ70qz
 4wJodijQQkFrk2AobQ6aQyiewkgGZJg=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a836c0f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=Kdkv-2UG5BF8DrlVkd8A:9
X-Proofpoint-GUID: sAn84rDjtBq1fECt_PiBy-q5jyc1MJdi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170153

From: Matthew Rosato <mjrosato@linux.ibm.com>

The current implementation of aisb calculation will erroneously index
via an unsigned long * as well as multiply by 8B for every 64-bits in
the offset; only one or the other is required.  This throws off aisb
calculations once the number of devices exceeds 64, and can result
in out-of-bounds access as well as failure to indicate summary bits
associated with those devices in guests.

Fix this by converting to a physical address before applying the
offset, as is already done in arch/s390/pci/pci_irq.c.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabling interrupt forwarding")
Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
(cherry picked from commit 0cfe660559e857d7c00ab86c73e4510ce069086f)
[alifm@linux.ibm.com: Resolved merge conflict]
Signed-off-by: Farhan Ali <alifm@linux.ibm.com>
---
 arch/s390/kvm/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
index 8b91f289226b..59e824a7eaaf 100644
--- a/arch/s390/kvm/pci.c
+++ b/arch/s390/kvm/pci.c
@@ -167,7 +167,7 @@ static int kvm_zpci_set_airq(struct zpci_dev *zdev)
 	fib.fmt0.noi = airq_iv_end(zdev->aibv);
 	fib.fmt0.aibv = virt_to_phys(zdev->aibv->vector);
 	fib.fmt0.aibvo = 0;
-	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector + (zdev->aisb / 64) * 8);
+	fib.fmt0.aisb = virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) * 8;
 	fib.fmt0.aisbo = zdev->aisb & 63;
 	fib.gd = zdev->gisa;
 
-- 
2.43.0

