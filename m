Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794302292;
	b=fe909KEY9Fb3vhbgqlBFQtKj/Pw/12ZZRI3dY91b6cq4OvkvmD+cCBfFluDxmyzsc/Sg
	 XYKRwk5qVoeT54yPWL4395M6TeJ91R2zm4PBDWlBYtsnngr4ZqanfxZEHlEFSeQ4IplLE
	 UEPuFnqw9dSv131JF/I+zRkabMRnbuMR818n+68sP/UpV8FXYPLt21FQOojLQb1pxkGXU
	 y3akgfhPKl0JtKPUlgCVNPib9e/BJJrB4mcdBczqHns02d6XgNkkU23oH0srPwomSdEN4
	 I4vMnKgXJ/s03mSPySwnXojwYkgmTHjEPoTHHMASeuWQcrjKwK3XiIHt/nWGf0BtuDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794302292;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=tIES/1ZtUVQWW9RQ9o/3BCRLnyN+/ueCJUQ4SJ2LWzc=;
	b=C68vjTZ1UqYcR9YJKGnJ2VojVJp0xEiRVgw1OFFbGIwqeT06CpSpmQbjV6X4Ont+BU+K
	 sSB8OAZiaq8C0XNWylqx/3eXdl1cIq0B2sfu+5EMlTMHBJVTRv0c0QBf4XK/i8w238tPg
	 NgYTXA5FMpgtVfTW9VWwJYZS3zp6pOeFmRVkEk369ht7Yf6OqYdisFkGJLv0ahcTy2GTQ
	 QkFYlPdLXKGfP1UygBiLV+LT12D18sNJ2kW5BLI47HFrx8JGZzpr8WAuZWBrTjjlyl5Ab
	 fdDIALp6SuASV5n4+5ZAwmed5gACd4ZqvF99+1UWYQJScd+i5YaG33xyphgd+UQT29w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDsa4LgU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.176
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B992D606A93D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 09:18:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B992D606A93D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YDsa4LgU
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b354d27917so14753387b3.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:18:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794302290; cv=none;
        d=google.com; s=arc-20260327;
        b=cy9SWRku5dWTr5z4umPOfysafG1kmgqvnqeYIVubDzGGLK4IJ2oCTuKChVCxkMoz6S
         Ja7cf/uZ2qYnSGBuvkrqGXSEBmpsOepplcOZlic55sTWmlskYN57yyVfvjtF/rlSmf4j
         lv80SeW/4CqS2Q9mLoPHPsR7SkSfuqtnyoVWAH1GrAa5CYnas/ejtH1aBX5PDr4oojyO
         kMOfA8ctGu7vWfU41k5ek8wnBIJjnqYwqFlRLrFGGqaupOZHupPTCUK4hBoh2Ny2rzkQ
         BoNpe2PvAapHrht4sUkdSmmLm+O+s/CDfz7LcBaooUiV1L3GPy5C2KSap6vSXiiSmhgQ
         jL4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tIES/1ZtUVQWW9RQ9o/3BCRLnyN+/ueCJUQ4SJ2LWzc=;
        fh=fF0G3KDBZ85EgwhM2GkuUbqciJEv0oJ1Y39oLL5yv9k=;
        b=mZJVmU8wq5gvIZkqEKkTHPCKjbLqlYRvrzdsHJopftcg8FHQGxnIKBG8iWiJV9m2L2
         U6ex96wtrWTtYKEaXkaFomn3ovn1nDBXXTfzLUB3AYzGjaogqEief36dkxS3vwlO350S
         /aE2ctjCubtMOZWPv2wFLsxJIXK/4+58FYWU1OaukLWUnNSArVgG0Z6831xKhofcC1a0
         fnS3BxuaWEDxE6YseBrpSp0CxHc3g02MqfiQdVcvfzDeioTdmeUWaySuIjtFKJMHI+5+
         cXMmP4B3YVm9AfvaNMBXgywHwuh8OaT1mzNsKFVyEQok/108pYhp+5ps7BSAojFB9nKt
         bH1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794302290; x=1794907090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tIES/1ZtUVQWW9RQ9o/3BCRLnyN+/ueCJUQ4SJ2LWzc=;
        b=YDsa4LgUv5n0lWCUEIfmMCWjIYt6ygKSrwZsVZ+QjGAEdhc8q2QeEvjCPA1Z/6u537
         WkjwNa1Il5/wGDPX9MiFyr1CTUOScTcunw8/VFBx6wd+llOK8aFQ2hvAUZiWBy8FRwZ0
         KK0usChUNLfDYp9sawBKytdDycg+VjkVsbOP5trDabilCoYB19+bsEUTnoxz8N1EWRI0
         bYEQWMG85TSLNUn5jHqYijJLZ32w/k6K4rTsT9Z9kQ198Zoh3osjWgWPrckZQ64E/Pz7
         vR5bIY15GRLc0p6zrmq7/EcJvsWvE0ZcUSq0erbvi7xitWc9w0qNYrSonBI9pW0dQCGV
         n1Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794302290; x=1794907090;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tIES/1ZtUVQWW9RQ9o/3BCRLnyN+/ueCJUQ4SJ2LWzc=;
        b=ANKwsomwzqibynFuGTZ8a3IywMfJumFxLjp+hrpC1rVhvhgXTrHe5Ld2ZQdQxPnGn7
         HXIdT98+DgwDp6jD2r0YkD6UBjjp2jvjsjYphBSMColrYlCAB/0eDOkEd0ERlqIryqLW
         niYB5Bc3uGWnIMTQv2EDlq/hsDeAfKNf9echBkIB0YpzbeEytR/kj08S7acGKw28uHn4
         e/1P93J86+EUmCYzF3hEeQTky1W3QKH4S3vdsl1itvA/GAowSTi/id91sAd4kF2NdAhh
         iVc0/y6petXVaz7XarK40R+X1WGTD4kWQ2BNk/+KiGHXBa33fLMBlVRlH9uXb2e45m27
         W0SA==
