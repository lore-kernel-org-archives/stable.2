Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795805827;
	b=w/khcmpXoRgdhpFhEuA2k5rU5jByqbSyVW4mwscG7LgYFtK7Ld3R4My6rnl+/TeZoX2R
	 twkQD/JYZ1uXqRCknsPnzaJZ8mXCkz7koKcUFIkWR7qg7Zs2okphE4J6gryHj0anmlZRC
	 BiGRiNCoMneLgTk6YwchQW1dr5/JupqdLHGCSNyPuwIQP5tbVVDnx8b7iPALTaWVjcmDf
	 Fs7OIOb7Q3F3iqtuRGb2pyEW8KYujo0rmJ4xi+ALh3eORg4tTygWXFBf5iVEJCRsArb0N
	 +hHFQUn6Q/fSnsGWbNYLufwDmcGaCBcYOMnMHw99hIlX1cUJxMkkxjjRxokpPOiB8Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795805827;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=HmYIiM6tWPo2N+WO8cTd9BpDIE3SkMBLv91uqBg4XLI=;
	b=E8IimAkZJ/iaFCorrzg/troqubnc3iWSdWIE2GfrRiFURV3BJnljyH2X/6Ool1bnq1pi
	 mO7xni/eSo9cgwKNdhtwuzZLO7Xfc+GeYJ7NlY/XFaTiOCynEENSl6zuPu2KWxlBPPDCy
	 IT9DOzqJQknIDM3IWgnmpGlUfbjVwxvSgPI7RpaKA3yrMvQB/BGbETsr2oUQOHdCqx7cy
	 pOnwsKLd53VdGRONaigrqxTQIhwjR4YIzbCfwGDIDxReQ4onR6EiBEChfMLMb2vnLWIMv
	 EadtlZxxTI1lTxJdWqnZwM/JnR9tWzqFKH45ZdMIhUAbbZBBhuU6lpJe6c3fy7P/TOA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2LNa26p2;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F190B606A31C;
	Fri, 27 Nov 2026 18:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F190B606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=2LNa26p2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=HmYIiM6tWPo2N+WO8cTd9BpDIE3SkMBLv91uqBg4XLI=; b=2LNa26p2awWx3mDMv/MdibpYRX
	Czbe+Dg7mD5L2fXrgMfG0rAXsl5dmwb/NCurqxJyGhnySwWyo1DzKpPv4JYfRv6CLzTleJPChPICR
	HmGvS65qenDY7NxC24qLiBlWzvng45hv8IAlkPfinrBfisIPXg4tKFmjpqsyG8Mm/1zE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xX17r-001rm0-QP; Fri, 27 Nov 2026 19:56:51 +0100
Date: Fri, 27 Nov 2026 19:56:51 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: willie.wiholm@tritechsolutions.se
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haemmerle <thomas.haemmerle@wolfvision.net>,
	netdev@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RFC net 1/2] net: phy: dp83867: set INT_OE when enabling
 Wake-on-LAN
Message-ID: <8abecae4-8a6d-4608-bf97-45423d69541c@lunn.ch>
References: <20261127-wol-net-v1-0-769a2aff91df@tritechsolutions.se>
 <20261127-wol-net-v1-1-769a2aff91df@tritechsolutions.se>
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
In-Reply-To: <20261127-wol-net-v1-1-769a2aff91df@tritechsolutions.se>

On Fri, Nov 27, 2026 at 07:44:56PM +0100, Willie Wiholm via B4 Relay wrote:
> From: Willie Wiholm <willie.wiholm@tritechsolutions.se>
> 
> dp83867_set_wol() enables the WoL interrupt in MICR, so a detected
> magic packet is signalled on the INT/PWDN_N pin. That pin is only an
> interrupt output when CFG3.INT_OE is set, and dp83867_config_init()
> sets INT_OE only when the PHY has a valid IRQ. Otherwise the pin stays
> a power-down input and the WoL event never leaves the PHY.
> 
> This happens on Intel Elkhart Lake boards with dwmac-intel, where the
> PHY is polled (no PHY IRQ in Linux) and INT/PWDN_N is wired to the MAC,
> which raises PME to wake the system.

Can this pin on the MAC actually generate interrupts? It would be
better to turn it into an interrupt controller, so all the usual
mechanisms just work, like PHY interrupts, not just WoL wake up.

	   Andrew
