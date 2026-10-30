Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793374039;
	b=uTJoQLXNzdQ0uE4KPY/hgYFAalDbhyRTp7K0ZfzoahZi8Jadt0k/l2nS1AGAsv2l2YtA
	 w4uAJxLRa1ImKA3QtBisvIqHHTLDyiP1sSV3v1I/y7zaU0Ew14VwKZrh1ZVCOT47DfWSz
	 Nijr4jkjgK5dhC31na99TqBDpKfJTbXjXPBjbkgjKkVQaLoETWZzIzx5Lb3KP3vMni8Kb
	 nl5b6lavuCVY/8L5z5l+rj6XcE5DBUxsCMItHiR1p6NQJTjFd2Gahba+ISTHVqZbvKAM1
	 C4LzUIJRfLuHlvmLkJ4RHgbQGmx76ias5F0ZgNFMxmAPP/9qQmN693zFDm97x135LeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793374039;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References;
	bh=e+m5QU2XeT3uQPTC6GC01opeM6s+W2OonF16GBipID8=;
	b=HiIC+YeCflewYr8Do+7ActAf2OlY2j9Z22t6Llqi9MQP6zPZkyzqe++1eVs38j1NO1vN
	 nDKUSLta5w43P0+K8nHzOTb5D2EemA9dyuE+oFKmGgBHzj7aW8Vji5oautjBZc46RZyCW
	 DOAbwQH2x+tqVPXsoWkCCy+SreuMF56E2eHNoMxbinSoKhv3li5d0ZuUR6qjMBpWgug8f
	 4ggYZf7hVg5kbS30x0bb/L4Tg57nBHTf4+fM5rxuLEf6gk/8uZECfG4IFPJcp08owy2Ip
	 deU4th8hR3ZBy6vGayi9mNiTg9reeW8/bq819LDyrKcjcu8SxCUoF94a+Fm6BpApsyQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFAVKHPu;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4824606A31E
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 15:27:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4824606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XFAVKHPu
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-15ea896ddc8so1375580c88.0
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 08:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793374038; x=1793978838; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e+m5QU2XeT3uQPTC6GC01opeM6s+W2OonF16GBipID8=;
        b=XFAVKHPulJdUfDeKa8svR9f5V73x+etFm4iL9VgAiu8m5lWA9EUvr1d93Ah/ZuLrVh
         Ulr3XfCeaRBNxhC+cJPnwBSRHWx1ie+YZmGO8L81/lEOglQw8Pt9yERS2XSzSR5v69O+
         pGP2U5hALlGXj/oK264mgyAz293TfKe7MaxMB7gTrv2kjEmXBJkurMOaG/vJn2TofYBl
         n8+01nrDE3nzZP7XYKhUKNNjL2/ic7mdsBQXhIfxwm0BVzBIyIJttzMqTSmG7RS8uSZW
         0o5sHXYDck3TLrbjYg1L0WR+y1mWykuG3/TxXHbmgmGaulL7NG1A6cQAFgY4WEXwxu4M
         SotQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793374038; x=1793978838;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e+m5QU2XeT3uQPTC6GC01opeM6s+W2OonF16GBipID8=;
        b=IZjCZI+Sknu9QskmRYdtwYcI09mh9RrPiwnLeKT2yG9mXE96FT0HyZT9uXopUhfOnJ
         KpD5GZ3ilbY4kmFlakxtu+ftFNr1tgNBr6lw2Hw3sgynshYO1JrLMq+kKC0o5M2d60Cb
         r03Su6sD1PdjwgCjjjUpd9K9uy3YWC+HW7B02f/Hes2d6Cz+QbHVGBNd6i3GeRJ6xael
         awG9QOgyHL9CrR26v2wsYXoZiRqYqv6+g5R6wdSZdhRWSDxUIBG9Hx7idX7abTMYPLj1
         +cdby6zZfKUwA4Jlr/FEzP+ZNJFywQGJ0o1BoZpfVjKBKt55OCyKZ6x7amHiRJnVOR71
         8/rQ==
X-Forwarded-Encrypted: i=1; AKwUvBxrabz767VTJZob32stzjB1MkzqXO3HyRcoRw3zFEtUnwS/34DnGvILD+suzP4Y+6H0ATUloaM=@vger.kernel.org
X-Gm-Message-State: AFq9FYI7BOmENWEkXq1InDm9oajcIfR+P+hRtHDn4TVw9+nixYDzaWvi
	dS+/JAZgmwYTUMM9fEB2Z2VboDUj8mTwcNr15V5foGIX9zItL4QC0L+Z3QSi8w==
