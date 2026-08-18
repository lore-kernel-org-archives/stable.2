Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA7A3CFF50;
	Tue, 18 Aug 2026 04:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787028300; cv=none; b=SNicCWy9lxkkk04+okgFzKX02fM0nJUReZPDHkVPco+rolnUPziOpiizDh4289WvAMgf3gL3uYJIZ6ja1Ob6TYsc8++mTGjQL2Ob+e+t7+QvGO+Lo35AvBmkfqSA2S/nKcSsoHKbZOIsoJD+PfEZV+uwSVCM6aUuFxZT00ezL9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787028300; c=relaxed/simple;
	bh=fu3zdJJCDYQ/JqF6t/4eKklG/E6LSzjok71eh0f6Ukw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n1/H0KR0UVjaUwqFbYs8nQSjp/ikdeHQgQqslHyV96cdWypNDv0ORmhGjNIXjo0vXeNRioRmnUc8N3k7HujYfMlGQj4MjG+EB5gOZC+7UwaoDiorAMyUIWP2SrRxd0Z4BHEalCaFjLE79SaYcWy2Ap39JFcgGd5ZVvpehgByju8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aPompkAQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aPompkAQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HM1kvw2526485;
	Tue, 18 Aug 2026 04:44:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ZIuxr7ve1EsfHD4TI
	wV9wbRem91LqTMa/I1SxblSMEc=; b=aPompkAQk8N9HDuQtAVv0kWTGAJACA4fZ
	aND5RpDoe7A4WtSYboVe5BtkH8ZUNjXIgZ3nk8CiA2BzOEQ8PvjoLMgq2QdBj/M4
	ZFMGP84JKklyC/CupBS4jCivkgyIk0HfmI57Rua8SedYvQ30R2TDICBAxao1KAPf
	Qv2M06qCQXiTJ7mmQZ/Q9/ftpYmV/6qos8qcNA7O18W71D7NwlLCOut78XDA9fKi
	nlmf8LNp/jbGrhPjXxanDxYHEGcJ5f7Ov6jBe5oaRqs86tRfAtl0zVBS50hPkZCq
	qJVXEQL/607yBJYTkvcbfkY2fx3GFSzeIqUgeteMyhWN5BkUl2kbw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkwx7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:39 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67I4fIQh020830;
	Tue, 18 Aug 2026 04:44:38 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng95e9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 04:44:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67I4iZ4Y37159196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 04:44:35 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E1992004B;
	Tue, 18 Aug 2026 04:44:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D305720040;
	Tue, 18 Aug 2026 04:44:28 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.39.17.69])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 04:44:28 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v12 4/8] powerpc64/bpf: fix compare instruction emitted for tailcall
Date: Tue, 18 Aug 2026 10:13:37 +0530
Message-ID: <25eadeff8698eae0fb2ce9e6bc323d3e0876fcd8.1787027080.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1787027080.git.skb99@linux.ibm.com>
References: <cover.1787027080.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfXw1c2d0kIR1/d
 C4PWggmXXs17jiZ0XvRJf2a1DUBg9c8JvCRGJpkekGeHuVEOzRGsnGDWOnAkcx3AmhQvDsLc7jy
 EJXacWlf4bjXYvY3mg8f21s3c+vErdDm/3Mfw4GcIbxJNjKRRMLXTwD7hoCNIzhX17GhdYbJtXY
 aVz1NcQQKJ+umOnHvFw1MyaEdEfU8yCtm2CjfgRf2kFC1tkjxqGDwboeiaiG7TXTKRYaQ/TmypL
 9BKxwrNqJYz3LW7NaKOowdYHGJWm9PMvOyQdKEJ12VSws4GBNtrsPuClY+QcsT4hWlj2bRIEavx
 5uDjQqdfwMRfY0UnFGvGKoN2b3NHMtBh0o3J0m8COtLvBP4uSnDGQD4Tqx6F056gecUTBnmPLYI
 go0WwdrPT7N5r8gcuF8bELtOfN2sGrTjRtrI4gkOj/stfTgEjLGXgIq3l7gbFLqKOIRaMjrGgOt
 gQ5fo9xwSRsOqkdafIQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDAzMSBTYWx0ZWRfXxwmFnb1hozqf
 JRitTtpIYAwPjARMhRg1Cu+UQZpbqln81LpQI5JgdUGkkdKtlZRwenV1dsCNffPbayaQvHF0245
 xESyf5yzo6ZnkHvJmYg8XINJjPC6z+U=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a83e337 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=_ChPpPKTfPU_lHkPiKQA:9
X-Proofpoint-ORIG-GUID: aLsGWgYVyTDJaMb8XlUSjLx5-YowwcQl
X-Proofpoint-GUID: aLsGWgYVyTDJaMb8XlUSjLx5-YowwcQl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180031

From: Abhishek Dubey <adubey@linux.ibm.com>

The tail_call_info field can contain either a scalar counter
value or a 64-bit pointer to the counter, using a 32-bit
compare (cmplwi) only checks the lower 32 bits, which can lead
to incorrect comparisions when location of counter is near 4GB
boundary. Use instruction cmpldi/cmplwi for accurate comparision
in corresponding cases.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260517191450.85AE6C2BCB8@smtp.kernel.org/
Fixes: 2ed2d8f6fb38 ("powerpc64/bpf: Support tailcalls with subprogs")
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Acked-by: Hari Bathini <hbathini@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit.h        | 6 ++++++
 arch/powerpc/net/bpf_jit_comp.c   | 2 +-
 arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
index 44fa414dc5a7..4da8bde92e1e 100644
--- a/arch/powerpc/net/bpf_jit.h
+++ b/arch/powerpc/net/bpf_jit.h
@@ -195,6 +195,12 @@ struct codegen_context {
 
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
index 870cbffdbb93..38acef44c097 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -786,7 +786,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
 		 * Setting the tail_call_info in trampoline's frame
 		 * depending on if previous frame had value or reference.
 		 */
-		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
+		EMIT(PPC_RAW_CMPLLI(_R3, MAX_TAIL_CALL_CNT));
 		PPC_BCC_CONST_SHORT(COND_GT, 8);
 		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
 
diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
index 951eb10ca1f6..e80312171aa7 100644
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
@@ -662,7 +662,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	PPC_BCC_SHORT(COND_GE, out);
 
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_LE, 8);
 
 	/* dereference TMP_REG_1 */
@@ -672,7 +672,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * if (tail_call_info == MAX_TAIL_CALL_CNT)
 	 *   goto out;
 	 */
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
 	PPC_BCC_SHORT(COND_EQ, out);
 
 	/*
@@ -707,7 +707,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
 	 * tail_call_info.
 	 */
 	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
-	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
+	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
 	PPC_BCC_CONST_SHORT(COND_GT, 8);
 
 	/* First get address of tail_call_info */
-- 
2.55.0

