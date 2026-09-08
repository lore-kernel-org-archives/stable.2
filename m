Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E865C584944;
	Tue,  8 Sep 2026 16:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885219; cv=none; b=SIRlE9THHIDIXAu6zf1qeKCKux3nx5+cAjiHRFPUTp7Z6Rzn9kJ6OIQkvp8fbI5HBruu0ofdSTMcvY2X0dQiGUWnOWBRrW5FGzSRi9sjXBa+dykc6amnKxU8yL/OOmUtmyqE3UerNIlum6OUtA+wi6kltOv2m6ijtsMq/8x6Yi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885219; c=relaxed/simple;
	bh=eXZm9UMGLWjpU5UOxf0lRTOdluSEUuqO/VzrnFVWtI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uvlS1e2QoM2I3MwdjNv2EdvfBtQtoIFA/KcJhGVjCR9PktmsUCNtjtpygtXs25YxlhK0qU/DTtm+3eU2ZSQQY8jCYuupoVLUQhGZHmtDtYqV3kyUAWfL2+FR9IW70saodjjn/zzE1VrwNRTXTCkbYh8UrFj8mraAPf/sKw5d/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f02g5x/K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f02g5x/K"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1ek1080692;
	Tue, 8 Sep 2026 16:33:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yC9WRO
	c5hKeZDWBapMIIHj+0R4ybqRQjVgDPeWwSkqQ=; b=f02g5x/KEiVHJksP37Zlly
	hAd9kb0pmyCe6/XMUbxRAlhBbkELzLYyPFtuDTMKypNTpKWTDrQ/Fqkw2/2PuWso
	3DavRhIMHqoXB9CRsJ2Rfl/6etEKz9F+mzgYlKbPPAPL706tHdREpbHcs62nUf8B
	5IJ8d5NbqR6GSoXr2zFxFxCN/nhOw0ex2fIuZxoCTJblN6oCjlVLrQHFvgJCRVnV
	Iobq9GfRoBt1KhZbeVjdTe8wNpunUiCmGbu5vbHPuGQ6DFDB6fNfKaNSr64Qzktu
	66bZ5o7DXJEVw2MgYVKktvfzkeGri9RC0ryQqaUmcuo+lPjfeebJe1SyFPUVzgBQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbjrr5e7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:33:18 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GQEQZ031291;
	Tue, 8 Sep 2026 16:33:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw56g7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:33:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688GXDFg43909500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 16:33:13 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7765820043;
	Tue,  8 Sep 2026 16:33:13 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ADFA2004B;
	Tue,  8 Sep 2026 16:33:08 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 16:33:07 +0000 (GMT)
Message-ID: <738ca597-abc4-4867-963f-ed1a55aa4a54@linux.ibm.com>
Date: Tue, 8 Sep 2026 22:03:04 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 6/8] selftests/bpf: Fix powerpc JIT disassembly
 failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <6034e8b7dc0c6954be35b6735a9b04b35903ed5f.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <6034e8b7dc0c6954be35b6735a9b04b35903ed5f.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E7T9Y6dl c=1 sm=1 tr=0 ts=6aa038ce cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=EX4WfZDNQFKdhq70EaoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX+azGlUoiqaGn
 BFB/WKFI+D1wYowYXu0RTl7uVA/nlcu/2/u93stWa6qaw0IYAQjTCQz0pVs2wEBtSU7Vaqmp2Ko
 nRCcgZ985TFs0fa1uBSb5uYn4rKFWe0=
X-Proofpoint-ORIG-GUID: 2CliXsQskbKrP9XBtDnZ-c4NweA505uY
X-Proofpoint-GUID: 2CliXsQskbKrP9XBtDnZ-c4NweA505uY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfXy4j+QQXc8O22
 hIYT/yEvD/gY/igpIsfKRNI6k+AOlPVFpPsJd+VrHWy+d5gceeZsXVJnoxulfx6pvSS9LWYcUkq
 iHmIBkZeCas5Qzolhndv7euyFGQyqpw4oSKX0guYIV9vQIKtHbkjkMUrenRA5OJsDzF8gRHTwwr
 GjLBTi7A9Yoo+swvWfFe/OfScnmRZhexna86sOvS8ZWTpA0UgkQLoktZYcBhDbkBxBcVZXjU1n2
 PBc/zTYXYTahnXVOzwNVBrcOEgHKCsrn2je5SASjJ8sdneE6k1zfSvvGtkHa1W7bmojFt2JKayD
 mp4Z9VD/Cg6IoZwHHwGPYF1HIb+AR5xxji0wvLvZV2wlfE1RtOwIBmTG84Ec4gd42euwcJT2Y/m
 8/e4JDim9dhe9+apu/VBL4lZmDYW09TFnX2oKVQYaRsHvff7CWlMKNuYtoYKKdIfMkiQvQaKHEQ
 FTDifjPBRDXL18ZilGw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178


On 31.08.2026 12:46 PM, Saket Kumar Bhaskar wrote:
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
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   .../selftests/bpf/jit_disasm_helpers.c        | 25 ++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
>
> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 3558fe10e28c..b291d934dd1a 100644
> --- a/tools/testing/selftests/bpf/jit_disasm_helpers.c
> +++ b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> @@ -179,9 +179,11 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
>   	struct bpf_prog_info info = {};
>   	__u32 info_len = sizeof(info);
>   	__u32 jited_funcs, len, pc;
> +	__u32 trunc_len = 0, disasm_len;
>   	__u32 *func_lens = NULL;
>   	FILE *text_out = NULL;
>   	uint8_t *image = NULL;
> +	char *triple = NULL;
>   	int i, err = 0;
>   
>   	if (!llvm_initialized) {
> @@ -225,9 +227,30 @@ int get_jited_program_text(int fd, char *text, size_t text_sz)
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
> +
> +		/*
> +		 * Disabled JIT have zero func_lens, hence underflow
> +		 */
> +		disasm_len = func_lens[i] > trunc_len ?
> +					func_lens[i] - trunc_len : 0;
> +		disasm_one_func(text_out, image + pc, disasm_len);
> +
>   		fprintf(text_out, "\n");
>   		pc += func_lens[i];
>   	}

-- 
Thanks and Regards
R.Nageswara Sastry

