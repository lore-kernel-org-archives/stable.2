Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793917750;
	b=bMlLxf0wa9L+Os0EYMutgRe9Wbquf9Z7eEhSUtSz07jyTTqiPOPIfRfvGj5PpI75tHsL
	 DQtGw9RjqeMhkxvpsZtYxkmW+b5LqF5n+o7jYDpTR2lX5uACM3GWA4WA97Zzq8ud2zWNP
	 AM7q8SYPYwFTtrZndno7u1n6htCkTzizfRm6FSdHfNMmw1L/kac5K/CWXQ8f5rQDtdkdu
	 pO3JA11q4jqPoKwXdUe/XL5MSv3jiODKOzgNF7ZGU2yOXPuUoDuCMG5BITcRxLOalgf9i
	 V4hrz+0XFvEbkOjkl/fKS2GRvRQdJv98PpcSpSTpHq835JQ3hM2qogWzRtWCv0QfcVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793917750;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=RDihrAvbt899nFV4qD5BU16ILjLzXvAuY9vU5B9lPIg=;
	b=CwTSQVHVcZOGZDf/EW6nGKS0G2+alysmdXIFD8zX+pV2Ks/7rnOqWegkN52o9fD8014u
	 KXIqDRAAn6jvDBVkBPIRIVSNXOivF03DSbyTl5OCV+L6LN8qsq4ngfs/t4KidlUffe3OG
	 AeO/rH04Ju5KpFQl2HOh6E3qPgGMwWVjkupCs2WH5Ee6kVEQKOhfqDDmejW7fxsudi0uF
	 Xb8Qo7rPNuBDWu8Lj6J30Y+rwqfRdc5ZGSDXdKChLb65XtLguFiHi/re1hL/HBV/6FfDo
	 NB8K0UfqaoYFEqAgm2M5N1KKL9EU/IgT6AcBhM31HWEEpDCv6a1wucnzxbanStji3dA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg6VW5do;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131D7606A31B;
	Thu,  5 Nov 2026 22:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tg6VW5do
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BB6E1F0089F;
	Thu,  5 Nov 2026 22:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793917749;
	bh=RDihrAvbt899nFV4qD5BU16ILjLzXvAuY9vU5B9lPIg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Tg6VW5do2xmY+b2XWSOyH4e3dxWRVhySRpcbJYakdxphVLBzPaQWQsZi5IX+lRgnv
	 rDAljbpUShy819ayok3GGq9JACkjBH4XvioCagRQxB7el3yIWnG075jcjGCEbho5Ec
	 y4THRMk9Puq5+BhVQQmJ1+Phjl86uIy1idjzBGUk6qJZV8P0mjRMGH3riTM1S882XY
	 jlsH2MAyLXCbZ8q37PUJy/mPv2ltqNPm7B4Yw0zWa27ExSAItitZQJVs6uGi4jYlPT
	 HgpjkYpjsBTgX49nh2R/LQNyGBqcNh8hw0jhuu5y4+jECxdgvXhpXZafZTR82/cpCX
	 vmdj8MAY53Kbg==
Date: Thu, 5 Nov 2026 14:29:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: dsa: microchip: drop the parent MDIO bus reference
Message-ID: <20261105142908.69966b2a@kernel.org>
In-Reply-To: <20261103100531.1309946-1-vulab@iscas.ac.cn>
References: <20261103100531.1309946-1-vulab@iscas.ac.cn>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Nov 2026 10:05:31 +0000 Wentao Liang wrote:
> ksz_mdio_register() obtains the parent MDIO bus with of_mdio_find_bus(),
> which takes a reference on the embedded struct device, and stores it in
> dev->parent_mdio_bus for the side MDIO accessors.  Nothing ever drops
> that reference, so it is leaked on the probe error paths and when the
> switch device is torn down.

Hi, since you're spamming the community with low-value fixes
we would like to ask you to not post any further networking
patches for the rest of this calendar year.
-- 
pv-ban: 2mo
