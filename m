Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794760230;
	b=ppFbreM/95800Vio2yknnunZHJ1pwduGrZvqAar4u2+19iQnELN2tBs0yBqvK50rnhv8
	 Az4yQy/tBT7RdQt2jRc22Lvc8rJ288Ut+rUN55fo+/C9BAYXOmaUEtlaDn48PVLDy4nBC
	 wCehOnIYPzhp6i+8Kmvj+LnItzCQYlujflxFS+GpeTfAu81PiapHzlJYC2MO/BKwtaZbE
	 t/dz5PuVcGnLLo4OjOr04bPcjPJK5Qe/9Y3gj0RYCssS2N6NE/cz89OlAlTEXn//hWMSi
	 4JGr7drWkqSxUDv37zwSftHzTSq0lOUsR4zdmyGXKg/7D8hNYZijIU3bHbwBs/EKLXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794760230;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=PRfMstXhdcPzzvK7D8pz3OXvYeTvk21pS0iDoNRxa/4=;
	b=I/QsIqDinJAEOJhGYqnS4DTAsh+1ly1mNEaIy3ybCDR83/wqUwSFbWCvGxv9q/fluwDh
	 Z02eo6MRPfg5VAZStVOZe5J4BheKsccNwwpertCIjr3jIaVvo2KSSlBX6m2T1K5dpHcjH
	 y05pVQ0MQatxqDwwp8I4Y+lpUfktxDhq1Yjx2VjoNm5UC2J/2wcXJh3LRZqoEuhIAEn9D
	 WcGNqEU09nthLctyf6LTgSnixaH/QxHmrvtH3MnfIEGdyF//3zUAMSC6beAj3nVUi8Rhc
	 vszh2GfMw4m25k5dwTY7z/SW7fHwTgDPmX5qE50FxWPuP1bgO5hKfNW6yM9zsD9Oxbw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=py1VCyc6;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D1A606A31E;
	Sun, 15 Nov 2026 16:30:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 71D1A606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=py1VCyc6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PRfMstXhdcPzzvK7D8pz3OXvYeTvk21pS0iDoNRxa/4=; b=py1VCyc6VJVO40Q1mJxxlwgAeg
	EdABDWYqicuuJqBugByltKdCTWQMeM0MnRJstGnSanlNeltTxNFb/M9X1jH7zR+9AYbp66triwCsK
	bA6yR7qFvBgwRX6HHfNFBavw8AMutt8fwQ1pnJVulo+AmfuLkxrTTs8kPVRJJGd/wL7k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xSd7P-00Gdkr-2r; Sun, 15 Nov 2026 17:30:15 +0100
Date: Sun, 15 Nov 2026 17:30:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ziheng Wei <zihengw03@163.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: reject non-PHY mdio devices in
 phy_connect()
Message-ID: <06c3990a-8f2d-4e8c-931f-6ad77a79a84b@lunn.ch>
References: <20261115161811.941022-1-zihengw03@163.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261115161811.941022-1-zihengw03@163.com>

> Fixes: a9049e0c513c ("mdio: Add support for mdio drivers.")
> Cc: stable@vger.kernel.org

Who does this bother?

    Andrew
