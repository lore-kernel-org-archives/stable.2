Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA638D3EA;
	Tue, 23 Jun 2026 19:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782242113; cv=none; b=HKrhEVjM1s3tWup4WgVqomGOKR565gITYWP2P9nykWe6Y0cLok48mUKmFns7IoylmZx5p923wjfwYzizalgAnZ4EoCZ2ACCjkjL1HIYAJjRU0iusP2Pw6nghhpw3FBmW2bUeUixGM5LuU8EhneRqXvSgePk1cT+X3DFuWnD/Agk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782242113; c=relaxed/simple;
	bh=jFlZvIjWEKlRjLYronD6WiyVJj87i6UWUowZV8yo9I8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DHy+UIsG5iVJm9KWmjGAJ7b+Cjumq4aeFQrMeGhQqHrq+Dl18QGGmt9QtQ7gnhAV2CMQNtVjVBdFjWApVGys0SF4kAEmjJ3PWfgfbzePsS4gQ6mTZc2N6Ch3v0IGm7n/sRM8gdMh1mE65Jz2+qX98EHYSNKnV/OZacwX/tbJrCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=URxTFvEL; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="URxTFvEL"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmPkL1805255;
	Tue, 23 Jun 2026 19:14:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NV9MRjnKrcn3AFW92
	zfPsRVSviWxiZjvS4UMUvjemAc=; b=URxTFvELEmlNZHzCgx9jM9pvIKgkgf8u5
	Isr61tSrXKLpaYa96+nlfGeibkiqBvcbTpKfFSa2lZ9gUxOuYzGx5Cdsfi4LI16M
	Ecg/X3SEXYEV2BImrtBU0aaPu0i8+MWzZC2v3xk/SmJkRHEfb4BPrz6XHU7Dh662
	4t3hasF3O2GXz0J/Kx4ofV2u323A093VWQmTaeEgyqI/5echu5vExbxUc6xaYbTt
	BwOlaFAnZ3cMfZM4ZVUveUrbTIWJq6+E9ffRd/do86A8Q2s0bUaZO00rdfhVmaz0
	AhNWb+z+lIKZ6czYiAZVTTJnuPPHvny5ZgKC61fGLRCfhcWhTlbgQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewh9ggcgu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NJ4hZu002116;
	Tue, 23 Jun 2026 19:14:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex6phcw5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 19:14:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NJEoef29360462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 19:14:50 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D1F12004D;
	Tue, 23 Jun 2026 19:14:50 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6660420040;
	Tue, 23 Jun 2026 19:14:48 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 19:14:48 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [PATCH bpf v9 6/8] selftest/bpf: Add tailcall verifier selftest for powerpc64
Date: Tue, 23 Jun 2026 19:14:09 -0400
Message-ID: <20260623231411.6216-7-adubey@linux.ibm.com>
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
X-Proofpoint-GUID: LlbwPd6zez2tNwdw64WoHQADCwZgJBK6
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX3kOlTw7vRDe5
 1i7XjTwvTDp9i+OtRCUEiHlQZPN4BcO/mrwEVArhA7wZFUwnw/45EaLyJhxYiCUOS/W4GwZyWdQ
 OvYxJeN0mjVcMgb0PNKTp1/3W9/eOF4=
X-Authority-Analysis: v=2.4 cv=c62bhx9l c=1 sm=1 tr=0 ts=6a3adb2f cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=YHohsJt5VkgNoF_SymIA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDE1NSBTYWx0ZWRfX/79DZDPyTPZV
 JRq2TFH9nfIZsj1xyju96VG7fYJCClDx0JAq3Kd62DKYazeIDwbBgYK3GXgMixmESV3BQ3d+HbV
 9m3ggJhDVXq6U1Ka7fu19rJee/Hq4uoOROwMzg9Z3u//j/sbyTmBvnmHkUwb3spwtyTTcuSTZvU
 p85NUNKQWTrbJtVF4sE9LgreQe/g7Npx+39H+5weiaG2FBNQCjefifslnwXX+00lpyT96qWl6l1
 vJrjo2EsVIlA6jFbYPSueUGO5+HYak8/MPAQAr45fEOwgjr8368KYqlDv6bMZ49ACZFVFkFG7++
 05q6r6tYnMWVx7H0aPU3UOLNbCGL5YgJJDCmKX0LkyyaWksTSH+XcHO91C2gxu9OZFxqSU+EknZ
 1Yf6ETN2qp4qAEQab27fUXmUnEHUwTRMFpdlZYoMiPZoXj1hYV97Cn3x28gEKPLqevTN2YuYGfe
 enMSwB9rTD6i+9NnEHw==
