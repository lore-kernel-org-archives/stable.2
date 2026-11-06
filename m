Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793972147;
	b=CH83sgsfPxyh79amxlY1Vszpg+jTO1rXWv2W3JvWEVb32F+BkdNfkvNp2S6aXFAx0w94
	 E39RGVILgQuy/K+kyDEUWNmwajZ4kFKH4sRgUSe0kakFZruQcNfD9Giq7FaKNpVnpDiNN
	 9LFvuURueg8yhsTpf6L4JZaTFpSWPkxJU8whdK4YRvK93R0YNgOb+ArSe/8O1cXq62q/Q
	 w5B7UjFpgewAAxWqrsOLWCMlDQM5Hj3UmU40iRj/s7XIMu2x0nEyrCS/LZUV2DOghxcF8
	 QD4XzXsuWDxz/j8ue9ZI+WQL04mbBrdZVd9Vv3FvU8fCsUjxks/dKoHS+fh1lQjsZvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793972147;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vqiBZf8MCJNi5yln1icHnq1nqZ0cACTANM4u61mdQZk=;
	b=iGMKqsW1CDZ/sOOeMw2NpM1ZROL1uawmsIb0BxmnCIAKXhe39MLaFF/VpN926rayL/Wq
	 Ki95pm1ZRjcAsk+UxA/3wruTuELLtl7NZYKEOcYlFbCGC3qWCrmV3pCIk3zNB3zlKKawL
	 Ly+dKOkTgP4wdc2tZyIe1crzcE4cM3stR8oUnkiM0p5+XtCITNu4bWOtkYjOrqp0YvivW
	 xJbOyWvX8T6rsu4VoOD7a+o7GI4aeSn7W9OsCl5hRTNEamHmp+hnjYjE7pewJvJb165qV
	 PfqnzQaJCOyYjkt/WDuakA1RxtP8VZJGUR5uCy9TQ2i0Q7uLnYghEexNmHdyV3BPVKg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AJF3puIu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901C6606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 13:35:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 901C6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AJF3puIu
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48b001cd92bso363078f8f.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 05:35:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793972145; cv=none;
        d=google.com; s=arc-20260327;
        b=XM6lMmZmEe2Z4m0Ex0Y/hgbGwq6xwprobfPmsVQLKxW1u8RQ4S5clFiIloxjLbb0xw
         mz/eGqzmX6j+JuIj2kz9++6yChJqtPJ2YVBDbnxG4yW5BsW/f/hcaVsRt/Z6H9+eP0UL
         bDV/pmFXEh3cApUGrhHwAzi1eigl83kbtONBXKl5tXxzSpJ/tnpIxicNzzUz7dlsDSZy
         yoCmc/gKRRsul+duiZYvStpRmSBa3H6vlwQAphQ1AX6OPIswtWRUSZBPdORN3cBtizrX
         COTU6hb4PTQCsy0m3AUMfoNI4VSHVp2/EUC1/RoV+NH3Ee1L/8XeWf5RQLpYPy4SFaOd
         k/BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vqiBZf8MCJNi5yln1icHnq1nqZ0cACTANM4u61mdQZk=;
        fh=YrBFc75Swy3/h9HB4Z+hTLgdkkeQ40tW2lrXeHyn+nI=;
        b=s7hM1X6w4FB5OdJTFoIfPzq7mE4edQNAZcYduVgaSGOVfK6nNh76hsAcNSZm+A2o+k
         GRwfIQieU6zeKq8gu6MgN8XPewWLYCzXcoFFFgukKj12GRzqjlB5HlkWz0z0VFV2AlwM
         8Fjz+nosEMOJMz0hBhvb8PGBM3wxc+nDIn0WNEkooS984Ej2APi3MdosiBwf3vCv8z9m
         s6pgboc9m1Yq7/NNX1qn0KkJiJDYciLSwRSMYRLh5JXK0tLoOWtDfmmLAeuYOvAzGoCu
         0va1vcZc6tuZxFz0vw6R43eNb7zPl7IkCFvyi3BEzCOvHZyVMqS/8ZvJv4ddK6YOZZ8W
         oDWA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793972145; x=1794576945; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vqiBZf8MCJNi5yln1icHnq1nqZ0cACTANM4u61mdQZk=;
        b=AJF3puIuRtNIJRLWbcLSabiCREtpW/FffWanMMkKvADW6k0WIXxsBRYfyaeu3auUn3
         Css5wFsawN7zzsyih8CxMOXs6kSAPS9c8MbAXxty84qFWfadQpsBcq23EO55FfC6NOa4
         3TpPwt5DGai5wE0jaDLlvrVjGosG7YALHiM9cR9mu7RNRYRLDYnsduEJSdPXsjCGguMW
         Mk3eV+VsGnV8sFSU0eDuxcgLilQTpvp+kyldgsKohj4UYNdmeOHecB2Fie1gQMlIGGkf
         Dp5IcoNq3SN8fdLuptYFs4NnMwLgEllTAsNUkvWMXAdms1qCJ4i5fQZ+UrrqM/DOYBvb
         aOnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793972145; x=1794576945;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vqiBZf8MCJNi5yln1icHnq1nqZ0cACTANM4u61mdQZk=;
        b=mQc6olRvNdlgXqaOfTn9AaOl7AM3k5NaC/dncXzqR5+eRQNa6MrdGfvFitZCqra1xi
         1O6quS5nxBrslfnLT9rAw2McpEUEbjlquXXioWAPxYoKMzwON13SR59NBI5cH0sXA+Np
         fDFHh9UV8lhZARic9EGNyuFc+YmDrIBeEdeb7ahe+9mMUAkDy/2O0JHp7m/Nu6cXA/AN
         XgZK1iFFZSSHjK7A+pCbbIbLOIACFiVUFOC04lsbc1dRxDi81TheNUCjBuKpW6jEaGrY
         LluAnF0vXWNE4lNvIt9o/vltDcNSzULExXIR6jAVmB3hz6fvulSFl0FC6VgZLJ0SOE0U
         5Fiw==
