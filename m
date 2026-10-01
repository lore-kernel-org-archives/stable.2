Received: from mail-ed2-f24.google.com (mail-ed2-f24.google.com [74.125.228.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1363FFACC
	for <stable@vger.kernel.org>; Thu,  1 Oct 2026 10:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790852298; cv=pass; b=jOx/nEGRc4XRQ5Yo8HA/Ha2VFukX8WHANyGguXgizXizPGu+MjOlzrUkyTyiY3V0dYoQSOx8Z/TqY3KlDycg8PG9XGtK4uxqyHlImkd1oZE8QvZXHrWPvWwKEzgRQ5j9Ypi0IAudheWAeRSMj2+wdBi3dFqAJEfrXeai4F475RM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790852298; c=relaxed/simple;
	bh=YJvXUr+pq2B5IAi3iXrHuCjS/uY9ahiglDRXGGu4abI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7IfXdL1Hpa+vju8J3Hp7GSshTx8/GZBDP0Lz+sDZ5TMiTjgi8L0SZV7diwdzGGRFf3JL12NnCdnOPSJ+cfkjWvf1aIQBtrI15Lz+2II8B1p0Pel6Zt4H3DmbsuJhAKsoXKEgtdi1sLaRFVkaf/ESx/3eDbjcj+otY9hA1CWYhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i9+6lg37; arc=pass smtp.client-ip=74.125.228.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i9+6lg37"
Received: by mail-ed2-f24.google.com with SMTP id 4fb4d7f45d1cf-6ab01dda422so6927909a12.0
        for <stable@vger.kernel.org>; Thu, 01 Oct 2026 03:58:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790852294; cv=none;
        d=google.com; s=arc-20260327;
        b=g4HAOcBV/8cOaRcxLiZQO/LedGDfaP2ocluWTqx2ISepXGtteFr0ttHcwU2F2Z68Wx
         Xgfhqi+4JXEsl/pkrtbgnD4oJ9U/RL7742UyyU7e9U97YR9zYKzL3R044xBCJx+kEVjd
         cw8f1dO/xV4Fb2ls6t4TvXLWm08lZr1BdsjPe9FBX1ns3SBI66ZLBJsrmbwKr84EJWCT
         /NMV9K8+GpJUCe6hkxM6CG3T2i2Oju1O/ioV5HLuYwXi97vFa2EAczoR1I7I+qujKnbo
         ZpzVFxGZ2eKIRN0E+Qd01vcapmWNn1MTsmQ5euLcpwzvYws3B69XfFT8MLRwHXaMK8oE
         ZSfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OucJBsbHM5acxxfL6ZGTIjEsrBVOev5k2SFxTGalm5U=;
        fh=Po9BCVdCfKRs7Ok9BJKVururZYr6sSu+e5EL9Mo47+M=;
        b=lqtyfn/5Fu27Zp7mYI+CnIQyS3lt0AUbl0SaSIMnH4K18pchuplR1WllnWhsxXjVzg
         1wZandqBast9mEVgZwVJGJUZZjPgvCAi+3RzJnCRI+RksWrkr84AVCLtZR+oZVgI76hR
         Z+mVh6f3iJYNR/qMBfw2gC6Oy3bPurjL8AUkOz6w/qmSx27Y358mn7BOWp17TGNkTdRl
         HasBX9JFqXrIeJ1bwMpFIToDJST7aoWTTahZRCZegWH+zFx0dttIgPCdFXc1qwZ3gYmp
         WZbnKektvQZtf+6HHbq1jVz2Vst82yqbV+d5gej6SJiaCaFC6EsLlK1fJEhec0Dp6p3v
         sgow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790852294; x=1791457094; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OucJBsbHM5acxxfL6ZGTIjEsrBVOev5k2SFxTGalm5U=;
        b=i9+6lg37vH2hh5OhDnsfiinE5SfKh4r6iPP+cf+LcE9mcY+0Ql+zAnXdlWyBw8dm0X
         7W3w5VzOUxxP1msSX4ax8dmqQM5RrDLJRRmrDIn7vR12i5e2Ot/ZqETnzlC8qOzT8HEU
         EFvrlL9NTwQdeDm4lkik6ZOSrxLgalyEK/1kDdaPfKF1mpUyYPM9jvu0hIC6bLO26S4I
         TlVgAtGs8mft7hO4bsxB2VXl+tAuv4kBKsVMV3+kstDJzPUHlAeL6dlNardh81p89W5V
         e0+KLMz4jnvyla0tr87gBF1aqRwAY+OegfUFIxHCwGANCLhYMNrTemxSWJ4CvsBFMtnD
         X75g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790852294; x=1791457094;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OucJBsbHM5acxxfL6ZGTIjEsrBVOev5k2SFxTGalm5U=;
        b=hZEIO/dY2LTyNxSLZ740DLe8Qg3aczDecVqjAnrmJR5sRuwXcwNh6oCVUE3VvSPqWa
         +2Os5lWHeqrxJycaj6T1AmPobIT82kpksewrSGMX15h/sdaZqQOsCFtfeGeM9OIcxVkq
         en4YaqraHsso3osLtmpxBK3WphZe5j+2VAwDIZE416YlcBxMWKb8oL6NN99BWy0MAK+j
         qsCv2Hyu6tWu5zzX1onnD4s7WpsBsJJnd5GuEleIIEMLn2apG9iUtwY0ttv37vtvDHt5
         w8gnLoh3ojlEsRt853Fdp3eLwKQVGbb5nAEOUrKZV+YgmX1aNZNsgApXOgEK6QGipsau
         vdZg==
X-Forwarded-Encrypted: i=1; AKwUvBzHse/AVVp/8gmUJqO4crJZ0GPWM9JTop5mD9wNVJjUAotuwJRx5kj7Vdh+wNOQG7QA3gGHN4I=@vger.kernel.org
X-Gm-Message-State: AFq9FYK21ft7lI+bkrZb6JLIx4LJexLXYAEJQljT42bBLKaMWp6b5BA1
	W0SkJItFsJuQ2Jn/5a4wTqE1LS4ZVRaBMcHjsV2Ks0xNbSZBJmZ8D3yin0YGavi576Lv38iwaL4
	gB8oRK/+FzVqf1BEHh8Urkubh+0AK6Sg=
X-Gm-Gg: AYBFou28l+X8LJdx7cPegI8cBpfdiFASMD3LKDMnVTrRRvuUUmDFnw5x3mCI+nx4jCM
	kOxOn8N6GuBwXOpW5EtomsZrSl7bl4dn4RSUVlRel5rfWsxQvww8wvV1oQK7A0limIo1HA3fnXS
	A7QjILKC7AqOj+pSYh/4rTbEXvq8/XwBZgX5hX8GIpcSftdGiZvtg8TfMfAugGhVJLbUtm8TySZ
	6YkXjmyKrrmfF8zBh4G0SPWofJ2ARVIgyBCAhiKLbR2HV1CO8cNoAac13VsO3noNbGlND4gPIF5
	C2wDDj74pDfVYQsA9UVQ24F/RnJtjiys3xmU/6dGvZse4nZpHbp0NNXT
X-Received: by 2002:a05:6402:a0dc:b0:6ac:9a44:d409 with SMTP id
 4fb4d7f45d1cf-6ae19861627mr2907669a12.4.1790852294289; Thu, 01 Oct 2026
 03:58:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260930-work-mount-fixes-3-v1-0-be34c83956ae@kernel.org>
 <20260930-work-mount-fixes-3-v1-14-be34c83956ae@kernel.org> <20261001-prollen-rutschen-amtssiegel-31392f0a489c@brauner>
In-Reply-To: <20261001-prollen-rutschen-amtssiegel-31392f0a489c@brauner>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 1 Oct 2026 12:58:03 +0200
X-Gm-Features: AclHuK8LYUpnYgW_XqI4dZeZJ1CrP8OKgqe9-i6bwlWoDiqRwSqyXnoOY4MaNfA
Message-ID: <CAOQ4uxinQiXn=F8p92rCTzwX5AcBiN0abWW7jE9jKE+zqjb1_g@mail.gmail.com>
Subject: Re: [PATCH 14/17] fsnotify: detach the connector before destroying
 its marks
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, 
	Linus Torvalds <torvalds@linux-foundation.org>, Chris Mason <mason@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, Jeff Layton <jlayton@kernel.org>, 
	Aleksa Sarai <cyphar@cyphar.com>, bpf@vger.kernel.org, stable@vger.kernel.org, 
	Daehyeon Ko <4ncienth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 1, 2026 at 11:31=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> On Wed, Sep 30, 2026 at 03:32:06PM +0200, Christian Brauner wrote:
> > fsnotify_destroy_marks() removes every mark of an object that goes away=
.
> > It walks the mark list of the connector and has to drop the connector
> > lock around fsnotify_destroy_mark() since that sleeps. Afterwards it
> > continues from the mark it just destroyed. That mark stays on the list
> > because the function holds a reference to it. But while the lock is
> > dropped fsnotify_add_mark_list() can add a mark to the very same
> > connector and put it in front of the current one when group priority
> > dictates. fsnotify_grab_connector() hands out the connector until it is
> > detached and it only gets detached after the walk.
> >
> > So the walk never sees that mark. The connector is detached from the
> > object with the new mark still attached to it. It never receives an
> > event nor IN_IGNORED. For inotify that's a watch descriptor that never
> > reports anything and doesn't show up in fdinfo either:
> >
> >   wd1 =3D inotify_add_watch(/proc/self/fd/6) =3D 2
> >   events after the unlink:
> >     wd 1 mask 0x400 IN_DELETE_SELF
> >     wd 1 mask 0x8000 IN_IGNORED
> >   events after write() to the file:
> >     (none)
> >
> > Detach the connector from the object before the marks are destroyed.
> > fsnotify_grab_connector() refuses a detached connector so a mark added
> > from then on gets a connector of its own. Nothing during the destructio=
n
> > needs the connector. The inode reference of the connector is dropped
> > after the marks are gone as before.
> >
> > Fixes: 6b3f05d24d35 ("fsnotify: Detach mark from object list when last =
reference is dropped")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  fs/notify/mark.c | 16 ++++++++++------
> >  1 file changed, 10 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> > index b2640d836a71..f6891d39e42f 100644
> > --- a/fs/notify/mark.c
> > +++ b/fs/notify/mark.c
> > @@ -1112,6 +1112,16 @@ void fsnotify_destroy_marks(fsnotify_connp_t *co=
nnp)
> >       conn =3D fsnotify_grab_connector(connp);
> >       if (!conn)
> >               return;
> > +     /*
> > +      * Detach the connector from the object first. Once conn->lock is
> > +      * dropped a mark could be added in front of the one we're at and=
 the
> > +      * walk would miss it. fsnotify_grab_connector() refuses a detach=
ed
> > +      * connector so any mark added from now on gets a connector of it=
s
> > +      * own. This also stops pinning the inode until all mark referenc=
es
> > +      * get dropped. It would lead to strange results such as delaying
> > +      * inode deletion or blocking unmount.
> > +      */
> > +     objp =3D fsnotify_detach_connector_from_object(conn, &type);
>
> Folded as a fixup. We just restart the walk after the drop.
>
> diff --git a/fs/notify/mark.c b/fs/notify/mark.c
> index f6891d39e42f..e41774b19e00 100644
> --- a/fs/notify/mark.c
> +++ b/fs/notify/mark.c
> @@ -1113,23 +1113,15 @@ void fsnotify_destroy_marks(fsnotify_connp_t *con=
np)
>         if (!conn)
>                 return;
>         /*
> -        * Detach the connector from the object first. Once conn->lock is
> -        * dropped a mark could be added in front of the one we're at and=
 the
> -        * walk would miss it. fsnotify_grab_connector() refuses a detach=
ed
> -        * connector so any mark added from now on gets a connector of it=
s
> -        * own. This also stops pinning the inode until all mark referenc=
es
> -        * get dropped. It would lead to strange results such as delaying
> -        * inode deletion or blocking unmount.
> -        */
> -       objp =3D fsnotify_detach_connector_from_object(conn, &type);
> -       /*
> -        * We have to be careful since we can race with e.g.
> -        * fsnotify_clear_marks_by_group() and once we drop the conn->loc=
k, the
> -        * list can get modified. However we are holding mark reference a=
nd
> -        * thus our mark cannot be removed from obj_list so we can contin=
ue
> -        * iteration after regaining conn->lock.
> +        * A mark leaves the list with its last reference so the one we h=
old
> +        * keeps the connector alive. Another mark can be added in front =
of it
> +        * while conn->lock is dropped, so start over after every mark an=
d skip
> +        * the ones that are already detached.
>          */
> +restart:
>         hlist_for_each_entry(mark, &conn->list, obj_list) {
> +               if (!(mark->flags & FSNOTIFY_MARK_FLAG_ATTACHED))
> +                       continue;
>                 fsnotify_get_mark(mark);
>                 spin_unlock(&conn->lock);
>                 if (old_mark)
> @@ -1137,7 +1129,14 @@ void fsnotify_destroy_marks(fsnotify_connp_t *conn=
p)
>                 old_mark =3D mark;
>                 fsnotify_destroy_mark(mark, mark->group);
>                 spin_lock(&conn->lock);
> +               goto restart;
>         }

Isn't the inotify problem described in the commit message already solved by
669bb5af15d41 ("fs: make sure to call fsnotify_inoderemove() only once when
inode is dead=E2=80=9D) on vfs-7.4.misc?

Maybe your fix is needed for fanotify mntns watch and related to the change=
 in
patch 13?

I was thinking about setting a flag FSNOTIFY_CONN_FLAG_OBJ_DEAD at the
start of fsnotify_destroy_marks(), which serves as a barrier against adding
new marks.

That is conceptually the same concept as inode_notify_dead() state but
enforced from within fsnotify code.

Thanks,
Amir.