X-Gm-Gg: AYBFou0s7+1zN/kzv7bBlWx9UFMxRm7I8pD7BsJoW1EB6NXqyQwOc/rxCcfrrUq0OSV
	FHYtCgB0/VL5WNDg+vsC1lLdWeC/yTqLgKaibjlDWObyDJMkECQQGrSzl6/2zTGSBhw6J+9E2Dv
	UWORd2lkceggVTR9cnFkgN1l9V41baSS/kr8QjcR681WSKVE94GlxRJEIGVu9P4lejhVWabMua1
	ymmR3w357bszbho0USROiuXZ3fnwiyq5BnVOvRv1pyP0QbQYhZ79/Qwvdolu9g0tz9F5HYOSyk3
	FYt6dS3BJ0tyNMRbZqFjedbFaRJpVSQl9Pqb2mNNP78D3T1Vd2lD8OaL+lcOL2Uy4JywY9JNdia
	zlwM6zjSLC3Y6MrKDvclIIuDTVIJhFA1N1FiJA+ia0OjrmmNgtS7+VasVl6JgOdFyEvEhXxwNZK
	149AWqHA4Vj6hLQQ4zDQWpeG7iE+vApgMlsUNSrB6TL1H4NR+duMclO+sS2fZj5VAvER7BjnxYo
	F3Njbdr1cEnqGcwPMUmBpw8yDkNeFsgMLtfK+7q6YjAxLaSuMFVdRA2nmRK5V0/JRj223CrdfZv
	cD7jiW+KgBOFX+3NWaX2lw39e1w=
X-Received: by 2002:a05:7022:7f0b:b0:13b:3132:6e99 with SMTP id a92af1059eb24-1ac5af2da84mr3344929c88.20.1793374036049;
        Fri, 30 Oct 2026 08:27:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36a42aa8999sm9261448eec.29.2026.10.30.08.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 08:27:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Gautam Menghani <gautam@linux.ibm.com>, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, sshegde@linux.ibm.com, nnmlinux@linux.ibm.com, amachhiw@linux.ibm.com, harshpb@linux.ibm.com
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Timothy Pearson <tpearson@raptorengineering.com>
Subject: Re: [PATCH v4] KVM: PPC: Book3S HV: Avoid spurious interrupts caused by LPCR_MER bit
In-Reply-To: <20261005084534.1588611-1-gautam@linux.ibm.com>
Date: Fri, 30 Oct 2026 20:48:15 +0530
Message-ID: <4ie3w72g.ritesh.list@gmail.com>
References: <20261005084534.1588611-1-gautam@linux.ibm.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list

Gautam Menghani <gautam@linux.ibm.com> writes:

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

Make sense. 

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
>  arch/powerpc/include/asm/kvm_ppc.h | 7 +++++++
>  arch/powerpc/kvm/book3s_hv.c       | 2 +-
>  2 files changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
> index 169ea6a7fbad..9178406dc365 100644
> --- a/arch/powerpc/include/asm/kvm_ppc.h
> +++ b/arch/powerpc/include/asm/kvm_ppc.h
> @@ -747,6 +747,11 @@ static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>  	return vcpu->arch.irq_type == KVMPPC_IRQ_XIVE;
>  }
>  
> +static inline bool kvmppc_xive_native_enabled(struct kvm_vcpu *vcpu)
> +{
> +	return kvmppc_xive_enabled(vcpu) && vcpu->kvm->arch.xive_devices.native;

I was checking the code and I am not sure whether we need to also check
for "vcpu->kvm->arch.xive_devices.native"?

Can you explain why do we need to check for xive_devices.native pointer
to be non-NULL? Because if we don't need this then it simplifies the
code as we can directly use kvmppc_xive_enabled(vcpu) helper.

-ritesh


> +}
> +
>  extern int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>  					   struct kvm_vcpu *vcpu, u32 cpu);
>  extern void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu);
> @@ -782,6 +787,8 @@ static inline bool kvmppc_xive_rearm_escalation(struct kvm_vcpu *vcpu) { return
>  
>  static inline int kvmppc_xive_enabled(struct kvm_vcpu *vcpu)
>  	{ return 0; }
> +static inline bool kvmppc_xive_native_enabled(struct kvm_vcpu *vcpu) { return false; }
> +
>  static inline int kvmppc_xive_native_connect_vcpu(struct kvm_device *dev,
>  			  struct kvm_vcpu *vcpu, u32 cpu) { return -EBUSY; }
>  static inline void kvmppc_xive_native_cleanup_vcpu(struct kvm_vcpu *vcpu) { }
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index dbac3573b2c8..dec89c014c52 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -4980,7 +4980,7 @@ int kvmhv_run_single_vcpu(struct kvm_vcpu *vcpu, u64 time_limit,
>  			if (!kvmhv_on_pseries() && (__kvmppc_get_msr_hv(vcpu) & MSR_EE))
>  				kvmppc_inject_interrupt_hv(vcpu,
>  							   BOOK3S_INTERRUPT_EXTERNAL, 0);
> -			else
> +			else if (!kvmppc_xive_native_enabled(vcpu))
>  				lpcr |= LPCR_MER;
>  		} else {
>  			/*
> -- 
> 2.52.0
