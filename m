Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B113137F339;
	Wed, 23 Sep 2026 03:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790134777; cv=none; b=clBEYECqKE7pSx28BuwOpl32x4RrByOuoO2iq5ha2N5z2KXL+bPwEggs288ppdFHfHw/9xSBvadiFBknWQbrjKpScwNoidpsmBY7vB4ZgUQgbI60WGC9Ga5ihWLaOBNm/pRQZDNYsJalURKjnr0ZYhTEIYFrDkaThHB5/5fAG/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790134777; c=relaxed/simple;
	bh=gm4fyReuiWxeqJWFOIFuvDAEIaopYi+tVz5GKuVnZFQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lopCwCIOBiI1BtogmYl7MFDM6kRiLl17H5Lib77jBwHxEWBHhJXihrqXyqLJ/CB2iF5izGMPabT/Vp9p+PdriqCY3rWjFVMNZu7fGUwGNrOHWVjgHEfr3QXLFbn8XgeOw+hCvDxXTmggcjiORpUQA68rKN6CHgdehDgkqqfsU5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iaafy6ou; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iaafy6ou"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3a6HY2317248;
	Wed, 23 Sep 2026 03:39:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7NoF1/
	Lp4e2fruKgAZwH9CbISe4iP63v0zB28htVbAU=; b=iaafy6oukNdFx0gFRpn+cN
	0JMjQLFwECcH1R23b/D91JnMUG1s4VSedp5Qa1/6L8C5ORpDBObzr6mgE/HBoV6f
	B5jj6Z7SwOkHB3EHdiIUJaxMrHiuAO3PmVpEOch394JkiHwAKep2z0Sosm0zC5en
	+iVqnZjgFnmy0lvh7wy0Jhlm0x3Nzspps6YB5w/inga1+vW9ku0xSUmUffIf8Gj6
	T4p+z17RGr2Hre1p+lllB8OeDX9NEqlUD3qiXGu9SuYQMRFTuc3uIGTAOyyOM/pR
	9FGebxJ+Pq0rVIMpeVTTUmsSgbBietvONRJtrMRLrCosgX7gVJ5VnkfhKab/Vm7g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdv8ny5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 03:39:06 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68N3WXbV2578232;
	Wed, 23 Sep 2026 03:39:05 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gu5bkf44w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Sep 2026 03:39:05 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68N3d1Ax45416746
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Sep 2026 03:39:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90AF62004E;
	Wed, 23 Sep 2026 03:39:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A720620043;
	Wed, 23 Sep 2026 03:38:58 +0000 (GMT)
Received: from [9.124.211.2] (unknown [9.124.211.2])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 23 Sep 2026 03:38:58 +0000 (GMT)
Message-ID: <ed756a12-182f-4933-8788-8b54a4e8912a@linux.ibm.com>
Date: Wed, 23 Sep 2026 09:08:57 +0530
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com,
        npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
        ritesh.list@gmail.com, sshegde@linux.ibm.com, amachhiw@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
Content-Language: en-US
From: Narayana Murty N <nnmlinux@linux.ibm.com>
In-Reply-To: <20260921111043.49825-1-gautam@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: FMJDrbwTvLAlZxxf_Y3B4db8Us1VDxTr
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIzMDAxNCBTYWx0ZWRfX55My7ytjw32Y
 j/rT5Wo3X1Y+yKUjGLNS8xCVQRQokiwSfrrunJeJuCXQjXDpb4UWKNECklQvD9kBekaayDoKdbX
 fyCpPOpXxtY6NhpIFoNTeEHKRKxAG2I=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab349da cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8 a=VnNF1IyMAAAA:8 a=EThlqOoKbmT7VKALfbcA:9
 a=QEXdDO2ut3YA:10 a=6M1ixcW_PCWoKiWyFx5v:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-GUID: aBLqlTnfUXMt09OXVH3CAj-ky44OsTcu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIzMDAxNCBTYWx0ZWRfX7MZHIOxzupFX
 s2rmtiQTZoZ3K1t0+VzhupmUzM2avyqsQxYbzGz8cUtenXcje0+M1b4XB0VC84QqYRWb0t0Wi6V
 JDVOSInbh57kEGikhttOu2Jylz+jvrr7idp3h1C0n0ddRLggOl88uPn5BDMnCS08ss78GGIV9vz
 CKCH383vaEaeP1ZRo4qfw1bvSgzxl9j8Au1X2Qp5heym7y1Yjw78bcO1Ut7YYDMorM8c2HtZYrT
 pRPz+M8DP2y0Psc0Xmmb1K2RSBowMZVZu1iGeSwciqwaQyNrDsaIxiFF/CKcUhzyWoSNt4IGth6
 5DvRp439sxMzFLNwZvNe4Y7O04pN2GXQcVn2thjpIuMWrdt8UCl9YWRdjmbiTrskdzx+ZqUajt8
 ElDJeH7gwb/MkPl8zE8TtS+ceeGjSKua8uMK2iJOkWAv7td+8RgObpTE+2mB8oRD1HTwmQ1PE9+
 7SF4cu0PuCoSPeam1EQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-23_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609230014

Hi Gautam,

On 21/09/26 4:40 PM, Gautam Menghani wrote:
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
> index 169ea6a7fbad..580ad2548c2b 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>   	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
>   }
>   
> +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm)
> +{
> +	return kvm->arch.xive_devices.native;
> +}
Also, should 'kvmppc_xive_native_enabled()' check the active XIVE
device rather than just whether a native device has been created?

'kvmppc_xive_native_release()' clears 'kvm->arch.xive', but explicitly
keeps the 'kvmppc_xive' pointer under 'xive_devices' for reuse. The
comment in 'book3s_xive.c' also says that when switching between XICS
and native XIVE, the previous KVM device is released before the new one
is created.

So 'xive_devices.native != NULL' seems to mean that a native XIVE
device has been allocated/cached, rather than that it is currently
active.

Would this be more appropriate?

return kvm->arch.xive_devices.native &&
        kvm->arch.xive == kvm->arch.xive_devices.native;

> +
>   extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>   					   struct kvm_vcpu *vcpu, u32 cpu);
>   extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
> @@ -782,6 +787,8 @@ static inline bool kvmppc_xive_rearm_escalation(struct kvm_vcpu *vcpu) { return
>   
>   static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>   	{ return 0; }
> +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm) { return false; }
> +
>   static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>   			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
>   static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index dbac3573b2c8..cb2bb29451a7 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>   			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
>   				kvmppc_inject_interrupt_hv(vcpu,
>   							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> -			else
> +			else if (!kvmppc_xive_native_enabled(vcpu->kvm))
>   				lpcr |= LPCR_MER;
Is the intent here to suppress LPCR_MER only for interrupts that
native XIVE can deliver directly?

BOOK3S_IRQPRIO_EXTERNAL is a separate software-pending exception. If
MSR_EE is clear it remains pending, so it seems this path should still
set MER even when native XIVE is active.

IOW, should the behavior be:

else if (!kvmppc_xive_native_enabled(vcpu->kvm) ||
	 test_bit(BOOK3S_IRQPRIO_EXTERNAL,
		  &vcpu->arch.pending_exceptions))
	lpcr |= LPCR_MER;

so that only the native-XIVE-pending case suppresses MER?

Thanks,
narayana Murty N
>   		} else {
>   			/*

