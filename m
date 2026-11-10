Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794326146;
	b=3vB0qdtdhB9KrF1Ed4lZOgTYIs1OWF+x+a5uz1+K0iXVpfg3RzESNm3WHfN2IF/rPfBa
	 7N5NXR8wNNuQmtUcIMjxYzPpy43VVhquktOIzbS0KZlQr3UeqTvTg89fuCy3Zy5V0ZnYr
	 bJ4LQvG9iFp+fjJDK17SwQux8m3KvCfNTF6V6KoVAI6+24zKMb3dJk4AWOHyyT0gjEk76
	 bvP5NH/GiPhFvTxzgWel3vtfX91/Ic/qJqpIwLEA7Kd639PJU2uyoKe4fDG6HKHFLBi+j
	 8uXNpvThGt1lw86y63PI+dcNzE/9BC8btDlvEfhA28c+nhTQFWMQBi9FucEC3OY5srg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794326146;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	bh=aM5tBn3ODTZ1/FCzgvJ2PUNZD7PoTyZUo4VRYYi2yLY=;
	b=3WOUS8V3Deqc6JzVuBkezy+K4mCzFT5Pza+vBpR4WbkeyBqFjzJCpkiMm1SNpbniN8vc
	 4UvgLZgIrwWfHEQme9mMJoDSXaWXXk67TLaqLTBFCFxeZyeAFb0zcO+ilt6EK8QdcYHNu
	 tQMkk1PIzfr9ek1HiRzqB9HwKAuiNGqnNe/fdmGzgo96mfSkmsYZkxWBvAcuplZJtGrIU
	 8i5oaB/nuJU0d5wWPvWIC966UOxVeUZck8p9mSjorGYT1MDSYYjEr7PrSGzADhTroNlkv
	 C2m5NfdBI53b/bXYT6RxVOXJoeXdTJ7hX1FIdyRiM8MtC8m9Y8GePpVBDqjLUnrdhhA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JC8ZByDM;
	arc=none smtp.remote-ip=209.85.128.41
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142F6606A33D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 15:55:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 142F6606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=JC8ZByDM
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4a5087a5348so18858205e9.0
        for <stable@vger.kernel.org>; Tue, 10 Nov 2026 07:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794326144; x=1794930944; darn=vger.kernel.org;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=aM5tBn3ODTZ1/FCzgvJ2PUNZD7PoTyZUo4VRYYi2yLY=;
        b=JC8ZByDMjknsyEpwTuwVgXFmocCEOhUTrbthwhiblOhrsWSGvDJo7/Rg/6oEFhuNUi
         O1ygA4AJMvLYdlLXB8F/Ic71Fa2a+fpsHV54QBhMrofde7CTX+mnhHq1vvwUsgcAwYW1
         qpJciVL0a2oVKA+g2iEbs73aA9+1JAkpg6dsyKW0on+P3IU47ixO+vShx0DX/NUTmURy
         gjUTvi0Cj6LWYxSgTyTYbI6EbBfV0EvkxS5T0NktsFJopDDZ+8THjRFBq1UlLBPvr6Dc
         dBbU7Z7JvrwMKD3qNU8vtqoO1OfbSSxXnTCIBPNX1VryJZyrK1hFuwkDt/8kyQtcjMGH
         GO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794326144; x=1794930944;
        h=content-type:content-transfer-encoding:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aM5tBn3ODTZ1/FCzgvJ2PUNZD7PoTyZUo4VRYYi2yLY=;
        b=qlIbimcDDm8pTCSWq3ZTfZM69YU4H0jGvwSEIfMLErJXhCkVyMeg8AwOPaziYqCawn
         irQEqz5fjfobvHVtf41UKFFxK8PlTpSm+X5AeG/VlkwEmSd9F8MxdIoeNk1uvx9RU18o
         X2YTP2UOzwBxp6wrtycheA4NVoItQe90SIkjiqI+/eJ3pGizRBJ5Oi+22IpP4WM1fDwy
         iaM1T7IfhgqeIzCKNgmXTQTG4ZIc3eMD6/bx0eq7F5/pyCjMfHc2SuKefnBpIK/7L7vv
         r9l9WBFglwMH6Mf1OjSbHUH9JVSIu1kGmjwCkVD6Li4V8JSHw2tBypKi9G+Cp5N2b2mE
         IWiQ==
X-Forwarded-Encrypted: i=1; AL+hErHjq9062NuFDW660hqfOEr8KqjlULT2aZoWKHgwHU2XwpvuYWToUfZJ3NzBt+YHlF7wcbx2wLs=@vger.kernel.org
X-Gm-Message-State: APuU4Z/safV18uiuIrLtC+4N8h6YuH29wcpnKdydkpxF34plGl9+oP63
	VkrE8prG5u7bjRX+MB/I/RGk6lMSn1+mg2E89xdBWX3F2njFPTMbfAYp
