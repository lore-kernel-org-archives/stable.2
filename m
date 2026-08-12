Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B43232F76D
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 20:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786567056; cv=none; b=KMbsKNUWEJGbvp+JmC8eat/ovtmcDDuGkC3sK5Ol/VzkGCBt9NP/nWPsVEa2Q2hbFu5eshxtOxJ4W/yci0gOD+iAOCHgIHb4Wxi8emRKC4dbl6KeI8RSbJmoOCLzt6/6TRQP7KzzY38d1Sj6L+x6H9p/RJfHuqa2l5WOKYjTBKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786567056; c=relaxed/simple;
	bh=3iNZQPCUaTjdteIQOERBrq9cmGQCxA5gPTupZWcPxe8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LeG4MpQTg1irmh4vaYQwe6bvKhHuc85DJM5I5tgPJOnbcR7W7TSSDsJe+3BOWSxqOX/+3Q4U3dLtCGh/OIaH6OgzBMZnhK4OzP/PY31de13Vhj5neVXB+yti9b4f6/w8OkZTAUsm3PldbB2q1ZkgDxAWy8AcquActRiePjMV4ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jj0RTywb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jj0RTywb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2vBf323398;
	Wed, 12 Aug 2026 20:37:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=D32eBZ0F+COdgE3bPZp3Hdhwt7f8UJaRompOuhxDy
	j4=; b=Jj0RTywbyKl81kXe256xGL99mF6Ai0pXk8c7DgXJyH7PJBtuJfplhxwvA
	QMGVG5fEP5RW1GkFLQIy04V/hdlURMtvNV9yGVGU8naHMsIxyaciFTHnrNPXnt1O
	0UGK+MGe4ZShrthfUPIl9OXqkOlpTuL864hl449sYZKUMyT+1f/EVZoP8EfE1S5d
	oCXnHQ1Mrucu78HihZX3pVtU30AFwtbFw56jLrBB7+RCUM357ckSX0o47Ufnb6q9
	+66WafD9sUb5lgAe/mlq2+bs3Z/MaTkuB+D2suLdT2b7kpnrs2zrz0mHtJfAPCtX
	vwG7BbWkm2KIS1Vb+3rEMhPXCjZ/Q==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnwbrb1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:37:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CKQLdj006770;
	Wed, 12 Aug 2026 20:37:31 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq841n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 20:37:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CKapL327591338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 20:36:52 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB7AA58056;
	Wed, 12 Aug 2026 20:37:29 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 714CB58052;
	Wed, 12 Aug 2026 20:37:29 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 20:37:29 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org
Cc: alifm@linux.ibm.com, sashal@kernel.org,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH 6.18.y] KVM: s390: pci: Fix aisb calculation
Date: Wed, 12 Aug 2026 13:37:29 -0700
Message-ID: <20260812203729.2422-1-alifm@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7cd98c cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Kdkv-2UG5BF8DrlVkd8A:9
X-Proofpoint-GUID: Y12JUGic3LPJsaixAq_8NLxN-D8U2yxD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfXwcp4SrRVVNUE
 mwH4XygwFSKdv0oSP4r5USd77CIqm6ls3AEBq7+s63cEoSUmRz3b/VqsRRnpIJ02iqx9fBO5NRb
 tDArMp2o53g/lXuRnxcFPUCnfEpLz+pEyJsL27N9gjUr208kMHfBbJP9TazqJ8v9yacTIBvvund
 4AhTvjowej22FavgH+e2600q+YRk01FBkYDK0/hHLtlwEaC3qDzmSHieHu8OJnlJyn8FQ59daZN
 KQSOdMLxs0PyA6msNAqXtIdvmWNE/APgvb2vHqF0ItLHA1FKqJAFMKvqEP7COOS3dF6qCOhWlPo
 bmb6OhXk+n3aCTSUpE/hN3J6XKOmB9SXQs3g6N9LFHlo5yTV21DEsPGcRX58l93vXMGAj/bVG1l
 SJPpo9cRSRp6F1ZZw9B7hW4GQHGd6u1i/CDhsYtyveBoSN2TJRtkbAB6I1n0/VHSOLlEZ24V2d8
 wI+XfDVZPy+AtV0RwUA==
X-Proofpoint-ORIG-GUID: Y12JUGic3LPJsaixAq_8NLxN-D8U2yxD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE2NSBTYWx0ZWRfX8mLr2F9T9fiF
 a7p6WEMfM2+PTYxnOiq/b8/8gtgEoLEsS8OSq4zZ3x1udGUPrBmZDsx/QL+ADAgHTkKagt8fTM7
 al8I1Nq8puAqVSdry6d2VEnW0WZzb2w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120165

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
index 4cc554c9d328..ebeaacfdb3bb 100644
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

