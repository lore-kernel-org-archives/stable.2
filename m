Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7D0522F19
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 14:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791988845; cv=pass; b=aX7lfkAyr+WbPoxVfYI4polC72JxOi+bj0ruhTYpTSM1NcSsEsKRIEWa79VtorCtUUBVHExHtp8hHAea+aZmzWrrmVHcdWcIXHzIAkwefVGSyOk3lEgWjc7iqkT8Dgpvg+cuQ3eazNU0GS8120LsIbcx6daokoPCXP2Y+hKObb8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791988845; c=relaxed/simple;
	bh=MxFG1mZktrMoElvMC0UlvjvWr6avtnQPc6bd059hWM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oAMnv4LUeQ8gEXWJNZxX6QXg0GnIqbPK0gOIQUvZbEbXrb2xrL2KpS4/HdaL64/7QR/BkNy2qdY7QvnEABcm/ymnLGMVpPA1zlWuXqkCdVxgExPhswpZocrh/Rp/5hzWudZL06xSU1VyKW3GQqfNG8xoATLLxFsq4begFUzs3Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UCCBpXnH; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UCCBpXnH"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso40467a12.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 07:40:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791988842; cv=none;
        d=google.com; s=arc-20260327;
        b=dPboc4mbGTxPWeBF8jz9FOxH3od/Bqi6G2d5GPxI0ws9r2LVjBTdGuSupX4cc11mjj
         S/0lTht/t2eFxcGnAJ/SwtgoetR5Vy7TVbD14amDxgwz7biAX+EavDtbEbVBbRi3SWPV
         9dACFiLFBZHBpIHgqfIpYvbm12sAhCPWlL4R4EiySZXGYak0IjTmhPiB/8IOovxn4VrN
         bdAAGH8ZRB0w6EZjZdc1R2LLP2rIA28gUIyAvufZk5uB7Jxjlbp8wXgFeWfwX8qGqibw
         KM1axybmgIdIeEdLd+RXsrIUqXUIcBoybnBb8FztiDJJ7pGbJHPpJ1Yimsmr/ej+UFfA
         t0KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=o+kqtSVBBM78ciUCA58cO4YtlpbL6uVSQYurfCH4pKc=;
        fh=vflYdbMxQqC21hbG3HlN6B+n+0Axv4MbAxMuQZPjP8M=;
        b=FK2m8meSjC6umpQQNDL7dxXmfqynaeY5ycyS+5HYmn4hytbwmvRIk9+NysGcHHHDGb
         NyUXI+n+aYBXI61KcM5DeY7ngx3m+Sqq7K+9AJOmnA4C1ciemwQLefVXuD7LpzOP9/Ho
         fdAxZgcvTvYNjR2yw1NxEQ1ATtax55QWTuifgh88UGwv6PmdHjBFexN290GosPeADNcw
         VboWt3+I+DrwXFL10CXfX5dSrg4TrMkQ5cV2VYttq9nxmXCouCXeb0dJwFRKiiI1XxF+
         TfvgAEpc7T9s0MCWOXj+FEu4zomb/DMVzvm0EFefU6yHFXlb7AIoJ2HocRTC79gw61+u
         E6Ww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791988842; x=1792593642; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=o+kqtSVBBM78ciUCA58cO4YtlpbL6uVSQYurfCH4pKc=;
        b=UCCBpXnHIIaZ0glcDUn+ikmOb3uFCXkJL0A+3AG6yTHyAwIipUmN0Qknyn5K/suHfp
         dRyqS1teWFl3PaQ0BoEn+ht0Xq3tRn8c8LseRiDLppaKomsYLwPwhZQqfniMHOWuBZh/
         lyG4IY8ScwWFlPS1CcpaFxUO4S2ZRkkt+w5YBoTwRuXdZ1l4V1Np/pZ3XPbEFcp+yrrh
         VpFX49/jFCQU9KCYBC/G7rAhn4jhZ1eIXm88N2qAkZb21jKIiFJK6Y8zAAZLN6Xn/fel
         99YGc4oRGQYBp07ptKINC/YavnkJx/7mPcuIt53KT3larzcg5ZfbfvOrFw9Zq6nckHKr
         w7Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791988842; x=1792593642;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=o+kqtSVBBM78ciUCA58cO4YtlpbL6uVSQYurfCH4pKc=;
        b=YJHRoq9bdqH6eT8nOQkmnCzEqMIE/AF51yN3J6AB7xTLoUEtwcN/uml5E9ptt+SO9d
         xw2Ox/ODK5NhUCmMoF3TuHz26k45lnWiUBBrFE3NulVt0ou3ysWQWPvbOLBjHg4gnspD
         +f/mye5QcyulAZ4UY3J9Z4Mecd4hvkFHJypsRFTtaK9C5Mw+/KyEf07DeAqoxVx6CSxR
         2KPxfpkv41mu71II4PNCh3nxEtas6b4gtIe0vj5Hi/OI1nX4pUvaEuqa/jbhE9awMm5i
         iP0itWwMeWS0A+3sruB1l07Ur3x37HMP9EXg5Amt3U5zT3wJoCipPlWyopYeA1cjfkL9
         WFVw==
