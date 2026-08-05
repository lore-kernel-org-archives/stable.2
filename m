Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D711C3DA7C4;
	Wed,  5 Aug 2026 06:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785910082; cv=none; b=XziokGX9SjRmBERaF/kfYPW2hibYUygIH3WvHCS1DuEU3uQCvc2bzQuAkPNV/vDIeaottIMRjZzEuFrhIYWCEDIpkrqshChr3qHRQ08uY2I48qRCxrVbNg/GuWCCqYOv8ZUwJ8tNaI96xaruuQF4F0O97UuPSRiOzvKPM0RBW/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785910082; c=relaxed/simple;
	bh=TFkQI5gVkOOPw1vHUFRgsifkoQLkRVMJoTOHRbe1beY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VDgeoi2Sr7e7NC51l8Gp5FNLUCwl9Z97ouGnN4dGiGVQXGwveCsWaV76KbInw9etRB0ll0u9Qce7SeCT2ucOtcKwTxRexkv8gu27yO8+0LK10T/YZJhIneGUwtNmDtQtlvpEuc198mUt4JsbwVYCAUn37M/HMyPjwjn7dRUfK7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rUR6nWAV; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rUR6nWAV"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6755mAPe2908791;
	Wed, 5 Aug 2026 06:07:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=czHJk1szuj3ov/7Zc
	86FnIvw/S1Oo0CfFDgDPi+8+Ck=; b=rUR6nWAV/FHYMVyLG1qEDAh/YTWffbmPS
	LiITodJEayheQxLyAlj7uDSMeZPtBBegoURMkYE3wyEq8bStmtPNSSSwYH0DkxWT
	jXG4VyytHUvGWzDEPGbQKbQX3lxD5OdO4AzyD02FPPN+QdxN6740KHsssPR6aVdo
	XrjJbwcjScQqEet+KqmclnXE/vHEQ5zXSoKk6iqhEDMMu7OwTXpPa5GQbif4mUPz
	sLMoVLKZUl9r795ldUqFH4LmfQkdj/PXxHUIMwGD5z/RqCl51Yr/+cB2TCDXmLhU
	2gsR5A2EW6DJCsfiiIFIkqUQZJ4CPEntQUkdJWPa6krKKvCcyGloA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hsben-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:07:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6755ujve030308;
	Wed, 5 Aug 2026 06:07:40 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyn0qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Aug 2026 06:07:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67567aLE50004266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Aug 2026 06:07:37 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6F4020040;
	Wed,  5 Aug 2026 06:07:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D74B120043;
	Wed,  5 Aug 2026 06:07:32 +0000 (GMT)
Received: from li-1cb9f04c-2ae1-11b2-a85c-a8a0a83790a8.ibm.com.com (unknown [9.124.213.166])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Aug 2026 06:07:32 +0000 (GMT)
From: Saket Kumar Bhaskar <skb99@linux.ibm.com>
To: bpf@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, skb99@linux.ibm.com
Subject: [PATCH v10 6/8] selftest/bpf: Add tailcall verifier selftest for powerpc64
Date: Wed,  5 Aug 2026 11:37:02 +0530
Message-ID: <83b869ecd74466a3fb08343c365494dcf144e3f6.1785906979.git.skb99@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfX/L0I3mtktTlu
 9V4y/NJdDj7ewuOHaUzF5NdjpjF1yaJqJFxVJbfqAJgguvPMtmYC/a8UxQghP50lLgLZcgXU73D
 BQv93bIdnxXsE+zLm3uoq9nkXPs6xsM=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a72d32d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=SaLraETjdKAjPQJzA60A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDA0MiBTYWx0ZWRfX4p8h7OwxseVQ
 DowbjaHLjUv88iWpOXsyqXP4vu0Sh7t9tNkZkVqdy23m7HIEbQN5adVKYjai79LNKhOrwzFWZcx
 7kVEQbrDLsnITXlfNk6qL5AATg93dIGIBYI8Vmd3AY8Li+zcaq0gWOR3jk1/UdHXTnlyQB9Gt2a
 Gu/7V4hUV8ZprwbLMsEzqzn6aPIzfcN1zw/BWu25oFuCshqG3DCrV97O/tUzsYhsXxYTDYaGamo
 s49pojw8SlKjCV0ffSoQ1/zypXuI1UKGQAdGssxnAV4aBJL1EwGK6LUJriYeSWPonRw+fElhxRs
 q8i0D5OQLVCksOXBrt43Qw+2RnA1fTEypoBjaUE79p4Qm2ZR92d125th7VlzMqKIhkNkO3TMCUg
 q6M/SIufJ9FaK3cw/SiGeYS3e7ct1dRPIdhEsW6ynsoseiZGwdrBpIF0rJb13FN8aSSJZ5gSC/R
 n8nW2a3X+5p9eT4Fh9A==
X-Proofpoint-ORIG-GUID: osHcyDQHAcP8dLST1LykxwxJYbfytXGH
X-Proofpoint-GUID: osHcyDQHAcP8dLST1LykxwxJYbfytXGH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_02,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050042

From: Abhishek Dubey <adubey@linux.ibm.com>

Verifier testcase result for tailcalls:

Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
---
 .../bpf/progs/verifier_tailcall_jit.c         | 74 +++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
index 48fa34d2959f..7655742f627b 100644
--- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
+++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
@@ -91,6 +91,80 @@ __jited("	popq	%rax")
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
+/* Address materialization differs between PCREL and non-PCREL kernels.
+ * Skip the address generation sequence and verify only that the call
+ * target is loaded into CTR before branching.
+ */
+__jited("...")
+__jited("...")
+__jited("...")
+__jited("...")
+__jited("...")
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
2.54.0

