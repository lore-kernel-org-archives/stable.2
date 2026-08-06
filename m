Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B1C341ABB;
	Thu,  6 Aug 2026 17:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786036801; cv=none; b=bsMB4/K4K8uwpXWtmNAkdqK2c1xm6uO0tGjrj78oayGDF4LZhue9r7EoU3J91wmHTQK2iVSRRtNHbv9ZxxVgqGPgPkrRp/4RkGzhLO2P/6WoRRshdRFC/vSJcmhb51POJs4vpDq5BM/hPScQD+A6fgxCN6WQ9EA4Qkq2+WyUvDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786036801; c=relaxed/simple;
	bh=rZWBnLaMuc9+mG6QOYC1Q7sGZNLcMekJX97iV5tKyno=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nncejjt/wypT0+pog0ljNusqBQd1+Ilrz1H16PzySklO5RLUbVwyRKrSJEgw2O9Kt6g4GxLruOFd2CvWj4Y4veUkg71k4qgjb+u0kispFVeKJojV8aWJOteu8DxiQITcM/myK4nKkQM51NgjbNOUF5IgzR6VFnxkmyVaDVAtMHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P8JeRFbO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P8JeRFbO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676HIZCk3193566;
	Thu, 6 Aug 2026 17:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wq8W6B
	EO2RhzpjAxxvkJJwPw5p2vYzFNkjAvDVACMJ8=; b=P8JeRFbOW6gnF53uN9Y6g4
	B1elI5UsHxPxVt6DW4mhCerJoRCN0o8/ihRJx0BVArX+r95plRw2YBUkds1+W+Ao
	DmicjjjJkRZ/+JXDf8+VJbeTGCa1P50u54PAVuUXILtGlbDWho9xdGLvnE4vZl47
	cNNl95FB/TbQJ/BOIy6ET3uBbf+hxkaVZaZkD+MKAZxac3xQaRVs3r/VuKrH7r26
	j1A2B0gWTPOcPQe6TjVPVGZ3UyXOohCbhYmD9UKdvfHbr/BEt90R0O1FiaPHTLJI
	mNTmLzhefo3b9UP3D8/7d3JfsbMonbZR/j3kaz5b0JdCFLFk1N2uQ5Cn4zwleG1g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs77gh0tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:19:39 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676HBGGf021561;
	Thu, 6 Aug 2026 17:19:39 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kc5yk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 17:19:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676HJZc37209438
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 17:19:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB8D620043;
	Thu,  6 Aug 2026 17:19:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B7B0D20040;
	Thu,  6 Aug 2026 17:19:31 +0000 (GMT)
Received: from [9.124.215.184] (unknown [9.124.215.184])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 17:19:31 +0000 (GMT)
Message-ID: <e867421c-3700-451d-911e-b5eb235fae94@linux.ibm.com>
Date: Thu, 6 Aug 2026 22:49:30 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/8] selftest/bpf: Fixing powerpc JIT disassembly
 failure
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1785906979.git.skb99@linux.ibm.com>
 <8b7bde664004feb383741b8807a561dba601285c.1785906979.git.skb99@linux.ibm.com>
Content-Language: en-US
From: Hari Bathini <hbathini@linux.ibm.com>
In-Reply-To: <8b7bde664004feb383741b8807a561dba601285c.1785906979.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfXxYAyzn4eAZfd
 KB2+FXOSoY5UJQ/CNdtAaPn2gMYdkNxBp/jY6dsxI50jP9/8RJwm/jsyRJLZhqTjG3zzLa8rfX4
 2Z10dxqHK75RthMvK0RXNWImLSOqPiHyYhK+7g5s2xPSZPxtxkuch7yxT/XAiHsu5OUeFqyfoGd
 xuuxLPp9+qa8+iuBTd6cuauOpCpo2pD5zMSsyKvncPtDIa9Dhm9HgWSnhxc+JMbj5Qv3BubVy0s
 Lqr6Opn48w5Z32JsFAvOrQDVLh8Hf4/bD6jFQ/21eaImRP4p4rzrmDU3JuGA8d4B/n1HEd2YIA0
 m9J9zcql7xGRxFZj47AW8qdpkEmx6KdKPYZbk4BW3sr172vCLW86QsRrQfBBkf2LfHI9AeKWeLl
 JLax87RjHeLKCZ0uRg8CEn4+8eIQU8mCr3mF58pJOKFySySThR8XMW0RXpTGqmbywkO8nODSNi0
 Ap5T4P65ZU21JLif22g==
X-Authority-Analysis: v=2.4 cv=WIFPmHsR c=1 sm=1 tr=0 ts=6a74c22b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=oud3N2J-nQTbalGW6a8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: D7efxdHpJmhYVye2F2GyC29HNYoMaCi-
X-Proofpoint-ORIG-GUID: D7efxdHpJmhYVye2F2GyC29HNYoMaCi-
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEzNSBTYWx0ZWRfX07J7cksE+5fv
 6Ic2pqaxLEv27cT5E+HXATYPo05O8Cb50Cn4EQc8sqiVX9jSzTCtVK3QQr3BVCeJR1nXUHoV1FM
 fHK/NNCmwiJStW90oIxgvjkALOehQCU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 phishscore=0 malwarescore=0
 suspectscore=0 clxscore=1011 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060135



On 05/08/26 11:36 am, Saket Kumar Bhaskar wrote:
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
> Fixes: b991fc520700 ("selftests/bpf: utility function to get program disassembly after jit")

The fixes tag on this patch doesn't really help. Please drop it.

> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> ---
>   .../selftests/bpf/jit_disasm_helpers.c        | 25 ++++++++++++++++++-
>   1 file changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/bpf/jit_disasm_helpers.c b/tools/testing/selftests/bpf/jit_disasm_helpers.c
> index 3558fe10e28c..c4aa1d69d3bb 100644
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
> +
>   		fprintf(text_out, "func #%d:\n", i);
> -		disasm_one_func(text_out, image + pc, func_lens[i]);
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

- Hari
