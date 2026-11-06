Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.58
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793930459;
	b=dn+GsIfcDwZa3sTpjcGj5o1+TGkDkewewPwQ6QK/wLB3675cLA56uX4REM3zIF5yi2SR
	 3rIa735FfCoqns7Kt6HbKPp4kFkgsT5X8Glu6TkeBGZ27kfBLTcMurXRbW8QgZricgUpe
	 xZdez+dJWqwVp1hz1QbWK1Rd20uAfCPfDWq7rMqIEtcNhqpc9LtsDufm6B6No2/GZ7VP7
	 X3YpSz2Ua8wpp6hY2Oj/KLDFpmnZK2ParVXpA1HweLUEZ/F6GOJEqThqMYDzLAUKQ22IK
	 dKyjUcffFn6x5vYOTlBbobwzQg/jQmS4qC7OoyWOn12lk5u9jTCRtcAnoEgMLXS3Tbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793930459;
	h=DMARC-Filter:DKIM-Signature:User-Agent:X-Lms-Return-Path:
	 Mime-Version:To:Message-Id:From:Subject:Content-Transfer-Encoding:
	 Content-Type:References:Received:Reply-To:Cc:X-Original-From:Date:
	 In-Reply-To;
	bh=BzurbRUdgcB5LkEIB7Hn26hUmmq0gClbqcTlXGMVGzw=;
	b=zKUYjuDRvYXNnT0ZPrpb+9z6tARu1lziKi2spDRM2eeTARDrFPI/iUIHesaofQBKs9Ls
	 1lZROaFgxJwXhCpQxgcrNmlUtrzum4z15ovWyQRXt+CyBwxUv1YsMM+EcP4LNHnEloOWU
	 XoVLh/n52aIsSfceJpmu73hVPg+/mFBI3PJcIjmd+ouuQZF1LB/NJKorlExm9wX58AuXv
	 sYm8a7kSxVcUG9f8QMzABzHj8PpahoFiHdp7sfSyyke8VmvkEeJo7nhMQVJdqol9em6m3
	 1KpwfV7ij3lzxDwjH6AhaB585mcGFRvwbKrhDuLIq0KkHbL16H0yHTNoqFkrEtk7bIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fygo.io;
	spf=pass smtp.mailfrom=fygo.io;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=ByicbgQn;
	arc=none smtp.remote-ip=209.127.231.58
Received: from va-2-58.ptr.blmpb.com (va-2-58.ptr.blmpb.com [209.127.231.58])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E488606A330
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 02:00:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E488606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=ByicbgQn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1793930450;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=BzurbRUdgcB5LkEIB7Hn26hUmmq0gClbqcTlXGMVGzw=;
 b=ByicbgQncgOWB8QtXNxPUp/boZqIU+6wT7nej9vW9WnUwlRKJJxXhDyv3AScbpqzJPxpUi
 EVR5W6q/WvqKawJVGIzWbPXKhL6kwEBZ08cmxCnqVhYot8Sz2ByUibbbiNfvwm5UdqkI2j
 y/pnu+FWGgqPOKF7BSnSlHDLpv3mpEdbkY8mo2v0KgMoF3CJ0ZXNKlXUOzjK7uRGr8c73T
 x6jtd0d2FPejJwkPytaoYVNp6dPepnUr8/yUQYrvO6a/LuRoAw1nbDLM0zjoyBwsuJ8G9C
 Uczub1HHhGfKtK3dAgx1GlKM0re8BSWOxMXAB6WL+MHdcDrz2dLyLztsi2ccPg==
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26aed34d1+510b79+vger.kernel.org+yukuai@fygo.io>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
To: "Sanan Hasanov" <sanan.hasanou@gmail.com>, "Song Liu" <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Message-Id: <ab391b73-557c-4eef-ac05-bfa25f9e2d03@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH] md: don't allow changing the personality of a failed array
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
References: <20261019193659.31381-1-sanan.hasanou@gmail.com>
Received: from [192.168.1.104] ([39.182.0.25]) by smtp.larksuite.com with ESMTPS; Fri, 06 Nov 2026 02:00:48 +0000
Reply-To: yukuai@fygo.io
Cc: "Li Nan" <magiclinan@didiglobal.com>, "Xiao Ni" <xiao@kernel.org>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<syzbot+0b672810a475890d3636@syzkaller.appspotmail.com>, 
	"Sanan Hasanov" <sanan.hasanov@ucf.edu>, <stable@vger.kernel.org>
X-Original-From: yu kuai <yukuai@fygo.io>
Date: Fri, 6 Nov 2026 10:00:44 +0800
In-Reply-To: <20261019193659.31381-1-sanan.hasanou@gmail.com>

=E5=9C=A8 2026/10/20 3:36, Sanan Hasanov =E5=86=99=E9=81=93:

> From: Sanan Hasanov<sanan.hasanov@ucf.edu>
>
> level_store() lets userspace switch a running array to another
> personality through the takeover path, and then ignores the return value
> of pers->run(). Takeover is expected to always produce something the new
> personality can run, but that no longer holds for an array that has
> already failed: since commit 57668f0a4cc4 ("raid5: introduce MD_BROKEN"),
> has_failed() treats MD_BROKEN as fatal, so raid5_run() refuses such an
> array. It then frees the new conf and clears mddev->private, while
> level_store() has already installed the raid5 personality and freed the
> old one. The array is left with mddev->pers =3D=3D &raid5_personality and
> mddev->private =3D=3D NULL, and the next operation that reaches the
> personality dereferences NULL:
>
>    md/raid0md0: Disk failure on loop0 detected, failing array.
>    md/raid:md0: not enough operational devices (1/3 failed)
>    md/raid:md0: failed to run raid set.
>    KASAN: null-ptr-deref in range [0x0000000000000060-0x0000000000000067]
>    RIP: 0010:kasan_byte_accessible+0x12/0x30 mm/kasan/generic.c:210
>    Call Trace:
>     spin_lock_irq include/linux/spinlock_rt.h:96 [inline]
>     lock_all_device_hash_locks_irq drivers/md/raid5.c:107 [inline]
>     raid5_quiesce+0xc2/0x8a0 drivers/md/raid5.c
>     __md_stop_writes+0xeb/0x4b0 drivers/md/md.c:7038
>     md_set_readonly+0x330/0x560 drivers/md/md.c:7138
>     array_state_store+0x584/0xe90 drivers/md/md.c:4720
>
> syzbot gets there by failing a member of a raid0 array, which sets
> MD_BROKEN, then writing "raid5" to md/level and "readonly" to
> md/array_state. The same applies to a two-disk raid1 array whose last
> working device has failed: raid1_error() sets MD_BROKEN but leaves
> degraded at 1, so raid5_takeover_raid1() still accepts it.
>
> MD_BROKEN is never cleared while the array is running, and a failed
> array can't be turned into a working one by changing its level. Refuse
> the change up front with -EBUSY, which is also what state_store()
> returns when failing a device leaves the array broken.
>
> Fixes: 57668f0a4cc4 ("raid5: introduce MD_BROKEN")
> Reported-by:syzbot+0b672810a475890d3636@syzkaller.appspotmail.com
> Closes:https://syzkaller.appspot.com/bug?extid=3D0b672810a475890d3636
> Cc:stable@vger.kernel.org
> Signed-off-by: Sanan Hasanov<sanan.hasanov@ucf.edu>
> ---
>   drivers/md/md.c | 6 ++++++
>   1 file changed, 6 insertions(+)
Applied

--=20
Thanks,
Kuai
