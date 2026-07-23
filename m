Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D299486B8B
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828466; cv=none; b=Meeo+iTVR2dT7ZrlO4wJTCc73m7IlXViffKOuLy+Rv262sWhMtymbW2crZOoyd8NO2y4odACUTmcvsaX8NGJMEFeWEuXnwf7DvRRA9aXxl3hENbkAmMcSSlOfRPHO1A4wA6zQE4HM43I5NRaENDD+Tcr5pis5Oq5IvcxMcO3m3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828466; c=relaxed/simple;
	bh=PSqz05Ttw8s/uUR8d4YlT8hCqLy2tTC+2Y+AmJbR5p4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lV8wlJAGmqPz9hmuE16r673dfdcv1hvoewLO4tkblgMwoEWc51JxF139PI4S54tYlgJYo93+icyaVBxHf3AOTLmcFpAizo0eMdsQYhdB2iwkbggQYkTxTPdECdPuNfdskty2WV7s2qUaKP6nOtfU6MtrHBflLhXV8KSAfT6OB48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MA2akMBU; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MA2akMBU"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2cc88e22f92so22471345ad.1
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 10:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784828455; x=1785433255; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=T0nJnPGw5B1wgopuk1VPIkYmtY/4C7SmoOyqSrpJCRQ=;
        b=MA2akMBUAhrlEXK6b/MRVLo2eFiI6NUFTFKYVVUbYWAv0XM9XMfZXXC7NbaD+yMOz0
         /uTXWsCGaxXZ1mx8SSdeKnrx9WYAu/phjvztp9lsP1DTj8BbZHXRqrxq9Ta2lIgs8iCB
         MpEBnIGAnXVjZl9x6V+O8ywXAnpGBaYoYxGkWdXarFx5eLxKeaqWU8nvSOxpsjU1a2av
         3xkpSEw5Dp4BPpFZ7s7pS1qaCABUXizEUSR84rLDZMZfMoizimOaVHUUV/wAkx+G3B1U
         cEZKhvwMm6srNqDvk/u4/z9pZRzcsCIrb3H5j7L45bpuiUABWN9rgckFdG4g5AlL2/Ao
         mo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784828455; x=1785433255;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T0nJnPGw5B1wgopuk1VPIkYmtY/4C7SmoOyqSrpJCRQ=;
        b=IE78l3yp6pQbLi07AWL5NB38apQugg/XN4FcfaGDuf1aRKhkUQH35SdLeZBHxhtzZL
         JHmm9qcacxixJ//nxhcqfJACU8N45ahYGjiOxs5ELNSsPc8wxbn+PFDe2cEgkMScqRqz
         Kn0gIZ9R/tf8qwSc4pUfulCL8Mi2DJPMAPSvMMOPAUrexO9l2ot3Oa/eb3hyt6BZh2la
         j4TnLXu2OBzn/Wp9bvldUs00WHj6gKk0gV4y1EzFo3B5HTQTNT6KDORSmpQCUdcTOeh2
         4qgm2NLFO8w7acH5Z2MG8hGJnDn2HsJSm6HELQ5ah/38mX5psQkd2j6WMaAx6qBNhjwH
         WJOg==
X-Forwarded-Encrypted: i=1; AHgh+RrLqbTE+T3/F4RgRbZLofeCfkQL6aTgarPKNoI9ZxnHIozOhuSOoxY+qQaLMYpH7n5KuUG3xao=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywt7YunQFcF/j3lbuSeyWxmYlip1lgZp79w0R/eGprOFT41Mg0k
	vdF1rsCJjhUp6hzh1Kj1R5MQhAQ5tlzKqKqVKQRmnB59vH7aF/zdso4TpBED3TJT/vyUWgVxYqX
	h08AbXw==
