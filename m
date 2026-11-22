Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795365101;
	b=eF5E5vYV6fW0xgKtiM8coh5MLNZojAhBMhVNSWS/C5kQFdnEOyorEH5yo+JSBeneyfJJ
	 XVmw1AWLbUzDj3XiGQgysAGZbQ398EeL8cnbTEu20r3rAkF66J1PALUX/+RQZFwNvcWcl
	 l5TgjGCj3OaHnvu5RWoVfLvZAADy+GwKOErkWoIpjsMktJGxUQKKpyuIQ+vOhsKrkg+4S
	 QIuRXwMf+BnNm/LgyAbCUzKb19u1oWAuQcIfPh60Uf2pTrebp1Xjr+q5g55aUerEiV0GU
	 nroSKWS+F4BtO4hZGgB1GKe09rbi3YfrVIzEBDLd6aqAf3JTdtqhMwOju1giJO/rnyA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795365101;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=j/ABN0weoH/winFO8vB9+wkWZtGk1oyDvKSMVSfn8VY=;
	b=0lxg48bkfzP6g1cOEmhFMGCGUOkOK3mAI8Sp4U08H/09hwJGJDpo56jLR+5qRI0Wpojn
	 cYV+xyMBCaZrmQPok5/YcFsoxF3dkzQQyL8GTWQK//oFce9efB85QLgB1QKFgPoVLvj+J
	 qNBjERK4GsUugn4mV94yENbF/5EMLBTvjQ/4EMiRnL9rF/kmtTWUUHlkkwUKLeGgmG8uf
	 q5jbT3JeK7l+NCeANq59oTcfA/JhqVcGigKMPZNa3vQ6E6nppyVPzUvjkmMUMip0wjrCO
	 EKgKoQ2xV6VPXrIU7dhq8CvjGPA33Qo46++fGPY+haN8w6DCY55C/f2rHmKG32u+GTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=TWqFJ7O0;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DFA606A32C;
	Sun, 22 Nov 2026 16:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 03DFA606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=TWqFJ7O0
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C25FEA03F0;
	Sun, 22 Nov 2026 17:31:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1795365098; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=j/ABN0weoH/winFO8vB9+wkWZtGk1oyDvKSMVSfn8VY=;
	b=TWqFJ7O0ELEUZetvWU8HRSG7eUK3T++NZpI4PJ0PHfZC7v8QLnMSB1RsKjaqBKIt5HJiUz
	Za8XmjLHFcNEfs1aW050lOjQXCgLxj531sxOnLZH8GT3vc3+WhiX5cip0q6ZrsZSfR3THf
	Ez3jTcPDq5rShz5TlWqHnpmrwCcrBvOl1GFUvqG5cBO7HRbBTJEfY/jQbosYToTM21HMBg
	ZnB0r6lu9RiO0KLihOUK2mskWTl3CyW7cU0uOA7/ZDNKA+L9qEsemtWInuTSkNl7r0Stbn
	cFNJR0NzUntuNiAMJmSfJlFk24TvBn/gPs5bDHCHa0JlriHfo6YNXyAYpUiBhg==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 17:31:37 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: wens@kernel.org, Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: aiyengar1990@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Maxime
 Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, LABBE Corentin <clabbe.montjoie@gmail.com>,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Russell
 King <rmk+kernel@armlinux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: stmmac: dwmac-sun8i: Limit the MTU to
 2018
In-Reply-To: <CAGb2v65_vY86WqvKr1m=g0N1Qr2UhLC1v3OHKPG3x+oURUKp7Q@mail.gmail.com>
References: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
 <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
 <CAGb2v65_vY86WqvKr1m=g0N1Qr2UhLC1v3OHKPG3x+oURUKp7Q@mail.gmail.com>
Message-ID: <5e09c85c2c33885fecbdf81cd0b9209b@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.11.2026 12:39, Chen-Yu Tsai wrote:
> [...]

> FWIW I think this applies to all DWMAC cores.

> [...]

> So for normal descriptors the buffer size is bound to (2KB - bus 
> width).
> Not tested, but I think there is more evidence supporting a 
> cross-platform
> limit.

The sun8i EMAC isn't a Synopsys core, so this needs a test on one.
Maxime, could you try MTU 2019-2021 on your boards?

> [...]

Regards,
Nicolai
