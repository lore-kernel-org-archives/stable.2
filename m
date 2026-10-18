Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC0B4DD6C6
	for <stable@vger.kernel.org>; Sun, 18 Oct 2026 21:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792357329; cv=pass; b=A5lYmzUUOVvogcTkp+Wq3ktcq9pj7aOMRplxtCzWyd4TwyCn1D0A0ue2otCvuRV7/hz4sevT2Tme3xTt20L4bXmVayTZAe04Mffg6jZUFSi/p5iHR9KiLoDjzNr2Xruhe5AESy001qByotnS+D+SR+Ko7FW29d1qRBfOxOYbBbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792357329; c=relaxed/simple;
	bh=escU3Q+P3zWInrjZP9+4JGAHTeMsskmq9FXjRcMohoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SxFpWniEA4COx2v/RKP1ldilWNtBxko6Jk0G2TGohia6ZjXsszin6/qNdUK5oELi+Pvld6SBz3lMvOOYEUC2MLRqZlbAz6Ri8U/TVT+cNjLRLDFeYl3lmBhSWU2RZa0Dt8NaWrYoplW5Z1qeTFGTp7VeftHuZdfTjH6TvkapehU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9yxLerV; arc=pass smtp.client-ip=209.85.217.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9yxLerV"
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7c6e6822b11so346212137.0
        for <stable@vger.kernel.org>; Sun, 18 Oct 2026 14:02:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792357326; cv=none;
        d=google.com; s=arc-20260327;
        b=TD8BOjNXB62l4vJpUM5ASYm8in+3nb4my2j94Rp+5t9W/YWKkqes9DTyHQeTbyiZXs
         j0bcu7Z+lt4DjF324W5lbxOmkGEX6xViyWjTaiXK075Sqwik6LmbD1whZn3Trt+bgOck
         SmbGpTTYQdPJoIYTBX/m7/tnWP9eUaFVJHhq6LFjUA8+NlJvNba8bg7WnpNHPmj8Dx81
         olCJ8UxY5eQFVBnIOzBJLj9Dnm/Ry0jaWykDX5FjhZmDqmR1H5tQQR64crTYvzbyB9W5
         6a9zQNZhCYonV18eYwGVVLR9jURO1+r4H/0BAub5ZeFJhgBkLB08IC0y7DMYgpxwLXgY
         3OEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Qy/eUVeUOjsCzAJiN1MNGTJCTNknQERtyP6Ddh4oOBI=;
        fh=6riH9CMb4V+QTwzsdTh9He30CAyAIkF3+c1YoUYwKR0=;
        b=blhXHtmox7Kl+zvml1N7fuigPfyMXy+mFdxI0j/j601LCYXDtdOph+kS9QVY8DE2BO
         Yi+Kep7+/K8WWebworwhYk7TJt7wXOMcZGxbs5GbtlY8ZrREDEQ5kAcrV5gp5ApckjVU
         LeieLDpu4P5paN7BHeyvlvPtpEgmzdvUnlhaz2h0gTQoTiOkAtZ2ZpKMJrh6+Zg2W9rv
         be2tXJKkHFbn9lw1R6lh2ohLj4InasTOVUUqI73up2d3zq+Cx5z420tF7qF2tR5vfMrD
         vfzZqj5IYMV1YRfMArTwnffB+IwQAbgPrkedR1w/f2yQMooE3TZ59PIIwl3ms/TBxieL
         vggQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792357326; x=1792962126; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Qy/eUVeUOjsCzAJiN1MNGTJCTNknQERtyP6Ddh4oOBI=;
        b=b9yxLerVZSFDSlMrB3Sqvb1c2CBc0S9R/x13M63+Iu7qSxr0uLDcNnzGrrmz6moqlp
         U5Agy1BkvOS5tab3cU6+EEQPmFVhv4OH+jU10xC6ww8zrcxR1Aoloqb15KnGA3j2j+eR
         6e8n97NeCGo76ppWF/M578Br4kqz09HO3iylmuzFeoSAP2o3VcHbT+3+NYk+H8TFvw4g
         UXvwSobiuH1GWJW+dweH/pcYyQWlimtV1WA+Glep+tkIfgSfdVfd/UMNmqV0veLsojBI
         1lf0R9VoTj9dEcVQt2Q5u9rOhOQsNAfE427MbLke+uY0UoEnYPwJW/cB8G67yBg/KQnO
         9EeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792357326; x=1792962126;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Qy/eUVeUOjsCzAJiN1MNGTJCTNknQERtyP6Ddh4oOBI=;
        b=B4ZMpp2EviwXKrhjyI88y24EIHKSfrS4ksZbotAdJZV6b/TtbNvA+zUg2rIZ/KF2X1
         LKXpZqj+70rnwqeI/Jp+waJzvEmBelXp1ZQnXoT+HEdM9jg2EHgPEBhXFBhHyZXre5Kt
         O0Qd+Ye+MF4OKJKAszIDCizzo6cFF5T5HSXuCVnKfAprJoQ+XfkeNgwPJiWngNmFRS2b
         Jibb0GdElCa87ZZC2iRfi+d8Ck7beM1QENSA3r9nMy/qprGimuUxioPsXHQoG4qOV1u5
         qA5QzjkVhkoyPmWMbuN1XaUCBLBqYX6VRfIdfSuB6cc9fEhvFCtdiqSDL0yUsPeco0OS
         5AFg==
