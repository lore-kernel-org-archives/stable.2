Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795317630;
	b=1RwT1GK+2rIeDZy87V2r/NmBLC1jnkK0Y6SRwfJj5NyZC3S1e6k8mEjXISmdY2Ma6C17
	 6WPLlePwEIicHs0GdjmeW7+u6vEIu+kvO4Jpx/NcJU1xHu8rjPCFT4cENMrOAbQer+hhM
	 D0jX13MZ96Tb9wnxkwAcXoIRbmRpxFZsHMiFnQp1OiYli/XcUgYrbblE2j2gh1B6vvlBh
	 UIUZEPgaNra/vbk3RViUJMYexRRITJlVPYCU3QWOzGl/J/M1wbdsoM7kOMZmLRXMe/FH5
	 gzZQ+kVrhhHansS5/mG3wYCwU3qJzmNmI+ykiidvvujgmHt7l9xaTQV7yQioagCixtw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795317630;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=gv3IQZHKimM8bI9m6RymLgtSv850RKl/MFJtLbuy7EI=;
	b=G3LT9zpJg6zGH4pLTYG3vmASnTIZUpGAoBVDq9DM/9iWd3XBs6ruWp0823UFSJXPc5s8
	 BU5ppUyMPQzVn+ZB6rfbLLwp7ZvuLRaUChBJgLz9Hc6vK9OuMzBNopj3pLtFtGKZ52c7s
	 X0GZVgTzKcUHdigYIhq3RGM+6zxU/eGNfU25+Vo7nVWz+/orGmbu9RKU063wtAIlQcxa/
	 FvXS3oB48eJF6p4G60DWiNRrVMlaBWn5XNg6favzFcf0VnCKqZAclhGEQ8gkNIa5bUVOm
	 CjUcAIhBR6i6wzIjgfpUjXZ3IF3e90Kh3e9x9O1ik9v95Om10oDkOQTwffl6Q914cUQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bWdJA9JX;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.160.174
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C6606A32A
	for <stable@vger.kernel.org>; Sun, 22 Nov 2026 03:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 129C6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=bWdJA9JX
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-54492d8a988so214641cf.0
        for <stable@vger.kernel.org>; Sat, 21 Nov 2026 19:20:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795317629; cv=none;
        d=google.com; s=arc-20260327;
        b=nAvo9uEgXpk1ibIQ7gfoAxEjgMzaCYuB/gUTVTsPXHkJFOqhd19bQnWhfTek9BUpvb
         KKTj9f49H00C/ucLP3RP3EsyJ7+isttWSJ6Rcpimo998XZZydRTuoa42DCl2LIS8QWiB
         hhhNR/k1n31WfUHpcpQYIOYTnILuEYqv9iy9Ps3mEpSpQNHHLWK/NQByMcspE8NhjJsJ
         +y9/Je6Cm+GGXCJVIMjFbYwTbVHD+Hj3wcOpiUXrN8HiO0IBLfnbC+L0ItRM93wYh1uK
         9O6MGiizvnP0TgCsIAvSp4KH5sIq9zDjKiql/QkyNLdFwSXp6qCIkwtOmG1uuqZz5orZ
         uowg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=gv3IQZHKimM8bI9m6RymLgtSv850RKl/MFJtLbuy7EI=;
        fh=cvjHTdhSVB5t/FMJi1YOKnHP2DpB7Gqen4YHMeF2uS4=;
        b=j1XIrLJBdAHIlxgv5a2nCnGDWtj/YJm9l/k2365c0QJ1s0L7CYlM3ExaCzd9dm07/k
         YhCp7etfxmDEQD7CtOExYefmjeC8clDvA1tmOU5s01edtxDES80zCsSAvUf2x1v4NxBm
         6QAIA8XYX78RKFHcPjq3W8yTCkYK1Z7LOq8q3bFFRFz5aP8chFdv6CGSBuE2OPFgq5NA
         6VEBjKl/P1UYnXTnXwlRF4FvjOE/hSZs3dB8s1/b8vDjHKPQOH3xqDyNAsQTRfCs4XIz
         fxheW1m3Aq1p5URXaVXaX4MX2SIH+YOLxzbf4Ks6Lh1/vH209Y/nTcAbwfz0M1KCKVYl
         NyrQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795317629; x=1795922429; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=gv3IQZHKimM8bI9m6RymLgtSv850RKl/MFJtLbuy7EI=;
        b=bWdJA9JXzA6k+6vXj8k2zooZrTTsa9a3/RARBL8SIkecf87yqPQy2ZPvyf+oNE4Bea
         kCrDQyxDoDUwgGlimFhBzH3cr6c11mDt22ysvWlYMXEKOQlgFA3b2ej3UrWw6CtFXeDP
         J+p3Yw8p1Z0Yp70HOqw29Xipmrk647a17AXfhcw0SEEr/uzn+ck0qcIm0IVfg4nte0Jz
         B29krk+C9tPa2Mj2TPzN3dF6jPaLEMAn6Ud5xsbW1CJuiEDYEnwCknrsIrLKTIsXSD4J
         AX4VaWK4sKAYp0vHS/iWvyEp379mRNeD8JJ0qOb/L4TLxXzE4F9b/Xej7kFpqAJIBUya
         8BrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795317629; x=1795922429;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gv3IQZHKimM8bI9m6RymLgtSv850RKl/MFJtLbuy7EI=;
        b=YWJyV/Xvm1xuy6pDQWIylNv/B2WI1lnfOYXNbjbkCwnCLbQs25EBbdqHbykowOYsLZ
         KrnJUsZSLSQvxj+dfLc6+H3dGPena2di6tkR+W/e0wgumsQz7aUjVra/AURpu2zHT1iL
         3iMMiR8AJlp58ntT1mL6hWdKgXzSut/TyQ5OrgD1GyrLx1x67GbBzw6Omi6ly6V9a/wv
         Y2UatnDbFNrg3V259WXM/YDN4GuffvoPnytQcTMPScQ1w1QKYCs4CJcFfWXhBByj95NV
         ppNhqr9tR7osikm5mntV+CV3mCnqj9VXNmwFjOn52ZkzfVbJYuA3EOD7bxvJ4kako9V5
         Ls9g==
