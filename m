Received: from va-2-50.ptr.blmpb.com (va-2-50.ptr.blmpb.com [209.127.231.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C853F39A7E0
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 03:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791518360; cv=none; b=t8KnOMBUiVuAW8GzMRj2tcOQWMVnPG+TAtaSy57JXYgtswWbYdZ08xfBiJdXbWePXku3mjm7TeoFqbTCBei92V0rPg7NDA3/dsSoJnStvJm3rQvmA1Sn5xXpGPPbDdUqqyVJuyMdfhz0ftcUjp0LCFG30ntdb7LXrmd7YVfxxE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791518360; c=relaxed/simple;
	bh=S3YX/IofUpGzMaHVjbZ3i/7v3orPrOdkbg+atX82QFM=;
	h=To:From:Subject:Message-Id:Cc:Date:Mime-Version:In-Reply-To:
	 References:Content-Type; b=qMAwPEJQU0AWrA+VaOgwcTQkuMreMLc8mdiGtte9p6lSR+cH5affuc8eCOO4K2XgUjbW9d1W6KzAILckn40ZT5TEBCjPi/Rz6v9yShXhkPP5YW1616A/0c5X2xRNxy35MvgsNTdc71ILuY7VFZ/KbBS7fX7eedNpBvUkG1rd+Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io; spf=pass smtp.mailfrom=fygo.io; dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b=JiMSmTTs; arc=none smtp.client-ip=209.127.231.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.b="JiMSmTTs"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1791518337;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=9ioF2CxfmybnWpl7CBEF+vseKEEUSR0omAyejznNhFM=;
 b=JiMSmTTsiLz4bKcLryrud0k5yHd0SBd6BN5HdJLAVuu1J1YGfJt3UwtP9LuCc3T1rsUM6n
 RDWw/VutWjmTb84UJHGEcXLQthsC6deD68S0A/6S+0b6LKiMcS1xlqzShTf/4YCGVGnh1B
 g4D2rCQ/tYRFb5PnFceJBzFmFdeRmyoUgtQh0CO2TMKuPThoA0r+MvR9pshD8IpwqIRJmD
 EZGCq/gr8pdrfyet7wXZFEVjFn0FXDJNDHYOwIjwViUeyXMYd3hXhYCSyhEf5ergGncLDL
 a18+wMBEF1A2C7LBqNqgM6oAy0/DBsMIS0N5N2GlfEFF5XYQaPE0s+yAcM/SmQ==
To: "Yogesh Gaur" <yogeshgaur.83@gmail.com>, "Song Liu" <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH v2] md: don't hand out the array before md_alloc() has added mddev->kobj
Message-Id: <ef73044f-592d-4bcb-9f0a-f1b45fd8b3cf@fygo.io>
X-Lms-Return-Path: <lba+26ac86680+8e4a9c+vger.kernel.org+yukuai@fygo.io>
Cc: <linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Li Nan" <magiclinan@didiglobal.com>, "Xiao Ni" <xiao@kernel.org>, 
	"Christoph Hellwig" <hch@lst.de>, "Hannes Reinecke" <hare@suse.de>, 
	"Logan Gunthorpe" <logang@deltatee.com>, 
	<syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com>, 
	<stable@vger.kernel.org>
Date: Fri, 9 Oct 2026 11:58:52 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Original-From: yu kuai <yukuai@fygo.io>
In-Reply-To: <20261006122904.1538-1-yogeshgaur.83@gmail.com>
Received: from [192.168.1.104] ([39.182.0.35]) by smtp.larksuite.com with ESMTPS; Fri, 09 Oct 2026 03:58:56 +0000
Content-Transfer-Encoding: quoted-printable
References: <20261004055712.1293-1-yogeshgaur.83@gmail.com/> <20261006122904.1538-1-yogeshgaur.83@gmail.com>
Reply-To: yukuai@fygo.io
User-Agent: Mozilla Thunderbird
Content-Type: text/plain; charset=UTF-8

Hi,

=E5=9C=A8 2026/10/6 20:29, Yogesh Gaur =E5=86=99=E9=81=93:
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
> add_disk() makes /dev/mdN openable.  mddev comes from mddev_alloc() and
> is zeroed, so anything that gets in between add_disk() and kobject_add()
> sees an mddev->kobj that has never been through kobject_init() - no
> ktype, no kref, state_initialized clear.
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
> the same window warns too.
>
> Every ioctl that can reach mddev->kobj runs under reconfig_mutex, so
> hold it across add_disk() and kobject_add().  An ioctl issued in the
> window now waits for md_alloc() to finish instead of seeing a
> half-built mddev, and opening the array still succeeds.  The ioctls
> md_ioctl() serves without the mutex only read array state and return
> -ENODEV on an array with no disks.
>
> Hoisting kobject_init() above add_disk() is not an option: commit
> ca39f7502425 ("md: fix mddev->kobj lifetime") moved it below add_disk()
> so that md_alloc()'s error paths, which free the mddev directly, never
> see an initialised kobject.
>
> Fixes: ca39f7502425 ("md: fix mddev->kobj lifetime")
> Reported-by: syzbot+95eeb4ada2349a2170ea@syzkaller.appspotmail.com

Reported-by should always follow with a link to the report, and the followi=
ng
tag and applied:

Closes: https://lore.kernel.org/all/6aaf3284.514bccd6.255447.0003.GAE@googl=
e.com/

> Suggested-by: Yu Kuai <yukuai@fygo.io>
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
> ---
> v2: Hold reconfig_mutex across add_disk() and kobject_add() instead of
>      refusing the open in md_open(), per Yu Kuai's review: v1 made an
>      open that raced with md_alloc() fail.
> v1: https://lore.kernel.org/all/20261004055712.1293-1-yogeshgaur.83@gmail=
.com/
>
> Built with W=3D1 only, fix has not been runtime-tested.
>
>   drivers/md/md.c | 12 +++++++++++-
>   1 file changed, 11 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 67108c397c5a..85439f27d943 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -5906,12 +5906,22 @@ struct mddev *md_alloc(dev_t dev, char *name)
>  =20
>   	disk->events |=3D DISK_EVENT_MEDIA_CHANGE;
>   	mddev->gendisk =3D disk;
> +
> +	/*
> +	 * add_disk() makes the array openable before mddev->kobj exists.
> +	 * Hold reconfig_mutex until kobject_add() is done so that ioctls
> +	 * issued in between wait instead of using an uninitialised kobj.
> +	 */
> +	mddev_lock_nointr(mddev);
>   	error =3D add_disk(disk);
> -	if (error)
> +	if (error) {
> +		mddev_unlock(mddev);
>   		goto out_put_disk;
> +	}
>  =20
>   	kobject_init(&mddev->kobj, &md_ktype);
>   	error =3D kobject_add(&mddev->kobj, &disk_to_dev(disk)->kobj, "%s", "m=
d");
> +	mddev_unlock(mddev);
>   	if (error) {
>   		/*
>   		 * The disk is already live at this point.  Clear the hold flag

--=20
Thanks,
Kuai
