Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729B438C2D1
	for <stable@vger.kernel.org>; Sat, 15 Aug 2026 20:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786824006; cv=pass; b=srbwvc6JDewtW5A1oD9mZE3uScZUdUImz6B2S/f5OWX2A26MSWW0hU7L6uFfkRyoxDKyis/YymPj1UIx58bfE1j5u0OtAApHBgOXE3yiGxJBqqBVpn6+2N0AyGAnlnS63khDhxHQT7Tb2itKAHUCRajsbmD7BqfEzMPVwTXv9Zo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786824006; c=relaxed/simple;
	bh=H0SAaDMcoUlmzvCFWtMI0+/aSNhKwVoOrwEM46qLy7k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdOcArBgPxMvq5/teFQtvSbkhh9a8lmykxptpHS1oDgKVxhuAu9Hbwh0oXfcYyaW6/cRv8SEIYkGJPnUF13Wlzi3nMpCZzqq3Mvo5DnIBhAW64GN3tCr+RSogAzWj6TxIHnyPOj/z0jhKK9OeD+bsErixh8+Rq1uJkRUZViVvsQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HgOdzVtw; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HgOdzVtw"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c20ce3c118aso398633966b.0
        for <stable@vger.kernel.org>; Sat, 15 Aug 2026 13:00:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786824003; cv=none;
        d=google.com; s=arc-20260327;
        b=mcGNE8BuPoQaVL76Co+qt68VQ79fnQKZmp9V72RMdnXqWMbMwG2boPbvmy+cpKzxAa
         E4o5dnd+VJEqZavdwB5qds6QZ4tBCwmtKrD33ht0gL7bMvhgD9A/9lBmqKzfX0J/Yr1j
         dq3iF6OApNVxJr9LR0fFxrg+lNnDQS0no+RB+RStpl5tftW5KC+sXCyHx7cPaXDM0yak
         G0JMN7URGwHyv0Ne10u9Qu6IWuE9NMxF/yje3eL+jOjf7/aPbFvESbsLPIh17QzmVHIU
         FywZvn78BRhDMvvHb3DQ+VVppHnwidDQuchDTm7+78N3aHeRRW98ZlVRnAUj8u+bMwzh
         j1yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1J4xJi/pgENX8KHVIVkJRZBjtsFynnK+5WJgXAi85A0=;
        fh=qW0OWmNB5PU8JGroYV2oSdSnVg3EeRmQQVPbZh2C3ac=;
        b=KcTffqeeRwE5femvXxWHDqhRdL1yWGj8vlK6pV5l236H/Ae8c9n3lPfOgb2gVoPIv5
         2hFJ1YkLf6lqjC8ea2/WIfbC+Iv6khnRky/Ko6LAwaTqzk1fweBHXCj73qtoXX0LyPvN
         a1naRhZiFGjbC/odaBKj/SY8SGtQrh0YcgtxVNoQAMwjYzmIOql+fRh0KM/wlIfykbJY
         zPbmjnIfBfP3EaLyxDwj9TmXMKoI7+8XTMqY4ep2queU+bBl+ZuZ1olVVrjS3IUGxvgi
         eBoRnq/V5e92wXMFz32vLheRvB4KKQVMhr3z3BEnpxHPXDz4VHbrfG0UCCQEsT5/YaVK
         hE3g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786824003; x=1787428803; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1J4xJi/pgENX8KHVIVkJRZBjtsFynnK+5WJgXAi85A0=;
        b=HgOdzVtwwD/mghUiKVMXYtiQyiY3F4/XASd4/7e/XgeHVzP0a5vea4U9y118ebA/bX
         VZaIIbEk6af2uUfz2JDKlozc/aC2dujCPY8jfGpbbHOnXdkGYGgvyx/klVAD/CPQsS2m
         k4++Rx5OBDsQwJURV3BceAzrTIah5PS9PeEsaP0jCgM2oBqdZ0sd6nB2qKkO9guy9u+n
         CQnigH+CJtCXZNtD/WBtCpE8vpBHYbkdThlTTlpeyDCrNe6p05jQx28zPVBnm+7jpglo
         euF11Asxk7C5sjxCFfSLWWff7CW6H93vSYuTTXhFqcKuKDzPgCBP66++tmLjT9WfQmP9
         1P0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786824003; x=1787428803;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1J4xJi/pgENX8KHVIVkJRZBjtsFynnK+5WJgXAi85A0=;
        b=Oaz+BUOBA8hp/UBpNi7XKitCksEnzVFzrI7huXIAbKyqm/1Dx/tzt7NuEeaYlsZlCr
         uYFWlFvq/pGnDZ8SsMfm525a+FN/xJ4czZrFVGybe7jHw28RNsJGfsKzn/IZKdtQnFjR
         kZiCxRskea1r6wdjtUvVsmQC0hFOnGOX5luVgkPSj5rFOmcm+XnHGBhGMNRtRZcSpQGY
         NHqb8oyo9Fw/WW1QSNrqdvLVK6oZkEvGWmDJjzAmwJ8W/C/k//r+1VKNNppI3bhU1EuK
         NG5wV/XGzWOtxjZDS6nRRauhYIJ+lK6Glgz8od2s/QWHTvs5MDUMQgsETskKjrNGJXzY
         8AYg==