X-Forwarded-Encrypted: i=1; AKwUvByZ8KCtvCZqNudMvLcGuqdfsavJ+jAuBLtRKs/QzyxETdHs0XoqtQ87d42ubg3ZLYSBtNdjVRw=@vger.kernel.org
X-Gm-Message-State: AFq9FYKczePXsP6qch/6ntJLCbiyp2YXsMVBXAVh6tP+uYkY+ePKR4wV
	B+SxcD3wcwVNoObxy+gDWFJ7mx1J1O9H9ql/xjW+XcsPy1+Da0uFXs1mHlwdsNqoVXIeHut+ulJ
	mh8MDxuatcvBgnwnGjs+ub7fyWP+q4ms=
X-Gm-Gg: AYBFou3EGSRgw9qgfVlo2BaZYykjHLNeWJPx2SpMphjUtgNdycPM+NJ1apZOtDn+p2j
	0mydrZMPCCMkVe0Pp7GgOnghzHtJwojMqUxDQLcgzg+rShqWKtEqpT8yeFodN7Ngy/PjeRukWnN
	HwRDOc1dCKMrqJPiqZE7BokeArUN8T2w1qTSyBYfNTyGBDX5fkCSigtJ+UvRgv0J0tUEqGLPSoH
	kkQkPWNyGQrfNaZz6TbYIwiOo92Qb4hKsQsyNed/P0X4lCl8cvqKjRj2snPgmpEe3mToGjrKHUi
	AWYYD0odTeXxCD4LL7vhSBPWeRlG5nNKXZeAu5UnjAj5auZdqij5OGi24pYMVCtk9f7VILqMQYh
	j8qZpsY6QvPSIgFx0OZy01W5/eYXgOq5GM1mcdjpbw1KKMw==
X-Received: by 2002:a05:6102:548b:b0:7c3:c0b9:9031 with SMTP id
 ada2fe7eead31-7cc36b17a5fmr1262224137.36.1792357325888; Sun, 18 Oct 2026
 14:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261018023349.1697434-1-gourry@gourry.net>
