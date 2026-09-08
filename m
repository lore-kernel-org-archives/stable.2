Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FD90559C85
	for <stable@vger.kernel.org>; Tue,  8 Sep 2026 15:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788880374; cv=none; b=go7zIlDYlYbgz4Yr7o+A3uEz4s3fC6Ts+qZElZONFvEDGwnd8ZqnYm+TVybSREASCyjn5At6pL9cNtcX4HVXP6zRREKE2OuBo1nPxhrhtkyTRiDpNePDcRE7aF377J9QQpDJVGDL+SuAy0jiJhXqc50m45rBYMamxZoEKHslRew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788880374; c=relaxed/simple;
	bh=Doj+ZCEyQBnoNJxOjsX1VqYVjYJ/WamXYne20s6EuPw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DniZH5XHWFr3ZuLT4i/qHJGQ/8zm1kOny1LBLG6x9VHg+4X1SwfZQE5wexLOK0+TJnXxV9+huJtsXyquP3u6ePDvNnTvpJC9GkBRkvfOXELURQNJ51+M7sQquk76LVmBowC9jqPahyr07nT7qiFG+1VcoMwHx3GWsOkB+Cz7spE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mbI2GhOV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mbI2GhOV"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49b9320423cso53973635e9.0
        for <stable@vger.kernel.org>; Tue, 08 Sep 2026 08:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788880366; x=1789485166; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XTgfNw2BEojIwEu1GKTPFuPQGMGtUKwmZuzA7RAeACQ=;
        b=mbI2GhOVU5hVYrA6X7OisrHVk6+nFnwrTJ1tYU9BCoo9hbtVC8TiYKvCFhDfDzaHBb
         HWbrCinpMmsyqOj1KCHqMrfGEi5L+0tDp61aoFPoacUTDoyqGyN/EQjHep2H2P5xVCPV
         rCNqZKQoQpgbCFtPIdqrH2W/2MHOUQVX4/ktVv4JYZoT7l8azXpaFuKO5F0vublJr+Rz
         YMl2/Us/mJuAk+Ojt7oWuIAWki0pAz8ua4FuKh9DTt27KiId8ewA8iYFBAmU6RDVYXZs
         F4HfUk76HgQLbQ/NYTns8c32ujbtd1ZwDLJU+CiKqy2yJWHC3xmrXUSLSxjPNu1S2TZA
         VeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788880366; x=1789485166;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XTgfNw2BEojIwEu1GKTPFuPQGMGtUKwmZuzA7RAeACQ=;
        b=dR3+HXlUwj8dN76izkojtytblaN5g7eDzZz8zJ3joVh6JsoU/f2xCmOYfql0BK9UqC
         Lbe5G6OfkyWluptItoB8S8tLgDqx/aNb02eyHQ7wSA3tBsKRnufKPvAUw8ejlcD9dXYz
         ra9jWHtJc5D+JZ76wwXOzIsUSBGvmlgxulngcKDNQCheApsAXoJnaPk6ESzElhD/lh3T
         Y1PWuVkdlrfSkM6GzgN+QpuWLAcktMYB3dD3pV7rnLtxdBAz1IHUio8onkScEDBs+Xhq
         1usZU9IogBrasHVSk6+hL6NAm+56FK4tyIdw24irtHxUoCIeNsktgGr8n74DWgpC62OW
         qJTg==
X-Forwarded-Encrypted: i=1; AKwUvBx2TWFMzGEAePFwjf2u2zwSrq2Ds8LT7cLpccVnewvH3bnE3XYolfldMawWaT/A1zJbcSrt6j0=@vger.kernel.org
X-Gm-Message-State: AFuF++n3FyJtUMG1+jW7oceqBizmGJlH768mS598p2SCD/jd5+dTJbZk
	EXFVblZA9cvk0S241Cl58ufXFkJigVRQXRR5ke4sb6C7XnM50sXbyNv3
