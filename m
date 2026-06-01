Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499FE3E0C44
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780336270; cv=pass; b=ZR65EPSj3beNsezXVbXQjtt0aEAR6/Ji1imetUhujAvq7tCNsOVkv3moW72Csc8ZmG9KEyNfbPZH/lVcQNBbALNbWuY9pO7V4lpKmjFrZGHGVBh0jyinw/f8mJ5GbitXVyK1500LAK4WwAn/CN4dIlYBuQ1Sn4Skf0sz5ewsdkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780336270; c=relaxed/simple;
	bh=flOdQbFMjfUG0jkFksI2WZ1HJzXvIy8Dsk0tvu6DNig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lxguYz30viK0RQIwL3kRki5YAua9PdZ37oTGn5Joi6+fvwDodc8VoGODSJXfOGl5+JTjuRvq7uIiNMC3/0rDSNfbAe3+Dz4pn1ZBf0D5XKWrDrRT4IWXqWjwE7nSLotxCjfQhAdjYo1mQSWH56kDPWlhRggSBixOeNoHkAu7BXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tFeTSrGP; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tFeTSrGP"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-bdf8add254dso968585866b.1
        for <stable@vger.kernel.org>; Mon, 01 Jun 2026 10:51:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780336266; cv=none;
        d=google.com; s=arc-20240605;
        b=ZG+PC1pe9UO7dq9AyMnUHczahX/9cmdBLoynAM3HN8txgkHPAV6KGDffBen2/cLOLQ
         YrqHtxk/9QcWMUdHXIz9+u6SdZjbL940iBm6abwLYmNlpxIYwMbEFFa7nUH+HW8TCazo
         2o6Vo21aVpiqYQ2jJTauL3yWDBr30+G0O/RhAJyiR0JQSvQbnr3mQOwjAOzCaxu09hM9
         AbO4LBdoqVBA6BpS8ybYtH6Eq7vMuwG9lgsZTs8fTwMSs3AOrzvOb3UFJ9b8JZMqpfCZ
         ce7wvhMjaa783YnWHWoyY8uvwNT8WoeXAGQ0FlqRYWk2ZXz/5BTRZYcZ06i0epUO2UMe
         LADQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1oyN2GHO/W1PVNw6MHzzvIqAiryGCw8vjjyfHSwiSxY=;
        fh=6zTPu7a/Mmy/U4u+Fd381rsTEZtTojEfZIo48I63LsE=;
        b=kTNvuvGsgwR3wpxl+NGC2flfXnPxebDUDyoUUnpDnFI3cj84iY4eXlO4TKZic8VbOQ
         IlXKFrvXZ2Xsdrzfnh1GAfPxR8zF0BdcuvoUY8XKEr05cGU4Tq874WMdYtEPT8a9b7Ny
         /lb6pum9qsEJlphxo6YEIbKb16loYT6GVGfRhxJ6m3K/NYdC7iHCA7JKjwIVaQ1i5j6g
         /FD3mieLl33RqwAAw2fDM1HvBghp3rpInG5mJhOSut/RdiZ3V3r8nasysDGWOXTPbAP8
         OjdIeFWvXnU5o3RUMoc3yPNFiyQWirradVYmrODIPPvVQlrW3et+OV8UoZpivUy9/gt4
         QtSA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780336266; x=1780941066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1oyN2GHO/W1PVNw6MHzzvIqAiryGCw8vjjyfHSwiSxY=;
        b=tFeTSrGPap1yf2dbp8FM1Wl0GY22tAy1HeqCwDyDijuqOFsKzJQB3U/iZC/IkcXwkv
         JT0YYWTrK9SOhBTAsSeqIK3JSUc2fFILOIr2uWJvlqUTRWGrUg1Q89K5gYx/qfd3ESPC
         XqMnHMSgO+YgVCukGPQAXwW1NmqIXNTDqq90IgCaOqFt1vqAYYIzxY5rV51c3VUw97l9
         QLlwIs2r69eyDzv9vCg+gbKH0jsi1lK74Nlnh82Z3TJTc8ikKyGKUHrkeoXpF4LiMj2+
         6KRL1rnJ5LteFdxJOuYXJmwMClELpnX60Eb258zZLF5V6+e5d0EkWjRdt4dki3z+j9va
         V2Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780336266; x=1780941066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1oyN2GHO/W1PVNw6MHzzvIqAiryGCw8vjjyfHSwiSxY=;
        b=NCHuiQtjqQX3dcIqOllAsN5i/3Qu7YVNtupHsnjTnWnOhuq7Pm/A3DH6vo1TEVRqY3
         T/YRRj+pkh3wXmLYgj8xT/LFeFuvxqns/RysfBsbaH/IpNpxaP0InPfSWCVkcWXGVoKT
         s67yatj5bVUnGhDx5fp+pNNZSPZkpSBdTjQWFKinb/RBMzknJpwF3zZzGqr0BgyepG6X
         Cf+n/A0/Rwkw8r9B5CCvNIyJEFpesqWnMYuFFMa3ts8jdu4JtSs7uSOXOsVvdhjmb1MH
         PtyP0uqBaPNBnOyDEWtuoMaBYAQbahoU067vjXd2CpdVOuBN8CqvDgrd8EcPFEbE4MPi
         4uyw==
