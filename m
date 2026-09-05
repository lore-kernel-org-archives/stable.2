Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D42EF30C16B
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638851; cv=pass; b=O5mNkS+o+ODcNrx6ck0LhsuSUTmnZPcgt/+8zgbupxzh3fy/FbJKX5k9WsBqOEs+do8tpnqkAzCi2KxKTNBG1xYP+l1DJhKXU8RDgPQ7ILhHYt56VnjSGZCl8034SN8IK6wQ+VhBmVZOysJEC3IbEt51IXVYorjM2qOipRPvVbM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638851; c=relaxed/simple;
	bh=EQ9c5JxouCfWZynK4bM5u3Cz5nHaJkXG/Cr8XcbHrR0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qzdOYVAxZUAi4Ek88Qs1WyLZRdAu7LOCBGU2FvAYpPGiM9vGOtHKw3NWLXOUj+xzviA4TYIUKRnTXZeWlkJ+DfyJ7tS3ZZ8OLoeu0MTXhRlm9Tczk8UywtF7ITILL3zFMNma2u7KH3Sx71GVdwCcK1mBWavoaJRIYe47ornD4Qw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uu/42U01; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uu/42U01"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c247f6687dcso344517166b.2
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 13:07:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788638848; cv=none;
        d=google.com; s=arc-20260327;
        b=oDMDFkEZbdCPe/7/DpdrfROPHnXcbLpIq7yIN343e0c9L/zXyL3kKav+xDa516iZNR
         r/7SnE80Y1n1H3/RFC4/LbVeACU97QySyWd4CdT5k3Iz6CKpevgkQ5ezb54uK3hbovH8
         C6q9eCjSyu+xAzivBpmynulPhf1RLTjOMKZZWecg17AnhSLM7AeBbdpQuGJghaDlJ6iw
         6BckPhBQ7hGJraPM75FKgXfqr4P0X21rnOFx4TqljNtAWdrJLqzU0NlNRj80imf5plnA
         Vm7Fq5vOGw0E4/N3WoGrcse1LprKIkPKIau2fUkNM2KHKXMUHKioim1eGGUa5w5GGFiz
         u5gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zhHUSVs2bF71Kw96g2BfQPiLqxxaLXVhlcrYYHUKO3g=;
        fh=Uhq13EloY8o77dVrLIKP+1ibTaVoRIMtP+RJ46t6+rY=;
        b=anZQjGluGQEzIS1VR6c0UO0Sx2CIDTgc72bQOOsG1GoebUvobC8hjRyLopZLx8T9gQ
         w6+lIxhDJtQkTud/LfI0d/y7R93Krs+tfmZdC0TwZIJTap92wR57WSw7pIZrTJw4v0m2
         pBH5JaMXaGx+35VV5NRduYPkSIkbAfW1mXEwBFg+de62CYCOqXx7QFKNaz0bdrjUw3Qe
         couI8maBaSgWAb9phePT9ZRNNE1FRxoRDAKDVodgr4Ld27PIBN6+wuNaqdGEwcJ1qnKI
         3xRfTg0ckKP2l7hmV8psxaywDbguypddUZg/+KoGzZspbiVay/R7Gav2kUS/j4kPnqNB
         cKGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788638848; x=1789243648; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=zhHUSVs2bF71Kw96g2BfQPiLqxxaLXVhlcrYYHUKO3g=;
        b=Uu/42U01uOCMZtK3dmycWtTrx9GKxnuaJjq6ZHyn8zz8HTgb/Oj0iV0prtXSVtOzJk
         Bu8X9TDlR2EsgpRZKaC5FO8O6uqJSDFEqsWR64JjnFnjEAUebc4UhDvuYEDAIvqh64KJ
         iew4DPTyTDJUcUJSdt2NTdKnb5mJKK9FhiLYLKVuJx70oxomepyA8h/CiknYz6tU1jgo
         VenKr/bOIT2ZNjTHpLTPxdJNNotUPKUbAmYfx5NFWx3aYt4BSeunCvb5UqdFNaO8CpN/
         SexMh/3TcNWn/crjgeebDH+ypjXsBIUuFiF59KTwoxRZQpSyk404N2+y30YuXmpPDoD1
         K/7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788638848; x=1789243648;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=zhHUSVs2bF71Kw96g2BfQPiLqxxaLXVhlcrYYHUKO3g=;
        b=fnbGTYoLx8fEiiQsl0LXShUfKo3ctzYkLZf1tSNF0fFuR9fwrDw7FQ6NU6a4m3IvLm
         o3HWyjJ+cbweBLquyIotrcTwm1ZHd3wdPnZBjE7vuPv/acA1HcYbYwoCA5bF5Nexql5o
         TzCFNhwaCHJbBqzqHae+2ZLdInX+EcDb/kFeBay752puNWY7LLHvMiNlPWDQI71HBkk8
         v2bcpuP4bL726JOzx2HwoQ5naRQzXJl4ZjK04B5+1HxOWQ/IWuh+8twLQbprK4waJSZ7
         I4ekfFuUTeTaBRffbxLn6VFR+OJq2w0Q6AsoN6f6bzHVjwbrEsevkFZm1Uru3Uoosk75
         ijLg==
