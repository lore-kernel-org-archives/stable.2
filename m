Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795094754;
	b=4fnqcU0jhtR7zNsMY02TLjenT815h6+WmK9PbIax0M0L4jj0KsWvk7w2Sqj+qWai1vEH
	 TYsNSfda+IZOeNYNgM/5t79merrNDehbxNZQE+B/1vdHUzKKHBYfTHqSjueWCCSV8qYk1
	 hNpEvG6UF5jZQZaXuvXC4w9nX3it3gSYDndjuzqazKuXVLd9wJJf/aRNDNYJuTvtBKgPq
	 JFTY8Kxw9jTmbbc+tMRwR3BmEqFHvyhyEEV002GS9Uegbxgb3KGHYq6TAUCeBzQTH5tdf
	 XMOmJCXczzl/qOkP+6+DekOcGUSMMXC9x0zWuaDkDvL1WB7W9sDrxYhecf1eExvUiIw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795094754;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6GtMGZ1q6ZRXofGUkEkZymFWRF+bA/VpHBqpwylrFKI=;
	b=kvqbyyGBnIXWWgE7OiBAtyhy4PLdB9aweIFV8oj9/TxNlk/jDJ8AeycYiMii6/LfQwLX
	 xRWUtEwEaIh8Zt1UgprjzVAS69B8loszUngfevy/ahaChXq7cO867RsgmFVU8ToqJZxQW
	 QuSD/LCmUSzT3H3Js4K0/VmBeB9M5KQNJICqEg84UPRPzeXce92xXPEGViWmYLVUz4yl6
	 2R+iNssrdAK0yOa2B811jENzXAKZRuTy0lpOwnxWOvWLMQV16MkY5z4pZKaqYruPWAzuA
	 AwAHvw/umdEnqa1+Jp+ANy0EHqGbRE3vlh5Iinfx48kIV6M4FsizxaHc+/H0UD9B6kg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJMQXDYB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.179
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com [74.125.82.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF7606A33D
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 13:25:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C5CF7606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TJMQXDYB
Received: by mail-dy1-f179.google.com with SMTP id 5a478bee46e88-381f65e4e4bso3442972eec.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 05:25:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795094753; cv=none;
        d=google.com; s=arc-20260327;
        b=VMlMCzTt00ESc8QM2aQpJsrF+Vm5klReld65wr8xxebLMvyEm+kXHCvOcXwPW/k+31
         Nr0wYGlYM7GeD4/2pkaMzY/4KmPFjPsD3doKYxojPpJb7/resaeBDVza0yU5XkjiFk8I
         kIJncJl0P2fwamcmLgUur35rTrKLGESauD6YokBLw4Xmz0wuiroNoYPUVJWYNckwXr5m
         +S8iVEUnK4/0gE2vwwHpZNHYmxXOTZMcbSxcHFAjKH0EI7ijoAzIxpM3aMlnqAtj42YL
         fhEYnmH0kPaJ0nBZm48iTD9HrKiSvgN6RF5qORym/22hraaI7PzEapmMgCnos/iDClXa
         T7uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6GtMGZ1q6ZRXofGUkEkZymFWRF+bA/VpHBqpwylrFKI=;
        fh=Cccynu9UlXdLTzBCHESKLLgbECcfMtaVkfAu0i5VcoY=;
        b=MUSbsCTYxh6FIgYhtOTeOUxZ2VmIj+FyDTzSzxBQI5FfXsCUSOqQsn5Z6ilvdJWkFl
         oG3bklQ7Ql8nnS/GOEF3qUoC2huSiz8t4dSf6/VYZd4anGBIm+TLvfLbC6mdxVDUTO6i
         E4AaZayW4VdnTHVVuKTr7lphAOsduWr7xINrCWICNuhGfolpfItJbSzd4MfOziBFD9Rd
         bb1ADxRFsVm27dQ123j4Hvj9QrlpLsGd4EvC3Oh769bjnGnPfIP0K4HnUnhfcb4Ap2oV
         PgfmTkCUBof8BR5RFCOpfLBIkvkJsoNSI302F7FCSVIA1fbDCULNxFiksRxNoZmvZFBR
         31AQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795094753; x=1795699553; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6GtMGZ1q6ZRXofGUkEkZymFWRF+bA/VpHBqpwylrFKI=;
        b=TJMQXDYBn44SkcrOW0pJGHN1bwblMduilNfFQcl3U1t6UyvvjA8TCLslSJkdUvfZIy
         KpXYZege3j2yJiou/fqKzS+rQ3KukR1pynvmd0C6JjEJ+AfeD4hrPSgiYxC/3BCGLUNT
         dUWhRhSYsoY6FC8dWVsLMLbZC7pcRNXO4YxXhqOexPvGQ+Ma2E0e14RUhjJilU3vXOdn
         gE25TfkBGvUlR9CYiuoIiIDr7tLwGLc6rWrvwbH7M3RBHAO0d419hcoA5o7N2Mb0oUYD
         oAzCDw0WZCK+d2M3yjlhn7yrJ2OsPdAmn1ncOZLlJaBB8XWvNI8+yVUkaYjphLM9wo36
         KKbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795094753; x=1795699553;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6GtMGZ1q6ZRXofGUkEkZymFWRF+bA/VpHBqpwylrFKI=;
        b=2Mazxr5MoQlKenbpkdkMxIHja/5R+C0HK2hUjIGErtgSsO+QM+CY4Q1b7EnUyd47/D
         zR3o763ekcmDBgNkRJC67j42uhjFz5KjZNEMtzW3WHQ4Zqi8ABQI49hYZaHZCXwT9BpB
         AUYGD4RMq25VqY7CgBP8Jer5ZuRpJ4Fk0OCgnXQVMwBKyZMH8xxKDaodgEiiatZGkyC9
         ZzQE0oPcJkS5DMl3BYqZCHRfQ9PrUBzQTMNDjFiMR1+eSXo8e6WKYwr0VxH2VR24tY6U
         zRjEuOTA5TGrvtP3RSNVrlyn92rrefugg7zNfyJa0D4ftkf5QwBiuiKHoc/9eK/0y7qF
         EAcA==
X-Forwarded-Encrypted: i=1; AL+hErGYB6vQL21VaSTzmScqVnfU85lgYDyxwhHXUBXehdeXwiWRRS24oKzb+h46jgGA/YK6UG19PPs=@vger.kernel.org
X-Gm-Message-State: APuU4Z9rFQFJkWHY3xSOEmyE8RcA61VKWSYc/3qqGGBqHRVXR3BXUaTH
	sq8SOmpIadKw7lu1XuxqX+4vIh92ZjLrvkXXFcK0AuuyMZaDX6zKkWixoHd+ZYOCI/tR/V+uxEl
	sMlKWoUrnnByywr5NJRmtMVBFXNzDvRzukmnw9Zw=
X-Gm-Gg: AZFdTZce4LBuQ/KD2YhkJlStnIcZaCrlW6/0NTUlQ+WIgnOGzSnr1MBsldh7kB3Ltva
	312ucLugM+2rOfEwQrCsBhaItpIuYYHpgc0BCrGQ01kCqwoOyqVo+Flclqtn3nmXXCa4HgIGUf9
	7S2emonoC2BzmsB3u1LyhxEgCfuTMnMvloj3cxdw1m8jipfVAoygYwIFFIKagT741heUTWo2MMD
	7DMdj66s0eSjz46dLuh7CYuZxClDXMLoMIw64j2iTO/xrSH/5GrYUApMMYSTR2NvX/fZi6NP+6z
	12n7FzFSJmm1lGroWG9esNO4zJBlgOTURY5aQI2IKSxO1z6bRVjDpD7v/6mn9ceYAgtyww/G0nA
	xi6SA78oKBGJszYjsY5kouCwrl+5H/VqifMuzXP0cFyhkb0Fd58/QCMabycKQ67aEJ8xS
X-Received: by 2002:a05:7300:fe4b:b0:378:7434:a526 with SMTP id
 5a478bee46e88-3828036f384mr5352568eec.14.1795094752653; Thu, 19 Nov 2026
 05:25:52 -0800 (PST)
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
 <CAGr5VtPJq10ZZoF71+714xrkC_-3g5JAEKfXXXx+6MEY3PN6bw@mail.gmail.com>
In-Reply-To: <CAGr5VtPJq10ZZoF71+714xrkC_-3g5JAEKfXXXx+6MEY3PN6bw@mail.gmail.com>
From: khj <hj351016@gmail.com>
Date: Thu, 19 Nov 2026 22:25:39 +0900
X-Gm-Features: Aa3M54rnPhZAKuEY9k2UmBknHhatG2W7IQACaSMZC7nT1gke2LYNilinggjycdY
Message-ID: <CAGr5VtP6AsETHHMGuhsycLy2Mq0z1Z-Jt5UF+W5_XBcbL=dKfA@mail.gmail.com>
Subject: Re: [PATCH] gpio: mpsse: reject bulk-in endpoints smaller than 3 bytes
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Mary Strodl <mstrodl@csh.rit.edu>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry, wrong thread - that reply was meant for an unrelated usbtmc
patch. Nothing to do here, the mpsse one is fine as applied.

Hyunjung

2026=EB=85=84 11=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 10:23,=
 khj <hj351016@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> You're right, sorry for the noise..!
>
> buffer[2] is only read when there's no interrupt-in endpoint, so
> rejecting every short transfer would break the devices that get the
> status byte from the notification instead. Dropping the patch, I don't
> have the hardware to test a narrower fix..
>
> Hyunjung
>
> 2026=EB=85=84 11=EC=9B=94 19=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 7:33=
, Bartosz Golaszewski
> <bartosz.golaszewski@oss.qualcomm.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=
=B1:
> >
> >
> > On Tue, 17 Nov 2026 19:41:10 +0900, Hyunjung Ko wrote:
> > > mpsse_read() reads min(len + 2, wMaxPacketSize) bytes and then copies
> > > len_actual - 2 bytes to the caller. A device that declares a bulk-in
> > > endpoint with wMaxPacketSize 1 completes the read with len_actual 1, =
so
> > > the copy length becomes -1 and memcpy() runs far past the one byte
> > > buffer on the caller's stack and past bulk_in_buf:
> > >
> > >   memcpy: detected buffer overflow: 18446744073709551615 byte write o=
f buffer size 1
> > >   WARNING: lib/string_helpers.c:1036 at __fortify_report+0x6e/0xc0
> > >   Call Trace:
> > >    __fortify_panic+0xd/0x10
> > >    gpio_mpsse_get_multiple+0x767/0x780
> > >    gpio_mpsse_gpio_get+0xa2/0xf0
> > >    gpiod_get_raw_value_commit+0xf8/0x1f0
> > >    gpiod_get_value_cansleep+0x1e/0xa0
> > >    value_show+0x42/0x90
> > >
> > > [...]
> >
> > Applied, thanks!
> >
> > [1/1] gpio: mpsse: reject bulk-in endpoints smaller than 3 bytes
> >       https://git.kernel.org/brgl/c/f94f85f82e042c89a1e64ed3ff1d591a2bc=
cfa7b
> >
> > Best regards,
> > --
> > Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
