Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=210.118.77.12
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793623388;
	b=zrzFB7lR+KAOFoZc/5IYGZbJtaKVjsOtVsZ3xKiZOn1HFX5BgThxpzArE1z6WX2frZY6
	 zG6JJO2TbmNGpvsCK2u6fwDhJMXXahxA3r6t/u5C6l/t5h4NHiNzuc94gC+3JbEaf9LX8
	 DT2kxwFeqKdGBaY+Hiudsc36oxo5nRN7BFuRll+/mji599EWxkXH/HJpWW6olCH7Kp/04
	 VczKWo50XRhDN30eTnMEEkL9olKtdPQaczIwo9pSBoyRD9NEgeB4GIec1LZyYrMJeST2L
	 UdFUAnOSIhy4/fQQ/RtsdmV7BLskx6ELLvHJooVBvkkIld0zLwNyeW1AyowmSjHS+/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793623388;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:
	 Content-Language:From:In-Reply-To:Content-Transfer-Encoding:
	 X-CMS-MailID:X-Msg-Generator:Content-Type:X-RootMTR:X-EPHeader:
	 X-CMS-RootMailID:References;
	bh=rH9vlZwAwta5qI38yKfrBL3Gqc0558o0bMuyyiURmLQ=;
	b=kqPPQqU8AJav8L1enFGHlJ6BRhawtzuj1+aKC+K6md2ybWcWVUi8KqDHS7p6PYjCewqT
	 4qCbFSKyM0fgpnYFIpU7hdoNRAm6OfZbQ/NqADlfrd4KayjeCX38RV8RL6Pf7G9+HdHWd
	 323PoYscgrj6nH05hE4BwKHQzYUIkvLFtQGNvrwYo7ks58Ch9TmXQvQ1pKF1JhnkmFybd
	 RrcQNgeoR2u1iLXieGmjxS29z7yHVB8F2ivfCaZwa3hfPKZRJZwTya4rKF26+XJ1z9n2n
	 rdnTsGeYY9yQ7IvH0+aU+avcSdo2fL9aJ67bwXyw52kGTHooItt2t1ikW/uIFXPdw/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=samsung.com;
	spf=pass smtp.mailfrom=samsung.com;
	dkim=pass header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=RAP4Jk5I;
	arc=none smtp.remote-ip=210.118.77.12
Received: from mailout2.w1.samsung.com (mailout2.w1.samsung.com [210.118.77.12])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C2160A2636
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:43:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 36C2160A2636
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=RAP4Jk5I
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
	by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20261102124305euoutp02b9dd224445c347bff9deda50bd30b708~kOvdGb-I00818208182euoutp02H
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 12:43:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20261102124305euoutp02b9dd224445c347bff9deda50bd30b708~kOvdGb-I00818208182euoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1793623385;
	bh=rH9vlZwAwta5qI38yKfrBL3Gqc0558o0bMuyyiURmLQ=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=RAP4Jk5IpIl9qisl34bV2qvQux21cBQ4nqXdyVkcAHgVlIl0liGG2kjCu2gUBSoWZ
	 GS86gtUEKdAZUPgTXEZJ2dif9vOVf8dqw2r+Q3tT1t5Nv123mDQiEY+cMPVu/mj+gB
	 TemKvE9rQVaC23JvY+3LCY7H5B7QFQr8/MRQ+N+Q=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20261102124304eucas1p2f20d8303a387eed97c9a260751f4183a~kOvcy1Cm90644306443eucas1p2Q;
	Mon,  2 Nov 2026 12:43:04 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20261102124304eusmtip29e9b409d4c80572efdd6779c68c2fc36~kOvcZ2q7A2439124391eusmtip2Y;
	Mon,  2 Nov 2026 12:43:04 +0000 (GMT)
Message-ID: <c5e4791d-d402-471a-b8a1-d791e6f3417e@samsung.com>
Date: Mon, 2 Nov 2026 13:43:04 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH] ARM: dts: samsung: exynos4210-trats: fix BCM4330
 Bluetooth GPIOs
To: Krzysztof Kozlowski <krzk@kernel.org>, linux-samsung-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>, Peter Griffin
	<peter.griffin@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>,
	stable@vger.kernel.org
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <8ab6e4fd-6a84-4a9b-9f2f-311d8a754158@kernel.org>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20261102124304eucas1p2f20d8303a387eed97c9a260751f4183a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261026103600eucas1p25b6792a9a244d71a5f2ca8d06c9e79f8
X-EPHeader: CA
X-CMS-RootMailID: 20261026103600eucas1p25b6792a9a244d71a5f2ca8d06c9e79f8
References: <CGME20261026103600eucas1p25b6792a9a244d71a5f2ca8d06c9e79f8@eucas1p2.samsung.com>
	<20261026103555.968273-1-m.szyprowski@samsung.com>
	<8ab6e4fd-6a84-4a9b-9f2f-311d8a754158@kernel.org>

On 02.11.2026 13:28, Krzysztof Kozlowski wrote:
> On 26/10/2026 11:35, Marek Szyprowski wrote:
>> According to the board schematic, BT_REG_ON (BT_EN) line of the BCM4330
>> WLAN/BT combo chip is connected to GPL0[4], while GPL1[0] is connected
>> to BT_RST (BT_nRST). The Bluetooth node however used GPL1[0] as
>> shutdown-gpios and left the real BT_REG_ON line undriven, so it was kept
>> low by the default SoC pull-down.
>>
>> This worked only by accident: the internal regulators of the BCM4330 are
>> enabled when either WL_REG_ON or BT_REG_ON is high, so the Bluetooth core
>> was powered via WL_REG_ON driven by the SDIO WLAN power sequence, while
>> toggling GPL1[0] only released it from reset. Once 'cap-power-off-card'
>> was added to the SDIO node, the MMC core started to power off the WLAN
>> part (asserting WL_REG_ON low) whenever it was idle, what cut off the
>> Bluetooth power as well and resulted in HCI command timeouts:
>>
>>   Bluetooth: hci0: Opcode 0x0c03 failed: -110
>>
>> Fix this by using GPL0[4] as shutdown-gpios and describing GPL1[0] as
>> active-low reset-gpios, together with the respective pin configuration.
>>
>> Fixes: 2fd18f0a8de6 ("ARM: dts: exynos: add bluetooth support for midas & trats boards")
> Another unknown SHA.

Aghhh, my fault:

Fixes: 132e900a47b8 ("ARM: dts: exynos: Enable Bluetooth support for Trats board")

Do You want me to resend it?

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland

