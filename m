Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ECC93F1AB9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788472846; cv=none; b=iRKx1w0rqsxN6Myd7C44LqHc82C9qDkea/8ZpTU84nGfm/HWd8pPYZGjCxtde0uUeiNx8oIOX4sTC+IaUkU6QuoG1lJDHBRikxZpsqXTcGlrsmGTRI+7FJL1bTYHebtADJiyS+xiUNw9KJKnMrZ16zsaJusPYlxUE/Ys1y0YOrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788472846; c=relaxed/simple;
	bh=8HgvklB29rh0ClPeXXm7oYhqE28MptayobnKEetJy1M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DoQAX0gi4IZjlHBS7QpJwxrdq1+R0Tqh5Js6uTZJPckIjVwlyfJr/lnBgh9MtyGaNB4rqZQbVbxVhOflIOo7Rh5eQyqtX0YjjAGEIEuAo8xCu/AxWYau4fXv39lz7GUru7dtdviXTIugZpN+zk/AoSFFqOZ1IanXORuYkcZaTHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=duU2wqID; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="duU2wqID"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3D411F00ACA
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:00:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788472843;
	bh=cDOcenxVcTfG2Ivwu2jQyEAhFsfes+FRIZ0N5RdiNPA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=duU2wqIDfg+PzVi7GNqCL/JAWbtHuvINHKWk+jn1c2BEActB9OqkbnrpS9z0R3Hm3
	 MIokDyUCVtuOQjX5OH7zszYjJvNnDRg7/RcSrad++pHia7ZtMk1rLTnvrADmSG2e0T
	 cTxVL4vJXx6mH+KUm1jz+fDu0ocRPtbe8/valyEyCItpaz9Z/urnuCLO5lVirhqQwk
	 N3wb3bayV9gseHMXqhGd2J5xg9ceSnK3nVMzJUlKjUrk90wQwCEwJtJNiu8f0H5Oh/
	 nbUxGglGNyym7u1tluqc7HAT0Ul8Cqv1a9g4+yU5fQCN4rxfzQ8419e/ePMvpnGpCC
	 bOnN6P2lMLihA==
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c25b661d37dso51529066b.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 15:00:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxsYwqrfh8NVTcIawg3Wgs4KWdUL7/LNrmhuuuaX8DGdi65+TpGmnNAhgI5N6pptwIf5y2T5W4=@vger.kernel.org
X-Gm-Message-State: AFuF++mUlu1dJ+dVHsTC1agrq2c9Nt594Qq/GSCuhWUaeVY9PemDefB6
	xj7KLrVpMVtbRxbfuxswZhrrPW6GAl5CLRr885tUZHpqohLvngREVJk334UXxn7WodKbd2tJNHU
	6PehJ5WFBakq7PWKli5PQQ8XWOm+N5Z0=
X-Received: by 2002:a17:906:8d89:b0:c24:c250:a6b5 with SMTP id
 a640c23a62f3a-c260c993a9amr120576666b.12.1788472842652; Thu, 03 Sep 2026
 15:00:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903175856.4065099-1-yosry@kernel.org> <apnqonqMBZ2GeGEq@google.com>
