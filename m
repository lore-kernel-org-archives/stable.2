Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B86F36196D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638581; cv=pass; b=D20yqaUsHmuGmBVlRcprPeIHsBRKRHIAa2P27vshsk8MJO5MP2MaKp8QLPALXZy04lTIwBm+9yZibRu+QnI6IAZ2hO8F6D38QBrt0lkNC3POiZ2RIyelRRTGV10QIa/lzPF01+buQtW30Ia6Umikd5nsbvdWbLTKsBfIgnnCYk0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638581; c=relaxed/simple;
	bh=T3sSM0iZZSBqx9fFu6YSBkxdlz8TEKWX/FWyOaUpfyQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPC8yZRhoozX9OZGCsByPIfCb4UJFH9fltmm0BRF9VIOONNi1rS8ogq2UY9bfe9TuYvJlLDzAMxqOlEbtRPaiGguwERZLvbtTCBE9Qoy/7+TM5EnaSw3s7qc5FpK+JhjBCYhgYCHQsw+JHQlcfXGzCcqh3L5iRSZsT2KZmk/Sqo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m/+dbPg8; arc=pass smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m/+dbPg8"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-c15e592da74so264015966b.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 13:02:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788638577; cv=none;
        d=google.com; s=arc-20260327;
        b=F7mPoCSckJvA4QsvplxZUDOfo7/20TS0//JLWjlAp0OhsKLI6xeKTuBUf6M0HL27J2
         D3svcmlwkWFd8ZXfm+FqI4xsCo7m11WGh6H86CHbCn94uwO3YL4ZIToRwHtDI7orT9LD
         +IyF+UUSm0LNtnVJUsJSPV6R/8Wxbgn7Y1GOMD66V2J8GzafQMpxhYxcBVu6xYsFH8Sr
         T3/y2Vs/RoyWKxReA0n+mmO+2bG9JHO1URapsj0kmQumbVTgLodrc4QlCVCuiAm9Bqar
         SmWuOx+jnh0o1+4hUR3c0kzI+hIyyBBrbfTPhJYG8HCU1Xc2PGDdi1WoxFSO0HKQPjjQ
         Yo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KeazdfZp3zJgvG8pltWk/kIfeGPhkjoklENiiPnWlv8=;
        fh=Uhq13EloY8o77dVrLIKP+1ibTaVoRIMtP+RJ46t6+rY=;
        b=pKPo1OYB9aoavPAjEesVUjU095huDPUXuDrZNPjffRlfvhpj+bWjRTZkQ+bKAPNFrk
         RPzEMYgXlqBKCFleTS3mG9+m+Ol37i0wrVbrhFGFzZbXN2XfIyyRz8xkW+0kLHGgt3V4
         OcYboLjwwXMP/kVfP6ZQo72qQpk05TLt8FSuXegVVQAQYFr0LOXqIZgOdKt8y31ievky
         CBPNFgQT6+FafEelMFq6l/ISiyj1Il3+gr0wcg9PLrDkimZoR9j3PprZJroXygxCENfY
         lHVAImhMkNcIy98ZhKG/m7V6t5xgn/URoHTOB1hWqLvbRmbwBSTdX4zauYT52ZW/eYmT
         f+KA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788638577; x=1789243377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KeazdfZp3zJgvG8pltWk/kIfeGPhkjoklENiiPnWlv8=;
        b=m/+dbPg8Y7rejQS7IBBop3HBjd4m/SvbEVkO6AxTN4GprJhhV6fhbNuVlhqOEQ4qox
         1JaCi9gynXwKl+UVGMtFyZ5vZ+90flhCJnhHEef0nW5dSYyAPD/0K/SsMObHQbUf5acF
         K3XqxFtCPDcVSZJxcBW02LWVzvTyjhIEMFKkd+pfR6DY3V6yTuf0OP2JW7B25+zfX5Mj
         tAG0FqUztYF4ZbTT3e2pWyIyipAotq+9vIyA3fD++DXrfQC5wLTsAzPdrafuoeckINcs
         iOtYmSVu/rktQiqg0RQh1+3OEuIbwNkjpNSN9cBHMMwUcUOS6Cbu7BKlomiG7cWBJSSN
         pdgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788638577; x=1789243377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KeazdfZp3zJgvG8pltWk/kIfeGPhkjoklENiiPnWlv8=;
        b=pkQvL+9rnWrGeg7jdh6Rsjjx+9wEvtxwGm6AcV3EjCPjxJ2b+ECu1WE/Jw4GVekUKz
         R1RoGdRrmxXJcKhF59w2vbWitv1OAtIVcI89W1ramePgtmqA4meJLUc+V0kWT1j3R+vv
         odGyeH5hDm5Ya9VvvS1E6ZIYnXTf6nE8ozpFaGBtabeMdFJupl5ZKFgCnZfx4+XEq0If
         fCEowqnI6ydAT6v7NT6527UU7AglNkCFVxFwhGJURe9zQhkGvXJIwRCVn05vUumY5pX3
         u4gLPV12d+in5GtsJHMmUZwJ5oii23eGDGYClsG5Wj0WkFZKL1dhzw8sgS4z8lHQjrDq
         3IMQ==
