Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEBC45DF7F;
	Mon, 12 Oct 2026 08:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791793827; cv=none; b=AHxI+uYmDA+Vz5ZGO1PfiVHopR1UuQ8pvzoHngSS0lPd2cTfcX3FSApFNmZuj/ydmwfQ+y1iDZnyxFjin9fD+W+lzlF0fZiZRBdLpZeR4FCCkQiwcZzau/Uy6FrEj0hXMVuZZKru/dbQD7YNuADYBAVwKTlbT4UHxdBU1mmUBbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791793827; c=relaxed/simple;
	bh=7SuiUUrCRAdFrE+hAncZbZDrVkC2BEmn3y523fpju0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P5lGjA0LNilBJh+i7pT1Jq53X3/iExTDl4XB8BTH74Gs9A/cuaPiElWnNmdvWfPUVL2QlbeiALie6UJXWXsMrPwmNE1q1X7P/1GnsGUpm+KG5CEUx58cjDPZw+yA9Czvx0oG/otyj0o6x75dGjXqHbBSewTBqJvwJXmOkqO3UI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gvSD1nhN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gvSD1nhN"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C5E7es3427792;
	Mon, 12 Oct 2026 08:29:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=YPTyzvFkIPPeVNCTj
	5M+M+KYpF8fo/2iX9cI4SgFZ3M=; b=gvSD1nhNTEyRZ6iSQStv5Alo8pKbXu/3i
	2v3TWkHphBaI94o0I7FjIzDUeJLyW/iu2nwQWJI9dKKcyMxZz/+Igge8z/CHWlkE
	1eg62JMG6Bcyj4J6e1TUbpBWCxAVvRf6JHOaEPaBpt3bGgPOFnmCu8k9ICS73o00
	im3xDgZDMBPu2bkOHTt3lSoaNXiAXsxzhjBPBCnEjRuTBIQ2Mu8Gq//gBmclcJon
	TtaIOUHKzuGXqWwTiuobybiKsNtaLj8DTzFolxjze6s/cfrXms3CGtBs0zmhU9ct
	NP6OcCsuZUnke1iOZTYWxkQ9WjV6nH79/RMT1gl+LT8oOd/tL/zcg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv37x3s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:51 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8K36I1013624;
	Mon, 12 Oct 2026 08:29:51 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyc307-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 08:29:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69C8TlrI40567208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 08:29:47 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 55E7A2004B;
	Mon, 12 Oct 2026 08:29:47 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B01A320043;
	Mon, 12 Oct 2026 08:29:44 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.28.91])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 08:29:44 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 3/4] KVM: PPC: Book3S HV: XICS: Avoid NULL ptr deref in kvmppc_xive_cleanup_vcpu()
Date: Mon, 12 Oct 2026 13:59:19 +0530
Message-ID: <20261012082922.218799-4-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261012082922.218799-1-gautam@linux.ibm.com>
References: <20261012082922.218799-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: E6FkFc5lJdHulTY41z7ZBupEsn7Kn9tN
X-Proofpoint-ORIG-GUID: TFHuhYM2uPHaOR87y_dagTQqV2B3CRYN
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6acc9a80 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=tG5QLYm-1oz9L0MxXuoA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX3FAueNjvOx2k
 3hcUxjfGqXe/GaN7zWjeksitRi4lje82F3e52gRNpUl6rIjshNSAJAtfVYscHHnxGhy4LikBPf6
 TngVDzvZJ2vjsTSOPvXBqXLLiY2O6ak=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzMiBTYWx0ZWRfX+W1LwoOonPS8
 ZV1RNS8BqGv3/WoSi8wxVteqLu6bvPpEHcDaley7jww/fHzAWcUEvnVd+KtYu1AfjVBPP+Q1RPT
 bJPoY4njtqitlx96xw8fWfdDzj1LLyCdaIvuiYNzqcdTw92XuiudYb/MmV5Wq3Tjy6Qs/Yhmipb
 p8D7slOPaLLbWM7o635Bak//fTsRriYWlg+IGovIbyWG21waVwI96+boZP8y2jZ8FskZnoYpDxx
 NSIGzlHySOB/8DaqsFOgCteRNDWaxomwWd3MNCS0EuE82MzS3CgjwnWLcTrM0vl8UYtwMoFL8x9
 EZIb3fEdpq4UnKV/FzxmyRvPFmHb+EY3+g7FU0B3bIIGK6dCB48uSv7pXFPIMWlKFAv6G5YIgMn
 2ZQ73hXhEthUI4aLHalMB33Jezb8f5hOTY/SVSFOS0oecqYUwwvE/Rw4+Zt172wZw8pyNkz23AA
 pUBYtUGqQ2dYHoTbXqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_02,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120032

In kvmppc_xive_connect_vcpu() if there is a failure before
xc->vp_ipi_data is setup, it can result in a NULL pointer dereference in
kvmppc_xive_cleanup_vcpu() when accessing the MMIO page in
xive_vm_esb_load(). Fix this by adding a check before masking
the VP IPI before accessing the MMIO pages.

Fixes: 5af50993850a ("KVM: PPC: Book3S HV: Native usage of the XIVE interrupt controller")
Cc: stable@vger.kernel.org # 4.12+
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
v3:
1. Add some more info to the patch description.

v2:
1. New patch - Introduced to fix the scenario where NULL ptr deref is
possible. (Sashiko)

 arch/powerpc/kvm/book3s_xive.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_xive.c b/arch/powerpc/kvm/book3s_xive.c
index 67219044fb8c..b27127c43315 100644
--- a/arch/powerpc/kvm/book3s_xive.c
+++ b/arch/powerpc/kvm/book3s_xive.c
@@ -1818,7 +1818,8 @@ void kvmppc_xive_cleanup_vcpu(struct kvm_vcpu *vcpu)
 	kvmppc_xive_disable_vcpu_interrupts(vcpu);
 
 	/* Mask the VP IPI */
-	xive_vm_esb_load(&xc->vp_ipi_data, XIVE_ESB_SET_PQ_01);
+	if (xc->vp_ipi_data.eoi_mmio)
+		xive_vm_esb_load(&xc->vp_ipi_data, XIVE_ESB_SET_PQ_01);
 
 	/* Free escalations */
 	for (i = 0; i < KVMPPC_XIVE_Q_COUNT; i++) {
-- 
2.54.0