X-Forwarded-Encrypted: i=1; AL+hErGjwMIHYbTuq6jUzU4F13JnKXcIjr+dkHf7u3Ggin63JHIbCSDo+MQdlnwU0WNcnoAx8utj9nA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+qxf71VGuol++ANq6mYZAbWrpYdOTWz9F504UhE/8e7+wFW8AO
	xLCJEC2G51Ov69jARZU2teUFe8dmVTpYCqIeuAcA1SOSuddr4QfUvOnX+wMeTD5IEmEmoEYRUaN
	04yHrurd5n1SQ+fTY8muc9yh+bkNcQOn9mINmqNdp
X-Gm-Gg: AZFdTZfCUnDgDHtMtGxVa/UmDK7upuvcFdz1jjd8qF/JQ7jBW6A3GvIenjKkbGGLU/6
	3CMkX+sMY8HuTNw60xxbXEBsLkcXO4kQSHHxytpPnX7cVnIHqQ5761oMzKOBx5/r5nRF34RZ3Qb
	GV/ggc+nCMtmvYGlvTxGDEO6pL+8oUrILnPPyBIBezZNxUiGDggEmo5g4NTrtYJNR3845gXcwWQ
	1dSFj6i07gbvkWzsYkqv9qIB9OsrjYN/cDokiZP/hgUqLG9ENX4ttdFnE5NDF5QENmV6YkOAgvv
	ZkZccHA2Cl61uzbay0gszh9oS4bhoYaXsskPO0x4SEJBCFEuX9N6kY4p52yk9S7TnQwkBtGU4Vh
	9QuvNy9zGTu4gMJJjnEj/GZqcSzXvb38vch6iLS2FkrfRnUzbngsi6/M7bym35WZq3TDDaxU=
