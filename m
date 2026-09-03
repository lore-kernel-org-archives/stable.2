Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25CAE4E56D0
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474042; cv=none; b=ec0Kz863fSWJ3tbEkVVmgas5XKPIfprgGVY+AQbeidG50ixTS1daUgVToJwzOaHxJ0Wh34c4a7dJfuDwSaJgTS0vJxMxATNWCZfNbuM9aZ4x80YPZMtzrtKGo+6q0CUtra1N+wsQBq/n2U7fp1NvZE9tlZvFrxPiE8kbWZEN7cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474042; c=relaxed/simple;
	bh=puDpgV/x7iJdRGy2iRfTHhaCr86DSBFmMYP1WYF7/Ls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8aKbUgd2ijPT0NHg6gWt7gi4gNcn3JS7VvrOpIkQVsKAAaXOK6k9DA4KSCeOa0BkM71bl8YpQsvs7Fezb7xT0P5YmHCmrC/urDZqztI58//HczOHOgosOg3x3y0K2xNn4DEI7edMpktuaZRvfQK/k+hIxRnePyPOL7pUS5fftA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDOVkusC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDOVkusC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D76701F00A3D
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788474040;
	bh=XErCkNZK6G7WBTio0jFGK/QgQh9ypuTGvQI+xaKM77k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bDOVkusCuh6f8y5QeSb4ykZg6FHXuAjSpiZHn7v+ni5orAJyTEEE32tJxPty1ECPU
	 o56o2JVbFh1LQV7VZcpsTwg3YibMKNmVl0MV44R39ih/kUUqwUp0Y/WrjW4EXS1/yR
	 wxe05MS2sFLrZkoxV11zEdnm1lICtAPDY4WOzSwNlMVu/D4hfpMgsvT59BiiYSAcOZ
	 3EQGbrMKVVXr4GQ0qcEAYM78I93REq/fCGP6aJ6MZ2E+3xS2OiztiDYP88CU1Neq9l
	 C8JT7F46EGNwK01XZFFplJFspAdzJ94feyhCcMowe4mVe0rMc+GOz9Dm2cnf2HPUQS
	 BPze/yPOscSCw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6a5e971c970so2817659a12.0
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 15:20:40 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwCgm2i60HAhW0zxMesrD2s1BjbviHdolmuCxWHao2Zvgc6dYNht0Z276MQN6qyFtoK1yy3ay0=@vger.kernel.org
X-Gm-Message-State: AFuF++nVQvQDPBZc8OgSXKU7qTFdaYoJM7RB0rI6UBQlPqng1FDZQkob
	PR7oc+xwLNC4ZxKhcOgQrMKIcZNt4X0crdn2bK5R+vyoHLbLJa9bAVs7gUCZaIBQZMVrHghQOug
	PuEa/0+attbu6/Ei6ami0b7xu321Lxfw=
X-Received: by 2002:a17:907:3f16:b0:c25:f7dc:2d2 with SMTP id
 a640c23a62f3a-c25f7dc0940mr245742766b.19.1788474039802; Thu, 03 Sep 2026
 15:20:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260903175856.4065099-1-yosry@kernel.org> <apnqonqMBZ2GeGEq@google.com>
 <CAO9r8zPcvZpy=379oWNY_+p2XZ74On5LPL+53evbRqq5OD1H=g@mail.gmail.com> <apnyKNY_FKFWtDNK@google.com>
In-Reply-To: <apnyKNY_FKFWtDNK@google.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Thu, 3 Sep 2026 15:20:28 -0700
X-Gmail-Original-Message-ID: <CAO9r8zN2AqpGudeej3VshJek6iy7iaTwO4GgmLSVO0++omHUxA@mail.gmail.com>
X-Gm-Features: AcwNN1USE5TIY09YYe1eMfDzPC0dWkGMMkhrDqscJ1Fg0-SNpp1bjRgtghuYZWc
Message-ID: <CAO9r8zN2AqpGudeej3VshJek6iy7iaTwO4GgmLSVO0++omHUxA@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Trigger new ASID allocation in both VMCBs on
 pCPU switch
