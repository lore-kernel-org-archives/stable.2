Received: from va-2-47.ptr.blmpb.com (va-2-47.ptr.blmpb.com [209.127.231.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBC32D2394
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791219945; cv=none; b=Abcp+9drrccR4YYD7KQ8VtZG24CBcfMYfMGqvgpgzSXTmTJayaK/H70j9TRVjJk7UaURSFL3BufRoIjZYQgMEYILkWSNXTdn4uCgkuqiVpa57MiSHrGvgFr6ndJ2dTz4qQERxY97jTeqaN5VRf4OmVSUtoaq4FnWnkOwRESM9UI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791219945; c=relaxed/simple;
	bh=gTDGYud3qlQvuMgHpcsxzMGP41YNywM9yUAqz9pKgn4=;
	h=Subject:Date:In-Reply-To:To:From:References:Cc:Message-Id:
	 Mime-Version:Content-Type; b=hiK5NduMFPtSRkDYsycML2MmA/JosOmWIkys/X70cHMdfcEf+Dgyg336Wtm/deQmphuNpazHoMsvjgndiD2+gop3vSlHb0+zV1ZulBxMbpq+G/3FearlNnMNINecwLbUeCGQB8u241TFSUGcQt/5wdS9ABB6hL//Kvj38wYl+KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=XT8gZwDr; arc=none smtp.client-ip=209.127.231.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="XT8gZwDr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1791219935;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=Z29jxW+KOxNoDRJXAQ3nuu7m9wFd0Uoz/D6C67c5o4A=;
 b=XT8gZwDrDSb1/VPVg7QzsvFqwHu01Tgw0HXrYsZccIb5hhqz75FWxwfANAeFUa3QGhTW6V
 1t9Vzmqxieden4Je2zs64wHu3xvXezfAnITVyLznidXx4R6yDO/OIyd6abr37adK6abDc5
 Wc/76UbR47+y+0lgGj/roJQkMN9lIzKA7xUbkGXvoo1Dbd7DOTBlqRoattj0RQcB6k3Jah
 BBvW/5mN6Pp/2slh6Fy/rFNk3dTuhgSBr958srxRCLk3J9q4Edwwc7fDUEClaaN/8ld+zg
 c8aaOybiD1c3J+wso8Xk1c043P4J6cytzMaszG3s5UHqxpAh1bs3hv8yZyhxZg==
Subject: Re: [PATCH] md: don't hand out the array before md_alloc() has added mddev->kobj
Date: Tue, 6 Oct 2026 01:05:30 +0800
In-Reply-To: <20261004055712.1293-1-yogeshgaur.83@gmail.com>
To: "Yogesh Gaur" <yogeshgaur.83@gmail.com>, "Song Liu" <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Received: from [192.168.1.104] ([39.182.0.177]) by smtp.larksuite.com with ESMTPS; Mon, 05 Oct 2026 17:05:34 +0000
References: <20261004055712.1293-1-yogeshgaur.83@gmail.com>
X-Original-From: yu kuai <yukuai@fygo.io>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Li Nan" <magiclinan@didiglobal.com>, "Xiao Ni" <xiao@kernel.org>, 
	"Christoph Hellwig" <hch@lst.de>, "Hannes Reinecke" <hare@suse.de>, 
	"Logan Gunthorpe" <logang@deltatee.com>, 
	<syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com>, 
	<stable@vger.kernel.org>
Message-Id: <32152011-b196-4dc0-ba7e-495f2132ad15@fygo.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Reply-To: yukuai@fygo.io
X-Lms-Return-Path: <lba+26ac3d8de+634b5e+vger.kernel.org+yukuai@fygo.io>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi,

=E5=9C=A8 2026/10/4 13:57, Yogesh Gaur =E5=86=99=E9=81=93:
> md_alloc() publishes the gendisk before it is done setting the mddev up:
>
> 	disk->private_data =3D mddev;
> 	...
> 	error =3D add_disk(disk);
> 	if (error)
> 		goto out_put_disk;
>
> 	kobject_init(&mddev->kobj, &md_ktype);
> 	error =3D kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "md"=
);
>
> add_disk() makes /dev/mdN openable, and md_open() only refuses the open
> when MD_CLOSING is set.  mddev comes from mddev_alloc() and is zeroed,
> so anything that gets in between add_disk() and kobject_add() sees an
> mddev->kobj that has never been through kobject_init() - no ktype, no
> kref, state_initialized clear.
>
> syzbot opens the array in that window and issues ADD_NEW_DISK:
>
>    kobject: '(null)' (ffff8880120640f0): is not initialized, yet kobject_=
get() is being called.
>    WARNING: lib/kobject.c:642 at kobject_add_internal+0xea/0xcd0 lib/kobj=
ect.c:225
>     kobject_add_varg lib/kobject.c:374 [inline]
>     kobject_add+0x163/0x240 lib/kobject.c:426
>     bind_rdev_to_array+0x80c/0xdd0 drivers/md/md.c:2621
>     md_add_new_disk+0xe3b/0x1850 drivers/md/md.c:7684
>     md_ioctl+0x200a/0x2610 drivers/md/md.c:8499
>
> bind_rdev_to_array() is not the only way in.  md_run() calls
> sysfs_create_group(&mddev->kobj, &md_redundancy_group), and
> internal_create_group() has its own WARN_ON(!kobj->sd), so RUN_ARRAY in
> the same window warns too.  Guarding the individual callers would mean
> finding all of them; the window itself is what should not be reachable.
>
> Refuse the open until md_alloc() has added the kobject.  mddev->kobj.sd
> is NULL until kobject_add() creates the directory, and stays set for the
> rest of the mddev's life: commit ca39f7502425 ("md: fix mddev->kobj
> lifetime") dropped the explicit kobject_del() and lets the final put do
> the removal.  md.c already tests mddev->kobj.sd for "is this array
> published yet" in mddev_unlock() and md_run().
>
> This cannot deadlock against add_disk() itself: device_add_disk() only
> opens the disk to scan partitions when get_capacity(disk) is non-zero,
> and md_alloc() does not set the capacity - md_run() does, long after.
>
> Fixes: ca39f7502425 ("md: fix mddev->kobj lifetime")
> Reported-by: syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D95eeb4ada2349a2170ea
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> ---
>   drivers/md/md.c | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 680b34a63cb3..e3326b78aef7 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -8610,6 +8610,15 @@ static int md_open(struct gendisk *disk, blk_mode_=
t mode)
>   	if (test_bit(MD_CLOSING, &mddev->flags))
>   		goto out_unlock;
>  =20
> +	/*
> +	 * md_alloc() publishes the gendisk with add_disk() before it has
> +	 * initialised and added mddev->kobj, so an array opened in that window
> +	 * would let ioctls reach a kobject that is still all zeroes.  Wait for
> +	 * md_alloc() to finish rather than handing out the device early.
> +	 */
> +	if (!mddev->kobj.sd)
> +		goto out_unlock;
> +
>   	atomic_inc(&mddev->openers);
>   	mutex_unlock(&mddev->open_mutex);

This is the same problem that I already replied in another thread, the same=
 solution
with different code.

Re: [PATCH] md: prevent opening an array before its sysfs kobject is=20
ready - yu kuai <https://lore.kernel.org/all/a19e3020-272b-4f93-8535-00fa07=
002d91@fygo.io/#t>

>  =20

--=20
Thanks,
Kuai
