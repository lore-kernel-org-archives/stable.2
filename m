Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE515293FC;
	Tue,  8 Sep 2026 16:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885267; cv=none; b=muSiJhLqR1usOHpc4ZFRpRIOZv6XhIw21hwCd/pN9GxLIs6kOWALYX8D1ugRgciK6K5YW9fsD4NBnR3aP77dpwsxmBH+txbsw7t25ol7OvS1yWCUXYtvTM/c0i/nQ3HlYDkQZ+6VvzRSHgmyJPszkWEXM/lbPA8vpN1/ncNoaiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885267; c=relaxed/simple;
	bh=0A2DB+h2myMPbc1b7+haoWdeKNoxrVFL1lo8/WicaVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Lh+9UgfXbng9SEnEtKF7Is2YXuSyKZxcWa+dWUv/opTx4XLd1GrkE3wtBiDVoqJyMN2tAutANpBhwgszlLF24G/TCXRkeXKY0BgGYFqvUE9MINtZQwEfYq3Kxq55KGG9CiO/dx8xj3Nbu18FnEoIWUTh2gC8i6pOhnnXJCytyCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KbFf/uGQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KbFf/uGQ"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1imV3545327;
	Tue, 8 Sep 2026 16:34:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Dus/iw
	UPbGNHX/3+OvuB+79Dq3Pt2DPRdDIagViEDD8=; b=KbFf/uGQ4p0YYY06y0soHW
	KkMuFLGlPoa+qMn7oz+iXMSOonxycxTTtkgfevqepdiz6Lsm7UY5IZeQc74Edamt
	+0RYHST+Rq4zDgAbDKha2Oc7a2kwOwpbQWd71epAM8BEG7Stpg6i3iessyF9CXq0
	WP9xhsTjNXGJMnubVEB8U5ha/QffuYb7MlLIZmC0e927dTjSebgLN2MCaXAv2Hit
	QTtcaqrEfXooy7FPi/QkT0IYBWF6oScJWRzAIbzRMCjotndlFffFYlm1YKCJoz65
	FbLnIfDOznoRQrAQOGSZYzYz9c9ADbuvAI5DCWx1jb6iwXHI7+Zoe9hrKZI4bTUQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbqk0cyn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:34:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GUn4q012876;
	Tue, 8 Sep 2026 16:34:05 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggxdjw38r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:34:05 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688GY1X846858560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 16:34:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5FBC20043;
	Tue,  8 Sep 2026 16:34:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A194D20040;
	Tue,  8 Sep 2026 16:33:55 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 16:33:55 +0000 (GMT)
Message-ID: <8a8fdd2d-b29b-4aa2-b9eb-66fd10bd476c@linux.ibm.com>
Date: Tue, 8 Sep 2026 22:03:52 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 8/8] selftests/bpf: Add tailcall verifier selftest for
 powerpc64
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <b11a7ad9ecf1dd7f6524067f061b4f7dabeff1d9.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <b11a7ad9ecf1dd7f6524067f061b4f7dabeff1d9.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Yf6a0WeLqNgGDzkSi7S5VPgr6VHdyJb_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX3A2BWzidwS+n
 fK0l6FWvzXAszdCA50cahnk7DLLe94Qq226UjaWoLPdyWvMNv3Trc6eSKBm9iX6fCqIHDVrFTF/
 UD4pzxHVMCE7dNYRyPIN6IRgVU3RBZo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX5keBCtbAuH/e
 WMDnfAZ7Avd2I+TLZtNyfFvCsPNJ9KKdRKB2DLCY4TpQfL7pcCgnF/R1IoCeSwV2ZEjUAuLT2nk
 EuB4VLQgiV+Cvty94l9+65g5pZmw8kZ9CqD3rLhZ8UdWNaB+qb9QH5d+ffd5qDcM2IXi4fdL4NL
 jWgipiJorb4hBD49vx5g/C4S+C/f616G48uq3vjNnz34fKcHWuL0NRVn3wt/jecX69pggOSbVdm
 JlT4I7XubWNRqWTNg/ICaPWDQvOEH0fWQ7ftjnmXnFWFuvK9Gkhpwd3yHj2uuAgXIF2YfnQU7tB
 dBLT+yGNxEpnjW5K7qLvGJOgdlRViyeCWuDrf8nja8nfGd6VafHH5ckV/1lpNf+qvCHdbHKT7R2
 +Wr+Cg6REiqdkU1UCQPCa1IHBqu34iangft9DompMmhHv5QhnFlOfcHtAVNYGjFC9ddoWgrPVLj
 H8/0E/3FGiS3WVp4v3g==
