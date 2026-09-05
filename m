Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C435936196D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638663; cv=pass; b=LunJ0iZh9F8LfVphHy6ikrgWh0wz5XMDxzTm5ViIzj74FIJiLVy5TUqIE5pZsvijWOr+JLkIZnuOBWH1Qdvf7v+8Eot5iSE0xOu7rqcuZCtkbONZueECy2go6qiy8JJxhpVKdBBrEDA3Omyb0bGlle1eRNiR8IRea8JVAWSkNKw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638663; c=relaxed/simple;
	bh=XkZIO36igUM9Do7N1JxTavEKGbOLQzpCr6Gli4QdI1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hvFS3fX3QUGZz4+48tNh8HDT7XTQMFiaJnXuRxCG7MJ2SNRYvpGSLXxkiqCm5ma1MXCkfrcmsgkizGG9TBb1Z1CFW19BcFgizZN9rEDXBu+MaywP8/ELH1VVFpSEW1e21x9Skgoqs3Bhj9T9OZmcthLbNS9KTky+V+KFA5/NpKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tHWYahKR; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tHWYahKR"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c25b661d37dso298781266b.0
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 13:04:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788638660; cv=none;
        d=google.com; s=arc-20260327;
        b=I4UihNP4bYy8rRrz98MMEJJ5AbQvy4+IINKua5cWZxiTUelJRwGymVfY7mfqWw6ans
         kG8coUZ/4BSP84ZpPOPcJWUzTMjjKSMVmZ0DtjZbNIzCz1j/6zH5RR7q5Ou8xbdU80DH
         keiVmKIG/VHLRo6VVUOSimKAgWJrMGQg7CDYJk1gL/pPq76gx4AqtDzfwgjFvdyg2NlD
         6A4rPYkpyoyo51MoVSzlK3dMIzc7O5MMVblYJ+DezQA9TAAxGc5FEUgi8iMhc/ybs/lF
         LxUR7XDGZObI+gsXgtWy4sTFN1rC7Sjilw1vJ/dU5eO1uaS/KmbcTv1rrJ0BqmQF7MAk
         IiYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i+VOTTCMtUIxBI1PycKO6akSJzqkBAGnqH0d9tN8wz8=;
        fh=Uhq13EloY8o77dVrLIKP+1ibTaVoRIMtP+RJ46t6+rY=;
        b=CBVQzYvYWTWD8E6XDTDBHw5LhsIlnCXU1G6+56jOB2KgCBsvWW6BDloGnlMOGvBIo0
         vD1WQGHTdZXx7Z6nrmpce1Wl84+KBOUhcdDwlhkMEs+Y7cJJFWnx4hO28eZt6xXbCsIN
         nDLVAYiKqeVM1iIc20wH0oS00slUbzsJNlgPqkCNQFdA2wnZtZlXkNCT46Q6M14EpNsd
         mbWFr80AXI9WG61VdSTkKmeQTd6TRPwIW8TL6VA0FRTbP8DUkdWDiR6WK+i0+tgZm6VN
         z7+VqeBGK6eUqzNwzzdydBcnYSvgYEqSLZRGTrZ8lLBmpxhdIDSe0pmu6FTJsIWQVaJl
         65vg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788638660; x=1789243460; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i+VOTTCMtUIxBI1PycKO6akSJzqkBAGnqH0d9tN8wz8=;
        b=tHWYahKR7uAiY4tEASoPEv3oG/sr/UrLWO1NiE1u6qBzYMYITquaT+EzXp5ctHvZHq
         MWjwOyE3JYoDB3VLU7dKbY7CZAlMP0xmNK70tzCGfTRuqbA2xwMKkh4IlZcNSit/telm
         FQoOMSaEckedYo+qQyUoOsmLCM2LtsQDn560GGDLmL9Hr63o/8U2p6Rqe5QGYMgK3amS
         VPrzxolz3Ej/988lMHTJ1nevxXjI1Y98iJcr9VhoSVZZga9iujD5CKgniYbTsVcLToZF
         wPsIlSMLNY2Fmvve5TN5kvnBN3xhPToagOCfxY802gEBH+O0VnHK58vkgqZLiiLOzMQs
         Jt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788638660; x=1789243460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i+VOTTCMtUIxBI1PycKO6akSJzqkBAGnqH0d9tN8wz8=;
        b=G1z7ngERAh5u/3BAkASzogJn3gPyWoCrDA4W5WJzi5AZoLVh1418SA4PAxeDQ4OT5A
         70T8saN2pfIBZb3zGUFumpcWoWjtrXM9OK/Dv4VBu8cI7GQ7GKo8JmVJgyVzK2DK2jmV
         DCJRea4yAlYjQEb57zvo97z4Ar7/9aaeGFDPObIVhZTeCBtnHL7pxhPNpVHO2gZqUYlk
         J5z3suSAUstkqZoUmv6y1A7BpJqE77Zx7eRJbCUF3nPJxjKkZHqSxn88Obgj4TwzT1IS
         WZIG8W+WspNoXI51lh2au3HeS3zKQbh0GSX8dLXQLhsLo5d/oSQ4u4JYzPJzLrkbghE3
         I+vg==
