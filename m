Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F9038DC60
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788620908; cv=none; b=kG5037eGKp//m8LivMO/M1BgiR0oBqM1qXfjxwMvQLjU6dylKyQHZg1sG7Zi2eOJ36dTiHWjkn/DgL06miwJa1QPk4P1O2sSp5t2anwCxduGO7z3Tb+7AYKSpyKK9AgTpxl4gTPSI+k5nSGhI1lvSgUrxTJXFpKEH8r/u/bfeW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788620908; c=relaxed/simple;
	bh=D9MLe2FWXK8l0yp8EOopvSy3WBRMUQxSHtOgPpBFNfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+7pw2YHsvgFAbJwuIgZxnWprPac++nGxBEln79ZJzKJwauJUoselXKtwVzCGWjlfMHvuWtNeOp5g3ngVR0M4m+YNab+2vrAarRADmHcoIypr6+OjyfIKqkXiV78CMqI/eTIMiCfItMFWR08YyKamvima60yEuVhfvMuVQ3zH5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HsIFm+Fu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HsIFm+Fu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6212D1F00A3D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 15:08:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788620907;
	bh=GHQttfGoEPmKo0nF5OG9d9wyjf9R2olHU8vn/gkHgUw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=HsIFm+FuRKgV+q5t2XjwxKz5+M9UFpJmFUPBjUuaxmSxZpgdo21UJSMv54sHBTHu+
	 lKWIBC2zP81+0g29OQSwsMuDgoUZd0fNji3+DPpF09lqjC0RVPZkos5xKBdlas9bsG
	 aZSqi5WMGK9wYFei3ntfZAynKLvHpS7xEwqvQ2EjWUCv7fyPTwvFF53o5roOWMcGF7
	 fC3psp8K0af9ZFs6Q+wdWidIebkYW+KWOWq+szXHy5CnG6BzyXUR9kVjESvV6Z2syi
	 HS+EObHttWwubXwEu9JpSGORjwrB9hXI5y9oMN/tGVv8nELE+w3CQ6l/9Kp4MHgIAq
	 mWzXF56lgf8jA==
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6a7f27637d6so2224425a12.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 08:08:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByNqn2ln9a4EEP6WT+GSKbhigsFtir4Rh4YmAGGhCR1AXHALNhLpyR7NMWm1tAktFioPdzMaq4=@vger.kernel.org
X-Gm-Message-State: AFuF++l7quE23WywKar9PMgA4QcsXAGPTTZaFr9zl+cB4gGHqOH/p7jA
	MoSPZDjCSWf8GzzA8gBo0SC5/cvIFtBVuu6lgguvRORAcErelr3IFD4JJstcLkFaVspfoEG6u3w
	VoV15RXpAEOKDQ8CtgoZknuKnffaVSRo=
X-Received: by 2002:a05:6402:24c2:b0:6a6:8dd:c76b with SMTP id
 4fb4d7f45d1cf-6a7e8d37131mr7093669a12.1.1788620906040; Sat, 05 Sep 2026
 08:08:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828094825.357630-1-zeng_chi911@163.com>
In-Reply-To: <20260828094825.357630-1-zeng_chi911@163.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Sat, 5 Sep 2026 23:08:14 +0800
X-Gmail-Original-Message-ID: <CAAhV-H71dcn46t7_cmnCDhJf6T3oHTrpz3c==BB1WGJ3mtXSjQ@mail.gmail.com>
X-Gm-Features: AcwNN1VQ6eiUw0Xp7Wb5Tv7Wnaju8g9BBNESfujGrbWOW852vJ9OiobZMxdp2RM
Message-ID: <CAAhV-H71dcn46t7_cmnCDhJf6T3oHTrpz3c==BB1WGJ3mtXSjQ@mail.gmail.com>
Subject: Re: [PATCH] LoongArch: KVM: Preserve memslot arch flags on KVM_MR_FLAGS_ONLY
To: Zeng Chi <zeng_chi911@163.com>
Cc: zhaotianrui@loongson.cn, maobibo@loongson.cn, kvm@vger.kernel.org, 
	loongarch@lists.linux.dev, linux-kernel@vger.kernel.org, zengchi@kylinos.cn, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Applied, thanks.


Huacai

On Fri, Aug 28, 2026 at 5:48=E2=80=AFPM Zeng Chi <zeng_chi911@163.com> wrot=
e:
>
> From: Zeng Chi <zengchi@kylinos.cn>
>
> kvm_arch_prepare_memory_region() computes new->arch.flags, i.e. whether
> a memslot is KVM_MEM_HUGEPAGE_CAPABLE or KVM_MEM_HUGEPAGE_INCAPABLE, only
> for KVM_MR_CREATE and KVM_MR_MOVE, and returns early for every other
> change.  But the generic code allocates a zeroed memslot for every
> change and never copies old->arch, so after a KVM_MR_FLAGS_ONLY update,
> e.g. toggling KVM_MEM_LOG_DIRTY_PAGES for live migration, the active
> memslot has arch.flags =3D=3D 0.
>
> With both flags clear, fault_supports_huge_mapping() falls through to
> the alignment check on the HVA range alone, which no longer verifies
> that the GPA and HVA have the same offset within a PMD.  A memslot that
> was marked KVM_MEM_HUGEPAGE_INCAPABLE because of a GPA/HVA offset
> mismatch can then be mapped with PMD entries on read faults, and since
> kvm_map_page() aligns the gfn and the pfn independently, the guest ends
> up accessing the wrong host pages, exactly the "d -> f, e -> g" case
> described in the comment above the check.
>
> Carry the arch flags over from the old memslot for KVM_MR_FLAGS_ONLY,
> as the GPA, HVA and size are guaranteed to be unchanged for that case.
>
> Fixes: 7ab6fb505b2a ("LoongArch: KVM: Optimization for memslot hugepage c=
hecking")
> Cc: stable@vger.kernel.org
> Signed-off-by: Zeng Chi <zengchi@kylinos.cn>
> ---
>  arch/loongarch/kvm/mmu.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/arch/loongarch/kvm/mmu.c b/arch/loongarch/kvm/mmu.c
> index e104897aa532..4ca7c6ea8f08 100644
> --- a/arch/loongarch/kvm/mmu.c
> +++ b/arch/loongarch/kvm/mmu.c
> @@ -383,6 +383,16 @@ int kvm_arch_prepare_memory_region(struct kvm *kvm, =
const struct kvm_memory_slot
>         hva_t hva_start;
>         size_t size, gpa_offset, hva_offset;
>
> +       /*
> +        * The generic code allocates a fresh, zeroed memslot for every c=
hange,
> +        * so the arch flags computed below must be carried over when onl=
y the
> +        * userspace flags change, e.g. when dirty logging is toggled.
> +        */
> +       if (change =3D=3D KVM_MR_FLAGS_ONLY) {
> +               new->arch =3D old->arch;
> +               return 0;
> +       }
> +
>         if ((change !=3D KVM_MR_MOVE) && (change !=3D KVM_MR_CREATE))
>                 return 0;
>         /*
> --
> 2.25.1
>
>
> No virus found
>                 Checked by Hillstone Network AntiVirus
>