In-Reply-To: <apnqonqMBZ2GeGEq@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 3 Sep 2026 15:00:30 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPcvZpy=379oWNY_+p2XZ74On5LPL+53evbRqq5OD1H=g@mail.gmail.com>
X-Gm-Features: AcwNN1XMVsEnoFpkVZlFWh79egRk2_lNmEeXqOjTbquABEBypRG25byaT8f89zs
Message-ID: <CAO9r8zPcvZpy=379oWNY_+p2XZ74On5LPL+53evbRqq5OD1H=g@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Trigger new ASID allocation in both VMCBs on
 pCPU switch
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 2:53=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Sep 03, 2026, Yosry Ahmed wrote:
> > When the pCPU where the VMCB was mostly recently used is switched, rese=
t
> > the ASID generation in both VMCBs, triggering new ASID allocation for
> > the immediate VMRUN as well as the next VMRUN on the other VMCB.
> >
> > The ASID is shared between vmcb01 and vmcb02, and gets flushed on every
> > nested transition. However, since pCPU tracking is done per VMCB, it is
> > possible for one VMCB to allocate a new ASID when migrated to a new
> > pCPU, and then the other VMCB reuses that ASID on the old pCPU. This ca=
n
> > result in the same ASID being used by multiple vCPUs on the old pCPU.
> >
> > Example scenario:
> > - vCPU runs on pCPU A, vmcb01 is active, asid=3D1.
> > - vCPU migrates to pCPU B, vmcb01 pCPU changes, new asid=3D2.
> > - Another vCPU runs on pCPU A and allocates asid=3D2 as well.
> > - vCPU migrates back to pCPU A, and then switches to vmcb02 before it
> >   runs again with vmcb01.
> > - No pCPU switch is detected for vmcb02, so VMRUN is done with asid=3D2=
.
> > - Two vCPUs end up using asid=3D2 on the same pCPU.
> >
> > Keep the VMCB dirtying to the active VMCB only. Clean bits are tracked
> > by a pCPU for each VMCB, so do not unnecessarily dirty a VMCB if its
> > pCPU does not change.
> >
> > Additionally, initialize the tracker pCPU for vmcb02 to -1 on nested
> > enablement, so that the new ASID allocation in the scenario above
> > happens even if EFER.SVME is disabled in L1 before migrating to the new
> > pCPU (so asid_generation in vmcb02 is not reset), but enabled before
> > returning to the old pCPU.
> >
> > No performance regression was noticed when overcommitting L1 vCPUs in L=
0
> > (to force rescheduling), pinning L1 <-> L2 vCPUs, and running CPUID in =
a
> > tight loop bouncing between 2 vCPUs in L2.
> >
> > An alternative (and perhaps more proper) fix would be tracking the ASID
> > per-VMCB instead (e.g. [1]). However, that's a more involved change, an=
d
> > it would result in having different ASIDs for L1 and L2 without actuall=
y
> > properly maintaining them. It would probably work because all TLB
> > flushes target the current VMCB, and the other VMCB is always flushed o=
n
> > nested transitions, but the code ends up in an arguably more fragile
> > state. Punt a proper clean fix to an incoming (and overdue) overhaul of
> > SVM's ASID usage [2].
> >
> > [1]https://lore.kernel.org/lkml/20250205182402.2147495-2-yosry.ahmed@li=
nux.dev/
> > [2]https://lore.kernel.org/kvm/20260728003557.1136583-1-yosry@kernel.or=
g/
> >
>
> Fixes: 193015adf40d ("KVM: nSVM: Track the ASID generation of the vmcb vm=
run through the vmcb")
>
> > Cc: stable@vger.kernel.org
> > Reported-by: Stefan Teodorescu <fane@google.com>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >
> > I wasn't sure if the last paragraph (or parts of it) fit in the
> > changelog or below ---, so I just put it all in the changelog, but feel
> > free to move things around.
>
> I like having the alternative(s) listed in the changelog, it saves having=
 to
> find the alternative when digging through git (if the reader is even awar=
e there
> was/is an alternative).
>
> I agree with your assessment, tracking per-VMCB is absolutely the right a=
pproach
> given that the asid_generation is tracked per-VMCB.  But I hate how SVM m=
anages
> ASIDs and want to burn it with fire.  Taking a quick-and-dirty approach w=
ill be
> good motivation for landing the overhaul of ASIDs.
>
> I _was_ going to propose an alternative solution, but it subtly doesn't w=
ork.
> More below.
>
> > ---
> >  arch/x86/kvm/svm/nested.c |  1 +
> >  arch/x86/kvm/svm/svm.c    | 20 ++++++++++++++++----
> >  2 files changed, 17 insertions(+), 4 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
> > index 73f37b050d0a0..0c55c71fc6010 100644
> > --- a/arch/x86/kvm/svm/nested.c
> > +++ b/arch/x86/kvm/svm/nested.c
> > @@ -1494,6 +1494,7 @@ int svm_allocate_nested(struct vcpu_svm *svm)
> >       if (!svm->nested.msrpm)
> >               goto err_free_vmcb02;
> >
> > +     svm->nested.vmcb02.cpu =3D -1;
> >       svm->nested.initialized =3D true;
> >       return 0;
> >
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index ea647938a2a65..c388c6598463e 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3765,14 +3765,26 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
> >       struct vcpu_svm *svm =3D to_svm(vcpu);
> >
> >       /*
> > -      * If the previous vmrun of the vmcb occurred on a different phys=
ical
> > -      * cpu, then mark the vmcb dirty and assign a new asid.  Hardware=
's
> > -      * vmcb clean bits are per logical CPU, as are KVM's asid assignm=
ents.
> > +      * If the previous VMRUN of the VMCB occurred on a different phys=
ical
> > +      * cpu, then mark the VMCB dirty as hardware's clean bits are per=
 pCPU.
> > +      *
> > +      * Reset the ASID generation in both VMCBs. This will lead to ass=
igning
> > +      * a new ASID now, and then again when switching to the other VMC=
B.
> > +      * However, this is needed as the ASID is shared between the VMCB=
s, and
> > +      * otherwise it would be possible to use an ASID allocated on one=
 pCPU
> > +      * on another, for example:
> > +      * - vCPU migrates from pCPU A to pCPU B, allocates a new ASID.
> > +      * - vCPU migrates back to pCPU A, and then switches the VMCB.
> > +      * - The new VMCB does not detect a pCPU change and runs on pCPU =
A with
> > +      *   the new ASID allocated on pCPU B, which is potentially used =
by
> > +      *   another vCPU/VM.
> >        */
> >       if (unlikely(svm->current_vmcb->cpu !=3D vcpu->cpu)) {
> > -             svm->current_vmcb->asid_generation =3D 0;
> >               vmcb_mark_all_dirty(svm->vmcb);
> >               svm->current_vmcb->cpu =3D vcpu->cpu;
> > +             svm->vmcb01.asid_generation =3D 0;
> > +             if (svm->nested.initialized)
>
> Isn't conditioning the clear on nested.initialized wrong?  It's stupidly =
contrived,
> but I think it can happen?  Even if it can't, I don't see any reason to c=
onditionally
> zero vmcb02.asid_generation.  Either it's buggy or it's a wash in terms o=
f performance.

Oh yeah it's not needed. I thought the generation is only allocated
when svm->nested.initialized, but that's not true it's always there.
So yeah we can just always zero it, and then we can drop the change in
svm_allocate_nested() too, or keep it as hardening (it seems like a
good idea in general)?

>
>  - vCPUx runs on pCPU A, vmcb02 is active, asid=3D1.
>  - vCPUx migrates to pCPU B, vmcb02 pCPU changes, new asid=3D2.
>  - vCPUz runs on pCPU A and allocates asid=3D2 as well.
>  - vCPUx switches to vmbc01 and disabled nested, but doesn't run, e.g. be=
cause
>    userspace stuffs EFER.

IIUC, here userspace wrote EFER.SVME=3D0..

>  - vCPUx migrates back to pCPU A, and zeroes vmcb01.asid_generation, but =
not
>    vmcb02.asid_generation.
>  - vCPUx switches to vmcb02, without running vmcb01, again thanks to user=
space.

..and here it wrote EFER.SVME=3D1, in which case svm_allocate_nested()
should set svm->nested.vmcb02.cpu =3D -1..

>  - vCPUx does VMRUN on vmcb02 with asid=3D2.

..and we allocate a new ASID here?

>  - Two vCPUs end up using asid=3D2 on the same pCPU.
>
> The "svm->current_vmcb->cpu !=3D vcpu->cpu" check is also sketchy, but I =
don't think
> it's outright wrong?
>
> Ugh.  Jumping back a bit, I _was_ going to say that we could revert 19301=
5adf40d
> and then do:
>
> diff --git arch/x86/kvm/svm/svm.c arch/x86/kvm/svm/svm.c
> index b4845e452e69..4c8e2fcd378e 100644
> --- arch/x86/kvm/svm/svm.c
> +++ arch/x86/kvm/svm/svm.c
> @@ -1310,12 +1310,6 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struct =
kvm_vmcb_info *target_vmcb)
>  {
>         svm->current_vmcb =3D target_vmcb;
>         svm->vmcb =3D target_vmcb->ptr;
> -
> -       /*
> -       * Workaround: we don't yet track the ASID generation
> -       * that was active the last time target_vmcb was run.
> -       */
> -       svm->asid_generation =3D 0;
>  }
>
>  static int svm_vcpu_create(struct kvm_vcpu *vcpu)
> @@ -4531,6 +4525,9 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kv=
m_vcpu *vcpu, u64 run_flags)
>         sync_lapic_to_cr8(vcpu);
>
>         if (unlikely(svm->asid !=3D svm->vmcb->control.asid)) {
> +               if (svm->vmcb->control.tlb_ctl !=3D TLB_CONTROL_FLUSH_ALL=
_ASID)
> +                       svm->vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUSH_=
ASID;
> +
>                 svm->vmcb->control.asid =3D svm->asid;
>                 vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
>         }
>
>
> But after reading the cover letter[*], I can't tell if 193015adf40d was a=
 bug
> fix for a dirty/clean bits bug, a bug fix for ASID reuse, or an optimizat=
ion (I
> thought it was an optimization until reading the cover letter and looking=
 more
> at commit af18fa775d07 ("KVM: nSVM: Track the physical cpu of the vmcb vm=
run
> through the vmcb").
>
> So yeah, hit this with a hammer and defer the proper fix to your cleanup =
series,
> because I have low confidence that doing a proper fix is the safest appro=
ach for
> LTS kernels.

I can send a new version dropping conditioning the reset on
svm->nested.initialized and dropping the change in
svm_allocate_nested(), is this what you had in mind?

>
> [*] https://lore.kernel.org/all/20210112164313.4204-1-cavery@redhat.com
