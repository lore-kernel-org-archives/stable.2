Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7622B3AFD0F
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 07:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785397635; cv=none; b=u0/AKeYH1ZumV5wtWN5aQRzX9QueXBzvU/KjkJx01l+xg/gJYl164fAh2gxr17ceDCV2eoMNwSvKNW9B9ozDS+HT6rHj1cpp/jeqhThCxsMOYwRrEisGHnhqNSXuyA7tFmto9XVo/d2RrgSzQ9LGhMVWoQuwlPdeuZn9bWDLklU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785397635; c=relaxed/simple;
	bh=D0KaS0Yk9tXGLsfg0t5EIZQa50X+fKdqYZwmCb5nkuk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urqJf+ApTC7gOKBRAkbyRmaOozuwfrK+CleyE+hPrOxbHdKezisJqSK3Oc+ntZ31I+IPswo89U9eZhEeZLjM8z/yA47BnIycza88molpNY7Vgd3yYXfQkoy1l/0t12GeH3zLKTlySlYk539unoDQMn018lKRkH8RRTAOct7z0n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PFNDasSw; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PFNDasSw"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-84eb992a881so370398b3a.2
        for <stable@vger.kernel.org>; Thu, 30 Jul 2026 00:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785397634; x=1786002434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qT2/Gj6C3LLD04ewfQjlm82kTvMsQwWc7jtbFYONwk4=;
        b=PFNDasSwqMRjIbYsZc4UBEBV9DUeTVrVZDPfQLnbA/ExpEutGwbq2+14VDvL8XulxS
         k9clJuW9b71qOpPEBOONjzW1WuR7ggZXHes9e/2MYiTk679lgYvpZtgchpckeFuyLhEN
         ISweJT2MytHSLrdWkcjeKuMSdZruITHgOgVwkPeMDKmgg9PZKVe5tVcz8s6PyCoWDVTe
         P7qB9Ndnz61/PMU3ZAiaVI+OcggOsHiuL5T3quLodkOjNa8kyNrSwC5BCiTD3SuerdDm
         nKJyadBmFTpcHDclncZ13b2fiJOPYxVSV4/kSQL9i3m+sF03bvl4Ua865SlOX2Hto+CX
         +4lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785397634; x=1786002434;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qT2/Gj6C3LLD04ewfQjlm82kTvMsQwWc7jtbFYONwk4=;
        b=G9mTmypWK4/b5iHAUrXljtv+dm4946HgYJFXFzIiO+s9frem/YcQS5uGAbt++icuzx
         +jaqWMaGCwukYypJE3Ge07xMMSjMTcZIdwOoUjC40N2OPvWbGLr48vQm0NKmQvlNMZjM
         Ql6QpMGh9uLRgLNzTZ0GKQ+A07tdWUOIbesdsDreZ2bj69ZJdEFxIoTSchROj7UVnOep
         naRxIDMyncQQ52dLmgW0T0hqi30CtwuE3S2xBn9JKnsmR0H8SontqyDy9GjR/lCa9lwA
         iw/D9pqtTg9ELJKb8tncCFIqSq+nTg5sx2nISwqYYT/ad/RoFd1f7NUNmFUXyCwG8R2Q
         XXng==
X-Forwarded-Encrypted: i=1; AHgh+Ro7z8V/83bEcH1/jJoRSvru+EQMk1fiz8XOX191/QvoLU/yz7cCM3gZgzu2smrHznkqWojBAB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWi/kLdRDY5BCb4SmZQEgoAeLfNNWQMGp+MAYtcY/7GX3U6UXB
	jQyHcmOXc7x/yWX6v/2gudLy/ZkdXnumt/VPdyF3C8dzY+SpqFw1i5CX
X-Gm-Gg: AR+sD13Ipf438oOe5xFHQkVsFkUQtr/RpkjS5vnwiQjc0gp2A3DmhMp1qTvBCIdojpi
	sBSaOPjor3e0KpPvRI0HignoEs99LoFjxDKMs/Y2J6VBb1Knw3o2WQWBUPNL18QYmZp8scC37jF
	lNFkadAqOuxsKFrtmX9PgzNlHg/CXJLAazuP8myaD7XKzvp/gjTOIsvP4zkO+C7ScIRryP5V0+B
	lophWBuQp8g0kOpj35aGqKwsgMCB+8GXSe9nfTRiiDi6hrLGUjalZitJ4/T6ORP5cS6JDPDDEGY
	APfCzZ6bZrbN88s19RfWHczND1thIJdlxmCK8xxZ15rWk20gTimNb+Tet36HPjgdlouO7Hhj3wA
	aGG8fLS6ixnWGxXTTJK0JTd4AhrMB88yYoYYIktvuQVAdDVQWEYro4Q4z4zT+E3u7Z8VvMRr//B
	89c6Nd9IRXcYuQSbRFOKJ/ljsPogv2SzPHZhi8wSPzlMPMpSCcNAPmRLuMqc4ax+4qy8X/VmlP0
	RAeWrO79ZLXuhfgSqQaHvvgfyAetNmemt2RWdx1dSvBKleHqP0Wy24=