In-Reply-To: <20261018023349.1697434-1-gourry@gourry.net>
From: Joshua Hahn <joshua.hahnjy@gmail.com>
Date: Sun, 18 Oct 2026 17:01:55 -0400
X-Gm-Features: AclHuK_otQGVJnFH3of7l6giChtEJc7SlCr0xXb-9-VAKMTt98ua1SNqHcfLZJE
Message-ID: <CAN+CAwMJZ929StJF3=5pJ8uO97u6pK+XrF3LwmhHia-rUO+dUg@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy: apply bind policies against the scoped
 allocation zone
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, rakie.kim@sk.com, 
	ying.huang@linux.alibaba.com, pasha.tatashin@soleen.com, mhocko@suse.com, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 10:33=E2=80=AFPM Gregory Price (Meta) <gourry@gourr=
y.net> wrote:
>
> QEMU fails to start a guest with a VFIO device when guest RAM comes
> from a memory backend bound to a movable-only node:
>
>   vfio_container_dma_map(0x55b1b1317800, 0x0, 0x10000000,
>                          0x7f39a2200000)
>     =3D -12 (Cannot allocate memory)
>
> VFIO pins guest RAM when the device is realized, and the pin faults
> the pages in. io_uring fixed buffers fail the same way. Faulting the
> range in before pinning lets the same pin succeed, since resident
> pages are migrated off the node instead.
>
> A long-term pin faults under memalloc_pin_save(). PF_MEMALLOC_PIN makes
> current_gfp_context() clear __GFP_MOVABLE, but policy_nodemask() tests
> apply_policy_zone() against the caller's gfp.
>
> The bind keeps its movable-only nodemask, and the allocation finds no
> usable zone:
>
>   page allocation failure:
>       order:0,
>       mode:0x140dc2(GFP_HIGHUSER|__GFP_ZERO|__GFP_COMP),
>       nodemask=3D1,cpuset=3D/,mems_allowed=3D0-1
>
>   Call Trace:
>    warn_alloc+0x136/0x150
>    __alloc_frozen_pages_noprof+0xed8/0x1720
>    alloc_pages_mpol+0xaa/0x170
>    vma_alloc_folio_noprof+0x65/0xd0
>    __handle_mm_fault+0x137b/0x1ac0
>    handle_mm_fault+0xa0/0x270
>    __get_user_pages+0x250/0xfd0
>    __gup_longterm_locked+0x116/0x870
>    gup_fast_fallback+0xcfc/0xdf0
>    pin_user_pages_fast+0x47/0x60
>    io_pin_pages+0x9a/0x110
>
> Base page faults fail with -ENOMEM.
> hugetlb faults fail with -EFAULT.
>
> Check the policy zone against current_gfp_context(gfp), so a pin-scoped
> fault falls back off the movable-only nodemask, like any other
> non-movable allocation under the same bind.

Hi Gregory,

LGTM, thank you for making it so easy to review!
I wonder if other places are missing current_gfp_context as well.

Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>

> Tested in qemu with a dax/kmem movable-only node 1. io_uring and VFIO
> pins of unfaulted base pages and 2MB hugetlb pages now succeed and land
> on node 0 (correct). QEMU now starts with the same backend binding.
>
> Fixes: 8e3560d963d2 ("mm: honor PF_MEMALLOC_PIN for all movable pages")
> Cc: stable@vger.kernel.org
> Signed-off-by: Gregory Price (Meta) <gourry@gourry.net>
> ---
>  mm/mempolicy.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 70298fded1b4a..0884c629670dd 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2302,7 +2302,7 @@ static nodemask_t *policy_nodemask(gfp_t gfp, struc=
t mempolicy *pol,
>                 break;
>         case MPOL_BIND:
>                 /* Restrict to nodemask (but not on lower zones) */
> -               if (apply_policy_zone(pol, gfp_zone(gfp)) &&
> +               if (apply_policy_zone(pol, gfp_zone(current_gfp_context(g=
fp))) &&
>                     cpuset_nodemask_valid_mems_allowed(&pol->nodes))
>                         nodemask =3D &pol->nodes;
>                 if (pol->home_node !=3D NUMA_NO_NODE)
> --
> 2.53.0-Meta
>
