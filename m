Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D239932779D
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 15:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789139847; cv=none; b=kF2qhUQ1/bjRnnABYpNjHI5LEi4eiQgCaIqsCQ/A5enujN1x2Gb8ea6bNoTcjbFMvhNKBVyC1AYfFYOls4BJH70ck4S+cQrbnwRwdMlt6a44Z1lV43o2o1i3Wm2/eLC42MuG5qKXgDlSqFlBknB3hvU/mlJ0xw6NfibAZC3yvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789139847; c=relaxed/simple;
	bh=efrWbnPzSCOA1sTxkkExMlXP98/KqkN8F1UUFEHHZ90=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qqY61YmNjcGx21BiFS63qQFJJE5qnOFjDqklCuqw8B54KQA/R2nOABd2S3uGEzQ/FPtLryrruaPDjHjRCtaSpujjqqMeu3x0Z2f2wdH9JkFxRsGd/PE/IoGX9k0JacTq17rwaYSQAPyXhEsrR44vxaRaqXunNoysWh5IptAhkP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QzZIWGFh; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QzZIWGFh"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3968bb86fb7so1322328a91.2
        for <stable@vger.kernel.org>; Fri, 11 Sep 2026 08:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789139845; x=1789744645; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=/VIzH3fcclvw4AXnBO3BO4tZuWWnQl1bNWKdePXc5bI=;
        b=QzZIWGFhKYDE75z11JeXZpCVWLR1BcDg478I/XJwDMP1+HxRjfUC62g/sfhtjmk16S
         gSm/rNATAyjLt1sm86KH4nbBE7mvY0Mshjeskt6Qtp+2iJM4gPk1RMgoNxwLd6Oyd6CB
         HbHQYfvexM6sx8CMrOeTe/q7R4cUkDdcYjqrQF7ZJucEeLGGGEstN9Rp6/4Pb7F8Faff
         7JIvIVfnrRYsXgQAShquvdGYuOPhdoFTZjMGJABuFqLAEuK2kAMRjvTwT6gso/ytLHlg
         HJ/FrLAeh1BiWtwlRhZOIi8daaOQT1ITxLoxYxDcPPvC4pCFiuCz6K+UvXykdB4FtpoI
         7M6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789139845; x=1789744645;
        h=content-transfer-encoding:content-type:cc:to:from:subject
         :message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VIzH3fcclvw4AXnBO3BO4tZuWWnQl1bNWKdePXc5bI=;
        b=mDp2nEaWfwY9fcj5JDiTNqiDHCEC/8k8B2oM7RV0m4K7CQTe/nopMEWsMxBzF0ejOd
         KVxHjmahaqTwQUhnnOfQ3bZP8lX116gPxtWPKzMO/xlTPuUKkqJW1ZCbnsIYoSm8C+9X
         Tv0s2ZrqWAnBxwgIQ79kVAAVvcxPXHNuVD/nhLZrgRdnQtJ1URy8nLe8XvqduvaQvwaH
         kvUphFCKZ63W+WA4c7B3VukR8N/zUQ9sQub+vPx1ocHuk7feNEvl7ql3sMLc/GkjdTYB
         6ExhNZJ3cruQ7KCTVPVmmWB7S+ZHHBMmSTP1Pl0otJeG/AJaFQiyqlEymXamH2tDQp+d
         XuuQ==
X-Gm-Message-State: AFuF++kNzEffCijDAbI768E+Ot5QDooc0MUxWnK8tkMJHNuaVfcqEiHX
	Nv2gJy6+sGgszXp23/Nzn/es+eIfOmkfwL6poxyZ/9Yjm3bC86uZ54aD+W1pqNCS2PDc18RN/tY
	ktwwJYg==
X-Received: from pjbjx9.prod.google.com ([2002:a17:90b:46c9:b0:38e:b97a:cfa1])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2641:b0:398:9bd1:3215
 with SMTP id 98e67ed59e1d1-39d9c352a63mr7856385a91.22.1789139844897; Fri, 11
 Sep 2026 08:17:24 -0700 (PDT)
