Received: from mail-ed2-f33.google.com (mail-ed2-f33.google.com [74.125.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF13397E85
	for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.97
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790550485; cv=pass; b=ML4r5JCaL4qs3k7X7xYOKLHE8nCXbpDr4FPLXnrOQCZ2k2cpf3l0TxDYO8rg2cTCV9y2LnrUgodsNEs5dx6UmY0ppDPo59lgcHjMeHL6aywTxLhMke7ui3Jeo/NdLHsB0tLm7qm7E7GwWRxreZwPjTZFdxOj+35nq6C+zjw34bI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790550485; c=relaxed/simple;
	bh=CTNDXQo5Ik8pEUNZkcnEchXw8zaYFKTIx91vzZ5s5LI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U2VSFgDz28hWKWm1x7GhGCuJeMMT3KgHA+GPUKCL8UpWSYQbSx8LE52rQNjncVJ5Y/v3y6RskBsH/pGGR2VcTRqB+HCTBd/eQR9/JszQ4RJiypUFION7c6tfRH8wgIy8gD3kfdx67Am8DW2kCM/+D4eA6PB1hpuVPhCVSJn/FBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EF9Z6Iyf; arc=pass smtp.client-ip=74.125.228.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EF9Z6Iyf"
Received: by mail-ed2-f33.google.com with SMTP id 4fb4d7f45d1cf-6ac6f5c507fso769437a12.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 16:08:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790550482; cv=none;
        d=google.com; s=arc-20260327;
        b=p6Yx0gAFC3JV1suWdybMYCoKTWDlI6uYGvbROuyN9Ia5KO5IoiiHzEbUkLj8+UpHVR
         5rvEbYyBsMyAQF0jrJsqyMQbdk+ep9KMZphdXnXOFPvW8yUuxTABgjfXzGxKoHk6SZHp
         q2Yi622uBk9j9KwreWuXO8zyTL9lXhU0HfQC8ycAZonA6VfF7/zoEa8/T7AqKjt2A5ee
         ivyloDtnDy29n80M49WCH2LxHthRivMRljxWPN52stb2U5Ai+fWC5ynIUqWDn0wYgvMH
         MGZuW89+xMQltKYpVAnK5FIw+IWLVVSI3dB5ye0mnV47LoZczwumcyyshCmj1NU1/6sx
         F3Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JG/tCdTlMmUy1VQCk4CZdBjuAkjHwjba+Uca0dFauBE=;
        fh=Pq4q1GVxzwTQMts1Y2/SydpzmT/VfSPVP3XkGaRi9J8=;
        b=GkVEKe5ktcwv4dL6j0X27K6QL2/a++QX2z2LdQSITMtMO6/Sqb83IJwDGfEqYevnhx
         W3z1+Nt9tvRYnSLtDK+xWvHe4Z/bt+GohUf3WGpuDhx1ef3l9C5QQWyYci2eJLWAVgHH
         0tOMbZx7YiobUbbhSFuUacEj8DJbknaPTcc4/6G9akF+OKAN3f8kBoGL56P4D10d6ttW
         p4zma7aazXz21FRZydsYc2qTeRHCccDNoUHEJnBM8O4pdmhk2CcisSa4BcZ7/AqZkoDx
         wVIdz92Fnmhvih7l9rIIVPVPb8SwGoqF5Rv2ys3CowN+ZBzTOvOuOvcchi96BVWuDCcl
         9sag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790550482; x=1791155282; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=JG/tCdTlMmUy1VQCk4CZdBjuAkjHwjba+Uca0dFauBE=;
        b=EF9Z6Iyfy2P/6Loz3rpDWJeRmPhCmWYfpFDgQlsKyJjetf7T9rR6YNb2VmsOWbMAhy
         xRGdj1qLEFC7pfzbSXPdSzK0mwYl3eU9R7UDNgDSX/6FVLoqtMhlPFLh8V2HHM7IWRig
         AssMM5DxalH+MY5/e7uZIl44Wj1bJYxtlVnQZttXSJvK8vYiUINXGQ0iKXp2XxPHb2zL
         ANMMkv7euaPBZtjWSCaZeHKVPUHM9oF4voyNYNpX+OBVbLwRnMPOw1GhYZBgCAxC2ZUM
         4+Gx9iR3pkekQmVn1bT86x+h1JTgQN+R3NRAYVJqlWDz8kstBQcA5+XfjOjuc11sZKSo
         YZRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790550482; x=1791155282;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JG/tCdTlMmUy1VQCk4CZdBjuAkjHwjba+Uca0dFauBE=;
        b=GZSCEp9ITByLZ3gKZptIOa+OR9ye3Mi9k+Iz/AOr4t6ClNsl2BlqAYfqnJTsC8jad/
         qW+yx/vNDbyFc2QFjhaBZmyjqFhBB2NZS8L4yyC/KPTjYJUY/C4gvLw+k/5sQTRC1TN2
         sewAlcyQ/To1DZCZZq8+LeIzA/KLItpLy1o8e13VuLeWj8TBeh+2BF90EEgZM0OLN1Im
         VSD8qjCIw0jnFiJfoICJWijik6SH7+yiE2pLLFT/DF/BaXNeRFf+4hj4iAaHvXmm5imQ
         uVfqgAZzFfKwKiHBdROP00x4AfImaIhH2rilBuh85lnbhWgpSHIpiEvu9yI4NyOBFTwX
         EP1g==
X-Forwarded-Encrypted: i=1; AKwUvBx8ByeVuEw5MGj6a5NC9U0vI8hyp8dCykYBRzB4Sj2yYQiseE4o+JX1THOtIuHSYT08Ov4fQdI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLSJNSNLpt2VsJiw2933h1UCjqNOpKzo43MXgvSqm9arniRuJvN
	FPwj5CeCqi4uhoS3fUfs7HPilUzwMUTvZBkV8SGFHNCCAbNOG8g1HQ9buz1N8i9j1TIbUATJDWu
	3A8e40kXkuroGQ3IF93bNwWF58IMkZKw=
X-Gm-Gg: AYBFou2YAKhaWqtI4yEandQB6bgVzq7G7Mw+qLdpY53pbBRZQn5J05O0Dts/FvD7Qbs
	Ou49pDZZRL7fiDOKFjn/HgbFaSNQSQFZ2qf4mK+KuPxYXyOY4k1OLVbqslGE+Fmz2GHq5X0t9NP
	AlZth1gHacuIfBfzN8amcBy4whdKAnuUnk9+HMfz2hPxAOLSJSiLYer7REEFJHQfl21pmKApeE3
	jDu02YPGwIONsKgxaGX33k5rK3IoMLfT0wmPKpIU3eWAQqjMbEyMYrfv3K6SQp0AGDcDX4mLgdu
	kZ4d4zEK2zz0rlCjvl6nyrTjq1TDph4cJ0WSINXeA9+EvdMKHabuSSULsgZ/aFqay1YOf7JqzqH
	VkvrlMEbpmRYWZwKQ+f2vuakkWHkkoa9uw59aMJnvKQ==
X-Received: by 2002:a05:6402:208d:10b0:6aa:9fef:641c with SMTP id
 4fb4d7f45d1cf-6aac8f5b1d1mr7218826a12.28.1790550481746; Sun, 27 Sep 2026
 16:08:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260927005801.8338-1-kaloz@kernel.org>
In-Reply-To: <20260927005801.8338-1-kaloz@kernel.org>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Mon, 28 Sep 2026 01:07:50 +0200
X-Gm-Features: AclHuK9wHFvF9AvbW3RHi3XsF87LZ25o8TZ7kIUlgFBipgElEQ_7njdLdEtPwZ0
Message-ID: <CA+=Fv5SEwB2b2On=2kEWq2hWMKVauDZ7wqa6+6xPD5nmBgGASw@mail.gmail.com>
Subject: Re: [PATCH] sparc32: don't clear the nocache pool through the PROM mappings
To: Imre Kaloz <kaloz@kernel.org>
Cc: Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Imre,

On Sun, Sep 27, 2026 at 2:59=E2=80=AFAM Imre Kaloz <kaloz@kernel.org> wrote=
:
>
> srmmu_nocache_init() runs before the switch to srmmu_swapper_pg_dir, so
> lowmem is still reached through the PROM mappings the head code inherits
> for KERNBASE, which end at 10MB on a SPARCstation 20. The pool, up to
> 5MB and allocated right above the kernel, was cleared there twice, by
> memblock_alloc() and by the memset(). Once the kernel image ends above
> 5MB the clear runs past the PROM's window, faults, and the boot CPU
> enters error mode.
>
> Every user of the pool clears what it allocates, so allocate the pool
> with memblock_alloc_raw(), after the bitmap so the bitmap lands below it.
>
> This has been broken since 2.4.0-test2pre2.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Imre Kaloz <kaloz@kernel.org>


Very nice work, this makes a lot of sense.

For the record, an unpatched kernel
(carrying only the patch series needed to boot:)
https://lore.kernel.org/sparclinux/20260816075141.3489194-1-linmag7@gmail.c=
om/T/#t

boots fine here: SS-20, PROM 2.25R, 512MB, 6MB kernel image, nocache
pool at its 1280-page cap. So the PROM window is not always small enough fo=
r
this to bite. Happy to dig into what this machine actually maps and report =
back.

Magnus


> ---
>
> Notes:
>     No Fixes: tag: this has been broken since 2.4.0-test2pre2, before the
>     git history.
>
>  arch/sparc/mm/srmmu.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
> index 9a74902ad181..16d5cde4f949 100644
> --- a/arch/sparc/mm/srmmu.c
> +++ b/arch/sparc/mm/srmmu.c
> @@ -277,15 +277,24 @@ static void __init srmmu_nocache_init(void)
>
>         bitmap_bits =3D srmmu_nocache_size >> SRMMU_NOCACHE_BITMAP_SHIFT;
>
> -       srmmu_nocache_pool =3D memblock_alloc_or_panic(srmmu_nocache_size=
,
> -                                           SRMMU_NOCACHE_ALIGN_MAX);
> -       memset(srmmu_nocache_pool, 0, srmmu_nocache_size);
> -
>         srmmu_nocache_bitmap =3D
>                 memblock_alloc_or_panic(BITS_TO_LONGS(bitmap_bits) * size=
of(long),
>                                SMP_CACHE_BYTES);
>         bit_map_init(&srmmu_nocache_map, srmmu_nocache_bitmap, bitmap_bit=
s);
>
> +       /*
> +        * Until the switch to srmmu_swapper_pg_dir, lowmem is only reach=
able
> +        * through the PROM's mappings, which may end below the top of th=
e pool
> +        * (at 10MB on the SPARCstation 20). Allocate the pool after the =
bitmap
> +        * so the bitmap stays below it, and leave it uncleared: every us=
er of
> +        * the pool clears what it allocates.
> +        */
> +       srmmu_nocache_pool =3D memblock_alloc_raw(srmmu_nocache_size,
> +                                               SRMMU_NOCACHE_ALIGN_MAX);
> +       if (!srmmu_nocache_pool)
> +               panic("%s: Failed to allocate %lu bytes\n", __func__,
> +                     srmmu_nocache_size);
> +
>         srmmu_swapper_pg_dir =3D __srmmu_get_nocache(SRMMU_PGD_TABLE_SIZE=
, SRMMU_PGD_TABLE_SIZE);
>         memset(__nocache_fix(srmmu_swapper_pg_dir), 0, SRMMU_PGD_TABLE_SI=
ZE);
>         init_mm.pgd =3D srmmu_swapper_pg_dir;
>
> base-commit: 62f4c998b297cf233997a2b4cd6fc2d2df0319c9
> --
> 2.47.3
>
>
