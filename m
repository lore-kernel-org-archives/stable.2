Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794473239;
	b=3yDtFgFUecqJXReuFhByoeYVV5Yipu0v52I+uLDmOCUJyanh7cqsiV46cVo9PNntKT9s
	 YtZ5cCIlLvVGVO2vx5agf/yDPReyIRby5WCPi2Egq99NthH9QYLgPwqmtrvfSb9o+/FDr
	 VQHrfPy72VlYI6c3eCNbphHDh/S3aas1AgqkrCu0LmXxG4dO39+mLMeiwNLsGbdgHcU2t
	 CIiO/06P9Q+XuKwNhHA9jk39BEOLXIUYEFIdadfv8eaQA+wwWbnvkK8KTNOJP3Ihl1S6i
	 q7MaVh95liS4WlCkp3muzMZC8417m1Cv+aNnFF7bfHIvjx9mWjBqgErwN+K6NWd2kBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473239;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
	b=n4e18I6ZOf0XFzVi9crwqw1euge8s2laRr+ApSjs/I+1ko+9fNYh3QEowVABc82tIWT2
	 Lu6wF+FdLe6Mnfx2Yg+CJ/gMuG4iTVZDJjxjZhYGVp4VH5lrLxH86T4IHgv6ftvGiezpk
	 XXU2OoxHdHT193aQU0W5LKjVV0+2If9vW51TBCKgG+LYarZU/EWqtBbPWH7JcThwam3vK
	 jgrHjy7dGgZpZYeJiWAceYDsyJRXGP/AjR+/M5y0VJjMxjcLkKOnfvIYC7ieHZRqSPVgt
	 dfUeI2GF6On+KxhDPIA5KrvvuJqF6YQnjJvsTxCavTGgR+idc6c0EIqXLIO147aNc5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxIOdRQr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.41
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB81D606A8BF
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:47:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB81D606A8BF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gxIOdRQr
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6b5973a4b4cso4687533a12.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 00:47:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794473237; cv=none;
        d=google.com; s=arc-20260327;
        b=ezci80pOhtDKijd9CLU9sIQ+//kDHs64huQZ+5PYdxX6FsCuo7J7JaYzyqoEgv+CFf
         EFTcvuFqGRPIw/WmsSkwI2JxUtF5zuzbWBFbjbKO6kCu0bPk+LcQ4e8JElmvxaauA0My
         FKkMKrQsYlILYZz8MVPuDs33NGK6F/JZR/q5FpAQGdt2RTLg06n6iAxsgBUbJV3ArlZA
         dUWT/5FSQ4Dm/hBJVUdE8mkauTgN3l5KGvqS57hpaGyPc0OOHXBzwwZwLjo0S4wC2MJB
         oAVcrbwAfyF26m6f3J/Kxp6b31C05qnP04d2uNwdDk3DbR2OQuzxUWEvjD1JodCSXCAk
         j52A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
        fh=usuHi2OOiCdjPZeIiahWohRXnX6sVabxb7VUAuNjKHo=;
        b=Xi5FPG9wwB9eHr73PeV9D2Nl0MJyO4uqDstNBRR36Cfs8zypVpYM1D73S0H+CTXwMX
         AxQdA72LzU3AwndEhDogjl/uHUeJum1NxLWcZMeGXg5dK6jfKRu7ZysFkObNTeSUyaIY
         mI6XrFI2IBB8S0ajYkLUlVY7sy76cXeXuT3ydKfxH2jibD1d5M1R+eW8Q0TwcjGXetPY
         tV5S9Tr+YmO6Id88NIencH2qrnohnU9ZEMM7Opih5yzfUGGAqd4uN9epJ1RG9J+NOIKS
         wUHEItrnDdLUcsa4+ylco5rCgKwmtoZLziqcBbHqHJebrqu7pKUySYGPcc7D+y6fzGhz
         eNJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794473237; x=1795078037; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
        b=gxIOdRQrGGYCVviGjxwyVeMmz6w7UXFEUKI8OQN3X4OR+FcEI9NqJN08m7fLY5oB3D
         ZchtKa23lEZZ1jsx8tgTdAzLAls+qRVKLe3KI8Y0LPWSiDRQv401NlBslerNSTBwMv7T
         nuhV0+FyrZFvQYvR61NBtLXUK/oTqHUiId/+algf5iPAoNK2hM8t7ZVLdPwQ81aybg0e
         IfosV53elz8kF42nVZGGAMxLgwcntqqBx8O5VT9x6TWi69+0k5qxx3j0xl14Icjpjj3X
         ENqaL69x+MRgzWQs8gNfVmvXZ0fV2WALM24AQyHocAl0ZUsHRKZeqFx7vdEbMKciAkcE
         n1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794473237; x=1795078037;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RB86biYg+BPhq88d5PdaceEbdw/e2Gm1TW0EI7mBLjg=;
        b=QGyssraOLFLiw8KQd5pIotRajexAtBhJ5IY2ofTgJeg0DBAhtNNvZHtj/QyU+kWGd3
         bPyANVxa+DFuMIKWBluuvq11Iy2EPDhDJuClmjp+vzae0O3e34DmZ3/2fsY5QhskzfJ2
         ILfZkUWiQl22hUxzBdAAGxpynlzsC56sDV4JdqZHy7kBYMAmlcQb4d28bgCuSC51bLY6
         Gyf4Srqlq40fcmza4ZxM394605TyKg41h3WdUFryFAUqNDS9fR80Eymfp0ij3vCxbAtn
         aWz/2ER4rcZQecCiDStwJjAjbH07LQ0va2zoXdw/57Ar+1YOIhT+ly2pQpW4+WnVgCU+
         i6QA==