X-Forwarded-Encrypted: i=1; AL+hErHtidsPGtZv85TZ1OK1g46eEBnFgXxdM4aZN9wEGqkVW34/fmknrgRaUnc9HhCj0TWAJoAWzko=@vger.kernel.org
X-Gm-Message-State: APuU4Z93289e00+INdk8nIUtJH+CNqxL0htlVcYkfsuRxxopbQbJHbrc
	eu1QQRLAcpKYgnSwA9MLIZcttgqYaEqRYqg+iFdfjgBAsdlUcv9k5NQ7QTSdR3KfVHmshEbCdKy
	mmBzd3g/mazTPwNoMUX9U0U5SmU/7Iio=
X-Gm-Gg: AYBFou3SxH2TTGvnHh4eJPxgFkGqZJGBP/s1oyUXnOkFj+Ffms3LJq/j5PYLx8kV1tU
	zI4f9V7s64N7Sjl/LoG5qAxd0u7oS18qc1JU0jmGF9TegB0Os0e341w94vOTmhYVFYmHxte2Xrp
	/j4gDm2eec3wzYRfjok6wRNIqXKxmb5mLNzEkGiYpGBE/gRejmr5QxqQMKsNBx7KcydAjnP6OQm
	F6T7swhOoqWiNFHEbqLZraA7zhPSRaYumcOU75ZQvCQA40EQQ7wiD3sr145nMvpGvHmGtwBtaTk
	vUIvkXtLkTlTa2xux1w1obmeQb5HMuhs3hIlIDDOBKNrBUsYcGfeS2OkGbPVLoBWh8xQ+09erZH
	6mBDBC1yS+6HtcNE6uEjB0lOYReqAof0ivS3VAsP9aCAnVpdsJnIhyacImoneT1yjiUhgmWk8vl
	o3L0IsIAoZz+Sed/n3oncT+9xLEs4Bawo5DdcBl23g7ecjAC6JCrmb
