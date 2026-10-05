Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949073C7E1D;
	Mon,  5 Oct 2026 08:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791189102; cv=none; b=uxbjNgluFlpcuBBVkUIscP9l2ncPVR3CCUmMWuwUJAUxMtBfaJE6sJjRlVGB1i5wX+HWva9xsgvu3kEOjIlEQwRX/zfHozr3iHEp6CTS0yVbjIVg0dcZjFlclwH6n3CF0RaCLZ3EwLSZ2x8TycWTWBLoL5ZVLCJhaAuxBTS87Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791189102; c=relaxed/simple;
	bh=i3KphR52rYjiPv244tJ77lodav7iifqNlET+lIZ2B98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mb12VQYkdW7hgrt2ZVcHsNPdlQyxIqDlVd0DCSworVCHCOwPvUQgZKq6bqlAaU4JXoD0IZr/YXTYiUeVduLW2WPI7HK/v7xU3D3b4OV+daMxDvH6YUX4lFNV3uiv4SAbS0wyZTJEC3YlWZfZnxocDEGQNeOYkyli/HYdOq+NLm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NEBxRDG5; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NEBxRDG5"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69515tPU3138609;
	Mon, 5 Oct 2026 08:31:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=cV1DIDm1H/SM4Pu6ttqXxzPFW/iqSK
	/fSLTDmMvEMRg=; b=NEBxRDG5BCq6/Q7Bi08IBeO69W4cIw6Cu8DO0DW0mI9ptE
	JjeMgIaTP9pf/7N5PKNJyP3o4l6xBqT0Ct6vHQvni6RpkEW7vzHEZlSQ959oTa53
	0rNE+PgiFRa53zlFbCefwOKFfjY++9ScYXIbPq03UeXXCZrB6xy2n8c9GhBAptqY
	5naqH0zK9ezIbWvajmbgQjVumk127vAsvE/DAVPsmcrCW3HM/iuQQapy690/I+hk
	GlYii7B6JaTYxf3FDJWKLjptRl1n8/Uwh4r6OEmb40sUYJTkdWRf7KvI0pa41Wa9
	dddzGnrg6YdC2xxoq4cZnG7LaP3z8pRZWXezthRg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h2q4jgunj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:31:11 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6956VlTS899523;
	Mon, 5 Oct 2026 08:31:10 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h3e8g4ewe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 05 Oct 2026 08:31:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6958V6eH51184078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 Oct 2026 08:31:06 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C24622004D;
	Mon,  5 Oct 2026 08:31:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9673D2004E;
	Mon,  5 Oct 2026 08:31:03 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.124.213.142])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  5 Oct 2026 08:31:03 +0000 (GMT)
Date: Mon, 5 Oct 2026 14:01:00 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        nnmlinux@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <asNgRIII-Wcoe0cu@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
 <20261005131832.8f6b2b14-d5-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261005131832.8f6b2b14-d5-amachhiw@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: CLcUPelohjNEPAL2N6DsAHZsHV7c3622
X-Proofpoint-GUID: 1NBb7_Ukx7J8J5asDhlXmHGytyLTBnYv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA1MDAzMiBTYWx0ZWRfX8CWIsYVsBMly
 ZxpKymgyfZ5RgawlHbekx1zQzZ+xUYW0qNZscn2JcI2laqMTELKD+lOajGnhgjEXjj6ycoLnyLt
 BG1aKhVm8nD6+kpyMEjiBBWXtku8YhU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA1MDAzMiBTYWx0ZWRfX7TThJCIZHbjy
 MSaJXkzse+bgujB39+v7rr+gild3rWp7+IhzXFlGHqwRV3wBa3jl8jefOqxExXtY+ydfH7pBpsF
 0/xGNTMTmOwkerbdI/30EbLFn/DMlp2taRCYjMQZJmU62u9q4PGb+l4KhfUPD2lWwH2Z51trANo
 wTD46qB933V2Q1rwGR2FFAa43HFvtHraKypTzFkY6APNXP4ow63iFHP+XdLFrohaTTZHTE8IUK8
 c3jO5LnAFdgLIWI9p9WptSKTsx9Rv7i4KlM85inbmpxA74jzxo9qkyl+EANm+1AUI2jMVnWPpdV
 Z2nK5Omk8qwVsG9xpQ3HNA6MZWbTphhYt5SUoO2D6d6v0L9T4bsd5llJdDTQ/GXUrxmdY2h73ym
 ad1rITsC4pIR9/Iflp8x4pBU7YS8H2foveg/rcT15Go1pn50zl2jIOFYcF5ki0n0BOD5Zb1o+9E
 /u/oJ9mHnRgC7sH1+qg==