X-Forwarded-Encrypted: i=1; AFNElJ8IYVzAv5R6hXxdykXgKJpbB27EkC5CNqG7wOvhAehc09YXQA7d3jabUkTdv0nv14qHwwnQQCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjXbJXGIPxgHqlvAcgae0nHay60lyui6iycXLuZX1mZSzV8MWc
	X1/m8L9yFeM8a5nuU+rLd9oG3hVhJ5LMVAkN6wcUkG6bpYq8cd3GzvJ37cd0ngUiBBMi8ms7bZl
	pRbUJIBLg1notVgBHsTEysCh+80cIpy8=
X-Gm-Gg: Acq92OE9mYG79HnHAxKVYIyawDNGE5xe6qkn6HqGknvbB3zsoQdXgAZneIzZBN3pYOg
	yQwfy+ChSObzjuyAhsDQIC6rTa6JdD0heR8XWXpeIdNPVaaiNhYo1mIw2R3cH0eOvTbid/4IJe2
	6LzgO8saBLmOcxc0C1W3VQ8tybzPzDiLLTbkfSBuUyFaiDmOM3diZPpi6knWUirXKIZcK3fBZV8
	tZJmNKG2QQuLJ33UtdmyUPj7OyokhzHYPAFhVEYg5WL+ef0u7xhdIBq7U+MIYa4rO45DYDL4KBa
	OBzLy+1UfD5CYv6gTn7MoQ4G5zbXILuwrPfv82nzBBZjERMLBVA=
X-Received: by 2002:a17:907:3d55:b0:bcb:4046:63ee with SMTP id
 a640c23a62f3a-beab17aaa7fmr558548966b.31.1780336265621; Mon, 01 Jun 2026
 10:51:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260601161501.1444829-1-shakeel.butt@linux.dev>
In-Reply-To: <20260601161501.1444829-1-shakeel.butt@linux.dev>
From: Kairui Song <ryncsn@gmail.com>
Date: Tue, 2 Jun 2026 01:50:28 +0800
X-Gm-Features: AVHnY4IV1F6PCCbzzYjlKLYKIUjD5M0VssnH2_2WxHth41_Ifdx4MpgpS8XDWPI
Message-ID: <CAMgjq7CQt+W5jAB1DM=nCRpLOFnCK3FkdKT6O0sznOEGpo6=Zw@mail.gmail.com>
Subject: Re: [PATCH v2] mm/list_lru: drain before clearing xarray entry on reparent
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, Johannes Weiner <hannes@cmpxchg.org>, 
	Dave Chinner <david@fromorbit.com>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>, Qi Zheng <qi.zheng@linux.dev>, 
	Meta kernel team <kernel-team@meta.com>, linux-mm@kvack.org, cgroups@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Chris Mason <clm@fb.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 2, 2026 at 12:28=E2=80=AFAM Shakeel Butt <shakeel.butt@linux.de=