X-Gm-Gg: AYBFou2WxNS2If5EM0PqrMRhs7GAdIRCpVp+xOzy8F/8LhxeWm4CTtf7rKydCBE1Pnj
	x0rrO1eb/OUfa2CJIsFauofAXdYaVdjEVPTMxKIxxe8z+wUYfzBtQWn7mBPwOCq6q3/rhoYyLZG
	Ag7aBFjKe7+wWCA/lD2YLF2XckHld+YXlMYzmud+CRmbwpkB1GnJdklU4CjrPGtlMoDKsQK7yVu
	d153kMfMzoa9o6RzchifLNT270sAEZyheVbQ27y85Los3AcxMkDuE+2Mff+7DHZ74mfKutWvphl
	0fL0G+RXzA+lB0Ko0bZlh1DuudIS9UPYlWbKif+aFDHGMxGx50NJUwg8FdWQ+DKFXszZ1rHNnBG
	KLoYI3jLqhQK18KuDdvnOgiB2ONnykBWGfUTrgEGGKJwGHJKTco/+ayeOgejOf96e9xyoRLnfig
	NtY0+u4WZFLbHzcQp9CQNNeNgI1IGDpXXBOkBEN3tZhRGXVxb3f8b2DbielLMVeKzfnKBty3doN
	Mp+zme9uJHtsHEaMySCeOtyFCoZJ71IVatwvWT9r2wqL/R9bmg/vxVDe/bRJwiAxq9E5OqDfanD
	GbzcHWis3Xmwdjn4srCxywvO2VXwB4ICLpZkw5D2haxXunO2guMxQgakDKqr1DWaQ78gZDa4vDL
	hBwnsrc/ju55G0OZu/38lmlvlEp1mlcOoxmE2P7sf8KDGCbtPKbh6teuAinoHLpgtMbSkqFA=
X-Received: by 2002:a05:600c:4e94:b0:498:943:ccc0 with SMTP id 5b1f17b1804b1-49cf81e368emr508972015e9.6.1788880365425;
        Tue, 08 Sep 2026 08:12:45 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee6024a8sm507187685e9.6.2026.09.08.08.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 08:12:45 -0700 (PDT)
Date: Tue, 8 Sep 2026 17:12:42 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, Kim Seer Paller
 <kimseer.paller@analog.com>, Marilene Andrade Garcia
 <marilene.agarcia@gmail.com>, Jonathan Cameron <jic23@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Nuno =?ISO-8859-1?Q?S=E1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH] iio: adc: max14001: add missing MODULE_DEVICE_TABLE
 macro
Message-ID: <20260908171242.00007f88@gmail.com>
In-Reply-To: <aqAlAJEJPrglb2E_@ashevche-desk.local>
References: <20260908114047.1360-1-joshua.crofts1@gmail.com>
	<CAHp75Vd-LTwJU-SvVug3MNPzFYsOQFc7qQ5AiMDjHOx8XNkHow@mail.gmail.com>
	<20260908150311.00000da6@gmail.com>
	<aqAlAJEJPrglb2E_@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, 8 Sep 2026 18:08:48 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Sep 08, 2026 at 03:03:11PM +0200, Joshua Crofts wrote:
> > On Tue, 8 Sep 2026 15:41:23 +0300
> > Andy Shevchenko <andy.shevchenko@gmail.com> wrote: =20
> > > On Tue, Sep 8, 2026 at 2:41=E2=80=AFPM Joshua Crofts <joshua.crofts1@=
gmail.com> wrote: =20
> > > >
> > > > The MAX14001 has an SPI ID table, but is missing a MODULE_DEVICE_TA=
BLE()
> > > > macro.   =20
> > >=20
> > > Is this a problem? =20
> >=20
> > For systems using devicetree, no. For legacy systems using spi_board_in=
fo and
> > this stuff, yes.
> >=20
> > If you're referring to the mark for stable then I'm fine with removing =
it. =20
>=20
> No, I'm trying to (implicitly) tell you that the commit message misses
> the answer to "why?".
>=20

Oh right... Will update in v2.

--=20
Kind regards,
Joshua Crofts
