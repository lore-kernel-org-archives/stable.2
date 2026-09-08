Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EF447A867;
	Tue,  8 Sep 2026 08:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788856547; cv=none; b=gE3ejT2opSIOk1XJ64+PxEmk51xjMMGKHaiOKbc5c1ANSiC4KKZMq19ckDzkxanPbbV422cjNQlLk2CZJJS/bcmPW11AHH4+wRfZAqxGUxpIOmjPW44Z/5FjgfeRsxeNMqaojdxqDkMhTbXZ0VvoJiT1JCjPVPlEXJvhyUf2VUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788856547; c=relaxed/simple;
	bh=tUGnQ6aKSBWyts8Xz2amxkWEBAzb/ijgQDfaWdgvmPc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=o9uBHKiyFyip/ssyx3gevamwwO4Yajb1OAzFiLYjpSeFhyiTnW41tUSpQpjUBfd83dmHBleVatdYWmXpxYz8xeqb2qQ0RbbPHBEbhytsbxDKm0vlhhY6exVptSDsar2KGTip9xxwalHlPmTGuiFb4OvjBG5+wWTs0sL90FuBRk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RdmTUKr7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RdmTUKr7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6886VxQt059989;
	Tue, 8 Sep 2026 08:35:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=R8bURA
	xOxYBXtW39WB07zwIYo9/CRyZmP50yeNmeuPg=; b=RdmTUKr71t0YIdrLaymnpb
	sclqdzdEKlAUh+X9Ej6Jh1rBh66GbqKjugfdI0pUHq5ZaitdLLAIbRPcYAJ7Z0pW
	CXtz9RVtHV64wu3YwobqupzIVjd7MXlc1MKvHBaPu4QR+Ml2ObL0hdoJ/lh6NxsJ
	lmC/JX4p1tIF29WpIiuCuAd8sNAEP9hHaWHuqkf12sLDMJ/R6H503krg2a9/WPjV
	8Z++dCrZD6ydC9qorAqOZwg41c8O8up+I1Aqg5CpgQZceDjeKy7YDrz0rEPNZ47S
	PxUHbt8cTmsUQiQMAYsSZRjVNzzA/kPw1aqY6Vm0JSlziSFtRhBYu7Hwq6b5nXkQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ggbhknnn8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:35:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6888QGFb004841;
	Tue, 8 Sep 2026 08:35:22 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gh03yaend-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 08 Sep 2026 08:35:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6888ZI4p43581720
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 8 Sep 2026 08:35:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63C3C20043;
	Tue,  8 Sep 2026 08:35:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0188920040;
	Tue,  8 Sep 2026 08:35:15 +0000 (GMT)
Received: from [9.123.3.64] (unknown [9.123.3.64])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  8 Sep 2026 08:35:14 +0000 (GMT)
Message-ID: <f1a0395d-f9ab-4637-8da7-87c91fa9a9aa@linux.ibm.com>
Date: Tue, 8 Sep 2026 14:05:14 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v13 4/8] powerpc/bpf: fix alignment of long branch
 trampoline address
From: Hari Bathini <hbathini@linux.ibm.com>
To: bot+bpf-ci@kernel.org, skb99@linux.ibm.com, bpf@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org
Cc: maddy@linux.ibm.com, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, stable@vger.kernel.org,
        venkat88@linux.ibm.com, yeswanth@linux.ibm.com, martin.lau@kernel.org,
        eddyz87@gmail.com, yonghong.song@linux.dev, mason@kernel.org,
        ihor.solodrai@linux.dev
References: <0700c866205c8fa2f861e4b8d64fdf7469cba021.1788154635.git.skb99@linux.ibm.com>
 <71916017b03ad6e22c093094acae6a356a57f8fd0c3afda3833a20a2db10ec77@mail.kernel.org>
 <f8439dfb-7584-45c4-90fa-5659fa5507e2@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <f8439dfb-7584-45c4-90fa-5659fa5507e2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA4OSBTYWx0ZWRfX7RgwKRe0KiIo
 ibiLK/gpURNPEHDEBuwSYFEyGvb80iMm4KvXpOEbRVPFLZROqjh6jOPW5bLYzK0cpkBTwQ4uUfM
 dlVU5punrNavA0S70xPJBWrBZwygRX0=
X-Proofpoint-ORIG-GUID: 5xzRqCDWWilm15zElExfiwfJhukAhYQC
X-Authority-Analysis: v=2.4 cv=NMDlPU6g c=1 sm=1 tr=0 ts=6a9fc8cb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QQXBir-yANtSgwdbjgUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA4OSBTYWx0ZWRfX0f3PTBi14eQa
 VU3wxCHUNh5706uaT9/wrXZJ1wp7dC8k+WJHteoQ1MGLTbX8fsGe1WqJPFjZHnH+PNIZ2AcG1qZ
 kibKl8C6iLMNwuhs3M5hIDel0tb0p3qjbaJvLBdp3jEjCRTFbZVD26Lm7NeuLfeT792K9p9fkwE
 rLbckCRzc2Sgc4T2fdePBx2/DDocRtL74f2mx+vQghLGcXL7oxZeIJeIpPXYx91ZyCytwasqWSP
 qg7UH5pqSocPOxtrxiC+Y7rkp+GDRAYZJgQQyuZjOaLVCyKeS00DC3IQ+GoqSf4x6cFomwhdjP1
 +wEnfL0x0NTqrMLlczZtNxkn6mptbSa2bVd7piZl2+9FnQGHdzouL3fSlHhUXIlwa1WZk24H9F4
 K8z/fLyyYv7tL8n10YRKgjF5eGY8NltB2L0KqJRTscKbGKFL1azfZ6lx/XzBqDYqeJ1GA973N9Y
 iWsqWJFaIKBIgqPTJ3g==