X-Received: by 2002:ac8:6542:0:b0:55b:ab4a:6fad with SMTP id
 d75a77b69052e-55d88fffc05mr16118011cf.9.1795317628142; Sat, 21 Nov 2026
 19:20:28 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261121-some-more-ai-fixes-v1-0-236e925d9b64@kernel.org> <20261121-some-more-ai-fixes-v1-1-236e925d9b64@kernel.org>
In-Reply-To: <20261121-some-more-ai-fixes-v1-1-236e925d9b64@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 21 Nov 2026 19:20:16 -0800
X-Gm-Features: Aa3M54qj2gRAgBBYtx6A2i2xOdED2vuVhUgObvafxq4NJaUBmmLRoUOUdO8rGJk
Message-ID: <CAJuCfpGkHJv3DUL8tByCrN9_PT7MJnRkg+dJH_oj-gm+2q7Nuw@mail.gmail.com>
Subject: Re: [PATCH 1/7] mm/vma: error out on invalid bounds in unmapped_area_topdown()
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Pedro Falcato <pfalcato@suse.de>, 
	David Hildenbrand <david@kernel.org>, Jann Horn <jannh@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Kees Cook <kees@kernel.org>, Peter Zijlstra <a.p.zijlstra@chello.nl>, Ollie Wild <aaw@google.com>, 
	Adrian Bunk <bunk@stusta.de>, Xu Xin <xu.xin@linux.dev>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, Hugh Dickins <hughd@google.com>, Joey Gouly <joey.gouly@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org, 
	Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 21, 2026 at 8:03=E2=80=AFAM Lorenzo Stoakes (ARM) <ljs@kernel.o=
