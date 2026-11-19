Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795108398;
	b=bi/gzZP4efLfLPrjx7EuIsl/BRCiyS5xiW4mU/NEV6TdbZbMqONXBlXn0REe2QLk9Q04
	 TqSS0uv1mFIRpXawS5aYiZVFISs392QN2VcHWDNpa/BHSlSIY8qKOVT/K3QhvsaRwkUzX
	 DSFfCOeo9zMDnxyzVzQj4Co8VP0ELfEE0UBaZMNwdFy6zcHMtM/bXBuX5CCMHsYHe1my3
	 q9ha6El89d2XwE9T0qZAxr17Q4ThHfk7n23UPjP7qeZFqxGDBtyMjgY3ivc2BUpFwCHLS
	 fndHYrDUInH27hbEnUnE6dkcxp35QeI5gp4Lx72vfSAIEcWEH4JYsUf+aIOinDODk9w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795108398;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=w2EnSjdigFnp2O6d4NnYI+986RpKhw8XyhaQWjzHOYw=;
	b=G8OJx2xcx/qUr9UYWuldMXcMTQGc+o4VWcLK6P4d4OD6+Nu9FxG16TlJ83PytygVZ7Kh
	 z7FPy8nLikXVX+vL933Ox07o/vJhU+5FnftwHBxtRNz54i9M1W4dbGoFCQx+4i4XjCB4s
	 g9MhAQLS1bgPitTNjC6H6zwg4Z/sTQe0VQ1nWFKX/Zw9WJE8WOfIctnlCU1+/YsYg4ed1
	 Tm4zBEZw45v404LIwu9YyUdbCLlq1sgTRwCl0jpp4yjY3Egzz5MQtOZNXWaqOtny3jb2p
	 n5ALfZG1lxSb/JNI3/3vsuz8K5MHZG5GaVM1v7I/0/jvxwq4yU5zHLsStGWLIaxZQ/g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a95DEfaf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.217.42
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE2A606A333
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 17:13:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BE2A606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a95DEfaf
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-7d2da166818so1419766137.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 09:13:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795108397; cv=none;
        d=google.com; s=arc-20260327;
        b=Auzdb1dXE2u6mKoAK2uSTFeXdbFkcgv7m71o/Yi++okmqhE7SR26OJ3VeW99+R6mqg
         PbR77tkxW/OVYl8Fq9ol8+c+kHaxPIVyA/fs660ri7Iy4tUD69odQ+FkYDMvEJLWX/Ug
         AI1TbIaVBHwBX8bMlceSzJfUu65jHI88+hHq/9lHzXfLuFH1jMjHujOBwmKI6f7q1/Cd
         yy0MjZtbt4CoMoCLdhFKV2ZguOa+ye2k1rcRsOS510ZspTMWMWrKpk1sKgHgkhw0yvdw
         sP1lPa+bKf+Kmv722R7VyhfR2U5A1gZAl1EwdfeoIeo/aY6iVBlbgBeiDPgdujticB/f
         LHHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=w2EnSjdigFnp2O6d4NnYI+986RpKhw8XyhaQWjzHOYw=;
        fh=BeRxF5MoWpmUrxGd6A7CBWeUg5/FgR8pe54mjd/iwtA=;
        b=c0lknQsBDnlnSnGnFlB7Qrz+q60jaXA1W9WXHgNxAjQh1WpY873B1y1BFC5Lf79yK2
         6skKq3qeUmQNBJD3+Nht1h6XZLCtrHuQtzZAtjEKLSTCca2ew3Bpra8/arHQOC4FBbJ1
         9YWwCvfZdo3XM1bH4kS2+VeazlcZWHa2hHg4uyAWJhOw+I66PqV5zQBlHEGd4KptZLY2
         rov3dakG7yZi8S3ldeQDjJhx6bGvOyFDwdJodRECE9a4jDujgc+NYobxpdvPgPsFh5Ry
         X2GWEHGxzHJsh5V/4HUZVb9GiSwTKa/sfl+pd5VuSxUNJwS+GWkeK/nQPNfu+NTOTVOn
         pAVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795108397; x=1795713197; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w2EnSjdigFnp2O6d4NnYI+986RpKhw8XyhaQWjzHOYw=;
        b=a95DEfaf41H00JrahzY7J/OxFUh+RpvPFLnD2bhT/kb9/isZuj7SQVofTbV0nRoqJM
         gE/W39r4fHb6MVGMH00YxWnuHwQVI9rUCXdd7/QzfLaEvlj3wLNVSlNXnZARiKR9+CSe
         U5KTtPgOUp85JflcZvfWHMqBTMTYYrAa0JfKizqkV6Ol/a8tOrsyiEW3T1YZgjv51D9b
         CNDohO3QnBXunkt4yW5s6zGnuOUfBcaDsWPDxXpA1Wfn6CHhSWuiEC+VtjhT1THyHwgv
         r4Q0WyMQz/bEEirUW7JJVOBLjb144GNd+RYK0/m6UNCVbumuOWQIkHoDqhJmE7EArW9K
         PeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795108397; x=1795713197;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w2EnSjdigFnp2O6d4NnYI+986RpKhw8XyhaQWjzHOYw=;
        b=1Gs5SeJ0UnSj18O1zgYH7+vc1IXcXr0jUzTpuBDLc+hx6RS+Zp6rbudAWd/ozkhc+x
         Hw2xylvK9F6uHHtM/kkF1gjbw/+SU06pwWf7PNLMMVZtGkXTnk22jwlKlKbIuM2s2Ws5
         EykP223wGrHYtEQIsjkncbgcLVQeP7XY9/ot+xvrKc9n2Ccjc+AG4XgWPdNQfEAWOCBH
         aJbkMxMxfqldyQzotDinyeCE1gNNsIYgDvUiELCMUZoKf6OsysPUSGKMm9hpfhMiq/Ef
         6nMWNh9sBKQ5EaRfCp14Ev8X8zmPhQMqIKIpg7PvBpW6blodxhNHvwhztJj7lcdGjEUN
         DIWA==
