Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4E81DED42;
	Thu, 24 Sep 2026 02:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216210; cv=none; b=u02H38zwAEq8GLqJ35AhR/XVivHBt/0IsDNZtOI9bhGPTgDSnGw+jPBhuDo08u5W6DRs5M7kD7Xpl1m+XHihIq1VosQST5HNlmutW/cRdg2E7i+bqdY+WbX0zZeX/KrY0xizx2GY4rGjToe6O7AAuD2jHLxCsmBcxNIql9CNsl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216210; c=relaxed/simple;
	bh=y9Kr876gT/lioIZzU6foer8EmNNJZ8g3aNokdz4ZUTk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lMfhQQnGj97eDKSNlLO4xNIhz0nTNgyOfb2hbYVCqyC7JqLTIC/Suxh8zNGLSzq/pJUzhqEKE7ymrvYbXmM+qocMTCWD4JE4WvhUicsHpF5G3/RVrWmlZBZe/L9KG1YDqnR1hCMrdM7Vb4nMNOuZl1q7yLCdirPmy3g/XPj/jIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=pf8fNEh3; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="pf8fNEh3"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ZaJqOMZSOqS//5mzBs9scqkrTDWWVvmEptXG2hdHuS0=; b=pf8fNEh3Lx4Tpp0AgQ+2JK8wwC
	Y9AnEzQ74FH2Z3KRUmwoLBRP8CVKJvEboFOMwIpmYe6G7gFkz6Gpe4Jq2T1nR9XG/t8ioEQYGWJBM
	2gav3m3OYbBDvTPTemFlBJN5X0Rm7/1onJiYNeMvRkMW9gWFRUCK/tHZYks7JAanE0HI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9Z0s-006uZO-Sb; Thu, 24 Sep 2026 04:16:42 +0200
Date: Thu, 24 Sep 2026 04:16:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Message-ID: <78724445-4c69-44fb-b82a-1f9275e37e9e@lunn.ch>
References: <20260923162339.1375698-1-qwe.aldo@gmail.com>
 <arQ4dVkI9llhXCDx@lore-desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arQ4dVkI9llhXCDx@lore-desk>

> > @@ -5808,10 +5809,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
> >  
> >  		/* ACS is disabled; strip manually. */
> >  		if (likely(!(status & rx_not_ls))) {
> > -			if (buf2_len) {
> > +			if (buf2_len >= ETH_FCS_LEN) {
> 
> I do not think this approach is correct since, at least theoretically, the FCS can be
> splitted between buf1 and buf2.

We are talking about runt frames here, so less than 64 bytes in
size. Can such a frame be split over two buffers? What is the minimum
size of the first buffer?

	Andrew
