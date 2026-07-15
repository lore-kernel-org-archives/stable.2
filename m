Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C945E175A9C
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 07:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101631; cv=pass; b=uJQx7lMSMNbRvxwNSVp4q68/gDotvvOQKEwrT4xMFLOj+KlWttUVPnizvy6eEk/1LugbtUyLc6wAbxZ4eLTryHcUntge7eJr0Z6F2ZHDEevG50R5wdQkH3JZd2tsyeGbynJnvgIVCcTiq15/NzGMqh4B66M+BjyPJvXLF9/uv4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101631; c=relaxed/simple;
	bh=y90jrUPYV7VSItBgSnQL8zxeBIn0uXVf/uDq6vYc25w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ovweneRqh9VgcXkLVrnaaCqu1mJrQjZUV61xKk3Q6vuAEwQu6J8lnTkHDgkGwQ3NSGTWowjHZP/27uMv/GFf1NtypJ//7TqmlC/wolgMSOhAZue0qohGLim5+VSN7NtXZJqVMgN7T2b4qmIU5IoLvyEdsW+G4FI1IClpQ7eD6IE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTAPJs+g; arc=pass smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTAPJs+g"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-69c7697d523so159182a12.2
        for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:47:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784101628; cv=none;
        d=google.com; s=arc-20260327;
        b=M13v156AHaLTRmc5tzkAA1FNDRHp9h9JnR4U7NXDHUW6DTnJohD7ISw9pZA16Jee2Q
         TC8hwn15eeWf4CpIIuQPgCFUHL2FAhDTNHQN32kZ/fHr5hf7J5SjJBG4pEeV0PiO79/I
         h2xohLTNW1MtGX7r+cAisWQsG6bAd2nxy06Gk8vYDmiHxRBQfBKVr5pbwK7GEH6Rg07G
         KNmW8eUU+zFnPPNTY0LXZLCSiGFIAtjCNKIOgj540i9shd8kvUOswCixNvAe6wgZ1cDS
         GN66v2OElO2vrnG9wssTtQWyq+e8sBwN9Y/gdSCdb9Z800qMHHl5Orgzlr4VFDjPgT1s
         sbLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=19lysSLEJkW4bBAksrp078nL+0xZ4dvwgENtO60H8WA=;
        fh=gWxgyxRbKpMlna+u24nmrCEkgPENjMqTPfVudetIJBs=;
        b=bhLoD2Kx3rdjPCpr+BV7jTj21dfttHRuF+iHcNvVcLI2CbeREP8E8eKHV/6rTdmvC0
         SnkHHNptlrbUdpOTftUbsCirxcn52Yac6Eq/bLk7OyqPHKV4PhCq06nN7lx6wVOZaALb
         JZSR1WUClXSlwDfS/b7CQnDYdbs6pdv0JO3ByCVLzrvQbCIPwS4PtIo4Dh6Vvq57wt+b
         0gPX+YZTAnefdu1xmvGlMotAO4mi9kORJcScVEezMyHsLIKhh5mI2khrtVL/ncDara0E
         gbXpwG8mHG/Zpv9PIXJvDYPhKIyWC39AZO1sny9n5HfztxlchFFrTb1zoVoWx+T1imyV
         CnGw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784101628; x=1784706428; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=19lysSLEJkW4bBAksrp078nL+0xZ4dvwgENtO60H8WA=;
        b=DTAPJs+g5cqZGxR4L6YRTKuUKYh8pdCTGWCSciuGNhOeoQdrlcTpYNWj1ko1WE/5ay
         KjhWe9N2KuDyXQFnIseexuxDvCbqydrfnm5qGh1cGfaPayYxbovHPAFOxvf1dQ1/XvNf
         P69PyXKjs7Y4LMm/gaz/4YbJXXh3l5ZDamA0ORKOBCmjRt2iQ8kM/+gWWiSB/Lb5BjqI
         xNYcEShjfx7Tt94Odw6FSWAJ+H1fVKeIZVCm0mVTyUEYM8qUnOiVLVxnNDH/1AAFiUZ6
         YzpfGA/65sVtTuujRZyIrksa8E5ACB5iJ9uHWMV5sD/If5aZE0PWo0UiNmHPJ/6OQ63b
         49FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101628; x=1784706428;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=19lysSLEJkW4bBAksrp078nL+0xZ4dvwgENtO60H8WA=;
        b=FPe1bI28oMb7aZ4XGwsme5tZysCMxzjbWE9jC7ZwofxtAUX5FFunX/TdDQQHU7X2P+
         wERrf5Ro+ZozunAQk2kAZoxAH7b4ItHgySNx4GAwgzf4eynAQN+XgrLQB6wOqUQPqlx4
         3m2ft3Q7xc3NRLkJF7q/K6duvIm/BP8lTvYsOO/cgOD96umP9OcEKIMvkcUZmJVegifq
         nAEpLeYyHHvqh5/cI0hFyxqGI+3bCV8IPD0S2hISFq0l0+uja8hRkXby4AbFLRa5RDTA
         VeMLb0Y9QYyA3OkccPuofb4vHmsrVZFa9UrGmK+QdGLzTG5dU748Xt2DJeNsSH5wwp89
         RFCg==
