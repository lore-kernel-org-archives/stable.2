Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 568CE51AEE9
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791902987; cv=none; b=b3x2A62N89RTmEwKI8iQOsPCBFEmlLVRLi5+cw1pospKZFxrkmUE2/goIkcOZ68rfcZ2pI7cAKPHUaXxkj/LmEl5fVB4ePxBenQ0OjSKjR/CwUd8SfUpCdIQC0rlV8B56hZne4BgDCQwB/3hpecFU8PfXW6s23yrKnSVwXFBue0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791902987; c=relaxed/simple;
	bh=kzfUibjmfz+BWp2vtACff4io5N0EKyuZUYSUqRhNKwA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=puAWJ79sk4O7pxgGefLMaP7CQjIr61SrdnUVoz2vVB46z0CBO2D6XnLP3lMYPu3M5kF8bwxHlS3PVdgum7ERCi4VJWrXaMXRgEEWYbZcrzj6Nqw9BwDYEVo1tPx/DUKxR+/t9pFrvXrRUmqa65ynbxMHZ7uZ0jR1nXvjSNbI+Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UxvP2iSd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UxvP2iSd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EC01F0089D
	for <stable@vger.kernel.org>; Tue, 13 Oct 2026 14:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791902986;
	bh=Xk0bia0wGEL+ZVRs/OEBd3mcvMKkTlwfLW9T5doIEdQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=UxvP2iSdi5GgZeYKArjnDKLKPh5wmm/dejVIzs80PIEF33v0Y69PIkVVTHGcrTce3
	 SSI49t7s3bu1bPH04iq6H3igtiub2yNsXFSugtkZqG/lF7bqWOxbSkYh7nELimYw40
	 du1QPGVaA5S0Ob2CpZeh10+9wtcJ8r9Nfn4UVlUhETa0OFw+LtDkD0JukcmU8mvfkd
	 yQwZugsB52Ayg0Y/Ln547BVSuYqZ4sFc/HqKq/jIK30ABUOnhoneORFfr1aciFiJoI
	 xpaahaEcNYUfoDiStAtQEKl34msqSiz9jJU3so3+cRN85N9N7GQUykeszn+wFkGuWC
	 yxV+AAr9Yxgdw==
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-91968804af0so34703506d6.2
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 07:49:46 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzUa5e3m5YxwAmeGEalVcVtBjiTZfkvDG1xtzpFUOlaEoXyvCzePmXGqTEe0KnQa8Z9Nth8pl4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJYTZsBLZynub6w44zxBEreilWc5NhT43YPnaoKPWOkEBTSOcQl
	M6JccR5VCirjuaRRr+Ik6wheNiHvyHlcJFQylnM6BFP0YaDFtTofFbymp5JB5dIIwZqcybz0fBt
	/VBQQd7YzC9hRgjqJpC/wbCQw+4ruLQY=
X-Received: by 2002:a05:620a:198b:b0:92e:76a1:96cd with SMTP id
 af79cd13be357-93ebd1e041emr2175761285a.13.1791902985432; Tue, 13 Oct 2026
 07:49:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261012224736.2306637-1-yosry@kernel.org> <CALMp9eT6eJSDaJVJ_1mrn8-sP6F88q-OcGrEgUWy-YpAkuA9vg@mail.gmail.com>
In-Reply-To: <CALMp9eT6eJSDaJVJ_1mrn8-sP6F88q-OcGrEgUWy-YpAkuA9vg@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Tue, 13 Oct 2026 07:49:31 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com>
X-Gm-Features: AclHuK9xJBp-Vsd-n1koDePDqGfjuO5ptyn-EvDSLGQFyT0K7N46CCWugVLQ1TA
Message-ID: <CAO9r8zMsih9vRJFWgbE=bgWAqBzwPO3KJiAyBVA_hJBgjPp6mQ@mail.gmail.com>
Subject: Re: [PATCH] KVM: SVM: Update tracked pCPU on pCPU switch
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Stefan Teodorescu <fane@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 12, 2026 at 4:58=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Oct 12, 2026 at 3:47=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > When a pCPU switch is detected in pre_svm_run(), update the tracked pCP=
U
> > and mark all fields dirty in both VMCBs (if nested is initialized), in
> > addition to resetting the ASID generation in both VMCBs.
> >
> > Commit bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both
> > VMCBs on pCPU switch") reset the ASID generation in both VMCBs on a pCP=
U
> > switch, but only updated the tracked pCPU for the active VMCB to avoid
> > unnecessarily dirtying the inactive VMCB. Leaving the inactive VMCB's
> > tracked pCPU set to an old pCPU still allows an ASID allocated on one
> > pCPU to be used on another:
> >
> > - vCPU runs with both vmcb01 and vmcb02 on pCPU A (both track cpu=3DA).
> > - With vmcb01 active, vCPU migrates to pCPU B. vmcb01.cpu is updated to
> > B, asid_generation is reset to 0 in both VMCBs, and a new ASID is
> > allocated on pCPU B (setting vmcb01.asid_generation =3D gen_B).
> > vmcb02.cpu remains A.
> > - vCPU switches to vmcb02 and migrates back to pCPU A before
> > pre_svm_run(). Because vmcb02.cpu is still A, no pCPU switch is
> > detected, leaving vmcb01 with cpu=3DB and asid_generation=3Dgen_B.
> > Because vmcb02.asid_generation is 0, a new ASID (asid_A) is allocated
> > on pCPU A.
> > - vCPU switches back to vmcb01 and migrates to pCPU B. Neither a pCPU
> > change nor a generation mismatch is detected for vmcb01, so VMRUN on
> > pCPU B uses asid_A (allocated on pCPU A), which may collide with
> > another vCPU on pCPU B.
>
> By "collide," you mean that two vCPUs, potentially from different VMs,
> will share TLB and paging-structure cache entries? Yikes!