X-Proofpoint-GUID: hrqhaITNcNLOgiTF-SKkG_GGyYjWC3dW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_01,2026-09-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0
 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080089



On 08/09/26 1:53 pm, Hari Bathini wrote:
> 
> 
> On 31/08/26 1:42 pm, bot+bpf-ci@kernel.org wrote:
>>> diff --git a/arch/powerpc/net/bpf_jit_comp.c b/arch/powerpc/net/ 
>>> bpf_jit_comp.c
>>> index 11981d2270a9d..8ca36a933c7ae 100644
>>> --- a/arch/powerpc/net/bpf_jit_comp.c
>>> +++ b/arch/powerpc/net/bpf_jit_comp.c
>>
>> [ ... ]
>>
>>> @@ -49,11 +49,35 @@ asm (
>>>   "    .popsection                ;"
>>>   );
>>>
>>> -void bpf_jit_build_fentry_stubs(u32 *image, struct codegen_context 
>>> *ctx)
>>> +void bpf_jit_build_fentry_stubs(u32 *image, u32 *fimage, struct 
>>> codegen_context *ctx)
>>>   {
>>>       int ool_stub_idx, long_branch_stub_idx;
>>> +    int ool_stub_sz;
>>>
>>>       /*
>>> +     * Align the mis-aligned dummy_tramp_addr field in the fimage.
>>> +     * The alignment NOP must appear before OOL stub, to make
>>> +     * ool_stub_idx & long_branch_stub_idx constant from end.
>>> +     *
>>> +     * The fimage can be non 8-byte aligned, so final alignment depends
>>> +     * on start of fimage and the stub's instruction count offset. The
>>> +     * OOL stub size is 4 instructions (with 
>>> CONFIG_PPC_FTRACE_OUT_OF_LINE)
>>> +     * or 3 instructions (without) before dummy_tramp_addr.
>>> +     *
>>> +     * Emit a NOP here if address is not SZL aligned.
>>> +     *
>>> +     * In pass=0 when image==NULL, conservatively account for space
>>> +     * required to accommodate alignment NOP. In case final pass skips
>>> +     * emitting alignment NOP, the image buffer have 4 spare bytes and
>>> +     * jited_len signifies correct program size.
>>> +     */
>>> +
>>> +    ool_stub_sz = IS_ENABLED(CONFIG_PPC_FTRACE_OUT_OF_LINE) ? 16 : 12;
>>> +    if (!image || !IS_ALIGNED((unsigned long)fimage + ctx->idx*4 + 
>>> ool_stub_sz, SZL))
>>> +        EMIT(PPC_RAW_NOP());
>>
>> Can the conditional alignment NOP here mask program length convergence?
>>
>> The preceding commit (5175364d6174 "powerpc/bpf: fix buffer overflow in
>> JIT for large BPF programs") added a convergence check:
>>
>>      if (pass >= CODEGEN_MIN_PASSES && proglen == prev_proglen)
>>          break;
>>
>> to bpf_int_jit_compile(). But the alignment decision above forces the
>> stub block to end at a fixed residue mod 8: the field address (fimage +
>> ctx->idx*4 + ool_stub_sz) is aligned to SZL, and exactly SZL/4 + 7
>> instructions follow it. So fimage + proglen is congruent to a constant
>> mod 8 every pass, meaning proglen can only change in multiples of 8.
>>
>> When the body shrinks by an odd multiple of 4 bytes between passes, the
>> NOP can absorb it and keep proglen unchanged. The body can shrink when
>> an exit goes from out-of-range (emitting a full epilogue) to in-range
>> (emitting a single branch):
>>
>> arch/powerpc/net/bpf_jit_comp.c:bpf_jit_emit_exit_insn() {
>>      if (exit_addr && is_offset_in_branch_range(...)) {
>>          PPC_JMP(exit_addr);                    // 1 instruction
>>      } else {
>>          ...
>>          bpf_jit_build_epilogue(image, fimage, ctx);  // N instructions
>>      }
>> }
>>
>> The shrink is (N-1)*4 bytes. When N-1 is odd, this is 4 mod 8. The NOP
>> appearance or disappearance compensates, making proglen identical across
>> passes even though addrs[] shifted.
>>
>> Because forward branches use addrs[] from the previous pass (addrs[j]
>> for target j > current i is computed in the prior pass), those branches
>> would land (N-1)*4 bytes past the intended target.
>>
>> The comment at arch/powerpc/net/bpf_jit.h:132-138 documents that the
>> PowerPC JIT avoids pass-to-pass size changes by padding the short branch
>> case with a NOP, specifically to prevent this scenario. Does 
>> reintroducing
>> an address-dependent, pass-varying size risk incorrect branches?
>>
>> (Note: commit 0cd8bd7da278 later in this series reworks the stub layout
>> and is described as a layout improvement rather than a fix for this 
>> commit,
>> which may provide additional context.)
>>
> The review correctly identifies a potential mechanism by which a 4-byte
> alignment NOP could mask a size change. However, that mechanism only
> causes a convergence failure if the total code-size reduction between
> passes is exactly compensated by the NOP (i.e. effectively only 4
> bytes). In this JIT, changing an exit from the inline epilogue to a
> branch removes the entire epilogue, so the size reduction is much
> larger than 4 bytes. The NOP can only compensate for 4 bytes; it
> cannot hide the remaining reduction. Therefore the proposed
> convergence failure does not apply to this code.
With the above said:

Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