X-Gm-Message-State: AOJu0YxgcDDeU4s5GCdYLm06qwNZhONckP27xka4O972k0YsubNQCP2S
	TLD7I1t+fQy9n/I1hR+Zsb4/ODHXpBCFCpzUVh7Zx2b15BISXfWBZFT62apjLx+pK0Ch8w/oKMt
	sapa5iSImCoMPV7vOyDpFDdzjecqJGcQ=
X-Gm-Gg: AfdE7cnWmcFiLX0a/X7jLFIOR0uoJ2DY/YUnbQZ8PdYwdSF9z/zPc2tS8ao8Uc0/8YS
	fmr6mUepMgdmyt0RfSzbHm1BQUwmp6QAcP1+80PwnV1onV1t+1uxsmpGcklO4OybWLeblNkSHrV
	ddnycjUOhJcaGu15/mDwHV4eHWz+O3U6yIku83rKz70JkL1+txC8nbDUTJ4D6Eu3xQbKN68Nln1
	xIQEpATmAcojnUgWT1LUqvxOT//tU2hoEHwc5G5qIA7ZNiNuq+IgPkIxzU1mTuNrp2v2uv+dA==
X-Received: by 2002:a05:6402:1e8c:b0:683:e394:cc0c with SMTP id
 4fb4d7f45d1cf-69c5ef84424mr8324594a12.4.1784101627942; Wed, 15 Jul 2026
 00:47:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACd_6n3dExLLL8fziY0ha+nDupfb+q45VCbjA7aAYNnj-YkY8g@mail.gmail.com>
 <2026071548-remember-handling-8672@gregkh>
In-Reply-To: <2026071548-remember-handling-8672@gregkh>
From: Chao S <coshi036@gmail.com>
Date: Wed, 15 Jul 2026 03:46:55 -0400
X-Gm-Features: AUfX_mzd5bCVpP5cy92lLa1bEKO7dne8_ZKrsJCeQfokyW36NQwyechjO6PjBtI
Message-ID: <CACd_6n2igietLgJAN=Z_u-qbkQULXzUY0uHWGL_mcLPYW6gKiQ@mail.gmail.com>
Subject: Re: Please backport 49f06cff50a4 ("block: skip sync_blockdev() on
 surprise removal in bdev_mark_dead()") to 6.6.y, 6.12.y, 6.18.y
To: Greg KH <greg@kroah.com>
Cc: stable@vger.kernel.org, Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Greg,

Thanks for your email. Sure, working on it.

Best,
Chao Shi

On Wed, Jul 15, 2026 at 12:48=E2=80=AFAM Greg KH <greg@kroah.com> wrote:
>
> On Tue, Jul 14, 2026 at 05:20:19PM -0400, Chao S wrote:
> > Hi stable team,
> >
> > Please consider the following mainline commit for the stable trees:
> >
> >   commit 49f06cff50a4ccf3b7a1a662ceb892b3b21a527a
> >   Author: Chao Shi <coshi036@gmail.com>
> >   "block: skip sync_blockdev() on surprise removal in bdev_mark_dead()"
> >
> > Why it should be applied:
> > On surprise removal (@surprise =3D=3D true) the device is already gone,=
 but the
> > bare block-device path in bdev_mark_dead() (no ->mark_dead holder op) c=
alls
> > sync_blockdev() unconditionally. It can then hang forever in
> > folio_wait_writeback() waiting on writeback that can never complete. We=
 hit
> > this via nvme_reset_work()'s "I/O queues lost" path
> > (nvme_mark_namespaces_dead -> blk_mark_disk_dead -> bdev_mark_dead(bdev=
, true)),
> > which wedges the reset worker and every task serialized behind it -- an
> > unrecoverable hung-task/DoS (multiple tasks blocked >120s, reproduced s=
everal
> > times under fuzzing). The fix simply skips the futile sync on surprise =
removal,
> > matching fs_bdev_mark_dead(); invalidate_bdev() still runs and orderly =
removal
> > is unchanged.
> >
> > Affected versions:
> >   Fixes: d8530de5a6e8 ("block: call into the file system for bdev_mark_=
dead")
> > which first shipped in v6.6 (it dropped the pre-existing !surprise guar=
d from
> > the bare-bdev path). So the bug is present in v6.6 through the fix.
> > v7.0+ already
> > carries the fix, and pre-6.6 trees still have the original guard, so
> > this is only
> > needed for the 6.6.y, 6.12.y and 6.18.y stable trees.
> >
> > The change is a self-contained one-line guard (plus a comment) in
> > bdev_mark_dead()
> > and should cherry-pick cleanly onto all three; happy to send adjusted b=
ackports
> > if any tree conflicts.
>
> We need a 6.6.y backport as it does not apply cleanly there.
>
> thanks,
>
> greg k-h
