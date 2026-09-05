Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A1536196D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638794; cv=pass; b=ZXvUB2Nxwvkthd3iLH4MTGASAPCzEeNXKHJvo1RN+0VM3AdhgXG2910/0xy2QFg86PWPqVhTYE293lNLf4M/6/6CzD/XkFAKubf1jYc+ucNZfDxxyzzxYdB/FNHZS8TWYXB+8jodiTN97Im2Mlm0CkbM9t9tWqecya77XxXwWAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638794; c=relaxed/simple;
	bh=NPhwl5IGL6O6pL2kWEnc5rMShMXLZLbH5KSD9/JY2io=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qCFUk3sBjW1XuV5JsZfCAH35iKNOAWv1j027CC2OKDrk7K6C1zP6e+DL6rjjzXeJGwyGN2O0KVxGT8TRP3yQm1N1l3ang9YIetZuobDalf+HguG40dTeMjlHKtTySRGaRJkJAtc/2MJnLCoJVsYkJzRUGlTMBaaAk6UnQCG3sGs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B128GN2o; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B128GN2o"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6a623987d32so3246412a12.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 13:06:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788638790; cv=none;
        d=google.com; s=arc-20260327;
        b=dHUOJ4uCvUNORhUz2iuGYjrvmEeFdNMoMhRFPLJ/D87NZEfUO1fpjBjmEsYFbosTfJ
         9m+SUeULmZS1UxsQ0qIl5E5o0NtJORFVi0nemzlMtrtsiVfh8OrjC9Bu/PiukKxvpylU
         Dj+00mZ96Gb7/enkWWUDfwPeLBjvEjBPABjyR0W7f2cjJkxbEGQere/Ev30eIb9N92rH
         jr0FQDUabps0vl9tSzyMd+qVdcy9InI72NSpRPBi1oixF1euP8FIc8jAk9Vq4bpQJ5Rn
         +G196gJpBNnyRs9ndsKUPbViVeIdik8Am+RSuJHVNWf4XIoraFp1QzlTCGvFvQKCn2EB
         YpDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+8qaStDLyT43wO5+47IDw8g2x8kb3p4F1r2sbQ+B+TI=;
        fh=Uhq13EloY8o77dVrLIKP+1ibTaVoRIMtP+RJ46t6+rY=;
        b=IuaR7ile6h4xBK9Izh1A/+Nu+ciXWi65YQ0nB4D7O7PdzOduoodLp4FlAY+BbR1ZW7
         +l9TM+yundM2hSpzltvfYvlKLQ1vY/O8QUgmq6v/iXzm22Pp/FkNV2VL//oCVRGtrxfM
         4OrPpYvy/VkTH8D+ZyzRRc0HIVwQMFG8zrB0JOV1LaRcLDI4/PT2v8rilbIrE07/0XJs
         1pveK3lhI2W6DL8fLR2Ite2OhydsAHeFLQDtpldDpQ1QhVRVaSvK2hsPng7huhLrWj2J
         j3dvwG/3+jk/6nX3bpfvM0QCIKCe7Q0kFH43GhB/aOTG1RSx48mVvr9VxrjrrxoyrPJu
         ieMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788638790; x=1789243590; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+8qaStDLyT43wO5+47IDw8g2x8kb3p4F1r2sbQ+B+TI=;
        b=B128GN2o9ovf0x4Ifv01aOzHbAvDzy8ewXPvSTIj2hHOl8kDDQIvfN0D7eqyHd4w9r
         suZ1sd8vAI8YDRVTLJOJYCAIuhPkQKF7We0mfhETaUz2m4P65GiSBjD5Gn0U896IQjlW
         WFsdlI+XmTg6HpPXQhHIMzW40zvi+7iVwk6dwAuCrweCmZepTdSt6mCRMJuGF+jd7bSY
         LyYQSVwnZCITYJr2kO/7gll4t+8fL3ofOv0NamIMunEiIBrEb8267Lhyflzjij5KZ7Jl
         OdtLNg8wiE8oOU5E3tmMQ0B0Ejcm9eoaJhW5g0EpDiCyIchhmb+jC6AZqqP73EDfGQkL
         XYRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788638790; x=1789243590;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+8qaStDLyT43wO5+47IDw8g2x8kb3p4F1r2sbQ+B+TI=;
        b=X7uVh2XqEfl58lFJu0qqsdwsj0VRaIzjFhEBkUnL9aSg2lI8MhnX3qCuLklEsV/am9
         s1f9fb1xQeGnXh56mZk3jsgBWglWGgkX26YW0+/WF0cDAzkySy1SBzsfHGW6IDlA9ldV
         VlyRN+3ppzHNVWDgTtpr0pfiFT8xYkmWBt/FWBbEdlf/r2umLzHSvS5iXpaeLXgbCfBo
         74DXtPBv9uXCK8hvPMvjw8RgVyuxGogGw5PLgHxWMliqWMcGxPmN03KjZh/3A4M3uWsx
         0lDR+6JJmSbF/itR4w2sE+JoXiXrX5cD9m8wcUZwVLx0GyJD0EB6TEu9IP/eZGVPGaRB
         0QoA==
X-Gm-Message-State: AFuF++kvJ2I5XRt6mqPzIkv9lJkL6rYZJ3fNNBNgpkVuGzBlxmCsIiy1
	lkHT43iCTkvhpl7Tlez++EVOeBuXLB+i5UHMjVSkvUBFeMJYgsjxGba48eiZeaO8EUZHyDMSFV5
	qBk1pEUWf4msetALwpr5UNeerDxPdNr0=
X-Gm-Gg: AYBFou3b4ElKJsHkz4wwb9YJT7EcLn3cNeXA/Ovy7QJ0Q2R5LpxlfH5ed/MyRT/pVoF
	TIOfoDNrVNUDvFm8NnzNSYgWGcHyO7tzQHtIePH1ZQexpqk4fOu5lpoSpo6tqigNsJuKaR4sS4Z
	Ceoo9JgVA2yi4yJ5qpUXOic2UcVjXm9DVeKStHHetXchokUkX+JH+I5BYJtxqzB31CnuAkkHIqj
	U0ys6WOdxNPPvaf4mrtYHhnhLUBHoJN04/F4kfUQa8vRJctzMPdwfRAzmz7uJ+yrEUfWUjgUqWR
	R7/VdMHIoC8MaarbdDxV1iuoJDEx0tbDPXM5H2HMfmarcA==
X-Received: by 2002:a05:6402:a0d9:b0:6a7:ee56:615c with SMTP id
 4fb4d7f45d1cf-6a7ee5662efmr3611025a12.30.1788638790115; Sat, 05 Sep 2026
 13:06:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090335-magnetism-tipping-5204@gregkh> <20260905024734.3941984-1-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260905024734.3941984-1-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Sep 2026 22:06:18 +0200
X-Gm-Features: AcwNN1X6VtDFdK31Js_ksnp0CEVkyXPapB4BXEdKvPRRDj96Q9PjmKeJHsNVdhg
Message-ID: <CAOQ4uxj0rAj+8S+E=fxiTxym5dRdEJgk9NHE=wJcancfnxLBLA@mail.gmail.com>
Subject: Re: [PATCH 6.12.y] fsnotify: Fix stale object mask after concurrent
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
> index 0ea4e99dc449..e5ccd5572beb 100644
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