rg> wrote:
>
> unmapped_area_topdown() suffers from a class of bug arising from a mismat=
ch
> between how maple tree functions and VMA iterator functions express range=
s
> - the former inclusively, the latter exclusively.
>
> This is problematic with an exclusive upper bound of 0, as it translates
> to an inclusive upper bound of ULONG_MAX, that is a range which extends t=
o
> the end of the address space, and start < end or equivalent comparisons
> evaluate false in a situation where in fact the expression should evaluat=
e
> true.
>
> unmapped_area_topdown() calls vma_iter_area_highest() to position the VMA
> iterator into the next highest empty range spanning [low_limit,
> high_limit), iteratively reducing high_limit without checking whether it
> has reached 0.
>
> This can result in a [low_limit, 0) pair being passed to
> vma_iter_area_highest() and thus unexpected underflow. Consider:
>
>     vm_start        =3D 0x30000
>     stack_guard_gap =3D 0x100000
>     info->length    =3D 0x1000
>     high_limit      =3D vm_start_gap() =3D 0
>     high_limit - 1  =3D ULONG_MAX
>     window          =3D [low_limit, ULONG_MAX]
>     vma_iter_end()  =3D ULONG_MAX + 1 =3D 0
>     gap             =3D 0 - info->length =3D 0xfffffffffffff000
>
> The result is page aligned and below the IS_ERR_VALUE() range, so it
> does not look like an error. What follows depends on the caller:
>
>  - mmap() with no hint can fail with -ENOMEM while space is free. The
>    bottom-up fallback is skipped, and __get_unmapped_area() refuses the
>    address as above TASK_SIZE.
>  - On x86-64, find_nearest_trampoline() can pick the address for the
>    uprobe trampoline. _install_special_mapping() then inserts a VMA
>    whose vm_end is 0, and exit_mmap() frees kernel page tables that
>    every mm shares.
>  - On powerpc64 with the hash MMU, slice_get_unmapped_area() can pass
>    the address to alloc_extended_context(), which then writes out of
>    bounds of mm->context.extended_id[].
>
> mmap() can succeed with an address from the wrapped window where the
> range above TASK_SIZE is too short for the request and its alignment
> padding. On s390 that range is one page, so this takes no more than the
> default stack_guard_gap.
>
> Fix the issue by converting the loop into one that explicitly tests
> low_limit < high_limit.
>
> Additionally, simplify the logic by declaring the VMA iterator in the
> loop (it is reset on each iteration anyway) and exiting with the correct
> output value on success rather than performing a goto when an iteration i=
s
> required.
>
> Reported-by: Chris Mason <mason@kernel.org>
> Fixes: 58c5d0d6d522 ("mm/mmap: regression fix for unmapped_area{_topdown}=
")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Reviewed-by: Suren Baghdasaryan <surenb@google.com>

> ---
>  mm/vma.c | 42 ++++++++++++++++++++----------------------
>  1 file changed, 20 insertions(+), 22 deletions(-)
>
> diff --git a/mm/vma.c b/mm/vma.c
> index c82e9306b11a..09bbcdb4971b 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -3369,8 +3369,6 @@ unsigned long unmapped_area_topdown(struct vm_unmap=
ped_area_info *info)
>  {
>         unsigned long length, gap, gap_end;
>         unsigned long low_limit, high_limit;
> -       struct vm_area_struct *tmp;
> -       VMA_ITERATOR(vmi, current->mm, 0);
>
>         /* Adjust search length to account for worst case alignment overh=
ead */
>         length =3D info->length + info->align_mask + info->start_gap;
> @@ -3381,31 +3379,31 @@ unsigned long unmapped_area_topdown(struct vm_unm=
apped_area_info *info)
>         if (low_limit < mmap_min_addr)
>                 low_limit =3D mmap_min_addr;
>         high_limit =3D info->high_limit;
> -retry:
> -       if (vma_iter_area_highest(&vmi, low_limit, high_limit, length))
> -               return -ENOMEM;
>
> -       gap =3D vma_iter_end(&vmi) - info->length;
> -       gap -=3D (gap - info->align_offset) & info->align_mask;
> -       gap_end =3D vma_iter_end(&vmi);
> -       tmp =3D vma_next(&vmi);
> -        /* Avoid prev check if possible */
> -       if (tmp && vma_test_any_mask(tmp, VMA_STARTGAP_FLAGS)) {
> -               if (vm_start_gap(tmp) < gap_end) {
> +       while (low_limit < high_limit) {
> +               VMA_ITERATOR(vmi, current->mm, 0);
> +               struct vm_area_struct *tmp;
> +
> +               if (vma_iter_area_highest(&vmi, low_limit, high_limit, le=
ngth))
> +                       break;
> +
> +               gap =3D vma_iter_end(&vmi) - info->length;
> +               gap -=3D (gap - info->align_offset) & info->align_mask;
> +               gap_end =3D vma_iter_end(&vmi);
> +               tmp =3D vma_next(&vmi);
> +               /* Avoid prev check if possible */
> +               if (tmp && vma_test_any_mask(tmp, VMA_STARTGAP_FLAGS)) {
> +                       if (vm_start_gap(tmp) >=3D gap_end)
> +                               return gap;
>                         high_limit =3D vm_start_gap(tmp);
> -                       vma_iter_reset(&vmi);
> -                       goto retry;
> -               }
> -       } else {
> -               tmp =3D vma_prev(&vmi);
> -               if (tmp && vm_end_gap(tmp) > gap) {
> +               } else {
> +                       tmp =3D vma_prev(&vmi);
> +                       if (!tmp || vm_end_gap(tmp) <=3D gap)
> +                               return gap;
>                         high_limit =3D tmp->vm_start;
> -                       vma_iter_reset(&vmi);
> -                       goto retry;
>                 }
>         }
> -
> -       return gap;
> +       return -ENOMEM;
>  }
>
>  /*
>
> --
> 2.56.0
>