X-Received: by 2002:a05:6a00:1d27:b0:847:9c3a:b77f with SMTP id d2e1a72fcca58-84ebc3eb0b9mr1599711b3a.35.1785397633653;
        Thu, 30 Jul 2026 00:47:13 -0700 (PDT)
Received: from nxpwireless-Inspiron-14-Plus-7440 (61-228-203-195.dynamic-ip.hinet.net. [61.228.203.195])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea02ff637sm2607204b3a.39.2026.07.30.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 00:47:12 -0700 (PDT)
From: Jeff Chen <chunfan.chen@gmail.com>
X-Google-Original-From: Jeff Chen <jeff.chen_1@nxp.com>
Date: Thu, 30 Jul 2026 15:47:06 +0800
To: George Valkov <gvalkov@gmail.com>
Cc: Jeff Chen <chunfan.chen@gmail.com>, briannorris@chromium.org,
	francesco@dolcini.it, johannes.berg@intel.com, kees@kernel.org,
	miriam.rachel.korenblit@intel.com, wenst@chromium.org,
	rafael.beims@toradex.com, avraham.stern@intel.com,
	peddolla.reddy@oss.qualcomm.com, error27@gmail.com,
	s.kerkmann@pengutronix.de, linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: ignore ROM regulatory hint on
 WRT3200ACM/WRT32x
Message-ID: <amsBes9fCF9ZdkCS@nxpwireless-Inspiron-14-Plus-7440>
References: <20260728103536.25012-1-gvalkov@gmail.com>
 <amq0EnoZrBA+8W+J@nxpwireless-Inspiron-14-Plus-7440>
 <CADOrJmZKdM0y6jeS7oOK0aKm7BaqcDB=BmXTSBrFTiTqXHhUhA@mail.gmail.com>
 <CADOrJmb=_uNHnnqswMAN+LTNPHnRARqF=MicFTP6C5QoMxH4Uw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADOrJmb=_uNHnnqswMAN+LTNPHnRARqF=MicFTP6C5QoMxH4Uw@mail.gmail.com>

On Thu, Jul 30, 2026 at 06:24:15 AM +0300, George Valkov wrote:
> Hi Jeff, I forgot to mention:
> The compatibile strings are added by this OpenWrt patch:
> https://github.com/openwrt/openwrt/blob/main/target/linux/mvebu/patches-6.18/
> 311-adjust-compatible-for-linksys.patch
> 
> So unless we also upstream this patch, using device names will work
> only on OpenWrt, which would make the current patch ineffective.
> 
> Georgi
> 
> On Thu, 30 Jul 2026 at 06:06, George Valkov <gvalkov@gmail.com> wrote:
> >
> > Hi Jeff,
> > Initially I wanted to keep changes easy to read and as simple as possible,
> > hence my current patch is based on device names.
> >
> > Indeed out openwrt-ai also caught this:
> > https://github.com/openwrt/openwrt/pull/24458#pullrequestreview-4803923901
> >
> > I've been thinking about possible options:
> > 1. Use board names "linksys,rango" and "linksys,venom", where
> >    rango is WRT3200ACM, and venom is WRT32x. But a venom dts
> >    is also not available in Linux. We do have it in OpenWrt:
> >    https://github.com/openwrt/openwrt/blob/main/target/linux/mvebu/files
> >    /arch/arm/boot/dts/marvell/armada-385-linksys-venom.dts
> > 2. We could either ignore this or
> > 3. Have another PR with venom board support files, but that will require
> >    much more research and work. I don't have WRT32x hardware, and I'm
> >    uncomfortable doing this without supervision.
> > 4. We can also implement a dts flag, e.g. ignore_reg_hint, which can be
> >    set in the board dts. This might be the best and most flexible option.
> >    My experience with dts is almost zero and I will need help to implement
> >    it.
> >
> > Georgi
> >

Hi Georgi,

Thanks for the update. My recommendation aligns with openwrt-ai's suggestion.

In general, checking board-specific DT strings inside a generic driver is 
not a good idea. However, since implementing a new DT flag or module parameter
requires deeper driver architectural changes, expanding the list of compatible
strings is a more pragmatic way considering these are legacy devices.

You can update the check to include all four strings for V2:

	if (country_code &&
	    !of_machine_is_compatible("linksys,rango") &&
	    !of_machine_is_compatible("linksys,wrt3200acm") &&
	    !of_machine_is_compatible("linksys,venom") &&
	    !of_machine_is_compatible("linksys,wrt32x") &&
	    regulatory_hint(wiphy, country_code))

Combining these four strings ensures the patch works in both pure mainline and
OpenWrt environments. 

We should still wait for feedback from the maintainers or other reviewers 
to see if they prefer this hardcoded approach or a proper module/DT property.

Jeff
