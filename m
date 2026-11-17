Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794922567;
	b=lnoi/O4WqgFNfs/K5w2rSpJuX5MQD1id4ezJghqXPz7t0u0qAf/yjG7KTyLN+EaBjUB1
	 vevYdDtS4wizXL2/Vr9bCAF0lvw2E3UVyoAXcuIP7M3AqQ9HsVuTEbfEuFxGxvgp3a7DJ
	 6CtWZaLkWZcujvSOjcrP0+gBACnSIVbTwXBbMpotFaHk6p87L6cKO7iLe8SP5Gm640AlS
	 wsGK9cW2wNe2oQElmEkdvCSHor4QnC3qT+Y1Yr52x1L/6BvjothLF2x/Rc0x9ruNxD7uP
	 zAOeeg7GM1E3X+FKA090HCnJOIUQJL2AA45jrLSY5T2szOwsfMTMqFz2CcnbNq4MbZg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794922567;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=zrjNaK2BMmlXskrm0KIplH9eRZPk+1mRx+s4P8jKOWE=;
	b=p6vY0AnZWp1ofu+ZsUff8mEC6r63tbpw08+bZOUImBYNIcozYbdq/sGHgi1F/nCUhZ53
	 QFHxXli6FiT9i4jRSj8gOmiD/5g9SiAi3jBhr1uj9m0ykIRH+VeTSdxbl0aNwCCm72J5l
	 /40HELYcT4Y+ryRnxBMGzUP7RTksr7qVtWvlWlBfHXWErM4TUZZy/YNtEElo3QQQSEZMT
	 NPTDluITaoxweOC0oIgekB+debAk4WpxEnQyFRF9VbgIwbEtyMdMTI4z1aHBiHTbXLTFE
	 X/jzJvJJrqcSioSZwexJzf3bVL6FZyHIYBfeQTeI4dcc+cpUFpx5B8iZwRCJ81t1Z5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lyyzifHP;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CC7606A31C;
	Tue, 17 Nov 2026 13:36:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C8CC7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=lyyzifHP
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 934F6C79A97;
	Tue, 17 Nov 2026 13:36:09 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25CAD5FC81;
	Tue, 17 Nov 2026 13:36:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D9E8811BC0008;
	Tue, 17 Nov 2026 14:35:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1794922560; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=zrjNaK2BMmlXskrm0KIplH9eRZPk+1mRx+s4P8jKOWE=;
	b=lyyzifHPUW/TF25iVGcxxozdbgkY/qmW1+lpBdGXZzGqQBZBIxE9ZXOrdLz16IlpxWvZAk
	e3266PE7euLObTyJBNNOD797XSiUMy+84nhboxxypsKcu5qqeCH+AMH8pXUbz7yQIOFi4m
	SaWzef4Ie2MByykrYRur3B+bdJc6V5dqFAfpqMamQs7QDl4nqcqBC+BSxjqGrt5p/Ofweb
	bXxizpY1Ry07WMp2HJIXA8/jPSrSjJC/q2QZ72HJvH3QYlAcD0LHnTLH+PFyxi9O5KdQFf
	My8aknE77tEPjHyXg5TFzJ3Vqdwj5lkD7lGsu+sQypAq3Y72ZkyBr6VTHnsgag==
Message-ID: <613e303b-635c-4751-8988-2687f8f39c4b@bootlin.com>
Date: Tue, 17 Nov 2026 14:35:52 +0100
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
Subject: Re: [PATCH net] net: stmmac: drop the rest of the frame when
 napi_build_skb() fails
To: aiyengar1990@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, stable@vger.kernel.org
References: <20261113-stmmac-rx-skb-fail-v1-1-fcaae89f2d2c@gmail.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20261113-stmmac-rx-skb-fail-v1-1-fcaae89f2d2c@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/13/26 18:13, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> If napi_build_skb() fails on the first buffer of a frame that spans
> several descriptors, stmmac_rx() drops that buffer but goes on with the
> next descriptor of the same frame as if a new frame started there. The
> rest of the frame is then passed up the stack as a frame of its own. A
> frame spans several descriptors when it does not fit in the RX buffers
> of one descriptor.
> 
> Mark the frame as errored instead, so that its remaining descriptors are
> discarded like those of a frame with a receive error. The frame is
> counted once in rx_dropped and once against the NAPI budget.
> 
> Fixes: ec222003bd94 ("net: stmmac: Prepare to add Split Header support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Arun Iyengar <aiyengar1990@gmail.com>

As you say, this only makes sense until Lorenzo's work makes it, this
should be suitable for net.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

