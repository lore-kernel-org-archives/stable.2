Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795094649;
	b=aMIrmrVhUVaLIv+9fhf8IXpHV/Py0lZUoCYpka4Wmbzq+K4lJQtv0lPCflMs4cMymn6/
	 5FRXgfaQnc0tmYVtCKLnEgPK7S8Qg+NjMZQpiImcsHhD/sPw/hKNDdtUoJr223GqeXX1H
	 sTgFGKn/2dWNCjD+dvDvi/sus0fuHp8FmYkZpgpLh4cWTvut3Ym+wSB+9mq7iktgN8xUh
	 RA3Og7qTZdglfFHaeEcka6dZIdl7O9H8EJ6KZDKhT0bB5auq0lKcx+BvGH2Cxi+EETys7
	 izdPBtG57XKorMFdkxUG0IcyJ9atMX71BFkHQN/dCIpzEDVPmYcCdloMkla/ux72x7Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mc3A7vlsW7JssIN0XeC96WxSi0wSNBfvSMrsmA7bSqs=;
	b=bP3iyXJPCnERhlbxiLKE6lZEucVIzijnuiY7sfchu74orfZ+tHQpZ5XKaHTMV483l64U
	 ly0Qpy8wgWMy6FVOeR1datXBjR2coEAqRjEzpHMr07BekU/FhsEcOIBZTZfuPGM7piw8R
	 d7UK87uRfMrwKsFNhegHaiY6IO0I3RLFObUR7Q0vk6k27EgGYSudkOWzf4XlUV00FhNb7
	 jWsvKLOOVQXxVFe6cRK8yQGJgNkoG8yav1nz9ECbiyvVXYN9U2IZ6K4cIKsQavdjNLr0E
	 r61D4bIZjuVnoAgU+IZOv5pa+O72fpYc4BGgL6lSh42vg+JB+aGpgmyid+sRBoZ4C1w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohQxkIHb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF360A2611
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:24:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2BF360A2611
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ohQxkIHb
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-380b40312e2so6072525eec.1
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:24:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795094648; cv=none;
        d=google.com; s=arc-20260327;
        b=OnFEuGY2XCRGGcKfjEU5O1ZmhBaMjQ/r5stK+BPpwk6zHVj034Qh0bNukKoudSGutj
         Wb/vUDYG5x6DeSkrwZqFIFCP6E9f0isKYRl2QcJGsHLtTj1icJLZXA2V8UcisRg9MvFH
         wmhMiGrP7m+DQTWMkgWFGju8XlQsksu4LOW27DcvRIzB78kOZmPJUcfOvxK2SYBFKWSg
         GXCSgBFRvY+aJ7JD6gvQzKjIsfO4pzMkP0p4fjU7UdHDAva2+pCm57jd+CSKJvMpg9Ic
         XoHhJLVHN+AJ307G1GZbL53152M1GLX3iBCGsnl/N/BAJ1rmEed4KdbnNkbvXPNhxEa3
         ll3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mc3A7vlsW7JssIN0XeC96WxSi0wSNBfvSMrsmA7bSqs=;
        fh=YSn52xbaby1F34EYJNrO3+Tyaie7a+BFmsw1z8c3TKE=;
        b=YWqW1z/L6BMDDIGFb7PyM7aeC+FxFIyCqWmdF5tnL8zfWMdhbs5tmoWg15sN76HnMy
         lEYnbXVYIueo72DOWEXo+PTcOkxrrWS549WhNPmtzDuF/UbCuZzJbOEg5E6Mb7XOOzUi
         Qf9X0W4Ojw1sCFxxk2DA2wSlAI/+EVj1ey/rUCQEXEiP9yi9o8yvKB8ranOln1OYdUM3
         AZKlIpbpnCPbMppjAPhYBngkarUHL9L7j06okbrNWWXpq2Te+DOuAyR1QIoV7LJ2ZbkW
         bB6NnrJLaIQahWV5a+fm/vginAn9hz67yJJKcHgGf8miKKNVnINiOjf/J2KEVeok6uKu
         99pQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795094648; x=1795699448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mc3A7vlsW7JssIN0XeC96WxSi0wSNBfvSMrsmA7bSqs=;
        b=ohQxkIHbfFyDyIxYW9q4LWS0JyCaGn48AkjZiAt6P4hauUtnBG8ITWl5sa7P7Qq6Yz
         l1YxudrCQY3gubPaig74j0rOJlJLwwUI1okCzHdn73HvDUcw8Qi5xOSKahFvrY4FbUbP
         9ir8bMZDfjIb2T035cHrr3koqY3lXIeJc1x3YrIQG5j/FEdZeCHBOIQKXDPTKJfmOej1
         L13m+Mc9umgXPOCZQ8MXgX+nXtL/1Cic6UcstYnKaiJuEk/MIpoutNARisjpADJOIzSg
         qAZ2/Uh+z8QdVDYD7Lkf/3AYVHruZ3u9m4i2rq0XRqtU0kTkSZhZIrdQtJl2uEmujd/K
         h/0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094648; x=1795699448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mc3A7vlsW7JssIN0XeC96WxSi0wSNBfvSMrsmA7bSqs=;
        b=hHwWu5Dno0AIW+NTVBpGd+cYWb8fywiqfrQ5TYs2NIvM/p7Wnc6/qxex+HKa1Pcesv
         xqMUbrxYNlhXUHw2vRfByJp8AE5beBgqGDvKK+fPZAmHcAV8GTv7UdLlVMWdnxhEBwwG
         xAS1YC0CrJrtfYIfI9x5k77RunG4CGhQeN4USblf6I2iokMHYiq9IVXNgeHXL/VZqA2e
         05GurGlQMeDzAyghQY7vW2LNe7Z832Mkc9QbPWTUaSPovVbW6zjGctQVKImVPhaz1Tfr
         +Ga0+3bDfQPnokk2lB0XCP5mOGbpweNlxAwA/KG5el/HaxUFvu/omTHgbfaqOTDeCe5N
         +g1w==
