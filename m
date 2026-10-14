Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7435452BF
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988071; cv=none; b=f2ditvuOK0OWwBmPq5UfFg8P30Z3qBzi7XLA+fpYBIlthxXD3X7KOxNg4PgQJsS4bAfz9Vo+UWRZ3Cz+7H0FwxJm98kPUPfm3SjciIwMSVZ4nY+amSuCLnFuIz79pqdytCOKZYm1g6QbmmqterRmODBkwmenW3BJEk1NWiBz3Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988071; c=relaxed/simple;
	bh=+4O3dgN8JnALS0J6zduu4TMiDSliF7CUQObkJt1qiAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CRaOXc6whWYd9prKG27C993wCHHGVfyuAnltambSHECQ1uVvWXu+VVPb9ZDj2cbvMD5A08JWIHcomeWI4N1YRj+x9VVtJEM5dXyo8bs++woNfD70NJvTggQpwc4rl7ej8pvwehk2EEmhKRNR2epXifgpVaQCUFJgVIq+VlKNahY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUloKktd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUloKktd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830F81F000C5
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791988068;
	bh=lfFmxhOLuqgGJZO0laFSH8+WRQc34Bzenr5qGk/rifc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BUloKktdx0X1kz3N13CNNeB1e/9uIP6grtYTSFnxPG3470gzPMMq67w+1lZpD+69t
	 VkJUWMGtKmgJ/pyKi4MQMZ50xL0EdetHz9N2S4YnLamvK1XtCGH9z8VCrhuOyRpn+4
	 pSlv+6c1kv9jETnRTOmoMbR7Y27zzIGvGVV+uNLfe25riQtsic6xFVhmqLECbnQpoT
	 nq4JU7pJQBYE/QoRADjfXhX/wETmu7ggy03zVTdMMqqPHxWyM9IWOft1eFxdZLmXUW
	 s/buOSDOwlmkMAIyeDGurjoeSE0XW4HQJzDV1A2huKhOTYJZNQ45RaiH7YJzPKgIrS
	 sKuTjwTaS8pmg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c2e62319cfaso114511066b.2
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:27:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx9Yk3hjF3r3bECdtjdqPGXKSxreb/5oU7ngpDSSiv2peV9QYnrZ4CnX3lWVh7eU4GBOz4t7Ic=@vger.kernel.org
X-Gm-Message-State: AFq9FYKqoSgikkqHVa2+w9dCdxlin2R4WOFW3DdjAKdWB8RxUuGOT974
	51NGZwmEBbOSNXaHtJuP5khRZ8Z0Xz6pVhb5f4gK5lsUaPkNeXbO6D3EjVbhQ6AEBRbMaVMoLfc
	ieH9zrdZpLf7AGhAcPrOxGNtf2QTlBis=
X-Received: by 2002:a17:907:608d:b0:c21:1b58:fa96 with SMTP id
 a640c23a62f3a-c31a9a28c37mr1538562066b.3.1791988067406; Wed, 14 Oct 2026
 07:27:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013231728.883001-1-yosry@kernel.org> <20261013231728.883001-2-yosry@kernel.org>
 <CALMp9eQ3mz_EiV4AcmMC2CQZ47s_uf7XCbhnn7pfvVjHwsXdTA@mail.gmail.com>
In-Reply-To: <CALMp9eQ3mz_EiV4AcmMC2CQZ47s_uf7XCbhnn7pfvVjHwsXdTA@mail.gmail.com>
From: Yosry Ahmed <yosry@kernel.org>
Date: Wed, 14 Oct 2026 07:27:34 -0700
X-Gmail-Original-Message-ID: <CAO9r8zMYj=Bxc_8bWh=G__2C0ouiarg-WMtVCdziCvccZTugPw@mail.gmail.com>
X-Gm-Features: AclHuK_WnIfbB2X-l5-gNuHe8WwlUpAJyDk8vl1lfYcYLbz5Ja5imyuXhMgyRJg
Message-ID: <CAO9r8zMYj=Bxc_8bWh=G__2C0ouiarg-WMtVCdziCvccZTugPw@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: WARN, don't BUG, when walking a cached
 root with a PAE MMU
To: Jim Mattson <jmattson@google.com>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 5:48=E2=80=AFAM Jim Mattson <jmattson@google.com> w=
rote:
>
> On Tue, Oct 13, 2026 at 4:17=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wr=
ote:
> >
> > Replace the BUG_ON() in shadow_walk_init_using_root() that guards again=
st
> > walking a cached (previous) root while the MMU is configured for PAE
> > paging with a WARN_ON_ONCE(), and terminate the walk if the WARN fires.
> > Walking a cached root with a PAE MMU is a KVM bug, as PAE roots are nev=
er
> > cached, but there's no need to bring down the host, as KVM can simply
> > bail from the walk.
> >
> > Note, the BUG_ON() is currently reachable by a guest if TDP is disabled=
,
> > as KVM walks cached roots even if they were created for a different MMU
> > context, e.g. if L2 executes INVLPG while using PAE paging, L1 doesn't
> > intercept INVLPG, and L1's 64-bit root is cached.
> >
> > Add a common error label for terminating the walk, and use it for the
> > existing invalid/dummy root check as well.
> >
> > Fixes: 7eb77e9f5fcf ("kvm: x86: Add a root_hpa parameter to kvm_mmu->in=
vlpg()")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > ---
> >  arch/x86/kvm/mmu/mmu.c | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > index aadd5bdc2c97a..126faef5a6476 100644
> > --- a/arch/x86/kvm/mmu/mmu.c
> > +++ b/arch/x86/kvm/mmu/mmu.c
> > @@ -2558,10 +2558,8 @@ static void shadow_walk_init_using_root(struct k=
vm_shadow_walk_iterator *iterato
> >         iterator->addr =3D addr;
> >         iterator->shadow_addr =3D root;
> >
> > -       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(ro=
ot)) {
> > -               iterator->level =3D 0;
> > -               return;
> > -       }
> > +       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(ro=
ot))
> > +               goto error;
> >
> >         iterator->level =3D vcpu->arch.mmu->root_role.level;
> >
> > @@ -2575,7 +2573,8 @@ static void shadow_walk_init_using_root(struct kv=
m_shadow_walk_iterator *iterato
> >                  * prev_root is currently only used for 64-bit hosts. S=
o only
> >                  * the active root_hpa is valid here.
> >                  */
>
> Can you please rewrite this poorly worded comment that now explains
> your code below? What do 64-bit *hosts* have to do with this
> bug/warning? I assume that should be 64-bit *guests*. But, even that's
> imprecise. Aren't prev_roots tied to 4- or 5- level paging (i.e. long mod=
e)?

I believe it should say that PAE roots are not cached, so only the
current root should reach here. Right?

I can reword when I respin.

>
> > -               BUG_ON(root !=3D vcpu->arch.mmu->root.hpa);
> > +               if (WARN_ON_ONCE(root !=3D vcpu->arch.mmu->root.hpa))
> > +                       goto error;
