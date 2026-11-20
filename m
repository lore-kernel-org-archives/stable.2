Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145364;
	b=dDChrXWZHSOebGnpCafJg1zJtDYJHW6lHXuinXNcwmfsFhSsBZptp/Un+Kpw/oXXomhs
	 lNX3Vl9rq2QQEFFrxVYNoWDveYTqldKUVuuZvefXW6RI1Z/kLX1rLjTnM2NTBXXURrbGb
	 yhEPzPtLMkTrWMsnJ1u+GLVj8XjSOrqISJCRRmWNtcEpdsVaou5QGeSdcTbndJ8a9MSlY
	 qyPBoYIkOcvz3WhCGp4RYvhZaEYe6llfiX6VkNoIuJ7oHI7NbyingV9Jh6xvglXf9q12p
	 hPx9XXmHGtVNtzpO3sCYO/Uw0RXTH1hTmWTbb8wBIe063wLMT73iAaWdJp19Y5wuFFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145364;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=dzVUz78BxetOP2oXgJlZ21u694OXSAGbMXxRsvn1+cc=;
	b=TzPoeBNh4MiXLW9WqBkGyzwb3IqUSO4+Hr/7BfW4h80ASKZLmEDgzmoUytMNrv21mY4O
	 QGGD6hqmuBNCF84djO3jzn8eBifZ68XqSpPHqaUpJWcsPMbH8oruvrQcSFA0lDUQ4ISZC
	 jun0H8kVbLIr2PtmPGPcv98hN95wrY1swVsOMTp2kzFb1WkBVctqHf/uGJ/vNmkVDWWKA
	 ViVvG0Up0BLtqPdsm44XaIVC+k+Dthuc6fOzxFihRMz8XCQsn3rqfGmcBDywBbM1vn3NA
	 vYik7xWIpKnsa6TUFTzcDY64Ct0SXHzmTjbwqBfDfcB0toQI/OqU0PHPg+DunD5XjXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=jZA2d5hO;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC323606A325;
	Fri, 20 Nov 2026 03:29:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC323606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=jZA2d5hO
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dzVUz78BxetOP2oXgJlZ21u694OXSAGbMXxRsvn1+cc=; b=jZA2d5hOJscMZXVYHnWV8ZIHJm
	Ip/lIe51miww/tFzirFf08yKiOlUdSunJ9SotHkjlYwwvHOuOlyxq7GWP5SFUIsvfBoMFPnCwgNh1
	f/7Gpr1unXRFFCi61wRuhr8dR/GD99XCydhxRVkle/lPa+XACwf2BldD+4tPKL/bxzP8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xUFJF-000Bv7-Ty; Fri, 20 Nov 2026 04:29:09 +0100
Date: Fri, 20 Nov 2026 04:29:09 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Prabhakar <prabhakar.csengg@gmail.com>
Cc: =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@linux.dev>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Ralph Siemsen <ralph.siemsen@linaro.org>,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net-next v5 09/24] net: dsa: rzn1-a5psw: Fix
 VLANTransmitted counter offset
Message-ID: <d4405a68-5df9-4e76-84ff-fa034f162429@lunn.ch>
References: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261120002549.1908299-10-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
In-Reply-To: <20261120002549.1908299-10-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 20, 2026 at 12:25:19AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The RZ/N1 hardware manual places the VLANTransmittedOK counter at
> offset 0x8f4, not 0x8ec. Correct the register offset so the driver
> reads the counter from the right location.
> 
> Fixes: c7243fd4a62f ("net: dsa: rzn1-a5psw: add statistics support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This again seems like a real fix, so should be for net.

Submitting these to net will also help with your patch count.

	   Andrew
