Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3F233B7767
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731771; cv=pass; b=uAf/LRu216yQNTzZr0o3eVSMVk9PJzOOCPy/GrS8D81ZJ2SVuH8Ry3pil34CmzLt48F6mGVKqNtVudx/jvM72UyPSPCfXJ8743ntTe3C3KHdoWRlm6C5SW4iV0AYW4u7VDWUISlJ3SJq5Rmb56thNc81V89cBe+eyc3BTohZ0P8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731771; c=relaxed/simple;
	bh=hoibuipogw8WclF1xR5HyS23ry9/ifoPowPx6lvjlCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XYQlM05BchYFLiz1WcJs+SL24whXwxyR+1KZvaFWuoKiJSWfMq2y4a/GpQHTQfBeWmEQ3Shq3s8v2/j0NUlH1Hkzyu0ivkYkmJ84B9ZNpekCJUS8PBZ4hJJHUcvlasAKE00d+V7d9fzfAb80jZAHLv+Zv1q10D/qjlVDBMADiro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecvAccYa; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecvAccYa"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66c711b7f2aso1054156d50.3
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:09:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787731768; cv=none;
        d=google.com; s=arc-20260327;
        b=qjOwErNbgpQT1oB2BOTU590M0POW3bRiGvPbVu+vhgzFAov+qPI7aK+ySCXqWFhekj
         WoQNCqRxH5e2IGY3LYHtCR1xGxxyhs9xkrqFmJVYe+PfCJBaMAk3108OCZq+TdGzGQQB
         zXEhYmV9wtXX5c0rmJ7y8o1ZHH7BnU2po8uMVBOjgw9wStFNbR7XH8qIV4dFjwsb8h/G
         s7/vTY6+Q0TcU0J3hLlOImcqzik3yHKbzeD4s2MmGiXTj/R6c0QFIXKZgHeC3YyjjEJ5
         XfM73RWBzHcksCjAzBQsuiZ52BGHmLZjsFoRbx60/zpEVq2wdSlDd4m1mLd2yOR8m3L6
         z93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hoibuipogw8WclF1xR5HyS23ry9/ifoPowPx6lvjlCs=;
        fh=GKjLvhQ/I/JK6ZP95A30cPLRSJFRO9ES6zy/xhavCLE=;
        b=nmKNgq0yGEkp6Q5nT/uBEEIaGVO7zTRPUMk0djF+8LQJrdNnCO4bnUwdls8X4Gyn67
         TB8PJyrqRyUHyCdmF7oCg2Zj6y09uq8kDJegUUxTLaboEpYLsCYmX7sB/4QEgywSnYPF
         th7xfg3/Q7pzVEnaujEEMMqAldNMx7X0YbNFx4cPuYh0YSivXygrbTrJzhy81+Xcr1/P
         5ViuZh+c9hb5nrPZvZiuIzh2CYh6aaMrx/GAXJHq9gBGimu+Rqn2W4hAolyB1OJhzkIR
         ch2Ht3iYRrdYF8+Q23QI6eEOBSRG2s67ctva9yCWzBHh41QBYOW3jckiDvypIxnvOvrZ
         myMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787731768; x=1788336568; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hoibuipogw8WclF1xR5HyS23ry9/ifoPowPx6lvjlCs=;
        b=ecvAccYapRTcorcS95MzPcVqKrG+u3Bh/azbdpQgi8eo0h47B9yrQnTsLNINfuD54h
         zEVwdnE/oY1H9c5zBRC24YB1SwYJuW0ZmGG4skEmNGC4uwhTnPWeXHT3gLz01nv+pCUg
         QYzMZP+W7slPdQh/IrDRmXpLPrfDxuhGdqXPrhfB0q/w6aQkg1nzWVxZgaETsfyZNwED
         QkjXg1sAMUoCSrITuYWtrwxYxyq3gMLb/MSwubB0SyUSNhIGbYRimmDE9L81DskkAQ89
         O2Tfu2OcGdrlRcriKCYT8Iu8+Duljwj2kNs1Z5YaMa6t/QzLRB86EwOBpnG408S3FQSC
         y4IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731768; x=1788336568;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hoibuipogw8WclF1xR5HyS23ry9/ifoPowPx6lvjlCs=;
        b=Z5qCa4+1p2aBOmNDawDipKz+pTVKzn0rDM5nSKP+QYq0L83BNWraYelY6tLTDUhG3W
         bhYrGTMDf5W6Ng4YjuGkn/2zGGiwWtwZIhnAtmz2A2HdcXZHrvJH/CZnLTD/7veDekcw
         J/vUr38GsHSLE1kVf0LGv/X5zOnaAlE6vCBUq3B9rk2dmbJpZh/bqyDYL76qMW1Rtmsq
         wPCRgNKQicXGML3NbQ2OR+UHTvm+i2IeVYBEH7Pfvkes6NBTS7MrFrtAHD2XX9to0DZo
         Y53a8/5JAiEs/qDtm54MaiGupvIzSIiTaXQ2FTYy1Oyn5ZdbM1jXxEdk8YGEDYs+AVCp
         RhAA==
