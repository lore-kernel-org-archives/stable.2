Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6C13A0B3B;
	Tue, 15 Sep 2026 08:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789461535; cv=none; b=Ld6sLk+ry7U0clv6laKpIBC93ShoeoWHUJr12YmIpKTJ8k0BWIqoUm4CnC12AClmeIDcIea/Ww4Df1dFRzERLptFrFhs9Se3qDCP9sEL7o2jFNalyo1NxFdMXhnHo6pdu1DEUwe9qTYGh6x+GnkBB1B8kRYGy1clZlyeEJWvVLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789461535; c=relaxed/simple;
	bh=zNKy/IzJ6qU7dVGDGyF1IZC2cGwnLBmyfREtiaXVX7Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VX77HUrX6fpV9NAOkKLCOMdKijmqMpE6DqTXma/5kt2CAtPwPb04PSmAliSIPBoh7ErOt4c45ayEjLrsqJSlNmYBjOJY1UPkAXTlnd7GzgnmGoT1qU6qgPSz2L4ClHfT/QIqpqe3T9mGvcnq8twEvW+Xvr83G8IgmdVvRls9XKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ipEX5J/u; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ipEX5J/u"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F71SYm150551;
	Tue, 15 Sep 2026 08:38:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=k3FH4x
	5L80jGTzVXyd1FgcnuV1kZzhrBCb0yGo4D9cc=; b=ipEX5J/ugvexfodCIvoUbm
	IRSxsEOyc04z5U5T9epHAnVnptHmf5S5gLqHb2heAYKh0AUyJEV8DKCLZVt6DCI1
	dIZUS7+2bh5wXsTFMfGpeTt5X7cLf9YtXkYH06TLO/XUjYzHZjPsSweMdte+m9JA
	UgSG3T9FXECuzDu7uaPgO6RnQE4nxLgdrbJq59fWOG0kUthilXgPmi0Gs/ZI/TJS
	GNufu21fxC+IL9ehtxWv99biuNPeUk9jUEvgzpW0nq+5SB4xmV+ZAtwU4fTOpRfx
	RKUCPWi20HatHvKjz3eR+VU/97lvP8chCgwo2v7xIxq2dVmvI3fP0NzWW9JABpvw
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4x3uc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 08:38:35 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68F6ZI6B3613555;
	Tue, 15 Sep 2026 08:38:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gpywerjvs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 08:38:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68F8cVhw41222544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Sep 2026 08:38:31 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 136492004B;
	Tue, 15 Sep 2026 08:38:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4578A20040;
	Tue, 15 Sep 2026 08:38:29 +0000 (GMT)
Received: from [9.123.2.177] (unknown [9.123.2.177])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 15 Sep 2026 08:38:29 +0000 (GMT)
Message-ID: <647f3494-1e79-43ea-a8ed-157b3f0e6c54@linux.ibm.com>
Date: Tue, 15 Sep 2026 14:08:28 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] KVM: PPC: Book3S HV: Avoid triggering an extra interrupt
 for a vCPU
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        tpearson@raptorengineering.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20260915060146.33410-1-gautam@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20260915060146.33410-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: WBWQJk8CS2rSJ-gzFi8ni3i-Z7ly88h2
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDEyMiBTYWx0ZWRfX+e06gwGvGJ43
 o5vMknaE4HWsvQ4+Dkdc6cCZ8qDrltltDnAeAhUFugJi1CQNpF+acI6xqKMXQeZtFWdVnjjrJQx
 37cg0wN8bP5x54atR9GxV7JwZ6t2c6g=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa9040c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8 a=VnNF1IyMAAAA:8 a=C-dYcwNCrXqwm9yQvhYA:9
 a=QEXdDO2ut3YA:10 a=6M1ixcW_PCWoKiWyFx5v:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-ORIG-GUID: Kady2yuf0ChdC2klB7QZEB5XWAWuVf-r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDEyMiBTYWx0ZWRfX0AvzrU1jlVxj
 vLPICeDcq1FCC6OdIyT4skJOrGWoT6patSLqr5YYZFjr5ACAnX1fdKzRrJPTL+TCk/GS9oGyaNi
 bOvQIOVGSXx/XxSv+MJWqxEcvgvaPRZuK951EzEakhxA3InbVBVNEb6QDj179F1ZZrQ+INUzW15
 1OR3TY+CFL8alyV86bITAup+9odiN4d0DwxpFmXECWEmnLSV8X6XHxICCHRBQ8YmF1o+up4I1K+
 FVMrwLUAj7Dlek4O97bxB6Hsz7Hdy9KGOatmfcLx0+8ucqHELQHwNariGZLYhWq+7XIeo30zx5b
 DB8hpWnK3Hq0eSu9Ro4S+gJBQJs+wnIObeuCLxG8xGZfFUcXVqd5SFhTgN9mBoJK1eTi1M6fvpn
 a5pm1tL7YrE52bPcXmte6Cs3Hdn3wn+76PmaphsZPEM4sg7MmarFktXzW9s+x2xZFX2whb3JHuS
 58pVoGWKNCwAm3brXwA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_02,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609150122

Hi Gautam,

On 15/09/26 11:31 AM, Gautam Menghani wrote:
> A huge number of spurious interrupts can be seen immediately after a KVM
> on PowerNV guest boots up in XIVE mode.
> 
> $ cat /proc/interrupts  | grep SPU
> SPU:     223705     192439     273526     147623   Spurious interrupts
> 
> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> Handle pending exceptions on guest entry with MSR_EE"). The root cause
> is that when there is an interrupt pending for a vCPU
> (xive_interrupt_pending() returns true) and MSR_EE is disabled for the
> vCPU, LPCR_MER ends up getting set for the VCPU. When the vCPU starts
> running, the XIVE hardware presents the pending interrupt to the vCPU
> (since the KVM guest has native XIVE support) and then a second spurious
> interrupt gets presented to the vCPU due to the LPCR_MER bit being set.
I agree that we should avoid setting LPCR_MER when the pending interrupt 
will already be delivered natively by XIVE on PowerNV.
> 
> Fix this behaviour by not queuing up any extra interrupts with LPCR_MER
> if there is an interrupt already pending in the case of KVM on PowerNV.
> This reduces the number of spurious interrupts drastically.
> 
> Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
> Cc: stable@vger.kernel.org #6.8+
> Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
>   arch/powerpc/kvm/book3s_hv.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 7667563fb9ff..fda3767ebc9e 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4937,9 +4937,8 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>   
>   	if (!nested) {
>   		kvmppc_core_prepare_to_enter(vcpu);
The current code handles two different indications of an external interrupt:
> -		if (test_bit(BOOK3S_IRQPRIO_EXTERNAL,
> -			     &vcpu->arch.pending_exceptions) ||
> -		    xive_interrupt_pending(vcpu)) {
> +		if (!xive_interrupt_pending(vcpu) && test_bit(BOOK3S_IRQPRIO_EXTERNAL,
> +							      &vcpu->arch.pending_exceptions)) {
>   			/*
>   			 * For nested HV, don't synthesize but always pass MER,
>   			 * the L0 will be able to optimise that more
This means xive_interrupt_pending() now gates the entire block, 
including the BOOK3S_IRQPRIO_EXTERNAL handling, rather than only 
avoiding the LPCR_MER which causes the duplicate interrupt.

Also, the changelog describes the issue as specific to KVM on PowerNV, 
while this condition also affects the pSeries/nested handling in the 
same block.

Thanks,
Narayana Murty N
