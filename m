Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D96A3CCA19;
	Wed, 17 Jun 2026 09:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689798; cv=none; b=ZnoN0TTLitQ1Jchcotd5NOrsvYTAsWUKxmYALUF8FhEx/wlrOCCEYSPjEaBT/LFtmM4uqTOJwDHhhd6K8x0W+foNj53+1l7gSNW+bNHoGwwGKj/YcpJMGWuBeLOpU/ASHI+QKued59BejrR4UxK4BeHxu4TGveJAtG7szUYMq5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689798; c=relaxed/simple;
	bh=zfVCtgTRAsvS+D3aeQbbK75JiVp3SqwTgEE46PHUzYs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rFRxEBkqkmd1aOSlPgxW/3ui4KAe9cgcAdl3BjFZhz/sG5o03qPIuKCtQRsxRWQfS8KasjPE1REIMLJkEqkO+m7oycPgidZXMhdrQycm+zmwkOg8YBBGUZlGq1R008S3c32L2Pim1nrWsW5BfV82j3N4XVbR79Ll11p1R71QQdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=vQ/fXft/; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="vQ/fXft/"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 96972A3D4C;
	Wed, 17 Jun 2026 11:49:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781689793; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hf9QkZGmUnC30a53FfAC7EiUIkOgNwS4+ou504SVgNQ=;
	b=vQ/fXft/e5Zqd3TnCz3P+bXA/fCTXUM+7AziJv1w3xZXegBO7jfLqg/KmzfVwh9rErZjip
	Br1LglAlOqImEWq62SCTjPUjC099mK2wlDNT0mDprbF0oTMEPWxFk0YtI6vaMg5bPTlm9Q
	M+llX2tGyuCRtfEDFX4Oh85OVycQ0CmDNt1/swRfpFvwAtHp/xi5pKmCJfKoXjct3TaM9w
	8CH2lJkmOMUOy7CWURJc0I/kGJh0JDuhjso2YCx50HYQ+8FMJy4YcQFnTdX2Ss07AH/7ZY
	mwJHkJB0WRO+yKu56KpnjZGGDND/0/ElFtdk+XN2BdZBwUS9/7DvfpQEe1iciA==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 11:49:45 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Haavard
 Skinnemoen <hskinnemoen@atmel.com>, Jeff Garzik <jeff@garzik.org>, Conor
 Dooley <conor.dooley@microchip.com>, Paolo Valerio <pvalerio@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Vladimir Kondratiev
 <vladimir.kondratiev@mobileye.com>, Gregory CLEMENT
 <gregory.clement@bootlin.com>, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Maxime Chevallier
 <maxime.chevallier@bootlin.com>, stable@vger.kernel.org
Subject: Re: [PATCH net v3 2/2] net: macb: drop in-flight Tx SKBs on close
In-Reply-To: <20260617-macb-drop-tx-v3-2-d4c7e57d890b@bootlin.com>
References: <20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com>
 <20260617-macb-drop-tx-v3-2-d4c7e57d890b@bootlin.com>
Message-ID: <133833c652ac0c979cf84865f2e5c7c5@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 17.6.2026 11:17, Théo Lebrun wrote:
> The MACB driver has since forever leaked the outgoing SKBs that
> have not yet been marked as completed. They live in queue->tx_skb
> which gets freed without remorse nor checking.
> 
> macb_free_consistent() gets called in a few codepaths, but only
> close will trigger the added expressions. In macb_open() and
> macb_alloc_consistent() failure cases, tx_skb just got allocated
> and is empty.
> 
> Use the new macb_tx_unmap() prototype to report our error as
> SKB_DROP_REASON_NOT_SPECIFIED rather than SKB_CONSUMED which makes it
> sound like no error occurred. Equivalent to dev_kfree_skb_any().
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