X-Gm-Gg: AYBFou1iUljn9mYdyJtk+pfxoN1/+Ghv3Tz/pEAQGASnQSgMbPxRmChprzJ6DfdNHrR
	U+3DSYgx/Hgq+g9qQY1/TwGd3IAVmjVS28SijscIpSdd3Ts+26gFfcoazXrZ8zzabZMLiOC56nV
	H2i+I8VxP86fDgONBppcHFkaLzQDn+0dq5ISG/l/rWsm2fpYpB0q04jB04iSFdDkQgNXvu6+kP4
	lUNbXZlXMmr487YELszRetssiDCmjsPetX58aSNhtUHsUkpGqHfsjvw14GW7z6F/4PKJpxeR0kB
	DOVstLDoyWLSs/5+wQXP0NyDtayzGNtMaq84vH/IX2W/HFNjecXj3qysgKl//Mk9t+XSmSW3WFH
	oO6Z0Pe6NQbjHUk6ohTJgVpXDPI7mReoMAHWVvxfBtYJ/GfuR3UpMxd4MJYvXeclTRu50rXowbo
	0RlHccyWm17fse0pYn9iNveCmmMULalxoGK04ZDy3kd/+x57+nIrmWIaqpUTKwEeRJ2it4Mi+wK
	WJ/0rudsNeZxYmWKBgflVMzEC0WHyc8Rz1F8EEXbfa8RbgHOCAqxuUqSmJCuly8xsQy4t6T5sHO
	NnIWhiq7AHpWdB6yBnYC2N5aNRvtBjLpXYu1x9m7J63kFwIofKDMPw09Gw3KKvyTCdANaeaEw7C
	wzbfOFgyXwZSI2E7uOG/6jmhM3gr9k0l6/k2VWNIKui89Y1gShinFD6sZTDmhjE83nh1mgWxXNW
	/thboKtQw1SJM4TQU2ghmK02V3+f7xXU1beA6Crlfslm6TFbI0eMHl7fsud4DAVuk9N3JlOo12J
	rLmz2A8zHyKFZ1fsK361yM9fFJWq+y0YcMCDM3W+b5BNfvLKNq8Yg==
X-Received: by 2002:a05:600c:c4a3:b0:4a1:dbdf:17a8 with SMTP id 5b1f17b1804b1-4ba02308542mr51845065e9.2.1794326144134;
        Tue, 10 Nov 2026 07:55:44 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-12-36.dynamic.telemach.net. [86.58.12.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ba0234a5dcsm73237085e9.2.2026.11.10.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:55:43 -0800 (PST)
From: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>, Chen-Yu Tsai <wens@kernel.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 Andre Przywara <andre.przywara@arm.com>, aiyengar1990@gmail.com
Cc: linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject:
 Re: [PATCH 2/2] clk: sunxi-ng: h616: Let the S/PDIF clock set the audio PLL
 rate
Date: Tue, 10 Nov 2026 16:55:41 +0100
Message-ID: <ThOkLORdSauix4Mt72r-lQ@gmail.com>
In-Reply-To: <20261110-h616-clk-emac-spdif-v1-2-e5e36e8963e4@gmail.com>
References:
 <20261110-h616-clk-emac-spdif-v1-0-e5e36e8963e4@gmail.com>
 <20261110-h616-clk-emac-spdif-v1-2-e5e36e8963e4@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

Dne torek, 10. november 2026 ob 07:03:01 Srednjeevropski standardni =C4=8Da=
s je Arun Iyengar via B4 Relay napisal(a):
> From: Arun Iyengar <aiyengar1990@gmail.com>
>=20
> sun4i-spdif asks for 22.5792 or 24.576 MHz on the S/PDIF (OWA) module
> clock, depending on the sample rate family. The spdif clock has no
> CLK_SET_RATE_PARENT, so it can only divide down the rate pll-audio
> already runs at. Unless another audio device has already set the PLL for
> the right family, the power-of-two divider rounds down and the request
> succeeds at a wrong rate: about 12.3 MHz from the reset PLL value, so
> 48 kHz content is sent at about 24 kHz.
>=20
> Propagate rate changes to the parent, like the audio codec clocks
> already do. This is the same change as the one just applied for the H6
> [1].
>=20
> Link: https://lore.kernel.org/all/20261104185027.883011-1-jernej.skrabec@=
gmail.com/ [1]

There is no need to link to H6 patch. It's clear that patch is needed.

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej

> Fixes: 88dde5e23da1 ("clk: sunxi-ng: Add support for the Allwinner H616 C=
CU")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-h616.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c b/drivers/clk/sunxi-n=
g/ccu-sun50i-h616.c
> index d2625fec651a..f703d690a563 100644
> --- a/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-h616.c
> @@ -529,7 +529,7 @@ static struct ccu_div spdif_clk =3D {
>  		.hw.init	=3D CLK_HW_INIT_PARENTS("spdif",
>  						      audio_parents,
>  						      &ccu_div_ops,
> -						      0),
> +						      CLK_SET_RATE_PARENT),
>  	},
>  };
> =20
>=20
>=20




