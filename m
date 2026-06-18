Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D840435E1D9
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 03:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781753947; cv=pass; b=hPsHenwHCOKX79DJ/0KWyn+L1UIBOJ0aMKHI6bd+e743omWx0rFaZZoMOtIQEgWeCtTRfONFY6xtlJWJP3aIJsGBs7Ioz1KJ9JLqqDPbZteJeU9MM1ES6x1wdFg3W1nPcL0hH19NB/ZsDNMl25ayX0DMTCO7ECqlOFRUq3jQvnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781753947; c=relaxed/simple;
	bh=tECTmax46r8pOZwIj9tnn9W17stC2dPd293+J8mrZn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PLQyLwyP07T//BHp8xoSEu7EgHbWgUxJHo8rsfDelzoXpY2alZiiCTlQA8CkL+xtKVg9MAH+JmrUVNakK33QgbCqiDUx5WNxMNxR8MzaB3b+ch6CY66uD1jcNX9ZijFik7N/9VfQTcqIRsXiMuB418XkfSH52oBVoCaA7kJNmZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lGRy8jaW; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lGRy8jaW"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5aa5e0d57e5so364620e87.1
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 20:39:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781753944; cv=none;
        d=google.com; s=arc-20240605;
        b=E1fH5qvWSysbP31sT/oQiYfkio7KI79Q3d39UAXAuRdhN9buODZeHBwqe+wRVUmrdY
         w6ee+JWwV5lrkE019G8IoPMUunfdDsMXZF2Kvx4TwVjltO+34oalQCfRvZqta4CKpwzf
         3rPCCAPkiJZ2NevCkHxLJeVDs7kMfEmPOPdkx+TF/qAyFihgENrROmcOrLXrGrdaev25
         p/zNFpuiBGes0XN1NydORkrzd+4PEi8Q5Hcx72eOWgp1sLc0ZRgQGVwmFsoERNmLovQ7
         94C/lAohTJkP9+dAZegGBLl6JdC4IgW0HOthbY7J6oKYeUIqFfyIRE1dBpmme+uiI4T8
         Czkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/4mOw+yDAuFvZjmWaPS16AJUikWnWazx6iUEAOgniKk=;
        fh=Q9UgxcntFDWuTom4ud5zWUuW77zm5qPLjkTweIkF7OQ=;
        b=HNpvebzox1W9DM3rFZbZJ6SyCqCaQ/7M3ogVBsrEleHU8IrVlOlFHS/bMdVOLBGKxp
         MqQGAbMJuR5gkl50+XVx9yX7c/WuWHcsAmZo7awy2Uf0xfbaBbKLraJFhEirrczb7cWk
         1oq7hG7p4vrUheu42TsRJTcojROrcX52LhcP61cIdWTmZN8XaqwOt5eOsbYS5Oed50e3
         YpboFDTLx7fe8wTWBZbG3i4tVohIWlY68gi84ChaQ0VzHZWpqSDQk2jUhjK8zqhLVqyP
         QZCyMloZrneBQfLC4Rhs1hsfrCESDHV0MysZGkMwiMTGrBIkO5zrRT3+IDlWSTTGLARM
         w//g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781753944; x=1782358744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4mOw+yDAuFvZjmWaPS16AJUikWnWazx6iUEAOgniKk=;
        b=lGRy8jaW+KtDsyWZviyNy9sHQVDPvEGOuEBUhwLrMehLAql1XW+37uD8/RYutcMDQ6
         sOgeJ4SWalfulOPrajKx4U5za9MOQWrhhwgzUwgprmH5oFTA8pAstRqd4hApOQwhL7s1
         wyCQse/U+AypSW3tP4FH7/zRffMYMknRIiOnd6urnFpS6g8HkGaWCcsCBGAla6dyYQot
         a3aXnxAM4Xl6pxcsm3wJwqJZiNrpvgsubJzpNPYF10Q1jkVOs23NifKjngC5sMIxEHVp
         aJAAyZZWYtoaDaBCGEwBJm/G6Ql0ponOE2VjcUjCHWK87iIlx+tgfKgtLd9MVsGJ550q
         BSuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781753944; x=1782358744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/4mOw+yDAuFvZjmWaPS16AJUikWnWazx6iUEAOgniKk=;
        b=jTx+1lOebJRsfgLYXfgnPN9Y1RnCnpVlodLzrnjeMIfJ7bu8exV3pQjx4tsTB8orYB
         lxr+lv3/rbhVUNsPw9+JDYNOzCQqETKb3SCCw8GLuj+LHGxjpzvLQXiIP9iMqUDUwuGl
         ihYFc2e9BQ4Pu7hGJtPww7Mxniao8+PhQ5V0CnCSQyT+V7ce9sKeQlFu6HIF1m6hQt9f
         8qfSKBcNF21V0JW/T8ZAXRegwyvragl1RpJ4DVOjHk6Ps0PuMFqTfqTzy0VEQukkN88j
         b3CGTbMlNaDMYs0Dl+ZB94tSIlJNj7tSLAFIyUyIDRITuN+9vDf9yuvtQSR/ougf0mXJ
         g71A==
