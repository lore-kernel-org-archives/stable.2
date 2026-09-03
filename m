Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A99E44CF2F
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 22:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788473900; cv=none; b=p1wObOWKPujoeB86mlTr3rIv3yfqx8ur0mffvLmavDiQY4aqRAfqqvD/1QVyeVm0Wnf+NBg4mLv3t2fztd81zdSpuMUHPb8LigZJpW0zKBf0BJ+m5fE0KT0PL3BVP5N5a/yK0L/sttDusdaLIGQTUJseGyQwECGWqag1grYWFJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788473900; c=relaxed/simple;
	bh=+wE9E9jL9x1acVAF/xZjpv+w+t6AX4qnd2tXKkPaYZo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XdkY8Dk+jmcywHw4Id+K7CEGDKltJey5gFLFcmRBK43MbPdyHW19c9hQjGbL+6EnGhbJqIlCWbUC7+aQG/+sIvU1be1/kN322M0xvbjStm5C8e5HZl6qlpmjQucM4rswTTIrSjZ7KvhiUiJkeG8+3CZyLOpL4OMVzqvvuOWAxiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VpiHWsI1; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VpiHWsI1"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2d6f75c1219so6534945ad.3
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 15:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788473897; x=1789078697; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xMhTt4jexs1ASzs4/CO4GgX4E09m8qb9vlwIOP+7h7E=;
        b=VpiHWsI1dC06F7FLteXdX7dGh4TLujNxE1o0oDpb0hWii1bN5kNbNiT1a4CzwUyOXX
         GPhAIuuiVruzaRhkvCEY92p9P0s1gYZoJrdOzaSvC20S29CJrZPmQruGNB08nHykDcc1
         BKSJuXkPBcBGiv9/WdI0oNDSY9xZmDKLFauEGx3TuvZjVW9w9BCbb2kpJeAFRJLlcQWO
         eEZO98quYzjTyPlOuJElHMasFiJ3eprFQHaOT6ggmY+eyeCkNnSJ2GbbrgfJTXIdnfi5
         eZsfU+UHzgnsI0YbCmyJfqNNzwT4i+cmuealyePxWBqoayratJiXufSNu9BCvsLh52tU
         Ahag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788473897; x=1789078697;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xMhTt4jexs1ASzs4/CO4GgX4E09m8qb9vlwIOP+7h7E=;
        b=c19MKWFrHr2B25WmoRT7mnCSN7ZjpQbXDEBLTxDAEAyoWI/dVlXmYoj8MMWDD7rm9a
         nmsUsc8cvnD4lKs6txNeAOvMQ8SMoVfNa+zpbjudkSwTC9PRfGcJu9fSQOhLWbrc2iAU
         gsgfrEHrfdFEFibN+SRJAmJailz+bHKYnqQ1Lo8+iOy9Z0vrc1BPbAgeVg375Ye0mR2S
         FRMBoqhP5ElDQ0y5LdUqUtbBCcrjpeNc/AgfZXenHBokyn0tsh8HwqD2i3kh5GQVaXXF
         IFVe48U8IBcA4LJ13fbuenK2a8q2lhw9d9xDYr/WBdDB/tO2D7pvd4qzzc3gzuS7RHWg
         +G/Q==
X-Forwarded-Encrypted: i=1; AKwUvBxaBOJPmoBQt2TEZFctcj+YX+TaiyQi+Yd1TOvwDpHYP5yfojxDma21iXeKjMjaIQ+cIOF5xk0=@vger.kernel.org
X-Gm-Message-State: AFuF++lvkMG64z42ho/vnUBO0iCSIRNqMioJXaV0Zu8hDDWTilv4Fhy/
	v4Oa7R5cMMqGtm1dWe7t76P1Kn82USPsYosaqrkRaFPXsEb15tPt+k2j4rKkCC7KDgn14wu6sgf
	bsx81Rw==
X-Received: from plbbg4.prod.google.com ([2002:a17:902:8e84:b0:2ce:d2e2:393])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:b8d:b0:2d7:1e07:4859
 with SMTP id d9443c01a7336-2db125cd33emr33796695ad.2.1788473897204; Thu, 03
 Sep 2026 15:18:17 -0700 (PDT)
Date: Thu, 3 Sep 2026 15:18:16 -0700
In-Reply-To: <CAO9r8zPcvZpy=379oWNY_+p2XZ74On5LPL+53evbRqq5OD1H=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260903175856.4065099-1-yosry@kernel.org> <apnqonqMBZ2GeGEq@google.com>
 <CAO9r8zPcvZpy=379oWNY_+p2XZ74On5LPL+53evbRqq5OD1H=g@mail.gmail.com>
Message-ID: <apnyKNY_FKFWtDNK@google.com>
Subject: Re: [PATCH] KVM: SVM: Trigger new ASID allocation in both VMCBs on
 pCPU switch