X-Proofpoint-ORIG-GUID: LlbwPd6zez2tNwdw64WoHQADCwZgJBK6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 clxscore=1015 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230155

From: Abhishek Dubey <adubey@linux.ibm.com>

Verifier testcase result for tailcalls:

# ./test_progs -t verifier_tailcall

#618/1   verifier_tailcall/invalid map type for tail call:OK

#618/2   verifier_tailcall/invalid map type for tail call @unpriv:OK

#618     verifier_tailcall:OK

#619/1   verifier_tailcall_jit/main:OK

#619     verifier_tailcall_jit:OK

Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
---
 .../bpf/progs/verifier_tailcall_jit.c         | 69 +++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
index 48fa34d2959f..09d7e92c8491 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -91,6 +91,75 @@ __jited("	popq	%rax")
 __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
 __jited("L0:	leave")
 __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
+__arch_powerpc64
+/* program entry for main(), regular function prologue */
+__jited("	nop")
+__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
+__jited("	li 9, 0")
+__jited("	std 9, -8(1)")
+__jited("	mflr 0")
+__jited("	std 0, 16(1)")
+__jited("	stdu 1, {{.*}}(1)")
+/* load address and call sub() via count register */
+__jited("	lis 12, {{.*}}")
+__jited("	sldi 12, 12, 32")
+__jited("	oris 12, 12, {{.*}}")
+__jited("	ori 12, 12, {{.*}}")
+__jited("	mtctr 12")
+__jited("	bctrl")
+__jited("	mr	8, 3")
+__jited("	li 8, 0")
+__jited("	addi 1, 1, {{.*}}")
+__jited("	ld 0, 16(1)")
+__jited("	mtlr 0")
+__jited("	mr	3, 8")
+__jited("	blr")
+__jited("...")
+__jited("func #1")
+/* subprogram entry for sub() */
+__jited("	nop")
+__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
+/* tail call prologue for subprogram */
+__jited("	ld 10, 0(1)")
+__jited("	ld 9, -8(10)")
+__jited("	cmpldi	9, 33")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	addi 9, 10, -8")
+__jited("	std 9, -8(1)")
+__jited("	lis {{.*}}, {{.*}}")
+__jited("	sldi {{.*}}, {{.*}}, 32")
+__jited("	oris {{.*}}, {{.*}}, {{.*}}")
+__jited("	ori {{.*}}, {{.*}}, {{.*}}")
+__jited("	li {{.*}}, 0")
+__jited("	lwz 9, {{.*}}({{.*}})")
+__jited("	slwi {{.*}}, {{.*}}, 0")
+__jited("	cmplw	{{.*}}, 9")
+__jited("	bf	0, {{.*}}")
+/* bpf_tail_call implementation */
+__jited("	ld 9, -8(1)")
+__jited("	cmpldi	9, 33")
+__jited("	bf	{{.*}}, {{.*}}")
+__jited("	ld 9, 0(9)")
+__jited("	cmpldi	9, 33")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	addi 9, 9, 1")
+__jited("	mulli 10, {{.*}}, 8")
+__jited("	add 10, 10, {{.*}}")
+__jited("	ld 10, {{.*}}(10)")
+__jited("	cmpldi	10, 0")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	ld 10, {{.*}}(10)")
+__jited("	addi 10, 10, {{.*}}")    /* offset depends on CONFIG_PPC_KERNEL_PCREL */
+__jited("	mtctr 10")
+__jited("	ld 10, -8(1)")
+__jited("	cmpldi	10, 33")
+__jited("	bt	{{.*}}, {{.*}}")
+__jited("	addi 10, 1, -8")
+__jited("	std 9, 0(10)")
+__jited("	bctr")
+__jited("	mr	3, 8")
+__jited("	blr")
+
 SEC("tc")
 __naked int main(void)
 {
-- 
2.52.0

