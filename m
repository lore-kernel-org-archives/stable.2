Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F8A28A3FA;
	Wed, 17 Jun 2026 09:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781689766; cv=none; b=LICI736UoPKIVXhr75NKQfwA2Pc55I5/9GOneLzYOfHO/BaI60sbgaki/pXEoURz74fApQV9uvcr8bw93NnA4UebygmwP9Hi+FZ2APCGlkaj1NwEhdywFJTkburXgiRgzqusU+bnU4rEK0zrSmXFAzp4Ivs6JZznnj7i3eb8BlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781689766; c=relaxed/simple;
	bh=wi4lwLaRO7F267pP1ARLV3qFeVZRDo6AoT6aFpopDXU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BfkdP0QY57eg0kXgGqbiAZUdMWyQArTy9b7kwYonF0HiwVzPCxYbx1FfKDaZpz6qgcDukQUzw0R9G0R/rSEycJPY94tEEBMNsApFM0WCwmcyL+TPMGLPj885QgAxoAQXGYT0QGuaTvlGvMy8eHwZ8NAuuzIJ/riCq481DxKjwT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=W3Esklww; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="W3Esklww"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C0BD1A0308;
	Wed, 17 Jun 2026 11:49:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1781689759; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZlrDqMyQq4zKuxqKG6lBK1mUYEi66ZSWBSX8jgTDuvg=;
	b=W3EsklwwgvkjKyWSwWZfYrzQbovQcNjs6sjus2PbL+xZtai3n+k6BItSd3Sn5BdaJKavyP
	2oioTcOF9K6PWGlaJtTS4dD72/SHb9HkJLEDCho6A1ro6lI2NkBYZrcH6AdrOA7XNfan7E
	B3D1T8XlsmiftI68bxMYzk7u4ov6wOXetIn9CKH7coyMuV95SfS1tWMuQDtgYg+XPsu6ys
	spjpM7Ik49Vx+ZvWDI9D5tKsbYuEDxymV9UEPdvZbcer9QGFBzmdYp8LnvSUgDAiWr9iu+
	+M98Mdat4VeZL7b5hpi/OQ9tiHxQCLkb9Z2zoXTVMUVjKYSsnMu1tTBRpnJj/Q==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 17 Jun 2026 11:49:07 +0200
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
Subject: Re: [PATCH net v3 1/2] net: macb: give reasons for Tx SKB kfree
In-Reply-To: <20260617-macb-drop-tx-v3-1-d4c7e57d890b@bootlin.com>
References: <20260617-macb-drop-tx-v3-0-d4c7e57d890b@bootlin.com>
 <20260617-macb-drop-tx-v3-1-d4c7e57d890b@bootlin.com>
Message-ID: <739f87c219e04468fbe0453013a7342f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 17.6.2026 11:17, Théo Lebrun wrote:
> Using dev_consume_skb_any() marks the drop reason as SKB_CONSUMED every
> time we free a Tx SKB. Instead, replace by 
> SKB_DROP_REASON_NOT_SPECIFIED
> when packet has been dropped without sending.
> 
> It is not precise but at least differs from SKB_CONSUMED and is used by
> many drivers for their error codepaths through 
> dev_kfree_skb_{any,irq}().
> 
> Pass a reason around rather than call dev_consume_skb_any() or
> dev_kfree_skb_any() because macb_tx_unmap() is called for cleanup in
> all cases.
> 
> macb_tx_error_task() is made complex because some SKBs encountered have
> been successfully sent.
> 
> Fixes: 89e5785fc8a6 ("[PATCH] Atmel MACB ethernet driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
> ---

Looks like my r-b from v2 was lost, but here it goes again :)

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
