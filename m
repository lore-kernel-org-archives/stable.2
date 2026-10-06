Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CD0E33F8AD
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 03:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791258196; cv=pass; b=BslUDAom1t22e5WLocvLEM7y8SIxXA2AvooeTbcxCTFi4OPeHprHoEGx+Temdxoi2Z/GmC8wWuWeiQrbt7jXA3Bn+L4eFyNRfqgfVBnN7NFkchVr6qBL33WzefyQiSUUYv9Bp076J5eLVG/wocsra3hqwW/W4N6DCS3DMSlX5pk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791258196; c=relaxed/simple;
	bh=TE1M8Xp9r8nWKhc0pgoLmT0J1KG+EsmuYHdJ9qwlb4k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZHc7ZsIX3Osq+jxgBCAEG5ILM/LRHPuzGqjoZREpyrv22Twgm0mkgsXB6cO3N3T6PbmpusINay9l2V1dWRlGt2e+6Pz8B5ZkroaeGunobS4IyCT70Q29H8dw8Ndp3FBs9zOabaJ1jFMU1AbNK8HYqgZ/sS+fSz0NWtTT+ZYHYLU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PDDHg3a2; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PDDHg3a2"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6774639a8a4so2154411d50.0
        for <stable@vger.kernel.org>; Mon, 05 Oct 2026 20:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791258194; cv=none;
        d=google.com; s=arc-20260327;
        b=RwqI0r/afZsDW5YGK3MStdoidjdgQCHO7iMrliFnaVW8ZctLPwTv5u/DcK+VI2EhyT
         jk8Mw1hd7k9jLeKhqw4M9FaNeiwE8nsOJkA3yYTP7nD+ur4Qh9Q9SjydOItCakwvtX4h
         PbthjfU5SfMiGkEDgl/vHjGZMT94rnq/cJnGdqkQKIDyocyZ8riY5NCVtiohfZh8jW+c
         D9Gq34+YGczpM7JqbX1hnuy1lYP4qnDtLuULKFojKeNDWDQ3V+bM0BbkvPuE535YLNRz
         i57LnPiMObOEnqabeE9InvUWO9+lROWu1Fil7ykuR8NKuTF5/aO1GbMpGtVNCFFKGX8j
         E1XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BEXTeQGLzgEVv8xuPTN36lgrQGwcruNuHdFhXGEDQxE=;
        fh=rb/TC9nbyrxoEWudF8Jk7IAg2fZA82IyKo6uLE/HDGY=;
        b=jUSVf0pEUuHCVtSW35RyLRvbSH7wUeNSkPWAMFBpcldIj3WvgLLzD8+FEHswruoQ1S
         EyK8GpFwH5OyHI8K5bbRclEUhkIwB2Kj2ld5vm2gluxH5N2Z7cD/UwXDXcgHIRiMe2/D
         qRA37A1UaGwGAiTyaYLo0fU7gscwNX9ZAu7J1EhByDHM65MES7AqZGSjPSjxPWSH+NW4
         MRZpEZcoyO8MoTJbj5YpATdRYpjeSHZQB8UJAg3w8RGI264yVelNYf8p0PDlfANsFCO/
         KttFmntagCUaAQek8Q5fqcD/ECae9aRSlulTmXTGo+EqTPHamHtgM1ZJgzkC+0xywUFs
         wV1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791258194; x=1791862994; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BEXTeQGLzgEVv8xuPTN36lgrQGwcruNuHdFhXGEDQxE=;
        b=PDDHg3a2LCqs+3XiRwyQt0AVuCeWE893FNKT0ilCYLizGNoF0Ro72mkC4XZ7pZiRGY
         fJUrVp50i0p6gdpkFdWfuutcSlbokOt4n+OoPdfXMr/1jKQB3iIDQz4gotpKFoeyLBJC
         f1wZCI1S6ch9Q0qU0LGW7r8Z589g7lh5Pam02mEIdrEHKdKURfYupRCAP9gWyuU+bDkD
         0+Kj/582bszSJRZMz32uOfB3p37sk/FHyXl71OBivn/+XJaYCtOF/5Up5Ss/qOyvglRq
         zr/ZJRrVMp/CcrlWGaBbwAoKhUPZaCkvuwOgFZSZE4cm4jpJ5nTC8x7ytU0pTATQuwcy
         V1CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791258194; x=1791862994;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BEXTeQGLzgEVv8xuPTN36lgrQGwcruNuHdFhXGEDQxE=;
        b=itvZHZirCG7KE2Blf8ycZ1UCjd0iZ50G2pX1hbhir2MerExVvwpD3Nx4z8nXqpi301
         94Ej64vcGYLXPfk/l0iRuaZtNQQ1TpQ+lVyyRgItDqpB2P93Z/kC0v7da7fb0GltLafo
         k5BxB+Ld8XF+HLCizaGyVT5sauP1YGzoHmr3KUH8ZceCfzxyM7knEFRKGzwIwwnhjoLu
         2bouiWe4W7KXTBMnDeBqOztcaYWp+5Ofh1hGd0pKDIt+ndHIS9xNuSxQqnBs5VyfWIxS
         31U9036KaOqeY2Kv7mgWIQQb4bar/hdPUTlNO+B6FSD+iJECRLwSR14j1tUYnidrNY5j
         A7yQ==