X-Forwarded-Encrypted: i=1; AHgh+RotO+ABGGb3v2TW49oDgJ7Hc8zI0Bj68BSgaLqFJkM9tOrLCuA7HZkpqbLIwLw8deqm22uIdEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHFxtKd96NC9YyQg5W3eapkjfnZEKhxKqIX4fs7dO3/7/hCxPY
	UmzS8WsLLP+hmovyd+f+Pdfe0s4BE64OG339LFfzFsNkQ23jwSuqFHNs0fk+d9uHEp//s6gisKE
	vPLRzqwzQS811xU2xDFzzPeFI50QN6T7AFCGE
X-Gm-Gg: AR+sD12lrZI3SjNDsCUra9cCnW2xtAMMJHmY0NJpsnKhNXmlfe/fMtv7Thlq3DTwiyK
	YuRukV0zCwlx6mMJnBFQoPIp7cONSHIqI+L2FnjRIo2dhT4O4Lz/k86mWamaNGv9sVAqljyLG5o
	JRWDg28eV04+ORi5u1O00wgIhKKG7bZ6PTfvUm4ccHhJB5am2Sn29N1NDVWoRAFJ0Oa3JCKTyAA
	cjsrJk0BP3DcT4ASPGKt0WtXz3HuSpKpcEm05c0Tz3UJ9jzrBQEB5IIfS3iTnb8LPdO/tK3MCdu
	vmNCFlNrRXVqgr7nRdJWx/q1g8/FO2WC0jKYYjsVuT/BmRsIMN8g+3Dg
X-Received: by 2002:a17:907:7b8f:b0:c1a:25cc:e585 with SMTP id
 a640c23a62f3a-c212a26746cmr765316466b.5.1786824002104; Sat, 15 Aug 2026
 13:00:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260801055704.2663156-1-yjkwon0026@snu.ac.kr>
 <20260802015801.2426818-1-yjkwon0026@snu.ac.kr> <gc2bqp2c3a6emhshpewjalti2j26a5zsrmd6s4gopzvmofklqw@xjnfn4tbaktb>
In-Reply-To: <gc2bqp2c3a6emhshpewjalti2j26a5zsrmd6s4gopzvmofklqw@xjnfn4tbaktb>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 15 Aug 2026 21:59:50 +0200
X-Gm-Features: AcwNN1VACDe4mHrw2k0mqD7AUeiw0lt5GsWsA2spzXTFlTeJDU7MkFWcw0jVPJ4
Message-ID: <CAOQ4uxhuFVKmBP0gq1o302p=eLk+wyuDsjJJ-w14gKQcVcX4_A@mail.gmail.com>
Subject: Re: [PATCH v3] fsnotify: Fix stale object mask after concurrent mark updates
To: Jan Kara <jack@suse.cz>
Cc: Youngjae Kwon <yjkwon0026@snu.ac.kr>, linux-fsdevel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 5, 2026 at 11:54=E2=80=AFAM Jan Kara <jack@suse.cz> wrote:
>
> On Sun 02-08-26 10:58:00, Youngjae Kwon wrote:
> > When a mark gets a new event bit, fanotify and inotify may avoid
> > recalculating the object mask if the cached aggregate already contains =
that
> > bit. This is racy with a recalculation triggered by a concurrent update=
 to
