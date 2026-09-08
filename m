Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 846DB580399;
	Tue,  8 Sep 2026 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885092; cv=none; b=pllYmvOoZiazibnJlx90LCD7iBGhUC81hxOkb1Q++iLRCpMf8SsmUZp9h/SDunkw78bOhe8R1hjfSH62qSBRhHorwwpc07ElRlWBTaa+ITN/J6dkA2v9CtFogVdIyRsbgBMfbX2QDK0SOhp4Dj+M336/YNWt+6YhyFuyDPbQPAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885092; c=relaxed/simple;
	bh=8+wFgoFbhl9/+uf44Nqcf8SDWohXgUnCXu65Lfx4F1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWKLp3Wko45wPjJcAP8UFGBlwpmimM5bU5eF9QFiiqpzjK9xozPmHzzmngH7F0kqTcf2/fmedMSDhg7J56zbI736eoWWe+aOiXKLw0TZR8ZmEPKQBX9HVowzY+sPMc/PnPffDMLnsFC7BwGfgpv3RltExGb4RMB1kcBtHgjQ0L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FT9xMuEJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FT9xMuEJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 688F1fEM1228032;
	Tue, 8 Sep 2026 16:31:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HfZlRn
	yze2Gd+l/Im88GZ93+4bkg8NTtDcScipwexiw=; b=FT9xMuEJ/t9PiztaacoIuP
	d9YiNx+uT2Zz9IfVUdCsSAJ26256pd4NV21GOBvhsGgLnc44JDstEIv6afMVp450
	Nr1EcIjrXCCxT5Z7O7LpyqZ48WgUFtsyFWaep/1Lx/Nzv74qGiUj7ipSQzPL0Tpe
	VwXwFTpC0WbTlDY6NAP+J/LEthZ2jEMpm/tRPTFcAJFLC4IrlzwTOwYWz5HRz0nF
	c8ZOG2M0lxcY1uFWkKKqQoHQakUhmY3x1k9Rf2InMYmkN+qgP1luPM0ZGVvxDLda
	hfpUUz6dTU41vAydILS/gqw3P9Suj+UuoKQ+cf9BxtPJuAAqPJwNxsJ97WFCQfTA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhkreva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:31:07 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 688GQEd1031283;
	Tue, 8 Sep 2026 16:31:06 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ggwsw55w3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 16:31:06 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 688GV2Vk45810036
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 16:31:02 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 74F3F20040;
	Tue,  8 Sep 2026 16:31:02 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E08F420043;
	Tue,  8 Sep 2026 16:30:56 +0000 (GMT)
Received: from [9.61.253.97] (unknown [9.61.253.97])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  8 Sep 2026 16:30:56 +0000 (GMT)
Message-ID: <c630046e-f79a-49c7-ae5b-7bcc825d9e5f@linux.ibm.com>
Date: Tue, 8 Sep 2026 22:00:53 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 1/8] powerpc64/bpf: fix compare instruction emitted
 for tailcall
To: Saket Kumar Bhaskar <skb99@linux.ibm.com>, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: hbathini@linux.ibm.com, maddy@linux.ibm.com, ast@kernel.org,
        andrii@kernel.org, daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com
References: <cover.1788154635.git.skb99@linux.ibm.com>
 <961601491716ef9e00f79e3aa9f7f4ef4440d4d3.1788154635.git.skb99@linux.ibm.com>
Content-Language: en-US
From: R Nageswara Sastry <rnsastry@linux.ibm.com>
In-Reply-To: <961601491716ef9e00f79e3aa9f7f4ef4440d4d3.1788154635.git.skb99@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfXyMnXzDj4qXZa
 gkA2BWYSHd0oWFW/zfftXe5F7/IULXObs3XtV0fjAjWZgCRThHwK9afNoW4/1XvehTfL9FMciXB
 cJSCa0b4KYeBFi87U0DkOm38JoemJMM=
X-Proofpoint-ORIG-GUID: jeT8GDlRC3BRQtOiazHGOYPVHTumcITw
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6aa0384b cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=jjcdjwgKS-9vtqCthAsA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3OCBTYWx0ZWRfX8VgcQHpIcy17
 P6cSNK6StpvVocHFqiTiAFkWtV4vJjtegg/7L5aOSutt6o9ighIwsHW236XNgWRvJ90MhV/OeAV
 uRHl/BCyyvDDjXfi47MV4h7Qm9N67CURQ3lKw46xlH8wDLFFAy81CEelDIpmMwMFTrigmIewMbf
 WiZCaFyRyVVoYbZtiOsoFZ+Kxo2hC8A+a6yiiA2lavab/QOLIu59WfijxApBVlZKjHNogKwtaR+
 +OJZnU1PlfNtL/e+Qa1pxnST5vkUX0xrXhOSgWiINZHdA0J5jVHB0Npr+Iq39bdjPgwu2MC0npO
 u/H0cf3TOXP2ugXUMhzKtsPVrSqujA/TpAYwnjae/yh3o2CMj0YabsW6tNlXyMvRlZhDSCJU/Nw
 hI0dqldgUlHyVvRqrI4TaUE9Idij31r0BajX2SZoal8JQzxN32Lsl44RGdQ3C/0LbqlCEImRKwA
 jAyJpYMU6RRWtDAzOMw==
X-Proofpoint-GUID: jeT8GDlRC3BRQtOiazHGOYPVHTumcITw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1011 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080178


