Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C033C345A
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 10:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781777232; cv=pass; b=a+cHltSyOzBom4QFDKzZuvHXSK1+8dMocZ6hH5EFv3GQl2BK1u3b4AZGYor9EPbpr19/qA8NwIH2dGHXY+JLq0aIM0Ow0+XTfunUu/YTtBstJZwpdRU4jWqz0j5jsULnADuhuOgKg9eISJ+s7a5IdBc/lHUzT9vFoGvIwDS5RFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781777232; c=relaxed/simple;
	bh=UrjScFoed6ba8lVI6g16EOXI1I6Ov2tM4Y2+U9efV/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+8SMkET0Mtt/qAx2dy5uLqva6/nBLE+0dUm9a7yuHBzsaHi4OxG0Vo7dsmNJpaX+tvbSvAry4Vj+r8aNuT2+pxkd82wQGz/mX8JbEEszgdk8RydrUchoq/EnvLRlmf7CqQ3GbMUkNO6eHAMUNYMTM0CtG41GLsR7eu+RCvDEas=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bR/u5P14; arc=pass smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bR/u5P14"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa6c66e6c5so561346e87.2
        for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:07:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781777226; cv=none;
        d=google.com; s=arc-20240605;
        b=RxXsnSXinCRgljL8cCAILT+LuI9QHrU/e1wW3Dvlg7C8Ro4KXODJRwLSQLZOzfSABS
         Vb7ZjwWUb1lW/PWgB/Ci9sbkSBu/S7A3LRWQurT0Vgiob1AdXIq/nkHneilVqxA4S/rF
         zOKPlb32D2cEBBvw2Hf4JU3EYypjpaDlXTWHVVawkLg34V6NTkW67x0rNAZA6m1BXJZf
         9nhhbFpLnd1IjwMTLiEfZ2W9TWqKyYAT2mpLeVQzO3h0GbXhu3TjGC7L5xfvKTLtHYi+
         qfaHq4QevFE//3p/aswjPxWVI2+bJLHEjASlMvD3umvr0Gu2r3p32UcF2jd5yLRGujKm
         uvZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b3tQM4YZOU4ZmVyeRxXliIy04zyVWMpCicoAHdMKaq0=;
        fh=w3pt3iKYkkWj9qEL9aL6AZij2pALPtWGmaXrDChWa+E=;
        b=I38ODHnfRtpRIBEgmTt6b8q5BBxuE+4NSgHo+uZikoXa0ZsFE4MOQP4H6/WVRZFN1F
         9UczA2neD8YMphJ/lUAHmMrnZQtcegVHU/91z44IF3BFnq0a6WQVEmNXq3DzVmO/Behf
         NiS4yWvPvVFDfIDzeHMa2BPVkGh/PqtsEZ2X5it08IuuF3KjEGmf8c3xYfOACmVNdx+o
         DmJ/Py+22BF42oqP81FWZ2kzIxY6ZhVM4ektoEUBQ6CRFclkBWJ7fSR8Kqqmq6cZQltE
         qeXabpjWGW8u7dxJAyj0ULDHShtlbnBQxX6iD61/tH8+PRU3fWpVKpdL2teVJ02q/pg4
         U70A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781777226; x=1782382026; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b3tQM4YZOU4ZmVyeRxXliIy04zyVWMpCicoAHdMKaq0=;
        b=bR/u5P145goxmufMQAZWBiHwm6Zalr+BKpWT1AhZW3l2OryMLca9/nH6tQThYkEiWr
         nwMdOE1+qWcot7lcMNdMhwBzKWKXKTePDY3HOyndG/jVsQR+R5Jfu9UotrYjSFzovynf
         7refPiCJNKzzmPAinfdbUB9vAa0CLAnZ/ULhOFNXdz6O35WqKfSvj6sfjke+C4MPFuCx
         oADh/KF1TNvfdqa6nfmMWJwFM6PQxglFFhEhoyfyZMCs49kd+fJoCYQ/IUWbgsGb6AOX
         80svrm6ilZCwPFKcBxuOMpik1UjWOOgMdrf7s+gO2+q6p4/pAD6e8dIcHY9GX4qv/WDD
         c8qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781777226; x=1782382026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b3tQM4YZOU4ZmVyeRxXliIy04zyVWMpCicoAHdMKaq0=;
        b=KNssEsfiMMRwu1omYrXbR/eXPolPS6B6uy/f/aE6e4R5HP84xJ7i0DRUPxlJWXgpsw
         MQpJLzqKsB23CxeOo+Hivk2oL/KpFoB0QINQcMAygWe/HTNjK2tGtUATx/TV0406c6sd
         BrizzkYzdPZtKg57CNnzqQGWY+XXE+O4qVxoPN1JwH4KL5UGCrByY7l+7pK1BaZ9ArlU
         uhFZqQP5HhtFOd+Vcvu6iAne92GrRtZ2eXXrF5wPySIm09nO9Sgw5/8amB0j7J95OjlM
         qm8uH5YMbd8sTWk0NJbcGAjMht1HToQIy/fBbqbg7Dvhu/iWlzvHYDQe2DpSCnsrMqEU
         LiiA==
