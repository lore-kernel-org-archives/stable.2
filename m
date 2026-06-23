Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D5B37F8CA;
	Tue, 23 Jun 2026 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242100; cv=none; b=nNttHKZUCvcDjRSBywDMFhtdfR2iq/CgFHfbgCI8Ant4J2BGa4qehV7cf08CJkl4YmiS4UNYUON/PDUcb0L8t7deqZL1t00mPAbC0cAFd4bXQMgrRPRh6crJxtNaayxkekbqjkibW+F2keqmQfZCwb3D/1z2U+V3KhTWi4I17vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242100; c=relaxed/simple;
	bh=26oBnhyS8jgr6BnudR/6iLNhSJM7N6j+JOLJBtlQ/mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pWZxwFyxUos3A2MCW0zM7qt3ZpV+GSuBaEokxxyF3Bxr2fzjIYCHm5bbOlfZDyvranhQ1noB40YbRBIJ9ujHwbn+eIvPAhl5vHyR9U++Tbnfv+O3yyieKiZ8eByCrV8IHgIK9f4LcFUO3vXzBW7BusKrlOabM5smpC5OPLcv0uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pSTEIqbX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pSTEIqbX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmmeo1858095;
	Tue, 23 Jun 2026 19:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=esOXrnEBsqa8PD/S6
	CVyx6Z8nYspUwbFrydWFgxBBEs=; b=pSTEIqbXIEL2ThTdlBImqXo1NX9z6j2MN
	EbIXiORBQ0HqCiz0AQltSOPeoyIkHbbppBqWkhbAhBRcbT4OqdaeJOGJDtg59iDu
	ix+3e9JDFhS8Qj3zeBvY/fZnzk49ai9MJFzokGAoQWwuvZJ5jmkD8tqXqlYZc9Bm
	w8ZzrUoJxdU9DfAwnQ+pazpdGQprFHGc+k43hQrdJS7XmVf0PJkOAeZ1sM+867Df
	DIQ7Nqb9RJx6RBMjv9s22PTftIFcZLA98z32XotCkm96ylnKa5Hl4xzuVHooLzrq
	Cz4PV7lY3su/C7k5rlVcwcnsljt72Nd3EzkIQz0badPF/+66vQ74A==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewg9hrnax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:42 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJ4hnF002112;
	Tue, 23 Jun 2026 19:14:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phcw4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:41 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NJEbMU49479966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 19:14:37 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 710052004D;
	Tue, 23 Jun 2026 19:14:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D4682005A;
	Tue, 23 Jun 2026 19:14:35 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 19:14:35 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH bpf v9 3/8] selftest/bpf: Fixing powerpc JIT disassembly failure
Date: Tue, 23 Jun 2026 19:14:06 -0400
Message-ID: <20260623231411.6216-4-adubey@linux.ibm.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260623231411.6216-1-adubey@linux.ibm.com>
References: <20260623231411.6216-1-adubey@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k8mZkOqQ2k92PrneOyfGX7KP7hpk1iqf
X-Proofpoint-GUID: k8mZkOqQ2k92PrneOyfGX7KP7hpk1iqf
X-Authority-Analysis: v=2.4 cv=Y4XIdBeN c=1 sm=1 tr=0 ts=6a3adb22 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=jFlzs3kxbzYMnpdfaSYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfXzAEikBVaj89/
 dhvJKFsshOBaRsyTj6AQbqA8klrBZ6rzVexdo+MhBlCvrAJY5teE5Aoqs0hdk4CkINEtphcbUMw
 OlvqE19tByYAaeSilrXld7bj7zmGZQ2/CKcDIsTIrDWLGlbQ4TgmlnNfOlFWD+IRk5yUe9/cLRO
 ALIx8ulR7bxmkBZSuH2EEECOOUctZ4mbhy0BCSvn6cv9PX6FGUWNrAUWUuQbLWnG/+vxH5JCkHs
 ZauiK+TfrqhF754tIYHsmH6Y2K56MeAK25GXq/VcBNWi9xtBWAt+mT1adtEj4P0KK5d+/Ri21oa
 g/Y5pByfaL+MW+R51BiWxXhE5f2awdbRTgH4jHgtlTDlsgszXmgR/ULOhw9rjWbszabcycyQq83
 RP3Si2XREChznW40SoQJls69WVDVcqtaUD6NY3v6BNDlqUVOx4yVGOIn4BxM0/Yd53lz2T1eMkD
 02OUOjlyXhm+Kwhu4ow==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX5Nsn/o58vfhD
 mzd6qF8THcke7Jda+ls1sB7XhEKJr9G59NnLYqkmnQ/VYt6CZc8rAsqX4P6WMsKijxM0KDxwuXl
 i4mccm3xUUtermZHmwIx7BDN+5a2kes=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 malwarescore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 suspectscore=0 impostorscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230155

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