X-Authority-Analysis: v=2.4 cv=JaKMa0KV c=1 sm=1 tr=0 ts=6aa038ff cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=fFdEStb9C0Pfc0vgUyYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: Yf6a0WeLqNgGDzkSi7S5VPgr6VHdyJb_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178


On 31.08.2026 12:46 PM, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
>
> Verifier testcase result for tailcalls:
>
> # ./test_progs -t verifier_tailcall
>
> #618/1   verifier_tailcall/invalid map type for tail call:OK
>
> #618/2   verifier_tailcall/invalid map type for tail call @unpriv:OK
>
> #618     verifier_tailcall:OK
>
> #619/1   verifier_tailcall_jit/main:OK
>
> #619     verifier_tailcall_jit:OK
>
> Summary: 2/3 PASSED, 0 SKIPPED, 0 FAILED
>
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   .../bpf/progs/verifier_tailcall_jit.c         | 78 +++++++++++++++++++
>   1 file changed, 78 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> index 48fa34d2959f..9880ce4f1931 100644
> --- a/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> +++ b/tools/testing/selftests/bpf/progs/verifier_tailcall_jit.c
> @@ -91,6 +91,84 @@ __jited("	popq	%rax")
>   __jited("	jmp	{{.*}}")		/* jump to tail call tgt   */
>   __jited("L0:	leave")
>   __jited("	{{(retq|jmp	0x)}}")		/* return or jump to rethunk */
> +__arch_powerpc64
> +/* program entry for main(), regular function prologue */
> +__jited("	nop")
> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
> +__jited("	li 9, 0")
> +__jited("	std 9, -8(1)")
> +__jited("	mflr 0")
> +__jited("	std 0, 16(1)")
> +__jited("	stdu 1, {{.*}}(1)")
> +/*
> + * load address and call sub() via count register
> + *
> + * Address materialization differs between PCREL and non-PCREL kernels.
> + * Skip the address generation sequence and verify only that the call
> + * target is loaded into CTR before branching.
> + */
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("...")
> +__jited("	mtctr {{.*}}")
> +__jited("...")
> +__jited("	bctrl")
> +__jited("	mr	8, 3")
> +__jited("	li 8, 0")
> +__jited("	addi 1, 1, {{.*}}")
> +__jited("	ld 0, 16(1)")
> +__jited("	mtlr 0")
> +__jited("	mr	3, 8")
> +__jited("	blr")
> +__jited("...")
> +__jited("func #1")
> +/* subprogram entry for sub() */
> +__jited("	nop")
> +__jited("...")                          /* ld 2, 16(13) absent with CONFIG_PPC_KERNEL_PCREL */
> +/* tail call prologue for subprogram */
> +__jited("	ld 10, 0(1)")
> +__jited("	ld 9, -8(10)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 9, 10, -8")
> +__jited("	std 9, -8(1)")
> +__jited("	lis {{.*}}, {{.*}}")
> +__jited("	sldi {{.*}}, {{.*}}, 32")
> +__jited("	oris {{.*}}, {{.*}}, {{.*}}")
> +__jited("	ori {{.*}}, {{.*}}, {{.*}}")
> +__jited("	li {{.*}}, 0")
> +__jited("	lwz 9, {{.*}}({{.*}})")
> +__jited("	slwi {{.*}}, {{.*}}, 0")
> +__jited("	cmplw	{{.*}}, 9")
> +__jited("	bf	0, {{.*}}")
> +/* bpf_tail_call implementation */
> +__jited("	ld 9, -8(1)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bf	{{.*}}, {{.*}}")
> +__jited("	ld 9, 0(9)")
> +__jited("	cmpldi	9, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 9, 9, 1")
> +__jited("	mulli 10, {{.*}}, 8")
> +__jited("	add 10, 10, {{.*}}")
> +__jited("	ld 10, {{.*}}(10)")
> +__jited("	cmpldi	10, 0")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	ld 10, {{.*}}(10)")
> +__jited("	addi 10, 10, {{.*}}")    /* offset depends on CONFIG_PPC_KERNEL_PCREL */
> +__jited("	mtctr 10")
> +__jited("	ld 10, -8(1)")
> +__jited("	cmpldi	10, 33")
> +__jited("	bt	{{.*}}, {{.*}}")
> +__jited("	addi 10, 1, -8")
> +__jited("	std 9, 0(10)")
> +__jited("	bctr")
> +__jited("	mr	3, 8")
> +__jited("	blr")
> +
>   SEC("tc")
>   __naked int main(void)
>   {

-- 
Thanks and Regards
R.Nageswara Sastry

