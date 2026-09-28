Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D2E35201A;
	Mon, 28 Sep 2026 06:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790578251; cv=none; b=NMr5YlarKHeH8ISDf8T/Ip5d/8/K+HRDVy60G4UWoI8IVQBxDZpWVB0LUFYb0TMebbv2FxwZtcT3p8Em5FgKuRiwugfEge6xBfbldzF/cQmFDKIYo79hu9sR3iRb3NaH4OwgMHDmQpW8G0nBf/sl4aS1kuL5wnmtsamObSX3Jtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790578251; c=relaxed/simple;
	bh=F2fkqk+warAqlcPPl4KiiXVtBr/t+GSWodwfx0lgHlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tNHd5N7SSvfx/CSCGjIWJxn/i/7nmouBFFPiKOLrbLswuYXMO7xlYqmKQ/acz7VaqMMIESzkMoWxBro1cbAZgqojknFzIjj3hz/0v7mWd5cevKbECysHzVm6WC0qh2sP8frP/bXXMF969FWcRqI+M/dglAb0c+6/LG1ZnuYlG6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=X5vM0D1k; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="X5vM0D1k"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 7EE0C1A0FD5;
	Mon, 28 Sep 2026 06:50:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 29C566074B;
	Mon, 28 Sep 2026 06:50:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 80AAD102F1E74;
	Mon, 28 Sep 2026 08:50:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790578243; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=fcCndR4hJBCttx8cdfopSI/TUzzp6DbkY/Fy9CVnC8Y=;
	b=X5vM0D1kBOHu5HqWiZ2dMX/Vp9xsfJhQ55pab6Q3IvULx98hYPpBlV+sdsLkCwZpQk6E//
	/Rh+gAfr4sLLcM5PxAaAPBBkDkYqv6YTVjONM6aN/eV34FtPgBjjr/nrRFZKi9IedGLTJZ
	cWEQciLMZxa2OUY6jOpX3kvU0W8TETg/nNen/GLpjzmMXzYncfCBLSucZ2Zuv/4jjFcI0+
	Fy3UKP7IzOUEmw+3Zcd4vJ6vqbw7n0YR4kO7hgI9jfwUzCOYA0xpEE/b3jDHaIk04HWos/
	CpJ6Ve67NZgQUuVxT6HE39uDIJ6Udh40uZ9FQ2ovztLbRUmiDgJMmG36+jqzmQ==
Message-ID: <d9d028e9-240a-4249-bc3f-c47194676fc7@bootlin.com>
Date: Mon, 28 Sep 2026 08:50:12 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 00/19] net: stmmac: preserve datapath state
 across MTU and resume failures
To: James Hilliard <james.hilliard1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Christian Marangi <ansuelsmth@gmail.com>,
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Suraj Jaiswal
 <quic_jsuraj@quicinc.com>, Richard Cochran <richardcochran@gmail.com>,
 Joao Pinto <Joao.Pinto@synopsys.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Ong Boon Leong <boon.leong.ong@intel.com>,
 Voon Weifeng <weifeng.voon@intel.com>,
 "Song, Yoong Siang" <yoong.siang.song@intel.com>,
 Linus Walleij <linusw@kernel.org>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Jose Abreu <Jose.Abreu@synopsys.com>,
 Yao Zi <me@ziyao.cc>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Richard Genoud <richard.genoud@bootlin.com>,
 Alastair D'Silva <alastair@d-silva.org>, Maxime Ripard <mripard@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
 ZhaoJinming <zhaojinming@uniontech.com>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
 Ding Hui <dinghui1111@163.com>, Linkui Xiao <xiaolinkui@kylinos.cn>,
 Linkui Xiao <xiaolinkui@126.com>, linux-tegra@vger.kernel.org,
 linux-sunxi@lists.linux.dev, stable@vger.kernel.org,
 Rayagond Kokatanur <rayagond@vayavyalabs.com>, Ding Hui <dinghui@lixiang.com>
References: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260927-submit-stmmac-reset-fixes-v1-v5-0-feec6c14dd06@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James,

On 9/27/26 23:59, James Hilliard wrote:
> Keep the stmmac datapath coherent after failed MTU changes or hardware
> resume without changing the interface's administrative state. Retain the
> working MTU configuration for rollback, and allow ordinary down/up
> recovery when hardware cannot be restored.
> 
> This revision incorporates the following previously posted fixes as
> prerequisites:
> 
> - Linkui Xiao's v3 MDIO reset GPIO fix:
>   https://lore.kernel.org/r/20260921015727.2643540-1-xiaolinkui@126.com
> - Ding Hui's v3 DMA descriptor allocation cleanup:
>   https://lore.kernel.org/r/20260919121436.1642724-1-dinghui1111@163.com
> - Lorenzo Bianconi's v3 EST series, patches 2-4:
>   https://lore.kernel.org/r/20260902-stmmac-est-reapply-after-open-v3-0-e72a6df5a7ef@oss.qualcomm.com

Then please wait for them to be merged.

Also why are you targetting net-next now ?

And most important, no more than 15 outstanding patches,
this series alone goes over the limit.

You need to split this up, tackle the issues one at a time, even
if the overall goal is "MTU and resume failures".

As you can see there's a lot of backlog in this driver, and if you try
to address sashiko's review by adding more patches and account for
all "pre-existing issues", this won't work.

This series already went from a 3-ish series that was
sent alongside the allwinner glue to 19 patches in about a week.

Please think about the people who have to review that :

>  39 files changed, 2390 insertions(+), 808 deletions(-)

Not only the quantity, but the quality of the commit logs, the changelogs
and the comments. This really feels like the raw output of an LLM and it's
very hard to read.

Maxime

