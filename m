Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC5C38DC73
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 15:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053402; cv=pass; b=Iuq68Lnswuysvbr6FMCMNr7ifj2oF9b+ZPd5PqJIEi8NZd8jdtbLIkEpkscumQRZut18V6RKtzJuD+ZJmXC1rWkp6XGjZAyRuB05PIz0T4lb8mzCbyDj5JZQ/XFsplAMv75TGgISnD3Hi+OwatKV2wnHZOvEYFGZOZXcvvh4Nxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053402; c=relaxed/simple;
	bh=IGzkZ29oQC5+zM7j41y1PzuVxI/kR6lS50DPmDPTu28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eYWR+RrRTC65aOrKyTsyyUyuRY2YCvmkjvEUQRUy5W9BlW4Oh/TLsn8vuvRyNyTJMy+JCx6fv/BhB1n+lgbCa/f+cY5I15uVnGU2rLEOryOQxgfvpCb2oDWVNqFKpffhmw9ewiJ3wi9L4fRo+oif0evTBGMOmCNBPfJVQn8Gi4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net; spf=pass smtp.mailfrom=flipper.net; dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b=wj7D5At1; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.b="wj7D5At1"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a99c5de614so2042456a12.2
        for <stable@vger.kernel.org>; Thu, 10 Sep 2026 08:16:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789053394; cv=none;
        d=google.com; s=arc-20260327;
        b=ln/vM4RiHa6B/+VoZYpF7Xg2kqd8cz+TIQPhUHc+wC9WzuBEFNGPY1JlQobmnqPHBZ
         JEDefZmz6e0iZ0pgdzeflqia4tVKo3avdzV++A/gJA/uAQFsCvNFgWyzeaVFS11coCId
         blt3kTCAh7w7oacv3FEXMhZ4kkM5KvinRpnQuJ47WQQ50I8tANtLBQch+0lBTo4xiGyI
         X8nn66A7Qs0wa5Ki/0LOoi9EuH9icHL+v9Yg0Hk3aSEb01QdCkiFcRFLSwUd+wji7sRl
         x3alfu3UfyN4L0aHmYB/ivqC9ERA66JwoF3HfrmJqHgkzCLkkOU+pCAvorfXC48CTgSc
         wzbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ZGkfTmvcfg2tYgnaJgCLfP1/mFjyPE2KGae6+BF91/w=;
        fh=RgMzbssGEGCjiJkJ5OjU6BXhQFf+5ZCp2iZEGNVsRFA=;
        b=dnpXDsBm1accVA5v6buDVE46mXlUazSFc3GzGOTuarctxhWhSOrtYaw9i3V8jit54o
         pU+go0h5HISSoNGHsbhw/qugQnEs6DK4Y80qvyx75XXBZhyNnOzmws3sSqrvySFnrgM3
         xGrt8xDmFu2aRdTWaCo71lca8Je60IGuszkKXVcSocn3jTwDoRy+UOaJhywpjXZJ2vWM
         wa9YjYuR0XFEsNc6QYNl0JBh2jUyaKj/oNAuiaaJtwnRQHYrQRjHe5qkvX8+ux9SejEq
         MwKdYmQIPSf42p4uzOkcKT2uge2sGmZBPHQItBycCcD11klSCKkBixbmzklLj9EhWWVj
         6edA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1789053394; x=1789658194; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGkfTmvcfg2tYgnaJgCLfP1/mFjyPE2KGae6+BF91/w=;
        b=wj7D5At19axXp16LaXN2tFJPiQlLcR+xzCk2HyRFuTeeocJO7icxJpJ0WJYs7io4h3
         QS+N2AmB09ZUsc/RwtDnmG91Wtk18AV0H+ekrZddWFCGDCC9vaZX0ubTzCGSuy9CQ417
         SDLjJz4MyUr14+bweA73T6F+hRTAobaczV2SpaPMBFfEWH9zs47lSLaka+//MUo9ydQB
         mdy7um41CsWqtUBE00QzTh/S3te14xUPOLU+g72gVBTr1DR910+TqInxwqP2LJ2bRmmh
         9mHfsEAgyJJfBUUUSrkoNMNm0+2XHBROEvlm2D390RLz7VP1y2K+9gklJqMj52TTLA4e
         Ny+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053394; x=1789658194;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGkfTmvcfg2tYgnaJgCLfP1/mFjyPE2KGae6+BF91/w=;
        b=oFU0VbOGnTR2FmSKkWRLsEnD5fq5vYjdOlQ1KPZpVmiOkLumiFZ2g5CGzk3D9Ta7/P
         A5hsWVHvmPuFCIVCfnFoFqFS3LhYXTEnirJGiPHyf6Un0j2OPkwXqlu9mRZnerwVMu4Q
         dcj7tzZU4yWKWnJW+V0ldWbMWhBJq4C228/171szm+qQmGddgTbkIMsZfMdadSMCyVDC
         rU/3vBJmxzO333Jfqptxzal3Wpq64HoLcla+OtBvCdw7BMO4PIk//JCQBkt7Vw7DYN4C
         nSJUfsXi6cP+CDVJQ/04joBFx8m0uzCT1IZc4GQtmCNpr+RK66Ns8D1pVWhQSEynTyTq
         KLOw==
