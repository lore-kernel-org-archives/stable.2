Received: from m16.mail.126.com (m16.mail.126.com [220.197.31.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B7549DBB9;
	Fri,  9 Oct 2026 09:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791538979; cv=none; b=np9F9SIyF/4nSL92Bc6fAqmkjII6hlk8nAtTrw2xLrK5z4NGtmAfMbDtdUEApG05hF4U8QM+DPkaRFvJ2Ag0mIBkvp8yRdxNboV/wB3KR/M/GdEXFDQj85ZocYI8hrei0mUZEU096ckyd6sRBTTyK2L1tvQeYm/hY9Q+GAmJX/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791538979; c=relaxed/simple;
	bh=yhOjj/wrjjiaYAgabEvaYOFm/8b7bCIzioUlA5BSq/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QyZhij95/8VgtRwuV8YqRIgh1GmXSvaybiQHg2x90ccss8hM+WVvpzOXMvK41WmjczGHn2G97J9/WYDHJRwy8kLo6jRQ0oatbSIVq+jRaqHEJFzJ6fz3w87BEgSgxTbgQZZboYPYm9IZ09SMg7DOG5A+pzbNVhIyBkrJzUAdJ3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Of3Cg7mi; arc=none smtp.client-ip=220.197.31.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Of3Cg7mi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=comNi0bq8Of/dXYDxEHJTvUJcWhZQ1Sp8DE5wIR2vhA=;
	b=Of3Cg7miPOXJ2jb0AeB8OOfPqw94BzyQiG5igLTjey/F5NEhxjHsOL2jXKdaAR
	iKM2VQntpfJBFotx+3JBc3RuhsIk7Eafyyfr8/9JxEXBW1ozXRGxLb0/CwChpKR4
	HmsNmt/WvY/2VyAIZK194DLatWI6J+R/0jX+u8MKdhBDE=
Message-ID: <544bc0d9-c1c8-461d-aba8-6065409cb53c@126.com>
Date: Fri, 9 Oct 2026 17:31:23 +0800
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 02/19] net: stmmac: request the MDIO reset
 GPIO only once
To: James Hilliard <james.hilliard1@gmail.com>,
 Linus Walleij <linusw@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Serge Semin <fancer.lancer@gmail.com>,
 Suraj Jaiswal <quic_jsuraj@quicinc.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>,
 Voon Weifeng <weifeng.voon@intel.com>,
 "Song, Yoong Siang" <yoong.siang.song@intel.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>,
 Richard Genoud <richard.genoud@bootlin.com>,
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 ZhaoJinming <zhaojinming@uniontech.com>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>,
 linux-tegra@vger.kernel.org, linux-sunxi@lists.linux.dev,
 stable@vger.kernel.org
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
 <20260927-submit-stmmac-reset-fixes-v1-v5-2-feec6c14dd06@gmail.com>
 <CAD++jL=6Ov5BPK1naX6orzMsrJPm_g6SkdRaU6Ji+okXMFaZdQ@mail.gmail.com>
 <CADvTj4pU6EXgx1-dupQoQBm8OrrvAeR5NyCk4of7zya2V=yvEw@mail.gmail.com>
Content-Language: en-US
From: Linkui Xiao <xiaolinkui@126.com>
In-Reply-To: <CADvTj4pU6EXgx1-dupQoQBm8OrrvAeR5NyCk4of7zya2V=yvEw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDnT_lttMhqfcDGAw--.25712S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXFyxtr43KF15GF47ZFy5Arb_yoWrXw1kpF
	Waqa1YyrZ5XrWxAws2qw1UZFyjvFs0yr43Xr1jkrWxCF98CFyfJr1xtr4Y9F97Cry8Ww1Y
	vF4vva47uan0yFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ur3ktUUUUU=
X-CM-SenderInfo: p0ld0z5lqn3xa6rslhhfrp/xtbBqRAW7GrItHDUxQAA30



On 2026/9/28 07:49, James Hilliard wrote:
> On Sun, Sep 27, 2026 at 5:35 PM Linus Walleij <linusw@kernel.org> wrote:
>>
>> Hi James,
>>
>> On Sun, Sep 27, 2026 at 11:59 PM James Hilliard
>> <james.hilliard1@gmail.com> wrote:
>>
>>> From: Linkui Xiao <xiaolinkui@kylinos.cn>
>>>
>>> stmmac_mdio_reset() calls devm_gpiod_get_optional() every time it runs.
>>> A GPIO line can only be requested once, so from the second call on
>>> gpiod_request_commit() returns -EBUSY. devm_gpiod_get_optional() only
>>> turns -ENOENT into NULL, hence the error is passed straight back and
>>> stmmac_mdio_reset() bails out before pulsing "snps,reset" and before
>>> running the STE101P MDC workaround.
>>>
>>> The first call, made by of_mdiobus_register(), succeeds, so the failure
>>> is only visible later on: every resume that does not use WoL goes
>>> through stmmac_resume() -> stmmac_mdio_reset(), and that caller ignores
>>> the return value, so the PHY silently stays un-reset.
>>>
>>> The descriptor used to be requested exactly once: stmmac_mdio_reset()
>>> resolved "snps,reset-gpio" itself and cached the GPIO number in
>>> stmmac_mdio_bus_data::reset_gpio, and commit ae26c1c6cb9b ("stmmac: fix
>>> PHY reset during resume") relies on that cache to reuse the line on
>>> every call. commit 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in
>>> stmmac_mdio_reset") replaced it with a devm_gpiod_get_optional() that
>>> caches nothing, so the request is repeated on every call and fails from
>>> the second one on.
>>>
>>> Parse the whole reset description, the GPIO and "snps,reset-delays-us",
>>> in stmmac_mdio_register() at probe time, and keep it in struct
>>> stmmac_priv. This is where devm-gpiod is meant to be used: the line is
>>> acquired with the device and released with it, and any failure to
>>> acquire it is reported during probe instead of being ignored by
>>> stmmac_resume(). stmmac_mdio_reset() then only pulses the cached line,
>>> with the delays that were read once and for all at probe time.
>>>
>>> Cache the request and delays for DT devices regardless of
>>> mdio_bus_data->needs_reset. That flag controls the registration-time
>>> bus reset callback, but system resume calls stmmac_mdio_reset()
>>> directly. The reset routine no longer looks at the device tree: where
>>> the description is absent the cached descriptor is NULL and the delays
>>> are zero, so the pulse remains a no-op.
>>>
>>> Keep acquisition conditional on CONFIG_STMMAC_PLATFORM, matching the
>>> reset callback, so non-platform configurations do not request an unused
>>> GPIO. Also skip acquisition for a disabled MDIO child: registering that
>>> bus returns -ENODEV without calling its reset callback, and the driver
>>> must retain the existing disabled-bus success path even if the unused
>>> GPIO is unavailable. Remove the unnecessary gpio_desc forward declaration.
>>>
>>> Fixes: 7c86f20d15b7 ("net: stmmac: use GPIO descriptors in stmmac_mdio_reset")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
>>> Co-developed-by: James Hilliard <james.hilliard1@gmail.com>
>>> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
>>
>> Dostoyevsky commit message, I didn't read it. Ask the agent
>> to be terse.
> 
> That commit message style mostly just came from the imported patch,
> I'll change it to be more terse in the next revision:
> https://lore.kernel.org/all/20260921015727.2643540-1-xiaolinkui@126.com/Hi James,

Thanks for picking this up. Agreed the commit message is too long;
I'm fine with you trimming it for the next revision. Linus already
gave his Reviewed-by on the code, so the logic is settled.

Thanks,
Linkui

> 
>> I looked at the code and from a GPIO PoV it does the right
>> thing: use 1 as asserted and 0 as de-asserted RESET line.
>>
>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>>
>> Yours,
>> Linus Walleij

