Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4250B3EDE7C;
	Tue,  6 Oct 2026 12:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791289497; cv=none; b=LfelMQPxQucKK5IIiGNlukIzX1QJlVEOVh5aKzeJHWnn3DMtVKi4D1t9gi7FZF+leElYkbjkmeqqMcd9giLQtTW1u6UvKYDaAuuGseipuq5i74gIg+N/TaLFCqjnQvyArLz2JctzFIA+yEOB4pO+hhHEvnSUULGtvwhLAzAwcT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791289497; c=relaxed/simple;
	bh=N9fFvMgG+csB8/awMd5ElmIoj0ieWwkAioOGuzGdsCc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ir/6aPtusIiTg7oLN6/QL9ICnA68XKbkNChkicQ5ZQVwFsdIdZGQd0Esn4QRo84D5XRq7Dx8/0XKlRF6VQcfYVMk1/6FTr+dfHUDDFzk2Ugjn2c8uVcPTfSm9zOteo7+gXNFP6JBTic0WN+xRwd8i9pB9bXLUpog+T7qf0uBAck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gQmw+79G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gQmw+79G"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696BZgKQ3474077;
	Tue, 6 Oct 2026 12:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3oFm4t
	ubtIMTZpZXRbTObhEsOwplB8DoBjWuq0KDJ7I=; b=gQmw+79GXUNpO5GnCoFEtV
	RdlDy29UNp0GkkTVITyo6BE+g+W3cKgGQVInbLDD+fzhcWB0z1ttGzH3pGrYjnq8
	stW+/7COBJC7OpgkcTyfOOcp+LDfRi9m5lbWoOX9s6ofDvxcCaMvd38wVITUVa06
	IjX9C4QJOT9/AfCzqq1U0oKHL+61BvmFXBhuQqsL/s+XT6Yb3wmT1YYrgoKB/khU
	pYjvn5CbQn5ExVPDtMXsqsbh5YUpxR8FewY6yxWJHjkpcI4ZFoX9Rl6qX+c+JLt0
	mNQW0ArFdNC+cq+aNnmlNV0FBUK2Cuv1qLQegVpaYcfXL1aDSorMdY93U9Ytv9jA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jqans-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:37 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 696BWbmn270002;
	Tue, 6 Oct 2026 12:24:37 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgsr6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 12:24:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 696COXH443843916
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 6 Oct 2026 12:24:33 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3139620040;
	Tue,  6 Oct 2026 12:24:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 884202004B;
	Tue,  6 Oct 2026 12:24:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.124.214.4])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  6 Oct 2026 12:24:28 +0000 (GMT)
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gautam Menghani <gautam@linux.ibm.com>,
        Harsh Prateek Bora <harshpb@linux.ibm.com>,
        R Nageswara Sastry <rnsastry@linux.ibm.com>,
        Alexander Graf <agraf@suse.de>, linux-hardening@vger.kernel.org,
        stable@vger.kernel.org, Avi Kivity <avi@redhat.com>
Subject: [PATCH v3 3/3] KVM: PPC: Fix get_d_signext() 12-bit displacement for paired-single D-form
Date: Tue,  6 Oct 2026 17:54:04 +0530
Message-ID: <20261006122404.99358-4-amachhiw@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261006122404.99358-1-amachhiw@linux.ibm.com>
References: <20261006122404.99358-1-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: RjurgE7iBOXIogRNExUsJsoeSeNMcwx7
X-Proofpoint-GUID: FUu8Psf17YyBlKXopUSoJL1aMyC-iyJ7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX9hfIeWIH2KAI
 CioNvRq5ovIZQa7ZUSd1xgmPE6p2XjuOWjwHHG+caMR8G8Q1hEP44WemldqI3OQN3iBXZH/DJBK
 QHmKAvJXzw1j1M/7GqeLNq7ZdgfKZfs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA0OCBTYWx0ZWRfX9loWTdA9Qro5
 xrqLN/auGFWoAZ6Fr8jFQAZtYFTOdKt9QlcaORkV3oE7IBERKZrnwwFbTjq3kHBuoqn4Cuecbc2
 SbRKZ/Dy7UxwgFiXIhf8jTyijXv4zoKcGz0zKAM4arC18Tuue+kazsn0Ubd22Xca87+6a34i5/H
 fR9yVBhZR0MfINJTM8PyclpABtASkj1xXuLsJmWdmu/EsW9jU6RI3LQB+LvmgioG0Rh37YUfCtF
 sFTKWyvLetKAoLLVE9jPOS1jiFkIPNJC3FMtGPVZN6yVQSEX6/kdimtkgrfs0EMqJ/zjoeUuDs1
 YWhRmC7GZjU9Lze1po/nZMnSwERUSpslmaeDy7hoe+jJpuhEVvbx1+qOq4RWlwzvm6muECreCJd
 ODZ0nXVpkEGeOej6Bf7v97ZvSEtxJfBZE9kolYHDgqw8YQpt58b89MMt5MRG6oxMzzUT/wIDkVz
 JSjgxC4ycz1RUbVBegA==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac4e886 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=WFAfMJoNLMmZCboqhGUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_03,2026-10-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610060048

get_d_signext() has two compounding bugs since its introduction in 2010:

1. The extraction mask 0x8FF silently drops bits 8-10 of the 12-bit D
   field (PPC ISA bits 21-23), corrupting any displacement that has any
   of those bits set.

2. The sign-magnitude idiom "-(d & 0x7ff)" is wrong for two's-complement:
   for D=0xFFC (encoding of -4) it returns -252 instead of -4.

Together these errors produce a wrong effective address for psq_l, psq_lu,
psq_st, and psq_stu whenever the displacement is negative or is a positive
value >= 0x100 with bits 8-10 set — essentially any real-world paired-
single stack-relative access.

The D field occupies the bottom 12 bits of the instruction word (confirmed
by the adjacent W and I extractions via inst_get_field(inst,16,16) and
inst_get_field(inst,17,19)). Replace the open-coded logic with the standard
sign_extend32(inst & 0xfff, 11), which correctly performs two's-complement
sign extension from 12 bits to 32 bits.

Fixes: 831317b605e7 ("KVM: PPC: Implement Paired Single emulation")
Cc: stable@vger.kernel.org
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Amit Machhiwal <amachhiw@linux.ibm.com>
---
Changes in v3:
- Picked up Reviewed-by tag from Shrikanth Hegde.

 arch/powerpc/kvm/book3s_paired_singles.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_paired_singles.c b/arch/powerpc/kvm/book3s_paired_singles.c
index bc39c76c9d9f..532f96293de0 100644
--- a/arch/powerpc/kvm/book3s_paired_singles.c
+++ b/arch/powerpc/kvm/book3s_paired_singles.c
@@ -479,12 +479,7 @@ static bool kvmppc_inst_is_paired_single(struct kvm_vcpu *vcpu, u32 inst)
 
 static int get_d_signext(u32 inst)
 {
-	int d = inst & 0x8ff;
-
-	if (d & 0x800)
-		return -(d & 0x7ff);
-
-	return (d & 0x7ff);
+	return sign_extend32(inst & 0xfff, 11);
 }
 
 static int kvmppc_ps_three_in(struct kvm_vcpu *vcpu, bool rc,
-- 
2.54.0 (Apple Git-157)

