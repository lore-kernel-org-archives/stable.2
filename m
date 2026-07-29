Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE518469820
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785343964; cv=none; b=ovUtSMQNt7lsr7rvbXFeCSuu9I+yx924ck7ZxCiKTKCC8mZ4dHwzgR/9fG1aP4e/1iM6UVWfB64cszy5KhiiWfXFTneUXZLGr0Txu76vdqr4iJUvEjR5o7k5hpvfmcZCWm1jBMoRGaTpjtACBWYXZnqnr8hxQ/PMKKBmU0cwUQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785343964; c=relaxed/simple;
	bh=yZ6keUU//SyAf3odXLA3e6PUQbHpD9sJojWOqafguUU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VFT7IWvFy9gO68Ryt3fTn/Q+6Bn2CxjdAXv5jfIEPRangMNiSVZ4enayBNG2qfT5yvibqqRHO9Mf6SNlPtUrjH//tkFHcHgjDSUVJDarsuM8K/zG5He3Z9pMeTYEO5SEqJic9+2BiePSO2IjnKzJD8VB4kfEFxQogprgf+jjUuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JGXtcrNR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JGXtcrNR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 649841F000E9
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785343963;
	bh=7ehxLdevH6pV5fmYhYDwtO8w9XgXnocWaWew6zHoG4Y=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=JGXtcrNRfHCEG+iHrkOM+Ah2X6b4FOjFv+BAZO9LqnY9eW1REeMCQcmIr36nCq03h
	 sayHxhpzt6sR3KkxJka1BAr4pvdPJxubgzJisLvkb8eur6sm/o3Bvh12NxOz5yaxiP
	 L0TQ24p6KKb/kQnDB7qR8XRPKINltfpH6rJKZ44ngYsZ3pij46BPiYysYbPKCsDA5/
	 Ioqwwgxj3+kYR/+W/VVwNs2V1AGx/+J/yezG8oTWaHt86v2rABdTl9Gwpa1sverWvW
	 iMWM1zpk05m2nRY9QHVfMQd8S1NfjvuPLK616GZNC3XUqFpVl+fOBlVX9/RxthIZq3
	 AghegzoAtE5AA==
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c15f020a223so189726966b.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 09:52:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RqgLuulAtqTanyWJygTfFiLH9OinWJUEuqpOVvchV4diU1VtlNfJfYj+/VIb1q+N0BfQCg+/cw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TpwAPOipqrlAf7g0lIRXLkDM/gtDQkcgoVFFr8xfnR/eqML1
	FqKB2LuCCdseinpPQ8az0bUBWJdD8HRho0tgomab6BB7gCvRQ4l1Kfv+NwfgTGyJ1UHv6h56597
	2GjcOAktgXb0us86hNkYtDABOJLUxoA4=
X-Received: by 2002:a17:907:3d05:b0:c1c:4db7:c9fd with SMTP id
 a640c23a62f3a-c1f71d63e55mr435322766b.3.1785343962370; Wed, 29 Jul 2026
 09:52:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
 <CALMp9eRhWq+MXj8zax8hS48eZVE031kctfa=SC1ngT31iBtC5w@mail.gmail.com>
In-Reply-To: <CALMp9eRhWq+MXj8zax8hS48eZVE031kctfa=SC1ngT31iBtC5w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 29 Jul 2026 09:52:31 -0700
X-Gmail-Original-Message-ID: <CAO9r8zPe0ONLFaL+ZLM4qs=8EeUzd+Gn+vzsOxryga3SsK4e7w@mail.gmail.com>
X-Gm-Features: AUfX_mzAl4e7KHz633mEpJH_gK_fq3uzIjGy1NU7D5kCJU9XvpMXKlTwbeNiy0k
Message-ID: <CAO9r8zPe0ONLFaL+ZLM4qs=8EeUzd+Gn+vzsOxryga3SsK4e7w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 9:53=E2=80=AFPM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Mon, Jul 13, 2026 at 11:04=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> w=
rote:
> >
> > When handling userspace SREGS writes, check the validity of EFER (i.e.
> > allowed bits) before writing the new value of EFER through the
> > per-vendor set_efer callbacks. This prevents userspace from writing
> > bogus values (e.g. EFER.SVME=3D1 with nested=3D0).
> >
> > Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
> > caps, not guest caps, so it is possible to set EFER bits that are
> > supported by KVM but not by the guest CPUID. Potentially allowing
> > userspace to set msrs before CPUID.
> >
> > However, for KVM_SET_SREGS*, check the validity of the set bits against
> > both KVM and guest caps. This is consistent with other validity checks
> > (e.g. for CR4) that check validity against guest caps, which already
> > imposes the need to set CPUID before SREGS.
>
> Where is the requirement to set CPUID before SREGS documented, aside
> from this commit message?

I don't think so, and also coming back to this again I think the
commit message is wrong. The whole basis for doing validity checks
against guest CPUID (other than the convenience of using
kvm_valid_efer()) is cr4_guest_rsvd_bits, which is initialized based
on both KVM caps and guest CPUID.

However, cr4_guest_rsvd_bits seems to be initialized *after* CPUID is
set, so it only checks CR4 against CPUID if userspace already set
CPUID. It doesn't impose a restriction to set CPUID before SREGS, but
this patch is.

So I think this may be too restrictive. We should probably only check
against KVM caps, which was the whole motivation of this patch to
begin with (disallowing EFER.SVME if nested=3D0). Maybe we should just
drop the Cc:stable as it won't apply to any of the stable trees any
way, and do this on top of the kvm_caps.supported_efer_bits changes?

diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
index 8f66438989e47..412a37ca86ecc 100644
--- a/arch/x86/kvm/regs.c
+++ b/arch/x86/kvm/regs.c
@@ -565,7 +565,7 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu
*vcpu, struct kvm_sregs *sregs)

        return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
               kvm_is_valid_cr0(vcpu, sregs->cr0) &&
-              kvm_valid_efer(vcpu, sregs->efer);
+              !(sregs->efer & ~kvm_caps.supported_efer_bits);
 }

 static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *sre=
gs,

---

diff --git a/tools/testing/selftests/kvm/x86/set_sregs_test.c
b/tools/testing/selftests/kvm/x86/set_sregs_test.c
index 603226ffe4374..c07ccf0bbe85a 100644
--- a/tools/testing/selftests/kvm/x86/set_sregs_test.c
+++ b/tools/testing/selftests/kvm/x86/set_sregs_test.c
@@ -171,7 +171,6 @@ int main(int argc, char *argv[])
         */
        vm =3D vm_create_barebones();
        vcpu =3D __vm_vcpu_add(vm, 0);
-       test_efer_bits(vcpu, KVM_ALWAYS_ALLOWED_EFER);
        test_cr_bits(vcpu, KVM_ALWAYS_ALLOWED_CR4);
        kvm_vm_free(vm);

---

Sean, WDYT?

If we will change this, would you rather do it in place, a followup
fix, or a new version?