From: Sean Christopherson <seanjc@google.com>
To: Yosry Ahmed <yosry@kernel.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 03, 2026, Yosry Ahmed wrote:
> On Thu, Sep 3, 2026 at 2:53=E2=80=AFPM Sean Christopherson <seanjc@google=
.com> wrote:
> > >       if (unlikely(svm->current_vmcb->cpu !=3D vcpu->cpu)) {
> > > -             svm->current_vmcb->asid_generation =3D 0;
> > >               vmcb_mark_all_dirty(svm->vmcb);
> > >               svm->current_vmcb->cpu =3D vcpu->cpu;
> > > +             svm->vmcb01.asid_generation =3D 0;
> > > +             if (svm->nested.initialized)
> >
> > Isn't conditioning the clear on nested.initialized wrong?  It's stupidl=
y contrived,
> > but I think it can happen?  Even if it can't, I don't see any reason to=
 conditionally
> > zero vmcb02.asid_generation.  Either it's buggy or it's a wash in terms=
 of performance.
>=20
> Oh yeah it's not needed. I thought the generation is only allocated
> when svm->nested.initialized, but that's not true it's always there.
> So yeah we can just always zero it, and then we can drop the change in
> svm_allocate_nested() too, or keep it as hardening (it seems like a
> good idea in general)?

Definitely keep it as hardening.

> >  - vCPUx runs on pCPU A, vmcb02 is active, asid=3D1.
> >  - vCPUx migrates to pCPU B, vmcb02 pCPU changes, new asid=3D2.
> >  - vCPUz runs on pCPU A and allocates asid=3D2 as well.
> >  - vCPUx switches to vmbc01 and disabled nested, but doesn't run, e.g. =
because
> >    userspace stuffs EFER.
>=20
> IIUC, here userspace wrote EFER.SVME=3D0..
>=20
> >  - vCPUx migrates back to pCPU A, and zeroes vmcb01.asid_generation, bu=
t not
> >    vmcb02.asid_generation.
> >  - vCPUx switches to vmcb02, without running vmcb01, again thanks to us=
erspace.
>=20
> ..and here it wrote EFER.SVME=3D1, in which case svm_allocate_nested()
> should set svm->nested.vmcb02.cpu =3D -1..
>=20
> >  - vCPUx does VMRUN on vmcb02 with asid=3D2.
>=20
> ..and we allocate a new ASID here?

Oh, right.  Yeesh, that's subtle.  All the more reason to burn with fire.

> >  - Two vCPUs end up using asid=3D2 on the same pCPU.
> >
> > The "svm->current_vmcb->cpu !=3D vcpu->cpu" check is also sketchy, but =
I don't think
> > it's outright wrong?
> >
> > Ugh.  Jumping back a bit, I _was_ going to say that we could revert 193=
015adf40d
> > and then do:
> >
> > diff --git arch/x86/kvm/svm/svm.c arch/x86/kvm/svm/svm.c
> > index b4845e452e69..4c8e2fcd378e 100644
> > --- arch/x86/kvm/svm/svm.c
> > +++ arch/x86/kvm/svm/svm.c
> > @@ -1310,12 +1310,6 @@ void svm_switch_vmcb(struct vcpu_svm *svm, struc=
t kvm_vmcb_info *target_vmcb)
> >  {
> >         svm->current_vmcb =3D target_vmcb;
> >         svm->vmcb =3D target_vmcb->ptr;
> > -
> > -       /*
> > -       * Workaround: we don't yet track the ASID generation
> > -       * that was active the last time target_vmcb was run.
> > -       */
> > -       svm->asid_generation =3D 0;
> >  }
> >
> >  static int svm_vcpu_create(struct kvm_vcpu *vcpu)
> > @@ -4531,6 +4525,9 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct =
kvm_vcpu *vcpu, u64 run_flags)
> >         sync_lapic_to_cr8(vcpu);
> >
> >         if (unlikely(svm->asid !=3D svm->vmcb->control.asid)) {
> > +               if (svm->vmcb->control.tlb_ctl !=3D TLB_CONTROL_FLUSH_A=
LL_ASID)
> > +                       svm->vmcb->control.tlb_ctl =3D TLB_CONTROL_FLUS=
H_ASID;
> > +
> >                 svm->vmcb->control.asid =3D svm->asid;
> >                 vmcb_mark_dirty(svm->vmcb, VMCB_ASID);
> >         }
> >
> >
> > But after reading the cover letter[*], I can't tell if 193015adf40d was=
 a bug
> > fix for a dirty/clean bits bug, a bug fix for ASID reuse, or an optimiz=
ation (I
> > thought it was an optimization until reading the cover letter and looki=
ng more
> > at commit af18fa775d07 ("KVM: nSVM: Track the physical cpu of the vmcb =
vmrun
> > through the vmcb").
> >
> > So yeah, hit this with a hammer and defer the proper fix to your cleanu=
p series,
> > because I have low confidence that doing a proper fix is the safest app=
roach for
> > LTS kernels.
>=20
> I can send a new version dropping conditioning the reset on
> svm->nested.initialized and dropping the change in
> svm_allocate_nested(), is this what you had in mind?

Keep the change in svm_allocate_nested().  Or just do nothing, I'll happily=
 drop
the svm->nested.initialized check when applying.
