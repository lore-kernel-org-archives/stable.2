Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD5941F5F5
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 08:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788685037; cv=pass; b=e1zYJ0N9dz3eiMmI9opOFKwMj1Zcsiq6RjE4fAGf3cRnAMlxTnmzsS36v/0ektBqfK4sHbBgNCkzJmUK6m0SHqT9yXHDUXEijRhjZUQvocYZmluIPcCCt7085SLNC3D/QFfGN6ZCnFy57tNMg5tI7bwvymfm6KlKvJEZxBIyKXw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788685037; c=relaxed/simple;
	bh=kOTdZ78C64PNmCHcn7/UzaKLudLK2k2BmWhiyDe7F7o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RPyhqFs3KcPab05u8QiifttIam13O5amw5Re2YxUjmTVK8aE7FfvzOS/mZEL0BiXrcbnpILr+kIzZiAczEAp8EBiCyaPYLMie3gXP6UUrb6kdToCVzDa3MQfMkMv7fPDG9sovfRK1xBLP3gYZmoJ0ac0QY4CBjfwai1cRywRoro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WuFIT/J6; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WuFIT/J6"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c262bc686d9so156480266b.2
        for <stable@vger.kernel.org>; Sun, 06 Sep 2026 01:57:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788685033; cv=none;
        d=google.com; s=arc-20260327;
        b=Djf852T0fwn/9Jnaj82xtPJshiE1gszmu3dNXMc3Xpr15S+NLDQ9mDrGK2Zx0bNo2F
         t0TW/WJsL3eZtlh3QvQ9+PUmEkxe6I6D4WajyCCJJhNmWdAL2Ceh4dqzMlo0FW3oKclg
         F6VhwVRY+92hlcKiFp2YyZPq+LmZ7rYu6H0eXn/Y78lGbIJ7oXsfQRJeZJG42qJXALAx
         e60cwKswbR4YcstszH3p0s7frfz8qI2fmcmrTOe3s9Sihq/Gk1zD+gVEaDYgx0TxtWPf
         qZ1rofInxoPVEbVYKiNNZ4xTWRqq3nncSN9vQeqEoQm9f7qOaR9U7eI8KqblzKATnKaM
         +VnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=egANJyolG/8Lvtld5DPV43DLJv/nO71KGBPgjlmY1ps=;
        fh=Uhq13EloY8o77dVrLIKP+1ibTaVoRIMtP+RJ46t6+rY=;
        b=eOEqNHYjO1ZWWHYT1WSdKe5Qt9as1egQkrlt62BkHQtp36JTxLAUXlsFTeRrqkjb38
         ZNcttgLQIH9WsMOO9pRh/B3l3LYPqlyLd/AJCaPj8LTj5yDUuUrQHdmzI8j/+m0inPFR
         nRcbOPHaBfO4Txk4Cbu7hDKc4o0AgA3+qr6Hmi5XKLwAhFBuuN0wn/GU71MUB0+9eWGT
         1SbddAsd2Xd2sNrIOq3R4gB5v/+KuOzwoMzoF4bjH9BOfqXxRJIhxhzv1USA+KySqmAZ
         7VwSvwr6wz/6TnBbSrBDt/IiBLA6tFBRAGXewEnNy3NzLqxqJXpsaOo/Y0PCPG040b0i
         Dusg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788685033; x=1789289833; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=egANJyolG/8Lvtld5DPV43DLJv/nO71KGBPgjlmY1ps=;
        b=WuFIT/J6M8wjSSQIEh5U/GLqgadig/j+JUr981CXJhZpT7lt0g/m1QXjdsbKN4iVML
         1crt0Jpy98qGKTszsBpph3MwLRGRdFzNFf5hei3p0lbb5N6x9UpIjZhBgDukahfnPLdn
         Hnl8UbVN6QfsscgETpEEJLJnN2j5ByOnT0ZMWBnacXRcfXHEgLLgvI3aDgGotn/yrqZD
         WrQIfv4PgNkTNS9BPHgqy1BSTWzwHWYl0/Y478ATUEoV3V/6SdgfuqQ2fpq4jvVco/u+
         Mq1EQifR8ygF63s/nzRRyV27t0b87DVbJHmzMC/sHSbtgVoTb/+szZ6ctkustO9JZ8gZ
         aAcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788685033; x=1789289833;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=egANJyolG/8Lvtld5DPV43DLJv/nO71KGBPgjlmY1ps=;
        b=JttcSq4HT/N1NHckIyvOEQgqDHEq5hAfdEFJJdH2yYELgAyt7nvrN+3/YfL6EN1Sci
         gL3iOtcXXUYi1L+LeZAaFAyoTyHhYxUuZQJqd4hXF6wVbMacrSNM4/1Uqn2NGanmP+Z9
         BZmeqQpqW0UXkisaKrKvtNtuOIXzR3diSq431GAVe/flkR5oVnvFB/QkISaCcc/So7yb
         W7UmJTx43HXP+msRkV18nfweFupoQ0t6cdozX3JL0DdEyeyc8+5LKs/vxb4HLoSlQZLt
         F9qzdYKQ+yj8GFbyYHXAXR2oWOO0q9eJkYAfIZuD3XTQRlLIji8aGv/eyP+1ca3cujEi
         h2hw==
