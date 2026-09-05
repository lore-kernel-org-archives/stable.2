Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29A5436196D
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638638; cv=pass; b=RDWrM5ZUzh2e3Kou1VRWdSfUeHkIXkZDUg4JqBztyvkCnCiSfBnctoqXWWmDNgbZjf8LuZrQiVl/yjC3WxRifELUNq/tnsPHBgNnu4PxZzaFA0XGsrNTeZeu2KB+oF5+UPVhpyZM2hc+imH1QX/DftV/qSYS4ZBgf4eEz1jzPKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638638; c=relaxed/simple;
	bh=BkZgxxLAmfuIAPv3orYPEawdsAtB5cX6BxuX1IjeU/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ezv1GSuGlbuCBJ3SF9eVSQq53tKvtnIxE09u1V2zd65xI/28vPPKgSgbs1Gz16QNzAgG9rGWytN/Van0Q4LQKS2lGJ4tUx7jmQrwRv2zKSA302dRjzbheGaVuNyHpY7+wqqVNmkdE1QN4EPwdiWxF5ltSxA2Z9q652DV0Ie+KJA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9mo/B8R; arc=pass smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9mo/B8R"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-c252e703fa3so328099466b.3
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 13:03:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788638635; cv=none;
        d=google.com; s=arc-20260327;
        b=G5RPbxXnqFzbjJx5ecBfq8+XN/uG0D/OVPA/kOs0nLiVFZr7y0/fKQ5Za/qeBh005J
         gaBJLpJC9tNNNzMd0hi0R1QtP7ZsG6WIMVX4rObX4wjHsRWtp6gGkBKBgAQOO2GVEkig
         qG5bX9XtQYbOz8vYyke57NQTWF4Qn7+Bh1wrdHyr843KUx+QFMa2A0j9CxRT/NSIgHVa
         /TZJaaowzbrCY5nRrU7tBCyjhNZnwB6cVt4sVbxh8iQMxVPp41VIcdSACjjf4TQwv//D
         Psxray8uQQ4h7A7bfptOJ9dcd6d1zE6B0WougYzXPmelpueuZcE/nyGYA0NmfSObVgdT
         TGEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CT5qtULPI13xIGGGV4PsdNwiWaFlL1cvj8xNZmK9mfg=;
        fh=Uhq13EloY8o77dVrLIKP+1ibTaVoRIMtP+RJ46t6+rY=;
        b=n9ZViIYiFnf0ZHja82b+0YGET5MB1QYtsUqWn6V9XtJs1tilRw3nRgzfSxuhKsyWVU
         sTOJ6Ja52KGulU4iJ5lXprSPbPq2qn/tfyhPCOE1MZMqXc8z6D6E6ksmFJ5x3Gp3noYj
         38xaToa+lEb9VCZ0Ubo4bLJ7FZibFQF9gbnIBitV1oEMu6drf+Tlsq0ZdJbgUlzLZejQ
         aU5sUpSFf7cUzVkJjH3HhQ5yL5cIRgP78pevAudTbvn1F4bGM+kI4RrjT5dopakT5JLw
         9zFFGVP4CdOS0P+RGhZNfZnJZXeoyM66iNiSbqdLNrSgySsHAdSQg9eLw9fud3FCDS6s
         lHSQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788638635; x=1789243435; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CT5qtULPI13xIGGGV4PsdNwiWaFlL1cvj8xNZmK9mfg=;
        b=Y9mo/B8RvqKG/d1JIYvEzGZU7+my5te8K7FTe7WysmGJWYeO6lT+AeZwygm2y25eYo
         hGMiyJVaGYkwm2zg8VQ7+nevBcijmFpMhD9XsXPIOARx6So0jo7jO/8P/U36KnkMr4w3
         5rcFfNImKeLWqn2FEmTJaqXv+RfDtxqPvgTSF8dXCfpMqKz1Dj4ra9/uykrWSXZxq8Tz
         Y9911hYH3oXCyMeek0mfuZdrgHHDnjP2AZajFTihmvR6zsEHJcLTjwmkeFnrKRqqdb3e
         sNwdgZvEUtXIGQA7hHN498ShlR1fxQ04FYqHuaH70jUiCi7gh6OBqDlRg2AsqB5DuXi2
         jARg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788638635; x=1789243435;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CT5qtULPI13xIGGGV4PsdNwiWaFlL1cvj8xNZmK9mfg=;
        b=NaN/nx+PVtjG8NE+160aBfjpqPo6CVE6a+3gR5fbxS0J74gAjIUoCm2zXHReiYcUxU
         644ZpVn9w0twpLK6VTLkW6ht1tf+XE0jo/fcqLE3+DOHHW7XB+cWNUXl28QREDaim8L/
         2AbkeGFEPhy6PodSTmRgiXc/utNFDNm3a0MCYaM2mBTfde1bE6WcQCVzU/z/kuWAakqX
         eL5AtpEntcZ/L5XDE5+CqYJQlfBf1R7kuVr1o9rKNS0dhxDjxGx7A/9qitZFUtRGmFvV
         LGNRgTESsZW3XqYMzGP+QhPGuMH5l8itjTAFL0kXJxU33l2nsQEBDU1FWW7pF5TgFhjI
         an0A==
X-Gm-Message-State: AFuF++npmu6Wd+23PEJEE5TbAQ/ADgphCbb9o8dlMbx4v+MYTz1fvWQy
	91n82mbp2h7CuovhTKP7sNSCl/FAw4gbZ2pXExBHLDV6UEV1WE1Bcmop4Qi+2tACLoPZVMYnTSI
	l7sR7wmhLw2gJShoNDynUO4oH2YGVDfL5L6S6+Eo=
X-Gm-Gg: AYBFou2ZDDyaNb+v85mD41764oorJPcyFDjzsZv+h3P8Dxjcse0YZJ6QkXQlb+U+EVr
	u3p3Kxv4V+He13qBfysKm+Ys2PHwl3VXhs1iG/omSLopqy458nXlRySVkpb3VeTxCQivqCwhB1s
	VSm1G+d5s/hT6LNfsrE3RPjilflibXnXfcYjDF/70TImfTVoNZevrDs5hJrYoOHEckBHy71aY6R
	VHONyvP6qOeRJAsyak3zjFFCbw7UuqSnVV5FfUmqV6xvXo1F3ssSBg0fcvI53weKarfgsnX7OH3
	cwOCjd11kJ3MpUoZF2iSyNBWMPnA7RRLoquOVFJYKrpAAgI5d7wyTtib
X-Received: by 2002:a17:907:c20d:b0:c25:23d:5295 with SMTP id
 a640c23a62f3a-c260c9f8920mr559675466b.17.1788638634921; Sat, 05 Sep 2026
 13:03:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090337-hatbox-diameter-e873@gregkh> <20260905024611.3934633-1-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260905024611.3934633-1-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Sep 2026 22:03:43 +0200
X-Gm-Features: AcwNN1VFShBlaL6sHY5-uJq0D8C430kcflf8iu5Qq2QSwJg92t6Ui_u3pa7dAic
Message-ID: <CAOQ4uxhV4Gf0HUbYWav4mtPSV+JhjvcrdBuetzUxYDD0uVhf3w@mail.gmail.com>
Subject: Re: [PATCH 6.1.y] fsnotify: Fix stale object mask after concurrent
 mark updates
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:46=E2=80=AFAM Youngjae Kwon <yjkwon0026@snu.ac.kr>=
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
> index 9df5db0f10ff..48984f039fde 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1126,16 +1126,18 @@ static bool fanotify_mark_update_flags(struct fsn=
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
