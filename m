Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F553C6600
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 07:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788161579; cv=pass; b=AMFsciKGs0+YHA8x3b+Yl5Ln0GWCw4WfF3kHYYMUBl2QkSxbYZn+KQ7/708KKj3o+I3MG3tHdgM0hFzlJRhHrb7lRlKx0Mp6YNIK/WFf0pr0Um+gUGY0gjjb3xTZwJ5V9ItDtnavstkj9ISz2tg2UxF4jf86yvVf6UvMWe4Syvo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788161579; c=relaxed/simple;
	bh=wo5jkpGnamGtjDuY1R1XZZcEwvVo/Wee6YR7yCBKlpI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Uwbs8FeOYlicL/seDlNNK8rv/uLppCzkhE5P0zNd8lzyfqP/LVQaqvUqp5lKEQExQKRRkV0pFpVAQnKlPr66mZVilEUfHArGD75qzce2a6vz1hFOIyjJPQEnMGXqpjierFkkUESpHmN70+VAbe56dO+PC/aomG0IPiCNenMaNb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com; spf=pass smtp.mailfrom=clyso.com; dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b=f6AYMuAK; arc=pass smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=clyso.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=clyso.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=clyso.com header.i=@clyso.com header.b="f6AYMuAK"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c255acff671so423374566b.0
        for <stable@vger.kernel.org>; Mon, 31 Aug 2026 00:32:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788161571; cv=none;
        d=google.com; s=arc-20260327;
        b=g2+3UJ/13WChsvShlDaeTkuBJ42M2JqCVcbObcmf3KDQoULuik3apIT5/VC74AD4UZ
         cC3LuSn+3qnNLYj1Sbi+c0KmyPnCkpa4BNFQ/bOCG6jGnewVzExMyCwnBoSq6XMHS2wh
         QAghvKRZdvwbYjVnahnfayJzp6g+rz9lxlscZiw2ZqJgolnkj6veDKOglokaKwziItYQ
         1T0QIdqdsOGAlHAeLo6tSqjm7wnmbKNWEhA8Y4PQJZztpBqlpA+ZiC5a8j/6QNQ9gxHp
         5HMSJMWULCLXgrppEznx5lKqQB1VKsBCNe9MdWeUHPYW1pgWjRyl9myEgaw0moLVKGfv
         CDGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=PFvhvOnOzBnlu/OCaPBHd1SISKgOpJNjXdUIfIOx0Q4=;
        fh=kVUCtW07rTF4L3mgCIb5NbnJkiX3nKr3J/m+HanYbrU=;
        b=mZV03srAq9dKow67zndUHg1fmZkb6cnwVJT+nxt+FTweFN+5nKSkAuHtVobTacvPDR
         MxG99TSeDjAR+yBDcn42+0fDRflBhShIwTtVZosakCK2GhS/4IvIOTNm82NLIBq7Lc07
         9oBO77CxUXgiH6U2WgLCtHGjImKojfp7oFZvtNmrkdBhX8NlJxPtdqilKGZid+1yRWlj
         ZKNkyr2lzZonvMVL02e3A8UDslZes1E62OI+RMB7yRbZKxhRqJ9p762VANnh3SeKjWA7
         y3+CeTacF0FpdMU5CvJRLTWud+mkzA5JY68OVHnOGBZCbwc0EzXIgmXQy6i/7A/MhxQl
         F7Jg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=clyso.com; s=google; t=1788161571; x=1788766371; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PFvhvOnOzBnlu/OCaPBHd1SISKgOpJNjXdUIfIOx0Q4=;
        b=f6AYMuAKCVCLLVTU/UqAVPdDGMaN2fvyMC0JpHLPuyC1uPmnZ/T9g81RiK/tHorVvE
         7NreaCWxZ3qFY7UR56ICcQkQ+BV9+9buro2L17rZl+HpdEhJCxH9akKh0JVG9LUS8kRG
         yzZk/fOSzs2RIiT1uX8rT0pceA1CmSvgydPxZAcHbCZH6FdGvGRecyg6zREysf06Xj+1
         +84pww3ewgG9b2kj5FbfY1O7hfmbISSERzDrvIuJWMHW7GdpfxRoFh6p/B2UbSyublze
         xrnoDFziJsifRSGfBUVJsvNWyE76gYRv6RMpAOeOpgEfr3rQBrIh9QIVfWwZaHKR2DFD
         CryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788161571; x=1788766371;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PFvhvOnOzBnlu/OCaPBHd1SISKgOpJNjXdUIfIOx0Q4=;
        b=kRkTJk565z5AYol0u9S8BOhAAujBeTArITdOXUNNO5CgvohadCb+zVDbuw9I+bLZ89
         v6WtFwN9aIZazduahhPnhB6ffAUiEJnRQVRXjewU5u6aBTOxmhRkP2agiVAXNxY7MB0/
         XFL9uB3I7iysWoUHFRWKgZOdptS/MsFIlfg61OO+va0fRGGtNGgBl/5nQZQ98Gy8fP1e
         gbGxu9nHKV3+I8rEly64UWVItssSM+miRBsMYcN/rmHKNSmq3KyJJnuD5l910FaSxAxb
         M/5OrD1vhD0sxhvywjp1bMHPDt28ZkCUjsaZ2+WCHINGGEGKsECwE+/DtNDDj1ZXNfTz
         qDLw==
X-Forwarded-Encrypted: i=1; AHgh+RrqWq4r86rncvjneDRPsg9yItTQwvG73UEGDTdPAdk/ASgJkBpqXELiFvcZrud+kgz/Ng09e8I=@vger.kernel.org
X-Gm-Message-State: AFuF++nipta5kXknC/TFxjYVmR/BihD4CpKNCNk9fYdUyKLfOBArPWRr
	0ksQEH+8bVoa8swlSRYL8gRvr9qPRZ0bICBn7F7KljyT3U/sOSriAlZMRe5Ja3ARS39II5VjOcs
	a3ie2UsLiIydFcCmicIbFcGOpsOKGfNa+h7kcEYQR7g==
