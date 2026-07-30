Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC349382283
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 03:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785381871; cv=pass; b=uzkvJqqlCSaz/tt6lviN/tlBEBMeEZoNAx1y9lCdyjdag3tnRtcSmavFLwqQZGFbgzMu5wU2wOhQKtdCUmZujOlEbKrc8BTI4JgRRQmprMrxWExYq9o9Ds0YQYLaExdd9Wt/rawcB9D2uM4e9sYAMvbsRjn1a+BvbEi4ej272TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785381871; c=relaxed/simple;
	bh=XHg40f1gJ/YIvj9Si9YNU/RPMmZ5XfcIDvaNQCDpNwg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aO2wA7YJ87PwAPyEzQXqiqRx4Jm3B6WIFR8iyP2ZinesfeyZaNt0s9nh+4B8vO1Mj84DYwdeKn//f1SJTbdSSbMjonbxmI/FoWufRRlGmCYh15Vde6PIJUHIteuWD7M580BaTAYjHFDLStZFrIoqzvuhhQOc8rfkDcStvbiO47E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r+CyZTg9; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r+CyZTg9"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b015532f7bso1527063e87.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 20:24:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785381868; cv=none;
        d=google.com; s=arc-20260327;
        b=Wr2cfEozR5FqUWrWgJ36KDLCaTZTRsuCvnyG1RdBpeiHDfydkSukHAZVS2pt9cctq5
         k0+Rlqi2kPvy3YaC9gTypdra8y3cVIt6RAII8JfFfCzBveHoVeN0cYRyr64CqRyjcUZx
         d12oqElzxtIU1FdNpHxXTMb1aRh/YfaAW/pgtNek+Zb7CnK7Jzhwzkh8LGxhcWlohmj0
         by2FTY95IseI1c6MT4qczd7Jyr4+Mdq9pED20V00RMK1bJr6IHDgt/ZIX29mBouGuEtN
         IG9pLdexJMZsUkwCL59EDJvCgpjwapK7aLbHE1lcNGom88m0nF/O5gNP5GdCdBSdnMa7
         7PrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=czSucy7zlmDRprNUvvGm2utHsJougpvDn6kozLJOcKQ=;
        fh=y2MnsId/UpW+2sGBYihYFbOnLO+6hZWerkFYYMfhoPA=;
        b=gBV4KN78m6uNX98S506jIuQDVblrAi1sDfcWLy//2N17FefmDGUdUvCcGo1rhrhX4B
         63nufYDoYSgnkOjnSiZJVV5woRwRzbnGJaHuWT80i+qoiqAw8ZD99qa2CKVtXdRJk1+x
         BO2Zcxpoes/BnBswo/cvREV0/JjmzXW0IKFFk25UTwWiQOOei4jlyVklwGulM5XLA1/t
         wMOQokGgRaMdpL41O2PqP1MVx2QFEyO5qTzbG5aqcCNQy00S6JfwRn1h8ct+ZiVvKzL2
         HWjWdkOvvpu3gyYI9tZLYiuHmpRZDz4l6t0OVh2frd/QeAPTuU+57tN6+u0Im2/uEwT7
         G40Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785381868; x=1785986668; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=czSucy7zlmDRprNUvvGm2utHsJougpvDn6kozLJOcKQ=;
        b=r+CyZTg9WAngGfsteFMObpjdYuxuRw82C6kWsRZcr1xE8x1nFjXuPmjaE3J3XjLb5u
         A0UG7EA7K0NMKuOsJhysgbA5BJF1TE7XiAOEb44Pfx6GGMucH1cMwlgBfUfJbIAQL42H
         FU3c3Dp5NqL48LUT50PzT6MYqg2KdnfK21qJ0gJczQWCIUQQb/TYU9hKKS2LHHLN00Aw
         P/0653GznNt1uYgPV6kYrQajw6prHGj6F3AVdRSX2BXcB7EDscFBbZZZO22f85lcN0qC
         5wiKoMf15o3hPTp3HR/LjdeHx1hR5SBPHNVvljbOPEWKfk2c0KM+DyThIWA2Xs908Vmo
         BsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785381868; x=1785986668;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=czSucy7zlmDRprNUvvGm2utHsJougpvDn6kozLJOcKQ=;
        b=BuvbNwdqBU3WoB28R9M8btIFuoe2BnfggY2URPa7PO8nicmkdtSFYuAIcOzIV0/coG
         nQsWHObd+A5tFYkiGEADyVvo5W7oONRn2z3R4v2ZL+RBdA0Ebs0iL+GUpJwSV1rZ0WjU
         f1+oFjdsjMg+8itxPPA2F/43T6dItf5zJ9yI1G/kNQk7G2amAfmDg1mgiYp/9AKC3NY9
         LWEirB17RS4DkfMHnQoa2t2BWi6qN9T1Zi7E2vTTiPbdh9AZy/zLugCVhxMBFYdUQoXg
         +Uoc5FCCKqc7LLYjNNocNxZEt9tRH8jyZbFnEe3Dsb67FdCOBC8aqODn96c84M/IXuLO
         NCig==
X-Forwarded-Encrypted: i=1; AHgh+RqMuPCa0A17V/jF8zjm5UJVdFveTTSn2O8Kz4vO4u5xLb57ptL3UbvjYB+z8Za0oBi4I+57dxI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH9dWMxGpbDacoj1HvPVJXtZCHaBDSiSy/QrtGwC72JsvIAr4v
	tVw+7YIys5xkPwkvt7tSSdaS8ZnfQov+Q/h5kSWXozSJ2dtSM6N6TK6iWrDW1/NmTbgxa1oYukg
	Z7R7cj42W+gCrjbe25UBLxVbdg1JfLOM=