Date: Fri, 11 Sep 2026 08:17:22 -0700
In-Reply-To: <20260911141350.763301-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2026090907-snuff-blot-3cf8@gregkh> <20260911141350.763301-1-sashal@kernel.org>
Message-ID: <aqQbgijDnBZds1rT@google.com>
Subject: Re: [PATCH 6.12.y] KVM: x86: Always initialize EFER reserved bits on
 vendor initialization
From: Sean Christopherson <seanjc@google.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026, Sasha Levin wrote:
> From: Yosry Ahmed <yosry@kernel.org>
>=20
> [ Upstream commit a4b8acd428ba3f03952ef309d7f438dbc357557b ]
>=20
> EFER reserved bits are statically initialized, and do not reset if a
> vendor module is re-loaded. For example, loading kvm_amd with nested=3D1
> removes EFER.SVME (and potentially EFER.LMSLE) from the reserved bits.
> Reloading kvm_amd with nested=3D0 does not add them back, allowing
> userspace to set EFER.SVME with nested=3D0.
>=20
> Re-initializing EFER reserved bits before configuring them on vendor
> initialization.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> Link: https://patch.msgid.link/20260713181020.2735367-4-yosry@kernel.org
> Signed-off-by: Sean Christopherson <seanjc@google.com>
> [ placed EFER initialization directly in x86.c=E2=80=99s kvm_x86_vendor_i=
nit() because this branch lacks kvm_setup_efer_caps() ]
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  arch/x86/kvm/x86.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>=20
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 9e7c9e3edb5b4..84f8120ac31f8 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -108,16 +108,7 @@ EXPORT_SYMBOL_GPL(kvm_host);
>  #define emul_to_vcpu(ctxt) \
>  	((struct kvm_vcpu *)(ctxt)->vcpu)
> =20
> -/* EFER defaults:
> - * - enable syscall per default because its emulated by KVM
> - * - enable LME and LMA per default on 64 bit KVM
> - */
> -#ifdef CONFIG_X86_64
> -static
> -u64 __read_mostly efer_reserved_bits =3D ~((u64)(EFER_SCE | EFER_LME | E=
FER_LMA));
> -#else
> -static u64 __read_mostly efer_reserved_bits =3D ~((u64)EFER_SCE);
> -#endif
> +static u64 __read_mostly efer_reserved_bits;
> =20
>  static u64 __read_mostly cr4_reserved_bits =3D CR4_RESERVED_BITS;
> =20
> @@ -9818,6 +9809,16 @@ int kvm_x86_vendor_init(struct kvm_x86_init_ops *o=
ps)
>  	if (boot_cpu_has(X86_FEATURE_ARCH_CAPABILITIES))
>  		rdmsrl(MSR_IA32_ARCH_CAPABILITIES, kvm_host.arch_capabilities);
> =20
> +	/* EFER defaults:
> +	 * - enable syscall per default because its emulated by KVM
> +	 * - enable LME and LMA per default on 64 bit KVM
> +	 */
> +#ifdef CONFIG_X86_64
> +	efer_reserved_bits =3D ~((u64)(EFER_SCE | EFER_LME | EFER_LMA));
> +#else
> +	efer_reserved_bits =3D ~((u64)EFER_SCE);
> +#endif

This is going to conflict with "KVM: x86: Disallow EFER.LME and EFER.LMA if=
 long
mode is not supported"[*], it probably makes sense to send a version on top=
 of
that, both to avoid a conflict when applying and to make it obvious 6.12.y =
will
have the same patch ordering as upstream (though that probably doesn't matt=
er in
this case).

[*] https://lore.kernel.org/all/20260911120502.489632-1-sashal@kernel.org

> +
>  	r =3D ops->hardware_setup();
>  	if (r !=3D 0)
>  		goto out_mmu_exit;
> --=20
> 2.53.0
>=20
