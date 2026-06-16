Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62F7F345757;
	Tue, 16 Jun 2026 12:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614165; cv=none; b=URRcEShO/B4j/KH+3oaP92LxL9gA2XuusjLpYUaDFVdLJ6Jxn9qXIgn/Lm1c3RiAJss9jA7dRHcsBS16ZGDxpAHM0xqXfkQtapv11hKRuWnumeQESU6ahgfcMfcOQ00HmbQdZwqasLFS7OALScEExYom2jRa3DvLFsnywDTGg64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614165; c=relaxed/simple;
	bh=Xc9ISkDUKfyGcb1GeVIjqxryF8rhgzOOSA581ACn6HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwZy39mo94T5WRS+TA/dA2UpUc7nJ4vF4Iq8Jko2My3AF+fVPgh95en/3cmR2/VajGX30Me7/HMBPDC9BSAQEc5VwmAypON+A7AfQWw6Z1sFxUyKcqba28k8jgvIg+WfJHD5xXP5keup6qvIPsS+CFEfbUbF9Z7pkT+AYD5lQKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=S/1xhsGF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="S/1xhsGF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIY4Y1156309;
	Tue, 16 Jun 2026 12:49:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6BvKCzySK9Zv9PpZu
	6TcSsU5oDF2XsF4jcw9XZlhRJA=; b=S/1xhsGFP8o+qpByPBnsEJWpV+ZyTFMaA
	QhDYd2HX50ta9oSAmn49Ax6gCbAR5EaK8giSPtOSmN7tMoELse+6W5Wie3u8V/xL
	g2XhcHOlpq7f7B3uLXjH049mojIcsQyk+AXn6vQOYY/Hbhc9cYFCUmoQuSJQpXHj
	5fNcAi/b0Qtb+N8VDjQMZobf0jwjy6zTsGcK2lAfWmdKsUOX7o6f0jIR1VkqRBL+
	5/htExvzcK2/QWKD+g0T0eRJiMVHiy42kxUne4lHclRrABmEPV+8uwZ6aJHSegTr
	3/Phrn/3JqVhSI/gsg/Ud/OsjSRQ/W92vWX+xwDPaaqOf761+60HA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg5538-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:49:09 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYbb2030945;
	Tue, 16 Jun 2026 12:49:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eskrgb5dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:49:08 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCn4BC43778360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:49:04 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A124A2004F;
	Tue, 16 Jun 2026 12:49:04 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC8920043;
	Tue, 16 Jun 2026 12:49:02 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:49:02 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>,
        sashiko-bot@kernel.org
Subject: [bpf v8 7/7] powerpc/bpf: fix buffer overflow in JIT for large BPF programs
Date: Tue, 16 Jun 2026 12:47:41 -0400
Message-ID: <20260616164741.32252-8-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX/+MYKPnl7OuF
 nF8RsgnOUo3ZEbCw3WDEcTUj3BPQg0bB8ccRILoSwt0kXwxkQhq5DD0p4z/DkMRVRkZA+pxE+/v
 +ag8gDvUS2qEo5AszNrsuqR3gJCOQrM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfX0laae5ci+W07
 RD9xypHRs7ijd2yrEtqzEKj2yyRTP3hKy0GkS73lD1IhwUYqzsQPtkdlTHTePwnUjlmEsIupeH2
 bpR/F2V1XmPQglqbPa4TdGZX8fzTggFX6WK3Hoyltjx6ILb0RqzvTT+vA+BvSCbc9keNuAnVnYk
 96paml8w8XfirccBIRZ0SIFJk38k06M9nSL1Bkk5hXVyXK52ZdNpNy1OzhydmQ6UtuAyvmgZEee
 z1dB+/uiSBE+xpwt9s3TJooxYOgWh1quOjzEdoT/Amuncj40jp1KHBq+rRe9DWS6nTvseFnDqwV
 qY/N3VchT+8btp3Jq6jmycBs0ckIBbUKQkso8f1NQ5sjZrstR1Z6SFbjxac07MBLq3zCv9T8o9T
 jNzMytuCUu+HM18S/g3gNVqcEgSA4fdParrZitmqjN7n9BvEvcBagtklEbm2XlRUw2SI94HPPCK
 uTpWKLTMDpIVcVD058Q==