X-Gm-Gg: AR+sD12imcTzA5oC52Bbhap2DPEyQk+zN5GtNY4ndWb25V+tYKOB2bYy7/Fycr7tR+z
	MyuaiiS0c8Vn9HDEbfzE677v4gidokQWgfRYLKHmNw4ZGL/unMrxN0lEdSVrsEv1kkDwqqE6lj+
	fUYli97tADzFEbxil++wSP1k9Bs3DBYWRvRmEgVWxCWV2WKrl8bnWd7GFxkgbwkLeuY/qt5vIPm
	dslpI1EBFRVjKZ/3jAQ8BlT/X+ed79KLlm27lgGzHIEP4IKkWuN7BhfOdsPLiZGm4w0NtLtsoQl
	lHFnGWoCu2RfyEXAEnFo1HENJszXMBk959i5CbHP2PoKwqH4QfLZYLUyaQ9vZKaQPHv/2qUoqIV
	1cerQDV3xsvDbSueGCYDVfEjFxDI=
X-Received: by 2002:ac2:4e0f:0:b0:5ae:be47:f006 with SMTP id
 2adb3069b0e04-5b2db391e67mr122170e87.43.1785381867775; Wed, 29 Jul 2026
 20:24:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260728103536.25012-1-gvalkov@gmail.com> <amq0EnoZrBA+8W+J@nxpwireless-Inspiron-14-Plus-7440>
 <CADOrJmZKdM0y6jeS7oOK0aKm7BaqcDB=BmXTSBrFTiTqXHhUhA@mail.gmail.com>
In-Reply-To: <CADOrJmZKdM0y6jeS7oOK0aKm7BaqcDB=BmXTSBrFTiTqXHhUhA@mail.gmail.com>
From: George Valkov <gvalkov@gmail.com>
Date: Thu, 30 Jul 2026 06:24:15 +0300
X-Gm-Features: AUfX_my7RmQB3ea64gFTkqlTnLieF4yzIpHcpIeqSKcu98ezcAV1Ujrhvwx5QWc
Message-ID: <CADOrJmb=_uNHnnqswMAN+LTNPHnRARqF=MicFTP6C5QoMxH4Uw@mail.gmail.com>
Subject: Re: [PATCH] wifi: mwifiex: ignore ROM regulatory hint on WRT3200ACM/WRT32x
To: Jeff Chen <chunfan.chen@gmail.com>
Cc: briannorris@chromium.org, francesco@dolcini.it, johannes.berg@intel.com, 
	kees@kernel.org, miriam.rachel.korenblit@intel.com, wenst@chromium.org, 
	rafael.beims@toradex.com, avraham.stern@intel.com, 
	peddolla.reddy@oss.qualcomm.com, error27@gmail.com, s.kerkmann@pengutronix.de, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Jeff, I forgot to mention:
The compatibile strings are added by this OpenWrt patch:
https://github.com/openwrt/openwrt/blob/main/target/linux/mvebu/patches-6.18/
311-adjust-compatible-for-linksys.patch

So unless we also upstream this patch, using device names will work
only on OpenWrt, which would make the current patch ineffective.

Georgi

On Thu, 30 Jul 2026 at 06:06, George Valkov <gvalkov@gmail.com> wrote:
>
> Hi Jeff,
> Initially I wanted to keep changes easy to read and as simple as possible,
> hence my current patch is based on device names.
>
> Indeed out openwrt-ai also caught this:
> https://github.com/openwrt/openwrt/pull/24458#pullrequestreview-4803923901
>
> I've been thinking about possible options:
> 1. Use board names "linksys,rango" and "linksys,venom", where
>    rango is WRT3200ACM, and venom is WRT32x. But a venom dts
>    is also not available in Linux. We do have it in OpenWrt:
>    https://github.com/openwrt/openwrt/blob/main/target/linux/mvebu/files
>    /arch/arm/boot/dts/marvell/armada-385-linksys-venom.dts
> 2. We could either ignore this or
> 3. Have another PR with venom board support files, but that will require
>    much more research and work. I don't have WRT32x hardware, and I'm
>    uncomfortable doing this without supervision.
> 4. We can also implement a dts flag, e.g. ignore_reg_hint, which can be
>    set in the board dts. This might be the best and most flexible option.
>    My experience with dts is almost zero and I will need help to implement
>    it.
>
> Georgi
>
> On Thu, 30 Jul 2026 at 05:17, Jeff Chen <chunfan.chen@gmail.com> wrote:
> >
> > On Tue, Jul 28, 2026 at 01:35:36 PM +0300, Georgi Valkov wrote:
> > > WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> > > from the mwifiex ROM, which conflicts with the platform regulatory
> > > configuration on units sold outside the US market. For example:
> > > - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> > > - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> > > - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
> >
> > Hi Georgi,
> >
> > Thanks for the patch. I have a question about these compatible strings:
> >
> > >                               if (country_code &&
> > > +                                 !of_machine_is_compatible("linksys,wrt3200acm") &&
> > > +                                 !of_machine_is_compatible("linksys,wrt32x") &&
> >
> > I checked the mainline kernel source, but these names are not found
> > in the DTS files under arch/arm/boot/dts/marvell/. Instead, mainline uses
> > "linksys,rango" and "linksys,venom".
> >
> > As a result, this machine check will always fail on a pure mainline kernel,
> > making the quirk ineffective.
> >
> > Jeff
