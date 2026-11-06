Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793979139;
	b=sMPa2TkT7i4NabsUikLWvG5M7bq1IrWYjnF1VvluAFK9Omy/ynPRzg9j6K7OKSoDPNO8
	 gfBgM4EFKuKLXSGazo8iVJpdw7ar9vp2iDLGomGX2YZ5bGARvizyQecVC6xPI6FnEg162
	 Vm8CfdP1qOLH60ww2xX9J+yz1JhUiQ3NlG7mkPLg1UMpPDZVgF436sqObri37eQwuPlc+
	 QgeySPEJpSG6V0SyZuZmOZf42ahF9NAu54JuSNefgmKzVgvcJ2TY0LfKLIJUn6xRn4Eyb
	 GBkBXesnYl0QQ3gsIQ1T3JvBD8PJvCYecPqVznxZXCKl/U36pDwvWul3soVHKSgF0MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793979139;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-TM-AS-GCONF:X-Proofpoint-Reinject:
	 X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=uStDWQc2bk82UMtjaWT+HYg4LA8nDLHw2SL2ZgVvfxA=;
	b=l7b4KtgRXAH/OAdp2zXlMXEMhIW2fYV15YRiVMI2WQAqoJhDf1Qx3Glm0MW607X3nIsd
	 6TDgu8Xo8pFsqP4LCbQpFMjwP+GLfzgouIjgzWt6p48y6XJJskFG1WfEh+RlPJfPKODOX
	 H1TJGbEiMjMHnrFL1wzUK961K0x0bvG1fZkYcF0BAUzuynK3d5hRz/Vt1YxzFk+dRfZYC
	 vV1eJvMkV/38zQtnm6uPTzfggoOMu6wkKffJ+ji2iXbR7Bn9qb/sbDC9i5yJSHx1+j2a3
	 3G9ZSlAy00E56mB8CSakId1Ri7MY26LyZgftCWtfNVb8dwVtlZ8y6TYFQ2vKO/aKHvw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GZ8zeszi;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 447CD606A326;
	Fri,  6 Nov 2026 15:32:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 447CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=GZ8zeszi
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6FECrJ2711295;
	Fri, 6 Nov 2026 15:32:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=uStDWQc2bk82UMtja
	WT+HYg4LA8nDLHw2SL2ZgVvfxA=; b=GZ8zesziBHjwbQeEgHkHL302eKfaT/whL
	fnRwSiq8ttCxQoYrjqB4fsXdnKxB24GFxSCiGqHjnmuQC6wYLRT5onjtF14I0N8N
	2YIY4Ybz8P37xfNt+i3SLpcS14i6zufrdXTkzoc83b1E3WSvyp+QeSH4lY0fTq49
	40ZuIC6r4YdzcRc9NZOyNW/B1gsh5U05bd+NjXbLRepAKz1C/OAioP8jOE95hQg0
	GN9BKNdrvofMEDWOglHEKLo01lfYNNOuk8l5JoLKqRKV9sGN5hi49zW7Mogbgf/R
	Rk2wyL+HTilhOldDBfr/hyOZCdGj5bkcNYIah5xuoXJme8sDMLg9g==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hs3r95868-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:32:05 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4sLN2390078;
	Fri, 6 Nov 2026 15:32:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hs7h13nnx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 15:32:04 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A6FVxql52429280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Nov 2026 15:31:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03C7320063;
	Fri,  6 Nov 2026 15:31:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57B2320043;
	Fri,  6 Nov 2026 15:31:55 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibmuc.com (unknown [9.39.29.160])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  6 Nov 2026 15:31:55 +0000 (GMT)
From: Gautam Menghani <gautam@linux.ibm.com>
To: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        atrajeev@linux.ibm.com, tshah@linux.ibm.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH v3 3/3] KVM: PPC: Book3s HV: Ensure reliable usage of latency counters
Date: Fri,  6 Nov 2026 21:01:34 +0530
Message-ID: <20261106153136.330165-4-gautam@linux.ibm.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106153136.330165-1-gautam@linux.ibm.com>
References: <20261106153136.330165-1-gautam@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=O86sLx9W c=1 sm=1 tr=0 ts=6aedf2f5 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=GgCYjPFYTpDDHSpCRZwA:9
X-Proofpoint-ORIG-GUID: thakxKSSkMQkb2QsvHeNY0ezaM0ZunNE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX0YK0FAxN7GHR
 MTLDirfWyEIHicdb19vdz0x/ahhUGJ1i1igWpE3ASHQ9GA6BqgciOGFl3912zRkjkZDR46dZ0di
 pbxPwPbmOIUG7diyCuddvUf/fe2SxTB3ct/tUBArrQmm9ePsYpHzAxI877lrV2dfncpo3plDLSt
 m0eWTHQtFmxBycaEt6vlPr9AiKvbZD4AbaXaJ+qOEZE5qrGllLBD06FPgo/nFB3BzT+OYhH3tYs
 T459C/37fOsU8d+Xf3Z4UDeHefJTCXlDCawhMsgnJlcRtbnNAja5OapNn6eIGjaEQztVpeuZU+M
 XoUHjSXLcwirApfTDH7N3ZnA5EdGVmoCY+4Kn33l4QboJIW88Cz6Pc1NY5Hx2aTIw/rZQZzL+Lw
 spM+vRegsormkwDoSe4F/zBZqG72bKFuS9jogr/q6MxeP+INYH0WVjpe7ZKlBNWX5i9A+56TAza
 QjbhrFQMh2CNHT1RBBQ==
X-Proofpoint-GUID: po2USU6AjBjATvqf-b9fyCsp9qI201lx
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MCBTYWx0ZWRfX6SIBg3pSFSRj
 LaaS+RF17hDf+eZGurTclf6gSt1axsWa3VQV26X5qZsWJ20Ezphrhs+BmwggZ3jxhqR0vvyICC9
 RmQLf/zy2N3OVo/aDjauRRpxmQ0Iyuc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 adultscore=0 suspectscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611060060

The kvmppc_vcpu_stats tracepoint and the vpa-pmu driver can both enable
and disable the latency counters in the VPA. When both are used
together, they can step on each other and produce unreliable numbers.
Since the VPA element for enabling/disabling counters
(l2_counters_enable) continues counting with any value > 0, introduce a
spinlock to ensure that the tracepoint and vpa-pmu driver can work
correctly together.

Fixes: e1f288d2f9c6 ("KVM: PPC: Book3S HV nestedv2: Add support for reading VPA counters for pseries guests")
Cc: stable@vger.kernel.org
Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
---
 arch/powerpc/kvm/book3s_hv.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 5fa6f93548ad..e1bde3c6b0c4 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -4142,14 +4142,19 @@ int kvmhv_get_l2_counters_status(void)
 		get_lppaca()->l2_counters_enable;
 }
 
+static DEFINE_RAW_SPINLOCK(l2_counters_lock);
 void kvmhv_set_l2_counters_status(int cpu, bool status)
 {
+	unsigned long flags;
+
 	if (!firmware_has_feature(FW_FEATURE_LPAR))
 		return;
+	raw_spin_lock_irqsave(&l2_counters_lock, flags);
 	if (status)
-		lppaca_of(cpu).l2_counters_enable = 1;
+		lppaca_of(cpu).l2_counters_enable++;
 	else
-		lppaca_of(cpu).l2_counters_enable = 0;
+		lppaca_of(cpu).l2_counters_enable--;
+	raw_spin_unlock_irqrestore(&l2_counters_lock, flags);
 }
 EXPORT_SYMBOL(kvmhv_set_l2_counters_status);
 
-- 
2.56.0

