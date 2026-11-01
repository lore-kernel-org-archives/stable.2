Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793512133;
	b=A/1mGVbkw1dtnRZ778+wP2IBrDalsWPMA1Mh23DhiWzqql9KH3UpzFoOdAeuevxBBZgH
	 Oq6YIrJh+fshVBO+pu9JHbrSFShg2mn2o9htr6w3WkvEkde0Hw94EKEP0braFjy2CQ7eD
	 ghcoDFRByknqiMgr73r42a9Nvei4aQiv9WUSqt70YgnWZIAvc1/GqCulkTMKJbnVdSyze
	 YCyZPJdnu6Ssl79120xX4vYT+F54dAm1ZHVEmFPrkF7NhZpHGjA6183rBM4uMo0J5eWf/
	 HdK2oCFD84DdaT1Ii+LUUWSDJzgcrmM4KV+W7EXswctRWPYaiapwTw20QGMFh+rIltw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793512133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=EGfxVHVkcrYrQKGYWR3trZufepOrJ+7eV2izdTVo0N0=;
	b=AZW5L/fsBQ0/zzTAp+7dW/vAk4ELe5i2aSRpxsc6lhWl3c2w1W4n0ovJ+FXC2Dms7jaR
	 3iOuGQUlf7drk4Y8kw4e8AOgpghe7X/CvfUP8fsO+02kkKrz+9+rBU1ygvF6mgmgIVCJx
	 sLsMwOsAdHoI5mMaD9nPSf5lxAorZRuJPYyXTgSFWm9SAjnEHUNyG4S+ukcpfQ1pRZhV4
	 CMD4oyki4v4DtxEzE4lOVy6Tg6iaTu7n7nVBQq6a2AfqNvx2q+PMcAMZt3B7JLcOT22pL
	 t8lHx7aTxKw721oqKx+90F6VGeV3Mmcj8q0cOa7Z5B98RTAyTNObgImWCQn9NE8Um/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weyO2K2Z;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4CB3606A325
	for <stable@vger.kernel.org>; Sun,  1 Nov 2026 05:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B4CB3606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=weyO2K2Z
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ac97e45a79so18854241fa.3
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 22:48:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793512131; cv=none;
        d=google.com; s=arc-20260327;
        b=Evk12GFzaMvOAPs6prBHIEEkdTahxPlWC0yzYNMaj6wZ/hjmk+GWBNtiTnHzUNYpJI
         pVpvdgeDmytNwavTcRIJVGkj4APCz9fQUXz4AWhkvf4NMaAyOS9ArN5tNiGQWIqxEeqI
         dg80PSeMQCCbsqKVoetPQK0upDG0KvdVcE+GIWu8c2uVmrQTHbHSHSWT168Wj+XudQZq
         VNsJSBQv1PduN7csX5vYKDQTe6yrDIYLrE5fc5Oy14CFIBuINrKpm0YGuxOhFyrBjufB
         EICeDuoiGypQ3W/zrcimNdrA608DEmZmHKV7EGGkm02anCnqKzdeYxgT8Sn5modH3NK5
         LYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=EGfxVHVkcrYrQKGYWR3trZufepOrJ+7eV2izdTVo0N0=;
        fh=OFLVdDOMQ0kRqhCqR72P6+RgLpbIUGb9Bv5vt2yHKIg=;
        b=DJVQ3VVADs3FOhcvjxB3Uevf7mi5fRrC/h8qx0dNIjmELpGd9XLFNBHyuD/5EK/11G
         /F8NkaWkF7XFujYyvGap7uTNYGggIQqyXqmIKfW9g6xbH49JcWKPeABrDhkYyyL42peg
         EdmLXmfK0r4DCGQ/TEOmP3lONCdBAjytVBIY0Bnk9sTQUGy5e07qTzgD1xiuT5CjBX8m
         wR8L4YIGQcaTa7efxp6oVtHJ0yqatkJEEXk6lRyuVZ9u3CjXg3WltUCx1X1svn1f9Z4/
         w4Ky681vRXdySmbn1xKUgnv1AjBvoRWBaqUxo1CQhqCnx5AVyvT0rH8iVVY/xUlswNlZ
         vl+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793512131; x=1794116931; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EGfxVHVkcrYrQKGYWR3trZufepOrJ+7eV2izdTVo0N0=;
        b=weyO2K2Z3b0LzD/hEyODcUaTMjso5EY+pHzgpgsO36+Go7wri9KGFzwbOpt11QlPm2
         hM6VRrvJCFcWqLlRbdvtdLrcIYxwb1is/W2btLLeBpycRVMvHNZbAnya2ep3XFu7aQHp
         tr2F1uocntttl9YlKlF6ntEWPU/tKGg+OIUkiDbF+AutxMPipzwlq+Ki0KkZRJU0bWo5
         yal59Z9UAq/4hrOU00lGv0fUtxZ3/op2fEx+6Vk9zJlgyxOAYmvwVQGH+7vACMaGArG7
         4TVwXsSvd9lVy+56qYxm0lfSpTgf9Qllc7GxU4poZR+lZM95d7xWc4aNnJqwwVpoJqMk
         QpQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793512131; x=1794116931;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EGfxVHVkcrYrQKGYWR3trZufepOrJ+7eV2izdTVo0N0=;
        b=vIu4I7enT//IZ+Z5WtUweOZC9HvFEUU0qH5knTlHAHaayXrvQjqm3BmDqlgd+RjxcD
         tJ30bay6hvfHEoGvprlfhzQHTxVUfBXUrCCFG5gbdajaEHeSKzFTcMkhSsXIQqlNVW2P
         hU9hannf7kW2Q9FI+oVsRfEPHUUI5xqeBxFRwyI/HKv4cP/MB1ttWdm4p2mRzG3JM6c7
         pZPPAHdruke957bE5oITnXpi4DU/eMts6ls2Y5X0oXLxgg8ibFgSuwEQJMTWtzeT86Zo
         hujurFNP3v3xtEzCLGFAHc9mHGUlsS0LJoQRvBIkHLkNu7HhPzqWsrQRU9CWxv3mwPTe
         o9Xw==