X-Forwarded-Encrypted: i=1; AFNElJ+uNb/mP0J65STsSrhMsl3tS7rMeV7/i6LvzunbGGipw6I1t9+4MYxjF1RZBiZV6nd96fyvhWM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJwOoHq2Uddsdf2ik6fA75G5DqiXi9HTJgOmcw6dkGsCHRxQ+Z
	q+oW7whhUwmFFqSSWRC24AtMBPpBww2TNzgzTl0ZRdzIn5Ra/hfNKjU52vXWBF6dzIGQi8XIOWZ
	PezYzeXUYL1L8SxsqtAiTaRo1nyXIy4lwlSLA545izQ==
X-Gm-Gg: AfdE7cmV4gWMXiusPKkEKRmpHKd6A0Ny2ut8NttVWlEGZFkeFownsPu8G6Rae6rREiN
	pnwB7GPs/m6o9GYNbmpLu9z/9S9jsSYKzO2JEifewZaKf6Cb17iknuU1jDBQrJ/Rk/6PdhVuk7v
	NkYTYWm3SdXLEDGlaUwA6B2ZM3D/RJyG/6TQLzV5EYSFF1yoPd7hvT2LZLIMhX0aFlDPWXkgDPP
	VVgy7LbaSau1QQVhr0dhsUooX6udvcOUuuZhPcY/7C5CaeGLtG9pPC/SuJwMLS8ZE/50mcuLg==
X-Received: by 2002:ac2:51ca:0:b0:5aa:719c:a21c with SMTP id
 2adb3069b0e04-5ad47db1520mr1680794e87.20.1781753943777; Wed, 17 Jun 2026
 20:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616135637.1439319-1-qiwenjie@xiaomi.com> <ajLi3nLqyS31Y6J4@google.com>
In-Reply-To: <ajLi3nLqyS31Y6J4@google.com>
From: Wenjie Qi <qwjhust@gmail.com>
Date: Thu, 18 Jun 2026 11:38:52 +0800
X-Gm-Features: AVVi8CcgdoCv5inzD3awJAiF2PsHp7vdlxGgu4pq57dsMZoNd6hxUCzgTuyajF0
Message-ID: <CAGFpFsRfSsBjuhGmXC8_NohcPFEAZncWKFnmbazo5EhrNqCM-A@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: use post-decrement count for cp_wait wakeup
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, geoo115@gmail.com, yangyongpeng@xiaomi.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

  The race is between dec_page_count() and the later get_pages() check:
  another CP-data writeback can be submitted after the counter reaches zero
  but before get_pages() observes it, so the zero transition may miss the
  cp_wait wakeup.

  v6 also adds dec_page_count_return() and uses it instead of accessing
  nr_pages directly.  The wakeup logic is unchanged from v5.

https://lore.kernel.org/linux-f2fs-devel/20260618031008.2447279-1-qiwenjie@=
xiaomi.com/T/#u

On Thu, Jun 18, 2026 at 2:09=E2=80=AFAM Jaegeuk Kim <jaegeuk@kernel.org> wr=
ote:
>
> On 06/16, Wenjie Qi wrote:
> > f2fs_write_end_io() decrements the writeback page counter and then
> > reads it again with get_pages() to decide whether the last
> > F2FS_WB_CP_DATA completion should wake cp_wait.
> >
> > Use atomic_dec_return() for F2FS_WB_CP_DATA completions so the wakeup
> > decision is made from the value produced by the decrement itself. Keep
> > the existing dec_page_count() path for other writeback counters.
>
> Is there a race condition to do this? If so, can you describe? And, I thi=
nk
> we need a wrapper function instead of calling nr_pages directly.
>
> >
> > Fixes: e234088758fc ("f2fs: avoid wait if IO end up when do_checkpoint =
for better performance")
> > Fixes: ce2739e482bc ("f2fs: fix to avoid UAF in f2fs_write_end_io()")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> > ---
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
> >
> > base-commit: c0b65f6129c7fbb526e921dd60261650f1b2bef9
> > --
> > 2.43.0
> >
> >
> >
> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