X-Forwarded-Encrypted: i=1; AKwUvBzoS0N10Or8g7nLr65wEMpIDda3CYxfD0ckwpAHS14o9BcDhNXf84NCWBVkjgv+c/9wGcKQh0s=@vger.kernel.org
X-Gm-Message-State: AFuF++nf8c6Nh7HesiEnhfZYXTe252FFKXFkxTXmFxtsPJKmV7g6xVZ9
	R1SSUht1n/XWj/QNeWozYVt5adj6OAmlZHSW5s9xs53Zam8okxQ+TQj1wFQJ3l1BNsT42c2Sq2d
	BjspIuap5hXtJUsvnaX2BjjuYZsBugpzpOW/HDPfCPSSSNdFzGGiyqCc=
X-Gm-Gg: AYBFou3zW2B3f4mkgFM3xrxIiKz2/Au8tC+MB6JOiuqYh8ODl2RC9G8HvMphznaJaqj
	MmXcW7gxZLYtSErR4plI+gPLW1YCV6N5CXX8ME9st0FIJ7UH9O3csXfuNZBCPIUZ16mM1/iJyh2
	52qT/UthGDsxoIbvZzEbclVOEEPtSWJahbMSbgXqLNtanKdDYpfVj3C7NuVCucEpp6B1JzlYnUI
	r4epIeqqtF00vt2XgiP397TRt2YilDrsZC6s0lry1EHDNfacZd/awl/jVlpYbOE0Xb5LYVO9reS
	+3QyFNbGkP+XFdgkjTfadfvyVljgs4VQIitK9dUXRcCCRjLQ0ZaqPkq+kzC/hG9xDWyk7rUKd/s
	4PXB94Ih1aCKUGA==
X-Received: by 2002:a17:907:c5ce:b0:c25:47a4:fedc with SMTP id
 a640c23a62f3a-c29418b652emr491393166b.2.1789051729432; Thu, 10 Sep 2026
 07:48:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
In-Reply-To: <20260902-rk3576-otp-cpuid-mac-v2-0-e4b7fe2ab13f@flipper.net>
From: Alexey Charkov <alchark@flipper.net>
Date: Thu, 10 Sep 2026 18:48:33 +0400
X-Gm-Features: AcwNN1UfoxjgFqkNtB6Aosk9zTLZTrJucLfz7oY5DTmBgBUsxij8crpGNXoG4yA
Message-ID: <CAKTNdwH9QAgreJ-6+t1j_P1di4VyoMBSsFkf_g=mCi_-M8g9Pw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] nvmem: Derive Rockchip MAC addresses from the OTP
 CPU ID
To: Srinivas Kandagatla <srini@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, Michael Walle <michael@walle.cc>, 
	Miquel Raynal <miquel.raynal@bootlin.com>, Finley Xiao <finley.xiao@rock-chips.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 5:08=E2=80=AFPM Alexey Charkov <alchark@flipper.net>=
 wrote:
>
> Rockchip SoCs are shipped with a unique CPU ID in their internal OTP
> memory, and Rockchip bootloaders use it to give boards which have no
> dedicated storage for a MAC address a stable one anyway: they hash the CP=
U
> ID and patch the resulting addresses into the device tree they hand over.
>
> Kernels started without that fixup, e.g. straight from the SPL in Falcon
> mode or by any other loader which does not implement Rockchip's derivatio=
n,
> fall back to random MAC addresses which change on every boot.
>
> Formalize the derivation in the DT binding and add a Linux kernel driver
> implementing it, so that a Linux image can use the same stable addresses
> regardless of the boot flow.
>
> Only RK3576 is wired up here, that being the SoC I can test on. Other
> Rockchip SoCs keep the same CPU ID at a different OTP offset - 0x7 rather
> than 0xa on RK3588, for instance - which makes supporting them a two-line
> addition to the driver's match table plus the layout node.
>
> Patch 1 is a prerequisite fix. The OTP hardware has its own internal stat=
e
> machine which only works correctly with serial access, but the current
> driver serializes nothing, which results in timeouts and/or corrupted
> reads (e.g. returning splicing a TSADC trim value into the buffer of a
> caller asking for the CPU ID, or mixing up trim values of different TSADC
> callers). Hence the Fixes: tag and Cc: stable.
>
> Cross-checked on an RK3576 board: the addresses fixed up into the FDT by
> U-Boot match the ones derived by the new driver, and the driver correctly
> assigns them to the network interfaces when the kernel is booted without
> U-Boot proper at all (via Falcon mode).
>
> Sashiko also rightly pointed out a use-after-free in the nvmem core when
> a layout driver is unloaded leaving its sysfs nodes and the postprocessor
> function pointer dangling. This is fixed separately in [1].
>
> [1] https://lore.kernel.org/all/20260902-nvmem-layout-unreg-v1-1-2d16bebe=
b518@flipper.net/
>
> Signed-off-by: Alexey Charkov <alchark@flipper.net>
> ---
> Changes in v2:
> - Switched from a scope-based guard to explicit lock/unlock calls in the
>   OTP driver to avoid mixing styles in a function using goto error
>   handling (Sashiko)
> - Link to v1: https://patch.msgid.link/20260901-rk3576-otp-cpuid-mac-v1-0=
-ea9135270fc2@flipper.net
>
> ---
> Alexey Charkov (4):
>       nvmem: rockchip-otp: Serialize reads

Incidentally, patch 1 of this series also fixes CPU thermal throttling
on my RK3576 device: apparently, the mis-read OTP-programmed thermal
trim values broke the thermal governor logic, which now works
correctly with properly serialized OTP reads. So it would be great to
have these merged.

Best regards,
Alexey
