Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E4E34FF78
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 18:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785955581; cv=pass; b=ee714jxdecv84HAxwLdJvDARjIWS22l+BLWJhU317vqSybEdOzM0xpgSs5PSJ+NguVg4eQgGeKTjmF6Qfejs4XmL0SlR1W9K6L4KOvAfK1iYDtBSreBKUg2oFo+X5GjYBnAxepHqmWl+Tuu/PPD4YdOofuie92cojeKhfCHjiHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785955581; c=relaxed/simple;
	bh=VHC/9TwijeBDOOisSoYmB168anR09Wauva2iRFh5CKU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XwQjx5HOuSFiq+gz35Jxuk9lF+8PFr32s4RNPCuhc2S/mHZfGDXs5GwQjd8234ZDrrRj68dYYV3Hu1ktJ39K2BE1/+2OfEYrr6LEx+tU76Mb2JZ4JQ7PhytO4TPKWV7QCq9OfzKxKDK2n9mCMVuYu8FyiYJbNInOlc42Kq6mXgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QhMnK9JM; arc=pass smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhMnK9JM"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-ca766c1c9ccso1076028a12.0
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 11:46:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785955579; cv=none;
        d=google.com; s=arc-20260327;
        b=HL581/VBmCzSioGJlAa2iusmHKqemkeNhQgTcPNqKaOgKfo20TxeQ0nVj/pZGz4Pwc
         VEdRYqzC8lGPWYTLtY/Cyhs5uZlHNBTqo1m7vvxMcvc56UKX3Eh23VPwmqjEonJbe4A2
         lMjgZbfpyh+NUxZqzb2m6zUCN6oZFmkvgJXxrHiiUDOBQVheODXUasH6n6b0zuaYkUPJ
         0GX3bs1pSEOkfHI1FemXhg8iM42FoG2RPb56gNoIsfyIthtMqGkqcz6u7YdM7Rps1kuM
         zupE8Iup5qzhaXA5tNr4y0TjGMJqnEQXg+UcsCO3SvWJ4nHioB3lZGsORmlDOnu+5QWS
         GWYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oraTB2zvKCroH6GNMJ43qFqh2yfzAvZ70RBsZUY2AEc=;
        fh=tXELnyKFzGo1+5zKVs81ZXxEUssDgl8EOqdXRl7Gg5c=;
        b=DDLMYzF6VwyV+54fj854DcmKdYKsQjqcCnWrX5yH5+auBdnyHdIBLY4wmNy69lQuRC
         OQy9JnYG8zu4YPqyUnXQmQEuuJxwPPYlAe+zPnChBtvgNZVV0vkR2FBms+an2jJJy1Ig
         kcQAMGUxkWNMyBZhDytOe8BktygEhfSckjnEXWfYPeGR3YC1xrlLIfDWYSGdWgxQYxxM
         C7dOLo5H7g0IzG9XqBMOSOCNQQXq041jQXTcz2YR5SgQQEKKHeQj/oSabJVEIqY+lVbp
         sI8D1plVD7Xujk7fjTzTsYPN8UlUBCawlM5d4KodoLd5SCwgUrUGvuGoijJyftIGKABH
         fV7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785955579; x=1786560379; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oraTB2zvKCroH6GNMJ43qFqh2yfzAvZ70RBsZUY2AEc=;
        b=QhMnK9JMBm1Rj7sLNd56LORdJFkHPuNOeST/AnwwQpvMNaA7SUKENrd7kJ3AGscUSg
         To16P3g6vZoWXkPyhtMdyrTDsc3E/85AVOhrStiaLL0QkJxQWi1s42ZFV7E0B/dGR4F0
         02QUgqCUDxuMVqFUmcP6KCkycGp6GZWLZ330zDoB4KTNrSgd7e6tXHMIkgEjZzFGif3a
         9P/uJxndsj2D+2Aa+3sngV7kJ9XgKZs8FoOOZDtqlDB1U+AdecRmLDzWpvuBFXe+ZhWM
         2zu5Ny4ZaZwbSUelpARiQ6QGsWeBfQxB2khjm7WdYsakuEQrpHFNhsMbciuWnqpNDdyI
         DDdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785955579; x=1786560379;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oraTB2zvKCroH6GNMJ43qFqh2yfzAvZ70RBsZUY2AEc=;
        b=Hmxpf9qCN73RlRgrbWsykT+RGrAUbwppyACklgP2tQiDMAUAIyrmO8YAnJgj7jUFGg
         QGQARZB0xiB4xvjnzDz/kKyANvaxAbxDQ81R9EyjiUsqrd2hWa4A85DTgLfKx8e+sMKo
         CNoGFeRVRrltXSmNcs6VJEs7MZzkAfb9Rb5yiXY6x6Y+j5dfFro+CPHJ3Kd4ikeXciMa
         C7KQgllWydJopWkSnnyZofLPfquan1rTlm+zdM/rgSXuE/Z+svbg5uLGl22zQH+QNf3G
         bnTvvOWqLaygLpKcZsmmEQfsd6P7GGEHNKmEVm+eDK9B4rYbx6Dk52qadHdIzy6Pi0uf
         Hhng==
