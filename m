Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0727C4DAFAB
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 12:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789646418; cv=none; b=OJMBF9z5VOAppUm7v7K8AxqznAAZbNHymu87noUQXIKsET54IHf6Bh9vLPs8fa9ARN1GrodDw1u7YkFcbXzO7WQ51H0z4FM2nTVVJ8lo2clxIpB9fdtT+WEARkPYDvksPKnhrlAtqUADfWJYyzcSVT30WNQ5jV62f9lg7lmZuFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789646418; c=relaxed/simple;
	bh=6zz0UggjsgW8aIxNzYIr3E5Qh5d+RQx1q49vq5jdOY8=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=U/O1B1TV6wEowbR0okYRbm59dPBKjJG2S72VHu5ctzsjYyofQU1/mEzWz/TAYYiiIV7SuxpF8vw/vTuFHmqLVaQ4/ueFEPLNT58KOZSGJUnxa5oQbBpJHQdNdzmq9XWahTqJUTFEgxGp5onVEbnsFnWo1gGf3JUoIqvngRF/tNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2ZPeAWCt; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2ZPeAWCt"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id D1697C5CD71;
	Thu, 17 Sep 2026 12:00:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4A9D35FAA3;
	Thu, 17 Sep 2026 11:59:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0716F11C7B02B;
	Thu, 17 Sep 2026 13:59:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1789646390; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HbgCCZfUU5o4soNjWP9yPKjHTi9IOiOG0p+xu2EOYQk=;
	b=2ZPeAWCtM3SKLnrtXvUTMLzIPNRs16ehkS8H38w1S6A9D3zpPH60evw5d4wC2UtPxYHZBy
	hA1gpPg38ekc44bVmialY46Z0WWHo72TRjcwvHX1Rq/bQFW5AiJde1dkUSBL9Uw++UJU7V
	NTvCNLoxYuY8dbTa9j6/HiBitQoSvNFLYMqeaFyltBC8+jlhRUG9tKKDOLGLhzhbBWMJe8
	wb4mEoN8/sCu+ZPWKHV0LGyOXToEQuZMPNIIy9at1+4y5uMGpe1yChTbuHMZ8gXBc3b38q
	YVtPmu+9fyYgeux/bTz7wbQn4QxKJKRR59PJprY6LK43IBDvOjpidTJJdNBg2A==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 17 Sep 2026 13:59:46 +0200
Message-Id: <DLHKP3SF683I.Q29HH06Z2MCY@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH] net: macb: Fix mdio_np reference leak in
 macb_mii_init()
Cc: <conor.dooley@microchip.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <linux-kernel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <o.rempel@pengutronix.de>, <pabeni@redhat.com>,
 <stable@vger.kernel.org>
To: "Wentao Liang" <vulab@iscas.ac.cn>, <andrew+netdev@lunn.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260917105223.2147724-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917105223.2147724-1-vulab@iscas.ac.cn>
X-Last-TLS-Session-Version: TLSv1.3

Hello Wentao,

On Thu Sep 17, 2026 at 12:52 PM CEST, Wentao Liang wrote:
> of_get_child_by_name() returns a device node with an elevated reference
> count. macb_mii_init() drops it on the error paths via err_out, but the
> success path returns 0 without calling of_node_put(), leaking a
> reference to the "mdio" child node on every successful probe.
>
> Release the reference before returning on the success path.
>
> Fixes: 8a6631f1cece ("net: macb: avoid redundant lookup for "mdio" child =
node in MDIO setup")
> Cc: stable@vger.kernel.org
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/cadence/macb_main.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ether=
net/cadence/macb_main.c
> index a12aa21244e8..0c4775d51263 100644
> --- a/drivers/net/ethernet/cadence/macb_main.c
> +++ b/drivers/net/ethernet/cadence/macb_main.c
> @@ -1164,6 +1164,8 @@ static int macb_mii_init(struct macb *bp)
>  	if (err)
>  		goto err_out_unregister_bus;
> =20
> +	of_node_put(mdio_np);
> +
>  	return 0;
> =20
>  err_out_unregister_bus:

This patch has been sent by Nicolai last week. It has been applied &
merged into net/main then torvalds/master.

https://lore.kernel.org/netdev/20260907210856.1673589-3-nb@tipi-net.de/

=E2=9F=A9 git log --oneline --grep=3D'child node reference on success' \
      torvalds/master drivers/net/ethernet/cadence/
382a373d9ea7a net: macb: put the "mdio" child node reference on success

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