On 31.08.2026 12:45 PM, Saket Kumar Bhaskar wrote:
> From: Abhishek Dubey <adubey@linux.ibm.com>
>
> The tail_call_info field can contain either a scalar counter
> value or a 64-bit pointer to the counter, using a 32-bit
> compare (cmplwi) only checks the lower 32 bits, which can lead
> to incorrect comparisions when location of counter is near 4GB
> boundary. Use instruction cmpldi/cmplwi for accurate comparision
> in corresponding cases.
>
> Reported-by: sashiko-bot@kernel.org
> Closes: https://lore.kernel.org/bpf/20260517191450.85AE6C2BCB8@smtp.kernel.org/
> Fixes: 2ed2d8f6fb38 ("powerpc64/bpf: Support tailcalls with subprogs")
> Signed-off-by: Abhishek Dubey <adubey@linux.ibm.com>
> Signed-off-by: Saket Kumar Bhaskar <skb99@linux.ibm.com>
> Tested-by: Yeswanth Krishna Tellakula <yeswanth@linux.ibm.com>
> Acked-by: Hari Bathini <hbathini@linux.ibm.com>
Tested-by: R Nageswara Sastry <rnsastry@linux.ibm.com>

System: ppc64le LPAR (IBM POWER), Linux 7.3-rc2
> ---
>   arch/powerpc/net/bpf_jit.h        | 6 ++++++
>   arch/powerpc/net/bpf_jit_comp.c   | 2 +-
>   arch/powerpc/net/bpf_jit_comp64.c | 8 ++++----
>   3 files changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/arch/powerpc/net/bpf_jit.h b/arch/powerpc/net/bpf_jit.h
> index f32de8704d4d..35015d7ecb76 100644
> --- a/arch/powerpc/net/bpf_jit.h
> +++ b/arch/powerpc/net/bpf_jit.h
> @@ -188,6 +188,12 @@ struct codegen_context {
>   
>   #define bpf_to_ppc(r)	(ctx->b2p[r])
>   
> +#ifdef CONFIG_PPC64
> +#define PPC_RAW_CMPLLI(a, i)    PPC_RAW_CMPLDI(a, i)
> +#else
> +#define PPC_RAW_CMPLLI(a, i)    PPC_RAW_CMPLWI(a, i)
> +#endif
> +
>   #ifdef CONFIG_PPC32
>   #define BPF_FIXUP_LEN	3 /* Three instructions => 12 bytes */
>   #else
> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/bpf_jit_comp.c
> index 7b07b43575f1..a875521ff904 100644
> --- a/arch/powerpc/net/bpf_jit_comp.c
> +++ b/arch/powerpc/net/bpf_jit_comp.c
> @@ -739,7 +739,7 @@ static void bpf_trampoline_setup_tail_call_info(u32 *image, struct codegen_conte
>   		 * Setting the tail_call_info in trampoline's frame
>   		 * depending on if previous frame had value or reference.
>   		 */
> -		EMIT(PPC_RAW_CMPLWI(_R3, MAX_TAIL_CALL_CNT));
> +		EMIT(PPC_RAW_CMPLLI(_R3, MAX_TAIL_CALL_CNT));
>   		PPC_BCC_CONST_SHORT(COND_GT, 8);
>   		EMIT(PPC_RAW_ADDI(_R3, _R4, -BPF_PPC_TAILCALL));
>   
> diff --git a/arch/powerpc/net/bpf_jit_comp64.c b/arch/powerpc/net/bpf_jit_comp64.c
> index dab106cae22b..59302cabc466 100644
> --- a/arch/powerpc/net/bpf_jit_comp64.c
> +++ b/arch/powerpc/net/bpf_jit_comp64.c
> @@ -276,7 +276,7 @@ void bpf_jit_build_prologue(u32 *image, struct codegen_context *ctx)
>   		 */
>   		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, 0));
>   		EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2), -(BPF_PPC_TAILCALL)));
> -		EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
> +		EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>   		PPC_BCC_CONST_SHORT(COND_GT, 8);
>   		EMIT(PPC_RAW_ADDI(bpf_to_ppc(TMP_REG_1), bpf_to_ppc(TMP_REG_2),
>   								-(BPF_PPC_TAILCALL)));
> @@ -662,7 +662,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	PPC_BCC_SHORT(COND_GE, out);
>   
>   	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_1), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
> -	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>   	PPC_BCC_CONST_SHORT(COND_LE, 8);
>   
>   	/* dereference TMP_REG_1 */
> @@ -672,7 +672,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	 * if (tail_call_info == MAX_TAIL_CALL_CNT)
>   	 *   goto out;
>   	 */
> -	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_1), MAX_TAIL_CALL_CNT));
>   	PPC_BCC_SHORT(COND_EQ, out);
>   
>   	/*
> @@ -707,7 +707,7 @@ static int bpf_jit_emit_tail_call(u32 *image, struct codegen_context *ctx, u32 o
>   	 * tail_call_info.
>   	 */
>   	EMIT(PPC_RAW_LD(bpf_to_ppc(TMP_REG_2), _R1, bpf_jit_stack_tailcallinfo_offset(ctx)));
> -	EMIT(PPC_RAW_CMPLWI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
> +	EMIT(PPC_RAW_CMPLDI(bpf_to_ppc(TMP_REG_2), MAX_TAIL_CALL_CNT));
>   	PPC_BCC_CONST_SHORT(COND_GT, 8);
>   
>   	/* First get address of tail_call_info */

-- 
Thanks and Regards
R.Nageswara Sastry

