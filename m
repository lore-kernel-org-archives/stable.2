Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762D342E8E6;
	Thu,  1 Oct 2026 03:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790827047; cv=none; b=Cb1W+awvfhVKnrpk8RcgbunKE4z/THBMe3J8/4rbqP4I9SLOT/CiLCCdwngS9lsUrK2jZF0Jpw0BVR/7dZtcE0SPAGXZD7B28wRx9EE5QgKuMBUxG2YrVwhXmv5lh2ssgcuCz3cQm5mGC27JlcrrdlDsQD4i7tzziFs7vxzUpTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790827047; c=relaxed/simple;
	bh=hQ8NYmadh8Vr9SUtn0nSGku5dnhZbFMbNf/Yo47e5Pk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Vw6uIV/+h6rQeqzFJr3jI2Jmtr7pzFJ9ftM8x+Wvy7MKbamIaHli3X0LsA5rf8KAJ/Ap0MYgUggertZZTcJWYZG1sIEpsL+8UTbDxsUDL3OjytWEjpS824gAkXpPnD3FHJxEdUdLR1gDMiGUPViMaaOExc6qLXybiyfXtlWy2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rj3iqbLl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rj3iqbLl"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69115eZ43277034;
	Thu, 1 Oct 2026 03:57:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=j3C1jtCzYOB/7ct9Ws2eH5RhJT8FVt
	vOQDQxv8iP5/A=; b=rj3iqbLlO89Sl6vnzzUsGzN+CzC/8kNzEtBsMPDdQiDjeO
	6UyzGokWniiMPIbJSqq+uxgveOYqweZmZRFQgUjSRaoPuaPwi86MpPim2TarDQ9L
	qpuJhUKdpgKx5ztszruVhCjR0/fPuRuZJX4DUYAu6+PLmEvNufusnq3GpNI4HF8S
	ZKClON2j1CR6ll8XwRYinyYtkibfR+UwvBF58FoDaG7XNJaRfgq/caOWf8bZx/y8
	zGsIVVdw79LPf7K40EGaKwGFiUSWQE8JsbCSF6i+wt+Ny2ukIfaQiWaZbq/HM79J
	CQu/DqgT5HHMZXxpN0nMAG5rrorGmqs0I0ZGj34Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx4fefwge-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 03:57:03 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6913le46306270;
	Thu, 1 Oct 2026 03:57:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0hfpeyes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 03:57:03 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6913uwAW47972792
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 03:56:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EBA420040;
	Thu,  1 Oct 2026 03:56:58 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA3092004B;
	Thu,  1 Oct 2026 03:56:54 +0000 (GMT)
Received: from li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com (unknown [9.124.215.84])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  1 Oct 2026 03:56:54 +0000 (GMT)
Date: Thu, 1 Oct 2026 09:28:56 +0530
From: Gautam Menghani <gautam@linux.ibm.com>
To: Narayana Murty N <nnmlinux@linux.ibm.com>
Cc: maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au,
        chleroy@kernel.org, ritesh.list@gmail.com, sshegde@linux.ibm.com,
        amachhiw@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org,
        Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Avoid spurious interrupts caused
 by LPCR_MER bit
Message-ID: <ar3ZrgzhSwkgPuZf@li-fbf77acc-29ba-11b2-a85c-e8e934f50a46.ibm.com>
References: <20260921111043.49825-1-gautam@linux.ibm.com>
 <ed756a12-182f-4933-8788-8b54a4e8912a@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed756a12-182f-4933-8788-8b54a4e8912a@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=FYWiV5+6 c=1 sm=1 tr=0 ts=6abdda10 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=yKAn6K1XAAAA:8 a=_AprYWD3AAAA:8 a=VnNF1IyMAAAA:8 a=9HMC7dwcUNEby-kk_2AA:9
 a=CjuIK1q_8ugA:10 a=6M1ixcW_PCWoKiWyFx5v:22 a=fKH2wJO7VO9AkD4yHysb:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDAxNCBTYWx0ZWRfX0Mwwp8a+mcA+
 kBRtTKDNRB8DfhDmk5KpUFnbXJfo7/81uwd1qUkTj+Reo/NS0D6oE0MHsdbhX9S8nkeZKiaXWWK
 x/M2ILMvWU/iYEwU9xg1R2DcQ/RUQJU=