X-Forwarded-Encrypted: i=1; AHgh+RrISQ+5Ra/sWevWfVGdjsZ4qMaFubGCb/u5oCPZZmKjWTNW7tqSf8QAyZr4de6LKMccpB5Gsz0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywymok2SwIPdjH+Vjn+M+fYl94Lrcq6HK/trtzCsD1I23yiUJsZ
	p/g5KAPezIktHJSzsdLz0geaX7IrlYZP/M5gG7xYXxwdTMx/oYpFDjjOmiVjmKgj3XkFrYcvj9r
	PcfbApU6XiuVjz10tuaCVTDyP//CcYMtZWQ==
X-Gm-Gg: AR+sD12cPgND+eBRSqnE5EjEDYefdYF4VdNUq9DWSwi93xUmKXcrpBKfngvkx2AApTk
	p3hc0K+ngqeH2lrYDeCE3AjkfB6j8Nvv5nI3FetMFc38kqrvN6sntlNOpcQ5EX4X/0Qz7wYVcbe
	1WNgwj3AsUxL2LRTk6ytO4lc4Uzac227NL8AXX+fGBh1usMdxRX4W9JS5RUqsxOWhqg2MSzr9eX
	RiflKmIyqR6oG9VesmloYzLSUQs8NAunnLBEhH2CYkW7YA48NFhrCTSHs0tk0/oJUUx2v87/5G1
	UKMALCyJaClm979D0706tX5sXipm8fGjVvgrB1eFU5IURuZN7CqFDkmbm3gw1baJbG/xcNQr2N1
	XgbhAtOr65jl/5WCqRBRI5PYXNA==
X-Received: by 2002:a05:6a00:9517:b0:84e:e809:dd49 with SMTP id
 d2e1a72fcca58-84f2e12d02bmr9403279b3a.36.1785955579296; Wed, 05 Aug 2026
 11:46:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260805060228.2703051-1-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20260805060228.2703051-1-Jeremy.Jean@oss.cyber.gouv.fr>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 5 Aug 2026 11:46:06 -0700
X-Gm-Features: AUfX_mz14l4BoLCHjdW3KnF8TblLUAl2yEU1dQ_INvK4a0wgPeZvuMP7ST-djpU
Message-ID: <CAEf4BzbQ3qURHOpFL4feXqOpggJJupp7NzPMU1jeH_p4CuvLWg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf] bpf: harden bloom filter sizing and indexing on
 32-bit kernels
