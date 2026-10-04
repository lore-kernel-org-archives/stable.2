Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F408C2E888C
	for <stable@vger.kernel.org>; Sun,  4 Oct 2026 08:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791103574; cv=none; b=Hb3HgVPwG7QQ5ycDF1fFcw2XXdaU9Q5q0xWMH29gyFmzOEaY9XV+3Q3hozqWBL2xtLB1uVv5ziryp55Zv2aJ9OzdCSiM/bMpkBWqVI2wYo6xYCFvHz4h0U76oYOQl8t6G7IYI+pJFITkvmWW3fYcSW+NK0ICXEUyPUd1Dq3nxJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791103574; c=relaxed/simple;
	bh=J9YwRGN77IP7yEemTbECWtPG2Dn+Y0IApsw/KTpB0a4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:To:From:Subject:
	 References:In-Reply-To; b=IHdkq1u/28K4/Hzyt39/YotXRkxZvuotWrtOCk6BM1YRCcQOq3EfNdTWz7mxkls0r8jYhecq06MA6ZDkEkmojHgTysW8oCajLaEtI8HsFwH57teKEfbHquCyBNXbVrmUmQu184I3+phw70VyaESOiUBVJuFYb2j9JF3visq5mII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=tFmnwn6N; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="tFmnwn6N"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D793E4E41150;
	Sun,  4 Oct 2026 08:46:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5D64E604FE;
	Sun,  4 Oct 2026 08:46:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0541010328327;
	Sun,  4 Oct 2026 10:46:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1791103567; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1v4gg6Lg7/4vOGj6jcBOLXQD+EJYylJZpyS7RIrs0bo=;
	b=tFmnwn6N3Gib/a3wqA+S0uJ0cF1/y25XjZRVSQJKI5jOHS/b6OyLrgxZIlbDXJUYEw89q6
	H/qr0TV0BkibHAhB4HSCAM4ExnETSiw1Gbb2G5oBIWoX+C1YgPE0v0EUO1rqIWhJzlYsKL
	67eP+ntzFERFgVumTAZPF6CUEPmRWDOXUM8u1hpNrBGplv1LWGs2+wXzELuqbXGzVhJTN2
	WIUUFK3fROFeI9SwvTvl2HzLcAgmXL0GSh/w68z4szVJvrjhwkff6ASpkFKKI15oJKkqWz
	NoyKDAZhhsshTayqKoVoyTg+U6jLcInjCm5qZT+B/RBPUzHZWgEIPGBRNTUDjg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 04 Oct 2026 10:45:58 +0200
Message-Id: <DLVX7ZLU4GOM.1WCL74N0U7PUP@bootlin.com>
Cc: <stable@vger.kernel.org>
To: "Jiale Yao" <yaojiale02@163.com>, "Conor Dooley"
 <conor.dooley@microchip.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Russell King" <linux@armlinux.org.uk>, "Nicolas Ferre"
 <nicolas.ferre@microchip.com>, "Soren Brinkmann"
 <soren.brinkmann@xilinx.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net v3 1/7] net: macb: manage the netdev lifetime with
 devres
X-Mailer: aerc 0.22.0-0-gc2f86b7abde3
References: <20261003085940.493951-1-yaojiale02@163.com>
 <20261003085940.493951-2-yaojiale02@163.com>
In-Reply-To: <20261003085940.493951-2-yaojiale02@163.com>
X-Last-TLS-Session-Version: TLSv1.3

Hello Jiale,

Those LLM bugs are code churn, that's why you are seeing pushback.
Please don't ignore the pushback. For example on V2 you got asked to
reply to an automated message, which you didn't do.

https://lore.kernel.org/netdev/20260927153020.5311dba6@kernel.org/

On Sat Oct 3, 2026 at 10:59 AM CEST, Jiale Yao wrote:
> macb_remove() frees the netdev while its managed IRQs are only
> released after the remove callback returns. An interrupt in that window
> can dereference the freed netdev or queue data.

Please indicate how an interrupt could land in that window.
Thinking about it for a brief instant, I cannot think of one.

> Allocate the netdev with devres as well. Since the IRQs are registered
> later, devres releases them before freeing the netdev and closes the
> lifetime gap.
>
> This issue was found by a static analysis method used in our research.
>
> Fixes: 0a4acf08ea62 ("net: macb: Use devm_request_irq()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jiale Yao <yaojiale02@163.com>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 17 +++++++----------
>  1 file changed, 7 insertions(+), 10 deletions(-)

Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com>

I still give my Rb because the patch is valid. The wasted time is on net
maintainers though; they'll decide if they want it or not.

For this MACB patch, it could land in net-next as I don't see a
practical bug here (in light of the recent pushback about the # of
fixes in net).

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

