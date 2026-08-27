Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E94AD3E44F9
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 13:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787836159; cv=pass; b=mKTt6JvRmSkQjzkmligcftFox4zDYL3oEmBaKdxstwTlEcsVk+4d1oGaaw2WOKudKU5TfRFAFO0d2BTV1Rg+QKcvSpINBXFztUSJTqtd89hOhQmLRJ3KNpVG9jBbG+yssqpxo7iqo+Y2aMR+y40OFjrNY/vr+MsLFZTvdr4So+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787836159; c=relaxed/simple;
	bh=yVbl3Z9HVr6Uibx2P5f7A2CJaisyDJjFLYgGyEoH47M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LeFi8G2NS1reidH55MFt3CYY+vvdsE0u2BugFP+iSXXWxCg30bECyUYwYfhuir5NUlhGazqhUispQs6feZIvA+bR4EGlSkxUn/Csmmq2fTIKvEM1pnL+AW6EkbMKwPX+Nr0T5TXZ2LhHPJgs2GZSWPPEsXynhzVlpbA2Gta5Jcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lRcTrciv; arc=pass smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lRcTrciv"
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c86945164so17471921fa.1
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 06:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787836145; cv=none;
        d=google.com; s=arc-20260327;
        b=cQU+srnd7fKMcQOYUYS/ljIjZcwmhmWf5oRnrq9q9nkULKy1K0tfwTsMzOl4myrjHf
         P0PrOTuhmUzOaJUV894vIFJxyBgHlO3e2RrcQesLlAo0LysfHhUaqyVRWw9L7cZ1+EHt
         p/KGzgYyjEv43LgW/aFK5ZZMwNUNUjFwz4SeqLT3hnD72+qY8NHnOKEai45VEab7X4d/
         sgFOkbotuw9bz5TES+9SnJd4srogCFIjcYxcTj6ie/ew/PG0EM7183SbKCaLkGpWgCNf
         TnaMr37ZnL0YdxtG4PetnK/xFxCJ0+ZolhTCxqBJEGaWOxx0tffzrQH5OwtZrZM4RMGE
         CoiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=yVbl3Z9HVr6Uibx2P5f7A2CJaisyDJjFLYgGyEoH47M=;
        fh=5b4BCADoSeaounrRkaNFQfNm6IDLN6IIUtq/N6WU0zY=;
        b=joydXqI5MORJsckyMzSDa1ThKDIFMxPaqaCkQC/hlVCuulsPt3PmfEFinhlwrcsllN
         wsPjLjF2B8tqXnKuF4fqZ5nOlVmUPKPFanDzGBmcTeC4GTqyGBU++7E0/bDGo10xQX0x
         UA0Mgr0sjny9+dCB/D4sjQ+cVOr3p1cclVHcI9xZBzahMEg2cgcHR3KaCh4DA7VAPhkG
         XoIKaD/MOpfcdjTVn/U8yE/Wxx6sHrv+Obzo9KXiyeN46jTaCA5tB9ep0ICi7nnz7JDe
         5dUy+3oVcnSvVFaOxR3XvEazqzuvBbFrdr/e4u+F2yZMV0XpjgMA+IGMVCdA0FpKMQoj
         QJKQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787836145; x=1788440945; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yVbl3Z9HVr6Uibx2P5f7A2CJaisyDJjFLYgGyEoH47M=;
        b=lRcTrciv1tpI+038IVPgCI2tC2Pcj6vTAlv+YwTWScJuGM4KIs5fvLPs3iLlRepcd8
         AdoyoJLWwxxvYyFHX1e8Vrly9rpYjMkUYmPfyLUB3ebqKwIBSdiB7pXJwi8iA9WaMSxB
         IBhFCqTLUDfJ+VQjvOtZ8RDl5NdtzoxL1rUDrKwfTkkgAOA8khrsn12UMfyXWZmOne/l
         AcMVSb5VCFypAc8pyurjApvpr2NtCKy7Z/KKJsMWspF8VIFzfY6Sd4qGkDwseP32tF54
         mxNQtguRbY57Gfq7Ease6C27QqN7v8YjofkIHg1zkG0uKKk69kos5EZ+laUGa7rZA1c4
         mOVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787836145; x=1788440945;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yVbl3Z9HVr6Uibx2P5f7A2CJaisyDJjFLYgGyEoH47M=;
        b=AG087nVX2WTUztHI6F+X2UCPYbhaVb6OKojvkXpaPjuMWOH9yEKWA0v8rznJa9kBSv
         FrM7NzZzIpZbv090Ema3oMTKWBNH4aCxeKKKAyo/5T9MF6leTONtr9tBODaPu69sNSuT
         sPV9aniNVl8ejD4nE+LSh7PKe1MGIXSNYr9wfiTtOHHVBmSK8xt5vVUO3iLtH3+HJqtI
         GmNFGp24oJnJbQHF+fdTtAmQd1vSuuxpJlo29RkMJm/OioVLTrhlvjzrXK31qK6S+Z+X
         CZeP10L+CtaHpM9Px3uzIjpT1qqbjHFBmmA/lq9UCDVYyaX6sPkUQhoxIB95RhR4kV+5
         zPgg==