X-Received: from plri3.prod.google.com ([2002:a17:903:32c3:b0:2cc:e88e:423c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:15c3:b0:2ca:17e2:2acc
 with SMTP id d9443c01a7336-2cfa72ef3bamr55655555ad.21.1784828454780; Thu, 23
 Jul 2026 10:40:54 -0700 (PDT)
Date: Thu, 23 Jul 2026 10:40:54 -0700
In-Reply-To: <CAO9r8zN5uGtYS-Y3qUNDmBh5X3zhjuHkbpEis8ti79977KkGwA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260717060505.2971514-1-yosry@kernel.org> <amE5DiLbq5PdYuNn@google.com>
 <CAO9r8zN5uGtYS-Y3qUNDmBh5X3zhjuHkbpEis8ti79977KkGwA@mail.gmail.com>
Message-ID: <amJSJuDGXI4oXE5Q@google.com>
Subject: Re: [PATCH] KVM: nVMX: Only update last_vpid on a successful nested VM-Enter
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026, Yosry Ahmed wrote:
> On Wed, Jul 22, 2026 at 2:41=E2=80=AFPM Sean Christopherson <seanjc@googl=
e.com> wrote:
> >
> > On Fri, Jul 17, 2026, Yosry Ahmed wrote:
> > > ---
> > >  arch/x86/kvm/vmx/nested.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > > index b5460de4b1a72..0a4ea410b0483 100644
> > > --- a/arch/x86/kvm/vmx/nested.c
> > > +++ b/arch/x86/kvm/vmx/nested.c
> > > @@ -2818,8 +2818,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu=
, struct vmcs12 *vmcs12,
> > >       if (kvm_caps.has_tsc_control)
> > >               vmcs_write64(TSC_MULTIPLIER, vcpu->arch.tsc_scaling_rat=
io);
> > >
> > > -     nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);
> > > -
> > >       if (nested_cpu_has_ept(vmcs12))
> > >               nested_ept_init_mmu_context(vcpu);
> > >
> > > @@ -3739,6 +3737,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_r=
oot_mode(struct kvm_vcpu *vcpu,
> > >               vmx_start_preemption_timer(vcpu, timer_value);
> > >       }
> > >
> > > +     nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);
> >
> > Hmm, so the SDM doesn't explicitly say _when_ TLB flushes happen, but I=
 suspect
> > this doesn't match how hardware behaves.  My guess is that any TLB flus=
hes happen
> > once VM-Enter has gotten past the VM-Fail consistency checks, i.e. once=
 a VM-Exit
> > is guaranteed.
> >
> > The SDM doesn't actually say anything about VM-Enter, so I don't think =
KVM *must*
> > implement *that* specific behavior, but I do think we should leave the =
call to
> > nested_vmx_transition_tlb_flush() where it's at, and instead service th=
e local
> > pending flushes in the pseudo-VM-Exit path.
>=20
> Well, technically, changing the VPID is not a TLB flush. KVM has to
> flush the TLB because under the hood it's using the same VPID, but
> from L1's perspective, it's using a new VPID so any TLB entries
> associated with the old VPID should not be used (for that VM entry). I
> guess you're referring to other architectural flushes, like a VM entry
> with VPID disabled.

Oh, right, I overlooked that this specifically affects the vpid12 tracking.

> The reason why I moved the call to nested_vmx_transition_tlb_flush()
> is that it only makes sense (semantically) to update last_vpid when we
> will actually use the VPID. Otherwise, if a VM entry fails, the CPU
> couldn't have cached any translations associated with the new VPID,
> and a flush is not needed if the VPID is changed again.
>=20
> IOW, the choice was purely based on semantics and code readability.
>=20
> > Because the other way the TLB flushes
> > can be queued during VM-Enter is via the MSR load lists:
> >
> >   If any MSR is being loaded in such a way that would architecturally r=
equire
> >   a TLB flush, the TLBs are updated so that, after VM entry, the logica=
l
> >   processor will not use any translations that were cached before the t=
ransition.
> >
> > E.g. if L1 successfully loads one or more MTRRs on VM-Enter to L2[*], t=
hen fails
> > on a subsequent MSR, architecturally I believe L2 TLB entries are guara=
nteed to
> > be flushed.
>=20
> Hmm that is an interesting case. I guess the right thing to do here
> depends on hardware, but yeah I think it makes sense in this case to
> service local flushes in the failure path. It still annoys me that we
> would update last_vpid even on failed nested VM entries, so part of me
> still wants to move the call to nested_vmx_transition_tlb_flush() just
> for that, but that may not make sense for the VPID disabled case.

Yeah, but I'm not convinced that KVM is actually diverging from hardware.  =
At
some point during VM-Enter, hardware needs to "officially" switch to VMX No=
n-Root
and start tagging TLB entries with the new VPID.  I can see that being at t=
he
bitter end, when success is confirmed, but I could also see it happening be=
fore
ucode starts loading guest state into hardware.

Heh, I wonder if we could abuse the MSR load list to deduce when hardware s=
witches
its TLB tagging to VMX Non-Root and starts using the new VPID.  E.g. maybe =
put
DS_AREA and PEBS_ENABLE in the load list, followed by a ton of MSRs to chew=
 up
CPU cycles, and then reverse engineering how translations to service PEBS b=
uffer
writes are resolved :-)