Potentially, yes.

>
> > Because the per-VMCB cpu tracking is shared between ASID management and
> > per-pCPU hardware VMCB clean bits, also mark both VMCBs dirty when
> > updating their tracked pCPU so that the inactive VMCB does not run with
> > stale clean bits when later entered on the new pCPU.
> >
> > Fixes: bf260dc9e7b8 ("KVM: SVM: Trigger new ASID allocation in both VMC=
Bs on pCPU switch")
>
> Commit bf260dc9e7b8 hasn't made it to Linus yet, has it? Perhaps Sean
> can just squash this in, rather than carrying a fix for a fix.

That would be ideal.

>
> > Cc: stable@vger.kernel.org
> > Reported-by: Stefan Teodorescu <fane@google.com>
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/svm/svm.c | 20 +++++++++++++++-----
> >  1 file changed, 15 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
> > index 136069dfcd44f..0a0af0cbb6bba 100644
> > --- a/arch/x86/kvm/svm/svm.c
> > +++ b/arch/x86/kvm/svm/svm.c
> > @@ -3880,7 +3880,8 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
> >
> >         /*
> >          * If the previous VMRUN of the VMCB occurred on a different ph=
ysical
> > -        * cpu, then mark the VMCB dirty as hardware's clean bits are p=
er pCPU.
> > +        * cpu, mark the VMCB dirty and reset the ASID generation, as h=
ardware's
> > +        * clean bits and ASIDs are per pCPU.
> >          *
> >          * Reset the ASID generation in both VMCBs. This will lead to a=
ssigning
> >          * a new ASID now, and then again when switching to the other V=
MCB.
> > @@ -3892,13 +3893,22 @@ static int pre_svm_run(struct kvm_vcpu *vcpu)
> >          * - The new VMCB does not detect a pCPU change and runs on pCP=
U A with
> >          *   the new ASID allocated on pCPU B, which is potentially use=
d by
> >          *   another vCPU/VM.
> > +        *
> > +        * Note that dirtying both VMCBs is not strictly needed, but th=
e per-CPU
> > +        * tracking is shared for both ASID and clean bits, and that CP=
U must
> > +        * match where the ASID was allocated.
>
> Is dirtying both VMCBs not strictly needed?
>
> Per APM vol. 2 (rev. 3.45), section 15.15.2:
>
> > The hypervisor must clear the entire VMCB [Clean] field to 0 for a gues=
t, under the following circumstances:
> > ...
> >  - The hypervisor executes the guest on a different CPU core than one u=
sed the last time that guest was executed.
> > ...
> > Failure to clear the VMCB Clean bits to zero in these cases may result =
in undefined behavior.
>
> Suppose vmcb02 runs on pCPU A, migrates to (and runs on) pCPU B, and
> then migrates back to pCPU A with some clean bits set. At the next
> VMRUN, pCPU A will happily load stale state for anything marked clean.
>
> At some point before that VMRUN, something has to clear the clean bits!

Dirtying both VMCBs is not needed in all cases covered with the new
code here. IIUC, clean bits are VMCB-specific, unlike the ASID here
which is shared.

Because ASID is shared, we have to reset the ASID generation for both
VMCBs when a new ASID is allocated through either, and update the cpu
variable tracking which pCPU allocated that ASID. Since that cpu
variable is also shared for tracking which pCPU ran the VMCB last, we
also need to clear the clean bits every time we updated. IOW, if we
had two variables, asid_cpu and vmcb_dirty_cpu, we would need to
update asid_cpu on pCPU migration for both VMCBs, but only update
vmcb_run_cpu for the current VMCB.

This is all annoying and confusing, but that should go away in the
static ASIDs series, and we should go back to only updating pCPU
tracking, flushing the ASID, and clearing the clean bits only for the
current VMCB.
