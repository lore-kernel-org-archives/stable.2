Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C6036997A
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 22:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784758628; cv=none; b=PO9mGPCketyYklvYpZhkFnXDRoFfmSOxj4FPgVcgC7nYN/OsaxBT2h1nNKIzjWu35F7PwLYv/FWIgNk8Cgbwrb7JZP8N2qVlJLBswH/BfHmfLzEPeHNJHrJvSFPBXSpEPGJ3VLBY4+bnUTxalSL9wuiuX/57kkhebwCeaCHwdRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784758628; c=relaxed/simple;
	bh=CS+5BodVT7fP2tqcuPhYMpWTqmb8m8g56WPBlCegP7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Kzb9VQwaz3f8QEClzT0jgP85bN2GP2nFGWUgzW19xy0K+UKfinMX9u4PhdMmescuQPuhgXf1gIsuOyIY4HAX26ir9kcd9FSx6MwtX1re2ACOLv//ETJyI69fXGOEzKxGFcpyfjObpRHfPJ8TlDS6RQrPnT3oJ1XGDqm5ph4STc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AkAJbfiq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AkAJbfiq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62FE01F00AC4
	for <stable@vger.kernel.org>; Wed, 22 Jul 2026 22:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784758627;
	bh=DG0VOfFeLsFqG6RzrNm7/kzVBCeGf739XJWpHdg2Aes=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=AkAJbfiqpO9BqebC2beqEit3hxt+u2swRpNr0j0v/goLdG+EviULf/I51c9Vn2qrl
	 Ru2IXdlB+1yg7pmEqQCVu6YCQ8/3+izQ3fCJaROXCCIwYbFLGdP6ZNwk1QRBp9F9oB
	 b00gHWAL5FzC+fvD6kzvsvuztPjr2ibyJwsdFEdsLLbpKBplWE8Xg6q3D35OJGNkDC
	 7s8pEVjvBgSaUHUOJ7DxaxmHrQjYDLfooNnTHtVt5qF2P92vZcSbXo3NwjOwBapXhO
	 zB2zBFJsCoTFfZvDYnwpXaHEZB62QVKm7Xor8ehXlZeQSq3q4tKwQ1cbL8nFlc4JRd
	 0S3abjRBZWTSg==
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c1c26d7e951so6120566b.0
        for <stable@vger.kernel.org>; Wed, 22 Jul 2026 15:17:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpQjZABW3p6lsA/zyEAZ5n1/34sy7Tex6uiNAlkII2JOUucEUj5C9Ok9gIKyeefkANPF5RuZDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbTkVX30xCwaH1Xb6xf8hRP12SAPQ4P43nLLToxfOt9pVrh27G
	+cusg87nSnz9cDsnuyIrgAfnNpsRsx3CaOl1UiB4KDM0LDDUbEvNrmsNkqmOr9ySuuJZv+ZOXeR
	lzsCU1LRqJkcpwgMCVnujXxnNqrjyciY=
X-Received: by 2002:a17:907:6d09:b0:c15:fc41:fda with SMTP id
 a640c23a62f3a-c1c50b5efedmr22653066b.63.1784758626266; Wed, 22 Jul 2026
 15:17:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717060505.2971514-1-yosry@kernel.org> <amE5DiLbq5PdYuNn@google.com>
In-Reply-To: <amE5DiLbq5PdYuNn@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 22 Jul 2026 15:16:54 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN5uGtYS-Y3qUNDmBh5X3zhjuHkbpEis8ti79977KkGwA@mail.gmail.com>
X-Gm-Features: AUfX_mwrOEJcVTbY_B_2odzglFxj2w-CUV1PsWh-DY-aLEcy3aXSA3g5MHnPayk
Message-ID: <CAO9r8zN5uGtYS-Y3qUNDmBh5X3zhjuHkbpEis8ti79977KkGwA@mail.gmail.com>
Subject: Re: [PATCH] KVM: nVMX: Only update last_vpid on a successful nested VM-Enter
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 22, 2026 at 2:41=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Jul 17, 2026, Yosry Ahmed wrote:
> > ---
> >  arch/x86/kvm/vmx/nested.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> > index b5460de4b1a72..0a4ea410b0483 100644
> > --- a/arch/x86/kvm/vmx/nested.c
> > +++ b/arch/x86/kvm/vmx/nested.c
> > @@ -2818,8 +2818,6 @@ static int prepare_vmcs02(struct kvm_vcpu *vcpu, =
struct vmcs12 *vmcs12,
> >       if (kvm_caps.has_tsc_control)
> >               vmcs_write64(TSC_MULTIPLIER, vcpu->arch.tsc_scaling_ratio=
);
> >
> > -     nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);
> > -
> >       if (nested_cpu_has_ept(vmcs12))
> >               nested_ept_init_mmu_context(vcpu);
> >
> > @@ -3739,6 +3737,8 @@ enum nvmx_vmentry_status nested_vmx_enter_non_roo=
t_mode(struct kvm_vcpu *vcpu,
> >               vmx_start_preemption_timer(vcpu, timer_value);
> >       }
> >
> > +     nested_vmx_transition_tlb_flush(vcpu, vmcs12, true);
>
> Hmm, so the SDM doesn't explicitly say _when_ TLB flushes happen, but I s=
uspect
> this doesn't match how hardware behaves.  My guess is that any TLB flushe=
s happen
> once VM-Enter has gotten past the VM-Fail consistency checks, i.e. once a=
 VM-Exit
