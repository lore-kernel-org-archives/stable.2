Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794489263;
	b=rtNl4tq2bx5nkmXWuIuY0yXhZ9g4gNVUe0+YmxK5CH3IVvYqxOAgaHtOH1NpBiTzyKVR
	 CqGkapFhAr9QU8PwjAVT1qVHTJcXzJNHgnWV0n6DRM4SsP5bvK5Q+7fc1BdX7CAjqAdyt
	 pUnf8cnX3qz7Vo0FrDn6xSqRkJnezlbTDM09t+JTS9zk6s2lfo+mXHTOa0WgQWHDzLRFM
	 pl8l8q7blSH2OAsSUXXfw2JfBLwG/E2cM1DBzmVydEaMmsNTGgfii5vUpu2CwZI4NBmee
	 lLxDsYCH/drFmWuw3hM+qqfG3+fgpbvvRFFOkYu659RxAvK6InuRsdAS56zP9sXIqaA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794489263;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=JsseaZWlHALkJDroqnvRsrsIA8/F+g3l2qrb9axVxOs=;
	b=ffIarSW7wIPXgimfMTeY2yisTURqBVIU+1QmY0zoACgTnvR/vYzLiVArttl1hxw9tVa6
	 IyUM/M0jdLfUGpDaNen5WibvPM48AVFt0FZ6oiexqp6qHsslppScQrS3Dee1Rq78IC3cV
	 rF/yFUh0AunrmQUcjR7KnP6nwdLddvRMWsztPYH0AsgHVnlvJbdAKEbSF7XnE2Fv6XDXf
	 Ny5JPxafA40w/pPq7akVYESy7OQErKxiujSQ/jlVld1tBKhqtDBfkwaG37ZIpiCzIwIO/
	 XSBg3XqlU8CW/VtcDx4JT1sh0hr7Z+W7XffboTwtaB7jmnATtrZXEZFGuB7h1ndYE7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b="WIJl/qw7";
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C430606A330;
	Thu, 12 Nov 2026 13:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9C430606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=WIJl/qw7
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JsseaZWlHALkJDroqnvRsrsIA8/F+g3l2qrb9axVxOs=; b=WIJl/qw7H0BAcm1v01iuIz8K0n
	/zMRv/4PU6hmW6MyyaRlRwjgpLKzdkb+rhiJrtiGtdp5c0BlWUd8nxgs3pMCg9asI6XeZ8oVc5gRr
	/A8XijRY6spjDYf2F9uh2CuhqOe8LqdJeU7ovZBP65Q0Jo/pXQSCGpH3Y2H0fEHpU0Ww=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRUcp-00G1SL-1Y; Thu, 12 Nov 2026 14:13:59 +0100
Date: Thu, 12 Nov 2026 14:13:59 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: aiyengar1990@gmail.com
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: dwmac-sun8i: Fix use-after-free in the
 MDIO mux error path
Message-ID: <e526541c-f91a-484b-a677-4c55e4a96a7b@lunn.ch>
References: <20261112-sun8i-emac-mux-uaf-v1-1-308ae7e6fcf2@gmail.com>
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
In-Reply-To: <20261112-sun8i-emac-mux-uaf-v1-1-308ae7e6fcf2@gmail.com>

On Thu, Nov 12, 2026 at 05:28:05AM +0000, Arun Iyengar via B4 Relay wrote:
> From: Arun Iyengar <aiyengar1990@gmail.com>
> 
> mdio_mux_init() registers the child MDIO buses one after the other.
> Scanning the internal bus makes mdio_mux_syscon_switch_fn() select the
> internal PHY and power it, which sets gmac->internal_phy_powered. If
> mdio_mux_init() then fails without switching away from the internal
> bus, for example because registering the external bus returns
> -EPROBE_DEFER before any access to it, or because an allocation for it
> fails, sun8i_dwmac_probe() jumps to dwmac_mux with the PHY still
> powered.
> 
> That error path releases gmac->rst_ephy and gmac->ephy_clk and only
> then calls stmmac_pltfr_remove(), which ends in sun8i_dwmac_exit().
> Since the PHY is still marked as powered, sun8i_dwmac_exit() calls
> sun8i_dwmac_unpower_internal_phy(), which passes the clock and the
> reset control that were just freed to clk_disable_unprepare() and
> reset_control_assert().
> 
> Unpower the internal PHY before releasing its clock and reset control,
> as sun8i_dwmac_remove() does. The later call from sun8i_dwmac_exit()
> then does nothing because internal_phy_powered is already cleared.
> 
> Fixes: 529254216773 ("net: stmmac: dwmac-sun8i: Balance internal PHY resource references")
> Cc: stable@vger.kernel.org

Does this bother anybody? Seems more like this should be for net-next.


    Andrew

---
pw-bot: cr