X-Forwarded-Encrypted: i=1; AL+hErF/y8s3DzbveMckWCG91GdXdt1zFFPcreuz5J/Ldf4yV5z2mWj7VEEbjqDl/B3Qu25ejndV/Go=@vger.kernel.org
X-Gm-Message-State: APuU4Z/tirUb5+bX+0HsJDmc9VZbc237eF361u1A7FfezFBnAVe4L7NB
	IYT+9Jf31i/4wqs5wwV+sEzK/ijcYpHy8i0BXB1kuCMQC4mlYhyTcJkHqgpblGM9dlddASEs2FJ
	fLBI9RkLw3xvoTKAhCxmVQEEtWYV/3XA=
X-Gm-Gg: AYBFou2ZJ3B4hNttn9Clrb1KZvMoGUajEyKlicTN7giTOh4gOdkEVbg5v34C5/hZZLO
	DkntZn3oWGcCEPu8bFwRfFZ5debTKqKcE0d5zIveUMaxVmxO067+5QnAt2NoxGQBQVpTkg/1qvz
	2gPzc5F/kMgqUVY/0n0KsXc4IAxq2nRG8GaVkoNwTuNop497z9is9hv/m9TwoKuNzdfI6gwAlwN
	JWLAA5pPb8KtS1frXddcPphhE8Q3+E9hCApsq0mwi+1gYOIzuMoaYLLxT0OhlLIxx39dDKUPc2c
	rhaepv6q/KaWYAbtO83wzBIKjLrUfm6ZPwCS0sOGdSmmrIZPjy0dYRFD9K9xc77kZBvhnePKiEr
	oQzyzadaU4P4t6cgFksLcwWyp28KyO2+ieGYJNiaN29wMAT/nXhCjYebiOKO/EbuN5ko71bOi/M
	TyRqNzWuE9S5lL15oX0O6iCZlfXmsFWwB60EePLKuZrskl+5mphasZs3TIAZKX7j4tqW8g5xh9j
	dxQl9Su8IYFlrdjSdeW8G7QJvwKKA==
X-Received: by 2002:a05:6102:508f:b0:7cc:94e0:ad23 with SMTP id
 ada2fe7eead31-7d73967085bmr11341137.31.1795108397165; Thu, 19 Nov 2026
 09:13:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117-submit-nvmem-wp-serialization-v1-v1-1-539d121f8f5e@gmail.com>
 <faiy43d7khj6d3adwhnbdkkq2h2cdg7bue4lpawtzrhv3vsm3f@3372slynbcbc>
In-Reply-To: <faiy43d7khj6d3adwhnbdkkq2h2cdg7bue4lpawtzrhv3vsm3f@3372slynbcbc>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 19 Nov 2026 10:13:05 -0700
X-Gm-Features: Aa3M54rAJ1Mkv9PZFikrBwu2LdRSge9Gu2YTNgX8QQ8FL9Kc05ECu88O9Wlq0uw
Message-ID: <CADvTj4rkBApMzBk0fmKym3iSxqjuGOPiPyTnBGKoVRgYcz_Usg@mail.gmail.com>
Subject: Re: [PATCH] nvmem: keep write protection disabled while writers are active
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Srinivas Kandagatla <srini@kernel.org>, Khouloud Touil <ktouil@baylibre.com>, 
	Linus Walleij <linusw@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 19, 2026 at 6:25=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.or=
g> wrote:
>
> On Tue, Nov 17, 2026 at 03:09:08PM -0700, James Hilliard wrote:
> > The core deasserts the WP GPIO before calling the provider and asserts
> > it again on return. Two concurrent writes can both deassert WP before
> > the first one finishes. That writer then protects the device while the
> > other is still writing or waiting for the provider lock.
> >
> > Count active writers per device under a mutex. Only the first writer
> > deasserts WP and only the last one restores it, including on provider
> > errors. Keep the mutex outside the provider callback so providers that
> > forward writes to another NVMEM device can still nest.
> >
> > Fixes: 2a127da461a9 ("nvmem: add support for the write-protect pin")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/r/sashiko-outbox-219526@kernel.org/
> > Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> > ---
>
> This adds a mutex where there was previously none in nvmem core.
> Synchronization was left to the underlying providers.
>
> Can we not use atomic ops and avoid the mutex? I'm talking about
> something like:

There's a race on the first write as well. The first writer can
increment the count from 0 to 1 and be preempted before it deasserts
WP. A second writer then sees a nonzero count, skips the GPIO call
and enters the provider's write callback while WP is still asserted.

>
>         if (atomic_fetch_inc(nvmem->wp_cnt) =3D=3D 0)
>                 gpiod_set_value_cansleep(nvmem->wp_gpio, 0);
>
>         if (atomic_dec_return(nvmem->wp_cnt) =3D=3D 0)
>                 gpiod_set_value_cansleep(nvmem->wp_gpio, 1);
>
> The only problem here is when we put the last reference, start setting
> the value to 1 to enable WP, while another writer bumps it back up and
> we drive WP pin back low. But then we expect the GPIO chip driver to
> handle synchronization in this case.

The GPIO driver can serialize both calls and still execute them in
the wrong order. If the last writer drops the count to zero and is
preempted, a new writer can deassert WP and start writing. The old
writer can then resume and assert WP in the middle of that write.

The mutex keeps the count change and the GPIO transition together.
It's released before calling the provider, so it doesn't serialize
the writes themselves.

>
> Bart
