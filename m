Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331AA3CAA5D;
	Thu, 11 Jun 2026 11:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177996; cv=none; b=h/IvoQDsMRMOSGGf4kPRa3006p84Xf3eMEd53WYoV1fsBZPQFp4RNAGuXvVK1JbzCJyfcDi3iPtrW3/ZlLbSDx1TxAT3KJh23WqWhgT4NdeAP+1EWFMi7l5rDzt+mWgZHOlZXgZrseCp2JKeJYQWJr9wFeumnHeVLLSsBQ8Cirw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177996; c=relaxed/simple;
	bh=rIDrnfZ41nqCCm/IlF4oWzjH0WVH/EKf7VQExR1i5vA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NEqFb6VmN0wcCtS/74PnpHPRY57dl3IAe6aDBHLsj3kwP2/SXEy0UAPi2HjIMGr8U3XM7NWVOrwVNktZdnHv8RepYzc/cXh90MtivLxIa1YGsKN2qDgyvHalpn/VGTItaSxFThXDfxt3I4ZOqU1YeZZ6KT6Dfb9ONPwdtWd9TTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k4aCb73R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k4aCb73R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu3sv1363798;
	Thu, 11 Jun 2026 11:39:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1xRaNhXfEBhZ8iWA7
	QGZ4CQjRL6RXVkNaeqt9LH4m3w=; b=k4aCb73RX1sLnRGLsglF2v+da6t/Fby1b
	2BeS8imuk72AnHmNJOu4EY3/FqnQIKdAxYxgfPNBFMYLaMyu7LgZCTHmkP4+QXGO
	ofVVWZnoSF3UELqUf8CIwsS5Eu2DOYbuqR7cTGuJ3pAHvLWbqYarlgh66p93viqs
	bV/s4RvfllTJKDSqLBXigOjiIHG+Yduqw55JhbeFEZ7PIpspUIHCOycL/RFn7Wa6
	I0D7qEXTE02EFk8xxC4j/ulZUgVG+jqOS+D75ZCTfBg8UXa6ZW5v6LqHvNIi9cXR
	n5U6LbRSiAV0ZP2akysZkzhq/P6cyDR3haCUoalU52vMXMYBxG+0A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8du2rp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BBYdZL005639;
	Thu, 11 Jun 2026 11:39:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09tye1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BBdYOG48562676
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 11:39:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D67FF2004B;
	Thu, 11 Jun 2026 11:39:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9BF8420040;
	Thu, 11 Jun 2026 11:39:32 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 11:39:32 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>,
        sashiko-bot@kernel.org
Subject: [PATCH v7 5/7] powerpc64/bpf: fix compare instruction emitted for tailcall
Date: Thu, 11 Jun 2026 11:38:24 -0400
Message-ID: <20260611153826.31187-6-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260611153826.31187-1-adubey@linux.ibm.com>
References: <20260611153826.31187-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: wLVGJRWgGmEZfnL1DwsRiM9weVPel_FO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfXzcjQ5zrErDjm
 GLTMQ1+j28opLrg4UJl4sr7pnUD6ESifguwZOIgkdmXK4EGWq6i4crNL49iztBi3bN0LFWxB82o
 MRBPAtaZTlHtBRWN0LH9chty5+LjdDr3UOg1fMIVAEv66WLdWeXOjeJGKoZ9JOWpXvF/w/8e4xO
 pOD+35YvzCRlj3LKbSVTFICRly9juy3BXbhdwRZaPjdS0IUi47r/qHHSuEi8yXHKjr+k0CX5V8B
 Kka/CPkf05UIRjUdFvxMOTcEehQy3OZDQop7Xl1+v/XbZsts87jqpAdp3RtnFI/XL33nemSqm/G
 faPnW3EJdUgIbJ5TLP8UgQsdKMDO/o6uukOMVmoN2wy+QGqH28/VTPaT/tgcOnd1Qu68UidHLUP
 LVsaB/9bi0ScaxZzdG1AWUFZ80BlhcMOA07mKKWXOdnwAOi8SKvq0iVJO3DBGSDqsGDT5/3zQch
 5xJPqiGHCR4exGhFogQ==
X-Authority-Analysis: v=2.4 cv=DPu/JSNb c=1 sm=1 tr=0 ts=6a2a9e7b cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_ChPpPKTfPU_lHkPiKQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX4X6WHKp4+gyC
 aDY116dzsJ9PHoCOYR2znZjR/lsCo55+opilyQiz1UZAVIspnw1CPXhBAUoOo3Z0AbnQrdT5e78
 F3MpZZNmpYd51vj4lX9IngaRN9yw+Gk=
X-Proofpoint-ORIG-GUID: wLVGJRWgGmEZfnL1DwsRiM9weVPel_FO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110116

From: Abhishek Dubey <adubey@linux.ibm.com>

The tail_call_info field can contain either a scalar counter
value or a 64-bit pointer to the counter, using a 32-bit
compare (cmplwi) only checks the lower 32 bits, which can lead
to incorrect comparisions when location of counter is near 4GB
boundary. Use instruction cmpldi for accurate comparision in
all cases.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260517191450.85AE6C2BCB8@smtp.kernel.org/
Fixes: 2ed2d8f6fb38 ("powerpc64/bpf: Support tailcalls with subprogs")
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c   | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index ebee23d33396..b36b55f12a8b 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -763,7 +763,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 		 * Setting the tail_call_info in trampoline's frame
 		 * depending on if previous frame had value or reference.
 		 */
-		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
+		EMIT(PPC_RAW_CMPLDI(_R3, MAX_TAIL_CALL_CNT));
 		PPC_BCC_CONST_SHORT(COND_GT, 8);
 		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
 
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index eaf816a07f14..086084abb184 100644
--- a/arch/powerpc/net/bpf_jit_comp64.c
+++ b/arch/powerpc/net/bpf_jit_comp64.c
@@ -276,7 +276,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
 		 */
 		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, 0));
 		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), -(BPF_PPC_TAILCALL)));
-		EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+		EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 		PPC_BCC_CONST_SHORT(COND_GT, 8);
 		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2),
 								-(BPF_PPC_TAILCALL)));
@@ -651,7 +651,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	PPC_BCC_SHORT(COND_GE, out);
 
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_LE, 8);
 
 	/* dereference TMP_REG_1 */
@@ -661,7 +661,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * if (tail_call_info == MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_SHORT(COND_EQ, out);
 
 	/*
@@ -696,7 +696,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * tail_call_info.
 	 */
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_GT, 8);
 
 	/* First get address of tail_call_info */
-- 
2.52.0