X-Proofpoint-GUID: hwu25mlypdz2NngOvoQ8zGwJ6B395rhR
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a314645 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=orbIJRQg7RPxDi6CqRQA:9
X-Proofpoint-ORIG-GUID: hwu25mlypdz2NngOvoQ8zGwJ6B395rhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160130

From: Abhishek Dubey <adubey@linux.ibm.com>

During size calculation in pass-0, exit_addr is 0 since addrs[fp->len]
is not yet populated. bpf_jit_emit_exit_insn() treats a zero exit_addr
as in-range and skips bpf_jit_build_epilogue(), so the alternate inline
epilogue instructions are not counted in alloclen.

In later passes, if the real exit_addr falls outside the 32MB branch
range, the full inline epilogue is emitted into the already-allocated
buffer, writing past its end and corrupting adjacent memory.

Fix by ensuring exit_addr is non-zero before treating it as in-range,
so pass-0 always falls through to bpf_jit_build_epilogue() and
conservatively accounts for all epilogue instructions in alloclen.
Also range check alt_exit_addr directly in the else-if condition.

Since exit_addr handling now falls through to the epilogue, two
related issues in bpf_int_jit_compile() must also be addressed:

1. Reset cgctx.alt_exit_addr before the second size-calculation pass.
   Without this, a stale alt_exit_addr from the first pass causes the
   second pass to emit a single jump instead of the full epilogue,
   undercounting alloclen and introducing the overflow.

2. Recompute addrs[fp->len] at the end of each code-generation pass.
   The larger body from pass-0 might shrink in later passes; a stale
   addrs[fp->len] would leave exit branching past the real epilogue
   into the padding.

Reported-by: sashiko-bot@kernel.org
Closes: https://lore.kernel.org/bpf/20260529015855.364704-2-adubey@linux.ibm.com/T/#mfcb23909d977b949727cca4f59ee56a13fd69b92
Fixes: d243b62b7bd3 ("powerpc64/bpf: Add support for bpf trampolines")
Cc: stable@vger.kernel.org
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 arch/powerpc/net/bpf_jit_comp.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
index 1c274df2b4f7..d48bc722d0dc 100644
--- a/arch/powerpc/net/bpf_jit_comp.c
+++ b/arch/powerpc/net/bpf_jit_comp.c
@@ -128,11 +128,10 @@ void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct codegen_context
 int bpf_jit_emit_exit_insn(u32 *image, u32 *fimage, struct codegen_context *ctx,
 							int tmp_reg, long exit_addr)
 {
-	if (!exit_addr || is_offset_in_branch_range(exit_addr - (ctx->idx * 4))) {
+	if (exit_addr && is_offset_in_branch_range(exit_addr - (long)(ctx->idx * 4))) {
 		PPC_JMP(exit_addr);
-	} else if (ctx->alt_exit_addr) {
-		if (WARN_ON(!is_offset_in_branch_range((long)ctx->alt_exit_addr - (ctx->idx * 4))))
-			return -1;
+	} else if (ctx->alt_exit_addr && is_offset_in_branch_range(
+			(long)(ctx->alt_exit_addr) - (long)(ctx->idx * 4))) {
 		PPC_JMP(ctx->alt_exit_addr);
 	} else {
 		ctx->alt_exit_addr = ctx->idx * 4;
@@ -303,6 +302,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 	 */
 	if (cgctx.seen & SEEN_TAILCALL || !is_offset_in_branch_range((long)cgctx.idx * 4)) {
 		cgctx.idx = 0;
+		cgctx.alt_exit_addr = 0;
 		if (bpf_jit_build_body(fp, NULL, NULL, &cgctx, addrs, 0, false))
 			goto out_err;
 	}
@@ -347,6 +347,7 @@ struct bpf_prog *bpf_int_jit_compile(struct bpf_verifier_env *env, struct bpf_pr
 			bpf_jit_binary_pack_free(fhdr, hdr);
 			goto out_err;
 		}
+		addrs[fp->len] = cgctx.idx * 4;
 		bpf_jit_build_epilogue(code_base, fcode_base, &cgctx);
 
 		if (bpf_jit_enable > 1)
-- 
2.52.0

