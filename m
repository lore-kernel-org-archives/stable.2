Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795370479;
	b=LxUNrS2zTIa8F2m6yn2UC4xYeKcvVlslUhuajQujVc6LfeBElpHahiP4JOgFwmQmhVPN
	 elKJO62us/ZD7n55/WbMkRY0buxVk07xsHvg2HzyNjraO9uJFf0tElKajQ5MroCqW0Qlm
	 y17hVO9DCceAGRAxEQujoGvVHErqkWlK+LdsMkxi2Jd02iaN+2xMGyOtUBJxgDpJIdSSs
	 OxSEIsauC6z2/JEvzQSbTd9tFI7H4dgpnontHT854sWmJhK1qHETQzf/7ZfwSdUmpPUhe
	 bw4SZ0SFZ32/mefacwz7dZgv1Nol4WR8vnJtCx0It+/LeXqz4a1gVjMCHYB8w44B/9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795370479;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=Z60uyFtNx0VkzpRcWhKH9sXU8xECnZhyM4KOZOe5aGc=;
	b=AJZBmfyxJxuu1K49bzUbQ5qvBjkmHPm2zD9Lfzs3TatFvJy7kFaB3CM8YoR58u5RDIL/
	 GTvARYSupYPPqLFq3sb/kTJyJ7xe+L5gFZT+jZjJjpWdD35rO7l7yGR2ChLoULPIcBoXZ
	 WHSWvwmCVC7NiEL28WdDY46W7IHKc9RQbaD7zHnxKcAhENrkz3NC2UHuj9lcv8cwL8+9M
	 XNFkRqRmqWAlnLBdW2acqCzK22xp47wCLkhlzxaGsk0ctt+flyl3wk1W661wK8uoWaO8Z
	 bKOnuJTpVwShp784ZIBdhNr12rW7//QLHRWgwKmhYV/m8YisifsOqsTpmGpHKEDRvuQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b="CTNMY+A/";
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E60606A32C;
	Sun, 22 Nov 2026 18:01:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 31E60606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=CTNMY+A/
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id E227CA03D9;
	Sun, 22 Nov 2026 19:01:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1795370475; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Z60uyFtNx0VkzpRcWhKH9sXU8xECnZhyM4KOZOe5aGc=;
	b=CTNMY+A/tNuJm6+ioyIbJFdxpOdWp+hvte3qKpCKloOoUBx7Np3NnT8y1pHHD7gJBI5TA0
	92+uWojbeS7No/UvGcNnMK4+2FVIREH1yImWGjnpCMmK2gqr6yyzREWJ0qxaIz9Xbaut9c
	qtCHtNEocCPO/7qCwxwFbvrnsZc0VPEvgWfInKbBQLKGdOHUQTwhsGlKM2uio6wv5UjHHv
	A6xFHbjV6kYoFPzk22yGQ5vfdezNSmjYrrg6BYofd4xm6eWb0CW6m1My2JACuv6Licd/AA
	PT9VlLcPqRn++GBUTp5d9ep1oUxm+Y0vYJRAP/HPiJVdWin1IoOsEwnsRcGnow==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 19:01:11 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Anandu Padinhare <Anandu.Padinhare@electrifex.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, Sam
 Edwards <cfsworks@gmail.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, David Wu <david.wu@rock-chips.com>,
 stable@vger.kernel.org, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: retry a failed RX refill from a timer
In-Reply-To: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
References: <MA0PR01MB921746F36D90C7080287ACC9FD782@MA0PR01MB9217.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <9d8cdde77beedce76aaaa1c5a7a788dc@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Anandu

On 20.11.2026 08:49, Anandu Padinhare wrote:

> [...]

> @@ -6164,6 +6205,8 @@ static int stmmac_napi_poll_rx(struct napi_struct 
> *napi, int budget)
>  	u64_stats_update_end(&rxq_stats->napi_syncp);
> 
>  	work_done = stmmac_rx(priv, budget, chan);
> +	if (unlikely(stmmac_rx_refill_needed(priv, chan)))
> +		stmmac_rx_refill_timer_arm(ch);

After a successful retry, doesn't this leave the last received frame in
the ring until the next RX irq? Could the poll refill first?

> [...]

Regards,
Nicolai