To: =?UTF-8?B?SsOpcsOpbXkgSmVhbg==?= <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: bpf@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 4, 2026 at 11:03=E2=80=AFPM J=C3=A9r=C3=A9my Jean
<Jeremy.Jean@oss.cyber.gouv.fr> wrote:
>
> bloom_map_alloc() has two 32-bit-specific problems when the computed
> bitmap reaches the U32_MAX fallback case.
>
> First, BITS_TO_BYTES(U32_MAX) is evaluated with 32-bit arithmetic. The
> addition performed by DIV_ROUND_UP wraps, so the map allocates only the
> fixed-size bloom filter object while keeping bitset_mask =3D=3D U32_MAX.
> Subsequent updates can then write past the allocated object.
>
> Second, fixing only the allocation size is not sufficient. The bloom hash
> is a u32, but set_bit() takes a signed long bit number and x86 test_bit()
> eventually feeds the index to variable_test_bit(long, ...). On 32-bit
> kernels, hashes in [0x80000000, U32_MAX] therefore become negative bit
> offsets. x86 bt/bts with a memory operand interpret those offsets relativ=
e
> to the supplied base, so a map with bitset_mask =3D=3D U32_MAX can read o=
r
> write before bloom->bitset even after allocating the full 512 MiB bitmap.
>
> Keep the U32_MAX fallback, but split each hash into a word pointer and an
> in-word bit number before calling test_bit() or set_bit(). The bitops
> argument is then always in [0, BITS_PER_LONG - 1], while BIT_WORD(h) stil=
l
> selects the intended word in the full bitmap.
>
> Compute the bitset size from (u64)bitset_mask + 1 before passing the fina=
l
> size to bpf_map_area_alloc(). This fixes the original under-allocation an=
d
> keeps the allocated storage consistent with the addressable bitset.
>
> Exploitation note: local privilege escalation is possible on a 32-bit x86
> kernel using the under-allocation bug from a binary with CAP_BPF.
>
> Fixes: 9330986c0300 ("bpf: Add bloom filter map implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: J=C3=A9r=C3=A9my Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> Assisted-by: Codex:gpt-5
> ---
> v1: https://lore.kernel.org/bpf/20260731204917.3845309-1-Jeremy.Jean@oss.=
cyber.gouv.fr/
> v2: https://lore.kernel.org/bpf/20260801083436.4014218-1-Jeremy.Jean@oss.=
cyber.gouv.fr/
>
> Changes in v3:
> - Address change request simplification from Andrii
>
> Changes in v2:
> - Address AI reviews.
> - Split full-width hashes into a word pointer and an in-word bit number
>   before calling bitops, so upper-half u32 hashes cannot become negative
>   offsets on 32-bit kernels.
> - Drop the redundant final u64 add-overflow check; bitset_bytes is bounde=
d
>   at 512 MiB once it is computed from bitset_mask.
>
>  kernel/bpf/bloom_filter.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/kernel/bpf/bloom_filter.c b/kernel/bpf/bloom_filter.c
> index b73336c..b63839d 100644
> --- a/kernel/bpf/bloom_filter.c
> +++ b/kernel/bpf/bloom_filter.c
> @@ -41,7 +41,8 @@ static long bloom_map_peek_elem(struct bpf_map *map, vo=
id *value)
>
>         for (i =3D 0; i < bloom->nr_hash_funcs; i++) {
>                 h =3D hash(bloom, value, map->value_size, i);
> -               if (!test_bit(h, bloom->bitset))
> +               if (!test_bit(h % BITS_PER_LONG,
> +                             bloom->bitset + BIT_WORD(h)))

this fits on single line, fixed while applying, pushed to bpf-next, thanks

>                         return -ENOENT;
>         }
>
> @@ -57,9 +58,13 @@ static long bloom_map_push_elem(struct bpf_map *map, v=
oid *value, u64 flags)
>         if (flags !=3D BPF_ANY)
>                 return -EINVAL;
>
> +       /*
> +        * On 32-bit architectures, hashes larger than INT_MAX would be
> +        * treated as negative by set_bit().
> +        */
>         for (i =3D 0; i < bloom->nr_hash_funcs; i++) {
>                 h =3D hash(bloom, value, map->value_size, i);
> -               set_bit(h, bloom->bitset);
> +               set_bit(h % BITS_PER_LONG, bloom->bitset + BIT_WORD(h));
>         }
>
>         return 0;
> @@ -94,9 +99,10 @@ static int bloom_map_alloc_check(union bpf_attr *attr)
>
>  static struct bpf_map *bloom_map_alloc(union bpf_attr *attr)
>  {
> -       u32 bitset_bytes, bitset_mask, nr_hash_funcs, nr_bits;
> +       u32 bitset_mask, nr_hash_funcs, nr_bits;
>         int numa_node =3D bpf_map_attr_numa_node(attr);
>         struct bpf_bloom_filter *bloom;
> +       u64 bitset_bytes;
>
>         if (attr->key_size !=3D 0 || attr->value_size =3D=3D 0 ||
>             attr->max_entries =3D=3D 0 ||
> @@ -127,22 +133,16 @@ static struct bpf_map *bloom_map_alloc(union bpf_at=
tr *attr)
>         if (check_mul_overflow(attr->max_entries, nr_hash_funcs, &nr_bits=
) ||
>             check_mul_overflow(nr_bits / 5, (u32)7, &nr_bits) ||
>             nr_bits > (1UL << 31)) {
> -               /* The bit array size is 2^32 bits but to avoid overflowi=
ng the
> -                * u32, we use U32_MAX, which will round up to the equiva=
lent
> -                * number of bytes
> -                */
> -               bitset_bytes =3D BITS_TO_BYTES(U32_MAX);
>                 bitset_mask =3D U32_MAX;
>         } else {
>                 if (nr_bits <=3D BITS_PER_LONG)
>                         nr_bits =3D BITS_PER_LONG;
>                 else
>                         nr_bits =3D roundup_pow_of_two(nr_bits);
> -               bitset_bytes =3D BITS_TO_BYTES(nr_bits);
>                 bitset_mask =3D nr_bits - 1;
>         }
>
> -       bitset_bytes =3D roundup(bitset_bytes, sizeof(unsigned long));
> +       bitset_bytes =3D BITS_TO_LONGS((u64)bitset_mask + 1) * sizeof(uns=
igned long);
>         bloom =3D bpf_map_area_alloc(sizeof(*bloom) + bitset_bytes, numa_=
node);
>
>         if (!bloom)
> --
> 2.47.3
>