X-Forwarded-Encrypted: i=1; AKwUvBxIC2kM6bi50ynCcQ76PSGulDdRIc6sHK1h+lk42k29n2XvnYrL044dWe2aBlATpFz/PagEqeY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK6bHq4qbSbO4CyZAiHsD7Un/8aOdUfCK0pwPWdaR2z7sQAxals
	K82LgE+9/Ho2c80k49tHe1pDMsxZgHOG1ucsEzJcqAxwKJ2Tqr3kBp69VKwyaX48ikJHJNIsw6C
	vl2gogwhgDFIg/Cc+8OTlPJM34S9bozA=
X-Gm-Gg: AYBFou0jBABhE0z4i/PUI2TWvibrQSaED0Khmj70LAcc7VLjH9T8QGFsL7BBDYxfpFT
	GYy3gdvaZZAmmbOaN7S7xvhtPMTdO0abj9yd6yFhSEpHWSxMUF7D1v0enYuSJM5Xt2Ij20GsqQ1
	W2Hr1ff16OhtYRhcxaIbtMIshMLELyGmpn+3cM5aKF8rNw+Oa6EvqgS/2vMVacKV2jHkEjkn6zL
	GzFiD5ZmLe7cJQsRIC85GSGNFN+GpMAf+vBDl3ppkB+zDoYOLamJFowXzZH5fJI8mBoh7/LFIod
	wxq5tP6rQ0cu4R3FIsy8QJE6SHmCyn5bkjVFm74ZR4JCMQPMUft2x1Wf/xP9zXEN3vfE/eC1sUy
	853h3JrtGrKAgWkPTGvO+A/UUFoFIm3Jb6XWM6v8EAfL0zuVzDskgwyuwRWJ1QEqBkUVo5NqAst
	r1JE/VNihLVeagDn1XlhJL5U7XNob4qNvvUjfRIaBvzeadLC+uU5M=
X-Received: by 2002:a05:6512:1252:b0:5bf:d938:b808 with SMTP id
 2adb3069b0e04-5bfd954bb21mr2075584e87.1.1793512130701; Sat, 31 Oct 2026
 22:48:50 -0700 (PDT)
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261031133455.3070233-2-rsalvaterra@gmail.com>
In-Reply-To: <20261031133455.3070233-2-rsalvaterra@gmail.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Sun, 1 Nov 2026 13:48:13 +0800
X-Gm-Features: AclHuK9Oijgn2EhPzsnGywVMmHQSWFg3blfXJ7nFJaMnQXGzRvyU2SOiQm3Go7g
Message-ID: <CAL+tcoB6vg+-w1JZdND_cTN_zPeh76_+-W_NU34jkunJUFwrrA@mail.gmail.com>
Subject: Re: [PATCH] tg3: make depend on ZONE_DMA
To: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: pavan.chebbi@broadcom.com, michael.chan@broadcom.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 31, 2026 at 9:36=E2=80=AFPM Rui Salvaterra <rsalvaterra@gmail.c=
om> wrote:
>
> Since 614f4d166eee, on systems with ZONE_DMA unavailable, the Tigon3 driv=
er
> fails to initialize, at least on systems with BCM57766 controllers. On a =
late
> 2012 Mac Mini:
>
> [    1.226623] tg3 0000:01:00.0: Unable to obtain 64 bit DMA for consiste=
nt allocations
> [    1.226718] tg3 0000:01:00.0: probe with driver tg3 failed with error =
-5
>
> Fixes: 614f4d166eee "tg3: Set coherent DMA mask bits to 31 for BCM57766 c=
hipsets"

The format is not right. And please target net branch if it's a fix by
changing your title to ']PATCH net]'.

>
> Cc: stable@vger.kernel.org
>
> Signed-off-by: Rui Salvaterra <rsalvaterra@gmail.com>
> ---
>  drivers/net/ethernet/broadcom/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet=
/broadcom/Kconfig
> index f0bac0dd1439..c9875daa043b 100644
> --- a/drivers/net/ethernet/broadcom/Kconfig
> +++ b/drivers/net/ethernet/broadcom/Kconfig
> @@ -124,6 +124,7 @@ config TIGON3
>         tristate "Broadcom Tigon3 support"
>         depends on PCI
>         depends on PTP_1588_CLOCK_OPTIONAL
> +       depends on ZONE_DMA

Did you verify it possibly affects those kernels without DMA config?

The blamed patch seems correct, so I think you need to root cause it
instead of adding a global dependency here.

Thanks,
Jason

>         select CRC32
>         select PHYLIB
>         help
> --
> 2.55.0
>
>
