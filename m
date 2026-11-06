Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993980;
	b=0boiWZQxDqgTEZU86aNGZmuvtUVb2ZoiOEH/WKsOXIGNGTCk0kCf8RdrHUnGvOKZy9cK
	 j12mTkrU/U5ppB1o9Hgr6iHOOAD+pDHaivHtL799hSZEFRQT8cEDtaJiZ9yLsZqqg5WmH
	 77US8IwrYFWTBvrq73sQHa+BVta7SGodF6+IKIoiG7X55V3FLPp35ED0pa9KVnvo4a4iy
	 xl17qgxLCOeoL12nNoYXyJ75iLFs1az2K4BROK0SZNn/q+Akgb914HR1f+uyiTjpspQdD
	 udHlZwtwaxL2PHKjDpydz6HHD+numTymFoHfL2kq0UJ2LfUhwrbnJydCk9f/S8TQ4ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993980;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Received:X-Forwarded-Encrypted:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FJWXDTr7Z5MpSyOdE1LeYV/bbbLocx7Wgu/XQXU9+kw=;
	b=hBRfbx0INB+WM5feQJle8s3oSPim4mqLPnIsafT4daHke9Je3/ct93L4iS1gVPI3TMet
	 yF3SZ0pY3TicGg5VdT4TQLInHcPE9tcp7iOU6fIzeGYLhsHlG4n56RJuzR58R9kXpxwu1
	 WlZhcKFTF2ceLgb2dFOTojRvchXlqj75i0jiCl7KjRdvXMLowEiltq6sHpyvTNlMUjl0h
	 2G4me9G3UWIf/lc4KUO5Um/YMdAhQTV+MgyTKrFBuV+7qBI7ziLbc1WBUSK70IU0TzH34
	 71Qs8w3y4FQ3Agr8QOhvREsp4jzxrlO3toXFq8o2R0/XIg2M/ke19XmCX7zJiUOc4dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chromium.org;
	spf=pass smtp.mailfrom=chromium.org;
	dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R8slF0Aw;
	arc=none smtp.remote-ip=209.85.218.45
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9B4606A337
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 19:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8B9B4606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=R8slF0Aw
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c4ceb15dfd7so120362866b.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1793993978; x=1794598778; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FJWXDTr7Z5MpSyOdE1LeYV/bbbLocx7Wgu/XQXU9+kw=;
        b=R8slF0AwkNo9QegUtRY0U9EbHQhGn7eOUxgag/qrHtQDEjCb6LprM8J6KH0o5yx2gO
         hlMPOktrUQKDmxMbYx+ETdRyDyk1KT1Hu9lbD2ykNIT19tRCAsrKg0NhTMH9DUxkrTtQ
         6A5c6fJpp7shE+ZTxODFDv5OCD8f9r3YwExoI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993978; x=1794598778;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FJWXDTr7Z5MpSyOdE1LeYV/bbbLocx7Wgu/XQXU9+kw=;
        b=0lTKfcYOSIU6TepGQhOA45Cb6LCg/NAJiUM1sbgjMzESY7aUqZOalaEN4z8EBFbZGb
         t6paGRJo4DUwwxJIWOB7v2bpxxtbYjgfEJCRis1O5I1EVD/A9uFJsehyaSXUkU+1mla1
         X8OL71heg1Xa1NXL4lanqI38LSq/G7yoZ2tySUG61MO1IQICT3GNzOCfMGhLGcNJhRa6
         oUCT/a3XRrpI3C77dPrjfjtDd2rNwyzSZjqslLP6R78YsKNMp7auW4FtP0qdk57Tlcih
         CfSaX7df5YbhAqoU3Q6ENU73ug4cV06W8Xmlz4zIvuYH5EM9fPgZnPv1SkP6iGQk/XoY
         AqZw==
X-Forwarded-Encrypted: i=1; AKwUvByoPVyHmvLP/QkE7qSU1yhSi0MO2hdWh3ieg907/cxhDI2knaviaYHlr+iqCNkk8B/SBov5fKs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/GqT8QIlmTT+tMLzp46jg3hQ45zX5ZBO5l+1/aNkKAqBOiG7S/
	HE6uPUzw4RGWf0Zl/WzGHW1JNyirZxXcBihP6boOiaaXuqsX9kx2moISnXkp6ydUj/bHdu75Rcp
	C6ktIiGhu
X-Gm-Gg: AYBFou3FziVoUs2eDOCRVR12x1tjz+/8RNYDFGFq3A7VPqpcDaB+AhAzDTZbBoPTdBM
	yVFWKOsNs4Mp03FDgH2I3dDDai2f7sVZU7NnRTzA+N18MdryDZAg14Z5YbGULW3fd5cR6dEyuxW
	ifblJK0vCGWlp9gfK47QSFAAS8siSX057DnTESVxlTBexZCCFb2hPYVjL6a0f8MiBjaCx94zK/A
	bvnINpwnLipaRminheMUNocngVEE/TLpF3oGMfJKHGAlVtcduXs1JJf+YTTr2e9wgogk9kX5E5C
	PJKHTEvSVk7qRND5aYebyevdihg/QkT7y3Phm7hLIzCjAaoEJX9+Lw9wqvF0+7CLcr424IeaI/h
	sxKSIpBoCAdcC8/8RmotdYzGuooaY+8PTzmOS7TJT66PCnU2Pun7aDV1FllENGkU7ZOJNjiaKqM
	jnpIRDprvO9eS0nm4dzzFBV/wZBMIGbtf5H+VrpVjPt1YDlMHrLVnXSzwIVxRhncCRwzpAA4E/s
	mo84BfmnYjtd4LvDTA4r5d6s7e1tjbtIl6Ke/TiS1ZwY/Rn77V4BK/RNUuBz9MRKQ2KuBBLKUCY
	31/fpelF0Xc9pymrG2wQtuleVPXEPJ2BN7yHa047nMQS+WLa2j7iI1AYRdYUYrMHxy8=
