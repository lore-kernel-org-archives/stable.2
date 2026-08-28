Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9246D55C
	for <stable@vger.kernel.org>; Fri, 28 Aug 2026 13:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787925601; cv=pass; b=YpEC7+m8/6dXzhVAq0f0Sbt58ctByO3/JugM4DRXJAH9zGUEic2CZAJnr+qfSvPJjHaJTL5ykBZM8sRRLuONjeefPti3tlhTv7A8R/XT95beszYAsgGP9O9a513ijPr/1ozQjcDR5fHIdvyIJd5+tmW9YwQijh5evS5O0MHG4Z0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787925601; c=relaxed/simple;
	bh=PLDkatDMFuj3LfTf/LIfXkKvgu8bZZ7TEdRf9Z+1JP4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mvtnE1T/PL1CVReFykiaDS2YTU+D68MCTKy+NqEQJiWR1k+sMYo0B7YuBEO5rcuM7sOJbeCMwVL2tHalPMpVQM1uEX+ikJtEoyEerYMyfKnlLx513lrkGoGR01OMnEmfooAARP1sQRt2MsVaEqldGL3P5Z6Nu+278SbGvkkZr54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AtnER0Bx; arc=pass smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AtnER0Bx"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceaf8a1265so13363315ad.2
        for <stable@vger.kernel.org>; Fri, 28 Aug 2026 06:59:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787925597; cv=none;
        d=google.com; s=arc-20260327;
        b=rLnFgeur4THkcGmD89Snfnu/kBVIOivVWgQ8JW9plVUr2aKizhns3wgqLU0DjQauYy
         X8YQRzdlx+LWCbRD4CYLAlwbRqcuNdMvSIRk+pt7qWbELmgAR+EATvG6lwEkkwWuCzAY
         ZtFjrSbQqdxFW1wqiuY8e7NbuzQfMkSyVp5Onys+PkqL53mwF1Nd+loV7pvWQnb+9yId
         O39co6d3JpgUl3TETukwAxrMT0iB0KV7hzlddETIMtT3f+9YYOayKAeGsA7HVhI2GQQn
         lHzMdC6QdmgHBO6ZhitrhvHZYU3DtWYfMxzXhgajki5bPhY0yTTP7UJQCW9XtLFkAtM+
         lepw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2GfMRvhyksSuSYcJwpV/kMHEmDv12BqauazUIu9BuUA=;
        fh=4A9ZgZ29zleV0tg+b6aUVQRUbjgG0GYNRNbndjGEv/c=;
        b=gH3A59mtFOtTUaS26ul+RG5lour5/QReTvG7cpj8eKq5baCuWz6gUhD5Ssh/FTuP3C
         LPTdWiZOi88zipddXWYNY/ciPiL5bwIMDN9fih0macIsqquCg8Jzoe6zCnU0nR+ZMgg1
         Puz+vY8Xguh56YWOSdZE5YqDrryKlZk0OZMP9yDdG/jm/ZMHdXpe6ftOxCdws+SInlub
         gFXs+h111WJX1R2DuWpyfWdHjxfLDf+PimuoTrZ4ASfiXK6sXPQJhPouRI8byDyjwyPy
         Vs0jbSn+HlbBjhfAJCgKThBaRVafg+YRajLUIR7+6l12lBZlX+o4aMnifLF0HMR592Oa
         m/FA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787925597; x=1788530397; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2GfMRvhyksSuSYcJwpV/kMHEmDv12BqauazUIu9BuUA=;
        b=AtnER0Bxly1hJYGTtR8GyEKYZH6vPsORM/+OpfltLCq8OBF+4n0jmIPUVGtw15zRwV
         iILX+zxOOiN7uxMcBuhcqkS36vjc5YGnZABQ6bMjl4zVJxncaUhypXJhlcWx3z15LOPn
         YUo1x+pAQqtNRmOJoi+4c5yplNvJY1iwAfpO+rffoWgapXS0J+QeWI9vLys5RMqODo/n
         bC3F4DN2e+EOn7TeZXIEirFh7HV1H4+F4AiBj2Sfto9L82dEbsJpYUSCnQ7pRe9GGi2Z
         8b73nHVkgfXKpxZCmPJvO17yMwukwHY+u9OtcXasKCp4HyQOZRNCv5Jy2P6mlRzVOTZM
         sWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787925597; x=1788530397;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2GfMRvhyksSuSYcJwpV/kMHEmDv12BqauazUIu9BuUA=;
        b=UxC4fxWrDu8G3R2GlkTzVm5V6CaXUuEc94hCCS7n2xVlcDxmqcuiGn16Y3Y7gDPXVG
         buvBtcAKHJHbMcGdPpKqsbhCthUYqhITgbg3eBOE/2Yr76IyCCfzKnsXuKJAPdvrLj9k
         q3NmjtMQ8syfDp9EfufFe/TOr0PkMCikCvhLBmGaC7HhUVTRYGSJVJSrd2Sq9PYZwXon
         rHakx3gnrjwSkP0fHLOw1rd8xN8XcJkK+LpcLeW7+svvumWh6D3br3CMY3glqQwnWMKw
         FImwd2rod/cUUZpkOBpi1RmaQ3bpbJ2frL+AnCDKh/83VFYw+gcP62EHTl3oOSXu0Kq+
         xAKg==
