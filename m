Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795612923;
	b=NmiGn3yQa0xqN4Ym9HphCR2/JHgwHzc/kfwmh1yWPOrhEm9GA8+4d1QBiZ/VyPobdw1P
	 v71UfKtnpZZesHUvKJQtiAeAWXI3eYP6VZXeCjI/eFNVtrpRrtv/lf+mxTf3mBHfo2pi8
	 DLMhuS12f6glQp5Er7goOI01Y0TivxDmMBfWJQ4ge5YmOJTqnzuuulL2E4f1Zbnyhj23e
	 BygIUPe5svEVp4XfYAQYay2FbSRciNQxEm8izFLFECE5RevM52yxyqX+o5NBRDEyCVtN6
	 EheXB95QKbfYcb60PDjs/NnIqmx4bLRMXyLkuUmpXuyiwYnu6OfDa2dCMUTmszAEjlw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795612923;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=i9r9UPtioq2obgdZhRICZquaiNExWv3cUxSGfBwpneI=;
	b=XAtQb3QOvE9EfHqhDOlnGd8gX+vClUAq2IOZ+IPq4HJ4TeL+W8u8KhcIi5qTbugVct2d
	 EMzIO6o/+VG7rCySxaevk+IKP5JtTNpFkvTwjOSSCKC8ZO4fnEhUk2tkJVpGLQoRZb5pv
	 2v8h6YcVuuINaz0xrKC7YzSmzc/c7av2jCmCyH4qVWCOugqzUCgCHju3aEaknsV2C53Xa
	 /uO0z5v426gqPPBgGZcNg6RBiAkUCcp1ijfEr3tKpX2HETqywzC3etNbT1McIDQmnBrX3
	 dKNBVE4+33C+pd2sgNI7XgjQvgtxSnD0Ic/2tS8F3J61BqFaAhIehjLW0yoGyoGJqVw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=opSEdQTb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6288606A326
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 13:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6288606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=opSEdQTb
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso3606018f8f.2
        for <stable@vger.kernel.org>; Wed, 25 Nov 2026 05:22:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795612921; cv=none;
        d=google.com; s=arc-20260327;
        b=sepNGhqWd9xigVNWeAabJSA8GhxyEVelJW4oO2KS4Q1F9BosMIOzNJCtSiEs60ZxlF
         uziyIskmKLWV/9d0iDwmWgzNKZ/HZ587Tx8eXCzNaRl57jCTvRLot9wxS9UGhx90d9v1
         EITkEXvroYe038up+SuYEKBjLoa2km2q/A3PNn/LuJgwWZ2fJ3XblRo72HyfXjbVGnEr
         Qn62d0q0bZDkYyvFZxcgHHu8dnmhLGalZIcfut2FUeAgjATs34/8rZvtW2iVclI0R2oa
         LlSLqrDuI2UfAKaJFCuB68BGIHzWcopgV8ne70igvXLT6Bvw8SDcReMZnKcq59h+3N4y
         4T1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i9r9UPtioq2obgdZhRICZquaiNExWv3cUxSGfBwpneI=;
        fh=nlX2cLMMeGR35uZfh4RchkaIro0yp+KVn88ANm/vCCA=;
        b=oTO1vcNtN+v731v2Ole5rT4ANqcNX+bnDEHAAuiqnf7MgtFSuhpfUWl3iK3ec+Q5KX
         c4MNh5GTALRJuZ27re00R+RtfytGUNUqrxvHIet9ZWbUUEDrPL1YBeBj1asikRI47o1f
         QOZsrUUF9gIDCwrAfD5P1KNyLtkyWlJoNQBWRlBQrvxZERlRuKp+c53+lBladXIjHw01
         hPAMMJNeV34kE6jCzTjwRV9F/kxrE0FblJcZN+zBELFRniZmin3fK2O5AAW4VWdBVkGR
         5VG45xx9e++a/R9XFjqIESjA42TsFCEx9JG4hez+G9jmOKGVJCEGfDot+ARByPouX2y0
         FyXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795612921; x=1796217721; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=i9r9UPtioq2obgdZhRICZquaiNExWv3cUxSGfBwpneI=;
        b=opSEdQTbB7rgsyjJ9BhIF9Grz8b8sB9R9IGgbDOXEPXF6u8P9tys2nt82Xr1hix9Lb
         8r1U84bKZE3IfywQtRNjB6DXi365U3bKGvDwwm6VW3FzLWLZUURNvYxRxaOrBsSaAF3b
         kmNDGoTQEXpo/V/DeQYIVVeUTpl3WNO658iG8xcNyiddyqdPNjTz39B9yYIzXeV9jOM1
         eBgDDjK+4rWvtPTrY/fZ34EkLwKoOeNSLrjB4uf8ZmRWmAtbyI2zBNE4I2XxCCfPgGWW
         M+VtL2OnG2s5Qyj9fFaREcdfCGYPh0zITb0diJNUfQQN76e9tViR2JTBDY23vcp7hYjZ
         BOnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795612921; x=1796217721;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=i9r9UPtioq2obgdZhRICZquaiNExWv3cUxSGfBwpneI=;
        b=Y5Wpi0NYK5bdHb6hYj1yFUGmKM8oUF718d5M/paEOxnpL5tThSGpcKPFazEH0VYYqw
         I0HC2rkjFMc+fJmjcUWcyHCex3ahtmUym+8ymZRuO6Q1u+M0MeNGivhOhS0nSd+ySz09
         Khdmk7IM0i8Om5SHaldJ6C+PhmMK+5q4cZaiReFgHyVkHNeUYTSM8+58aluy6Kn4k2zq
         twg6aQSFMXOveEOy9Q7bFe8TfGnwrmYpT6KtBIqWRyoRUA2GUkXz20CX3t59pMOw81eC
         ScpIcHmfPiHTXN2d0di43ElU3a6Pms4TuOXXZA3QwlwtUb4bTduekGeYtTa+S+dzSw+M
         nNnA==
