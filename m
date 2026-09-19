Received: from mail-pz2-f42.google.com (mail-pz2-f42.google.com [74.125.228.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF49038DC78
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 17:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789837946; cv=pass; b=J/E0ZxANKpXSoavulrQx39dhgNK5fssEbj6e7f/Vx71m9FnzKM+66Tg/MhaUp02Cw7rqmRMoLUTr4QpNvOnKk3AY4XWRuSLRt0RVvnroGt433m5T4R1lMK5/k8yUfhs7/GrWGxs5nXEKUrfOEcf5UL5syahEginwADBlS+1Gb5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789837946; c=relaxed/simple;
	bh=cRaq2vEhqIJg0D3zpc578gLi83aQfa/KOMz4IOlLK0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CVjWbXm8K0pNDAXfdi3jfgQMYm9PuSt0SdZ5r4sGvnWIMMsi0j98cc6nQg5G5lvDkUECZtCRAz1cZhfZe5ys8G9Gh44p5isZc9GjXv2LK0GFIE7OM65D5sK4mgjPVwDHvA6+uY6gNg1fNz1Kp9pq7Ozpc8nMYnX2lMtNwo6A5gQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kh9xk6aw; arc=pass smtp.client-ip=74.125.228.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh9xk6aw"
Received: by mail-pz2-f42.google.com with SMTP id 41be03b00d2f7-cc1cea34ef4so1951659a12.3
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 10:12:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789837943; cv=none;
        d=google.com; s=arc-20260327;
        b=g3Qm3mYXpwajLjujRYNfnT3FoTW+oDo8Tp8GPnREMIdp9F6MQEBuFx7m22Qj5Yq3NL
         tvXO6Gl4BpKLSdVh/t9Kb3iKA5lKxnsCAsLxfTeKrVogf/dWGUJ/YE7eIyMU6h/S2mqb
         gfw3KzJzEXLyozvg//EFpHeN2C2g1RHEz8eUn6e8IQ/q/UAs5WN5kEX3entRkFzz3poD
         fiJHvIxm9t37Ojy+rFwOXoJ9egn199z6RPo3iTVR7m9icaNE2kNdHHqh7HXnjKpntGRA
         cTJRYX+SqPKV/mAhkadpacQ9kMuaNvR5eBpvCpKokDhbdOxpHHBWwgIREfNiOPYFHWwI
         lP0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Zkr+gHgVsQMqSsPQMn8TPthwWqA+8VwSm0BAWBHSiiY=;
        fh=wr+cS6NkzIt7JlnSQVUWwrRITpqBJuUBHUzTlsmkWhU=;
        b=SAsQ/IygjhxEK8JT8TMn42lpqCCneJh9n+G/V4TbxyyfUUwpY4M7fSRKd1f2EOvVUc
         SSQzfW3ve3OBzc4YF2OojlQNifrXhCPtp6S7E6nJoGXq2YKAuhQiCf8btmiuNLV3lqL+
         3WXdTQSiB0A9VDNd6ACkyZ+Bxc69P7Vf0M9MmYYI20yxNHEmvlNhzDqYDX/RsnFtK7bR
         6n239Jg2VaDRyGWfYnzlGOy79p3V6+DHWpgpp7vFPHvGtj8QgtQ2guwdOE0MrAKPU6Bp
         j0+emE2zwQvSLKi0F674LjNO6UoNmZ22bRijy9VMqMtV2+3iyW3Za76Pr2u2eU1bNUnx
         AHUg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789837943; x=1790442743; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Zkr+gHgVsQMqSsPQMn8TPthwWqA+8VwSm0BAWBHSiiY=;
        b=Kh9xk6awMQdz/8fQhuFSrok2nK81H6OrPbcIibZpn+r7sy24SnOoEsjB7QCWFnSPLq
         0hsa+zwOFL6D2aA+5asofouYIgWpq3QrTPw7Yymat0O3NAdBvGD++XKhDoNZJ/dAkZCZ
         YdjsxwjheA0viSEQ4w3tJfXGSZdvOW31TcdTP2dEdn2m/0an9w+Z+ScnIuGx3xHk1b3T
         FOSc3ORg+Mox1cPRl8dRuTup5NNpvd9aodGG/lDBm30VcUmCkTxLnwRweMhFEnBKTSaM
         02BVD26LyLdVlbwOARZD3BIvwI64aCaFySSiwGnbnlypdnnhdmd1Olfpc8BwrZtIYuWJ
         CMaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789837943; x=1790442743;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Zkr+gHgVsQMqSsPQMn8TPthwWqA+8VwSm0BAWBHSiiY=;
        b=mdGQmJaoObWSHoDaAsaHbYCY67vyk3IofladZ5qB42BaRJ5nmE71+AHkv0IXqF1KFg
         k43h9efXdZlLiYBXzeemq3hFnzvpqoDccdYnr53HshW012Z1rhU1SXH8gG2jeuQqHbDH
         IbUeTQUief2YD/5GG0BEsLw2+NFC0fGG/xuo0GNdcjOKfI1lGzywL6zOEEDqbBEWwUpD
         u2+Ko0DfezXRqACajXKKDeBLMI3jLr0MinNraAtdVxDHJ1DBkSv6K9sI5lFapwJ2eek9
         QHQyPo62IYX3dxhAWiB+dxGIK0ANWvL0Sj1j3d6C2eiOdQgwbAdXTyyRhIAIEmwY07Bn
         zDLg==
X-Forwarded-Encrypted: i=1; AKwUvBzXXuXLyM/yQ8yHFZVtXLdXzJsl5szgnpzz9Vjc/uVG0w3jH9+9tWHH5/XjTPKv6u3p+LzeGM0=@vger.kernel.org
X-Gm-Message-State: AFuF++kZ9XifwIQ6thEJ/vSPzK6mdC1fGlokHkW4AuEYiKuL0ByHmTqT
	JE+0ADjAtqcoZmkKoA+D8cPmIsG31o0Etn9aX5LPNf9vxS+rcr9Fw/Bx+vHdskZzO3tcutqPO9L
	3SDVlhH8Pr4Gk8UneekVCh8vTvbMeOyWE2ING
X-Gm-Gg: AYBFou2fUt0rnALgLaq9DRpXUpS0GS0AWNGJugPMSTJ3BgRO8jeRtxV2+zYqjHWMUpp
	yG8hZ06Pnwg3FPpz0fUVCvZjFOhcCZfvMN4Mn/FOFvJa27dBbnmoKQpoGrQzJK7N3KWnDt53LX/
	B4ziqn376ikB+xtV+8ToWg+fQszt93+1FIh3To8tE9pxdl35GTRb/K16pC2Vj6yEaCE4BzvRAHu
	yz5PDk2PWKxS8p7S2x1xykP6D2G49zqPtfrpOew36yGXHA4+Jy873zNJ3wIkA5YPidTrsj8WM00
	+551uQeUMiEr1T3pJmXAvBNYKrpSFAyNroVF4mnVu1wEcA9nG4D8QsSk0hG/vX5ID2f54949k6W
	RSbXlncU4j21h
X-Received: by 2002:a05:6300:6d86:20b0:3dd:a197:edfb with SMTP id
 adf61e73a8af0-3dda197f7f5mr2879544637.74.1789837942974; Sat, 19 Sep 2026
 10:12:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260919162709.314464-1-ngocthang2710.1999@gmail.com> <20260919170212.GE1124359@killaraus.ideasonboard.com>
In-Reply-To: <20260919170212.GE1124359@killaraus.ideasonboard.com>
From: =?UTF-8?B?Tmfhu41jIFRo4bqvbmcgTmd1eeG7hW4=?= <ngocthang2710.1999@gmail.com>
Date: Sun, 20 Sep 2026 00:12:11 +0700
X-Gm-Features: AcwNN1W-B3cTpGZCyYckGIVLyhbtuqqArj7ZLsBYFmrIcOznLZNL1MJHrookzjk
Message-ID: <CANfSzAtc0O0qfa0GmzdpnuT6Dn0sxGjhfpW333asYS=Le553sg@mail.gmail.com>
Subject: Re: [PATCH] media: v4l2-subdev: fix NULL deref in subdev_open()
 racing with unbind
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+74de6401dbdd377b5746@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Laurent,

Fair point. The patch only narrows the window: sd can still be
unregistered right after the mdev check, before internal_ops->open() runs,
so the race between v4l2_open() and v4l2_device_unregister_subdev() is not
actually closed.

What I see (syzbot repro, vimc bind/unbind vs. open of /dev/v4l-subdevN):
v4l2_device_unregister_subdev() clears sd->v4l2_dev and the entity's mdev
before video_unregister_device() on the node, while v4l2_open() only checks
video_is_registered() without any lock held across fops->open().

How would you prefer this to be fixed? For example:
  a) unregister the devnode first in v4l2_device_unregister_subdev(),
     and make open/unregister mutually exclusive somehow, or
  b) something else you have in mind.

