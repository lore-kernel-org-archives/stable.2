Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C552F99B8
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 06:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781762730; cv=pass; b=DZN2g5b00Vhlmd2yqOfVXUMYYajdvEKl2nF6TeL5lFvKsV9nsFdg90h9QfRnFITmNcL1ZY8fXFpjMjqFqQe+7tvhIc7N+eGQd6WBhol47KPQVPr15hH2l3HxiYXT+C621YHMvCAwZ9r8aaCJtxvhiwr9GaZNyUbBHKDfKZFy+kc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781762730; c=relaxed/simple;
	bh=Tx9BTR94Ubwp8M3rnuGD9HRzcODmfxoI1z/NMtqxE7c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S4vkdabPWPzbd+UH6dQ6piLJ3M+KgwkkhzqYSccbo/ZjMjF+bVdF5bkvuTYD386Kbnhewzo4eiSdN4I+LEjnr0jCKldMpvnbx0TjiTSbRKvm9KqCXpTsqxqsUXDGT7GQdanblbqXIbDn9YeYS0bWOR81TGxS9qe/TPS0AYLN1FU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndJYP+YI; arc=pass smtp.client-ip=74.125.82.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndJYP+YI"
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-30bf854d5feso273444eec.0
        for <stable@vger.kernel.org>; Wed, 17 Jun 2026 23:05:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781762728; cv=none;
        d=google.com; s=arc-20240605;
        b=ANEunQIWXBJlBAUL49ziDZOAApGVTRc/PE3yRwM8MbLNeegakega6KKiaE3++gBHAE
         33RAsLl113wzoa0rdJ9MTiAxBVAmO3Y04kcV6+ti9lGAow84B/NiF6Dt700ryTzPYEP7
         xS+YglPAtmtP5KMThDPog+m9vire+cfni4r+bPYo03OM8h+DG+TouC37aFjA9NHUBoXO
         w6XR6a4I8GWUvh5J6MOJCF5HRPxJsdhQnqovyrhfYrYXuUYNbUxMapkpq5Y7pfB5Lhv2
         RKGKazmFp4kYQF9ok872N42Xn2NhgZBd6FD4ikgWOitfl1+xOaDrLF52kivabAbQ41Zh
         KDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=aJOsNUD9iDpleZjGvR/ke/hr60F3TsVEaiWUdbuG6nk=;
        fh=+PQVLTuuO+jSvX6v+OcWWVNQsrpvzrQ01D5Mb+sBGkc=;
        b=JnsnWAmGQDkb0ypfA7B4XdIMnFMpBQcc4BuALnX7HVTErV/cJw/I1k05/5Rcd+VKqP
         DyXDokW2E5UYfA9oC3Hk4fXZd8LDtyypAPLUoKymTGN0rkYFOdBCc6Eykcz2X1qa4xHl
         cfLbO9kHMMyT8NCfoTyvqm5EEbbrHEqBeC+9+eXyUXDAt8wy3Ilg4w9B99g2ZBS/hKub
         CJq3Aix/e4RD/SX1Ule60zbCCo3tJiAN0lPLPpq7sMoitbZPK5FbS0ATe5GcyydKgHdw
         nD+eeQpN/P5aoZvOwbIE8Ooj+qdT4ROZ9ixHh9KfeilgmQa1RTeJ3DY9sz/ZcJ1meSZu
         Awyw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781762728; x=1782367528; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aJOsNUD9iDpleZjGvR/ke/hr60F3TsVEaiWUdbuG6nk=;
        b=ndJYP+YIx+8NElYhIhjMnf64X6S1oI+gPW5/Y3GY49U0+fcY+2P6KMsPDDeTsvUR3d
         hGjK/UAy+C0i9mBLNMNmt4GZWYalxZBtFytX1aUC8s78ewdR5zXRb+sRp/N4noo9akkT
         w+lpWUGocuSZH8nYWLRrQsxenvTBvEklf3azgV9iEmssrhPKJ+Aqg/veeuTcQY/oAL7N
         zdfv7CVPMvTZAB2O7By2DIsjNAJPiaNRnkqV01DLzcmgk9eQ/MeN9138CqZrR1ZFdbt7
         pSfC4Wz62qIec3Rel+ttDIfs7OlJEjwwkj7SNfsPwBurFBwF+Ad2Hd0SbCFSwpEj5He0
         zcjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781762728; x=1782367528;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aJOsNUD9iDpleZjGvR/ke/hr60F3TsVEaiWUdbuG6nk=;
        b=LRhlnoIXNDGNvlzC88YwHbdv7GscV51y2a8VrZui9uYH/v9PyW/0F4U/eCeis1QELM
         ZQY7M7K8RDkSDRNJNDz90an+Prv3vu942MGPR5Y10NO3gasUDYhBkgjEFnu4hozQMJZg
         kyUjtB+ZlFISUSXnnroJFDW4Ec3J9SX/+4JK5LygqO7cj4hoyJc0ljWNdSQqqQy0nDij
         85gtogRZHvxkkfZs4KZlpER2pkDHR1f0+Yc4mMnL4i4rwkTTQBcSjiLcHCs3t5CQE9eU
         XH+75GwST9R83twe71a2rzRV7w/l/97LUncK24WFL3yXdkdn2rSQuWaTD+EWBU5eehgx
         GlrQ==
