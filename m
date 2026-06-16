Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84B6367F3D;
	Tue, 16 Jun 2026 12:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781614162; cv=none; b=Y6vTv6BRKidOZkZcFA9GwUe1pkbXSd42fW9SJK/cm0vA9kZrRjaJXZqP3PEId/EPKKA38hVljCUka/xzQU1GfLGY9vts48hUUXGgnnrKtreDwh98KGizAFMmixZgVCR/doJzIjgzeKw8TyF/vVR7A+Jmzr2Yt3hPlpSw956reTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781614162; c=relaxed/simple;
	bh=mKAaenqSpoThJDUlINw9aNKRwG0YXvc/juvUZZcXW20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nGQJhoZRHG7O2YUXGNx6u6iXcmGW0/NRNiPaM6GnlgTDlxPNOmibbYuWZSrWnOIshFYGxwTTY37W3XcW/0tlX4c+8L+v7su15RgOZ7hSyyrva8vWs7qd37ZMshEqEiNeFNbeIc+axlGFGKY3u9K+52DnzAOIPpqZZIlaJEcLGGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ky2RaTgK; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ky2RaTgK"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65GAIY4X1156309;
	Tue, 16 Jun 2026 12:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aklu07BPS1piXeSso
	aOB53jGEe8EVF2hHvFhPPD91FI=; b=Ky2RaTgK8CtNvCXJ9BGPBIF3e95kAFazV
	1BFqI+D76RbuiYUD18RS5TDydi3BoHy7sEtchLDDoD3C5gLvkJnklfKFpdA34UeJ
	edy1eKo9lM84ubadX1FBy0iDPcaqY8JixEqE6mEMZ3d0QaFvJ7hbzKSFya1FFLVt
	2LIJE9VV/xncCpY6/0rppIeC5cV+qn3tgVBcy6wvltd5+VTe1Cueyb3yFtz7faZ/
	Ix0nJmudWkA6WlOGHZox/Ox5FdssVZFko8CeRz4V+mjIt3Ewyg1nJ0mzrASzwTC6
	y9gebiIsHtHDWkqHuJEr+3ZXa1dDrnH5j5tH7P5c4GHQ4s21v7kWQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1eg552y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:49:04 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65GCYcaL021713;
	Tue, 16 Jun 2026 12:49:04 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshww3f5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Jun 2026 12:49:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65GCn0L561342010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Jun 2026 12:49:00 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04EC32004B;
	Tue, 16 Jun 2026 12:49:00 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0552920040;
	Tue, 16 Jun 2026 12:48:58 +0000 (GMT)
Received: from ltcrain4-lp15.ltc.tadn.ibm.com (unknown [9.5.7.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 16 Jun 2026 12:48:57 +0000 (GMT)
From: adubey@linux.ibm.com
To: bpf@vger.kernel.org
Cc: hbathini@linux.ibm.com, linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com,
        ast@kernel.org, andrii@kernel.org, daniel@iogearbox.net,
        shuah@kernel.org, linux-kselftest@vger.kernel.org,
        stable@vger.kernel.org, Abhishek Dubey <adubey@linux.ibm.com>
Subject: [bpf v8 6/7] selftest/bpf: Add tailcall verifier selftest for powerpc64
Date: Tue, 16 Jun 2026 12:47:40 -0400
Message-ID: <20260616164741.32252-7-adubey@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfXzQL+GEHGJKgy
 h14ZNS2PyQ0BH2FVhlCK412dDvGxtAVpBviLP1Ntt7uh0JS7b9RMjPjp9e30NdQInT5ChfLEI7n
 Ry0RFMNAu0wwhhrwFUsMjK9PJnkbfRM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE2MDEzMCBTYWx0ZWRfXzKh3DyoQUoUY
 vs8FPXW0vd04dCQkrIpfHNMt8zyMiquvh3m4wTaWtZqSZmTsAjFp/Ui86k7rV41mVnNZaFRPj33
 n36dfl7SzawJsD7zb0eAbqkmN3cqV8RsdR3kXeF7ZXxESMcVjLgJh0DAVeooTz7+n186hm1Szg5
 4bISC4f5tncNrzEFA4s2gsxK1Uojmw3Yp3tyLxq9R3ESFPgX578fyAmdURNe24cXBxYF9ul1eeN
 uqQ+Wtif538+FEjK9WSaohrwVelBaYe3F78CBJSNdcxl3kYQoa5gbZrLQxkp8iL2FXRuHlDtdME
 i3/ixrUxhrO8lIJQXKHgyR1mGMS1U1+cMGLnj/FsDCMobNrrRiyyPhffsSc6MrK0o2nJkYcTrL8
 OFhvd7ZRkxMo8ldfVfPMfTLFbb5ZpK6Tt9gfhfegoQkDB5nHi9t7ZtOvrY0DXvgaZlzdtiPmmWO
 V0nCHgfDOF9Zb9/W8cg==
X-Proofpoint-GUID: bkT6mePiZ5yfzDtj4a-8KBBPI4eJ6fGN
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a314640 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=v_EuApQnFJK-j3Uko2UA:9
X-Proofpoint-ORIG-GUID: bkT6mePiZ5yfzDtj4a-8KBBPI4eJ6fGN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-16_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606160130

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

