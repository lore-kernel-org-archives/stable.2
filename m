Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EBA13A8755
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 20:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788638564; cv=pass; b=a22fOtT3PBsaI1RxhjUWRRuyjRgCRFQf9E+vzY7UkgVPOE7j6JgEwROgpguCRVCDpvruVQAdvx8SQfOkYp7VXzJRmE2jVqoARpQRfo2eyH1iLgqBz8FA/2djbHoQEiDIp0KLADgl+qtRdpvczYr/rl8bYvAbwfy9tsanuSUIogU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788638564; c=relaxed/simple;
	bh=5FKr9DnE4V9mhkJPVSmoYSr8XmYZQrVZ9NnQuVQS+2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0JtxgBgZ1NkJz9dT940VGL6JXW6t+tuC6alXgQBv3A+41M2sOAUfmWaVtrmbhii5VIVRFXJGJjOh0boidMqb0D6IkdbqBlpnomqJI1nfOnwKomdRuXhVjb9ZRI0VMPxnydNHgCNHo1i8DurnPfX3Eh8rfLdSfooaU1emxkehTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E/DxEy79; arc=pass smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/DxEy79"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6a623987d32so3243921a12.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 13:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788638549; cv=none;
        d=google.com; s=arc-20260327;
        b=dYxqa8ISp9ZD0OhGL80eSHZmuRSKSRzebgF46a1qRGSJDaqMszGVqDLQys68Xq2w2y
         YxAUPsfNvw2KsJxVtRk6T16ZAyh4cMNTnwIe3N1HhX8tw3ft7C9vF8rwUzPAD5zWUxhq
         scze2eILi2JVYRX69b6Hf7dOFvbHp8kY8cTfePjlYmxgWvNa0SI+/9JPyhxE3u+lmkDT
         KEn2/bY2ihtnrqznJZa7fHvyKyzFG/fZpcr0bHchb1rF/wtGNjIsrwxLZt/JtZVPCpko
         HkFk7i5ZaqlyYufICgMfyTjb7AZW/TKBH8dKBH9A+J6cSFB3eBBtkD/h1+HVEPb9bTu2
         59zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pdrOp93Z3L0MINt34xXDWa79zO07ij7HLrR5KtoARuk=;
        fh=Uhq13EloY8o77dVrLIKP+1ibTaVoRIMtP+RJ46t6+rY=;
        b=e0b6b3+uRGhSbW3mllZVGfNr3xJ5DTVUHPro7WtVeNiyL4kFWWjBd3d/59HLkpbqwo
         u2pw11J3uhhiJmLGpml7MMj+Rsz/0xzZwmxnjZyrkuIUsXTdnd6ENNLD8stVOhTroofA
         B9H1z88UNuOGNhRSoQ7+VxzSgKcJ2U/vBpxSjy2wKW1UyQVog/cknpwsQOGx34CrYjCM
         BgJs2M3XMgqG9GWqupbhqJb6X2UxBw/TDa6ugU214FaXA2+ekOPTVzIlyWZ9fHECKCU2
         brpUveDd2Zq8HPSUKEqVVCrncH7qijsm2gbV0v0vTMi86Yg/VTq8h14znQuCffqH3+V5
         pz7g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788638549; x=1789243349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pdrOp93Z3L0MINt34xXDWa79zO07ij7HLrR5KtoARuk=;
        b=E/DxEy79VDom7Dwra6Bk2RsShz7sLz0459sK0CFoM0Pv57BfaO64PwnlAH/4GXCVQd
         dk8mZNEMHfQXpZfRYDmTNOQ58M0nGWX/rakI6Z6qqgLyNXOZPX4U1WxroYLq23ymGqvd
         aNctQgItHbjnbeysrQ9lQaKAidT1WTuvkJ+dSX3Q2bGsM8L+a4lgf7s3ga0QzyBNZNd5
         VjUFMscSvSy7hxt4Ym63ItQi3nUathN9B6HtAWPhZX7NXf3yIE88ZZchJ9+z5KamVACB
         jdV5T92fcNeyL7J+POWoruJYXUkiSi4NK2zW5jC9Ha3BrKHGIN/7SmYSTGGj2biR8mO+
         Wnsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788638549; x=1789243349;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pdrOp93Z3L0MINt34xXDWa79zO07ij7HLrR5KtoARuk=;
        b=NqeimxsqNoMx3WJpCtF1VC9Oj0hg/PtTrsDr8R0x2HQfeeMV3pw23Fku3MUbzJ0og+
         SaG/t0R3SJwUwpRqGlV8h7rwvNJUPSXAKsads/d6ntowblwiR/jLO5ExBc64o8U0xprE
         EM8NgRBGaN55kJGUP8HrENwrNwFepK9JoprUl31q8DzQGNQE/8yxeTV1gN+QoH50l5XZ
         7p4bf8VlM0uHH7/w03eYSWeM0ug4Un6gj2MAOOXLQw475l4sDpF4PaSOaJVpebr8SW0x
         En+HEWr/LifI93bo+rfQnSfv0IsPTISBt0sF9f2ScwFCPD9z/Gtx6tW47iR+9QLRqKrs
         Uzvw==