X-Forwarded-Encrypted: i=1; AFNElJ+fqHoZ6c1bmv21d0yVhIGIQEQpp7VYw9AvQ3UPvn8mnQ8GGfo/T91DjhigSYC1/eAXoJiltqg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj7qKNUY2DECdauK2gyLg/oJbXMC7To5DG+CK9XLK97JqCVXKZ
	5+/Be++G7veNHtBZfze3a4GXyZUi9FKAS7a9rcyKfAu3UPa4FsSVL78WIgdNO78bXzttn888vno
	W3V26DkVD16golEZEgSGrScuTm9oALr8=
X-Gm-Gg: AfdE7cnO6szoopyiZFYjUH9kauVTO2Myv6SieZFr8m7d4bLOazhnxV/RvMRY738yats
	77CydOJz12aNH89KV0wuHRzUs95ttZbMwN1CdZjIASv0MaFAYGpoLY8wnX4JwyqoRVC1A8uM8LV
	1LJsj+Jn1wGM9trmkqCliS9t383G8WtstHj08Yg5kX9cTUH9VqFKZytC5i7FM17tEB6wLBxzOtR
	RBxbCdMTSafcS9Kqxn8uC1+CFqi2igKqyCrfCH76VSIQL2COw/2WyBwDIS5sKU+J4Ip2QSsIfkQ
	tAGQWtO9EDLQd42xZGP1IXTrGRuRlxf1zYeJbQp9A/4h26fJgXc65N695dcSyO/tuuKnnAZOhBB
	XlYjwrS8AvYIbOLyJ5vabAWPLAUcm3lWMz6TrPRGY1OqlH9oVBcmifM3jneZ1m6B44h+y7dcLrG
	wV9ylP18Oq
X-Received: by 2002:a05:7301:100b:b0:304:886b:b07a with SMTP id
 5a478bee46e88-30bf078f1f1mr1575257eec.14.1781762727979; Wed, 17 Jun 2026
 23:05:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260616145109.744539446@linuxfoundation.org> <f33dcd2f-787d-4705-9272-394e1d560ae0@googlemail.com>
 <CADo9pHhAQHGsEB5i4R1GDeAqRubRb-oaUgMjTrk0y-Oc_8U5EA@mail.gmail.com>
In-Reply-To: <CADo9pHhAQHGsEB5i4R1GDeAqRubRb-oaUgMjTrk0y-Oc_8U5EA@mail.gmail.com>
From: Luna Jernberg <droidbittin@gmail.com>
Date: Thu, 18 Jun 2026 08:05:14 +0200
X-Gm-Features: AVVi8CfSbVlzNaaeCW0Sq4vNDheQukQjggWo9S4RjMX8OAuinKPoUeiP85GZR7E
Message-ID: <CADo9pHg4gEE7zNU=goiNjANpLuO1CgZ6RvNLk8kdUyBaBNsDiA@mail.gmail.com>
Subject: Re: [PATCH 7.0 000/378] 7.0.13-rc1 review
To: Peter Schneider <pschneider1968@googlemail.com>, Luna Jernberg <droidbittin@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	patches@lists.linux.dev, linux-kernel@vger.kernel.org, 
	torvalds@linux-foundation.org, akpm@linux-foundation.org, linux@roeck-us.net, 
	shuah@kernel.org, patches@kernelci.org, lkft-triage@lists.linaro.org, 
	pavel@nabladev.com, jonathanh@nvidia.com, f.fainelli@gmail.com, 
	sudipm.mukherjee@gmail.com, rwarsow@gmx.de, conor@kernel.org, 
	hargar@microsoft.com, broonie@kernel.org, achill@achill.org, 
	sr@sladewatkins.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested on a *


Den tors 18 juni 2026 kl 08:04 skrev Luna Jernberg <droidbittin@gmail.com>:
>
> Work a Dell Micro 3050 with Intel(R) Core(TM) i5-6500T CPU @ 2.50GHz
> and Arch Linux
>
> Tested-by: Luna Jernberg <droidbittin@gmail.com>
>
> Den ons 17 juni 2026 kl 21:13 skrev Peter Schneider
> <pschneider1968@googlemail.com>:
> >
> > Am 16.06.2026 um 16:53 schrieb Greg Kroah-Hartman:
> > > This is the start of the stable review cycle for the 7.0.13 release.
> > > There are 378 patches in this series, all will be posted as a respons=
e
> > > to this one.  If anyone has any issues with these being applied, plea=
se
> > > let me know.
> >
> > Builds, boots and works on my 2-socket Ivy Bridge Xeon E5-2697 v2 serve=
r. No dmesg oddities or regressions found.
> >
> > Tested-by: Peter Schneider <pschneider1968@googlemail.com>
> >
> >
> > Beste Gr=C3=BC=C3=9Fe,
> > Peter Schneider
> >
> > --
> > Climb the mountain not to plant your flag, but to embrace the challenge=
,
> > enjoy the air and behold the view. Climb it so you can see the world,
> > not so the world can see you.                    -- David McCullough Jr=
.
> >
> > OpenPGP:  0xA3828BD796CCE11A8CADE8866E3A92C92C3FF244
> > Download: https://www.peters-netzplatz.de/download/pschneider1968_pub.a=
sc
> > https://keys.mailvelope.com/pks/lookup?op=3Dget&search=3Dpschneider1968=
@googlemail.com
> > https://keys.mailvelope.com/pks/lookup?op=3Dget&search=3Dpschneider1968=
@gmail.com
> >