X-Forwarded-Encrypted: i=1; AL+hErExYPXPFarIbpz9OHArvCafsixWjQqjBd2GjwBablbBXqIgdvivOra2h7MdWC/Srt3e96aydx8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+JcFbJjNDMUOMUl6uzuYXrS/blybe1B20L+ZmtAjenleGZss1q
	7P7atBNNrBcwbK31v8BNoVPkAeBFYEQg9bz+4+Hnag5P9Nl7Rw2mi2MUVrOFyt2jcoH49eENIJQ
	Qa+Cix97iL2/X2wR44p3DHHM3Px494ag=
X-Gm-Gg: AZFdTZcSIb7b8gje0bP9ba5hASrlzkczG4GUx3w8ZK6Kld2iT/NsSd6ZofZ/PTpRw04
	7MQfhreYRd5kMdZVXDWoHquE6cVLXzmsV+jcJTTubVGxZc/TOC7ycTrd9o1sVts+8U2/j4AL2jL
	1+2k4hTWu1eVvw6DgRS97Zb9EJvI5AaOGvPhWEvy9u0AkgrEU+aPAwZ/ceVzmxeC6ByZnw1loI7
	TDyaquX/RiyoH3d+QLB54Z9SKzZCl1pWfC76TfCKHK4B03KWb22v2vzbPrsjRD4tTCVn2zjycmJ
	QzVMV83+NY27uV8YhCb4WKs7XVmyNauJIGzj84B/udMg+mOBFv4Qegzue0KKocaJseQ2ts38sy3
	vd4CLSKpWeu59RuvcS8rnaQnjwtDSOyKORlyuiUSbUUe+VNJED5nrRx6mTrm6OAiBv7Dr
X-Received: by 2002:a05:693c:894c:20b0:381:2f5d:a696 with SMTP id
 5a478bee46e88-382815231femr5552211eec.34.1795094647673; Thu, 19 Nov 2026
 05:24:07 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261117104110.240112-1-hj351016@gmail.com> <179508442284.48856.17227214993153041326.b4-ty@oss.qualcomm.com>
In-Reply-To: <179508442284.48856.17227214993153041326.b4-ty@oss.qualcomm.com>
From: khj <hj351016@gmail.com>
Date: Thu, 19 Nov 2026 22:23:52 +0900
X-Gm-Features: Aa3M54pq8_LNh7uQ__eLE8hy46Sn_JzIFh689mI7Grw_bv_tYKUKVMqusZDjKC4
Message-ID: <CAGr5VtPJq10ZZoF71+714xrkC_-3g5JAEKfXXXx+6MEY3PN6bw@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpsse: reject bulk-in endpoints smaller than 3 bytes
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Mary Strodl <mstrodl@csh.rit.edu>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You're right, sorry for the noise..!

buffer[2] is only read when there's no interrupt-in endpoint, so
rejecting every short transfer would break the devices that get the
status byte from the notification instead. Dropping the patch, I don't
have the hardware to test a narrower fix..

Hyunjung

2026=EB=85=84 11=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:33, =
Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1=
:
>
>
> On Tue, 17 Nov 2026 19:41:10 +0900, Hyunjung Ko wrote:
> > mpsse_read() reads min(len + 2, wMaxPacketSize) bytes and then copies
> > len_actual - 2 bytes to the caller. A device that declares a bulk-in
> > endpoint with wMaxPacketSize 1 completes the read with len_actual 1, so
> > the copy length becomes -1 and memcpy() runs far past the one byte
> > buffer on the caller's stack and past bulk_in_buf:
> >
> >   memcpy: detected buffer overflow: 18446744073709551615 byte write of =
buffer size 1
> >   WARNING: lib/string_helpers.c:1036 at __fortify_report+0x6e/0xc0
> >   Call Trace:
> >    __fortify_panic+0xd/0x10
> >    gpio_mpsse_get_multiple+0x767/0x780
> >    gpio_mpsse_gpio_get+0xa2/0xf0
> >    gpiod_get_raw_value_commit+0xf8/0x1f0
> >    gpiod_get_value_cansleep+0x1e/0xa0
> >    value_show+0x42/0x90
> >
> > [...]
>
> Applied, thanks!
>
> [1/1] gpio: mpsse: reject bulk-in endpoints smaller than 3 bytes
>       https://git.kernel.org/brgl/c/f94f85f82e042c89a1e64ed3ff1d591a2bccf=
a7b
>
> Best regards,
> --
> Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