X-Authority-Analysis: v=2.4 cv=eYeo7LEH c=1 sm=1 tr=0 ts=6ac3604f cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8 a=VnNF1IyMAAAA:8 a=9HMC7dwcUNEby-kk_2AA:9
 a=CjuIK1q_8ugA:10 a=6M1ixcW_PCWoKiWyFx5v:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-05_01,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0 clxscore=1015
 spamscore=0 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610050032

On Mon, Oct 05, 2026 at 01:30:59PM +0530, Amit Machhiwal wrote:
> Hi Gautam,
> 
> Thanks for the patch and working on this.  I have a couple of questions though.
> 
> On 2026/09/21 04:40 PM, Gautam Menghani wrote:
> > A huge number of spurious interrupts can be seen immediately after a KVM
> > on PowerNV guest boots up in XIVE mode.
> > 
> > $ cat /proc/interrupts  | grep SPU
> > SPU:     223705     192439     273526     147623   Spurious interrupts
> > 
> > This bug was introduced by commit ecd10702baae5 ("KVM: PPC: Book3S HV:
> > Handle pending exceptions on guest entry with MSR_EE"). The root cause
> > is that once LPCR_MER bit is set, it is supposed to be reset by
> > software. But when a vCPU starts running with LPCR_MER set, the vCPU does
> > not exit back to the host until the decrementer expires or there is an
> > hcall, etc. This is because KVM on PowerNV guests have support for
> > native XIVE, so they are not dependent on host for interrupt emulation.
> > Due to this behaviour, a huge number of spurious interrupts are seen
> > since LPCR_MER continues to be set and LPCR_MER cannot be reset until the
> > vCPU exits to the host.
> > 
> > Fix this behaviour by not using the LPCR_MER bit whenever native XIVE is
> > available (currently in case of KVM on PowerNV only), as the XIVE hardware
> > can present interrupts to the KVM guest vCPU directly. So the LPCR_MER
> > functionality is not required. This reduces the number of spurious
> > interrupts drastically.
> > 
> > Fixes: ecd10702baae5 ("KVM: PPC: Book3S HV: Handle pending exceptions on guest entry with MSR_EE")
> > Cc: stable@vger.kernel.org # 6.8+
> > Reported-by: Timothy Pearson <tpearson@raptorengineering.com>
> > Closes: https://lore.kernel.org/linuxppc-dev/582904882.11159.1786719390349.JavaMail.zimbra@raptorengineeringinc.com
> > Signed-off-by: Gautam Menghani <gautam@linux.ibm.com>
> > ---
> > v3:
> > 1. Continue the use of LPCR_MER when kernel-irqchip=off (Sashiko)
> > 
> > v2:
> > 1. Handle the case where xive_interrupt_pending() is true and also the
> > external exception bit is set. (Narayana)
> > 
> >  arch/powerpc/include/asm/kvm_ppc.h | 7 +++++++
> >  arch/powerpc/kvm/book3s_hv.c       | 2 +-
> >  2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index 169ea6a7fbad..580ad2548c2b 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> >  	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
> >  }
> >  
> > +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm)
> > +{
> > +	return kvm->arch.xive_devices.native;
> > +}
> > +
> >  extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> >  					   struct kvm_vcpu *vcpu, u32 cpu);
> >  extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
> > @@ -782,6 +787,8 @@ static inline bool kvmppc_xive_rearm_escalation(struct kvm_vcpu *vcpu) { return
> >  
> >  static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> >  	{ return 0; }
> > +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm) { return false; }
> > +
> >  static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> >  			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
> >  static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index dbac3573b2c8..cb2bb29451a7 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
> >  			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
> >  				kvmppc_inject_interrupt_hv(vcpu,
> >  							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> > -			else
> > +			else if (!kvmppc_xive_native_enabled(vcpu->kvm))
> >  				lpcr |= LPCR_MER;
> 
> 1. What happens when an L1 KVM guest is booted with (native) XIVE and then the
>    guest is rebooted with `xive=off` i.e., with XICS?  Will we stop setting
>    LPCR_MER as kvm->arch.xive_devices.native would still be set?

Yes, that's a good catch. kvm->arch.xive_devices.native is cleared only
when vm is destroyed. So this case has to be handled.

> 2. What happends when an L1 KVM guest is booted with XIVE and then we kexec into
>    a new kernel with `xive=off`?  You did mention in your other reply that with
>    kexec, `xive=off` is ignored currently but IMO, we would want to understand
>    where this limiation lies and fix that if need be.  I do understand we are
>    trying to fix spurious interrupts problem with XIVE in this patch and this
>    particular problem can be taken separately but it worth investigating.

Yes right, the kexec case is to be understood, but I'll take it up separately.
Meanwhile, I'll send a v4 to fix the reboot case.

> 
> Thanks,
> Amit
