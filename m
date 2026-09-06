Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E636B314B63
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 08:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788684997; cv=pass; b=Wi0EJjAZHgfhH01FP+tpXlija9/GUFwKAxGDBmFZ5SRJd2IIDRdMS89DP2/P8mW7NWlR0s9MDQjTkRNfTR2JzrZ9Bire4y982MU6liGJvKQq+f8NXciCNOQwn8klyl2R0VkE3765eru3gHHd71OrUncaTHyRC+lLaiin7tzn/nk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788684997; c=relaxed/simple;
	bh=sDs5CQr6pwzT5GT7SjCGuwlyCtB/1j1bLpwJ/JFiQbU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m99ge+tbTlxTVrBBHFF1VZNRrRu/QBHpNp2djvjFuIeULeZGBsgBwwbG0EV1r/E0yLy9FGeDkttz18UuQp59uKa0L1oDZLaoSan1ONAcJssP1/3Ogd2R6iVySS8yQKZMwvVh50RqrKo3B0PLAWhzue5xzjDKd4hpIozhzWgwiH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxUcPSgN; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxUcPSgN"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a68279dd86so3146228a12.3
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 01:56:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788684994; cv=none;
        d=google.com; s=arc-20260327;
        b=WpBrK3EUR99QJiIHXG5kdKAXJf6SPyMeXeStQ31fsGywO1udDX84MSPyQiLTmzRujh
         PAE8rBuDawIDpztVmzcyUGXhTljy2fD1tzgSckdqWSKyk5OGk8ClLSa1Bl6Y1pMwgXcb
         FM8H0t1K5zkVcdZB+2tQwcaz2ZOJAwsfOm07xngXYDwIF0O/7XNmSIbjVWWm7a9Eic4J
         8U4TVPGQEMl6/YH/+GkOa9Dy/Q8lIUmSZPICWGkdFY8CZYTw5bZZxJSqAEaQ4oERzu4J
         FoNybU8ychUD7GvtU5Ey0q6YDmCao0ynKJIA90+qv+C3hSxtZzmPIHAhg/b+jzJTtsuw
         bBGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=KAvtxf9cCLStf1TmW00YPBVNLMXDCX8VCf/l5UIH9+w=;
        fh=Uhq13EloY8o77dVrLIKP+1ibTaVoRIMtP+RJ46t6+rY=;
        b=IhR+zdB/B1C07wyE5/4pkouUE1btTMmeoVLbBfIeQiSvIe/9b/rPXyNFujamwyed6w
         XiqpCpR7rUEZaz9Kju0Zzp+S0u0LoXJUPMot5lClQD4ZsM8usLITC1adfxGQTjjvt19L
         8CqNRqPi08T8OEo9KsMjuPOvAIECWA4xzbRx/kLN9TJbAGduSTVIfUZ4Oqfu1AO7x2kI
         3KasA08/TdRTT/oVrA4PIL6hC0VBIDGHvr0NB72sOUe5N5cpsaCqqQ2h+N285Jw4Ow+R
         zlBe8IMKv5quE86+DsrTTrphEY+Jo9zfSKwsZd8tdQaSlW8jaT8o1Ovgh+cr6c45vKO/
         RIUw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788684994; x=1789289794; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KAvtxf9cCLStf1TmW00YPBVNLMXDCX8VCf/l5UIH9+w=;
        b=cxUcPSgNblsNyi6Dtwllu1a5UH+dClJyGA0Rh2WuYp5HDGzBTkYwsSqzes9O9mwKaV
         lLdnYuGTax0GstzdeBBs0oEd9GAUFbIQkvjDizd38P+Vx7WWWfyvdZjRd4YjDMkAwddC
         Y750ldrIUG7jE5e/yUJkks2uRin409j4JQjSC7jbPt5spIMKQSBrRYrj3Da5Y5qbuTdw
         s9nBUO/amQOFH2ApOpPz2hZ09Q4wNp97uNov2t0rJhqMIRDCnNZYWUb8luh+d4HRsLt6
         tAx3IvrY5nF6GizdYX0KFqbuCW4HPa2kb8iCCiUisX3mZuDrYCWUlkty/KDpeAb2jSvl
         vjRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788684994; x=1789289794;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KAvtxf9cCLStf1TmW00YPBVNLMXDCX8VCf/l5UIH9+w=;
        b=sVYjQhvF4mwljoQ65DU2lW6H/PLZ0vSHRrMPRherfaJDXvJXTHlIh/JMOvw7BNZBCl
         881mzlDfazNbeJREf5UepjTu1tW/BfVGe6qHc9dB9pFonkJBfhWcIQvi9ScKyo2P83aF
         6pH7wgtOlZf/u799Z09wFXJ79HgsfXcdrUtmkkBAPhHA4VcMmmEqd6FofuGvS1rNTwmG
         a75++t/HDQ5KVaUwFPM0oigXL5bdJPsfaG3DRSsILwMxzXxlBZJH+g6Ij5zMZ122BsOy
         B9F8+FOvK1yi7ckYfCqEvRXd6yDyTJhBtD/vB533rv8CjeH0OS7uuPlIbmodSAaLxpqK
         +JYA==