X-Received: by 2002:a05:6000:4282:b0:48b:9ed:b81f with SMTP id
 ffacd0b85a97d-492760da82cmr5408804f8f.10.1793972144669; Fri, 06 Nov 2026
 05:35:44 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019160615.2348500-1-nphamcs@gmail.com> <CAMgjq7AEg6XEUJPaM3mMBQAeS_KiDv8_za4w-R2WaZ=ZGenvuw@mail.gmail.com>
 <CAKEwX=O=PL3DEaEDe=F-=zhQ=VW3_UtcqesdX9fH_cr6orb2wQ@mail.gmail.com> <CAMgjq7BSzYTbrzbA4vGqMbvegoHnDtJ0vA9PcwCet-m6Ow3ouA@mail.gmail.com>
In-Reply-To: <CAMgjq7BSzYTbrzbA4vGqMbvegoHnDtJ0vA9PcwCet-m6Ow3ouA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 6 Nov 2026 06:35:33 -0700
X-Gm-Features: AclHuK_c4e-RdWwmOq4OypJaP6HdPutPsMXoulXmVlinw_aIwzodsE6iH8OD2N4
Message-ID: <CAKEwX=O0s9n2x5p-BL1Hru3e-9z88Eg+JVM6OM02QTeY9a=xdQ@mail.gmail.com>
Subject: Re: [PATCH] mm, swap: revalidate populated clusters before scanning
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Baoquan He <baoquan.he@linux.dev>, 
	Barry Song <baohua@kernel.org>, Youngjun Park <youngjun.park@lge.com>, linux-mm <linux-mm@kvack.org>, 
	LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 11:53=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wro=
te:
>
>
> --- a/mm/swapfile.c
> +++ b/mm/swapfile.c
> @@ -449,9 +449,13 @@ static void swap_cluster_free_table(struct
> swap_cluster_info *ci)
>         swap_cluster_free_count_table(table);
>  }
>
> -static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t =
gfp)
> +static int swap_cluster_alloc_table(struct swap_cluster_info *ci, gfp_t =
gfp,
> +               bool locked)
>  {
>         struct swap_table *table =3D NULL;
> +       struct swap_memcg_table *memcg_table =3D NULL;
> +       unsigned long *zeromap =3D NULL;
> +
>         struct folio *folio;
>
>         /* The cluster must be empty and not on any list during allocatio=
n. */
> @@ -472,8 +476,8 @@ static int swap_cluster_alloc_table(struct
> swap_cluster_info *ci, gfp_t gfp)
>  #ifdef CONFIG_MEMCG
>         if (!mem_cgroup_disabled()) {
>                 VM_WARN_ON_ONCE(ci->memcg_table);
> -               ci->memcg_table =3D kzalloc_obj(*ci->memcg_table, gfp);
> -               if (!ci->memcg_table) {
> +               memcg_table =3D kzalloc_obj(*ci->memcg_table, gfp);
> +               if (!memcg_table) {
>                         swap_cluster_free_count_table(table);
>                         return -ENOMEM;
>                 }
> @@ -484,8 +488,8 @@ static int swap_cluster_alloc_table(struct
> swap_cluster_info *ci, gfp_t gfp)
>         VM_WARN_ON_ONCE(ci->zero_bitmap);
>         ci->zero_bitmap =3D bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
>         if (!ci->zero_bitmap) {
> -               swap_cluster_free_table(ci);
>                 swap_cluster_free_count_table(table);
> +               kfree(memcg_table);
>                 return -ENOMEM;
>         }
>  #endif
> @@ -494,6 +498,20 @@ static int swap_cluster_alloc_table(struct
> swap_cluster_info *ci, gfp_t gfp)
>          * Make tables visible to cluster_is_usable() after everything is
>          * ready.
>          */
> +       if (!locked) {
> +               / * Lock it here before assign, not after the asssign
> and return */
> ...
>
> This should fix all potential issues I think?

Lol this shows up twice under vswap's sashiko reports:

https://lore.kernel.org/all/sashiko-outbox-181084@kernel.org
https://lore.kernel.org/all/sashiko-outbox-181086@kernel.org

Now it's personal :P

Anyway, I'm sending a patch soon based on your idea (will keep your
attribution around, if you don't mind - but we'd need more eyes to
review it to ironclad it). I also have a couple more fixes along the
way. Nice thing about sashiko is that it's digging out existing issues
while reviewing new code, for free!