X-Forwarded-Encrypted: i=1; AHgh+Rpc2lUNfg+hkarcIQso2oZSo1/MiEMYM5x529UOXDovmdqeuzBN/o1ra3R0wfYbdsY1L7BHv7U=@vger.kernel.org
X-Gm-Message-State: AFuF++nGNUXRYR9uZy7/bTQH8IGraQV7rmEDrMqUoKbegsz2zbtChRKE
	2LCzIIBpcKgFwEIoN1WzwCCVvqHohpzmUSOqfS9N8mRlgxtIVTiHIG35HqOVzwx911hPGIDCSoZ
	g1xI6ZO2YQN9tfwRjmpwBwHr1w7gv8G0=
X-Gm-Gg: AR+sD10fAhqQB8P6cPkpDUph1+gFOGe53/zxlgqWZk+qm0Y3VnisKkgq/weEu79PZsW
	wFukh5rj+4a8Gf67qF4zYHEZqTfCFOOvTEgYy8jDOOp0bYmuwzSDU6/PJnSKtrHysD3iAJ6kSu3
	Oqn161FhUVWDbAIbuAxpi00HeqBR0+f6FgA+RaSAcxKlAiK+PwysPZbFgZCba140uTe8cIDOLiK
	Cub47phqF8QJKT65+2PNfexV08Ju22IJFiC7qnDpJzSX3jIcl7BHpIyk/W8/CchavneqUcGaGA8
	7ycDJIqjkY/h+4d/Lyq5m9F3M6QijVtZCBBaFDofdrQvYqw=
X-Received: by 2002:a17:90b:2f8d:b0:38e:4114:d8c7 with SMTP id
 98e67ed59e1d1-396d0a3f016mr16289039a91.0.1787925597040; Fri, 28 Aug 2026
 06:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828032922.469449-1-xuziyougm@gmail.com> <0db183d7-3881-4f81-9e04-cd2c13d1dcee@lunn.ch>
In-Reply-To: <0db183d7-3881-4f81-9e04-cd2c13d1dcee@lunn.ch>
From: Ziyou Xu <xuziyougm@gmail.com>
Date: Fri, 28 Aug 2026 21:59:45 +0800
X-Gm-Features: AcwNN1WIz7kiRjyaUFUv6xWV9lPHFkUCwWjJHmG3pD7abaxNcROmy-pxsGrQvww
Message-ID: <CAF2gcSUVmn57iSo_Vf08+QWHxAoDRbpuone5MOnMd=4c_GhfGA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: air_en8811h: restore AN8811HB LED GPIO
 after MCU restart
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	bjorn@mork.no, ericwouds@gmail.com, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Right, I'll fold that into v3.

Andrew Lunn <andrew@lunn.ch> =E4=BA=8E2026=E5=B9=B48=E6=9C=8828=E6=97=A5=E5=
=91=A8=E4=BA=94 21:09=E5=86=99=E9=81=93=EF=BC=9A
>
> > @@ -1265,10 +1258,19 @@ static int an8811hb_config_init(struct phy_devi=
ce *phydev)
> >
> >       ret =3D air_leds_init(phydev, EN8811H_LED_COUNT, AIR_PHY_LED_DUR,
> >                           AIR_LED_MODE_USER_DEFINE);
> > -     if (ret < 0)
> > +     if (ret < 0) {
> >               phydev_err(phydev, "Failed to initialize leds: %d\n", ret=
);
> > +             return ret;
> > +     }
> >
> > -     return ret;
> > +     /* Restore LED GPIO output enables after MCU initialization. */
> > +     ret =3D air_phy_buckpbus_reg_modify(phydev, AN8811HB_GPIO_OUTPUT,
> > +                                       AN8811HB_GPIO_OUTPUT_345,
> > +                                       AN8811HB_GPIO_OUTPUT_345);
> > +     if (ret < 0)
> > +             return ret;
> > +
> > +     return 0;
>
> That can be squashed down to:
>
>         return ret;
>
>     Andrew
>
> ---
> pw-bot: cr
