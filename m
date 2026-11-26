Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.203
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795658300;
	b=iok1T3cRzCcbNE0ACDCFa4V9OQFkxdJz/Obn7yprYBAceel6VwWW21mmoMnLpAMdRPBY
	 gTjer1G9LdL7iVXyqna4z2hWPRES+SDqAzSMTrfcImuCsil40l1HOsAKyMAwY1tUFwafR
	 Wd/rwmOoMy0E6Jp5w/N1eTvOnQF8u1uVaIR7vmLisxnNAH4yLEweVhgdc5Am7CouzmO7v
	 guA7NvQ5tX2lXr6SNNhvx4rf6dwl1Z5MjkfJC2c9OlyCeVtykYxGHY5WUI2wm9h3iL6Hj
	 K3B38DSTD49dLuAhUUP0RjvYlQU4UsHdxfytTBjcJ/Ooy8JOGouvw0l7MYLIWVCIsKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795658300;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 MIME-Version:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tCGVdvTPZIhAz66YN5IUl8TOqz+MMSQeSPJRIWUDXgM=;
	b=mNuFJFjSrGJqQpew2xJ2w41K0GYtWTl6EXXh7Jx/MgifqJ7QtCOLTH7IMCBz0qbCN/ir
	 h6UgPfmdURLOUj8LSYHRpKOyGiZkc4W23ZQbc8yfwP9Kk9w0XBntG1alz1jLjWRxkAU71
	 MSMz77nIewHJkrdtV7zi6fhJP+XaP8nUS8CWouFkQvpM+opkDL8b3r9DCPt0cS3+cwpnY
	 HGKfBov0JZrMsD7eQkngxr6FRRb0i+9GhZTbCgecHBrxg4fDptZZnSBB5jwrI6W9jjTFf
	 IwxaFuVWLrkrFstORDQVxkWdNjtPSYS6KlCK03ZZQrkpRsFi/qjGpsjalTwaweMpyxg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XT67xCtj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.231.203