> > another mark on the same connector.
> >
> > The concurrent scan can read the mark before the new bit is added, whil=
e
> > the updater reads the old aggregate before that scan publishes its resu=
lt.
> > The updater then skips recalculation and the scan publishes a mask with=
out
> > the bit, leaving the object mask stale after both updates complete.
> >
> > This can be reproduced with two fanotify groups watching the same inode=
:
> > one thread removes FAN_MODIFY from one existing mark while another thre=
ad
> > adds FAN_MODIFY to the other mark. After both fanotify_mark() calls ret=
urn,
> > writes can fail to produce FAN_MODIFY for the group whose mark now cont=
ains
> > the bit. This was reproduced on an unmodified v6.12.95 kernel. The
> > equivalent inotify interleaving loses IN_MODIFY events.
> >
> > For normal fanotify additions, recalculate whenever the raw mark mask
> > changes. The normal mask is not cleared asynchronously, so an unchanged
> > addition cannot introduce missing interest. Always recalculate ignore-m=
ask
> > updates because FS_MODIFY handling may clear the ignore mask without ta=
king
> > mark->lock, making snapshot comparisons unreliable.
> >
> > Always recalculate after updating an existing inotify watch. Its replac=
e
> > path temporarily sets mark->mask to zero, so a concurrent scan can obse=
rve
> > zero even when the old and final masks are equal. Assigning the replace=
ment
> > mask directly would avoid the transient zero, but existing-watch update=
s
> > are infrequent, so unconditional recalculation is simpler.
> >
> > Link: https://lore.kernel.org/all/CACwKKmCZdiZDoFuYm6LZhQ=3DXvHPk0fNKH=
=3DX3LmoXMqakYqJaNw@mail.gmail.com/
> > Fixes: 63c882a05416 ("inotify: reimplement inotify using fsnotify")
> > Fixes: 912ee3946c5e ("fanotify: do not call fanotify_update_object_mask=
 in fanotify_add_mark")
> > Cc: stable@vger.kernel.org # needs adjustments for <=3D 7.0
> > Suggested-by: Jan Kara <jack@suse.cz>
> > Suggested-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Youngjae Kwon <yjkwon0026@snu.ac.kr>
>
> Thanks the patch looks good to me, I've added it to my tree. Amir, are yo=
u
> happy with the changes like this?

Sorry for the late reply.
Was on vacation.
Yes, this seems fine to me.

Thanks,
Amir.


>
>                                                                 Honza
>
> > ---
> > Changes in v3:
> > - Preserve the normal fanotify duplicate-add fast path by recalculating
> >   only when the raw normal mask actually changes.
> > - Recalculate fanotify ignore-mask updates unconditionally because the
> >   ignore mask may be cleared concurrently without mark->lock.
> > - Keep v2's unconditional recalculation for existing inotify watch upda=
tes.
> >
> > I will send backports for stable kernels through 7.0.y after this lands=
.
> >
> >  fs/notify/fanotify/fanotify_user.c | 12 +++++++-----
> >  fs/notify/inotify/inotify_user.c   | 15 +--------------
> >  2 files changed, 8 insertions(+), 19 deletions(-)
> >
> > diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fa=
notify_user.c
> > index 9ee373ff5..9c27db2b7 100644
> > --- a/fs/notify/fanotify/fanotify_user.c
> > +++ b/fs/notify/fanotify/fanotify_user.c
> > @@ -1321,16 +1321,18 @@ static bool fanotify_mark_update_flags(struct f=
snotify_mark *fsn_mark,
> >  static bool fanotify_mark_add_to_mask(struct fsnotify_mark *fsn_mark,
> >                                     __u32 mask, unsigned int fan_flags)
> >  {
> > +     __u32 old_mask;
> >       bool recalc;
> >
> >       spin_lock(&fsn_mark->lock);
> > -     if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS))
> > +     if (!(fan_flags & FANOTIFY_MARK_IGNORE_BITS)) {
> > +             old_mask =3D fsn_mark->mask;
> >               fsn_mark->mask |=3D mask;
> > -     else
> > +             recalc =3D old_mask !=3D fsn_mark->mask;
> > +     } else {
> >               fsn_mark->ignore_mask |=3D mask;
> > -
> > -     recalc =3D fsnotify_calc_mask(fsn_mark) &
> > -             ~fsnotify_conn_mask(fsn_mark->connector);
> > +             recalc =3D true;
> > +     }
> >
> >       recalc |=3D fanotify_mark_update_flags(fsn_mark, fan_flags);
> >       spin_unlock(&fsn_mark->lock);
> > diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inoti=
fy_user.c
> > index ed37491c1..5f19c24ec 100644
> > --- a/fs/notify/inotify/inotify_user.c
> > +++ b/fs/notify/inotify/inotify_user.c
> > @@ -539,7 +539,6 @@ static int inotify_update_existing_watch(struct fsn=
otify_group *group,
> >  {
> >       struct fsnotify_mark *fsn_mark;
> >       struct inotify_inode_mark *i_mark;
> > -     __u32 old_mask, new_mask;
> >       int replace =3D !(arg & IN_MASK_ADD);
> >       int create =3D (arg & IN_MASK_CREATE);
> >       int ret;
> > @@ -555,27 +554,15 @@ static int inotify_update_existing_watch(struct f=
snotify_group *group,
> >       i_mark =3D container_of(fsn_mark, struct inotify_inode_mark, fsn_=
mark);
> >
> >       spin_lock(&fsn_mark->lock);
> > -     old_mask =3D fsn_mark->mask;
> >       if (replace) {
> >               fsn_mark->mask =3D 0;
> >               fsn_mark->flags &=3D ~INOTIFY_MARK_FLAGS;
> >       }
> >       fsn_mark->mask |=3D inotify_arg_to_mask(inode, arg);
> >       fsn_mark->flags |=3D inotify_arg_to_flags(arg);
> > -     new_mask =3D fsn_mark->mask;
> >       spin_unlock(&fsn_mark->lock);
> >
> > -     if (old_mask !=3D new_mask) {
> > -             /* more bits in old than in new? */
> > -             int dropped =3D (old_mask & ~new_mask);
> > -             /* more bits in this fsn_mark than the inode's mask? */
> > -             int do_inode =3D (new_mask & ~READ_ONCE(inode->i_fsnotify=
_mask));
> > -
> > -             /* update the inode with this new fsn_mark */
> > -             if (dropped || do_inode)
> > -                     fsnotify_recalc_mask(fsn_mark->connector);
> > -
> > -     }
> > +     fsnotify_recalc_mask(fsn_mark->connector);
> >
> >       /* return the wd */
> >       ret =3D i_mark->wd;
> > --
> > 2.50.1
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
