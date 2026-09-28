Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFD437B02D;
	Mon, 28 Sep 2026 05:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790572489; cv=none; b=e0ROuQR/RVNOxd0DuOGZ3Sh1WGteCv/2optBTD3Bnb004NS0WBKOLPR4smUkGSw/YNYXLGylBR3/28PSV/AXTv9Y1Rjx5+b3ZMBAQsJuKrk1veEX6qenrg2r/6N/9C2jNDDa42/LfdABEy4Nc8ZdGHmJLoZNagQBRfOyqJiq/Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790572489; c=relaxed/simple;
	bh=MMPjVCTmIFEwMiOHhpsA4IQfMkI4XSX2a/CYGCMUTbA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evXpICuH8DppDyxm6qivfjorugP3X0mpLsMQkGUkGyDp+Jbq27Eq8URugkURm7gtncq37SNplOvUd6O6nGvgQGBgC4EGi366rB+/8MBXj/jGAr+nokkQmn0Zfg1uDJ25DfH0CAkauG0l9RTBj3028LG3DSpSsfmIz/dkCmZ2JRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f5YOcExf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f5YOcExf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68RHRD9n244795;
	Mon, 28 Sep 2026 05:14:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=ACERjJqx86aC/lpX1
	ykbkrjCjA3Z/V5tEb1tqx8W1jE=; b=f5YOcExfPHs4SjghP2flFM5/t8adAy9di
	D1Vf3/6KArldsGxCjqnQZwzVuSNiHdZ5gJ57TGF030xN0DXQllNp+S2+oZz3Bmbp
	y77rKPuRVgkxOHE3LHaZdbacmbpsZZR0AOdMYfH4IlfyoI7gOzvOb7Xa5aKsI8HG
	nd/3HCcDus5Fx381wkEFzwNhg2rCZL6hLLoM1ZpCCdjEfU/T8cDHkMKEUgd3HAqy
	s8oWltDuMZJyUO+UnnmyKyIAD0vuS5CIhrbAZ3aip06aR6Cv2wBUGmoubt17vVJF
	iSckTpLzuosdskBQrJ4B5EFW9VD19s3jQ0h6SCnPkW7GQJwShTuSQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s4yds3-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:14:25 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68S3vZRe2157270;
	Mon, 28 Sep 2026 05:14:24 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gxsvhbpj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 28 Sep 2026 05:14:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68S5EKub36897252
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 28 Sep 2026 05:14:20 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B741120049;
	Mon, 28 Sep 2026 05:14:20 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2817320040;
	Mon, 28 Sep 2026 05:14:17 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.124.213.52])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 28 Sep 2026 05:14:16 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v14 5/5] powerpc/bpf: Move out dummy_tramp_addr after Long branch stub
Date: Mon, 28 Sep 2026 10:43:54 +0530
Message-ID: <552225fc257381fb83d282b3040c6ad363246465.1789982239.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789982239.git.skb99@linux.ibm.com>
References: <cover.1789982239.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfX1rSa1uOkqCA5
 bizQezQcpMWwJz2pM5Wr5n25byw9hHc1mDH+ywNIP/f6Xkc7BoFqFGfyJS41Bb7+MP8TE3SNTqh
 sRH2wUgj0m5eZfhPd1jW3U6sy0w8lPg=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6ab9f7b1 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=RdjiNnAT9l7Kg8zf_tkA:9