Received: from mail-oi2-f11.google.com (mail-oi2-f11.google.com [74.125.231.203])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3BB606A31E
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 01:58:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A3BB606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XT67xCtj
Received: by mail-oi2-f11.google.com with SMTP id 5614622812f47-56820670d00so2192415b6e.0
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:58:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795658299; cv=none;
        d=google.com; s=arc-20260327;
        b=klAKd8YXmY2GiUFfxy8W9kz9HhfgG3E7KVG4T3cyRrfgNjlfyvcfTRcMF0plMeuWeQ
         /VuUmLxa41pnboPRQ4ZSYN308LsctIOsfd2DNTc6Q4CugEhksjjQeASKJzf16mJmkvJM
         kEnNpVevvqOo0cZcOX1z/ASreZHOZklPnoTF0LkN/K5A02RBSfsunzGRLWd4fy49Fo+3
         Q8GDi59ZtWwQfLoxVlUyHpgUWau4L9WXBnsFND7b6kLtYHWXigatv/G6i5Hk4W8nba1E
         gHDhmXwxyUI2VnEGTiMl5lfv206b7qB0XbW/UdFK/Td+2a2plXOjReAyOTVznrb3OT/E
         WXmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:references
         :in-reply-to:from:mime-version:dkim-signature;
        bh=tCGVdvTPZIhAz66YN5IUl8TOqz+MMSQeSPJRIWUDXgM=;
        fh=vpQgmJsmnQu2JmqAm1GZ6qh/9DSLECeFpXtMzIBbd1Q=;
        b=iK9Nk/btov/qnzul3GwOKP3z5YnZmpT+/RH+r6vGnlIX88zClNCFMboj0fXts9DeEt
         xh/vs5UjTDetM0436M+1Wf5LUniNe0HNMxqKp4jixQ1uh/aUnWriqK8ValesWs/hdUUu
         2dMuLI2pyfc5PeCWA9WaE4IAy/2NncvsSCQDtpjjQ7LRaxL5Gy9gGVKQgvyQQ5Tj6P25
         P7306OPkGZhI8PnAUXdSTAYx7e3ctHK+yN25jQl8ylw9yWgZxlSWa9nlbgmFUv7mpIAQ
         yhcQWVJ+ujA1x1JcIBkvkIe8fJRn/3Vt/amKkptm0+8mou8ki/9DOV+U2+5yNd/D3Akh
         qTgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795658299; x=1796263099; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tCGVdvTPZIhAz66YN5IUl8TOqz+MMSQeSPJRIWUDXgM=;
        b=XT67xCtjWsUHkc1pG8y37JSJ+903cIqaAFw5t8re1ijshHaRVgv4BRGuwEj005FGGL
         T65ytF3Sh7pqJ4nN8IJDZNqCujb+O3y5OiL7GffArrV0QB8u1qUi3qWQ8m9avcc2qGIQ
         R3zi2pXZ7P6/p9uyd1N4uVLpqqoZ2Qm5ldzXAv99u7FuWQmh5XKuSU0uvIgcjjSDiCTC
         DBbtjtkBwrdG9QArVN57QxL7DFkC0MFss4OCugOAd23LnfbiwPOApzAEaxYnf9j/zJf0
         R38A0qX7Znr1JmmUnqx9YVS3OpK4qYUEhfcmJrIY3pQ5fz0B8xctJmdFeCDdacqbLTGq
         5KSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795658299; x=1796263099;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:references:in-reply-to:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tCGVdvTPZIhAz66YN5IUl8TOqz+MMSQeSPJRIWUDXgM=;
        b=z0dS17LxCYO+z6mj2E4vaU41/ISZ27EjCuFq4HV0Qvh2C/ItoCOtV8DFcOzhIdP5RU
         YJaAp3Qm4WjN6MDV67VlQOZ7SGWJfNXIVXqByooBgwP3f7KraekUJPZ2EsWwomAlzsZQ
         UkZwR0pJxBHe59DF2gtNrIYZMAGfZaNrowMOl61k0iYFJlsgGdANgKRJJus3KOYdat4k
         r5uCcPfR2ULr82JWNVlrEk6DLbl5UhP9LLlXLI5FS3V2E91zraQTb3PlVyTlOj4nup2V
         Js7KsBhKtQfKfj7tRQEChD8Kgjf6nM5D64QOw44Y7TN9xR91DQoFAmQ/c+Vc/Cry53/o
         WBgw==
X-Forwarded-Encrypted: i=1; AL+hErF5VhEE23cZ1ADpRJo92H3jKgBq2AuqJFb8k6DGMldeErE5PKXXYWsEOYaTreBvS7l16yFZXKM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/FFYAznG9oyq7E28jr9hyHWCE1kWhgEh9XvkoQ97bTCkzj69bo
	fujhatwQfpdJNQCspzXSTz0E5Wld5HKr4+q2ssPJWmVJv6kHWKZVvUHProtSEbAhISERnHbvsex
	98ECD6XVHRkeLDv46kkmYPKYSRMJp3yU=
X-Gm-Gg: AZFdTZdQj1C7DvudhO8qqxjU2cOGpjmTPjjhRgS+28aRG1IZRM7I03BamFdhFVOCUQk
	AUy+bFxpb2Sdfth0lgDrY9KEeEA6FKyDXuX2fW+Jr5fMuQRV8ICrUJzkb7Y5KppO0GajnDpg9AT
	Jm4cBPVxcN0Ym9WapgY4eABk/6kYvY8Dj/Xc6nGt/icBappxENEBGw6H1jkpOkH7GoFodW/ISOy
	Gy7nCoTbzFVSczE0njtXlc5gICFywjP2qQYbgrWU+lXrQMLJvJ+8hXAQfadJTAH4WAdrPhpbWbZ
	bFziNvmZU3jFFKYSp8R6H9l1knzgFXLCBSC2F3U2lz2moU32O8wGCIgtJtaMuKpOpS4Ht7z4ZMz
	X0zHSeBnxJDPJzVTxbRqFjJfD9vbZVDWyUxP+ehqCnnegdjH2meHnwm438ivGfv7BE4zAq7XNiK
	OirAcCAcmJDmZdnefgyqCs7zZJQ3M=
