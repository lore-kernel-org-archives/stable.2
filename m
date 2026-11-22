Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795365425;
	b=sIyZjL8bGPwnFKpXoUv4g3M4OOIHeTvptY37EX+wj/gkDn30xxECfP3uBcCl20UPBxxi
	 HfcNs1aT7tKSYGhttvbLQNNs1nl5kSWbGZ+p0JxkrDewcoBIdptuQJcQTIoU7v0cf+71Q
	 XXyIGfFgITbNIVdOPysaLqLSzJbCsSFVGszIKQhkEJhXsM3nzK62HiyJIBeGWDpzM7Qsi
	 dJFOCMSwZ0JThRqV0Pi0YrsC/0uyj3NxbHofybDnOMmqKdfsuSASMr668BXCEFvPeIzCe
	 nf/2SnF+cFiW55kd/AKgulJ2xmSP5lbx8BRfj25w+8oFy9+JRyA2tJQxjM0DrF8gWCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795365425;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Last-TLS-Session-Version;
	bh=wYErie+YgFKgwdokQKPH5aMCl4CIj8MWz6Gs+KkWE4Q=;
	b=oKvLl1qReeSPC/o5BaQYwSdvpiQZkbzA3h0CgidjP6JhXphNPDRjNIN3KpqbovwTm7FO
	 HlKXIbc0zFhyvEucOAGHOcWW6snIOYrfa/ofvTEHumwd+A+x4FN4fwHlGBM9mT22UCnYn
	 0PV7C3lBM3nUA6yDe0+WgYHaDqbzCTyhwSWymnlEndxVRka8JKMeEmdRYk+GzozTqa4sZ
	 b7kn1tPQedWCeyhcAYKhoaaXJ4uOqS6M84Iewgf7yyca1bIg3UkjdoQTDKcPkJ7EkDj1f
	 O0K3IB9kwthH2g/VC60nO3jH8ucP1pAzvCHkBPBun6BonUe8PlFXiMfyd9aKyehIZ0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DrZ+0Dbq;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED445606A32A;
	Sun, 22 Nov 2026 16:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED445606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=DrZ+0Dbq
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 38BC44E416DE;
	Sun, 22 Nov 2026 16:37:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E43DB60512;
	Sun, 22 Nov 2026 16:37:01 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6BB5111E6256E;
	Sun, 22 Nov 2026 17:36:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795365420; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=wYErie+YgFKgwdokQKPH5aMCl4CIj8MWz6Gs+KkWE4Q=;
	b=DrZ+0Dbqt9RADd8Bw0JW46aL8a4DDFcS/lCIDEsCpAuPVGKx2tkyuNCj4BgEpxH5fTPYu7
	DiQAl7hy+njY2Vwjw2kr04u0Pl5iCuvGYr71O5Gk8/wSnKLYFcotjGB/BaHOuYxV7urOar
	LGsljGLFaLpqnnOuHXPjpHMn8HuiPnVTvYAqKXwp1anE/mzPSuKdKBtKLPG8V5POd5BUEF
	U6fgFL00bBiz81vNc9l3qyuXfwo/W1nrP9w2SzHnmDt1prfFSfCPq3AjGpbOe5uNG/2NDQ
	M9evLcT0oe20zcH9OX4txkjLA7q4C0hJAHD/XQg+5EkD/h1Qb5gM2E6rRN8qkA==
Message-ID: <3459ab2c-e35e-4fb1-80d0-b79991b5bc2f@bootlin.com>
Date: Sun, 22 Nov 2026 17:36:43 +0100
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

It's likely a synopsys core, but with some wrapper around the register accesses,
hard to tell how much of the actual dwmac is in there ._.

> Maxime, could you try MTU 2019-2021 on your boards?

It'll be tested in the nightly runs, I've setup some local MTU sweep tests
following the previous version of that patch :)

wonder what else will come out of it, I'll report in the morning.

Maxime