X-Gm-Message-State: AFuF++lFvk8DfrLRtEGuSRjsED8nVyOanWioIhk7717zp99mJTv1V41T
	iDe7BLjWVlLDY5IeSiNMlki6Nxb4fKAR2poAeT0s6E22LSvblnI7WtxZtTHCirWvt1u66ArSe4W
	Yo1TlcHh9CUqNOKuZDd1Wcmtoc2NMAm8=
X-Gm-Gg: AYBFou3PoFtYpK1p3mtTFnndMW4wDjX2x5HcAozIvTrE+iW1eSJBcE/4C/t54mXYSqe
	phsKiHbBy/D62YeNXBrp7NmG9o4ny2wwjms9t0nILZkW8sIMjipmI6IeRhpNskzsPBsqHZKguJw
	XfLiiu/Z7kV6IvU1he6VT2kG0aBZgpMTiZspek0rAxVq/fBzIQNICwASZnSQwVKqh5CMC6JRZoB
	G7Olz3q+j4iALbnwsZ6CxseW1/1nkTjL+CviyUamdOppR7GSFysxZbxzcHBdSZLOmSD7ARXNWYx
	/zz5MMFLbJrei4iSKC857kByBYrq+osGe4jmaFfWPNTTnw==
X-Received: by 2002:a17:907:7282:b0:c16:6a42:c7d6 with SMTP id
 a640c23a62f3a-c260c8d57a5mr533530366b.9.1788638659414; Sat, 05 Sep 2026
 13:04:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090336-dance-salaried-2815@gregkh> <20260905024642.3937399-1-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260905024642.3937399-1-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Sep 2026 22:04:07 +0200
X-Gm-Features: AcwNN1U84GDpqp3oKTkMqHfVi6QPYwybv-JWEWBz9Pk9ygayzGDBiamyvkWY-Bg
Message-ID: <CAOQ4uxgsvaJr+nV5CiHgzrbYr5KLtgNfGV=O+YndftGaC0-oOw@mail.gmail.com>
Subject: Re: [PATCH 6.6.y] fsnotify: Fix stale object mask after concurrent
 mark updates
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:47=E2=80=AFAM Youngjae Kwon <yjkwon0026@snu.ac.kr>=
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
> index f4798d613dc2..763ca835d8fd 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1186,16 +1186,18 @@ static bool fanotify_mark_update_flags(struct fsn=
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
> index 804af9d6078b..b2c75477f549 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -540,7 +540,6 @@ static int inotify_update_existing_watch(struct fsnot=
ify_group *group,
>  {
>         struct fsnotify_mark *fsn_mark;
>         struct inotify_inode_mark *i_mark;
> -       __u32 old_mask, new_mask;
>         int replace =3D !(arg & IN_MASK_ADD);
>         int create =3D (arg & IN_MASK_CREATE);
>         int ret;
> @@ -556,27 +555,15 @@ static int inotify_update_existing_watch(struct fsn=
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