v> wrote:
>
> memcg_reparent_list_lrus() clears the dying memcg's xarray entry with
> xas_store(&xas, NULL) before reparenting its per-node lists into the
> parent. This opens a window where a concurrent list_lru_del() arriving
> for the dying memcg sees xa_load() =3D=3D NULL, walks to the parent in
> lock_list_lru_of_memcg(), takes the parent's per-node lock, and calls
> list_del_init() on an item still physically linked on the dying
> memcg's list.
>
> If another in-flight thread holds the dying memcg's per-node lock at
> the same moment (another list_lru_del, or a list_lru_walk_one running
> an isolate callback), both threads modify ->next/->prev pointers on the
> same physical list under different locks. Adjacent items can corrupt
> each other's links.
>
> Fix it by reversing the order: reparent each per-node list and mark the
> child's list lru dead and then clear the xarray entry. Any concurrent
> list_lru op that finds the still-set xarray entry either takes the dying
> memcg's per-node lock (synchronizing with the drain) or sees LONG_MIN
> and walks to the parent, where the items now live.
>
> Fixes: fb56fdf8b9a2 ("mm/list_lru: split the lock to per-cgroup scope")
> Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
> Reported-by: Chris Mason <clm@fb.com>
> Cc: stable@vger.kernel.org
> ---
> Changes since v1:
> - Use xa_erase_irq() instead of xa_erase() (Sashiko & Claude).
> - Added comment on CSS_DYING check in memcg_list_lru_alloc avoiding a new=
 mlru
>   allocation.
>
>  mm/list_lru.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
>
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index dd29bcf8eb5f..d454bce9a78e 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -473,26 +473,29 @@ void memcg_reparent_list_lrus(struct mem_cgroup *me=
mcg, struct mem_cgroup *paren
>         mutex_lock(&list_lrus_mutex);
>         list_for_each_entry(lru, &memcg_list_lrus, list) {
>                 struct list_lru_memcg *mlru;
> -               XA_STATE(xas, &lru->xa, memcg->kmemcg_id);
>
>                 /*
> -                * Lock the Xarray to ensure no on going list_lru_memcg
> -                * allocation and further allocation will see css_is_dyin=
g().
> +                * css_is_dying() check in memcg_list_lru_alloc() avoids
> +                * allocating a new mlru since CSS_DYING is already set f=
or this
> +                * memcg a rcu grace period ago.
>                  */
> -               xas_lock_irq(&xas);
> -               mlru =3D xas_store(&xas, NULL);
> -               xas_unlock_irq(&xas);
> +               mlru =3D xa_load(&lru->xa, memcg->kmemcg_id);
>                 if (!mlru)
>                         continue;
>
>                 /*
> -                * With Xarray value set to NULL, holding the lru lock be=
low
> -                * prevents list_lru_{add,del,isolate} from touching the =
lru,
> -                * safe to reparent.
> +                * Reparent each per-node list and mark the child dead
> +                * (LONG_MIN) before clearing xarray entry otherwise a
> +                * concurrent list_lru_del() may corrupt the list if it a=
rrives
> +                * after xarray clear but before reparenting as
> +                * lock_list_lru_of_memcg will acquire parent's lock whil=
e the
> +                * item is still on child's list.
>                  */
>                 for_each_node(i)
>                         memcg_reparent_list_lru_one(lru, i, &mlru->node[i=
], parent);
>
> +               xa_erase_irq(&lru->xa, memcg->kmemcg_id);
> +
>                 /*
>                  * Here all list_lrus corresponding to the cgroup are gua=
ranteed
>                  * to remain empty, we can safely free this lru, any furt=
her
> --
> 2.53.0-Meta
>
>

Nice catch! Thanks a lot!

Reviewed-by: Kairui Song <kasong@tencent.com>