X-Proofpoint-ORIG-GUID: b4ol1MZLxroLxsstq4uGJlIotdzkNjSm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDAxNCBTYWx0ZWRfX3adJ90NN5pRW
 kH1dhiitnZwaxcGerX+0jbDkISq/9wOKDPg5gMseRkw4mWJvGvWIznIuGfSTZcnEm73vylVs6gW
 JtozuE+THOxtwK2lfsh0mqw3VsPM5iw10OxGmvn9hMtkFj4zLwNe6xdh+KYQabZwQWxed2EzQx6
 9V7Da6MPirZgsBJGVKLwZQabTnag8j8TRMefljS9WEltgn2Lkr9RS2+eaKtaU1oo3brx/RHKl2a
 AAkvdqOlS+QUmx18z0kpxwnU1QkgQDfnKeUEXy8ulkcyet6jiVtvneigW1VwPPmmTc9IJnD62G7
 ftiR5b8DW+Nh4sz0igqpbfDU6ZFKN4x6pSyPQpcezPSv7KVfqKmE4pB+BcFwyonYEIlnEOdlabm
 AV+EUyL9s0MfdYysW/fwA2l/lY5E6OluTY68k4PW1jzMyeP4/8LMSep8iCpW8xkkzN36gTnlIJf
 Zgueu6JIVWf/S2vjzZw==
X-Proofpoint-GUID: MLpu277iUP6UEDeVLkicwtUv15akBGR7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_01,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010014

On Wed, Sep 23, 2026 at 09:08:57AM +0530, Narayana Murty N wrote:
> Hi Gautam,
> 
> On 21/09/26 4:40 PM, Gautam Menghani wrote:
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
> >   arch/powerpc/include/asm/kvm_ppc.h | 7 +++++++
> >   arch/powerpc/kvm/book3s_hv.c       | 2 +-
> >   2 files changed, 8 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> > index 169ea6a7fbad..580ad2548c2b 100644
> > --- a/arch/powerpc/include/asm/kvm_ppc.h
> > +++ b/arch/powerpc/include/asm/kvm_ppc.h
> > @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> >   	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
> >   }
> > +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm)
> > +{
> > +	return kvm->arch.xive_devices.native;
> > +}
> Also, should 'kvmppc_xive_native_enabled()' check the active XIVE
> device rather than just whether a native device has been created?
> 
> 'kvmppc_xive_native_release()' clears 'kvm->arch.xive', but explicitly
> keeps the 'kvmppc_xive' pointer under 'xive_devices' for reuse. The
> comment in 'book3s_xive.c' also says that when switching between XICS
> and native XIVE, the previous KVM device is released before the new one
> is created.
> 
> So 'xive_devices.native != NULL' seems to mean that a native XIVE
> device has been allocated/cached, rather than that it is currently
> active.


In a KVM guest on PowerNV, whatever interrupt mode the guest is booted
in (XIVE/ XICS), you cannot switch it with kexec. So if
'xive_devices.native' exists, we can be confident that native XIVE is
being used. So the code in the patch should be fine.

> 
> Would this be more appropriate?
> 
> return kvm->arch.xive_devices.native &&
>        kvm->arch.xive == kvm->arch.xive_devices.native;
> 
> > +
> >   extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> >   					   struct kvm_vcpu *vcpu, u32 cpu);
> >   extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
> > @@ -782,6 +787,8 @@ static inline bool kvmppc_xive_rearm_escalation(struct kvm_vcpu *vcpu) { return
> >   static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
> >   	{ return 0; }
> > +static inline bool kvmppc_xive_native_enabled(struct kvm *kvm) { return false; }
> > +
> >   static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
> >   			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
> >   static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
> > diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> > index dbac3573b2c8..cb2bb29451a7 100644
> > --- a/arch/powerpc/kvm/book3s_hv.c
> > +++ b/arch/powerpc/kvm/book3s_hv.c
> > @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
> >   			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
> >   				kvmppc_inject_interrupt_hv(vcpu,
> >   							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> > -			else
> > +			else if (!kvmppc_xive_native_enabled(vcpu->kvm))
> >   				lpcr |= LPCR_MER;
> Is the intent here to suppress LPCR_MER only for interrupts that
> native XIVE can deliver directly?
> 
> BOOK3S_IRQPRIO_EXTERNAL is a separate software-pending exception. If
> MSR_EE is clear it remains pending, so it seems this path should still
> set MER even when native XIVE is active.
> 
> IOW, should the behavior be:
> 
> else if (!kvmppc_xive_native_enabled(vcpu->kvm) ||
> 	 test_bit(BOOK3S_IRQPRIO_EXTERNAL,
> 		  &vcpu->arch.pending_exceptions))
> 	lpcr |= LPCR_MER;
> 
> so that only the native-XIVE-pending case suppresses MER?

No this would still result in spurious flood. If native XIVE is being
used, LPCR_MER cannot be set in any case. Software interrupts will
continue to work in the same way they work in an LPAR.