X-Forwarded-Encrypted: i=1; AHgh+Rqawz9Thck58ro2bw7xA8QmARbiQaVNb+NpypEaV+h0vTaa1p3b3PYttP3URCKvSyXHF+Ycguo=@vger.kernel.org
X-Gm-Message-State: AFuF++npws7S+mjWeh+gjD9Kh2+GPM/m1pmy00JLnB7m85USvPLly4Ut
	bi/lObNj21hvsNrEr+CxiTc9aVsgDbnE4aCZP4QYuiSCpoRmXBaZbohYGVU1MttWDilItNhVjJf
	O5K7EjCmgcssZxr7Xq8PVwht8L/u7IxA=
X-Gm-Gg: AR+sD13dH+zgE/vvLKPRsCHKqmtViekcYA6+UbhQV5l+tllDjri7rxxbYsQXeawZ9nt
	SaMP9fVYazIzkFLy4iZZxs1gLsCcr/czzy4HZV6D53x5YNBWCNuC7bx/Wp09FhMZ7a5T9v7GE6w
	nGl15S6X2Bw55clUJ1kbsyeBvZZsucZEBY0t4mZ/rkXgHofeVqRpH0K6Z8ykPwL2pa75Pd+YqRv
	SW4KqklFSJnkXscwW253iKrmg48ttsA0/aVBxbeNYsJLO43A7cu3xhtwYhTj9ODfVKpqFtnWB/O
	mSG+iPN8QUDWlWEkMqyRw5HhlJzi9DbG0hVMil+RkXdBcVE=
X-Received: by 2002:a05:690e:4146:b0:66d:13ee:2daf with SMTP id
 956f58d0204a3-66d257d9e4emr1314684d50.43.1787731768110; Wed, 26 Aug 2026
 01:09:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260808152654.2943371-1-lgs201920130244@gmail.com>
 <144ef4b2-a200-4634-a4ec-539a0ba9a15c@kernel.org> <aogYAmDqlgmnEd3X@zenone.zhora.eu>
In-Reply-To: <aogYAmDqlgmnEd3X@zenone.zhora.eu>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 26 Aug 2026 16:09:14 +0800
X-Gm-Features: AcwNN1UWlYeU_Fm6Vv0GYzUXavNzpuhA_CQkuRUt3KOhhAYuo0_VKS3Q7UQ3-ug
Message-ID: <CANUHTR-eRRw+uHBzAK42jVmnfEv_zV=_RgPGtiBCjZzjr4PJ5g@mail.gmail.com>
Subject: Re: [PATCH] i2c: at91: fix autosuspend cleanup during teardown
To: Andi Shyti <andi.shyti@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Codrin Ciubotariu <codrin.ciubotariu@microchip.com>, 
	Nicolas Ferre <nicolas.ferre@microchip.com>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
	Ludovic Desroches <ludovic.desroches@atmel.com>, Wenyou Yang <wenyou.yang@atmel.com>, 
	Wolfram Sang <wsa@kernel.org>, linux-i2c@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andi,

On Fri, 21 Aug 2026 at 17:22, Andi Shyti <andi.shyti@kernel.org> wrote:
>
> On Thu, Aug 20, 2026 at 04:50:13PM +0200, Krzysztof Kozlowski wrote:
> > On 08/08/2026 17:26, Guangshuo Li wrote:
> > > at91_twi_probe() calls pm_runtime_use_autosuspend(), but neither the
> > > probe error path nor at91_twi_remove() calls the matching
> > > pm_runtime_dont_use_autosuspend() during teardown.
> > >
> > > If the autosuspend delay is set to a negative value while autosuspend
> > > is enabled, the runtime PM core increments usage_count to prevent
> > > runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
> > > during teardown, this reference is not dropped.
> > >
> > > The documentation for pm_runtime_use_autosuspend() also notes that it
> > > is important to undo it with pm_runtime_dont_use_autosuspend() at
> > > driver exit time, unless runtime PM was initially enabled with
> > > devm_pm_runtime_enable().
> > >
> > > Add the missing pm_runtime_dont_use_autosuspend() calls to the probe
> > > error and driver remove paths.
> > >
> > > This issue was found by manual code inspection.
> > >
> > > Fixes: d64a818859af ("i2c: at91: add support for runtime PM")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> >
> > How many separate I2C, drm, crypto, hwrng etc patches you sent?
> >
> > You sent vast amount of patches, all separate, making it very difficult
> > to track and respond in efficient way. Do not do that.
> >
> > Group your work per subsystem.
> >
> > You were asked to clarify and respond to incorrect fixes statement. I d=
o
> > not see how you clarified and responded at all.
>
> Is this a kind of LLM command or what?
>
> I'm going to check only the patches that have been acked and/or
> reviewed (people have spent time for that), for the rest, please,
> follow Krzysztof's direction, put them all together (or ask your
> AI to do it) and resend.
>
> Thanks,
> Andi

These patches were submitted manually.

Thank you for the suggestion and for taking the time to review them.
I=E2=80=99ll follow your and Krzysztof=E2=80=99s guidance and group the pat=
ches by
subsystem when I resend them.

Best regards,
Guangshuo