X-Forwarded-Encrypted: i=1; AL+hErGA3NB/+n6I52RzpeJEIhax6hNP+85k2Oe76sesvGOeSRDhSmYrILEvJFHFr2DHV7Eti1A1YuU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+S7CoX1Ige0NiD3OL70/Sz5B0EdRQL91z1OazJ3//RzE+vP8QN
	B2MErEXNHXL1p41EhbLqP1biE9rRurNMs+9sg2fJxZWO1ux+oSkV32HVf0rOB05vrF2q9GXj/A5
	2I3Jlg945C60/phtHC8Ov3B1iAtup30c=
X-Gm-Gg: AYBFou3bWnDowQKB1l3wLOQkR04l1rnJlbtEnxGsGqteomq5KOkSTyARqI2/tD9vbw4
	ulJUWthIDnAKQ4D8OIEA+bIKAEODVzK+mizTaFHzcFehk3a2Z/ihRBGf51nRt0c9V+thfC072FJ
	b78CONgGDqvH4cu3gVnH3VQ9R4ESzjJhrDpfzgt/6uaOyOtV3ZKOhm7uihOkINYwY/1DpFBKIt+
	dED9H2MDSz2Jtx0xfThWM8mH5Kg7Nd5+DzFsORmndL+AnGRq91CRlqyG+HIsvvFs46Mg9G26ehY
	5f+uZkT405iIMGf+3wG2NUoldpKxKyEXzK0wjI6NUSn7pmti4BsRNeRb7DjAIcA//TYuAOK5lXh
	fdr1mXF5sjWhDQaDkFOa3qaj8U1XkSVV+TnVv7qZgubE+MNrEz+X5illlvcr1WEESEIEXJjAekD
	ah+Xw0XOIvAxzb7wNTnNTAzAiaJFb82s3hJZJEYrX8GhI95+fNDe7ViNI4H7fU3d67GxPt+KefL
	s2AWSpWJ3/U1m0njaLItbLDAJSMPI/uwn7jfpxAUKV22vhcxztWGMDPTCtdGQ==
X-Received: by 2002:a05:690c:c6d1:b0:8b3:3f54:353b with SMTP id
 00721157ae682-8b392a5fd86mr10563747b3.23.1794302290725; Tue, 10 Nov 2026
 01:18:10 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-gpio-sodaville-use-after-free-v1-1-f572f40feedd@oss.qualcomm.com>
 <kyqnjm57yrercvg5raacrxwt46p2fig6leeeywipv66c3iqzlg@tdh5swet65jb>
In-Reply-To: <kyqnjm57yrercvg5raacrxwt46p2fig6leeeywipv66c3iqzlg@tdh5swet65jb>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 10 Nov 2026 11:17:34 +0200
X-Gm-Features: AclHuK_tfRAddWryhIu2itwZTuCw6dMSKtHbGDbuVRDpd2s9leUebZVLl6Fly40
Message-ID: <CAHp75VcO0tFShCN5n+7WXQwM9ZBAUS7-0G+SQL3LW_tbObKtpQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: sodaville: fix use-after-free bug when registering
 the irqchip
To: Bartosz Golaszewski <brgl@kernel.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 11:15=E2=80=AFAM Bartosz Golaszewski <brgl@kernel.o=
rg> wrote:
>
> On Thu, Nov 05, 2026 at 02:14:27PM +0100, Bartosz Golaszewski wrote:
> > In sdv_register_irqsupport(), if irq_domain_create_legacy() fails durin=
g
> > device probing, a generic IRQ chip is left registered in the global gc_=
list
> > while its underlying memory is freed, leading to a use-after-free. Use
> > the managed variant of irq_setup_generic_chip() to ensure that the chip
> > gets unregistered before the memory it uses is freed.
> >
>
> Andy, will you queue this or should I take it for this week's PR with
> fixes?

Feel free to take it, I won't think of any conflicts in this area in
the future with this driver.

--=20
With Best Regards,
Andy Shevchenko