X-Forwarded-Encrypted: i=1; AL+hErGfvTsilFfvoxtCOTgpDxBZ2HIhO3E+gIkUyBn6O6zkAGsPKMpJZOCQKyPOberwYm+w3Od7Grk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/rQS5YUqxviuhWFRxzQEdu5bdqp8ocyqETpN7TcLrxk4PImTiQ
	M/toTaGJQs1yvGr45K3IU/tx9ZAjeogYH5HjXSTLDnxKxfNHogO1n8LupXH8YDAxxGZq/XoMrj7
	Lp7VBret9EhBpKz0gxFHcvbxfyo/nyWY=
X-Gm-Gg: AZFdTZdMLGOCJXgr6Tq6kSlOS6wcPuFnaoVqOYYGw3oo9IX13gowe7YvbeLEGalhd5e
	0rGGfABqtQ+cMka5t8HXOp+rCZ6dq534+sIavEhUd/OatoV3T4LnzMrvcH+aUCQ2/hB+Yks4U5f
	J2IKQXddLYMPW8zGKRxBw/oejBV7GPo6U8CVvh8ey9H+mg9fXxy0OokibxJsmU6MwLjxqSeU1tx
	II9XMBxJTyB+BpueM5F4eSsR0C0V5YzyfUZhR4pu+Gd8DPfD7xVT7/OhuYf2Eby0KgfnF9kwgY+
	MGyhB30YOnTH61ZtgpSJyf9ujgY0PjZa9647pP/sLWkpgTk9IJc0qi9gvwkbbvwOEGBgrOqZLT+
	BCHuMOVZxQf/ddvCmX0on7tI27FJ25regC1Q3A7GNCA5ZN96Qq7s3HgJOfsPF
X-Received: by 2002:a05:6000:490f:b0:492:a72:9303 with SMTP id
 ffacd0b85a97d-4abb47b242fmr34560131f8f.22.1795612920985; Wed, 25 Nov 2026
 05:22:00 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-0-c8079f8f569f@gmail.com>
 <20261125-upboard-pinctrl-add-intc1057-intc105e-support-v2-4-c8079f8f569f@gmail.com>
 <awXJ3Ki8i9b-Kokp@ashevche-desk.local>
In-Reply-To: <awXJ3Ki8i9b-Kokp@ashevche-desk.local>
From: GaryWang <is0124@gmail.com>
Date: Wed, 25 Nov 2026 21:21:49 +0800
X-Gm-Features: Aa3M54p0xO3lEZyqglSCQSV8T77pe3-rwZ_B8_WgOtklEC3zCzvHR5oUtvb-Z6A
Message-ID: <CANYHO6pSi9G9N38+mh5610XcHATV0otOr+6rJfiW=kNEyy5sVQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD
 GPIO OUT not function mode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Richard <thomas.richard@bootlin.com>, 
	Daniele Cleri <danielecleri@aaeon.eu>, JunYingLai <junyinglai@aaeon.com.tw>, 
	Louis Chen <louischen@aaeon.com.tw>, BillyChou <BillyChou@aaeon.com.tw>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 25, 2026 at 1:31=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Wed, Nov 25, 2026 at 01:10:38AM +0800, Gary Wang wrote:
> > The CPLD I2C pin mode setting through pinmux-select is not correct.
> > Should be set UPBOARD_PIN_MODE_FUNCTION on AANT0F04 devices.
>
> > CC: stable@vger.kernel.org
>
> I already mentioned that it's better to use 'Cc: ...'.
Noticed!
>
> > Fixes: dca2f73cf19f ("pinctrl: Add pin controller driver for AAEON UP b=
oards")
> >
>
> No blank lines in the tag block.
OK.
>
> > Signed-off-by: Gary Wang <is0124@gmail.com>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