X-Gm-Message-State: AFuF++lS7UNHlmUWuKekPyJgO0w2lgaMma7sPm42bq2H43iwBV3MTSyg
	UF6/i8n3Vdo0CowZpcQkclw2KdCaxmnPtFNUi1cW++K6Ry2cubS4gFz8WCtDZ9DQVPMRFCgehOp
	okxWKLtxFYtq+SdHoBAqYi0elElIfE0U=
X-Gm-Gg: AYBFou1Nqb0pWZobpxiTyPC8TdYQsmqIzzEu3PjMqMNOcZnT6zr+0bpRwogQcUS/3af
	aQhcsnwylqZCbx60OBmhzc6VkbNBkqeSkqM6gSDWmk66akTHl5JOyYbbA1Zg9vrVKLBOlrFIwd0
	2pjVDcO+dJpR4p7wNONDnSbKe9fsONBW3fKB1INEeAYo+ZnDGDSPzRC51m6m6gKe6cwGDRdtS5k
	uGgeuUuz6ihN27RKD3IJeQj0sHfjS22NyL/Z5nKO+kzAjq+fDrYwTepz4JnArBlm2THWRnRnOfz
	buTccPaLVTeDvU6QCinQmNQDqD6uGSo/Ago6T6m7HsmQew==
X-Received: by 2002:a05:6402:4150:b0:6a7:ee56:8150 with SMTP id
 4fb4d7f45d1cf-6a7ee568298mr4671503a12.30.1788685032991; Sun, 06 Sep 2026
 01:57:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOQ4uxjNxYFJE2J3K=_Ur2LjvF2nnE2B626ef6YUWJwAoirB2w@mail.gmail.com>
 <20260906030833.3356045-1-yjkwon0026@snu.ac.kr> <20260906030833.3356045-2-yjkwon0026@snu.ac.kr>
In-Reply-To: <20260906030833.3356045-2-yjkwon0026@snu.ac.kr>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 6 Sep 2026 10:57:00 +0200
X-Gm-Features: AcwNN1WXfl8LMtmQ6HGsokmVkhNpvVMmg4gvgWuHmDhOswCzUl70NMOxvdspFO0
Message-ID: <CAOQ4uxga6piy=9isevO9TTrYEgQEbv4mcm_1W9FCTm5vsVkZ1w@mail.gmail.com>
Subject: Re: [PATCH 6.18.y v2 2/2] fsnotify: Fix stale object mask after
 concurrent mark updates
To: Youngjae Kwon <yjkwon0026@snu.ac.kr>
Cc: stable@vger.kernel.org, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 6, 2026 at 5:09=E2=80=AFAM Youngjae Kwon <yjkwon0026@snu.ac.kr>=
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
> index 905c27e9cd38..6eaf0d382eec 100644
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
