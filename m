Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F874EC64D
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 12:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791982131; cv=pass; b=SjZNHuWUTXvwXSTUzixGJm8QO0Yr8aE3aoq66WWy/kXGpDV6ZZ5n83b1CYSPZZEj0FfuaCzYAjIJbvRiVmV9/SPXJFvq2m6XEbKzz1AGBRx+zua5N93i9sQMgg6zQT7OLA+jCYWA9EVws7ODFxE8F1VpyfETS6l7p7MrprHCTf4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791982131; c=relaxed/simple;
	bh=PErefbjRur8+lAPuSaGWtGt6QpUAIajC81LrxVlpFMs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YTYZ7MTokXTgmdKmsr77W1Ztdtr1v2FYfNmaY3ZBtxvs2TNGUmLi70MaExrarqqsEVukJps6GQlGjGN8zS14za7raogu+FcMVpQYDw6WsoypK5F/Sy4mMJueQN4z+NsDqFia7nAAsjo0c8EID2SX+1Vjdgk9XNMwdvqZhXgZ24Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ArcUYW7P; arc=pass smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ArcUYW7P"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6ae14cdc63aso38929a12.1
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 05:48:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791982117; cv=none;
        d=google.com; s=arc-20260327;
        b=kG8pnpzW55R/ABiBI2SHh4wk47GcW5QwUl0L4eQLlL+8zDAd3Ss5bAdkzwJ+YB44y6
         2IfzeeilyZWoi27MbVz8+IcHJMFopwG1agnXLYXiMyPAzp1kdllCONUIUSJD0XYKi8HJ
         b1rtYHcKeq6GjubBHI5H4JiCWwf1cTBVEIPmTmY3Jf5XUs7qnlJyUU7gAyhVFZ1WnOaQ
         Cf5nF3iYI/Gp53IQz1smPzvUHAL94XehioOdgTTUUUBcP+Q9Er/zNpWAzYr2M3Co/V0m
         3YDW8HVOBauup/kMGp7+0Xvpef9T5pzAlE6KPpW+e8btjX1+mnhj6rZwrlF7NzKsG6KS
         w0og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZQL2xas4nG18KleQ+fT63AHqIIDtA2su0UrfgqIbaUY=;
        fh=Ysz01Hg3EqNhYSGTvGeIiqeR90EvpjjdNetBDyg2RLI=;
        b=Sn/VADP1+uYWnbWjzIn3zhbA+PGF2FhbSMNPPTjgb23dwxWRBth4roeI+B9IDdfOoH
         6RQiPHweuDy7iEyEv6b0iNHTTfvtZQ4bkLnj4PjiE8yhEGPM2DXZD6g4aZbyChYCCm5B
         oy68LX3r7bViPRu2zCPrU95b8n9jR8HCKozXsiw+PXhSpxbMA5daDHFUyIU9wPjZFshj
         8zKaTOESDjOeMq7baZV58/Dp606tQMU5dS3LksJEYWXrpF9RAyZFQixz7HT7nhWHpX9f
         DPihoRmCXCt1SrzKe5eR8+RTRScHptUXqpPQKk/fwxET+st+RFjH6JEen/xskWtobcTn
         PPug==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791982117; x=1792586917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZQL2xas4nG18KleQ+fT63AHqIIDtA2su0UrfgqIbaUY=;
        b=ArcUYW7PlGRQMppwNESL5NfTwEdvl54Oot4YOC2WoKwUCaoA7NsFTGNXVw7tfUthDd
         6KABLnr7CEb3SUwCV1D1LVst2kJbBZZH0GB7u6PXSNGLHs9fp7yGwXPHlb0yQw6MXRfn
         1FHe+2wZ52Y2NR0bru9BeMi+OvJMMEMMYe/AbVL/5MGckfBa3T5KdzzEH+UQLtG7MkEj
         He3bPtJQD5QNx3SNrkcctMBlwB9MF9gbOAtm1PNvrbegs+z1oj0rDIrD3e0Fg8bV1X7H
         X0TaJU6JUh6crWo7To8GvDW3bzJiMY4WmRAsLZ0+EP7TicXpkhu//e3heGs59NwUkdij
         iNBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791982117; x=1792586917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZQL2xas4nG18KleQ+fT63AHqIIDtA2su0UrfgqIbaUY=;
        b=BT6G/CiyBKgWCx1ry5BBYt/o19GahrXgw2PtRt3gf2i/ytBaGBQApWZyjv9kw/IP0Q
         UTpf9arNE6mrP/Bvjwd28iic62IokeZyp5TrE7Jrhmyug0LymoTmxft8kEQb8YCmfXuu
         /sEmOX+x0/dFC/bGUGhYTM2Q81kE/CIJMdU9udK4unTSWbsCDSO8CWX/JgYLzxQ+AN/L
         Milo9CUSntVXa4aFsE8Jl/6lB1J3uONrotTAF1+xypytwobM+n5NuuZQzSklGRPhpZ4R
         UR8KoLoerp7+cXhqUdE9vvKD0KdTs7gaLV31lJVNwJBJuOnIUFNtHgl4U+5digkE6ZZk
         v6tA==
