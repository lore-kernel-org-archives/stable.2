Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.171.202.116
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795531909;
	b=lzOV7IiWFHxhdBXL6ioh79SZJVdMcUClUZS01NbzwnR9qVKP5d1DzjXuBuOWlzx/5G2w
	 X3Qyek8pyuDntwAy2OtCWbmQcy4gbNRA70yi3o1sU33Rf5o/U5he0DyL9ZR6cTD1EX1jj
	 nj7gRnsNboAEsCWCegZadwBkffY2uPgIxh2q3JJu3vgOsaeojF9SnEmfrsjTQZ80LsdRI
	 ZIFyP9y33rJaJ22z/8/LWl8ev6bGc6sUgHkQdG2pgU3fDh687bvWlAXm1O16cWweRBPJB
	 pVhej2ExWAx6cFlxOtXVxoncroXIDh9laVeaM2xutgAictqUDLKNS1U6JOlVoXgdAsw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795531909;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=ULSJeJaQRalsTqoU5W1rSuYhUrpQTwSQEQPfYYy36zk=;
	b=ePsn9L6hji6aoDN2XJOaD8hmOW9DoRvTDJiXyBa+1CWsMIEXpaSwzt4tkDcG0yOgIL98
	 uyLMFbXApblEYi7ZtYi95WRBk67pc9KKKSQwd/Kzoju/kqD9gZEG04w9iDt5Cn+o1J8vd
	 WUcgWPOt+VP+P+SumaqTkzCRDpIA52y3Hy6KbkVSGuGJ0vyKyZfd1JL37Nmq/xW+pFa6I
	 r5XLVLivXvE+6B/fUum2uSMs2ju8oJGwH3PHoHTJEDrfpCBvzYpn7iG48TKn+/HfobboV
	 2HnjtanfSYP66fm5Pr/fCmismblJdqlJ5dKoNYb7kYp1Ysh7857go/akorrR4VV0VQw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Jzg3QENG;
	arc=none smtp.remote-ip=185.171.202.116
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E732606A327
	for <stable@vger.kernel.org>; Tue, 24 Nov 2026 14:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6E732606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=Jzg3QENG
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id B9F1CC2C64B;
	Tue, 24 Nov 2026 14:51:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 45162601E1;
	Tue, 24 Nov 2026 14:51:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5FCCE11E698C3;
	Tue, 24 Nov 2026 15:51:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795531905; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ULSJeJaQRalsTqoU5W1rSuYhUrpQTwSQEQPfYYy36zk=;
	b=Jzg3QENGVlhk4j/SENqmtOZebmGfYqsEyLpCNZMOV9RWteUNWbt9h7o5HLWm2gZ6UlACu9
	Iz3GhKtkvPZU0gNvccDbmmZeYo63x1kb1z7kPU0wFk0t/hCn3II/U/3dia72VeQgXsZscw
	Zi1TaVrwWsdn2+Rg7yIR8wT1DUNJc7qY5CuIjkCUjZ4T0n92DsYJNRL/QEMQNrjAUOI/m6
	DqrOe8D5SwORGMVaXLAwj0+X8sWjyaBW4VRjsZZse5qJWyDPctLkPRbLS8s4DxFOEA0qHK
	Ik/pYTwLm2pGLZ7Y7ZP+sxFxgNao51qbMd96bpcDXMpgGumI2jHaiqOpm6lW3Q==
Message-ID: <73996d83-47bc-495d-ac5f-539c32b5147f@bootlin.com>
Date: Tue, 24 Nov 2026 15:51:35 +0100
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
Subject: Re: [PATCH net v2 2/2] net: stmmac: dwmac-sun8i: Limit the MTU to
 2018
To: Nicolai Buchwitz <nb@tipi-net.de>, wens@kernel.org
Cc: aiyengar1990@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 LABBE Corentin <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 Russell King <rmk+kernel@armlinux.org.uk>, stable@vger.kernel.org
References: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
 <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
 <CAGb2v65_vY86WqvKr1m=g0N1Qr2UhLC1v3OHKPG3x+oURUKp7Q@mail.gmail.com>
 <5e09c85c2c33885fecbdf81cd0b9209b@tipi-net.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <5e09c85c2c33885fecbdf81cd0b9209b@tipi-net.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 11/22/26 17:31, Nicolai Buchwitz wrote:
> On 22.11.2026 12:39, Chen-Yu Tsai wrote:
>> [...]
> 
>> FWIW I think this applies to all DWMAC cores.
> 
>> [...]
> 
>> So for normal descriptors the buffer size is bound to (2KB - bus width).
>> Not tested, but I think there is more evidence supporting a cross-platform
>> limit.
> 
> The sun8i EMAC isn't a Synopsys core, so this needs a test on one.
> Maxime, could you try MTU 2019-2021 on your boards?

Sorry for the delay, I'm back with numbers :)

So on net-next, w/o this patch, I see:

 - dwmac-sunxi (Allwinner A20), the first MTU that fails is 2029 (so frame size is 2046 incl. FCS)
 - dwmac 3.70a (meson-g12a), first failing MTU is 2031
 - dwmac-sun8i (H2+), first failing MTU is 2025

The first two are ring mode, the last is chain mode.

This was all untagged traffic.

Maxime
