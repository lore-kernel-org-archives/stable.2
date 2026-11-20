Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795145296;
	b=IchE3pHW3cdJSC4PaHEYztaya34IEoVWTXa+denw7B34dWgBP86o4jwZlZpCdvJFzDLq
	 +NeLvFDzll/IbGkpYUaGxwvtcRG58lgCDoaAnLpqM78xpiL/aMMQJQzAP86G7yuWjsO9t
	 i12rF0uFT3edlvtuo4BbZ4Jo6rENaeO+jO+G165jdrTGy8jTtp95wagr2BgJu7np5Qpmc
	 eI5H8/Q2gYZVBUmfVjWIAj8TbkFPVzOXqj8j1V1FMuVejnXHrmuMjeY0dQZSVyVAARwjt
	 n+PxErSK8E5WhSr9euHrPuU3CFUvRtmNyqOAYBBBCJshozX229jv7edY9A77SAkOQoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795145296;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=iCuHVTWJGQQZffL51FdvyrvlRrU2up2oO7trDXmVHTk=;
	b=5arEZh3ThgswEsfdwq1UQTEP8sMYD7yy0teCRbXZITdD7i0IS9umpizgNlPUsYXsi25w
	 c8hHKYjvTOoCcJubEiKoxP6ddGYk/G72i1EyZtJOs00Xz0ZBJZgK9BOyxxUS4VgMfcBHx
	 /g/vXnOnchIUy1Veip5PBuNTenxQqtE0zT21OU3izUK/L3Vw1yzek/xiFfNzuBlvQqZpN
	 fel9SFfvR9sPv14GO8rt5R0RTVz3d6B7gMffKdMJm3Gxv7yzm09bTS4MxYkirfYBiMbeh
	 riaFVnQt7hf+IJenh73OK1ECIHtDVLS26HcTCYykudYlEkgC7boiHO+bRi67A0P8Sag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=A6qX0olY;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E885606A337;
	Fri, 20 Nov 2026 03:28:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5E885606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=A6qX0olY
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iCuHVTWJGQQZffL51FdvyrvlRrU2up2oO7trDXmVHTk=; b=A6qX0olY28It2xWB0eBNmhl1tV
	JdoJ/4+kqS6ILl4lTdOTxTVFkCKJJ0s2QJlfVCA0sQS8RJYgoWNup0PIBzIc06kn12XU+abSq7aUW
	RuaLkWW3KdBXtZXVAyUQw5Ptrs30GIocop2rkDbKQ4Z9Rm3hZ+F9JdUUMoLhNKnnL/C4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xUFI1-000Bs9-LS; Fri, 20 Nov 2026 04:27:53 +0100
Date: Fri, 20 Nov 2026 04:27:53 +0100
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
Subject: Re: [PATCH net-next v5 08/24] net: dsa: rzn1-a5psw: Fix
 LK_LEARNCOUNT write mode encoding
Message-ID: <8b1a4bb5-b53a-4d6e-ab4e-c644e453ce87@lunn.ch>
References: <20261120002549.1908299-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20261120002549.1908299-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
In-Reply-To: <20261120002549.1908299-9-prabhakar.mahadev-lad.rj@bp.renesas.com>

On Fri, Nov 20, 2026 at 12:25:18AM +0000, Prabhakar wrote:
> From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> 
> The LK_LEARNCOUNT write mode lives in bits [31:30] of the register, but
> the driver writes the raw A5PSW_LK_LEARNCOUNT_MODE_* values (0, 1, 2)
> directly. As a result, adding an FDB entry writes "set LEARNCOUNT to 1"
> and deleting one writes "set LEARNCOUNT to 2", instead of atomically
> incrementing/decrementing the counter.
> 
> Use FIELD_PREP() with A5PSW_LK_LEARNCOUNT_MODE so the mode lands in the
> correct bit field.
> 
> Fixes: 5edf246c6869 ("net: dsa: rzn1-a5psw: add FDB support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

This sounds like a real problem that should be fixed? So please submit
it to net, not net-next.

   Andrew
