Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D864137D133;
	Mon,  5 Oct 2026 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186797; cv=none; b=iSz+b9tfcewVjihD7++Md5I7uF/nOm7ZDGiu1NgrvMqSnMKe/newc37OzB+fA8por2CZ8OWD+JjgIBBpe9la1TMk+ebClXH7LV5hdlGZWAQMecyUieKiOhxMYhrKgExpjFWHDT8wACM4jW2Fs3EjspbpacoW42YzV5jB+DKkKmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186797; c=relaxed/simple;
	bh=cZoKzXfW+ICxc0xbdGx+9g/g9nxFz7RtNyJINpsT5Sg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E707YrmoKb9WIm60/CCGA4dMwZ58Rg37iGzUhgmZIGePmfeE/57SqCFEuHMrY+yvjf25afSnrjxHXLND4F6GkhNuN7+0u3yLQj2ZTuz6cNDqy3U0O2dt1sOIbz91cjM5YXw5Oh/0NezBZwhTiAN/4IV9PmCXMX/suxpjxv5KZKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TCmTSY5Z; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TCmTSY5Z"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515Y7c2065822;
	Mon, 5 Oct 2026 07:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=wovB45gTblG2t7xU0qO9DxtlTJom+P
	bKDVPM7twlFec=; b=TCmTSY5Zh9AKcHz80FXkejP0Z01sDWYfwb2RBkH1jbIXM3
	sMRHTTsCfANAYCF7vGoDzuLqimMOpLjhDVh2RpN6zvEa8AVHQK+9wCiBi5w322H5
	HXZqIP8vzgueFu/cdLvYfka/eKtBAjvUDLRZcM1bGQ9ZdlcQ8YHqgzQY+PF35Fnr
	epuHoJIWoQurHpmiIFD2sfM3W5TfhsOR1mrRdeJPURO19bkob+r6g6/wTTzEgoIk
	8x+oVrZIwMHkp+VBi9PJI1AF63X5LP6Lf8O5rhHwVkEgYy1ZI/ThVfIeHrHdZ+tg
	u3YSAPg5rdylSaR3oNiOzz1rWfWo9x2NBBSrguSQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2r4frg3s-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 07:52:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69569p1v2203886;
	Mon, 5 Oct 2026 07:52:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhgmed1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 07:52:55 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6957qo6h35455236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 07:52:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B3D972004F;
	Mon,  5 Oct 2026 07:52:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2757F2004B;
	Mon,  5 Oct 2026 07:52:48 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Oct 2026 07:52:47 +0000 (GMT)
Date: Mon, 5 Oct 2026 13:30:59 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Gautam Menghani <gautam@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnmlinux@linux.ibm.com, amachhiw@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <20261005131832.8f6b2b14-d5-amachhiw@linux.ibm.com>
Mail-Followup-To: Gautam Menghani <gautam@linux.ibm.com>, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	ritesh.list@gmail.com, sshegde@linux.ibm.com, nnmlinux@linux.ibm.com, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Timothy Pearson <tpearson@raptorengineering.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921111043.49825-1-gautam@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=TOPQ2Fla c=1 sm=1 tr=0 ts=6ac35758 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8 a=VnNF1IyMAAAA:8 a=EThlqOoKbmT7VKALfbcA:9
 a=CjuIK1q_8ugA:10 a=6M1ixcW_PCWoKiWyFx5v:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzMCBTYWx0ZWRfX2InbMOps9S09
 JI+jwuFS/ZBJCj7AAFdKAc8Wis3oh+tm2iyOkkOBXYk5rOsUx4OPGw6qD98MbVu0I5Oo/dVfLNC
 rfMKo7sN31SO7dEBQmfK5c1yEy1WGXKPgzdIHwGEzMwmvYFh30YdUB7JrzjleyCD/Kc54Wl1t4+
 NOCUjRVZFeS+3jwuIujjxRkxPyXJg5JYqHLM6X4TJpOi1ztnoujWXPyHcfqsZRlzNkaH3N+nPqk
 tDa6zEK+ZPCGp9t2em/YmPqWL9gQwmHXQ4tw48Ldw67mCjI+ofPc53DUQatEzJOFH/pPbWnNpC+
 vU6s0sZTZeX7W2mFA1nMOjJD+8DVJdbxNLlFzGR19LRrMocxYKdlPLntstwDDyZ9BQBudjE5QxQ
 UK8yD2/gXh+hiQUICAn3IcrKxejyyM9AEg38XpUSDmovniqVUuAUY3Vog0lQWHP9VSZ4ofeBzVr
 NulN/EI6QqioziJ8wLA==
X-Proofpoint-GUID: z3VeellNhN-20HClfkBmum5rlFaw0hFJ
X-Proofpoint-ORIG-GUID: is6NVzq44xhVgSXksG9snG8P5amf8ebg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzMCBTYWx0ZWRfX6INeK+u8IbeW
 9yV2bMXqmwIx1n4til78OiMAuYtKetphFSAXcTv7HLO3RKb5DTu9ZhDkxNq+hNIvwJX6s3B+WCv
 OkDWbsYrtFWXHmIX2XBrql0x+PmqUFU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1011
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050030

Hi Gautam,

Thanks for the patch and working on this.  I have a couple of questions though.

On 2026/09/21 04:40 PM, Gautam Menghani wrote:
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
>  arch/powerpc/include/asm/kvm_ppc.h | 7 +++++++
>  arch/powerpc/kvm/book3s_hv.c       | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 169ea6a7fbad..580ad2548c2b 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>  	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
>  }
>  
> +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm)
> +{
> +	return kvm->arch.xive_devices.native;
> +}
> +
>  extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>  					   struct kvm_vcpu *vcpu, u32 cpu);
>  extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
> @@ -782,6 +787,8 @@ static inline bool kvmppc_xive_rearm_escalation(struct kvm_vcpu *vcpu) { return
>  
>  static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>  	{ return 0; }
> +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm) { return false; }
> +
>  static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>  			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
>  static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index dbac3573b2c8..cb2bb29451a7 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>  			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
>  				kvmppc_inject_interrupt_hv(vcpu,
>  							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> -			else
> +			else if (!kvmppc_xive_native_enabled(vcpu->kvm))
>  				lpcr |= LPCR_MER;

1. What happens when an L1 KVM guest is booted with (native) XIVE and then the
   guest is rebooted with `xive=off` i.e., with XICS?  Will we stop setting
   LPCR_MER as kvm->arch.xive_devices.native would still be set?
2. What happends when an L1 KVM guest is booted with XIVE and then we kexec into
   a new kernel with `xive=off`?  You did mention in your other reply that with
   kexec, `xive=off` is ignored currently but IMO, we would want to understand
   where this limiation lies and fix that if need be.  I do understand we are
   trying to fix spurious interrupts problem with XIVE in this patch and this
   particular problem can be taken separately but it worth investigating.

Thanks,
Amit
