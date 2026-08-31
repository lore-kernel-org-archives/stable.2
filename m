Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814113C3439;
	Mon, 31 Aug 2026 07:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788160635; cv=none; b=Ca1gLhQa9/U6v0Gynfwo6JYc9sJ1pQoSTpMKUmtPsPAXHT6NM6TixKfLqKRcQ5aQopAwb0z1oaXZ2hDyJ/AGQMwVhd9CWLxdVxkGD5Zmc78A+3wg5JCgXpYXKerP9FWtmEAMYJeJ5A9vwrumiOazL/NgZiyTilX0DypVPFRuvx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788160635; c=relaxed/simple;
	bh=KxduHs0DOmyXAgHuW+6KNVO6HEaa6/Vt1RpiSbAo95w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rBPemKPvZk14lHuZ5ICNn+67fCVWB6SPleQ4Rsl0KDXJHY4G/qaRdpB/IgxknqnXP8t3P/EQiHYyEjx2d20Rxu1sR2dBQsqBF/3qaf8gfdSe70o7JLL53kL8bEZhO/3QKRJF3vT1qwhtCCaj4BMSJrXrHnoaN+cfXc923xCNpI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lFh0NIGG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lFh0NIGG"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67V52eJQ1270466;
	Mon, 31 Aug 2026 07:16:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nrCNqQyRjEs2T172T
	HhQTixW7ejk5qHSnv5UECNHcVU=; b=lFh0NIGG/F+6bmnmDaXRP1g46FyGb08d8
	lkuqdDkwbhqfxnP6UgGqsgjX282iAP0MqjDJHJNRsMWvPrVE5UDaTFSx90LWC0sx
	kWT1k4N3y++Tt09jEZOQ7utCUB6URkRgAE44UluaBgIX4gZtoEN9NOA0MliNPAto
	UKdLIaTAQR9XN9iC2ZMNPHzVntZfItdw0ixo1YmNNIvldYiVLmF84L1qJmF1fL33
	IGhiwq+GxZ41p8Mesg/ssHglgg/bYoMZ2w7JYCZQKY2pg43pXuOBi/UvthAdTAjt
	20H5ISy/j5jI+l2ETVbCO9fSHTgYWBSZdJIgf8R/SkGr9abncyBHg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbpx57s3u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67V7BLcN025282;
	Mon, 31 Aug 2026 07:16:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gc9rq4qdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Aug 2026 07:16:53 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67V7GnGJ51839254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Aug 2026 07:16:50 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0E4520040;
	Mon, 31 Aug 2026 07:16:49 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97BA320043;
	Mon, 31 Aug 2026 07:16:44 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.67.146.121])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 31 Aug 2026 07:16:44 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v13 6/8] selftests/bpf: Fix powerpc JIT disassembly failure
Date: Mon, 31 Aug 2026 12:46:03 +0530
Message-ID: <6034e8b7dc0c6954be35b6735a9b04b35903ed5f.1788154635.git.skb99@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1788154635.git.skb99@linux.ibm.com>
References: <cover.1788154635.git.skb99@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=PPc/P/qC c=1 sm=1 tr=0 ts=6a952a66 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=LRkTx50ZmXYUPJyuxFYA:9
X-Proofpoint-GUID: dldzX-afyEVzV3MVUjQcX0ryn2wZo_jD
X-Proofpoint-ORIG-GUID: dldzX-afyEVzV3MVUjQcX0ryn2wZo_jD
X-Proofpoint-Spam-Info: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX4QVQ5BrLvSnX
 jl6wL5bDKuPdGueF4aecmU+qEndqN3QD/onIVfDyDlz9tgRSRBmFzIj1k1KXXtyLSI/gT9Thg5v
 zOdZJg4OrXf2ucAqKodd4pzkzYY+Kug=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODMxMDA1OSBTYWx0ZWRfX9HktcbHWxPW/
 sZLjOUfOpZ+srbKBGXsl3PDRitbasj8i3M0iOBqYiEYsVdDb70tTBnHYohf+Iid3/01J38749pb
 NGBAqF4wXKk7fyIDZLhZlP95CmRuAE8ddbOXKsxXpf/UDbFnq2dvsik4B+tZINoZxivQXhr/cSq
 UfOvXLFVTRDczMLDhC/0vhQ6EkBmcACznQVPhtiLyrLtmbeXN/ZCntSLa6qYc6Hs/9FrGXzHw28
 Hn+Z10YMosUDXsb9kPGlLlYZ0kWvBOCBmma8qFrRKkg3HP+aFa3Betk5pV4EeuRDyN7Gp5BSGNW
 6il6eNb1n1dnRvtgYxPA2wd9lX63ch3OMfjO30Y/9ZOD2P/dQV0WClP0Wk27y08s9nqgSayqgDP
 8peZgS96jbyla0tsugmC82WKBlUByLiLgtRN0WwWFOrETX7+P8Q3qDmdYFpu06R7z7FP6rVIGxx
 RbzAUBsXu6r3hgAmzPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-31_02,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 suspectscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608310059

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
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
---
 .../selftests/bpf/jit_disasm_helpers.c        | 25 ++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
index 3558fe10e28c..b291d934dd1a 100644
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
 		fprintf(text_out, "func #%d:\n", i);
-		disasm_one_func(text_out, image + pc, func_lens[i]);
+
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
2.55.0