X-Forwarded-Encrypted: i=1; AFNElJ8pqXmtVoWgbdfC9ObmUElm//hlOIAbSEtKrmcwj93v2kuUYCpEv2zQTbNhuPCx7muyEx90ezI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxa8Rpq+Hfjb5rlHZlAnhlLpU2GM98wN9Bqy5fUOVtK9Jtscf0p
	L9nABArY0XIEdFMH8DDrZm684rVERYcQa5Zcns8+2vpSdvULh160XsCgP7i1Yl74pO8OxErb3va
	WEvsBe6l0DCRqeh5fvz1Jja6EdWXRZpg=
X-Gm-Gg: AfdE7ck/2bj6BSIcvC/Jez/8nEY4Kf7UR00gxEKDPW2pgUm95uJuOVBXFt8rC/6xR9r
	yv8/Td6rSCXr4gAZYtefMxCOpLMhXyj3qBStHB4M/0pxE3mfMXpQBPhKXDd+/IU1xfAeTZHQzNf
	ntv0qHfHdzSZPwVJ5jkxcPQxnuUj3SqQJcqZH5xQtwIXITQMYLU6SWuUBLBOv9xygbOvIjrHmwS
	bX5DLFyZCXWnNNMnDWrnjO96OZ1NJfdd1DXFI7KrZq4wgQsU1EAKKNuy7Rr6+J2iVJFk7ey7w==
X-Received: by 2002:ac2:4bd2:0:b0:5ad:4840:fbab with SMTP id
 2adb3069b0e04-5ad50ec7d27mr538117e87.41.1781777226239; Thu, 18 Jun 2026
 03:07:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616135637.1439319-1-qiwenjie@xiaomi.com> <ajLi3nLqyS31Y6J4@google.com>
 <CAGFpFsRfSsBjuhGmXC8_NohcPFEAZncWKFnmbazo5EhrNqCM-A@mail.gmail.com> <0d161878-6602-4bbb-b1db-754f4a37a011@kernel.org>
In-Reply-To: <0d161878-6602-4bbb-b1db-754f4a37a011@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Thu, 18 Jun 2026 18:06:54 +0800
X-Gm-Features: AVVi8CdIYSWPCV4zbTbrh8InJy9-CYEOx6N8eLPWgnHONLZmhfuqM3wGmOWr1FE
Message-ID: <CAGFpFsR9DDYXvad-Q7+ZinqQRPb5KKGP2xTm2a6HbdcrJY+b_g@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: use post-decrement count for cp_wait wakeup
To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, geoo115@gmail.com, yangyongpeng@xiaomi.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Yes. I described the race with a calltrace-style timeline in v7. The
code is
  unchanged from v6.

https://lore.kernel.org/linux-f2fs-devel/20260618100503.2601790-1-qiwenjie@=
xiaomi.com/T/#u