X-Gm-Message-State: AFuF++kMLfPXGKwDgBb7XQ/CRNh53XhRnqzZWxx1ygxBYcgSH8kTWWxn
	kaMp8sZceNhoAKatycWCQkyoZ0I1zMnlHIXBY5RsYsdNcQMs8wJvXDHD+9OAl0WbzdIiehcHZMx
	vS6zXIa8LpIHlzm9G8PJ+8TxB4lBxqdk=
X-Gm-Gg: AYBFou363EeSLluQl+QBJ3tF8+NeLE2DcGHpRbtBlTrq9BeMiVTE/SzVkx2j5BhVfCU
	NV4jN0Ktu9D439tNm37DfW36irD4LXrjucbCe5hqDQNXmhPIOBWyF67GvglOP94Dw3+Byy1Vxik
	TMDa1RVsrvoGQqo9EcGauA8+9zoFEVqMj4WnHdn20bqewQVmUuypKUct4uQR4ACHIdMElOdBPyh
	NWkdf3AMlthWbWuSmMmNeWaxfq962mxQuWIW8WWjjF6gXs8wgBc7Bu529hRMfpmtYKGBZSgCUC9
	N6VbtWmQ9Iu+OPplyPOmvbsd0zhFbfpAyIh90nMVFVwgLA==
X-Received: by 2002:a05:6402:4150:b0:6a7:ee56:615e with SMTP id
 4fb4d7f45d1cf-6a7ee56631dmr4035697a12.32.1788638548251; Sat, 05 Sep 2026
 13:02:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026090338-buffoon-phony-d532@gregkh> <20260905024422.3925571-1-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260905024422.3925571-1-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sat, 5 Sep 2026 22:02:17 +0200
X-Gm-Features: AcwNN1VEo5QJISyHrcmNQe-wgD83yB0bqv997rBeTV8ZYKfbWNwNRYcx288dI60
Message-ID: <CAOQ4uxj5ay5g4VQgbbs10eMAQ-zeqron_Pp6kLxwErf_NeSw8A@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] fsnotify: Fix stale object mask after concurrent
 mark updates
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 5, 2026 at 4:44=E2=80=AFAM Youngjae Kwon <yjkwon0026@snu.ac.kr>=
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
> index 5302313f28be..634de85a2f03 100644
> --- a/fs/notify/fanotify/fanotify_user.c
> +++ b/fs/notify/fanotify/fanotify_user.c
> @@ -1114,16 +1114,18 @@ static bool fanotify_mark_update_flags(struct fsn=
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
> index 0b439051951c..40343a15aeb9 100644
> --- a/fs/notify/inotify/inotify_user.c
> +++ b/fs/notify/inotify/inotify_user.c
> @@ -527,7 +527,6 @@ static int inotify_update_existing_watch(struct fsnot=
ify_group *group,
>  {
>         struct fsnotify_mark *fsn_mark;
>         struct inotify_inode_mark *i_mark;
> -       __u32 old_mask, new_mask;
>         int replace =3D !(arg & IN_MASK_ADD);
>         int create =3D (arg & IN_MASK_CREATE);
>         int ret;
> @@ -543,27 +542,15 @@ static int inotify_update_existing_watch(struct fsn=
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
