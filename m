Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2D03E556D;
	Sat, 13 Jun 2026 12:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781354462; cv=none; b=Rkntj57FAmRGsXGEdkbc31ZGUC3UACyEU0mMStTRu1yMhkl58pagKgtGBLo0q5oWOwQ4y/JSIEeOs8ZMJQLIqhkQHkWIO3g01smLXKmMtF+dFSXsX+1Nh+3t8Cte7ke5ntrSe379hdcDod7OcBR8OCGPFPDvzSj8DsP8kxvZ/Sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781354462; c=relaxed/simple;
	bh=MDJZkNl2CWc4uEmLAEUNUhrrM3uOWPRwzpfLD8cZQGE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8cYN37+Yu47/7e56JVYevuLIA4WTADFjkaK2T4XC0q4BAM8Yx78xv6/er4bNroNe8xx7eQI2x4YrHk0BcVuEoSzdKgpZVOAJ9jGnX2ScT9OUN89SLCLVaTO2BoF+jCydNteA6aNkQghGIPl19X5BBWunS2i4Q94UWNbgUag3cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=m+DEG1AF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="m+DEG1AF"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65DBIlix652871;
	Sat, 13 Jun 2026 12:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ydvbqW
	5uF3cK4i0S+qx1mU4pZwT4vRnhnNMxCS69lQQ=; b=m+DEG1AFbq/gjxx69UREop
	Kly/NnYchj42VNAUkFYRlRcEA7l1qgs3Ego+yyYq0E2+xnkyw6X5jyLCvfkWq4gU
	t8TAPTpbQ3uubHpX85IvwChzKHtTLLWiuykWDIUaTjT04TrNPKbLX9R+TRH9p2Yq
	HRad1Nz5z1SmnjUvgV4Ti3sQve1ubEshvxPQVz2L0q1oAsY1i+jUYFHG7mmFixjH
	GMElCRHQ44C1o9lbM5bmYkWsYF0mst84s27bMHkbtQLCPGrbu6GgtUFloaHwxq3S
	EJ+xJED+NAipbFDG9fwrpblYwn0BBWvUJ4w2w1zBxNCSHSEtaU+8qntm0uFk63mg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1efrrj1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:40:43 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65DCYj3P023972;
	Sat, 13 Jun 2026 12:40:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eqe093xsw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 13 Jun 2026 12:40:42 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65DCedC029295078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Jun 2026 12:40:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4836F20043;
	Sat, 13 Jun 2026 12:40:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E485120040;
	Sat, 13 Jun 2026 12:40:36 +0000 (GMT)
Received: from [9.124.210.219] (unknown [9.124.210.219])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 13 Jun 2026 12:40:36 +0000 (GMT)
Message-ID: <734fe885-ccb1-43c9-b3e4-50615926258e@linux.ibm.com>
Date: Sat, 13 Jun 2026 18:10:35 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/7] selftest/bpf: Fixing powerpc JIT disassembly
 failure
To: adubey@linux.ibm.com, bpf@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org
References: <20260611153826.31187-1-adubey@linux.ibm.com>
 <20260611153826.31187-4-adubey@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <20260611153826.31187-4-adubey@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfX4lETkS3LTlzt
 SNSftstFikP0y8cPvD8ZOkUgBnKBKZiUR/n0t9urq+DRLS6w2t93a45Ek6tW2Ikksf//272dzbU
 XHiaoQF5e4ss1LN57tvVt3AiqRZkVdk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEzMDEyNSBTYWx0ZWRfXyFr4nekX5J2o
 hUKROVFEpTG25SI2h1ehgh8uRTkWEqw8qpCACc8SSiJxLHNBKUaKte84Ap5MlRTfLZmlklATtxh
 lbJHdE69BRQosbsFl6YN6BDV/57IyBTUIX4i5XBeHGqB4d3IkpLI9JnBywHx+l1mVkNdCcTCv3b
 VRK0m1+jSgPyFOSbTVkt41YZRyAyLwM0IbHxH24E/9PdSUAe+AJk+XyeGaeXHGTrYNEJRa9QG+/
 SEASWCEMxLGBLxDMgn8SgNv5xbkOOdzw5hQFxCDUlUISqzAOhlgWh3bErJQeFlBWckkj+hyl4Po
 uIAmXf8rQCksgG575vM1O5tIKI/dqbksmrvMrFtGn7VZ0V7wg/ZXWfzjb5vzOrqTx73b7Fpx889
 zPvTIEaOzO8lehb6JsZ7SczRF31i5/JZgU/5mUMi20KszVILXXECrt1p4nO4hVvbsp/3ePRnwjN
 0wYMlxoj2DQxr4Z4U5g==
X-Proofpoint-GUID: 6ag7rUaVKmdpp58bXaeb5slWYq0R6GsN
X-Authority-Analysis: v=2.4 cv=NuDhtcdJ c=1 sm=1 tr=0 ts=6a2d4fcb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=yb6hTpJXbLsbbwInLtMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 6ag7rUaVKmdpp58bXaeb5slWYq0R6GsN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-13_02,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 suspectscore=0 impostorscore=0 clxscore=1011
 phishscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606130125



On 11/06/26 9:08 pm, adubey@linux.ibm.com wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
> 
> Ensure that the trampoline stubs JITed at the tail of the
> epilogue do not expose the dummy trampoline address stored
> in the last 8 bytes(64-bit) and last 4 bytes(32-bit)
> to the disassembly flow. Prevent the disassembler from
> ingesting this memory address, as it may occasionally decode
> into a seemingly valid but incorrect instruction. Fix this
> issue by truncating the last 8/4 bytes from JITed buffers
> before supplying them for disassembly.
> 
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> ---
>   .../selftests/bpf/jit_disasm_helpers.c        | 21 ++++++++++++++++++-
>   1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 3558fe10e28c..759d6a86803c 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> @@ -179,9 +179,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>   	struct bpf_prog_info info = {};
>   	__u32 info_len = sizeof(info);
>   	__u32 jited_funcs, len, pc;
> +	__u32 trunc_len = 0;
>   	__u32 *func_lens = NULL;
>   	FILE *text_out = NULL;
>   	uint8_t *image = NULL;
> +	char *triple = NULL;
>   	int i, err = 0;
>   
>   	if (!llvm_initialized) {
> @@ -225,9 +227,26 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>   	if (!ASSERT_OK(err, "bpf_prog_get_info_by_fd #2"))
>   		goto out;
>   
> +	/*
> +	 * last 8 bytes contains dummy_trampoline address in JIT
> +	 * output on 64-bit and last 4 bytes on 32-bit powerpc,
> +	 * which can't disassemble to a valid instruction.
> +	 */
> +	triple = LLVMGetDefaultTargetTriple();
> +	if (triple) {
> +		if (strstr(triple, "powerpc64") || strstr(triple, "ppc64"))
> +			trunc_len = 8;
> +		else if (strstr(triple, "powerpc") || strstr(triple, "ppc"))
> +			trunc_len = 4;
> +		LLVMDisposeMessage(triple);
> +	}
> +
>   	for (pc = 0, i = 0; i < jited_funcs; ++i) {
>   		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);

> +		// Disabled JIT have zero func_lens, hence underflow
> +		__u32 disasm_len = func_lens[i] > trunc_len ?
> +					func_lens[i] - trunc_len : 0;

Following the traditional C style, declare the variable at the start
of the block and leave a blank line before the fprintf() statement.
Also, fix the comment style as noted by the bot.

> +		disasm_one_func(text_out, image + pc, disasm_len);
>   		fprintf(text_out, "\n");
>   		pc += func_lens[i];
>   	}

- Hari
