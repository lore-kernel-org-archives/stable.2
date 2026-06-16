Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C900033439A
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 14:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781618901; cv=pass; b=Oy+wsZl7ZPjshCCpuVDTyEirZpWhl3nKhtboBQZdDPeYJWpUjOwgm6wPdyN8Z8Rg1sC46ib6ebtdls72NSRqTEPhSXiBWvs01MhAW3y7ZjuQo8G2tEQ1rbwebX75IJEBbwZuYUlXhsck+cD42XYOo/m6vqn6ndZGWCxNsD92w+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781618901; c=relaxed/simple;
	bh=c9sd3zzPVZBwa+vSsmFVC7ljmnmwFSek2fXaqLbOUdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQP3FXTA5DGP5bQvi2nxFX998s6M6mDgLKArGqcISJJ5Gw/9Bt7qTbOth8NEol5NX4HmtiKvL8C/fcZczN3dbKvdByNOYWBCmZhkcpYl8ZzOi5yLpS6YzajwuTMV/nVOhcC1U/8XqFN+10Y3mOwwYzhrolJHR+3Flwp3A9my1RM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ISZS/UT9; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISZS/UT9"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5aa6c66e6c5so3051207e87.2
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 07:08:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781618898; cv=none;
        d=google.com; s=arc-20240605;
        b=IdH0HE7xM4vD6BOzG17HarraqLMqQzDslsCIxMe+HwtGtNxnJ2PzHlBRIvYCChaTne
         81+U9L6EhVKFi4eZ86dlOVzwk/nJfAHDdZ0xF3pqnOWjv452ZD3OF536iOFISvUz9zev
         AvJkCfBqUaavRWlcuKJ96XaUMQGsarSwpAsE6/onP053dJchiUzhKcO/k2y1mN6vqpsF
         9Ei71VQO9+hlfxefKRqr0fNZjUD+pwbAPAslRl9VV9bEWqXgiOofrv9dfoVse0yhn3gd
         8Ee99+3RkAMxF8a6NdmYaNc4fvs8dl4NL2EEIWsKyMOXo7mftqlpy+djiaf1cRGTOcJn
         F8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RdIep9P/0cMDZlvaAZGjNOLxN6aqwz4mIiicGIFwB9Y=;
        fh=vtl1JYtRTyOMxfJIM2ihvpycDWXj+xR7Q00hsuL2bwI=;
        b=hYRnmvaZ0NJ+zCo7brQ/whPeHC+xeaKTL17tasS8WD0NMzUHyxbSj+0TMkK1HXQvZd
         ta1vz/QOrb1eUtyZWQjCSkUwvv+i5ROt8JUarmaww6KNtFm8W07WTC/QuaJrDD9yTGz+
         AUSFWfrjc4qXAMl6yyIc90jgMChNm+tBVWlXFFUp5ZUrwEq6hj9+HJTyxKRyoKnMoLtz
         rDRNuF7s6LZRDSMkP2/KHzgtDaqVtEe2PIskh+zig5czecAz6yg1PnVPvZyNqLOPaRwZ
         c6RfNFfocr2hA6CZC/7P2ZGh9ZTm4GqSgmv9MHvvfP+IUKk/kax34TxHsfX/24HmovV5
         lbRA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781618898; x=1782223698; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdIep9P/0cMDZlvaAZGjNOLxN6aqwz4mIiicGIFwB9Y=;
        b=ISZS/UT9YDc/+bYQUW0BNofDFghcrvlUhompcFo0wxRwz8TF7eX7j9g4y0/nuQRTld
         WJzILEx0kwPOIPCur4Qq+ZW/uc6esR/NZ7bBR1tUFLwjEU0LitRWBxvkHU1EpCeure/G
         bVI7ie42L5lbws0jCz9BlY1DJgXmq9wjeesvsd3H3/dQxkhT7+xq2M6MyUSu6xQnMji1
         v8jeM3cnX7vZ1p4oKOFYYHZrj0azDkm5mMWpXNnMZOve/Op+fpBaREetOxTCPM1fjmEz
         6DhQu9QatWhyz8fp7f9R1zwZA9Qbrtc8fJF3pxJmVFKEBTA7rvue3oH/zlECIczrNDiE
         HGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781618898; x=1782223698;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RdIep9P/0cMDZlvaAZGjNOLxN6aqwz4mIiicGIFwB9Y=;
        b=dEI0hCs5dNUW6GimBCzaNUTFinxfzoaiMUstTZe4U/SJDi31URUicCZvDFz0K4H8tY
         fZ+gniI3eu19J/BVZ+ckBV7D5PxK0B0BWfRYzyNqDTV83LzRt9g+1xR1a3rcBCbKuwJI
         IH7H+tcMyA3MLUli6iHJQ0kLo7dHziTwYFIjCWnbke98HIJSlXjI2XKvt2Mn7FVHZVer
         Q29f9GkceTx/8+nTrYfc9rKsYHESkRBgargmQZtwLX2UrTsg9FDFhQDBhUO4SYN+2j9U
         3Ks42kATQTBv76UhYNSDANZABKqKkauoA3MWtnKTDYvLhH/f8IHL6vXdmkDIVNmMCGlJ
         LGxg==