X-Gm-Message-State: AFuF++lCiZcYcj9jajKQ2lRhZpfXa7AYlglzk2FrO0i+Akpw1Uvjyv/B
	VXb07kGy9r6ALxb2xSuMlwegC14XKg5lHCb8TUeldQdismPePKTnrA450k3CsYU/B5Gp34gj/Vw
	BKMMzB2gILpURZTfZS8vEo3SExuuUzM0rnV3UjBQ=
X-Gm-Gg: AYBFou1boPWVKJWda0LCZ0CllS/IZ3VrM/Wesxworg5U0+uVeALFoff8rXdZ1qldiQu
	yn0W+5wFfAMqw3Ojv7FMWzjMTnU77thrT0Q6Oa1QlkfLBbR40PGCXJXUvf+XXWVEYnWsHcDbwLT
	N5KtYiVHy1DwyGuItWNnzY1OzqdmEwUhejEl1+gpnQcgAzS1r8Kb7NtY7FL5GcxPcM1hhdjZJeR
	HFJH38LzfgJjQux3hJYMsuWiGFfH2VyDxMApun2r901qSKBp+9AfcGmIbRhTRiiCZRKSEEhlQ82
	dEBEeMoT7SYgBb7ixUv45pVTdcxkzvCmaeCqdLcdwO/QdmPYU552P+zz
X-Received: by 2002:a05:6402:44cf:b0:6a7:ee56:6157 with SMTP id
 4fb4d7f45d1cf-6a7ee5662c0mr3426417a12.25.1788684993803; Sun, 06 Sep 2026
 01:56:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxj0rAj+8S+E=fxiTxym5dRdEJgk9NHE=wJcancfnxLBLA@mail.gmail.com>
 <20260906030345.3332040-1-yjkwon0026@snu.ac.kr> <20260906030345.3332040-2-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260906030345.3332040-2-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 6 Sep 2026 10:56:22 +0200
X-Gm-Features: AcwNN1W5ozZw1nU5KN48YzdeYcPTsndtCT8wclh4pPTWNe9Li-qXK2i3X42wSOE
Message-ID: <CAOQ4uxi-aeLdHf8-8PjjetaNvxDBjLO_X8cENyJNRZHVge1Q5g@mail.gmail.com>
Subject: Re: [PATCH 6.12.y v2 2/2] fsnotify: Fix stale object mask after
 concurrent mark updates
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 5:06=E2=80=AFAM Youngjae Kwon <yjkwon0026@snu.ac.kr>=
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

This line is redundant

otherwise

Acked-by: Amir Goldstein <amir73il@gmail.com>

> Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
> ---
>  fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
>  fs/notify/inotify/inotify_user.c   | 15 +--------------
>  2 files changed, 8 insertions(+), 19 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fano=
tify_user.c
> index b89ad128bf09..93472a48ceb3 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1141,16 +1141,18 @@ static bool fanotify_mark_update_flags(struct fsn=
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
> index 657fc36df7ce..024be6cee849 100644
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
> -                       fsnotify_recalc_mask(fsn_mark->connector);
> -
> -       }
> +       fsnotify_recalc_mask(fsn_mark->connector);
>
>         /* return the wd */
>         ret =3D i_mark->wd;
> --
> 2.50.1
>
