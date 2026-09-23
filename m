Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1437DEBF;
	Wed, 23 Sep 2026 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790196835; cv=none; b=PJL8ppGy/0pTs2r5WLJwpmV0vUc4bJeR2Gl8vsKZT7pH5n7TDg+geurl6hSRjsnZfpzRckNH1NMX7o37y49ZrbjtzNMAscfDbAZPSKxgj6vD6ZK2+1OpcqT6A8Irt46oopFtXIl5xEcwZeLTRmBbxEWw9CUPGs5W6nIRIo2yUhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790196835; c=relaxed/simple;
	bh=OSl9JnLClbDp1DMXBH9DEyy7hb7yn2V4q9dQerSym54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRyBc/3N8YkOCON/StAcT5PAx0lB4g4Ijovnq//BMt6zVs3c0knUu/WR2EATvYxbGlFOaSSebciWzRTnQb/5JOxH35VL9c6OaK9eEvLk6wzmP5TlO6to+1sBGTQ7u7gPoyp4Pl5whRk6ho+s4mnQf1oD0ZgGz4JmqsyXXcapyr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=aiL8W9St; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="aiL8W9St"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5Bm/+0EcngfKdWcwDY8qFA8uhs2WaYFdYwsqhTp+Yn8=; b=aiL8W9StXpw1/JGwyp+ROWxuGj
	QHXJkCcsa6bml8CqCI//HrKmSOu6o7lOg2HYHi52nNJ1Bj3foBebCrmcaMXvO7EqeffA3Wk829q4g
	90Wt4ui0qOXFjgT3P1I7FKZQOJ/XNq8kRRKTS1tGTFOgk7q3rtB5hw8VElHqKb+m0oiU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9TyQ-006sHl-9P; Wed, 23 Sep 2026 22:53:50 +0200
Date: Wed, 23 Sep 2026 22:53:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Message-ID: <54796d52-7656-43f6-9ca9-7bdd10db0a76@lunn.ch>
References: <e0515b50-8a7a-4c4d-91da-9b62c2f663bc@lunn.ch>
 <20260923193354.1537557-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923193354.1537557-1-qwe.aldo@gmail.com>

On Wed, Sep 23, 2026 at 04:33:54PM -0300, Aldo Ariel Panzardo wrote:
> Hi Andrew,
> 
> You're right that the relevant question is not merely whether the MAC can
> forward frames shorter than 64 bytes, but whether a descriptor with a
> reported length smaller than ETH_FCS_LEN can reach this path.
> 
> I found a closer NXP/Freescale reference: the i.MX RT1170 ENET_QOS
> documentation (IMXRT1170RM, Chapter 61), which describes the Synopsys
> DWC EQoS receive descriptors used by this driver:
> 
>   https://www.nxp.com/webapp/Download?colCode=IMXRT1170RM
> 
> The MTL receive configuration explicitly supports forwarding error packets
> and undersized good packets (FEP/FUP), and RDES3.PL is documented as
> the number of bytes transferred to system memory, including CRC. I don't
> see a documented lower bound on PL.

Will, a frame which is smaller than the FCS cannot pass the FCS
check. So you don't need to worry about undersized good packets
hitting this condition.

Given that an ethernet header is 14 octets the FCS is 4 octets, any
frame smaller than 18 octets should be dropped by the network
stack. So why not do one test at the beginning for ETH_HLEN +
ETH_FCS_LEN?

	Andrew