X-Received: by 2002:a17:907:c23:b0:c42:102f:15df with SMTP id a640c23a62f3a-c4d35412275mr300596266b.8.1793993978024;
        Fri, 06 Nov 2026 11:39:38 -0800 (PST)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com. [209.85.128.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d354ac22dsm101733766b.2.2026.11.06.11.39.36
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Nov 2026 11:39:37 -0800 (PST)
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so10638635e9.2
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 11:39:36 -0800 (PST)
X-Forwarded-Encrypted: i=1; AKwUvBwWW6YOFF3Jxju56SaJpfTh1h/buqJ6/ZK0Pbxpk1U3md//5gzHAjGBNdjmKhlXcvn/i7KkFpQ=@vger.kernel.org
X-Received: by 2002:a05:600c:8b01:b0:4a3:5a7b:6002 with SMTP id
 5b1f17b1804b1-4b6dff841afmr64687555e9.28.1793993975424; Fri, 06 Nov 2026
 11:39:35 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105151159.1.I0b27923381ef34cc99cdf8b65fea2e1bafce6370@changeid>
 <CAF1bQ=QkGntJu8G67ssH2dS3Sn200_JuYitjtAfNPBu_hn0fZA@mail.gmail.com>
 <CAF1bQ=QiP4fb-+Kn8wzEH7wqjAjZaagxUd3sYpv2SkwDcnFPWQ@mail.gmail.com>
 <CAD=FV=WGKOnDoY1W7CuZw=s3e8f3jrXzkJ5_Qp_Y4WfT0XwXDg@mail.gmail.com>
 <CAF1bQ=TWZ=u1h92Nt9NgGcaDNTo=BOHmUp1DCWEeUMfwBb3WhQ@mail.gmail.com> <CAKwvOdmTaMQf4Wyk_sygaushmMd9dRR3xPZ6K9rbKYB25uz7jg@mail.gmail.com>
In-Reply-To: <CAKwvOdmTaMQf4Wyk_sygaushmMd9dRR3xPZ6K9rbKYB25uz7jg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 6 Nov 2026 11:39:23 -0800
X-Gmail-Original-Message-ID: <CAD=FV=WHjRTmAd9XO4HaenLWH+H+CEPzQzT=LBrtczeLQjKbZA@mail.gmail.com>
X-Gm-Features: AclHuK9tP02VsIUFVmusvGUU0-cT9m0zdYlZ-nWofELLkEPHJWUUFL-DsndX4ZI
Message-ID: <CAD=FV=WHjRTmAd9XO4HaenLWH+H+CEPzQzT=LBrtczeLQjKbZA@mail.gmail.com>
Subject: Re: [PATCH] kbuild: AutoFDO: Disable Profi (-fno-sample-profile-use-profi)
To: Nick Desaulniers <ndesaulniers@google.com>
Cc: Rong Xu <xur@google.com>, llvm@lists.linux.dev, linux-kbuild@vger.kernel.org, 
	Han Shen <shenhan@google.com>, Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	Han Wang <nesthanwang@google.com>, Snehasish Kumar <snehasishk@google.com>, 
	Nilanjana Basu <nilanjana.basu87@gmail.com>, Yabin Cui <yabinc@google.com>, stable@vger.kernel.org, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Nov 6, 2026 at 10:17=E2=80=AFAM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Fri, Nov 6, 2026 at 10:13=E2=80=AFAM Rong Xu <xur@google.com> wrote:
> >
> > As far as I know, Profi is enabled in the Clang front-end initially. I
> > remember reviewing a patch that enabled Profi for the Rust front-end,
> > though it's possible that has already been merged.
> >
> > It seems strange that these flags diverge between C and Rust. Could we
> > add a comment to indicate that Profi is currently not enabled in Rust?
> >
> > Rong
> >
> > On Fri, Nov 6, 2026 at 10:06=E2=80=AFAM Doug Anderson <dianders@chromiu=
m.org> wrote:
> > >
> > > Hi,
> > >
> > > On Fri, Nov 6, 2026 at 9:43=E2=80=AFAM Rong Xu <xur@google.com> wrote=
:
> > > >
> > > > Just one thing: I think we should also have this flag for Rust so R=
ust
> > > > and c are consistent.
> > >
> > > Please see the commit message, which says:
> > >
> > > > RUSTFLAGS_AUTOFDO_CLANG and KBUILD_LDFLAGS do not need changes beca=
use
> > > > SampleProfileUseProfi remains false by default in the LLVM backend =
and
> > > > is only enabled by the Clang driver.
> > >
> > > Is that incorrect?
>
> Probably better to be explicit, rather than rely on the implicit
> default value, which sounds like it may be changing over time.

Sure. v2 posted here:

https://lore.kernel.org/r/20261106113800.v2.1.I0b27923381ef34cc99cdf8b65fea=
2e1bafce6370@changeid
