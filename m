Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793622493;
	b=z3XP7YyNbY7068ksb9ErYPrB+O5IClAXfoJ7T45s2uRLV1CjPTHvrC3LnKWu1khDBzHI
	 UhW+xmRWgbFhtcki6WiNM3yJq9J6umynUQLHL/5Z1XqGsF5H/su3odJPNdQn/0nisrJBX
	 gOSOO14jQ75mmO/5Agugvv4aZPBM8GFgwBl03QwoWAqPZnGL+a/ShOmZxjbUdQ8f3FHdc
	 /Zw3VCQdWg5FzwI44S4XSQMcvalq/vkqrLAjdaIGfszBzekm3ljf+wg1vZJrrb17ZJ6mD
	 5Tv/wKjUchwTmb4OScuPzbLu045CZqi/F4kmqUZA2xnmxLS942D0zRVyemVyIy04v3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793622493;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=4X3VkScTDGjLaIOcWr8h5itegyLdzGxm82n+db9CBE8=;
	b=SGBUZX3z+fe55yVlzXHMvkMZE6sejSngvkhJZ7JLH4yq2egbNlTsVPzZlhfgLggnLaaL
	 miozREVO0Ih6XrgnhRH8ZOhzivGkXmLZwSsnMyrGM3FKMupIXoj4RKAsUBO32D6LxBzS7
	 zxgUAbQi2/SIKwA+AeloUkstvaVzsW9NR1pwW3dOs9mue8Jp1Xg68LRMIs8H0y16DHvXq
	 jGdhJ9S7pLjyKIZQ5HTyl8DffDCWytuWRX2rV58tO3N9WApUGU5/XiKQ2MAeVxFPiBMZK
	 V4ooiDcuHLah6EFqeYqkjuK8KUr6msgMNGLZskMhIeqW4edVHeBrapFoLwA83dON7+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mW9gyDUB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA39606A32C;
	Mon,  2 Nov 2026 12:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mW9gyDUB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF2791F00A16;
	Mon,  2 Nov 2026 12:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793622492;
	bh=4X3VkScTDGjLaIOcWr8h5itegyLdzGxm82n+db9CBE8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=mW9gyDUBHbks9XJTS4RNb5ybmVqoKT57U32q8MC7yuPdhs0/mqYYyE7RDwPrcBb4p
	 jnN30S8rPofjXpH6iMDk3iAb9MnGt8QuqDrOvIwHcSqou8dOuAiN3iYviF12rqQbLH
	 gSDEH5eST53x3Ghkt53Fe7dNkaOKk6WcA8ukqKjsRdIXttz6c85FHfiGbulQJD8fsy
	 MpPylsZhpZr/P6/Srdp9G6dLPiZR/eesh47pL/ZTp5Fsvdf3/j9lUG9B+KszFesTkv
	 U4Z13nKfyavB+daW1TrbRcxuhWODS0MNZ6oVA3Erc+rZcNhlkGyhU5eCzso43/iW21
	 rNvHXE5Jeb8Jw==
Message-ID: <8ab6e4fd-6a84-4a9b-9f2f-311d8a754158@kernel.org>
Date: Mon, 2 Nov 2026 13:28:07 +0100
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
Subject: Re: [PATCH] ARM: dts: samsung: exynos4210-trats: fix BCM4330
 Bluetooth GPIOs
To: Marek Szyprowski <m.szyprowski@samsung.com>,
 linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, stable@vger.kernel.org
References: <CGME20261026103600eucas1p25b6792a9a244d71a5f2ca8d06c9e79f8@eucas1p2.samsung.com>
 <20261026103555.968273-1-m.szyprowski@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20261026103555.968273-1-m.szyprowski@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/10/2026 11:35, Marek Szyprowski wrote:
> According to the board schematic, BT_REG_ON (BT_EN) line of the BCM4330
> WLAN/BT combo chip is connected to GPL0[4], while GPL1[0] is connected
> to BT_RST (BT_nRST). The Bluetooth node however used GPL1[0] as
> shutdown-gpios and left the real BT_REG_ON line undriven, so it was kept
> low by the default SoC pull-down.
> 
> This worked only by accident: the internal regulators of the BCM4330 are
> enabled when either WL_REG_ON or BT_REG_ON is high, so the Bluetooth core
> was powered via WL_REG_ON driven by the SDIO WLAN power sequence, while
> toggling GPL1[0] only released it from reset. Once 'cap-power-off-card'
> was added to the SDIO node, the MMC core started to power off the WLAN
> part (asserting WL_REG_ON low) whenever it was idle, what cut off the
> Bluetooth power as well and resulted in HCI command timeouts:
> 
>   Bluetooth: hci0: Opcode 0x0c03 failed: -110
> 
> Fix this by using GPL0[4] as shutdown-gpios and describing GPL1[0] as
> active-low reset-gpios, together with the respective pin configuration.
> 
> Fixes: 2fd18f0a8de6 ("ARM: dts: exynos: add bluetooth support for midas & trats boards")

Another unknown SHA.

Best regards,
Krzysztof
