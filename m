Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794107683;
	b=RUbP8rp1PHUJ+X30/bhLgezZRqhDUvZGph3ZoZlaIXg+YJLY3b9hdlrRnCUFc/pm+oc2
	 ybZo8dmKovDHR4Yt8q88GgNWooh45YP0IQeY8vzhOsyTTiuXo9hAnRAQ1Up9CrkkovkML
	 GhZOXTP7zoRm7Q1iq2Rt9338l05c9USnpR5/neNo2oBE/920wVGwawQJd8onibhXSAr5n
	 EWxQVAw09Sk2fopx/6eUWS2p5wyl+1LGyurhacZZ/Q6hlL9++dzQeVQUvzEb+BukgDdpE
	 7i/0AhM3l53TeYgeJU6dPQFgEhaq9MV6r1ISFFFwr+ryKxUhTMFMhOaXzuNTeI2A7zA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794107683;
	h=DMARC-Filter:DKIM-Signature:From:Subject:Date:Message-Id:
	 Content-Transfer-Encoding:User-Agent:X-Lms-Return-Path:Reply-To:
	 In-Reply-To:Content-Type:Cc:References:To:Received:X-Original-From:
	 Mime-Version;
	bh=fcS+F/Hy4XJGS8BMwI2LBnJgUZYL/GRgOXKaCNVoxGg=;
	b=Q+y1saQPDMTNv/uqxRRHqWlzPSHNGShP3tX9US7fkScWx5ns6mzA0x2OauJqhg2XoWvB
	 YCGR6uA3CQ+EWJvpe3qIXR7hxMjsLyQ54QL1LvXFyDTKQ+YHqDMfB7fe4phDd98NJuejL
	 +H9Z5P2B9tFjxemttOAaGbH5jIEQt0WkrWPd7t9gVYv8fEAqUMijZH0e8oLVxsXcm1bZ/
	 ELXbpDgZNow/sE9wDZIGv1fCQY6/o6yybMTt8q03WsxZjDdlXDba8oySkAWee+dRfAR3v
	 dKuFwoNu6RTzabiDC9dQLsQiHljY3vBbMx0ZwxKPYhBul1g43jIMStRgoWE2D4Ja49Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fygo.io;
	spf=pass smtp.mailfrom=fygo.io;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=IxRHXbZG;
	arc=none smtp.remote-ip=209.127.231.45
Received: from va-2-45.ptr.blmpb.com (va-2-45.ptr.blmpb.com [209.127.231.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2433D606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 03:14:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2433D606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=IxRHXbZG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1794107677;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=fcS+F/Hy4XJGS8BMwI2LBnJgUZYL/GRgOXKaCNVoxGg=;
 b=IxRHXbZGh+1id8PTP8BIT6IgkHYzMw/1YLqNIEvCOwe6X6UOGwrDlqrKYZZgeuvyu5UA8C
 YGGy9vn923TAV1ZfYrCVGocdn/6RD7mLZQsfvu0s0PVgNuvwDsGtJkbLVAWiedBVy9cyxF
 tPMCwyde4PzKdEEh2w3uq3uzNG9xHRvD5Hp/vT2uCkCXsMFX4p/faouCIOrGuwkDG3jwrK
 M8EUg+Uj0QZGWI3tok8UjfZfq1ko4XiG1dQ0Ext3PFcyNqRsSfaaUwUKE20P+/hdGihokW
 /05Swqiqwzk7B0OKSYEhjhD/rutrR2e9scQQr99lWLAh3peSfU24Q/H6JZqBvQ==
From: "yu kuai" <yukuai@fygo.io>
Subject: Re: [PATCH] md: fix NULL dereference of pers in md_start_sync()
Date: Sun, 8 Nov 2026 11:14:32 +0800
Message-Id: <71ac878d-1b05-410f-9cce-66264560427e@fygo.io>
Content-Transfer-Encoding: quoted-printable
User-Agent: Mozilla Thunderbird
X-Lms-Return-Path: <lba+26aefe91c+89c303+vger.kernel.org+yukuai@fygo.io>
Reply-To: yukuai@fygo.io
In-Reply-To: <20261106083543.249267-1-dayou5941@163.com>
Content-Type: text/plain; charset=UTF-8
Cc: <magiclinan@didiglobal.com>, <xiao@kernel.org>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	"Li Youhong" <liyouhong@kylinos.cn>, 
	<syzbot+a53c2918175b36cfd601@syzkaller.appspotmail.com>, 
	<stable@vger.kernel.org>
References: <20261106083543.249267-1-dayou5941@163.com>
To: "Li Youhong" <dayou5941@163.com>, <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
Received: from [192.168.1.104] ([39.182.0.55]) by smtp.larksuite.com with ESMTPS; Sun, 08 Nov 2026 03:14:36 +0000
X-Original-From: yu kuai <yukuai@fygo.io>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0

Hi,

=E5=9C=A8 2026/11/6 16:35, Li Youhong =E5=86=99=E9=81=93:
> From: Li Youhong <liyouhong@kylinos.cn>
>
> md_start_sync() is queued on md_misc_wq to start resync or to
> manage spare disks. On a read-only array it calls
> remove_and_add_spares(), which ends up in remove_spares() and
> invokes pers->hot_remove_disk.
>
> md_start_sync() does not check whether mddev->pers is still
> valid before using it. dm-raid stops the array through
> md_stop(), which clears pers. If the queued work then runs,
> remove_spares() dereferences pers->hot_remove_disk and crashes.
> The read-write path has the same exposure in
> md_choose_sync_action().
>
> Return via not_running if pers is already gone.
>
> Fixes: db5e653d7c9f ("md: delay choosing sync action to md_start_sync()")
> Reported-by: syzbot+a53c2918175b36cfd601@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da53c2918175b36cfd601
> Cc: stable@vger.kernel.org
> Signed-off-by: Li Youhong <liyouhong@kylinos.cn>
> ---
>   drivers/md/md.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/md/md.c b/drivers/md/md.c
> index 680b34a63cb3..b7e162f52408 100644
> --- a/drivers/md/md.c
> +++ b/drivers/md/md.c
> @@ -10286,6 +10286,13 @@ static void md_start_sync(struct work_struct *ws=
)
>   		noio_flags =3D memalloc_noio_save();
>   	}
>  =20
> +	/*
> +	 * md_stop() clears pers. This work may have been queued earlier and
> +	 * can run after that, so pers may already be NULL here.
> +	 */
> +	if (!mddev->pers)
> +		goto not_running;

The plain NULL checking is not a correct fix, as md_start_sync() should not=
 be running
after md_stop(), I think the root cause is that dm-raid is missing a call l=
ike
stop_sync_thread() to flush the sync_work.

> +
>   	if (!md_is_rdwr(mddev)) {
>   		/*
>   		 * On a read-only array we can:

--=20
Thanks,
Kuai