X-Forwarded-Encrypted: i=1; AKwUvByvTzsN6fek5YPo4JDHXhqHcYHoTXm6GO/sychsTUoqcSDknDK0LC60ffsjDsd43BObfUtDugE=@vger.kernel.org
X-Gm-Message-State: AFq9FYK8T1cl23q0vy4ZkycePF0/Eof74ekb0EqTdpZV2UrtIXUZErF7
	meKpqKsUQtez6McGi3MFffFVmnIPUCxjuzqFT/IvHx9VI9i7CBXqeyaBDrt+7uIEUPw9W5MbdYT
	b0a3lI1NENCPMjCbU+sR92xoq8uFSbqA1AummVH57
X-Gm-Gg: AYBFou0KrfdYn+Yyh+Dd9yCzcWwJPCL/Ka/7KfHVQw5L4zcGxlkMV7SQxkTkDxah8mA
	aioVTnKHNuECFZRcYyWy1zemGLWXyTxZpss6PYH3TmPC3rzIZELv37v1z0ufit3+SdOZdpqEL0M
	MzlfbEo1uxPUSdeCy+XjL+SYfdmrQ+X3Xk+yEnsyw+5C6+AZEqol8kj3an9BZQXkh7i7xJYqh3y
	tvUVujDzmStLfYsDjRW0zJUK6fSVAxmOMFhikxYBrola/qtV5Tu/QbL9qgZhfES0Y2mBHJCbzZ+
	dfAW6FvviWD+IsfeHcK3NbRpYNnZMG3Gmv9niNxBLnPAuxDqFlHf0ELE
X-Received: by 2002:a05:6402:22c5:b0:6b1:c3f3:225 with SMTP id
 4fb4d7f45d1cf-6b209504430mr53244a12.0.1791988841607; Wed, 14 Oct 2026
 07:40:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013231728.883001-1-yosry@kernel.org> <20261013231728.883001-2-yosry@kernel.org>
 <CALMp9eQ3mz_EiV4AcmMC2CQZ47s_uf7XCbhnn7pfvVjHwsXdTA@mail.gmail.com> <CAO9r8zMYj=Bxc_8bWh=G__2C0ouiarg-WMtVCdziCvccZTugPw@mail.gmail.com>
In-Reply-To: <CAO9r8zMYj=Bxc_8bWh=G__2C0ouiarg-WMtVCdziCvccZTugPw@mail.gmail.com>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 07:40:28 -0700
X-Gm-Features: AclHuK8QvSQV5JIun9Aw8Aiber8CAgmIN8b8u5LQUwGXpdAYDUmRDzVbMQGTfj8
Message-ID: <CALMp9eQtcCMYiQKKyA+L-rNN9kjNZDhTqtQWF=8VmiaqqSEw7w@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: WARN, don't BUG, when walking a cached
 root with a PAE MMU
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 14, 2026 at 7:27=E2=80=AFAM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Wed, Oct 14, 2026 at 5:48=E2=80=AFAM Jim Mattson <jmattson@google.com>=
 wrote:
> >
> > On Tue, Oct 13, 2026 at 4:17=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> =
wrote:
> > >
> > > Replace the BUG_ON() in shadow_walk_init_using_root() that guards aga=
inst
> > > walking a cached (previous) root while the MMU is configured for PAE
> > > paging with a WARN_ON_ONCE(), and terminate the walk if the WARN fire=
s.
> > > Walking a cached root with a PAE MMU is a KVM bug, as PAE roots are n=
ever
> > > cached, but there's no need to bring down the host, as KVM can simply
> > > bail from the walk.
> > >
> > > Note, the BUG_ON() is currently reachable by a guest if TDP is disabl=
ed,
> > > as KVM walks cached roots even if they were created for a different M=
MU
> > > context, e.g. if L2 executes INVLPG while using PAE paging, L1 doesn'=
t
> > > intercept INVLPG, and L1's 64-bit root is cached.
> > >
> > > Add a common error label for terminating the walk, and use it for the
> > > existing invalid/dummy root check as well.
> > >
> > > Fixes: 7eb77e9f5fcf ("kvm: x86: Add a root_hpa parameter to kvm_mmu->=
invlpg()")
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> > > ---
> > >  arch/x86/kvm/mmu/mmu.c | 13 ++++++++-----
> > >  1 file changed, 8 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> > > index aadd5bdc2c97a..126faef5a6476 100644
> > > --- a/arch/x86/kvm/mmu/mmu.c
> > > +++ b/arch/x86/kvm/mmu/mmu.c
> > > @@ -2558,10 +2558,8 @@ static void shadow_walk_init_using_root(struct=
 kvm_shadow_walk_iterator *iterato
> > >         iterator->addr =3D addr;
> > >         iterator->shadow_addr =3D root;
> > >
> > > -       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(=
root)) {
> > > -               iterator->level =3D 0;
> > > -               return;
> > > -       }
> > > +       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(=
root))
> > > +               goto error;
> > >
> > >         iterator->level =3D vcpu->arch.mmu->root_role.level;
> > >
> > > @@ -2575,7 +2573,8 @@ static void shadow_walk_init_using_root(struct =
kvm_shadow_walk_iterator *iterato
> > >                  * prev_root is currently only used for 64-bit hosts.=
 So only
> > >                  * the active root_hpa is valid here.
> > >                  */
> >
> > Can you please rewrite this poorly worded comment that now explains
> > your code below? What do 64-bit *hosts* have to do with this
> > bug/warning? I assume that should be 64-bit *guests*. But, even that's
> > imprecise. Aren't prev_roots tied to 4- or 5- level paging (i.e. long m=
ode)?
>
> I believe it should say that PAE roots are not cached, so only the
> current root should reach here. Right?

Right, that's my understanding.

> I can reword when I respin.

Ta!