X-Forwarded-Encrypted: i=1; AKwUvByzQQyoftUK9BY33nNzAAijTqj/Y/Q4YZGYVMfDGBP+s5ahQuR48/49Zt+fdbj94RzSQff7NIk=@vger.kernel.org
X-Gm-Message-State: AFq9FYIM9Dl2d6owJEjk6CU6sAL/0UeCiT/DgDsmlnI3kyojrfhi/dS3
	L4+3sxfT2NeW/AWFkHWUDChZEcfRsNr0AgAEN4Z3PzMGSwojHy8Fp4fwtna1t9LPoiA8DI/zO3m
	RgJxdvyQiILH9xo8f882Z4n9pdx4Hpts=
X-Gm-Gg: AYBFou0915F9Sj+a7AuqP3kly0ei8agmgATu8RX/N8qWdWa7e24MYmi74KToJYMEdpe
	1Rr5zlQ894lnM3X1T0uJnl7ocgAvjOeSqGg2ysVzSG/xaHAYS0FJFuCKqgjADkB/uKGEKnzz4B7
	aQkwHLWkxoDflRvM1kYipKYK/WF4fecxb88OiPLPiDv/mKqVcC0JgEEV0feIc4iwQrds5x/TFyC
	vYLjeh4TJpHg0K4LoQbjfngN10dIxkWDTsbjtmMaP+vBjao6MdjVidtmhloh4qgOw4VLRv02gra
	xPCW1ANWK/G4L6kx2dAl4qC65d2Pn+IVm7zI7xbnwHPqSoVTQcy0giDrgMHU754ytYeG
X-Received: by 2002:a05:690e:4145:b0:674:1336:7d5b with SMTP id
 956f58d0204a3-677bd380447mr3369449d50.52.1791258193959; Mon, 05 Oct 2026
 20:43:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261004055712.1293-1-yogeshgaur.83@gmail.com> <32152011-b196-4dc0-ba7e-495f2132ad15@fygo.io>
In-Reply-To: <32152011-b196-4dc0-ba7e-495f2132ad15@fygo.io>
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
Date: Tue, 6 Oct 2026 09:13:03 +0530
X-Gm-Features: AclHuK-etZgMZhRThOtRlbtdP2ce2Ph0ESLyjNgIBlEnFN-xlVATRsrCZ1wzbZg
Message-ID: <CAG6enPwFpBK=VyEPEnw9a26Yg+Gzt0enieHpYvnJz-v7L5ALyw@mail.gmail.com>
Subject: Re: [PATCH] md: don't hand out the array before md_alloc() has added mddev->kobj
To: yukuai@fygo.io
Cc: Song Liu <song@kernel.org>, linux-raid@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Li Nan <magiclinan@didiglobal.com>, 
	Xiao Ni <xiao@kernel.org>, Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>, 
	Logan Gunthorpe <logang@deltatee.com>, syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com, 
	stable@vger.kernel.org, "xiaobai050@gmail.com" <xiaobai050@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 5, 2026 at 10:35=E2=80=AFPM yu kuai <yukuai@fygo.io> wrote:
>
> Hi,
>
> =E5=9C=A8 2026/10/4 13:57, Yogesh Gaur =E5=86=99=E9=81=93:
> > md_alloc() publishes the gendisk before it is done setting the mddev up=
:
> >
> >       disk->private_data =3D mddev;
> >       ...
> >       error =3D add_disk(disk);
> >       if (error)
> >               goto out_put_disk;
> >
> >       kobject_init(&mddev->kobj, &md_ktype);
> >       error =3D kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s=
", "md");
> >
> > add_disk() makes /dev/mdN openable, and md_open() only refuses the open
> > when MD_CLOSING is set.  mddev comes from mddev_alloc() and is zeroed,
> > so anything that gets in between add_disk() and kobject_add() sees an
> > mddev->kobj that has never been through kobject_init() - no ktype, no
> > kref, state_initialized clear.
> >
> > syzbot opens the array in that window and issues ADD_NEW_DISK:
> >
> >    kobject: '(null)' (ffff8880120640f0): is not initialized, yet kobjec=
t_get() is being called.
> >    WARNING: lib/kobject.c:642 at kobject_add_internal+0xea/0xcd0 lib/ko=
bject.c:225
> >     kobject_add_varg lib/kobject.c:374 [inline]
> >     kobject_add+0x163/0x240 lib/kobject.c:426
> >     bind_rdev_to_array+0x80c/0xdd0 drivers/md/md.c:2621
> >     md_add_new_disk+0xe3b/0x1850 drivers/md/md.c:7684
> >     md_ioctl+0x200a/0x2610 drivers/md/md.c:8499
> >
> > bind_rdev_to_array() is not the only way in.  md_run() calls
> > sysfs_create_group(&mddev->kobj, &md_redundancy_group), and
> > internal_create_group() has its own WARN_ON(!kobj->sd), so RUN_ARRAY in
> > the same window warns too.  Guarding the individual callers would mean
> > finding all of them; the window itself is what should not be reachable.
> >
> > Refuse the open until md_alloc() has added the kobject.  mddev->kobj.sd
> > is NULL until kobject_add() creates the directory, and stays set for th=
e
> > rest of the mddev's life: commit ca39f7502425 ("md: fix mddev->kobj
> > lifetime") dropped the explicit kobject_del() and lets the final put do
> > the removal.  md.c already tests mddev->kobj.sd for "is this array
> > published yet" in mddev_unlock() and md_run().
> >
> > This cannot deadlock against add_disk() itself: device_add_disk() only
> > opens the disk to scan partitions when get_capacity(disk) is non-zero,
> > and md_alloc() does not set the capacity - md_run() does, long after.
> >
> > Fixes: ca39f7502425 ("md: fix mddev->kobj lifetime")
> > Reported-by: syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com
> > Closes: https://syzkaller.appspot.com/bug?extid=3D95eeb4ada2349a2170ea
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > ---
> >   drivers/md/md.c | 9 +++++++++
> >   1 file changed, 9 insertions(+)
> >
> > diff --git a/drivers/md/md.c b/drivers/md/md.c
> > index 680b34a63cb3..e3326b78aef7 100644
> > --- a/drivers/md/md.c
> > +++ b/drivers/md/md.c
> > @@ -8610,6 +8610,15 @@ static int md_open(struct gendisk *disk, blk_mod=
e_t mode)
> >       if (test_bit(MD_CLOSING, &mddev->flags))
> >               goto out_unlock;
> >
> > +     /*
> > +      * md_alloc() publishes the gendisk with add_disk() before it has
> > +      * initialised and added mddev->kobj, so an array opened in that =
window
> > +      * would let ioctls reach a kobject that is still all zeroes.  Wa=
it for
> > +      * md_alloc() to finish rather than handing out the device early.
> > +      */
> > +     if (!mddev->kobj.sd)
> > +             goto out_unlock;
> > +
> >       atomic_inc(&mddev->openers);
> >       mutex_unlock(&mddev->open_mutex);
>
> This is the same problem that I already replied in another thread, the sa=
me solution
> with different code.
>
> Re: [PATCH] md: prevent opening an array before its sysfs kobject is
> ready - yu kuai <https://lore.kernel.org/all/a19e3020-272b-4f93-8535-00fa=
07002d91@fygo.io/#t>
>

Thanks Kuai. Yes just refusing the open would be going to move the
race condition. I had missed earlier patch from xiaobai050, sorry for
the duplicate.

I would send a v2 that holds reconfig_mutex from add_disk() through
kobject_add() in md_alloc(), so an ioctl issued in that window waits
instead of failing the open. RUN_ARRAY is covered as well, since
md_run() also uses mddev->kobj and runs under same lock.

Thanks
Yogesh
> >
>
> --
> Thanks,
> Kuai