X-Gm-Message-State: AFuF++nZ1fjLNPhUGR91IWglHkYO7Q8+aY8CAWAsq0lEmnuGISCH2Uc1
	A69SdR0cCCa/shjqV7DPTJ8UJb8Ja3c8vlYq2P4dnex2twP9FRA4MGaqnnoeuqi8aLeMSZUu01N
	fFVvP/PdnFu4LZaWVlYPGJe9SDcS83/Hz/oQ9cy8=
X-Gm-Gg: AYBFou0VAvNp+mnbJnhdmhWOjCGKbqHYypUaGyjaQqepVc+NbF07cG6F2AEcUHz1Prg
	YyqcfCuZvnA9QJLNdk0lGo38CZW5zgNgrBcmPEtONHa7XUpJxAD1R6uxsJOZPhFcv/w0SC6GxUd
	HMywbkTltroA4rAYftGIsS55SX97mwWYxUUIjmwBjfaNjzsKqNmP2yeWh8WC0JDwTJrlDEqnqSz
	6OqakhXrDqXiW/aGWa8YB2aOS8p+IrHfNxTW6dDNdrO2HMbxWAGb/BLtBnfkG9fbJUaCaSdDiZ2
	YDXOsQEASdXJRPP4zq5b8zfbjCxDOVPAS5Y0F50QJ8Jiyw==
X-Received: by 2002:a17:907:9713:b0:c26:1648:a066 with SMTP id
 a640c23a62f3a-c261648b70bmr384187966b.33.1788638847980; Sat, 05 Sep 2026
 13:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090335-leotard-duffel-dd93@gregkh> <20260905024800.3944249-1-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260905024800.3944249-1-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Sep 2026 22:07:15 +0200
X-Gm-Features: AcwNN1UarhJM49IfOzIUf7N4DD_nfkEyDujxpbSBeX99-yHVpIAA62Q0oh9EIck
Message-ID: <CAOQ4uxjNxYFJE2J3K=_Ur2LjvF2nnE2B626ef6YUWJwAoirB2w@mail.gmail.com>
Subject: Re: [PATCH 6.18.y] fsnotify: Fix stale object mask after concurrent
 mark updates
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:48=E2=80=AFAM Youngjae Kwon <yjkwon0026@snu.ac.kr>=
 wrote:
>
> [ Upstream commit e422777fdd4746de1109575c51e65038d4c5c1be ]
>
> When a mark gets a new event bit, fanotify and inotify may avoid
> recalculating the object mask if the cached aggregate already contains th=
at
> bit. This is racy with a recalculation triggered by a concurrent update t=
o
> another mark on the same connector.
>
> The concurrent scan can read the mark before the new bit is added, while
> the updater reads the old aggregate before that scan publishes its result=
.
> The updater then skips recalculation and the scan publishes a mask withou=
t
> the bit, leaving the object mask stale after both updates complete.
>
> This can be reproduced with two fanotify groups watching the same inode:
> one thread removes FAN_MODIFY from one existing mark while another thread
> adds FAN_MODIFY to the other mark. After both fanotify_mark() calls retur=
n,
> writes can fail to produce FAN_MODIFY for the group whose mark now contai=
ns
> the bit. This was reproduced on an unmodified v6.12.95 kernel. The
> equivalent inotify interleaving loses IN_MODIFY events.
>
> For normal fanotify additions, recalculate whenever the raw mark mask
> changes. The normal mask is not cleared asynchronously, so an unchanged
> addition cannot introduce missing interest. Always recalculate ignore-mas=
k
> updates because FS_MODIFY handling may clear the ignore mask without taki=
ng
> mark->lock, making snapshot comparisons unreliable.
>
> Always recalculate after updating an existing inotify watch. Its replace
> path temporarily sets mark->mask to zero, so a concurrent scan can observ=
e
> zero even when the old and final masks are equal. Assigning the replaceme=
nt
> mask directly would avoid the transient zero, but existing-watch updates
> are infrequent, so unconditional recalculation is simpler.
>
> Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=3DXvHPk0fNKH=3D=
X3LmoXMqakYqJaNw@mail.gmail.com/
> Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask i=
n fanotify_add_mark")
> Cc: stable@vger.kernel.org # needs adjustments for <=3D 7.0
> Suggested-by: Jan Kara <jack@suse.cz>
> Suggested-by: Amir Goldstein <amir73il@gmail.com>
> Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
> Link: https://patch.msgid.link/20260802015801.2426818-1-yjkwon0026@snu.ac=
.kr
> Signed-off-by: Jan Kara <jack@suse.cz>
> (cherry picked from commit e422777fdd4746de1109575c51e65038d4c5c1be)
> [yjkwon0026: Resolve the inotify conflict by retaining the branch-native
> inode->i_fsnotify_marks argument to fsnotify_recalc_mask(). This tree
> lacks 4520b96b8136 ("fsnotify: inotify: pass mark connector to
> fsnotify_recalc_mask()"). The surrounding conditional is deleted by
> this patch, so that commit is not a prerequisite for this fix.]

I slightly lean towards backporting the trivial sparse fix to
keep the histories of master and stable in-sync with cleanly applied commit=
s
without the need for this explanation, but I do not insist.

Thanks,
Amir.

> Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
> ---
>  fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
>  fs/notify/inotify/inotify_user.c   | 15 +--------------
>  2 files changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index 5c30f4d8c7c1..e0a0f67b1350 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1327,16 +1327,18 @@ static bool fanotify_mark_update_flags(struct fsn=
otify_mark *fsn_mark,
>  static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
>                                       __u32 mask, unsigned int fan_flags)
>  {
> +       __u32 old_mask;
>         bool recalc;
>
>         spin_lock(&fsn_mark->lock);
> -       if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
> +       if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS)) {
> +               old_mask =3D fsn_mark->mask;
>                 fsn_mark->mask |=3D mask;
> -       else
> +               recalc =3D old_mask !=3D fsn_mark->mask;
> +       } else {
>                 fsn_mark->ignore_mask |=3D mask;
> -
> -       recalc =3D fsnotify_calc_mask(fsn_mark) &
> -               ~fsnotify_conn_mask(fsn_mark->connector);
> +               recalc =3D true;
> +       }
>
>         recalc |=3D fanotify_mark_update_flags(fsn_mark, fan_flags);
>         spin_unlock(&fsn_mark->lock);
> diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify=
_user.c
> index 0d813c52ff9c..2a8a83d8f4a7 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -539,7 +539,6 @@ static int inotify_update_existing_watch(struct fsnot=
ify_group *group,
>  {
>         struct fsnotify_mark *fsn_mark;
>         struct inotify_inode_mark *i_mark;
> -       __u32 old_mask, new_mask;
>         int replace =3D !(arg & IN_MASK_ADD);
>         int create =3D (arg & IN_MASK_CREATE);
>         int ret;
> @@ -555,27 +554,15 @@ static int inotify_update_existing_watch(struct fsn=
otify_group *group,
>         i_mark =3D container_of(fsn_mark, struct inotify_inode_mark, fsn_=
mark);
>
>         spin_lock(&fsn_mark->lock);
> -       old_mask =3D fsn_mark->mask;
>         if (replace) {
>                 fsn_mark->mask =3D 0;
>                 fsn_mark->flags &=3D ~INOTIFY_MARK_FLAGS;
>         }
>         fsn_mark->mask |=3D inotify_arg_to_mask(inode, arg);
>         fsn_mark->flags |=3D inotify_arg_to_flags(arg);
> -       new_mask =3D fsn_mark->mask;
>         spin_unlock(&fsn_mark->lock);
>
> -       if (old_mask !=3D new_mask) {
> -               /* more bits in old than in new? */
> -               int dropped =3D (old_mask & ~new_mask);
> -               /* more bits in this fsn_mark than the inode's mask? */
> -               int do_inode =3D (new_mask & ~READ_ONCE(inode->i_fsnotify=
_mask));
> -
> -               /* update the inode with this new fsn_mark */
> -               if (dropped || do_inode)
> -                       fsnotify_recalc_mask(inode->i_fsnotify_marks);
> -
> -       }
> +       fsnotify_recalc_mask(inode->i_fsnotify_marks);
>
>         /* return the wd */
>         ret =3D i_mark->wd;
> --
> 2.50.1
>