X-Forwarded-Encrypted: i=1; AKwUvBzEN8EzH7dgqqfcwdFBC/RlX9ENl0vBDD24ZdJn3W7xrXkJLVVuBFCvrkG1kSSFy6cQjBMOsXU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKeZnkKl2e6wrgd9bAlwfB69EwRCQ9caNnFeqbdyIYQdsUQrFEo
	ADHWr8rNfa3KrtFLIb/GRZa94WcI4fZtbWl/VIwaVDt4+cpTyCxB8mAX9vQ5wQcjeBFoL8h8LjB
	MaffBjxE6vIST2nakgWq6J0e+2MjzTej0HQJQZB0zL+ed2B9hELmXPzJL
X-Gm-Gg: AYBFou13zRaERxuFKwx2nC8hMRIcV7t7WF9lBmHNjed/mxs51cjMkcChuLl52r2bWJg
	5fPoDpo22BYvwfn26zqhffrg2eGBxD9LzejVQO+Nss2/A8NXJL11h7r6U48mM6FZMY2+93+Sqq6
	jikhISPHBJwOTJjz0R3XYwJKo2v52FUqHhxizexOLeCuflV4nfcC4l+cSHt/nr+k4Naz+8MYiJ6
	o0rTzBWE3dOFWrvjQjiC8I6zt1O2yzY4fdjrZKxXX/Xk1dQu0ShFc0uHyQnxlPqbG6d6VusJXxd
	n9h6G8EcydKTBlFiCdpD5wjL7Gw01TrJhWQnUHInjX8XlKis8Lg/iDQ=
X-Received: by 2002:a05:6402:424c:20b0:6ae:188e:e119 with SMTP id
 4fb4d7f45d1cf-6b20aad471fmr31158a12.9.1791982116138; Wed, 14 Oct 2026
 05:48:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261013231728.883001-1-yosry@kernel.org> <20261013231728.883001-2-yosry@kernel.org>
In-Reply-To: <20261013231728.883001-2-yosry@kernel.org>
From: Jim Mattson <jmattson@google.com>
Date: Wed, 14 Oct 2026 05:48:23 -0700
X-Gm-Features: AclHuK_eUHrZ3upceONbVQEejfpEzwYMGcSk3TlD294BOAEgQl9aP_4IrxL6XqQ
Message-ID: <CALMp9eQ3mz_EiV4AcmMC2CQZ47s_uf7XCbhnn7pfvVjHwsXdTA@mail.gmail.com>
Subject: Re: [PATCH 1/4] KVM: x86/mmu: WARN, don't BUG, when walking a cached
 root with a PAE MMU
To: Yosry Ahmed <yosry@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 4:17=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> Replace the BUG_ON() in shadow_walk_init_using_root() that guards against
> walking a cached (previous) root while the MMU is configured for PAE
> paging with a WARN_ON_ONCE(), and terminate the walk if the WARN fires.
> Walking a cached root with a PAE MMU is a KVM bug, as PAE roots are never
> cached, but there's no need to bring down the host, as KVM can simply
> bail from the walk.
>
> Note, the BUG_ON() is currently reachable by a guest if TDP is disabled,
> as KVM walks cached roots even if they were created for a different MMU
> context, e.g. if L2 executes INVLPG while using PAE paging, L1 doesn't
> intercept INVLPG, and L1's 64-bit root is cached.
>
> Add a common error label for terminating the walk, and use it for the
> existing invalid/dummy root check as well.
>
> Fixes: 7eb77e9f5fcf ("kvm: x86: Add a root_hpa parameter to kvm_mmu->invl=
pg()")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Yosry Ahmed <yosry@kernel.org>
> ---
>  arch/x86/kvm/mmu/mmu.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
> index aadd5bdc2c97a..126faef5a6476 100644
> --- a/arch/x86/kvm/mmu/mmu.c
> +++ b/arch/x86/kvm/mmu/mmu.c
> @@ -2558,10 +2558,8 @@ static void shadow_walk_init_using_root(struct kvm=
_shadow_walk_iterator *iterato
>         iterator->addr =3D addr;
>         iterator->shadow_addr =3D root;
>
> -       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(root=
)) {
> -               iterator->level =3D 0;
> -               return;
> -       }
> +       if (WARN_ON_ONCE(!VALID_PAGE(root)) || kvm_mmu_is_dummy_root(root=
))
> +               goto error;
>
>         iterator->level =3D vcpu->arch.mmu->root_role.level;
>
> @@ -2575,7 +2573,8 @@ static void shadow_walk_init_using_root(struct kvm_=
shadow_walk_iterator *iterato
>                  * prev_root is currently only used for 64-bit hosts. So =
only
>                  * the active root_hpa is valid here.
>                  */

Can you please rewrite this poorly worded comment that now explains
your code below? What do 64-bit *hosts* have to do with this
bug/warning? I assume that should be 64-bit *guests*. But, even that's
imprecise. Aren't prev_roots tied to 4- or 5- level paging (i.e. long mode)=
?

> -               BUG_ON(root !=3D vcpu->arch.mmu->root.hpa);
> +               if (WARN_ON_ONCE(root !=3D vcpu->arch.mmu->root.hpa))
> +                       goto error;