X-Proofpoint-GUID: dZKEmwNZS-SnHjZ5CCX1bLxF8R96sxE8
X-Proofpoint-ORIG-GUID: dZKEmwNZS-SnHjZ5CCX1bLxF8R96sxE8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAyMCBTYWx0ZWRfX9DrqRYPm1CKe
 Z4HI0JyX4oeHnf0Nqul7YyPBw5pvlWdLJFvZs/ye6jpFyh5RHdufWAxkj7Z35njlMFnVE5aa2Hw
 aMXUZo7V0Yy+AZTuKYLAHS5j1XtkEo8nvBT+oMs/+v5d3NCshnmM/0tCewPQDu4nPwvEmCZzzGT
 Q5xyGQMucwn6AxhPB66p/SDAbD0GJE7gHgyDS10dn8GAPkMBU/NNKChQwOVU/VIJlurfV1XECQr
 4KreMInu0+0p3+J1tNBqJgi1jL+BJxjqzIgBgkPfAEcv9qZh6u9xiOVSpp7lxpXPkEpibGeWnLb
 w8ESojHcg7g5BHNCffzFyRIVkwUIZtCXW/oa3+rQGUCXB96wBTDV61eNPdii3c6mqsWGGMl/qZo
 82Rbln7FvtogIkjfcfEjfmddgHSLFsx7gnsEg5nbVMLL2/lHSovox/fe2lz++BX7OjG/vZl9SFO
 Bm89nT3cYTx7+lQj3WQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-26_05,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609280020

From: Abhishek Dubey <adubey@linux.ibm.com>

Move the long branch address field to the bottom of the long
branch stub. This allows uninterrupted disassembly until the
last 4/8 bytes. The last bytes exclusion is logically necessary to
prevent disassembly failure, otherwise the actual program layout
is never altered. Hence no effect on overall program size.
Also, align dummy_tramp_addr field with 8-byte boundary.

Following is disassembler output for test program with moved down
dummy_tramp_addr field:
.....
.....
pc:68    left:44     a6 03 08 7c  :  mtlr 0
pc:72    left:40     bc ff ff 4b  :  b .-68
pc:76    left:36     a6 02 68 7d  :  mflr 11
pc:80    left:32     05 00 9f 42  :  bcl 20, 31, .+4
pc:84    left:28     a6 02 88 7d  :  mflr 12
pc:88    left:24     14 00 8c e9  :  ld 12, 20(12)
pc:92    left:20     a6 03 89 7d  :  mtctr 12
pc:96    left:16     a6 03 68 7d  :  mtlr 11
pc:100   left:12     20 04 80 4e  :  bctr
pc:104   left:8      c0 34 1d 00  :

Failure log:
Can't disasm instruction at offset 104: c0 34 1d 00 00 00 00 c0
Disassembly logic can truncate at 104, ignoring last 8 bytes.

Update the dummy_tramp_addr field offset calculation from the end
of the program to reflect its new location, for bpf_arch_text_poke()
to update the actual trampoline's address in this field.

All BPF trampoline selftests continue to pass with this patch applied.

Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 44 ++++++++++++++++++---------------
 1 file changed, 24 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 8ca36a933c7a..c2717f0d9cdd 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -52,19 +52,19 @@ asm (
 void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context *ctx)
 {
 	int ool_stub_idx, long_branch_stub_idx;
-	int ool_stub_sz;
+	int stub_sz;
 
 	/*
+	 * The dummy_tramp_addr field is placed at bottom of Long branch stub.
 	 * Align the mis-aligned dummy_tramp_addr field in the fimage.
 	 * The alignment NOP must appear before OOL stub, to make
 	 * ool_stub_idx & long_branch_stub_idx constant from end.
 	 *
 	 * The fimage can be non 8-byte aligned, so final alignment depends
-	 * on start of fimage and the stub's instruction count offset. The
-	 * OOL stub size is 4 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
-	 * or 3 instructions (without) before dummy_tramp_addr.
-	 *
-	 * Emit a NOP here if address is not SZL aligned.
+	 * on start of fimage and the stub's instruction count. The
+	 * stubs block has 11 instructions (with CONFIG_PPC_FTRACE_OUT_OF_LINE)
+	 * or 10 instructions (without) before dummy_tramp_addr field. Emit a
+	 * NOP if the address of dummy_tramp_addr is non aligned.
 	 *
 	 * In pass=0 when image==NULL, conservatively account for space
 	 * required to accommodate alignment NOP. In case final pass skips
@@ -72,8 +72,8 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 	 * jited_len signifies correct program size.
 	 */
 
-	ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
-	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + ool_stub_sz, SZL))
+	stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 44 : 40;
+	if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + stub_sz, SZL))
 		EMIT(PPC_RAW_NOP());
 
 	/*
@@ -94,28 +94,29 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 
 	/*
 	 * Long branch stub:
-	 *	.long	<dummy_tramp_addr>  // 8-byte aligned
 	 *	mflr	r11
 	 *	bcl	20,31,$+4
-	 *	mflr	r12
-	 *	ld	r12, -8-SZL(r12)
+	 *	mflr	r12	// lr/r12 stores pc of current(this) inst.
+	 *	ld	r12, 20(r12) // offset(dummy_tramp_addr) from prev inst. is 20
 	 *	mtctr	r12
-	 *	mtlr	r11 // needed to retain ftrace ABI
+	 *	mtlr	r11	// needed to retain ftrace ABI
 	 *	bctr
+	 *	.long	<dummy_tramp_addr>  // SZL bytes aligned
 	 */