X-Forwarded-Encrypted: i=1; AL+hErFv15G2yYAf3YtU7e/Dvx+BonTs+YX7Gx0Cx8AtyouRCDzSHoZp0ZDJY4Yfewb81BQyX7joHZU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LNvnYN2ZkVSX5cmV2xvDChpTRTo7GYCVMstNpxMTvW96I6257
	jwoSp22EfRGmwddc57Po/6rNu5R8v99thKepubBZr9uq3MRqy2h/aclYicpo+RCjenelRv7WhuE
	/PWJR6Y9Z6+vPMUtA56ldFW91hwXmdx8=
X-Gm-Gg: AYBFou3OA4GTJ8gJznq9olon1yvNxZ0ZQaR0sQtRb5Ez0vHyjD6jmmUmyjZJ2Xnt2f8
	Bq50BuxcMP4tBcaf5okv6eVPcLNLv8yEXWTmGuqdEklPNUV7YKssAR+bXYTGZJR7fLQD1LUTR03
	R6cgsksBiaIXXbrub/5EUJImrhpOLHKlgwIGo4w/F5G9QfBE+UQGb7BepBnSTb7+2BKLmq0MxE5
	EkbgXhDTDwnFhIWairH6wM4Xng2rSFolSLRx8yNyQoOWeu12T8WFqgsGdvHBMEtvTTJBL+nxIZP
	rDgWQWllwh/gDxHbdsZERwNAX7NYAAtAipkXdvqIegIadbipMwOAcyVOEVQvut5/Wbg07BK9+xR
	o2nlIvQgHcWEf0aAjS5FcGtpG2PUlrTf3inxwWU+rMjsLTVwWEw1xFthPZjYqireKfG+52g==
X-Received: by 2002:a05:6402:22d0:b0:6b5:7ac2:b4b2 with SMTP id
 4fb4d7f45d1cf-6b7773eddb5mr3024443a12.15.1794473237126; Thu, 12 Nov 2026
 00:47:17 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
In-Reply-To: <20261111-vgacon-ioremap-null-v1-1-6dd05bf390ef@gmail.com>
From: Magnus Lindholm <linmag7@gmail.com>
Date: Thu, 12 Nov 2026 09:47:05 +0100
X-Gm-Features: AclHuK_fa-iP9Xeaq-QANT8HT3vhxni1COHVSdMAf4Lytq6Fso_wKtQBPBFi4S0
Message-ID: <CA+=Fv5SHTC9XWQJZY7DnZbpMPnk3b7eYNiiH6Dnii+eLJo9YgA@mail.gmail.com>
Subject: Re: [PATCH] vgacon: Fall back to the dummy console if mapping VGA
 memory fails
To: Matt Turner <mattst88@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Helge Deller <deller@gmx.de>, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Matt,

On Thu, Nov 12, 2026 at 1:30=E2=80=AFAM Matt Turner <mattst88@gmail.com> wr=
ote:
>
> On Alpha, setup_arch() registers vgacon whenever CONFIG_VGA_CONSOLE is
> enabled. On Marvel (EV7) systems whose SRM console is serial, no VGA
> hose is set, so marvel_ioremap() finds no hose for 0xb8000 and returns
> NULL. vgacon_startup() then probes video memory through that NULL
> pointer and oopses in console_init():
>
>   Unable to handle kernel paging request at virtual address 0000000000000=
000
>   pc is at vgacon_startup+0x174/0x910
>
> VGA_MAP_MEM() is ioremap() on Alpha and powerpc and can fail. Treat
> failure like a failed probe and fall back to the dummy console. If a
> VGA card is present, locate_and_init_vga() still switches to vgacon
> once PCI is up.
>
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-5-5
> Signed-off-by: Matt Turner <mattst88@gmail.com>
> ---
>  drivers/video/console/vgacon.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgaco=
n.c
> index e7e6750f1f87..09f7c376b468 100644
> --- a/drivers/video/console/vgacon.c
> +++ b/drivers/video/console/vgacon.c
> @@ -324,6 +324,8 @@ static const char *vgacon_startup(void)
>         }
>
>         vga_vram_base =3D VGA_MAP_MEM(vga_vram_base, vga_vram_size);
> +       if (!vga_vram_base)
> +               goto no_vga;
>         vga_vram_end =3D vga_vram_base + vga_vram_size;
>
>         /*
>
> ---
> base-commit: fa4ad798f6f681031775266044ba1b0cf3c670bd
> change-id: 20261111-vgacon-ioremap-null-ad4c7184b807
>
> Best regards,
> --
> Matt Turner <mattst88@gmail.com>
>
>

Nice fix! this must have been lingering here for a long time?
Cross-builds passed for generic Alpha, including Marvel. The shared
vgacon code also compiled successfully for x86-64.

Alpha QEMU fault injection confirmed the early dummy fallback and
successful VGA takeover when only the first mapping fails. Without
your check, the injected NULL mapping faults.

Forcing the later mapping to fail too exposes a separate takeover
issue: the console core installs vgacon despite the failed mapping,
leading to a NULL dereference. I don't see that as blocking this fix:
finding the VGA hose normally resolves the mapping failure on Marvel.

Reviewed-by: Magnus Lindholm <linmag7@gmail.com>
Tested-by: Magnus Lindholm <linmag7@gmail.com>

Thanks,
Magnus
