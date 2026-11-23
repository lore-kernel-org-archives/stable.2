Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795466394;
	b=0W+p5GOR9StERSM+uTOqLN3yeGmuQxhFWN8LCxHIgpfNcZC1VHI+SUutQwezA3eTP+rH
	 1wzlyVULFRSCu29z3x5AvqSRIv9Mub3kJvoDEEoygT7F4/PEr72n6y4LiwjTXEMS52Ubr
	 TP0L9Z4m6Rl52mkJO9gIyWjmarQ3gD2bx/7/UdXP1VpiKPuf7JtwdWvCHgW1OrtqExIbV
	 K87v9UFbUbS/HHBXoNY+2XHrQv4BJjNIkuG6F/Fe5dy5MT0xiEkw00xUcVjlesMK8ZUNt
	 Ka6S0H+J8LdVNl5mKx8lRcwhMGeuCZYYt3MHESVwzdVRUiRyyZD96XICw3Q84O6f6kA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795466394;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=nMl2tg7zBR1rlQ3Z80sjydvjC1TlhDIEJG7iv6AnATU=;
	b=CaSCCKV+3vMdAiEo2lrNidWwvq4tz1ULVYLpAZXudfXyHc79gxtozCzSWMy6Cwk4YhjD
	 sK4ACTxEW+dKI+E/PytY1xHup7oDKnvvdw3GuMY0KOS1/XsXPbb8t0Q3+dmweB0nIF6WK
	 AcKZzFY8zBeF4v801b7TIqXqSPkRt9KLtDg/dMsD3bwSLmWDcGSPnMnGrGNie3WCcIcI1
	 M5Zs0i13kUt/Hu1mGIZ274/WEntnqY1Zien2jqAkgvHxtFK+GPU04R5wXbap6atm2tR9X
	 hceYTgJz9L7efIw5C44jvQheFEu7dRQWsTEE1gzV39EoN8K0YoJrQFGaDbK3+VFRH0w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xyho0CaO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3222C606A321
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 20:39:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3222C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Xyho0CaO
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4bb69f5b161so24445395e9.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:39:54 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795466392; cv=none;
        d=google.com; s=arc-20260327;
        b=jFKvUuYj/XmsOrHAjHYGGYyeeYGjnq691HR2/sbcuJHJ+2F6sHxIzDHafKY6utsGY7
         HWTs6kuafH0PXyXLw3yk/NWSf15bOieSGl9NCJBYtZCdkDpXboT3b3cO4jbBbWVa7YoC
         mcfYjH7rGJXAhj4rDoXrhc3WWjWEmM6IQThcQI2oGQQ/qSTL9nKAsJi3Zoz8E+789l5r
         wQ2W1eaL9Xx/4Z7UuaL9H6AHz5gXREqKvBUBZrkpI8o61Fn2keVEC+TSzOE6hsab89as
         5IRRnAdaS1YZ/SfRCsiAVQZxvMJvWjAjZXjk9BoSFqjXWiKJ/YKF18Q8MwoqutRi6qZ8
         SK/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nMl2tg7zBR1rlQ3Z80sjydvjC1TlhDIEJG7iv6AnATU=;
        fh=onnrgQqH+1/CDFwR5/E5/cIxjTuYocqrDD8Z/AzxDVo=;
        b=A4/KS+0nTHtTTd9DJr0NXTd9VxnbpL67T27gWScgmrpdt04MTMkUNMbq81WcInQARH
         z0jOc4XR4fQCVN12auWmsxC0og0J3/H0+vqpu7wX+lP/fm8XriBmSJVtkXTw64UDUlcL
         aApon0df70nH58zYP4pcmpZxBVoP5OEPk1epwkfNmxue2ZplzudyxCuSRJvs35WbfcLe
         TzwqfmmPKEkSKPQYYvVZUwdT8vRKAcxPjYq4xdfk2eZWnI6UXtgCecxJXVy7cso3fFz3
         dRBd6tHdnimpJj7u+a+9jKRj4QZfC7JcZDX0Xg5ieX7qLCtalz7gRo+O5p3pnIxxd2gw
         QjrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795466392; x=1796071192; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nMl2tg7zBR1rlQ3Z80sjydvjC1TlhDIEJG7iv6AnATU=;
        b=Xyho0CaO9ajf+CZo2ue7LaRGM1afwxl+5LXe5Ql/Y+CA0QzR0QQBDuSW9pn/klcz5i
         dO0A7l1p9qyq/N16q8UL56mBsa4XH71zxHkkEs9iDBxnkXgIloz5WDHGf+9n/Jl8yzaA
         LI0UHXF0/tBtbqHumvMNAGiubC0/o+TPaXMb/YlhxumFz48uDdv3oL3vUiPAi5nPfqtk
         dsKvuZZF9o8E/e8vvgAIcCZ2Tw8YFbE8l8H7f1PqBqeb/y/sEWUKJVO98kuwMaKo0jfr
         QAIiM1iJplZcrW6pTsSqEp2jS1NN4YlhBiB41KgIK8oC1XaR6HmuKNVrwo7r1uhUVofc
         E9cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795466392; x=1796071192;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nMl2tg7zBR1rlQ3Z80sjydvjC1TlhDIEJG7iv6AnATU=;
        b=rc3kted0+u68l2oLOdcDDDkMRtHUfETDf+UbYvs9JNarXQ9KV1W9Fs/QUHf0CTYn8f
         T99S0vz6cM7ltPafn+DpvfPwbwxO5EiksPjNlqV/1CqFMOqtZNYb1oHcERvFZ6e/H8s0
         mk+ke8g+fg//+XU9WB1n6qHwF3s8gIr8Nb10VIeN2m0n/Udx5NKx79nOQNBXQYqFbx3p
         qGn6ZIKkZ+MFlbK96em7yfK5qEw8MhT77LF8BditdpfJcm8CzfCj1cgTocAJP1EfZcS+
         zclYppYY2kmlxju37SQEwf1JRpP/hu5qn+4Pg5GeFgNksMU9vwaUGiPxBARHoHkJJT/H
         6RSw==
