Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 603EB30C35E;
	Tue, 16 Jun 2026 12:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614156; cv=none; b=j36PxRphCWAyUGXBVzLOJTCJ41w/fyV61joaD7yMVyWyFWtYUq03yDi3FMkgEe3BjnNOv/7uc2gcEbxfCIaQ/L185+ucOtkGstI9EDYyYlLPLAVpKDxnwdgzuLr7VHGxdGu+UksUnefkPhQhmNFBha3qj2K8+Q3TrmIKIXxbBUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614156; c=relaxed/simple;
	bh=nzDffTjJPAF2Fkw8ZpLilPKh6StndGVe661hXV0vCB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p09aOOZKZKF+oaKytzPWILiYRQT40Msv89Zc3anpKmahBO+rvNdKZbl/QV0EroSn+IuQYhYbcNPcaKBSjjvFYg4XsDQ0/Gg1+YRg9LUyv/gNzTlaQsZPV6y3asoyX4fbueZhnbbi8MAZAY0i8HDTCnWqaZahQbizA/V3OGfBDbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MzAuqHce; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MzAuqHce"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIHuL1245320;
	Tue, 16 Jun 2026 12:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=7nDSzOUBbdeWSb6M/
	HFrkb3N9Y9WDXnccZaskZs/GRo=; b=MzAuqHceGOF6z905aay7PhEaoHjLEpvUh
	zaouxs+ML2lMtxO823A+W8z5frDMpNyROs9bu47jKC+QNV7+bRe/FGzSMvgR3vqD
	DZD3xgSFwnJ+YmnfHSsDezx5tyJhbrzEoQHrBijZZx+C4bOm0Kk84kVph8lbus6v
	/Y6oH+SFQMhQYHsS7Uop24wcxboMwKJ7GZ2evCD12MS3wFQPdcm1sA4wJh9APFDU
	zxTByVZT0leKnCYGI0ZIOHnBzRxa7p1OI45M+shME37LymCE7QV5wqghVifkFa4y
	on8OmbOWSK4AfWAjfdQcD2/6wvW34UXzG5TPAFwu4R1ZLcfI7UpYQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nnmmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:49:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYcV1030948;
	Tue, 16 Jun 2026 12:48:59 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrgb5cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:48:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCmuB927001478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:48:56 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1D0082004B;
	Tue, 16 Jun 2026 12:48:56 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E653F20043;
	Tue, 16 Jun 2026 12:48:53 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:48:53 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>,
        sashiko-bot@kernel.org
Subject: [bpf v8 5/7] powerpc64/bpf: fix compare instruction emitted for tailcall
Date: Tue, 16 Jun 2026 12:47:39 -0400
Message-ID: <20260616164741.32252-6-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260616164741.32252-1-adubey@linux.ibm.com>
References: <20260616164741.32252-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a31463c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_ChPpPKTfPU_lHkPiKQA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX3uv+hbnLYHTk
 6kmIZ0stNf91G5U1quaxPSlEv7agPUnRm6l2SFnHqLxQ+kj4giRVIiQGuhzONzKvxUC0l4Y5oYv
 F8PTipanIRLiIGpprFt+DxrVjfJpsoNQaomOi0kiuOTokicyKTdzFmOz8STIQoqFSpf0smSt+Wb
 uraCfKkSDfAxgrdi0KNexFiiaw29/IUiLmCMMUFzDp8OEYBRUrRhgZ1ynd9UStQg8zfw4sAaBc2
 +2JgQsLpkk1ObPxFLcgox9BSFdrIF7xWMMH5G0rMesq5ZrnP/+2nRFlDuqreO/bxPepuoHbGtFO
 fZm6Zf9JxPvyDzRBz0igxsAlF16ZUSTpSBCR8v6tMLLMazrkeTxbKC2xY18iImPimKjtF8hqgTs
 FFMdfymHpTN7MZEHMmKEXpZ7ciHbfE7M+6krGJXmXRuQ9DpZCN19VptsfGOXACa9dnzhfAA+rpP
 8F5ulnrzdgy+FBC9wvg==
X-Proofpoint-GUID: ugXoT8MDRic-LXtQkv5kLsmjXq6dRtMj
X-Proofpoint-ORIG-GUID: ugXoT8MDRic-LXtQkv5kLsmjXq6dRtMj
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX5ujakIFFbi7U
 l2gzctzpfhMVzgQCTwmT8qbCF6GkzHpTip1DK4tO2rapsAYutze2rTYZkcVsLtO1IDscH6ZK2h5
 CvAeKr1eDNPkLvqpkiiE62ZNH/eg2K0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160130

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
 arch/powerpc/net/bpf_jit.h        | 6 ++++++
 arch/powerpc/net/bpf_jit_comp.c   | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 6632de9871dd..af510da12d8e 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -188,6 +188,12 @@ struct codegen_context {
 
 #define bpf_to_ppc(r)	(ctx->b2p[r])
 
+#ifdef CONFIG_PPC64
+#define PPC_RAW_CMPLLI(a, i)    PPC_RAW_CMPLDI(a, i)
+#else
+#define PPC_RAW_CMPLLI(a, i)    PPC_RAW_CMPLWI(a, i)
+#endif
+
 #ifdef CONFIG_PPC32
 #define BPF_FIXUP_LEN	3 /* Three instructions => 12 bytes */
 #else
diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index e36efc09e133..1c274df2b4f7 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -763,7 +763,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 		 * Setting the tail_call_info in trampoline's frame
 		 * depending on if previous frame had value or reference.
 		 */
-		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
+		EMIT(PPC_RAW_CMPLLI(_R3, MAX_TAIL_CALL_CNT));
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

