Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=194.13.80.246
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795365611;
	b=AMtDMuke/t2wAvFhpmIMvfOSPEu1xErb8Erg7LpS5uKVrQK7wcel/0l8E+SGuS3cfnZr
	 GzowZqI77OndvpxZzno5kLV4en09Hd7RqGtdH84L2xNP9ns7P7QvAjqTO+hozcLgPSgFE
	 OxDAFmiX3bUdsgPpYgXYDQKJm9i48FLCbvQOcCbU6FLRrOv87XyxNjVoIePmR+6m4Mtdv
	 l8hJGBzYjL7BreZaGEZo10Aln6kfqlWa5tCaEkHJy44O84fWl4s97XDEN0Olu8x91AJsL
	 BriweFCEDRkZlFopEtfURWzITs87jm56/yLZ8I+GvRPZeHhkPz2AVZNiLzeO87raolg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795365611;
	h=DMARC-Filter:Received:DKIM-Signature:MIME-Version:Date:From:To:Cc:
	 Subject:In-Reply-To:References:Message-ID:X-Sender:Content-Type:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=jaSKFlCu54zHESqkKubj1+NuHGdKJrU2G8EmITP6xpw=;
	b=thTVl33wVRzEIxtC+t/E5TbUPX6PHXyZ+0JIgiyES+EBVDW7jYKOTNmz6FhFhP1lpW9a
	 3uKH9cBQNCf1GzWPgfkaz352xGLGAXVnS43pKZ3bHRpA4+0avQ3r8VKUseiaaU7TdfrN5
	 cCZuBIs2OK+kV9trVHgYC9kY7nXpun6zkToclc3n7+jI9hexKJQhKLE3TgVdP2IXiHeR9
	 MOUHNXG1UTsxTkfJ4Rp5zAYwK4MrMM7skDFi+K6soMB45/ek67LDOpjixLqY9gm6lbEoj
	 onafaOfvKXuQahMYMnt+WCvIXQ2Lz+FYgkcRLEU21H1qpf/bb6hICcGOI1jB0SZTa2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=tipi-net.de;
	spf=pass smtp.mailfrom=tipi-net.de;
	dkim=pass header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=2yGVPMCs;
	arc=none smtp.remote-ip=194.13.80.246
Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37413606A32A;
	Sun, 22 Nov 2026 16:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 37413606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.a=rsa-sha256 header.s=dkim header.b=2yGVPMCs
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id F341BA023C;
	Sun, 22 Nov 2026 17:40:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1795365609; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=jaSKFlCu54zHESqkKubj1+NuHGdKJrU2G8EmITP6xpw=;
	b=2yGVPMCsKB3mt0D1EmjrbYxsJH5uCeek02v4QJQBgHuca6yxEp3cPBxTqiuhbjp+hcD1JT
	qWhCCU3Db1/ZeHtjVZ0KUsjfo784QkArs/MesO7Tp1bywtjxJIb4D/uw5+kYlbCWJa+5U+
	9qHtDaipoqGplt0zmmk3wGl/FJS84OmLJdYpfKYu2I+lp595UR2ukxDaAWovWK/Tv9QDEU
	Am0kA1Ppi4cJd/pz6za22JNtpx/tsnufFctYmMXIGntJVcJEym3h+o4CjqT/onWnDSe5wp
	cKJ7GXEDELKLFaYYUoUu1mFGgmS39jyehxTunpFReo557C9Wdl/AwbyGnqtC0w==
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Date: Sun, 22 Nov 2026 17:40:07 +0100
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: wens@kernel.org, aiyengar1990@gmail.com, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, Samuel
 Holland <samuel@sholland.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, LABBE Corentin
 <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, Russell
 King <rmk+kernel@armlinux.org.uk>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: stmmac: dwmac-sun8i: Limit the MTU to
 2018
In-Reply-To: <3459ab2c-e35e-4fb1-80d0-b79991b5bc2f@bootlin.com>
References: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
 <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
 <CAGb2v65_vY86WqvKr1m=g0N1Qr2UhLC1v3OHKPG3x+oURUKp7Q@mail.gmail.com>
 <5e09c85c2c33885fecbdf81cd0b9209b@tipi-net.de>
 <3459ab2c-e35e-4fb1-80d0-b79991b5bc2f@bootlin.com>
Message-ID: <8a11d9e72123b68d89a0422dd9211e88@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 22.11.2026 17:36, Maxime Chevallier wrote:
> [...]

>> The sun8i EMAC isn't a Synopsys core, so this needs a test on one.
> 
> It's likely a synopsys core, but with some wrapper around the register 
> accesses,
> hard to tell how much of the actual dwmac is in there ._.

Someone really needs to draw fancy cheat sheet with a stmmac family
tree - lots of weird uncles and stepmothers :-)

> 
>> Maxime, could you try MTU 2019-2021 on your boards?
> 
> It'll be tested in the nightly runs, I've setup some local MTU sweep 
> tests
> following the previous version of that patch :)

Thanks!

> 
> wonder what else will come out of it, I'll report in the morning.
> 
> Maxime

Nicolai
