Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A1A37F31C;
	Thu,  8 Oct 2026 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488764; cv=none; b=V9g/i5vpCeY5a7iLwCNb9tJevWfACaKphs1ckm4YGsZfjTOnQsYeqPspXun9UbEGanIfwCzmd2buuoZWnF3Kz9sOwduHMMorhkaKvs9jBAa5vYBQHj6gT77AS81WDlFGnYnTe9aoNHNmEQsEzYugsbNPQAyZpKl5qg1p8WQuJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488764; c=relaxed/simple;
	bh=LEW94m3rs0MsPp1aE7pvAEL/rwEtYOeyCU6oCitcU98=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClxfXanp5bkcqpSfXjlzpmnCOAyFKYi9IsjdPpxNwSfNmF3BFNARU2e8N4pqIU2us6VbiCxV4Kj34AkiwEJLIi7GEOWp5aUnuQZLwPVrQ5KTNPAGQgDgvd8NvliphY7107QiZIBWL/SjGK+FGx+EScn8kGgzaa6zEwdxVhhUQdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dHTW14vQ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dHTW14vQ"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698HZPfq2063934;
	Thu, 8 Oct 2026 19:45:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=/lrjjj
	lNn91KMBz6pzu9kExNdFo3rxhRlGa78fgGi/A=; b=dHTW14vQ/YyDwDg5VZkgfm
	mGeQOLRRoRoWC5xLUe0IIaPOxnh/g5CrdPR/76fSWAtco4SNa0dAuGT1rCW54Qsq
	80VWHI4E8hEaXrk72ppkk/MhvTs6WS96DmdcKHBrCAXMuUSyYhSWITgnsqndcbKs
	jn4dvIhqJ9L1stU9XFfpM0DeZUC1LnvcWuCgB9di88hJN/zP8H59UgcQrKk9r+o+
	O360JJXIm6+kQfSEC94YokYu0/Jx1XQ7UeK6eAjRbDrlojL7qz6we1bp+b700PZC
	GfDaxMdLvYpmfoMwJFByr2BnGtFERUn8Uv3EZgsfaHUf6kW5e2IOwgZsof0XZirA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvx7at-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 19:45:36 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698HldAo3802948;
	Thu, 8 Oct 2026 19:45:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s34wnkb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 19:45:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698JjVXm27853230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 19:45:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F1F0720043;
	Thu,  8 Oct 2026 19:45:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C387E20040;
	Thu,  8 Oct 2026 19:45:27 +0000 (GMT)
Received: from [9.124.217.41] (unknown [9.124.217.41])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 19:45:27 +0000 (GMT)
Message-ID: <703a731c-efc3-476f-b9b6-77b4bdcb3b55@linux.ibm.com>
Date: Fri, 9 Oct 2026 01:15:26 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, amachhiw@linux.ibm.com,
        harshpb@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
References: <20261005084534.1588611-1-gautam@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20261005084534.1588611-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: YxkVyBYcvhWmpOKD6KP6eWYhIe47SGYS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfX8u3GjcZVhHFQ
 /4QPLrXa6sfLu0jvwt97s86x0e3GGhZf9XVldyYk8YWCXaE6i7OjGaYqMfzkF8aOrJY9HY9feKP
 n+4jZ9VE0mDyiw0/aAY6h8+KnSrUi80rDUxWo+4+Qgcycn2ZUf+Zn29pWzOp4FdCDdVrrytaB7X
 jeUGgctJtuJ9Krq8/JHzxqdnbrqNtaQti5krZTgr1D3G7+reZKVBzDoK5saHVTeGR7dn4T3pUEf
 scotCFRHBZV3ixFEOE6S9r8DAQiHUa8PJb6W3dgj6pPtovJbdCWDXbc35r4ab62qgQvzVlzyTmx
 To1Ae6rWF4dni0cp2Q18M/9iQMB+0Rfg/fO4JQzM0V9esO60+c277dUXIurQgp0YCEFJ35n4exY
 Hj4dpIz6lzObvkZ2QSsNrw+CLWpcjL691t5JJxM9Zp5I/buK1B70OzF+7Y1VRcb5T0kKfrNUt8s
 5a+f2WbtfL0NPxCjH0Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3OCBTYWx0ZWRfX3+RnJKsTjs9L
 U289GfKKWa61wIwrZQsaC0q5a4j1a3om3J/qLNoAdGif69OG7XZBeMsAXa2evr80JHkBzkAP6yb
 Ih7vliZK0cHFWPv5hUARn0BqA1daktc=
X-Proofpoint-GUID: 8E0aK5kgsyfbJ4_x8o7e6AS8MHkS8Q2b
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac7f2e0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8 a=VnNF1IyMAAAA:8 a=EThlqOoKbmT7VKALfbcA:9
 a=QEXdDO2ut3YA:10 a=6M1ixcW_PCWoKiWyFx5v:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080078



On 05/10/26 2:15 PM, Gautam Menghani wrote:
> A huge number of spurious interrupts can be seen immediately after a KVM
> on PowerNV guest boots up in XIVE mode.
> 
> $ cat /proc/interrupts  | grep SPU
> SPU:     223705     192439     273526     147623   Spurious interrupts
> 
> This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> Handle pending exceptions on guest entry with MSR_EE"). The root cause
> is that once LPCR_MER bit is set, it is supposed to be reset by
> software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> not exit back to the host until the decrementer expires or there is an
> hcall, etc. This is because KVM on PowerNV guests have support for
> native XIVE, so they are not dependent on host for interrupt emulation.
> Due to this behaviour, a huge number of spurious interrupts are seen
> since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> vCPU exits to the host.
> 
> Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> available (currently in case of KVM on PowerNV only), as the XIVE hardware
> can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> functionality is not required. This reduces the number of spurious
> interrupts drastically.
> 
> Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
> Cc: stable@vger.kernel.org # 6.8+
> Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> ---
> v4:
> 1. If interrupt mode is changed to XICS during guest reboot, MER should
> be used. (Amit)
> 
> v3:
> 1. Continue the use of LPCR_MER when kernel-irqchip=off (Sashiko)
> 
> v2:
> 1. Handle the case where xive_interrupt_pending() is true and also the
> external exception bit is set. (Narayana)
> 
>   arch/powerpc/include/asm/kvm_ppc.h | 7 +++++++
>   arch/powerpc/kvm/book3s_hv.c       | 2 +-
>   2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 169ea6a7fbad..9178406dc365 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>   	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
>   }
>   
> +static inline bool kvmppc_xive_native_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return kvmppc_xive_enabled(vcpu) && vcpu->kvm->arch.xive_devices.native;
> +}
> +
>   extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>   					   struct kvm_vcpu *vcpu, u32 cpu);
>   extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
> @@ -782,6 +787,8 @@ static inline bool kvmppc_xive_rearm_escalation(struct kvm_vcpu *vcpu) { return
>   
>   static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>   	{ return 0; }
> +static inline bool kvmppc_xive_native_enabled(struct kvm_vcpu *vcpu) { return false; }
> +
>   static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>   			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
>   static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index dbac3573b2c8..dec89c014c52 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>   			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
>   				kvmppc_inject_interrupt_hv(vcpu,
>   							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> -			else
> +			else if (!kvmppc_xive_native_enabled(vcpu))
>   				lpcr |= LPCR_MER;
>   		} else {
>   			/*

The v4 change also handles switching back to XICS while the native XIVE 
device is still present. With that, the interrupt-mode cases look 
covered to me, feel free to add
Reviewed-by: Narayana Murty <nnmlinux@linux.ibm.com>

