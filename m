Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B881137883C
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 02:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785377832; cv=none; b=ss5ipQnenkmiE0M7tpqF0To0fo6uwhzc+5oFzRHEV6S9oHzcvXKOoHD2xrQ4K5KmDE5W8odMo+REzwXiSR8W4PI140e0XrU9iQZttLRUrmr27H1U5bEGMDNU8H2culxmh5zJXegiSKs3oAp10yvHmuhJmDLjGwppUqZTYS51UH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785377832; c=relaxed/simple;
	bh=khsmZgJKT9/IBeIlvEs/hMaMAC9DItOZ9XBcqu1LjnU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUOiB/Yr+5i9fx+2zc/q16HUXblhw6dk0m9Ey07ZOho/KOVHPD8lmC/2+l9SOTXhFHFw0j4RYTLvVkJx1eskXePsk+gXqjs1p3nuw/Auu/Xkt91woZw0EqDScN5qi2aouTFmoNpo3L62GEBmQXlke8zrU8pW2y1dxuTa9nqwde8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e2ZmvwFu; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e2ZmvwFu"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2cf41bab353so27763945ad.0
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 19:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785377821; x=1785982621; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UGoTLKKfs4+hUb1Adf9zrnlsEvil0MdoNex4bufgTIs=;
        b=e2ZmvwFuHiF1UHhAysi5daU9rpY1HsZKKYVfOlNedkSvvDfFiQwIOaDyPamWxxr3+Y
         4YCNHxFuHK7bcWb2xbhZ6A8Eg/l9IAhyIx3s2vUc7OQgjrSzcLwE9pIbsTYyvwf90tt8
         WnLhaRVC6CPXkCDTYY7B9DtTReMWtb+3sZncUSGbiokyLGwq6zD4x5I7vaxnJw4LjEpu
         P1RlkhD04BkXSbQU481e9bfzoK6u620lbFhjsKu9Zlhebq85nz3V6TEmYKl56MStKJwn
         6V89wTx13iLBC9yphGPi1mMr9FchOaTnoqC+dFNHOpCxWYysGoe0v31dl1WF3p/niJgk
         kxRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785377821; x=1785982621;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UGoTLKKfs4+hUb1Adf9zrnlsEvil0MdoNex4bufgTIs=;
        b=XFs9upsuaHlouy8myD29LXFQWMxPLl/OA1CfJYeCuBtwwxPdQXvGaRKnt4j2ssalnp
         nffPaj+tDtAIEf+Y6NIuqiajlg7/uWbKHxz5XO8/jpeNLbe0ixQWiOROhczCUspWFu72
         JA4DWq2o6mVp3VO6u3aa0fQhmiH/DSo4eX28NJQ1h6rNI4uBqeXAxCaMXgRgGNh70/tv
         jrTBbsDUbBXKBqiibnVV1q7H0Sc8uAVytxeu7ENVMzAQ9EYD6QEoGya0+G2fU7TZ/k0U
         gWuQkXrHi0T0by4KBR1WHIa8Tf84+XTf79uqAiKRQ1FFAo/QzI50Lpihx/6vk0rot9cv
         JCaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rq3iZiuCoq7ApmDAUuo/riw/0lIznN78u9KMWNPhW9n43NXmH2x6EeCGhISmQuoeGEUWorfdsM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsjYKZIDotJe9zuQcCI1QTtbxiK7hRa+QskCh3/Q5sHOQKiO2J
	Dgwq+a+cbz6Jt5csLGrybuJnRFxgfceO5rOhDG/laduzptLK5uZTs+Zo
X-Gm-Gg: AR+sD12d6M2Tz2a+yDIRRYCM3c1s1fd7qdqPe4yyA6a8r0is8mSnLf60WCezleoIoSd
	ys9AUSpu11ecEx6F5SVQ3AoqWS8G1VC/VC7bGQEEAmSq6wg5iOpZB2UXtn0/XQxTljx1ldRqOR7
	vHFFgw393FsGIhQ1+8FO32scaBmzYVt/4Bj3LBawIAA29beTZkU0X7Ux94dqWu6NiwEeecgk3rh
	C/1OZsiyS+Z5wVDxGxg6RNDfzp+djqHesS+u+2hNk/hjKKSLWNvzD+mnAkF9qyvmk4jF0S2/jai
	8CeKmAWOPxibFyCiFo+B6++4rcXa3dHDumrNkwFEKG3YwNdVsn8oDq9hDq6w/1hBxPCuJ9ER9Qx
	55cVnOlZnEPRUA1HUxBlaiXgTs0BYq3CYP9kgv8Ds3AM44Iy3ymBC2OLoK2JvcRbsnot+hVXCLZ
	LUXshqH4/VHXushb4mVC84kD/pf/5sP7VU3GN3RnpzQ+o0lVrnYP3iF5S9WWVW/rpJadHuWPhNS
	VBL6JjG5KjzcL94pUN35tncUW0V1KUrq4bDJuL7ZZ617phVQLENkqs=
X-Received: by 2002:a17:902:e551:b0:2ca:5a42:d8c5 with SMTP id d9443c01a7336-2d035e3c524mr8179935ad.46.1785377820754;
        Wed, 29 Jul 2026 19:17:00 -0700 (PDT)
Received: from nxpwireless-Inspiron-14-Plus-7440 (61-228-203-195.dynamic-ip.hinet.net. [61.228.203.195])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c37211sm18553575ad.78.2026.07.29.19.16.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 19:16:58 -0700 (PDT)
From: Jeff Chen <chunfan.chen@gmail.com>
X-Google-Original-From: Jeff Chen <jeff.chen_1@nxp.com>
Date: Thu, 30 Jul 2026 10:16:50 +0800
To: Georgi Valkov <gvalkov@gmail.com>
Cc: briannorris@chromium.org, francesco@dolcini.it, johannes.berg@intel.com,
	kees@kernel.org, miriam.rachel.korenblit@intel.com,
	wenst@chromium.org, rafael.beims@toradex.com,
	avraham.stern@intel.com, peddolla.reddy@oss.qualcomm.com,
	error27@gmail.com, s.kerkmann@pengutronix.de,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] wifi: mwifiex: ignore ROM regulatory hint on
 WRT3200ACM/WRT32x
Message-ID: <amq0EnoZrBA+8W+J@nxpwireless-Inspiron-14-Plus-7440>
References: <20260728103536.25012-1-gvalkov@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260728103536.25012-1-gvalkov@gmail.com>

On Tue, Jul 28, 2026 at 01:35:36 PM +0300, Georgi Valkov wrote:
> WRT3200ACM and WRT32x routers always report a fixed US regulatory domain
> from the mwifiex ROM, which conflicts with the platform regulatory
> configuration on units sold outside the US market. For example:
> - phy0 mwlwifi 5 GHz, hard-coded region 98 EU mapped to FR
> - phy1 mwlwifi 2.4 GHz, hard-coded region 98 EU mapped to FR
> - phy2 mwifiex 2.4 and 5 GHz, hard-coded region US

Hi Georgi,

Thanks for the patch. I have a question about these compatible strings:

>  				if (country_code &&
> +				    !of_machine_is_compatible("linksys,wrt3200acm") &&
> +				    !of_machine_is_compatible("linksys,wrt32x") &&

I checked the mainline kernel source, but these names are not found
in the DTS files under arch/arm/boot/dts/marvell/. Instead, mainline uses
"linksys,rango" and "linksys,venom".

As a result, this machine check will always fail on a pure mainline kernel,
making the quirk ineffective.

Jeff
