Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622424;
	b=nDbZNo9Vw3h3WXBYfUN+9T2bmZjUs+I5rr5jvBKSOHrBHnnK4tke2pHTy20aAF2Lh6yL
	 5MQ1Hi/xRNSRmaSILaJU44MVYdPF2YtvwmuQyFY+/odTxHxeMha6bF2++C9TI4i+K5mVu
	 0IB7uJpA3c7k0V9tOMLZtZRA6dU4xXM+WQTWZXjRsn7SZB6Db6r0ARRXniRCeZbr1L7Vx
	 sqf0uKHgyraEm8+FtYp1OtZ99nYuxcUY0i8vmZlrpffLUPZJLWcd/oT6MmXnzvKkVF8S+
	 9j5F9AizQyd9itVJcBCPNW7zIT2+OBwW8BX3XZ3BiIReJyarh9M82/WxHPyhzsWmq2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622424;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=vNNddRAdMLxK0ANAKEMUtJ2LppMU0bveEB1/Y3XdFzc=;
	b=0WQP3UUKPnupmwlTQtKZDj5fybUgvKKcwiXFvSUnxgghZGGxDu9TEovlYtT71jkmi/yS
	 +QBxwaGPYCqo99BkHGAyRyPMm1eLcNUzhFqUNj/91NVJ2d4QiezgrpfO955VBMwQydXhq
	 GSu4Yx2l2XEHH5V+7h3pweCID+Y7I7GOUugiFRo+12W7tAMLhMeI2ha5qPZVYJ4qDD632
	 eirmwlzkWQ7HwNQVBsGastZ7aKJlxzVHEkL9pGO6nzIgfGw8yqt7JLSOGShn2ihOiwZOA
	 2rI6+wrqjYwmpbWbfAMKZ2KooBbhnFuW6kF3konaPoSbCEJQdThV4Kw4+mnwMQRp40w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omsEJ1Sv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7618606AA33;
	Mon,  2 Nov 2026 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omsEJ1Sv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9A01F00A16;
	Mon,  2 Nov 2026 12:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622423;
	bh=vNNddRAdMLxK0ANAKEMUtJ2LppMU0bveEB1/Y3XdFzc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=omsEJ1SvO/+LOhonjiNRdB6u7UNG+jPypFLSjmzfHPCNJoptNkpvGVY1GSLVktE1p
	 LQj2RdXSSuDRiXb8vdq7wxNXTebCUKykwbxy0oKDNlvFWR1NBEx4MUmB+fswhTjfYs
	 IEed13ubqIcp2yJoCtstO/kaOpo2Q2dI6Oemi4S75QaXdm6NAHkdUPcnJZ0LkdQKi8
	 Xq+u3E//g0r3u3ahG3h+WkP3ei+9yunpUfAv3d/R9dhTGAsTmKGmD3HHEgsoVXx4Vs
	 q8HFO/z1nMNtRrpcNV0zD0moMK/gPX0TC8F1+pQM2m8YelJ0Nh8SrAmLcq46WitN02
	 h4TTcYkU4f3KA==
Message-ID: <eeca871d-ca1f-4cd4-b40a-570f0805dbd1@kernel.org>
Date: Mon, 2 Nov 2026 13:26:58 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ARM: dts: samsung: exynos4210-universal_c210: fix BCM4330
 Bluetooth GPIOs
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, stable@vger.kernel.org
References: <CGME20261026103612eucas1p10fbe3777394cc604419299509c22a2e7@eucas1p1.samsung.com>
 <20261026103607.968295-1-m.szyprowski@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261026103607.968295-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2026 11:36, Marek Szyprowski wrote:
> BT_REG_ON (BT_EN) line of the BCM4330 WLAN/BT combo chip is connected to
> the XMMC1CMD pad (GPK1[1]), while the XMDMADDR_4 pad (GPE1[4]) is
> connected to BT_RST (BT_nRST). The Bluetooth node however used GPE1[4]
> as shutdown-gpios and left the real BT_REG_ON line undriven, so it was
> kept low by the default SoC pull-down.
> 
> This worked only by accident: the internal regulators of the BCM4330 are
> enabled when either WL_REG_ON or BT_REG_ON is high, so the Bluetooth core
> was powered via WL_REG_ON driven by the SDIO WLAN power sequence, while
> toggling GPE1[4] only released it from reset. Once 'cap-power-off-card'
> was added to the SDIO node, the MMC core started to power off the WLAN
> part (asserting WL_REG_ON low) whenever it was idle, what cut off the
> Bluetooth power as well and resulted in HCI command timeouts.
> 
> Fix this by using GPK1[1] as shutdown-gpios and describing GPE1[4] as
> active-low reset-gpios. While touching this, move the GPE1[4] pin
> configuration to the pinctrl_0 node, as GPE1 bank belongs to that pin
> controller, what fixes the following error:
> 
>   samsung-pinctrl 11000000.pinctrl: does not have pin group gpe1-4
> 
> Fixes: 8929d4a9d204 ("ARM: dts: exynos: Enable BlueTooth support for Universal C210 board")

Unknown SHA.

Best regards,
Krzysztof