To: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 3, 2026 at 3:18=E2=80=AFPM Sean Christopherson <seanjc@google.c=
om> wrote:
>
> On Thu, Sep 03, 2026, Yosry Ahmed wrote:
> > On Thu, Sep 3, 2026 at 2:53=E2=80=AFPM Sean Christopherson <seanjc@goog=
le.com> wrote:
> > > >       if (unlikely(svm->current_vmcb->cpu !=3D vcpu->cpu)) {
> > > > -             svm->current_vmcb->asid_generation =3D 0;
> > > >               vmcb_mark_all_dirty(svm->vmcb);
> > > >               svm->current_vmcb->cpu =3D vcpu->cpu;
> > > > +             svm->vmcb01.asid_generation =3D 0;
> > > > +             if (svm->nested.initialized)
> > >
> > > Isn't conditioning the clear on nested.initialized wrong?  It's stupi=
dly contrived,
> > > but I think it can happen?  Even if it can't, I don't see any reason =
to conditionally
> > > zero vmcb02.asid_generation.  Either it's buggy or it's a wash in ter=
ms of performance.
> >
> > Oh yeah it's not needed. I thought the generation is only allocated
> > when svm->nested.initialized, but that's not true it's always there.
> > So yeah we can just always zero it, and then we can drop the change in
> > svm_allocate_nested() too, or keep it as hardening (it seems like a
> > good idea in general)?
>
> Definitely keep it as hardening.
>
> > >  - vCPUx runs on pCPU A, vmcb02 is active, asid=3D1.
> > >  - vCPUx migrates to pCPU B, vmcb02 pCPU changes, new asid=3D2.
> > >  - vCPUz runs on pCPU A and allocates asid=3D2 as well.
> > >  - vCPUx switches to vmbc01 and disabled nested, but doesn't run, e.g=
. because
> > >    userspace stuffs EFER.
> >
> > IIUC, here userspace wrote EFER.SVME=3D0..
> >
> > >  - vCPUx migrates back to pCPU A, and zeroes vmcb01.asid_generation, =
but not
> > >    vmcb02.asid_generation.
> > >  - vCPUx switches to vmcb02, without running vmcb01, again thanks to =
userspace.
> >
> > ..and here it wrote EFER.SVME=3D1, in which case svm_allocate_nested()
> > should set svm->nested.vmcb02.cpu =3D -1..
> >
> > >  - vCPUx does VMRUN on vmcb02 with asid=3D2.
> >
> > ..and we allocate a new ASID here?
>
> Oh, right.  Yeesh, that's subtle.  All the more reason to burn with fire.
>
> > >  - Two vCPUs end up using asid=3D2 on the same pCPU.
> > >
> > > The "svm->current_vmcb->cpu !=3D vcpu->cpu" check is also sketchy, bu=
t I don't think
> > > it's outright wrong?
> > >
> > > Ugh.  Jumping back a bit, I _was_ going to say that we could revert 1=
93015adf40d
> > > and then do:
> > >
> > > diff --git arch/x86/kvm/svm/svm.c arch/x86/kvm/svm/svm.c
> > > index b4845e452e69..4c8e2fcd378e 100644
> > > --- arch/x86/kvm/svm/svm.c
> > > +++ arch/x86/kvm/svm/svm.c
> > > @@ -1310,12 +1310,6 @@ void svm_switch_vmcb(struct vcpu_svm *svm, str=
uct kvm_vmcb_info *target_vmcb)
> > >  {
> > >         svm->current_vmcb =3D target_vmcb;
> > >         svm->vmcb =3D target_vmcb->ptr;
> > > -
> > > -       /*
> > > -       * Workaround: we don't yet track the ASID generation
> > > -       * that was active the last time target_vmcb was run.
> > > -       */
> > > -       svm->asid_generation =3D 0;
> > >  }
> > >
> > >  static int svm_vcpu_create(struct kvm_vcpu *vcpu)
> > > @@ -4531,6 +4525,9 @@ static __no_kcsan fastpath_t svm_vcpu_run(struc=
t kvm_vcpu *vcpu, u64 run_flags)
> > >         sync_lapic_to_cr8(vcpu);
> > >
> > >         if (unlikely(svm->asid !=3D svm->vmcb->control.asid)) {
> > > +               if (svm->vmcb->control.tlb_ctl !=3D TLB_CONTROL_FLUSH=
_ALL_ASID)
> > > +                       svm->vmcb->control.tlb_ctl =3D TLB_CONTROL_FL=
USH_ASID;
> > > +
> > >                 svm->vmcb->control.asid =3D svm->asid;
> > >                 vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
> > >         }
> > >
> > >
> > > But after reading the cover letter[*], I can't tell if 193015adf40d w=
as a bug
> > > fix for a dirty/clean bits bug, a bug fix for ASID reuse, or an optim=
ization (I
> > > thought it was an optimization until reading the cover letter and loo=
king more
> > > at commit af18fa775d07 ("KVM: nSVM: Track the physical cpu of the vmc=
b vmrun
> > > through the vmcb").
> > >
> > > So yeah, hit this with a hammer and defer the proper fix to your clea=
nup series,
> > > because I have low confidence that doing a proper fix is the safest a=
pproach for
> > > LTS kernels.
> >
> > I can send a new version dropping conditioning the reset on
> > svm->nested.initialized and dropping the change in
> > svm_allocate_nested(), is this what you had in mind?
>
> Keep the change in svm_allocate_nested().  Or just do nothing, I'll happi=
ly drop
> the svm->nested.initialized check when applying.

You'll need to update the changelog too.

Instead of:

Additionally, initialize the tracker pCPU for vmcb02 to -1 on nested
enablement, so that the new ASID allocation in the scenario above
happens even if EFER.SVME is disabled in L1 before migrating to the new
pCPU (so asid_generation in vmcb02 is not reset), but enabled before
returning to the old pCPU.

Maybe:

Additionally, initialize the tracked pCPU for vmcb02 to -1 on nested
enablement as hardening, so that a new ASID allocation is always
triggered when nested is disabled and re-enabled.

Let me know if you still wanna fixup when applying or a v2 :)
