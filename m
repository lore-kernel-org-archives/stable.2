Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793192128;
	b=ptaqzNwOaEs0j7GdriUjQ4pBvfjJmZaegWLO25oTukyTIi5yYXI1ttxk2MA60wSrzhZY
	 AltiywNRaRIdz+gxtMKs+OhuB9GdGoweaX14eAQx0FsdC3F3VUT6F0+ty49VxSCmoWL8v
	 P7pXN5luATwftIi56f4/rbva45ufXQuqsw2RGzoIZLAeUOUgHw7Akig92VQpaW69Lq9C9
	 mInMugd8CKV4iea8H96Xzh81M3OyRdKhBJo3d6f7rTi5lQms9ek9jGrwygHp16iVJ41cu
	 gZoxrM71qySYaAlVy+DQU4MHSJPPGnNaqKL+umVw767AILRyzJUkL0t1KYws62aGdkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793192128;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=eHbyHWX9D1X04aCutvqNA7jCNBocSSad23gFzUF9G78=;
	b=swf4m80rulKAqW+FYv8nIM4uqDi2lK756DU6yy8Z1Li9U2vKE5tcfPUhAsTTwlhPhwrz
	 3244fz+hrF1y9iYk9qTuc16SW1RwczBK42SJGvibXJVzqqSBUcazRw7X2v2P5diFTUvHf
	 qqD6UF44XK4OmJ5PV+gVjHJUimZ1WmZqDxWK29dOSEN5abAZO+FdTeDKQOddcLC7hVGIC
	 TMQd88y/F/Ll4fAFDGMsbAiJCWWUdYvCb2gjqUFJuo1Eqlb5428CbvSxfowq2036VcqWt
	 cZzK5vnkS94unzOL1hGX9zSOA35Gf0NRpwrLY/nK2fL+283DoPVWOONfnhFC0SquU5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=1P4d3T0I;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2681F606A321;
	Wed, 28 Oct 2026 12:55:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2681F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=1P4d3T0I
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eHbyHWX9D1X04aCutvqNA7jCNBocSSad23gFzUF9G78=; b=1P4d3T0ItLxrz6r8x8NMydpK8m
	nblADvsdNlMH7N4PheILsjtpV5XKgTuoigntzY5n8B62m0PHeKLVPCM5127CyvsYbpFhxffl1WI+W
	0sFVOgyFSRjdCc3IG3KOpR6fO7n7xMzJRV24deYEoN4D8NPiIMz5idQyTfEeGBKpuOp0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xM3BH-00D6r4-S8; Wed, 28 Oct 2026 13:55:03 +0100
Date: Wed, 28 Oct 2026 13:55:03 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jiale Yao <yaojiale02@163.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Christophe Leroy <chleroy@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: phy: only remove owned topology entries
Message-ID: <76063c7a-26f2-4867-8d76-ca489f55a29f@lunn.ch>
References: <20261028050312.126508-1-yaojiale02@163.com>
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
In-Reply-To: <20261028050312.126508-1-yaojiale02@163.com>

On Wed, Oct 28, 2026 at 01:03:12PM +0800, Jiale Yao wrote:
> phy_link_topo_add_phy() can fail to insert a PHY when its saved index is
> already occupied.

How did you get into this state? It indicates there is another bug
somewhere which needs fixing. Fixing that bug is much more important.

	  Andrew
