Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4F03B4E87
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785348861; cv=none; b=OUoy+zd+xRSWuTtuEkWfiQKndNhVvUfK9da6Iu5g53/A+l8mwk8B9+acf7OOyo86Ope0GxkqSzq0tFdfY/+W759LZk05ISNd4WfgZIk5o9c3TGYrkXEtG7kZHJbS9juffuFoV3XC7kBUMPgr3FboMW4j2Po4eJlgHDk4MIe1bBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785348861; c=relaxed/simple;
	bh=nXvxhyCrLtuyKc3HaJEGA/kPIG4/7IU3AHxrZWgGmcI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bc94n6Mr1OXiE092Wj+3MVCiXxU5lQJQvGCv3rtYKQEvM+Ad0bvRPWibDaBKsMztWoVkiFA+0x7JDNYCpDy0SCfDpi6G4PXw9nelcGeoNFIpCOIk9/vS326LQEcQs8pNxfquQsajHYtZhAoDAo/zy5p96loIPiLhXGW+ByeCnR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Idq6+qHO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Idq6+qHO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442D61F00A3A
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 18:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785348859;
	bh=exmMkvw0Kbsw2gErktHRjURFCx5Kr1AFKum0kLUFv6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Idq6+qHO9Uo8aX7Sy61XGftWDSr/adFLWdyzY8izz3yTFrapaq6TuwJmT6YAE0DTj
	 fcP45rFjDH4qZNLnu4bJKC9bZb/cxA6GD9dVTqzmxbMkalm5Owj0pgkxb7q1vp0MXs
	 huDacu6tLB/mcJuHoDVjoOD1GCvU+LHewFd20KbtcuFtZETnIeOFDNPcAdSVr8blxZ
	 FIRDHYFzYekTQG9R3rA4B0KYI5MpDJ0Lx1liD2dwUjtOPc+YuX+GfIYroyvW3IH5LQ
	 CQxgKu1u7f4UPf/gouLUST8kfDSo6QHQoy5afWhcBiCy8loyovDGD1tIKw3GE/6mRL
	 VLDYk73nM4Mog==
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c1f5208b38dso242194066b.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 11:14:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrbY26fKyrUDWCEbMrRLhcMT7T2ILaVtC1LcBi+hIN8/NUIDUy9XnKjI3srOe6lvg2Hx/+t8xw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywvgg5nz1JMRPWlGXiGIVuQZOah3AeRxmNqZZ3O3y16sqsXaald
	IAm5urYmgY19w2gf4vp4p6wv+kcQQ8qIWbhd29aWXh/IRjo6TeXb1fJ7jgUtdJbUdeiVPi3JURr
	wKvV8qthpQM6jGQH2fVnBaY0xY99p7Ss=
X-Received: by 2002:a17:907:1787:b0:c15:ff7a:e56d with SMTP id
 a640c23a62f3a-c1f7215114dmr410786166b.51.1785348858159; Wed, 29 Jul 2026
 11:14:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260713180153.2728382-1-yosry@kernel.org> <20260713180153.2728382-2-yosry@kernel.org>
 <CALMp9eRhWq+MXj8zax8hS48eZVE031kctfa=SC1ngT31iBtC5w@mail.gmail.com> <CAO9r8zPe0ONLFaL+ZLM4qs=8EeUzd+Gn+vzsOxryga3SsK4e7w@mail.gmail.com>
In-Reply-To: <CAO9r8zPe0ONLFaL+ZLM4qs=8EeUzd+Gn+vzsOxryga3SsK4e7w@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 29 Jul 2026 11:14:06 -0700
X-Gmail-Original-Message-ID: <CAO9r8zOrCMqBSnxqxnqj1M1Mmr5wMU0H9uVeNuOYKLwhvQA0Sg@mail.gmail.com>
X-Gm-Features: AUfX_mynzWvzboeMQfBAgSWIRLhEXTy3IK-N4jvqG-A9FNzHuoOCg0oOqU9ikZE
Message-ID: <CAO9r8zOrCMqBSnxqxnqj1M1Mmr5wMU0H9uVeNuOYKLwhvQA0Sg@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] KVM: x86: Check EFER validity on KVM_SET_SREGS*
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 29, 2026 at 9:52=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Tue, Jul 28, 2026 at 9:53=E2=80=AFPM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Mon, Jul 13, 2026 at 11:04=E2=80=AFAM Yosry Ahmed <yosry@kernel.org>=
 wrote:
> > >
> > > When handling userspace SREGS writes, check the validity of EFER (i.e=
.
> > > allowed bits) before writing the new value of EFER through the
> > > per-vendor set_efer callbacks. This prevents userspace from writing
> > > bogus values (e.g. EFER.SVME=3D1 with nested=3D0).
> > >
> > > Note: on KVM_SET_MSRS, KVM only checks EFER validity in terms of KVM
> > > caps, not guest caps, so it is possible to set EFER bits that are
> > > supported by KVM but not by the guest CPUID. Potentially allowing
> > > userspace to set msrs before CPUID.
> > >
> > > However, for KVM_SET_SREGS*, check the validity of the set bits again=
st
> > > both KVM and guest caps. This is consistent with other validity check=
s
> > > (e.g. for CR4) that check validity against guest caps, which already
> > > imposes the need to set CPUID before SREGS.
> >
> > Where is the requirement to set CPUID before SREGS documented, aside
> > from this commit message?
>
> I don't think so, and also coming back to this again I think the
> commit message is wrong. The whole basis for doing validity checks
> against guest CPUID (other than the convenience of using
> kvm_valid_efer()) is cr4_guest_rsvd_bits, which is initialized based
> on both KVM caps and guest CPUID.
>
> However, cr4_guest_rsvd_bits seems to be initialized *after* CPUID is
> set, so it only checks CR4 against CPUID if userspace already set
> CPUID. It doesn't impose a restriction to set CPUID before SREGS, but
> this patch is.
>
> So I think this may be too restrictive. We should probably only check
> against KVM caps, which was the whole motivation of this patch to
> begin with (disallowing EFER.SVME if nested=3D0). Maybe we should just
> drop the Cc:stable as it won't apply to any of the stable trees any
> way, and do this on top of the kvm_caps.supported_efer_bits changes?
>
> diff --git a/arch/x86/kvm/regs.c b/arch/x86/kvm/regs.c
> index 8f66438989e47..412a37ca86ecc 100644
> --- a/arch/x86/kvm/regs.c
> +++ b/arch/x86/kvm/regs.c
> @@ -565,7 +565,7 @@ static bool kvm_is_valid_sregs(struct kvm_vcpu
> *vcpu, struct kvm_sregs *sregs)
>
>         return kvm_is_valid_cr4(vcpu, sregs->cr4) &&
>                kvm_is_valid_cr0(vcpu, sregs->cr0) &&
> -              kvm_valid_efer(vcpu, sregs->efer);
> +              !(sregs->efer & ~kvm_caps.supported_efer_bits);
>  }
>
>  static int __set_sregs_common(struct kvm_vcpu *vcpu, struct kvm_sregs *s=
regs,
>
> ---
>
> diff --git a/tools/testing/selftests/kvm/x86/set_sregs_test.c
> b/tools/testing/selftests/kvm/x86/set_sregs_test.c
> index 603226ffe4374..c07ccf0bbe85a 100644
> --- a/tools/testing/selftests/kvm/x86/set_sregs_test.c
> +++ b/tools/testing/selftests/kvm/x86/set_sregs_test.c
> @@ -171,7 +171,6 @@ int main(int argc, char *argv[])
>          */
>         vm =3D vm_create_barebones();
>         vcpu =3D __vm_vcpu_add(vm, 0);
> -       test_efer_bits(vcpu, KVM_ALWAYS_ALLOWED_EFER);
>         test_cr_bits(vcpu, KVM_ALWAYS_ALLOWED_CR4);
>         kvm_vm_free(vm);
>
> ---
>
> Sean, WDYT?
>
> If we will change this, would you rather do it in place, a followup
> fix, or a new version?

I take this back, I think I was right the first time.
kvm_vcpu_after_set_cpuid() is called on vCPU creation (confusing?),
and looking closely at set_sregs_test seems like it specifically
verifies that CR4 bits guarded by CPUID bits cannot be set before
CPUID is set.

I think the main difference here is probably that CR4 bits that are
guarded by CPUID are more "advanced" than EFER bits?
