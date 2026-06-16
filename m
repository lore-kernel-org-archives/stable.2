Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCCC366DC1;
	Tue, 16 Jun 2026 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614123; cv=none; b=SWr14nfdQKNLkAonM5V5iEjoUfZcoV/HcMjvH30b2KaIyprOgwnThpdlgrOv8+b0DOCX+CvBw6kseNcGM08JsxX2F4baANfvtl21MD/C2ORZctr5vV/9KB4Me5SsMasoA/bs7jNIVpLp7Ltn9+Is7qeD7RqRsY1yaWVpwl7uhWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614123; c=relaxed/simple;
	bh=26oBnhyS8jgr6BnudR/6iLNhSJM7N6j+JOLJBtlQ/mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SB7kAIf70seKqslIJih5ETNhWsRbww5O/MCLPp6gYoAuJeZIzDboS1ChMWvxNena7P//+V1BHK2OvCmXagw5HYxqXQo8bjz9PdyTRiXdX6S3DMQpwvdO6EfVz3e1C0erj99kfDiffKxtn17nBt8VPuuanTGhbFrY5TI3pwOOCnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QGIUaptN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QGIUaptN"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIGGh1395952;
	Tue, 16 Jun 2026 12:48:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=esOXrnEBsqa8PD/S6
	CVyx6Z8nYspUwbFrydWFgxBBEs=; b=QGIUaptNIXigQRWblQzbMUFoeEc1fuLm5
	YF1dNatwMDxwUAVPP7/z42v8rvbda82KU8cwF43neSDZzaeiZ5EFTRNVy0792+fa
	lQETGEt0kSbtCg/iquqPe9xm45e1VVQdHlP6MzMHjC9doVTqMDC5V2JeLJ+CAmcm
	hBNsiARWPsniuNgJ6Qd+OlgaN4exMyayKBQhdRuTCfClZNu+JnHRNQsxtGkE1z7y
	uwg+EObAlk8aDmIElPKVSS3Y8vQTeARwTRmYqyp8QTzACsm9M4NVet+iB2k8u+QJ
	2Q4VX2Tr34+RuRg13S7ge4jnRUdz8GgLR77xywVpWHqnPLPp3gIyQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1h85r5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:48:27 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYdXK010178;
	Tue, 16 Jun 2026 12:48:26 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4esjhk3b4q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:48:26 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCmMYc47120700
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:48:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EC032004B;
	Tue, 16 Jun 2026 12:48:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3C2DA20043;
	Tue, 16 Jun 2026 12:48:20 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:48:20 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [bpf v8 3/7] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Tue, 16 Jun 2026 12:47:37 -0400
Message-ID: <20260616164741.32252-4-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX0vWYvEVy0G4l
 Mrwo/zS13ainnrcSEH4lY/lvy/EpfbQEZkwqp6y+Q2Oxehx/rtmGQ82x4sOb+JyYKfq5cJGPNco
 x6YAe/q3GlfWeRBIm0fiV2FBiu++1Hs=
X-Proofpoint-ORIG-GUID: MRwJw2wvY_mFukhhzbwldUWmlQxskinq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX3ToHH+lbSBAD
 z8xRJ1A8StE+QjfqMaPnFtCebaz9EQsvA1q950MBSdcAzdr+fZfM7E/Tz+zp2OO8hZrgg+2BCJt
 wQSxNZy2npT1a0wfgA36QW0ZBrZjahwBRVSY39X37u2rhV2Ic4pcBkreECA6RpsttKmhsLydUSM
 +5d6ahcoCHCbtxQYvMmmsrDijHsgegVWzULzDjCI78nORi1gYvx6LudR4uAUtSuHz3/CdrZeaVL
 nkIbz/NdlqUDdTCqgupoJzPrziVzOAJ/twPsiWsmfRIhMexL9tcmGnmzehklzIU9OIY65DE2oKz
 9GRt2rRbjJP555TyE2Hm1A/+d/iSY89JZzzPlD1O1yHQKXiHGSu4Tg7ckpv0OoUO8Spd+xv1S0I
 fF2xA515EJhgMPggFRwl3Pp07r9rwZtl9AKk9x1d7AkYQ3cIt1x8AmPFeDyK70EF/LuGmUSF6/E
 r+s86ifX2yq+cQK66GQ==
X-Authority-Analysis: v=2.4 cv=U9uiy+ru c=1 sm=1 tr=0 ts=6a31461b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=jFlzs3kxbzYMnpdfaSYA:9
X-Proofpoint-GUID: MRwJw2wvY_mFukhhzbwldUWmlQxskinq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606160130

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure that the trampoline stubs JITed at the tail of the
epilogue do not expose the dummy trampoline address stored
in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
to the disassembly flow. Prevent the disassembler from
ingesting this memory address, as it may occasionally decode
into a seemingly valid but incorrect instruction. Fix this
issue by truncating the last 8/4 bytes from JITed buffers
before supplying them for disassembly.

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 .../selftests/bpf/jit_disasm_helpers.c        | 27 +++++++++++++++++--
 1 file changed, 25 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 3558fe10e28c..11428cad5b2d 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -178,10 +178,12 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 {
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
-	__u32 jited_funcs, len, pc;
+	__u32 jited_funcs, len, pc, disasm_len;
+	__u32 trunc_len = 0;
 	__u32 *func_lens = NULL;
 	FILE *text_out = NULL;
 	uint8_t *image = NULL;
+	char *triple = NULL;
 	int i, err = 0;
 
 	if (!llvm_initialized) {
@@ -225,9 +227,30 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
 		goto out;
 
+	/*
+	 * last 8 bytes contains dummy_trampoline address in JIT
+	 * output on 64-bit and last 4 bytes on 32-bit powerpc,
+	 * which can't disassemble to a valid instruction.
+	 */
+	triple = LLVMGetDefaultTargetTriple();
+	if (triple) {
+		if (strstr(triple, "powerpc64") || strstr(triple, "ppc64"))
+			trunc_len = 8;
+		else if (strstr(triple, "powerpc") || strstr(triple, "ppc"))
+			trunc_len = 4;
+		LLVMDisposeMessage(triple);
+	}
+
 	for (pc = 0, i = 0; i < jited_funcs; ++i) {
+
 		fprintf(text_out, "func #%d:\n", i);
-		disasm_one_func(text_out, image + pc, func_lens[i]);
+		/*
+		 * Disabled JIT have zero func_lens, hence underflow
+		 */
+		disasm_len = func_lens[i] > trunc_len ?
+					func_lens[i] - trunc_len : 0;
+		disasm_one_func(text_out, image + pc, disasm_len);
+
 		fprintf(text_out, "\n");
 		pc += func_lens[i];
 	}
-- 
2.52.0