X-Forwarded-Encrypted: i=1; AHgh+Rr8e0xHpwHkHDe4md1StGySOER+GOXhCxR+dNLZAu36Qn8UiZsQSmTW60I0FNliL4yjHXMFXA4=@vger.kernel.org
X-Gm-Message-State: AFuF++nYJn6zp8CMm78w4obWKPw7KhjuzNevLrErEvtmh2XfP6mCALVM
	uArR1IOYXTC/8+hbkC1lxsGlvdKShQ0JQ/UQonbgx9aYJ/BwA92TYTJNtTcmSDHlUxDyouN28yz
	ZgMDSb/Y7GbhGRg08ilQiY9K2jDDjIMo=
X-Gm-Gg: AR+sD12Bq18qjKRiIPmZu0jy1msunqbamOw/o0qjc4j+3JmfcAPNKPH8P58Sf8DgNPe
	HrJxjUOcJHvynvnXzssDzP5Kna2zn1m/a+qE/dCQsUKsquju9LGtZU/T81lMJPMKi72eUF58qlI
	RLnFA7b0KqOr+a8ATc5TSOP6lE3DbHJ4mLuaueZyfJl8uQbP+0aCz/+wh0sx9W3z5K9fxZGl/BT
	ZyJi6ug6fs2qyWAVHF4eaKF/9BEasOTzG9mE98YDPf+M+UBmEflu2XXk1sEv3d6yn02DopuFnSK
	N/ib71g9U77v9QFM2NXJP4RtnIU47zhYSWujoMqcH/7cp46jCu9iGjjuRKTTOf5XLD9ELjApjLk
	384DjuxfcHhBc40C4ladkPdJA2OhPqsGft+EwuGVjWC6pAqDkLCu1FPT6Sw==
X-Received: by 2002:a2e:be27:0:b0:3a1:d468:f988 with SMTP id
 38308e7fff4ca-3a1fd453e09mr37025921fa.1.1787836144417; Thu, 27 Aug 2026
 06:09:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821010728.45065-1-gvalkov@gmail.com> <20260827-helpful-icy-donkey-9bfdaf@quoll>
In-Reply-To: <20260827-helpful-icy-donkey-9bfdaf@quoll>
From: George Valkov <gvalkov@gmail.com>
Date: Thu, 27 Aug 2026 16:08:52 +0300
X-Gm-Features: AcwNN1UImZDtg3-upEabUa_XGggulmtbmlnjP2_UXhZYxbNMdjonIxEdG5ok4DI
Message-ID: <CADOrJmaF0UpRefk1+BDyn5iU5La4ke1gFWwzyRr5-9wp7Zr2+A@mail.gmail.com>
Subject: Re: [PATCH v6 1/3] dt-bindings: net: wireless: add flag marvell,invalid-reg-hint-in-rom
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: briannorris@chromium.org, johannes@sipsolutions.net, andrew@lunn.ch, 
	krzk+dt@kernel.org, francesco@dolcini.it, johannes.berg@intel.com, 
	kees@kernel.org, miriam.rachel.korenblit@intel.com, wenst@chromium.org, 
	rafael.beims@toradex.com, avraham.stern@intel.com, error27@gmail.com, 
	s.kerkmann@pengutronix.de, gregory.clement@bootlin.com, 
	sebastian.hesselbarth@gmail.com, robh@kernel.org, conor+dt@kernel.org, 
	Frank.Li@nxp.com, chunfan.chen@gmail.com, arend.vanspriel@broadcom.com, 
	peddolla.reddy@oss.qualcomm.com, linux-arm-kernel@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 27 Aug 2026 at 13:34, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On Fri, Aug 21, 2026 at 04:07:26AM +0300, Georgi Valkov wrote:
> > WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> > from the mwifiex ROM, which conflicts with the platform regulatory
> > configuration on units sold outside the US market. For example:
> > - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> > - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> > - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US
> >
> > When the system boots, it detects a conflict between the user selected
> > region and the radios, e.g. BG FR US, and applies extreme restrictions,
> > preventing phy0 from starting on any DFS channel. phy2 works.
> >
> > Add a device-tree flag, which allows affected devices, where the radio
> > conflicts with the platform to ignore the incorrect regulatory hint in
> > the ROM of the radio, so the platform regulatory domain can be used.
> > This does not allow the user to change the regulatory configuration of
> > any radio. It only allows phy0 to start and operate according to its
> > certified configuration.
> >
> > [1] https://github.com/kaloz/mwlwifi/issues/173#issuecomment-307879699
> > [2] https://github.com/openwrt/openwrt/issues/9956
> >
> > Cc: stable@vger.kernel.org
>
> I don't think there is any bug to be fixed here. Support was incomplete,
> so you add a missing quirk, but there was no bug in the binding.
> Binding was correct.
>
> With stable dropped:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

I added Reviewed-by to the first patch and sent v7 with these changes:
1. drop Cc: stable, the first patch only documents a binding
2. restore colon after Tested-on as requested by openwrt-ai
3. mention the added wifi@1 node
https://lore.kernel.org/linux-wireless/20260827130335.6606-1-gvalkov@gmail.com/T/#t

Thank you for your help and patience!
Georgi Valkov