> is guaranteed.
>
> The SDM doesn't actually say anything about VM-Enter, so I don't think KV=
M *must*
> implement *that* specific behavior, but I do think we should leave the ca=
ll to
> nested_vmx_transition_tlb_flush() where it's at, and instead service the =
local
> pending flushes in the pseudo-VM-Exit path.

Well, technically, changing the VPID is not a TLB flush. KVM has to
flush the TLB because under the hood it's using the same VPID, but
from L1's perspective, it's using a new VPID so any TLB entries
associated with the old VPID should not be used (for that VM entry). I
guess you're referring to other architectural flushes, like a VM entry
with VPID disabled.

The reason why I moved the call to nested_vmx_transition_tlb_flush()
is that it only makes sense (semantically) to update last_vpid when we
will actually use the VPID. Otherwise, if a VM entry fails, the CPU
couldn't have cached any translations associated with the new VPID,
and a flush is not needed if the VPID is changed again.

IOW, the choice was purely based on semantics and code readability.

> Because the other way the TLB flushes
> can be queued during VM-Enter is via the MSR load lists:
>
>   If any MSR is being loaded in such a way that would architecturally req=
uire
>   a TLB flush, the TLBs are updated so that, after VM entry, the logical
>   processor will not use any translations that were cached before the tra=
nsition.
>
> E.g. if L1 successfully loads one or more MTRRs on VM-Enter to L2[*], the=
n fails
> on a subsequent MSR, architecturally I believe L2 TLB entries are guarant=
eed to
> be flushed.

Hmm that is an interesting case. I guess the right thing to do here
depends on hardware, but yeah I think it makes sense in this case to
service local flushes in the failure path. It still annoys me that we
would update last_vpid even on failed nested VM entries, so part of me
still wants to move the call to nested_vmx_transition_tlb_flush() just
for that, but that may not make sense for the VPID disabled case.

I guess the "right" thing to do is break the last_vpid tracking out of
nested_vmx_transition_tlb_flush() and only update last_vpid on a
successful VM entry, but it's probably not worth it in terms of code
readability.

> I'm speculatingly heavily on all of this, but even if I'm wrong (or it's =
uarch-
> specific behavior), explicitly servicing pending flushes in the VM-Exit(i=
sh) path
> feels safe in the long run:

All that being said, yeah I am convinced it's probably better to do
the below. I will send a v2 after testing it with my repro.

>
> diff --git arch/x86/kvm/vmx/nested.c arch/x86/kvm/vmx/nested.c
> index 3266c63046ee..49aeecc2f093 100644
> --- arch/x86/kvm/vmx/nested.c
> +++ arch/x86/kvm/vmx/nested.c
> @@ -3760,6 +3760,14 @@ enum nvmx_vmentry_status nested_vmx_enter_non_root=
_mode(struct kvm_vcpu *vcpu,
>  vmentry_fail_vmexit_guest_mode:
>         if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETT=
ING)
>                 vcpu->arch.tsc_offset -=3D vmcs12->tsc_offset;
> +
> +       /*
> +        * Handle any TLB flush requests that were queued for L2 if KVM m=
ade it
> +        * far enough along to switch to L2 context.  Note, loading host =
state
> +        * will generate any flushes for L1 required by VM-Exit.
> +        */
> +       kvm_service_local_tlb_flush_requests(vcpu);
> +
>         leave_guest_mode(vcpu);
>
>  vmentry_fail_vmexit:
>
>
> [*] https://lore.kernel.org/all/20260717230542.3555587-4-jmattson@google.=
com
