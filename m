Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C5C40861E
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 22:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786572816; cv=none; b=YylRWXd02Rh6SG52Rv9BfR0KonujrhnyPbq7Ee1ZAxQKlHcA7SPNMIk7Rak8dUgTY0P7d/8QU1dFAvH52+XyL+gaviqU+coQxZ88w2kcfgF56hy65xFDYVu0iUXOQyeT17iseieVlgMBXkmlim0MCJUQNeQol7L1uKzoXdPvcLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786572816; c=relaxed/simple;
	bh=vMGmQiTX2q8TUXxMJ0caXSBgGSkGILCldAytqb7DWBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=syNd71gfCMzw29VLG6zKonsz38xqHqJ2Sk3RX1B0iGiZTlr4Agk2Rh6GQLVSK8qZp6jIeUEmOKquRz5bo/oCpm7HLG9PTQUFRWuypvDRgIN0UKNw010eA2SBz/QcrvA5j4XGC6NaMVO0hYD8fUXf8bhozBszBX2U2gANaIfTb8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XkpN97H7; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XkpN97H7"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67CK2qlC3381545;
	Wed, 12 Aug 2026 22:13:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=DmlX7SbJi+adqA0Y4
	i63kr8HUI58f1g3vBNV1Pi8qqE=; b=XkpN97H7UC3SJnq0Tp+5r6ELuAeXELB0y
	9+DfAhq8r9vIJuoKdCFe0bwslPm0b9O2nTskZJrMW7CKp86K8m6saOMaVSGlvHHL
	V73Unonye5MuvI8NzwX1xrVajEwjfOFpjQJZyvjrjLk8hHzuAHqw/caDfcmXA6nn
	rJ0b8JOPq6Xbv36oe/fXIEzRxqY5JCwGUlyVd9jnJJJG24YH7sZDC1pM23sj7+hX
	7Q2IAomBC8K6DEysTjWs5sLQdMDSndpaTigJuKfYAX6tWmEQVV/WcuPg92vU56II
	A16uR1S/xr91xfxGxiznSAEd+5UPQO9ar/A6kyx/TfJAo1ss47AEg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fyb23wfs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CMBKDb014220;
	Wed, 12 Aug 2026 22:13:31 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0gg6a6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 22:13:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67CMDTIa26739340
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 22:13:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A81858060;
	Wed, 12 Aug 2026 22:13:29 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A61D658056;
	Wed, 12 Aug 2026 22:13:28 +0000 (GMT)
Received: from IBM-D32RQW3.ibm.com (unknown [9.61.244.42])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 22:13:28 +0000 (GMT)
From: Farhan Ali <alifm@linux.ibm.com>
To: stable@vger.kernel.org, gregkh@linuxfoundation.org, sashal@kernel.org
Cc: alifm@linux.ibm.com, Matthew Rosato <mjrosato@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: [PATCH v2 8/8] KVM: s390: pci: Fix aisb calculation
Date: Wed, 12 Aug 2026 15:13:23 -0700
Message-ID: <20260812221323.3645-9-alifm@linux.ibm.com>
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
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a7cf00b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=Kdkv-2UG5BF8DrlVkd8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfXxw/tgihBMt3U
 X0tIKsccEjpXuoZSD8iBc2lJkxQ4wIIMtEdiUpV8O6IhhbpuaDPmoZUMb1EPQ6Y2p5OS/LWGwcT
 LvyPfe14Zs77m57swVDHTQYfF+2slIpb2pfCKZioHJOf4I8hHLeOArRYxALkLVYhyU2SwPNM3HR
 vSh40km+p0zi6hnne/yIgvWkE7Hvm8bqA8rRIiAO0BIUSEhVjWHgYvY8XpWH8/xf16U/8+z/kKt
 5grCHkWOq3cjz7jznXeHPnp5n1YyZcjME0Pv2k5lyfD+XA3FG020xbLciRf0DIx9Ykn4hmUeEJO
 UhuwlVAkuHM57efBnf8ovFIj6ECl34+eC6Y0FMqBJyDMnOjKZ0ss3tIFAlLKB0mIlq4q57YiCDk
 c/ChT/Oep9Jm/ne6jiZRf9rO52ipOOOXPjrhHaNZtOzyRplOoVAv8WcyG8TUSQ8pgtznKmSWEu7
 EvJgguJXqru5kvtRwlA==
X-Proofpoint-ORIG-GUID: NIcnG_-w7pq6962P0jYseRMAPrZB1Rc_
X-Proofpoint-GUID: NIcnG_-w7pq6962P0jYseRMAPrZB1Rc_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDE3NyBTYWx0ZWRfX6IYWQQrywlnW
 Z2tFzMjfoJQwepxGDI1XUzwCTgoHIyEFgyLDkZ+pRqZ7zmHS7vBUG76LR2FaCqVUGNgkWOEflq4
 jio6FDmZXnZl3DzPGYkvC4ruwMV0gg4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120177

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

