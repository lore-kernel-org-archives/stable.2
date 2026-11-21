Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795284176;
	b=lnm//N/i42Fw9mLmKGfQ3a2oXqi/vwfT4BbyOEa44L7UGjlK/Rt3PwYGzpllHN5GR4Qx
	 j+KhTkj4ooCxwvrSHinbbpA9s0la2muFgYHG1v8MQpgk/w4XFm/x3KLwHIxApJTptX87x
	 30T18aApasjbJdLfjGpTlNznsHif1cF9E0q8r/dDh9JYLVwzcoWsrtk6j99lWB9zVNOhL
	 BZRqhKNa2CA9+xNpbC/Ixw9c7CM8SM8wVd4B/lQsu1uubZM4RudGGi38duTUTIWGwn8hH
	 prGiy7RWhcYoNVqsQ9drWJvRO3uLaguiY9fTcNVWAMcfne6227aOBvZzBS8HZRMt1ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795284176;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=ZjOww6Av4TYuUIUrHXUPGTFtUR3yqkQIr555NuUOYP4=;
	b=LfTCDYTj0duGugKfQEpl/GtaL9oqAOSpFGbx5NjfCahgytUuKYILSuWjqwxRrejSQhBe
	 ZWb1sfO0IBmiDKjdo2UpgAHh1ZHeTP6pNRg+x0JFQEEN0I/eez2LE7PH2thIDYgepmZtR
	 jtF0Ym9wtj4pzOHI3nJxGTehIJ9J222AcKtvFBlCDkBIeYKOON8/EO9/oF8uAfSjn0+5X
	 LBi9EItiGXZVbUccCwlm3yZz4Iw5DVZUCb62gFyKxMyGfc/Tg1JpqH42zoK5DuNWRnuDv
	 oaoI4jq3uweVXS6B1m+kUm0cOlUkp3FUBpQRUpeSIJyNfx6gu+On039TQf8R135aUFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=NQy5ayoe;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96557606A32C;
	Sat, 21 Nov 2026 18:02:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 96557606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=NQy5ayoe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZjOww6Av4TYuUIUrHXUPGTFtUR3yqkQIr555NuUOYP4=; b=NQy5ayoerTWJL/iw2Dp7R0pY/8
	9OYzjOKz3wZJGygM/bkvVNRK6RArDIz2w9i8ryW+/3jGc+ENmmttk+4SA12zROqWAiPKx+ezFx6Xe
	A10j5IRJj8/yXoTScm0agc9zOEk+yptuWcZ8jaCz0lFFE8tHTvpiuizaw3acnuc1d5XY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xUpQ6-000TX2-Q4; Sat, 21 Nov 2026 19:02:38 +0100
Date: Sat, 21 Nov 2026 19:02:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: aiyengar1990@gmail.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	LABBE Corentin <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-sun8i: Limit the MTU to one
 descriptor buffer
Message-ID: <7dee2bac-9892-42df-b2d3-62d648af3452@lunn.ch>
References: <20261121-sun8i-emac-mtu-limit-v1-1-22492842d318@gmail.com>
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
In-Reply-To: <20261121-sun8i-emac-mtu-limit-v1-1-22492842d318@gmail.com>

On Sat, Nov 21, 2026 at 04:43:41AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> Russell King pointed out in [1] that max_mtu ignores the 11-bit buffer
> size of normal descriptors. dwmac-sun8i always uses them in chain mode,
> so a frame must fit one buffer, but max_mtu is SKB_MAX_HEAD() (3712 on
> arm64). Sashiko asked in [2] for this to go in as a fix.
> 
> On an H616 the RX DMA fills 2044 bytes of a buffer and
> ndesc_get_rx_status() drops a frame that spans two. On TX the MAC cuts
> a frame after 2048 bytes (TX_FRM_LEN_CTL is clear). At MTU 2033 no UDP
> datagram gets through in either direction.
> 
> Limit the MTU so that a frame with two VLAN tags and the FCS fits 2044
> bytes (MTU 2018). MTU 2019-2026, which worked without VLAN tags, is now
> refused.

Is this problem specific to the dwmac-sun8i?

   Andrew
