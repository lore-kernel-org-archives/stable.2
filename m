Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.59
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793674507;
	b=wCGYxDXfS/RcSlV1kOJzaY5X0d1tXfdGb6ArQ8ehMnuYR+9Mrs+ikjLltzoPDl7LxLZC
	 X+oFeHg+dNv7DlmcJ+gjGGrisDwotCPhErF5r1MlNWA09JhJPmaRV2Egdma8FY+05S4L3
	 h/bj+qA2xdZJ7zlUpxmb0sTs6KSpwDWj3tWCuc4gUuvXJe/qenYHUZtfnX9yfTmLL0xYf
	 uT6bw859pqlG9yW+39P50TbpAneBmPHHxrwYhQDnBoPJuE7/iIKblfelRSTYXQLpJdZqz
	 0rjmO7aVyKpmKk4aotJXav6DcP3G3n10XBGcxA4wbVwpMutaef83n2bzkKShb7p9f4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793674507;
	h=DMARC-Filter:DKIM-Signature:Subject:Mime-Version:Received:
	 Content-Type:Cc:In-Reply-To:X-Original-From:User-Agent:Reply-To:
	 References:Content-Transfer-Encoding:To:From:Date:Message-Id:
	 X-Lms-Return-Path;
	bh=gHNVKexvi+2DC2GaCkkB9eH3+bs83qsGXoSScAr4A5A=;
	b=Is7gG7tKvKrLzGFSCeFeCbwqnGTZMrShZkusJpOrwYp03nAd9P9vz2sx39c9kj76aBov
	 SjcRMJMQHcDqs9pUWPjs7JLAj0mSNwiAfCg7WUZRMTPWbT3ejuYKWja4qhp29dnL3sjLO
	 n13Mz/f9tS2yekP1jh88KjqxYdrzxeYwggfR1rv7isx6ZCfKvJSWOr6w/9773UnmClozD
	 NPdBCfWtIm5h1G5iDWz7DM/KkexgY3OwW/co5H6t81oUuzaUtHRkYDzEp1De9OhOWy6+6
	 9jAGbfu6faxyYreozI+Mk5FXI4V5c7nF29BagBehfb41tbvD+aT4SAEva5OQotH2ZPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=fygo.io;
	spf=pass smtp.mailfrom=fygo.io;
	dkim=pass header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b="a/omXujP";
	arc=none smtp.remote-ip=209.127.231.59
Received: from va-2-59.ptr.blmpb.com (va-2-59.ptr.blmpb.com [209.127.231.59])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A156606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 02:55:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5A156606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fygo.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fygo.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=fygo-io.20200929.dkim.larksuite.com header.i=@fygo-io.20200929.dkim.larksuite.com header.a=rsa-sha256 header.s=s1 header.b=a/omXujP
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=s1; d=fygo-io.20200929.dkim.larksuite.com; t=1793674498;
  h=from:subject:mime-version:from:date:message-id:subject:to:cc:
 reply-to:content-type:mime-version:in-reply-to:message-id;
 bh=gHNVKexvi+2DC2GaCkkB9eH3+bs83qsGXoSScAr4A5A=;
 b=a/omXujP/+BmTnJgjSY4xYcMc7qjB3iDvCZ+xEpiTWbVAjg5OS2t39x6THE7VleHpcqpXK
 ZA4kSQ6dJ0doSCF2V3vjHcBtLBWkkcZVI10EI30cQNsRdYRP99S5G6KnxMrji8np0sA/Ba
 xeE0XluN5yZnjxHMxJdSKaAUxGhqvIAwfKABJOX47MYj/Y9kEst2ePKamP30jWXR2GtRdd
 isYa6PWu1/0s4fRJ2Q5HcunbvZHikTgGnoAGSpyJypvH/qCmkQMnI8kwFnxT/NqLTa3E5+
 b0pix8/jOvp3Axq9GN5czUuTL3AAUmgYmuu96KVJVr2UX52s0td7vbDGhwV7Bw==
Subject: Re: [PATCH] md/raid1: Prevent excessively large memory allocations
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Received: from [192.168.1.104] ([39.182.0.25]) by smtp.larksuite.com with ESMTPS; Tue, 03 Nov 2026 02:54:56 +0000
Content-Type: text/plain; charset=UTF-8
Cc: <magiclinan@didiglobal.com>, <xiao@kernel.org>, 
	<linux-raid@vger.kernel.org>, <linux-kernel@vger.kernel.org>, 
	<syzbot+fc26c366038b54261e53@syzkaller.appspotmail.com>, 
	<syzbot+75f49ec552cc74d9d69b@syzkaller.appspotmail.com>, 
	<stable@vger.kernel.org>, <syzkaller-bugs@googlegroups.com>
In-Reply-To: <20261028152755.383821-1-gowtham398gs@gmail.com>
X-Original-From: yu kuai <yukuai@fygo.io>
User-Agent: Mozilla Thunderbird
Reply-To: yukuai@fygo.io
References: <20261028152755.383821-1-gowtham398gs@gmail.com>
Content-Transfer-Encoding: quoted-printable
To: "Gowtham S Bhushan" <gowtham398gs@gmail.com>, <song@kernel.org>, 
	"yu kuai" <yukuai@fygo.io>
From: "yu kuai" <yukuai@fygo.io>
Date: Tue, 3 Nov 2026 10:54:53 +0800
Message-Id: <7135fce3-943f-4e3d-9413-2a4ba962021f@fygo.io>
X-Lms-Return-Path: <lba+26ae94d01+d20be5+vger.kernel.org+yukuai@fygo.io>

Hi,

=E5=9C=A8 2026/10/28 23:27, Gowtham S Bhushan =E5=86=99=E9=81=93:
> Validate mddev->raid_disks before memory allocation to prevent integer
> wrap-around or allocating an unreasonably large chunk of memory that
> exceeds KMALLOC_MAX_SIZE boundaries.
>
> Reported-by: syzbot+75f49ec552cc74d9d69b@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D75f49ec552cc74d9d69b
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Tested-by: syzbot+75f49ec552cc74d9d69b@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Cc: syzkaller-bugs@googlegroups.com
>
> Signed-off-by: Gowtham S Bhushan <gowtham398gs@gmail.com>
> ---
>   drivers/md/raid1.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
>
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index f0646fb24371..88038d535727 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -3050,6 +3050,16 @@ static struct r1conf *setup_conf(struct mddev *mdd=
ev)
>   	struct md_rdev *rdev;
>   	size_t r1bio_size;
>   	int err =3D -ENOMEM;
> +	size_t calculated_size;
> +
> +	/* prevent baseline integer wrap-around anomalies first*/
> +	/* Safely calculate size; overflows automatically saturate to SIZE_MAX =
*/
> +
> +	calculated_size =3D size_add(sizeof(struct r1conf),
> +				   size_mul(mddev->raid_disks, sizeof(struct r1bio)));

This is not the only place, raid1_reshape() has the same memory allocation.

> +
> +	if (mddev->raid_disks <=3D 0 || calculated_size >=3D KMALLOC_MAX_SIZE)
> +		return ERR_PTR(-EINVAL);
>  =20
>   	conf =3D kzalloc_obj(struct r1conf);
>   	if (!conf)

--=20
Thanks,
Kuai