X-Received: by 2002:a05:6808:19a8:b0:564:36f8:ee76 with SMTP id
 5614622812f47-57a06b269d2mr20161076b6e.7.1795658299340; Wed, 25 Nov 2026
 17:58:19 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 25 Nov 2026 20:58:18 -0500
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: Aveline Noir <jm5905938@gmail.com>
In-Reply-To: <be640357-419b-4c78-8d96-3c698424ecd8@redhat.com>
References: <bae41f6fc4114357a8a74c8b958f2bdc.1@linux-foundation.org>
 <awbtZjtII9h1oJ5R@raptor> <CANOyQmGPHrHAzVW70Q8T3AYtzFi3C7jCQdd-QW0rQCPEf=ycyw@mail.gmail.com>
 <awb5agUP80qz8iss@raptor> <be640357-419b-4c78-8d96-3c698424ecd8@redhat.com>
Date: Wed, 25 Nov 2026 20:58:18 -0500
X-Gm-Features: Aa3M54qAXZ6qA4q_sbAfBxVmt8Cb0Xyz8Ds0vdPPeDkPy9UkzqtNX26VGzoRiOY
Message-ID: <CANOyQmHt=Q+JjcDjdkcv2RVzTDtiWZAmiBy8rEyhROmUK-uhEQ@mail.gmail.com>
Subject: Re: [PATCH] lib/test_hmm: invalidate all mirrors on device-private migration
To: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>, 
	Alexandru Elisei <alexandru.elisei@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	Ralph Campbell <rcampbell@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>, 
	Shuah Khan <shuah@kernel.org>, David Hildenbrand <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
	Michal Hocko <mhocko@suse.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Mika,

> As told I will be sending a proper fix for the two fds invalidation case
> as a follow up to my other changes to test.hmm.c

I only ran the selftest that Alexandru mentioned.

Thanks for the clarification! Looking forward to your patch. :)


On Wed, 25 Nov 2026 18:40:12 +0200, Mika Penttil=C3=A4 <mpenttil@redhat.com=
> wrote:
> Hi,
>
> On 11/25/26 17:06, Alexandru Elisei wrote:
> > Hi,
> >
> > On Thu, Nov 26, 2026 at 01:25:41AM +1100, Aveline Noir wrote:
> >> Hi Alex
> >>
> >> On Thu, Nov 26, 2026 at 1:15=E2=80=AFAM Alexandru Elisei
> >> <alexandru.elisei@arm.com> wrote:
> >>
> >>> Might be something on my side? I'll investigate further, but I'm not =
very
> >>> familiar with the code.
> >>
> >> I reproduced the same 0 versus 523264 assertion on x86-64 when the sep=
arate
> >> mm/hmm: account for subpage offsets in device-private PMDs fix was abs=
ent.
> >> With that fix, the test passed. May you check whether it is in your te=
st tree?
> >
> > Indeed, I didn't have the patch in my tree, now the test passes!
> >
> > Tested on a Radxa Orion O6 board (arm64 architecture):
> >
> > Tested-by: Alexandru Elisei <alexandru.elisei@arm.com>
> >
> > Thanks,
> > Alex
> >
> Did you run the full selftest?
>
> Without skipping own invalidations the normal migrate to device test fail=
s
> ( With no skip, migrate_vma_setup()'s invalidation erases the caller's ow=
n entries) :
>
> #  RUN           hmm.hmm_device_private.migrate_fault ...
> # hmm-tests.c:1023:migrate_fault:Expected ret (-2) =3D=3D 0 (0)
> # migrate_fault: Test terminated by assertion
> #          FAIL  hmm.hmm_device_private.migrate_fault
> not ok 14 hmm.hmm_device_private.migrate_fault
>
>
> As told I will be sending a proper fix for the two fds invalidaton case a=
s a follow up to my other changes to test.hmm.c
>
> --Mika
