Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9BF4395AFE;
	Sun, 18 Oct 2026 15:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792338683; cv=none; b=qdJpHRny4AybyQtUnXVmIm+6p1Zp86NnbjetJ1kjsvGl0d8F2ogcYz21m9wnEteiJduRkPv9Qn4cn8BlxQfn/t5iUc146Q4Yjy0Wocr2pl5H40llsznrVHKa+GmPUDP6WAfNgRC9y3OIx1I6SbBcAdEkIG+AemJK9xIoP1ohppo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792338683; c=relaxed/simple;
	bh=PC2nwUIctw/opFVir6NYxMVSrSsNepCXzeuf4jelZlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YB3W+jzuSQEBLQa/yJIIP9RpBJu15rk2cm+ELe3nBUbV4VoLBRO8/9h1Cru6hLGKAwVyY8ZwIISp6aDgwkr83czRlAwh3L/e1NYbRu8Ywi9JNe0CPpCKnJXbxu9XWIONujw4XiZM1m0l7+YPCKXDDlkT16MMj/LPIApyHyHCEBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JmSJjNfQ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JmSJjNfQ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=/GXMNXvu9Ucx8ydkf56R+nlJN3aAcHuHVa89lye6maQ=; b=Jm
	SJjNfQqNodHlr4SfFLNQ8bLBjhHmMOrV6SK9ZZJLq771tU4uqAbV7KI3Xc6l1glVGiyfSFKTyh34q
	nHUrIl6xVQkOdvowc+LsYFMzXu2crkXlkoK4Z/J00+oP/Jz/FxGGcLS3njy6FDD653ozfzD7c2ZqY
	kJRyEanfmesSRdw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xITA8-00BVLw-OY; Sun, 18 Oct 2026 17:51:04 +0200
Date: Sun, 18 Oct 2026 17:51:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Josef Schlehofer <pepe.schlehofer@gmail.com>
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc: dts: turris1x.dts: Describe switch PHYs on the
 MDIO bus
Message-ID: <cb96159f-c510-49ab-bc1d-20149222781a@lunn.ch>
References: <20261018015311.4822-1-pepe.schlehofer@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261018015311.4822-1-pepe.schlehofer@gmail.com>

On Sun, Oct 18, 2026 at 03:53:11AM +0200, Josef Schlehofer wrote:
> The QCA8337's integrated PHYs are visible on the same MDIO bus as the
> KSZ9031, at addresses 0–4. Since they are not described in the device
> tree, qca8k accesses them through the switch's MDIO master.
> 
> Describe the PHYs and reference them from the switch ports so phylib
> accesses them directly through the MDIO bus. This fixes intermittent
> WAN link recovery failures on Turris 1.x.
> 
> Tested on Turris 1.1: 40 WAN link down/up cycles across 3 boots and
> 10 LAN link down/up cycles passed.
> 
> Fixes: 54c15ec3b738 ("powerpc: dts: Add DTS file for CZ.NIC Turris 1.x routers")
> Cc: stable@vger.kernel.org
> Signed-off-by: Josef Schlehofer <pepe.schlehofer@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