X-Gm-Gg: AR+sD13JfQJ6PCAaoxJhvJKWrPAlB8boAdOmZh3jne8lVZSvM0dQX9g3sk0px5KO8p0
	W54jwBbWIe3WVTlJtHSwol5qBhRe4Cs0OIaEiXyEseN9Ow+uz/UC5qIuc/y+lC0LKY8JBvqr2zF
	V49/JH8TE8zw/xNYXrEZWNdmv6DJ9HmXqSCNiOojM6qOFUFrgVEGbhOULzxuCpDxzoS9R4a2hnW
	U3LHwhTbu6ulDq8OBaYvjMq9vG7bxaxSwu9PWbTROlT+9s1ut517nZ3uNBzBP0/xdZwWHH5PXov
	PaI7vDKsHmZe3M4SlRbqLBmdmgM9e4tEzo2Vmjl9sUGTu1s=
X-Received: by 2002:a17:907:c48c:b0:c24:4128:c19f with SMTP id
 a640c23a62f3a-c2557165b0emr1440124266b.11.1788161571351; Mon, 31 Aug 2026
 00:32:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827173703.2762844-1-amarkuze@redhat.com>
In-Reply-To: <20260827173703.2762844-1-amarkuze@redhat.com>
From: Xiubo Li <xiubo.li@clyso.com>
Date: Mon, 31 Aug 2026 00:32:40 -0700
X-Gm-Features: AcwNN1UFM6BeUUDwjfOttejAbN8op5g5yEOcon2Mifr6PMyWshfSc_yv6nV-mks
Message-ID: <CAOJNxRKQcNv3aTe-WLYL7Lk46izVt62=J+Mtk8yUDDfe5mL=_A@mail.gmail.com>
Subject: Re: [PATCH] libceph: avoid infinite loop in ceph_pg_is_split()
To: Alex Markuze <amarkuze@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>, Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>, 
	ceph-devel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Alex,

This also LGTM.

Reviewed-by: Xiubo Li <xiubo.li@clyso.com>

Thanks
- Xiubo

On Thu, 27 Aug 2026 at 10:37, Alex Markuze <amarkuze@redhat.com> wrote:
>
> old_pg_num and new_pg_num come from the OSD map. When old_pg_num is at
> least 2^31, calc_bits_of() returns 32 and both (1 << 32) and
> n << (old_bits - 1) are undefined in 32-bit signed arithmetic. On
> machines that mask the shift count, next_bit toggles between 0 and
> 2^31 so s never reaches new_pg_num and the loop never exits. old_pg_num
> == 0 hits n << -1, which is also undefined.
>
> Do the shift in u64, build the 2^n-1 mask without a 32-bit overflow,
> treat old_pg_num == 0 as not-a-split, and compute stable_mod in
> unsigned so seeds in the high half of the u32 range stay well-defined.
> A hostile map can no longer pin the client in this helper.
>
> Reported-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
> Link: https://lore.kernel.org/ceph-devel/d1dc7faa-2373-4c96-ba0e-0e6d3e3b8457@tu-ilmenau.de/
> Fixes: 63244fa123a7 ("libceph: introduce ceph_osd_request_target, calc_target()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Alex Markuze <amarkuze@redhat.com>
> ---
>  net/ceph/osdmap.c | 34 ++++++++++++++++++++++++----------
>  1 file changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
> index e3448915bdec..558c7c3a4a84 100644
> --- a/net/ceph/osdmap.c
> +++ b/net/ceph/osdmap.c
> @@ -2307,25 +2307,39 @@ void ceph_osds_copy(struct ceph_osds *dest, const struct ceph_osds *src)
>  bool ceph_pg_is_split(const struct ceph_pg *pgid, u32 old_pg_num,
>                       u32 new_pg_num)
>  {
> -       int old_bits = calc_bits_of(old_pg_num);
> -       int old_mask = (1 << old_bits) - 1;
> -       int n;
> +       unsigned int old_bits;
> +       u32 old_mask, n;
>
> -       WARN_ON(pgid->seed >= old_pg_num);
> -       if (new_pg_num <= old_pg_num)
> +       if (!old_pg_num || new_pg_num <= old_pg_num)
>                 return false;
>
> -       for (n = 1; ; n++) {
> -               int next_bit = n << (old_bits - 1);
> -               u32 s = next_bit | pgid->seed;
> +       WARN_ON(pgid->seed >= old_pg_num);
> +
> +       old_bits = calc_bits_of(old_pg_num);
> +       if (old_bits >= 32)
> +               old_mask = ~0U;
> +       else
> +               old_mask = (1U << old_bits) - 1;
> +
> +       for (n = 1; n; n++) {
> +               u64 next_bit, s;
> +               u32 parent;
> +
> +               next_bit = (u64)n << (old_bits - 1);
> +               if (next_bit >= new_pg_num)
> +                       break;
>
> +               s = next_bit | pgid->seed;
>                 if (s < old_pg_num || s == pgid->seed)
>                         continue;
>                 if (s >= new_pg_num)
>                         break;
>
> -               s = ceph_stable_mod(s, old_pg_num, old_mask);
> -               if (s == pgid->seed)
> +               if ((s & old_mask) < old_pg_num)
> +                       parent = s & old_mask;
> +               else
> +                       parent = s & (old_mask >> 1);
> +               if (parent == pgid->seed)
>                         return true;
>         }
>
> --
> 2.34.1
>