Happy to rework it and test with the reproducer.

Thanks,
Nguyen Ngoc Thang

V=C3=A0o CN, 20 thg 9, 2026 va=CC=80o lu=CC=81c 00:02 Laurent Pinchart
<laurent.pinchart@ideasonboard.com> =C4=91=C3=A3 vi=E1=BA=BFt:
>
> On Sat, Sep 19, 2026 at 11:27:09PM +0700, Nguyen Ngoc Thang wrote:
> > subdev_open() dereferences sd->v4l2_dev->mdev and then
> > sd->entity.graph_obj.mdev->dev->driver->owner. v4l2_open() only checks
> > that the node is still registered, while
> > v4l2_device_unregister_subdev() clears sd->v4l2_dev and the entity's md=
ev
> > before it unregisters the node. Opening a sub-device node while the
> > driver is being unbound (e.g. vimc through sysfs) can therefore see a
> > NULL entity mdev, or a NULL dev->driver once remove() has finished, and
> > oops:
> >
> >   Oops: general protection fault, probably for non-canonical address 0x=
dffffc0000000000
> >   KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007=
]
> >   RIP: 0010:subdev_open+0x193/0x510 drivers/media/v4l2-core/v4l2-subdev=
.c:115
> >   Call Trace:
> >    v4l2_open+0x1d2/0x490 drivers/media/v4l2-core/v4l2-dev.c:433
> >    chrdev_open+0x234/0x6a0 fs/char_dev.c:411
> >
> > Read the entity's mdev once and treat NULL as "no media device". Take
> > the driver module reference under device_lock(), which is what unbind
> > holds while it clears dev->driver, and fail with -ENODEV if the driver
> > is already gone.
> >
> > Reported-by: syzbot+74de6401dbdd377b5746@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D74de6401dbdd377b5746
> > Fixes: 218bf10e39ed ("media: v4l2-subdev: handle module refcounting her=
e")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Nguyen Ngoc Thang <ngocthang2710.1999@gmail.com>
> > ---
> > Root cause
> >   v4l2_open() checks video_is_registered() and then calls subdev_open()=
.
> >   v4l2_device_unregister_subdev() clears sd->v4l2_dev and the entity's
> >   graph_obj.mdev *before* video_unregister_device() on the node, so an =
open
> >   in that window sees a NULL mdev. After remove() returns, dev->driver =
is
> >   also NULL. subdev_open() dereferences both unchecked (v4l2-subdev.c:1=
15).
> >
> > Fix
> >   Snapshot entity mdev once (NULL =3D=3D no media device), and take the=
 driver
> >   module reference under device_lock(dev), the lock unbind holds while =
it
> >   clears dev->driver; return -ENODEV if the driver is gone. Errors go
> >   through the existing "err" label.
> >
> > Testing (QEMU x86_64, KASAN, vimc built in, syzbot's C reproducer:
> > 16 threads opening /dev/v4l-subdevN vs. one thread doing vimc bind/unbi=
nd,
> > vivid.n_devs=3D1 to avoid minor exhaustion at boot):
> >   before: 32 x "RIP: subdev_open+0x193/0x510" GPF (same as syzbot repor=
t)
> >   after : 0 oopses, 0 KASAN reports, reproducer runs to completion
> >   (checked with 1 ms and 30 ms bind/unbind period)
> >
> > Unrelated finding (not addressed here)
> >   If the sub-device node registration in vimc_probe() fails (e.g.
> >   "videodev: could not get a free minor"), the error path in
> >   vimc_register_devices() frees the entities and then
> >   v4l2_device_unregister() hits a slab-use-after-free. Easy to trigger
> >   with the same reproducer if minors are exhausted. I'll look at it
> >   separately.
> >
> >  drivers/media/v4l2-core/v4l2-subdev.c | 20 ++++++++++++++------
> >  1 file changed, 14 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2=
-core/v4l2-subdev.c
> > index e9f81b9be9e2..cec63694a658 100644
> > --- a/drivers/media/v4l2-core/v4l2-subdev.c
> > +++ b/drivers/media/v4l2-core/v4l2-subdev.c
> > @@ -97,6 +97,7 @@ static int subdev_open(struct file *file)
> >       struct video_device *vdev =3D video_devdata(file);
> >       struct v4l2_subdev *sd =3D vdev_to_v4l2_subdev(vdev);
> >       struct v4l2_subdev_fh *subdev_fh;
> > +     struct media_device *mdev;
> >       int ret;
> >
> >       subdev_fh =3D kzalloc_obj(*subdev_fh);
> > @@ -112,15 +113,22 @@ static int subdev_open(struct file *file)
> >       v4l2_fh_init(&subdev_fh->vfh, vdev);
> >       v4l2_fh_add(&subdev_fh->vfh, file);
> >
> > -     if (sd->v4l2_dev->mdev && sd->entity.graph_obj.mdev->dev) {
> > -             struct module *owner;
> > +     /* Unregistration clears the entity's mdev without waiting for op=
en. */
> > +     mdev =3D READ_ONCE(sd->entity.graph_obj.mdev);
> > +     if (mdev && mdev->dev) {
> > +             struct device *dev =3D mdev->dev;
> >
> > -             owner =3D sd->entity.graph_obj.mdev->dev->driver->owner;
> > -             if (!try_module_get(owner)) {
> > +             /* Unbind clears dev->driver under the device lock. */
> > +             device_lock(dev);
> > +             if (!dev->driver)
> > +                     ret =3D -ENODEV;
> > +             else if (!try_module_get(dev->driver->owner))
> >                       ret =3D -EBUSY;
> > +             else
> > +                     subdev_fh->owner =3D dev->driver->owner;
> > +             device_unlock(dev);
> > +             if (ret)
> >                       goto err;
> > -             }
> > -             subdev_fh->owner =3D owner;
> >       }
>
> This seems the kind of completely wrong fix that would be generated by
> an LLM.
>
> >
> >       if (sd->internal_ops && sd->internal_ops->open) {
>
> --
> Regards,
>
> Laurent Pinchart