X-Forwarded-Encrypted: i=1; AL+hErEBu65aMHvbXeEWvFkEIVZBDA33jU2up5GaHAI1z3lQCcaPknbbyJqKmYlCUctmS1ey3h7oDAE=@vger.kernel.org
X-Gm-Message-State: APuU4Z/f3EENLsZiXsT2+T4LW8ygbdQ06A5+ax2PCTdWNSqxhTqBZ1aO
	PjsnfWB+MhG3qJAE636vNVuFk1XSxZNinbduzjdHoUyTL/BSRmCETEVomOoOff2iYSJIonvOpUZ
	V9XuY0sr0PpWAxpwszPYis0aQYcrv4Bk=
X-Gm-Gg: AZFdTZc2mqE3OG/Y/HS6tQnGr37TjnMgSrf+jSFhy+bMy+OdK2zrJX9uK050HpJo2WB
	FLuvPXFBLEhjeVcva99sHXuoEL92D/K8KJw8guRg8PJmkBUc2x2+p7/i1HnFnECfyPTfAtCR5Xn
	t/mg2Gulgaa6WLNw0EkbS2IqNRiW/I9krIJcwQ2bFZZ/5Ogp3lBNRtg0HuZEnmksCxGPNZ837eQ
	VpOyyE4rrOXxRTRRZhHz3Fi3ODoTRlDIZKyICcZ1/KF7FQq/aa1JQ+vGIvsma+GZOaqSMupH6bT
	10MCaDh/Nb7wCcWnZ7xFCNw1X4DO9x194iRl6K8NSDhb38lNfAZfPa1CJGf/drymKIr6WDM4W3X
	DqUrxTX3RgLl4v7gZnf6PEQW/G0P8pHPtGLeXYsU=
X-Received: by 2002:a05:600c:a085:b0:49f:e8bf:8f9b with SMTP id
 5b1f17b1804b1-4bb887ca0dfmr280208775e9.4.1795466392388; Mon, 23 Nov 2026
 12:39:52 -0800 (PST)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-0-f2322a91686d@gmail.com>
 <20261123-upboard-pinctrl-add-intc1057-intc105e-support-v1-4-f2322a91686d@gmail.com>
 <awSbkAjWErc0ac_n@ashevche-desk.local>
In-Reply-To: <awSbkAjWErc0ac_n@ashevche-desk.local>
From: GaryWang <is0124@gmail.com>
Date: Tue, 24 Nov 2026 04:39:41 +0800
X-Gm-Features: Aa3M54pW8nTndfc2YkE4XIoHXj50vEdpBOxgCjgICpgYwVEehODt65XRpbec5kM
Message-ID: <CANYHO6qir4Zb9TBG+JP36=tCpQdf+uUiOwv5XurP7XGRz5GnSg@mail.gmail.com>
Subject: Re: [PATCH 4/5] pinctrl: upboard: fix I2C pinmux-select set CPLD GPIO
 OUT not function mode
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Mika Westerberg <mika.westerberg@linux.intel.com>, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linusw@kernel.org>, Thomas Richard <thomas.richard@bootlin.com>, 
	Daniele Cleri <danielecleri@aaeon.eu>, JunYingLai <junyinglai@aaeon.com.tw>, 
	Louis Chen <louischen@aaeon.com.tw>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, BillyChou <BillyChou@aaeon.com.tw>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 4:01=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Mon, Nov 23, 2026 at 11:16:17PM +0800, Gary Wang wrote:
> > The CPLD I2C pin mode setting following uart & spi used modes array
>
> UART
> SPI
>
> > on device AANT0F04.
>
> > CC: stable@vger.kernel.org
>
> Should be better Cc: (CC: works, but looks non-standard).
>
> > Fixes: dca2f73cf19f ("pinctrl: Add pin controller driver for AAEON UP b=
oards")
>
> You need to read the AI slops, test them and add your formal SoB.
Tested, but I'll check AI slops than add SoB.
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