On Thu, Jun 18, 2026 at 5:10=E2=80=AFPM Chao Yu <chao@kernel.org> wrote:
>
> On 6/18/26 11:38, Wenjie Qi wrote:
> >    The race is between dec_page_count() and the later get_pages() check=
:
> >    another CP-data writeback can be submitted after the counter reaches=
 zero
> >    but before get_pages() observes it, so the zero transition may miss =
the
> >    cp_wait wakeup.
>
> Can you describe race condition like below calltrace? which will be easie=
r to
> understand?
>
>      loop device                             umount
>      - worker_thread
>       - loop_process_work
>        - do_req_filebacked
>         - lo_rw_aio
>          - lo_rw_aio_complete
>           - blk_mq_end_request
>            - blk_update_request
>             - f2fs_write_end_io
>              - dec_page_count
>              - folio_end_writeback
>                                              - kill_f2fs_super
>                                               - kill_block_super
>                                                - f2fs_put_super
>                                               : free(sbi)
>             : get_pages(, F2FS_WB_CP_DATA)
>               accessed sbi which is freed
>
> Thanks,
>
> >
> >    v6 also adds dec_page_count_return() and uses it instead of accessin=
g
> >    nr_pages directly.  The wakeup logic is unchanged from v5.
> >
> > https://lore.kernel.org/linux-f2fs-devel/20260618031008.2447279-1-qiwen=
jie@xiaomi.com/T/#u
> >
> > On Thu, Jun 18, 2026 at 2:09=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org=
> wrote:
> >>
> >> On 06/16, Wenjie Qi wrote:
> >>> f2fs_write_end_io() decrements the writeback page counter and then
> >>> reads it again with get_pages() to decide whether the last
> >>> F2FS_WB_CP_DATA completion should wake cp_wait.
> >>>
> >>> Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
> >>> decision is made from the value produced by the decrement itself. Kee=
p
> >>> the existing dec_page_count() path for other writeback counters.
> >>
> >> Is there a race condition to do this? If so, can you describe? And, I =
think
> >> we need a wrapper function instead of calling nr_pages directly.
> >>
> >>>
> >>> Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoin=
t for better performance")
> >>> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
> >>> Cc: stable@vger.kernel.org
> >>> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> >>> ---
> >>>   fs/f2fs/data.c | 12 +++++++-----
> >>>   1 file changed, 7 insertions(+), 5 deletions(-)
> >>>
> >>> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> >>> index d83a21998ec2..58d23eb74ec2 100644
> >>> --- a/fs/f2fs/data.c
> >>> +++ b/fs/f2fs/data.c
> >>> @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
> >>>                if (f2fs_in_warm_node_list(folio))
> >>>                        f2fs_del_fsync_node_entry(sbi, folio);
> >>>
> >>> -             dec_page_count(sbi, type);
> >>> -
> >>>                /*
> >>>                 * we should access sbi before folio_end_writeback() t=
o
> >>>                 * avoid racing w/ kill_f2fs_super()
> >>>                 */
> >>> -             if (type =3D=3D F2FS_WB_CP_DATA && !get_pages(sbi, type=
) &&
> >>> -                             wq_has_sleeper(&sbi->cp_wait))
> >>> -                     wake_up(&sbi->cp_wait);
> >>> +             if (type =3D=3D F2FS_WB_CP_DATA) {
> >>> +                     if (!atomic_dec_return(&sbi->nr_pages[type]) &&
> >>> +                         wq_has_sleeper(&sbi->cp_wait))
> >>> +                             wake_up(&sbi->cp_wait);
> >>> +             } else {
> >>> +                     dec_page_count(sbi, type);
> >>> +             }
> >>>
> >>>                folio_clear_f2fs_gcing(folio);
> >>>                folio_end_writeback(folio);
> >>>
> >>> base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9
> >>> --
> >>> 2.43.0
> >>>
> >>>
> >>>
> >>> _______________________________________________
> >>> Linux-f2fs-devel mailing list
> >>> Linux-f2fs-devel@lists.sourceforge.net
> >>> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
>