X-Gm-Message-State: AFuF++ka5jWXxbNmssW4nFXbLiq4cmIMdTufLziJHUa2ynSBz9INR4wj
	2mr/3yukpv7ikw1xotIi2zgHUQQLl9l5fbs0GsqN++eoM0To3shIAk9HNgIVbTqe32thmjGLSly
	D2y/M7jUg4rH57K8IcLBrRofr0KvG8ps=
X-Gm-Gg: AYBFou3Q9FMGujVHWHvT3N+Ddl2ZqPXA9lD2BKYPZQzg+eoEe9SnhZtSJM9rPF386Nz
	WQ9GCbNYJiArPqPUDlSxeqR0IXV7jSTBr21U4slUqyMij2NdwvHsL2M7ork8Zr6FrXaQtS4K2Zn
	es9nUPHqQ8Rjupe86BaI5ZqwhH8D35N57eGOURc5uJl+ET+cqcFvhwc25mwFinj1oM/o+lcQLxB
	PrrfDzpUZDexX5oVHc2+pVFByIFjF6I/8612SfE0Hr8p11/K23YnNoXTj9GiqqrMd5c9ebhbzRm
	HUG35G43qJcXIvicBSbQX2idlKjfmiZ3uq2z+75bRrRxkg==
X-Received: by 2002:a17:907:3cca:b0:c26:19de:9ac8 with SMTP id
 a640c23a62f3a-c2619dea66cmr340470566b.32.1788638577373; Sat, 05 Sep 2026
 13:02:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905024015.3904717-1-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260905024015.3904717-1-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Sep 2026 22:02:46 +0200
X-Gm-Features: AcwNN1UmbH4puvKRIKm8VuphpTwFds2GtYCWmyDA_-ju5oWSoF4WnK3gw9j1QaQ
Message-ID: <CAOQ4uxh_WAe35Ai37SeQiSwy9mfYJiO9N9jiEJRG_7np=FewNQ@mail.gmail.com>
Subject: Re: [PATCH 5.15.y] fsnotify: Fix stale object mask after concurrent
 mark updates
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:41=E2=80=AFAM Youngjae Kwon <yjkwon0026@snu.ac.kr>=
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
> lacks 35ceae44742e ("fsnotify: Avoid data race between
> fsnotify_recalc_mask() and fsnotify_object_watched()") and
> 4520b96b8136 ("fsnotify: inotify: pass mark connector to
> fsnotify_recalc_mask()"). The differing READ_ONCE() line and connector
> call are in the conditional deleted by this patch, so neither commit is
> a prerequisite for this fix.]
> Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>

Acked-by: Amir Goldstein <amir73il@gmail.com>
> ---
>  fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
>  fs/notify/inotify/inotify_user.c   | 15 +--------------
>  2 files changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index d93418f21386..1abbb30bd0d9 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1122,16 +1122,18 @@ static bool fanotify_mark_update_flags(struct fsn=
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
> index fd5febf09ab0..9e46895269d8 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -532,7 +532,6 @@ static int inotify_update_existing_watch(struct fsnot=
ify_group *group,
>  {
>         struct fsnotify_mark *fsn_mark;
>         struct inotify_inode_mark *i_mark;
> -       __u32 old_mask, new_mask;
>         int replace =3D !(arg & IN_MASK_ADD);
>         int create =3D (arg & IN_MASK_CREATE);
>         int ret;
> @@ -548,27 +547,15 @@ static int inotify_update_existing_watch(struct fsn=
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
> -               int do_inode =3D (new_mask & ~inode->i_fsnotify_mask);
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
