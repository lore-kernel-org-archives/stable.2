Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 102D53D9521;
	Wed,  5 Aug 2026 06:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910070; cv=none; b=uGzE7b+ba7CT+b3jtq5uB8BzeOmDCWf5g44+8pRjGjWBT+raxKGtROzm7EIIQS/wqAGxVcmtyutmKb2y6CS4jJKdZpqsYW7LVdNlfvhzkFUQWagyUtxXXcUNLfYgq4Lp0CkMc/JkVFNwQNHSca9b5AC3Oemd5s+jDT2bKg2L3Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910070; c=relaxed/simple;
	bh=8URoh6UYzliFPDVvzhS4UDus/2XwoF5S2QfEqyIzXwc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+mHkma8pvSkMfXsITUUHIVKOQ5AI4dse+JX/8vIFDTnNfKWWzYKr4wYSZ5jYBoqZnoLZxzKSHKjMMQKgEqVfIoUMjJCkoNZnLMIr1KF2KtT8Pf6/7ssxtJ6exYHSCXysgoATp1pvpJ5FoLNpXXENz8FfwM67PirEsS6eSc0mO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YOXeEDSI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YOXeEDSI"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755mqas3058328;
	Wed, 5 Aug 2026 06:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=6/PcJHzf5OlVvKqg0
	bq+dzlnVX8MyflyGDNa60XIe8w=; b=YOXeEDSI24WircU2YVxVNHZ0hSgxwWmOp
	gRjTNxjataAhlL97GI2S8eQy/ubz8GGw6B1ObM3R4NOF3wMwRM+nKQi2FqFfyAeE
	qq9rlfWskJfgQV3lQRDGxR9pI2Fw6oXMBRG/6SnTaktFmJsAeD+jsOZoB1fDt3dC
	vNf6L1RzhTDWzesDwp5q7FgK31jAHw65X+0JHPckAd+6BJ761nUWdl4aGOYX6C0h
	bB7XabijK/zygQOc86ZVJ1sGD1F27dW4HXSZfzi12azyeQdLyctS9fyq6wm7jTxh
	f8oYGvi9iHm27rDiJepVSMkTIjdcnWYkv8JRq/LGp4UbFfdzz5iqw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8eus1bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:07:28 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6755ueBR023346;
	Wed, 5 Aug 2026 06:07:27 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbgd241-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:07:27 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67567N4F32178456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 06:07:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7312420043;
	Wed,  5 Aug 2026 06:07:23 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B6FA20040;
	Wed,  5 Aug 2026 06:07:19 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.124.213.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 06:07:19 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v10 3/8] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Wed,  5 Aug 2026 11:36:59 +0530
Message-ID: <8b7bde664004feb383741b8807a561dba601285c.1785906979.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1785906979.git.skb99@linux.ibm.com>
References: <cover.1785906979.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: x2s9CexoTPbjUFy0Vr27Uri5IiNcIyzp
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfX97fsSRP9URoV
 +V3V/GlQiUQhswy+d46k6pcmllT3SHJKd5l5nBmd06pCrXUCx57Bc5ilIIs7EqYR7wEPyIhaYWt
 +OB3OucVln8hSruhn7G4Ar69Z/HtlRc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfX/nIhw+mJyA7m
 7aZc6hjBBrDCi69u1gOaMy9YULaVMI1wV/Uh6oS5+o+vAcdg2B1HwWT1vDsKtvh5jZSOkRb3L+g
 6XXH6OE8XmeTmAQfkAJF+CP7dRhMvWvnd7sIOyxni6N8TfIeBV4cL1J4iD4so0EUKkADS2YOLLX
 95fKbShZupDvQT7rOlKQkZCYrasUv/MhZviMNX0MMhfen+P0ddpUHoiaQD3B6+JKYkQXOCHao2Y
 +fU8EM9hzcra/2gRxlGWqrJBNxB5d+VSSXunhnqMZyPduHwTzFJ5tgZ+uzNmXPpSEV2c5Q8Yda3
 0MNZf9n4nLEyX6ufIFU8DoE6Uj6asuAiNKVdKJxmOh8w9JEUUSbk03OmMTmykste9Cbi1QYb5Rw
 7zUz0qi7hxwuFJlebcBehUw4O6+9bdFWbKJorJKovZNsydtq8v43rOxg/nTTRcQ936vyHCS7WR9
 z8XhTN/Sw6+rgbsgjFw==
X-Proofpoint-GUID: x2s9CexoTPbjUFy0Vr27Uri5IiNcIyzp
X-Authority-Analysis: v=2.4 cv=KfzidwYD c=1 sm=1 tr=0 ts=6a72d320 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=jFlzs3kxbzYMnpdfaSYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 impostorscore=0 suspectscore=0 malwarescore=0
 adultscore=0 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050042

From: Abhishek Dubey <adubey@linux.ibm.com>

Ensure that the trampoline stubs JITed at the tail of the
epilogue do not expose the dummy trampoline address stored
in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
to the disassembly flow. Prevent the disassembler from
ingesting this memory address, as it may occasionally decode
into a seemingly valid but incorrect instruction. Fix this
issue by truncating the last 8/4 bytes from JITed buffers
before supplying them for disassembly.

Fixes: b991fc520700 ("selftests/bpf: utility function to get program disassembly after jit")
Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 .../selftests/bpf/jit_disasm_helpers.c        | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 3558fe10e28c..c4aa1d69d3bb 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -179,9 +179,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	__u32 jited_funcs, len, pc;
+	__u32 trunc_len = 0, disasm_len;
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
2.54.0