X-Forwarded-Encrypted: i=1; AFNElJ+ag/ibFPAQnXP9hXkRe0XJJZetCinkotyhGk4w+KEG/GSCfZj+nzwkd4jYRIObqUDgePsQqJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzGUXQAcbc9wGQ8MphF2PfhuepPGejmpMf8CDYSWfdXle4bfVx
	5f3dti7urkdWvhWz+BKXU1XkqlNBAaMxoQ2lJoIHCOdnbEEPvyCohjWVWhvkm0zTyLGaBomRc5/
	man2CaGTdZlopYphfFaJxu2W9af9Xg5Y=
X-Gm-Gg: Acq92OG/by62ohAzE2VqDWGDPx0g66fjvjrdXL/nbJyEnYq0leVHWE55t5rMHkBhlPZ
	XCymWckAzx8VyRrI0Fe7IBlJ+Dfe9lkng6Rpi/nqUl4HCLcDpMm7TBGfJO9XH2MZ2MMi5D7gK2D
	WUOIIhJY5H7zYdssRGszxv9DhO5+5VRLmA3JK4rxpDhirsdpIqYj6TudkboLvy+XVbXrywfEht0
	ly1ushqUlOJb+mUcuYjsQPa1I/LW5SsmX83GHriSxNSYPYzSfTVqorOh7P6nJNOg/g9zO9BPtt7
	/wKAvYYu
X-Received: by 2002:ac2:52ab:0:b0:5aa:63ad:77f7 with SMTP id
 2adb3069b0e04-5ad427a8f40mr935731e87.25.1781618897753; Tue, 16 Jun 2026
 07:08:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616033146.127000-1-qiwenjie@xiaomi.com> <bd3d9950-80b9-4099-a088-d2d07fb3092c@kernel.org>
In-Reply-To: <bd3d9950-80b9-4099-a088-d2d07fb3092c@kernel.org>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Tue, 16 Jun 2026 22:08:06 +0800
X-Gm-Features: AVVi8CeTrBPJ5GX0Wqz54GtleJSJIr-WRuVD3gKEmRfbXlAFVniYS90J20nqPw4
Message-ID: <CAGFpFsS_BVVMKgmTVD_Kuihr=VuF3ODrCOmeCe=ZXs5mwrDi8A@mail.gmail.com>
Subject: Re: [PATCH v4] f2fs: use post-decrement count for cp_wait wakeup
To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, geoo115@gmail.com, stable@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
	qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

   Hi Chao,

  I added the missing Fixes tag in v5. The code is unchanged from v4.

  https://lore.kernel.org/linux-f2fs-devel/20260616135637.1439319-1-qiwenji=
e@xiaomi.com/T/#u

  Regards,
  Wenjie


On Tue, Jun 16, 2026 at 11:37=E2=80=AFAM Chao Yu <chao@kernel.org> wrote:
>
> On 6/16/26 11:31, Wenjie Qi wrote:
> > f2fs_write_end_io() decrements the writeback page counter and then
> > reads it again with get_pages() to decide whether the last
> > F2FS_WB_CP_DATA completion should wake cp_wait.
> >
> > Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
> > decision is made from the value produced by the decrement itself. Keep
> > the existing dec_page_count() path for other writeback counters.
> >
> > Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
>
> Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint fo=
r better performance")
> Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
>
> Thanks,
>
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> > ---
> > Changes in v4:
> > - Add Fixes and Cc stable tags.
> >
> >  fs/f2fs/data.c | 12 +++++++-----
> >  1 file changed, 7 insertions(+), 5 deletions(-)
> >
> > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > index d83a21998ec2..58d23eb74ec2 100644
> > --- a/fs/f2fs/data.c
> > +++ b/fs/f2fs/data.c
> > @@ -392,15 +392,17 @@ static void f2fs_write_end_io(struct bio *bio)
> >               if (f2fs_in_warm_node_list(folio))
> >                       f2fs_del_fsync_node_entry(sbi, folio);
> >
> > -             dec_page_count(sbi, type);
> > -
> >               /*
> >                * we should access sbi before folio_end_writeback() to
> >                * avoid racing w/ kill_f2fs_super()
> >                */
> > -             if (type =3D=3D F2FS_WB_CP_DATA && !get_pages(sbi, type) =
&&
> > -                             wq_has_sleeper(&sbi->cp_wait))
> > -                     wake_up(&sbi->cp_wait);
> > +             if (type =3D=3D F2FS_WB_CP_DATA) {
> > +                     if (!atomic_dec_return(&sbi->nr_pages[type]) &&
> > +                         wq_has_sleeper(&sbi->cp_wait))
> > +                             wake_up(&sbi->cp_wait);
> > +             } else {
> > +                     dec_page_count(sbi, type);
> > +             }
> >
> >               folio_clear_f2fs_gcing(folio);
> >               folio_end_writeback(folio);
>