-	if (image)
-		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
-
-	ctx->idx += SZL / 4;
 	long_branch_stub_idx = ctx->idx;
 	EMIT(PPC_RAW_MFLR(_R11));
 	EMIT(PPC_RAW_BCL4());
 	EMIT(PPC_RAW_MFLR(_R12));
-	EMIT(PPC_RAW_LL(_R12, _R12, -8-SZL));
+	EMIT(PPC_RAW_LL(_R12, _R12, 20));
 	EMIT(PPC_RAW_MTCTR(_R12));
 	EMIT(PPC_RAW_MTLR(_R11));
 	EMIT(PPC_RAW_BCTR());
 
+	if (image)
+		*((unsigned long *)&image[ctx->idx]) = (unsigned long)dummy_tramp;
+
+	ctx->idx += SZL / 4;
+
 	if (!bpf_jit_ool_stub) {
 		bpf_jit_ool_stub = (ctx->idx - ool_stub_idx) * 4;
 		bpf_jit_long_branch_stub = (ctx->idx - long_branch_stub_idx) * 4;
@@ -1309,6 +1310,7 @@ static void do_isync(void *info __maybe_unused)
  * bpf_func:
  *	[nop|b]	ool_stub
  * 2. Out-of-line stub:
+ *	nop	// optional nop for alignment
  * ool_stub:
  *	mflr	r0
  *	[b|bl]	<bpf_prog>/<long_branch_stub>
@@ -1316,14 +1318,14 @@ static void do_isync(void *info __maybe_unused)
  *	b	bpf_func + 4
  * 3. Long branch stub:
  * long_branch_stub:
- *	.long	<branch_addr>/<dummy_tramp>
  *	mflr	r11
  *	bcl	20,31,$+4
  *	mflr	r12
- *	ld	r12, -16(r12)
+ *	ld	r12, 20(r12)
  *	mtctr	r12
  *	mtlr	r11 // needed to retain ftrace ABI
  *	bctr
+ *	.long	<branch_addr>/<dummy_tramp>
  *
  * dummy_tramp is used to reduce synchronization requirements.
  *
@@ -1425,10 +1427,12 @@ int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type old_t,
 	 * 1. Update the address in the long branch stub:
 	 * If new_addr is out of range, we will have to use the long branch stub, so patch new_addr
 	 * here. Otherwise, revert to dummy_tramp, but only if we had patched old_addr here.
+	 *
+	 * dummy_tramp_addr moved to bottom of long branch stub.
 	 */
 	if ((new_addr && !is_offset_in_branch_range(new_addr - ip)) ||
 	    (old_addr && !is_offset_in_branch_range(old_addr - ip)))
-		ret = patch_ulong((void *)(bpf_func_end - bpf_jit_long_branch_stub - SZL),
+		ret = patch_ulong((void *)(bpf_func_end - SZL), /* SZL: dummy_tramp_addr offset */
 				  (new_addr && !is_offset_in_branch_range(new_addr - ip)) ?
 				  (unsigned long)new_addr : (unsigned long)dummy_tramp);
 	if (ret)
-- 
2.55.0

