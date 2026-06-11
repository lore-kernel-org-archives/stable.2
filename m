Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE7C3E6DD3;
	Thu, 11 Jun 2026 11:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781177988; cv=none; b=KiEiY5o/ORyTG9rQZBbW5n1Rp8Ra7rExXQ01v+8QYaaYV2DhpsKSl03jjw3EPV58A2TB9KSiJN9+o84tcaKgtTNnBXQiPTiPYpTpd2r7WzHW5imKgWDV2KfZpeshWcr7bfHpgstXUOXJwAcXAwHGuMsTC6Pnzp6OiW8Pn63z0GQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781177988; c=relaxed/simple;
	bh=pIS/J7a/geMLgysR0s8uPOME1JNgbmSn94SZcAUen+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uEMKrXe/zxAA0RNvE6cchvK+klPVVP6flnj4oiwPmsPeHf8v/41ERl5ByIEmT7GzFsokC6JTIrDn0w8HpLI5dQpW6d0pItrTdTMw61lG8Mj58tKs67gEPPAYTtsay/eb9Ysmr3xqQakcphoz9vlNvWX29hotGbBR1iAuWjuUOGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H73W4jn1; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H73W4jn1"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJuAsY677505;
	Thu, 11 Jun 2026 11:39:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=eKubuwyPu8Ec82f94
	tNitO+L10thXe/0QwLN9TQOGPI=; b=H73W4jn1ArRs82wOmwY5Jr7Mm3uNYl0eo
	SEfOCkYMKKnvMaRgPkJAIBJS1gQjJRh8VUj5HHLbZ6kPF/vs3l+x1XBLi01GFCZC
	2WxgPNWrpbv5oGVbdzEfQnG1dwtRyeoJwqsFvqs51alPsUf3WHUKRIT6nmsd3OCe
	j6a3dufztw6YJAkRphn/PLD3tbQbWqDGSNf7Qs1iXstzKDiKN8JiEbab7nSrak2D
	sfXkPy8ld2GBOjgK/xJU3IPgnt7mJoT+Iff7Lv0Q9LIdauhqIwi6l6dMaiId2Kjb
	ximF6sEcJpB9Zw/7y0f5gVbV44J/WWhoe6gSL/jo1SCjzPnRq0V1g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ak37c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65BBYmpq009441;
	Thu, 11 Jun 2026 11:39:29 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09jyc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 11 Jun 2026 11:39:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65BBdQ3f16187892
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Jun 2026 11:39:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43F7920049;
	Thu, 11 Jun 2026 11:39:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D94320040;
	Thu, 11 Jun 2026 11:39:24 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 11 Jun 2026 11:39:23 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH v7 3/7] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Thu, 11 Jun 2026 11:38:22 -0400
Message-ID: <20260611153826.31187-4-adubey@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: Vk3i4uA1ScR6BGgOBsvab5j6Wer2_iEp
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a2a9e72 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=BG0PCUMEzKLNx9Y0HWgA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX1qSXjidZTlqZ
 IQuQd4VeCAzAn+bij0s2uGJ4CsZlTi2pqIrVnPaOq2MWBvoe4RAzdua8yLEHZXKsZzyO6+oWTum
 HpWSMCNaMKpEVzCsn1GZ69pSdmPltSPqHa/XPBnngAH9Z5K2KE5AavqCIh7dpFeuXFPAufdcTzJ
 5iy98h5SenbbUSBteUc/IzW4amzKKtYWXxEf1CtiWeJ32MPwMrToK9GYIElmYAW9Whv3bH9sQry
 IARnDvCiNJckLovPfo2UIA/PeCI6fBP8zaLPY7UxZu7NMwB0Fl2B3ie+ViW3ROofsf9UqBTBSlf
 QLNAfyI7vJqBrM7UeJM2chaBm5AqdrbcoekLv1vnzCsi8ZSPCUzwwdceyGM/eZVJEAfM4+Blw1/
 jB1Qz0NQkfsOqHyi4QL064RIjyx/PZqcCTpQqOqLr8BeeHIv47HjdlvqPncWadfROUdYCJTRIir
 cydZFGzcD+xDTt3V6PQ==
X-Proofpoint-GUID: Vk3i4uA1ScR6BGgOBsvab5j6Wer2_iEp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDExNiBTYWx0ZWRfX5oeavV4eGNA1
 i0mPxhX5hBVEZzKS6mB43mLfujFLMxQzSb+vxrH8IdV0A38adKI/wn1o4Hvxv8FzO2Frpb4HhmQ
 KVJ4dVbqQ8tbHVtfAszOtPHEsC932FA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606110116

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
 .../selftests/bpf/jit_disasm_helpers.c        | 21 ++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 3558fe10e28c..759d6a86803c 100644
--- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
+++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
@@ -179,9 +179,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	__u32 jited_funcs, len, pc;
+	__u32 trunc_len = 0;
 	__u32 *func_lens = NULL;
 	FILE *text_out = NULL;
 	uint8_t *image = NULL;
+	char *triple = NULL;
 	int i, err = 0;
 
 	if (!llvm_initialized) {
@@ -225,9 +227,26 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
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
 		fprintf(text_out, "func #%d:\n", i);
-		disasm_one_func(text_out, image + pc, func_lens[i]);
+		// Disabled JIT have zero func_lens, hence underflow
+		__u32 disasm_len = func_lens[i] > trunc_len ?
+					func_lens[i] - trunc_len : 0;
+		disasm_one_func(text_out, image + pc, disasm_len);
 		fprintf(text_out, "\n");
 		pc += func_lens[i];
 	}
-- 
2.52.0

