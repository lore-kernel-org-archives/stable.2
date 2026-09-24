Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE86D311946;
	Thu, 24 Sep 2026 12:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254274; cv=none; b=A+sJRNxDqL0H9XGLXwiZuTV71BDD0c0KW/kYAn12EegSPcppoQrF6M/P3R9B6/ihD2oHlyT/THgF4xv1oODVwoYKYumAmeBBaA9gNGFt1Y7OMdF1y4k0+3zv/v3R+/1if+qU62DXzqaW3W0aBD5upoNLTwlYOmdmG4NGbdABtZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254274; c=relaxed/simple;
	bh=0NoCcowoVuCQyLtJFecCntna/RvD8szpkF05RojNLwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g/72S0jMFVC2EPJyNhjI9qJvM6VF8aWsiNXhuZdjlswvYxl4QMezMM/yEZ2cBfYG/fKePupdr4Irm7rFMaj9QJP0Fcfm6XXPdXOMOJMhGjHarQck+zEVcA6J0M6qWhkoTGLflQiywSOnvrCYIGnW1IyDWkL1w81812RKTQt9tCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ib+gPErF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ib+gPErF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5PtMn6ukGg6gAsqu/cBjeIKvLMgTB7HQzRle6zjWATg=; b=ib+gPErFxsicRDZfSVfRrDJlO4
	IkT3EdKg1TZSG65DPsXiMOKLswHDzpB1ribsEEgjOBBv8QYVaaUaELPrHmDfdtbwhy1ivOAOlS+D1
	NvzQTGVjr7t0IL2dWZujkGGuJnj3BLReG2vj2PjacAR7UF93rO36MRvPSZScozxC0dzY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9iul-006zbx-9w; Thu, 24 Sep 2026 14:51:03 +0200
Date: Thu, 24 Sep 2026 14:51:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>
Cc: Aldo Ariel Panzardo <qwe.aldo@gmail.com>, maxime.chevallier@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Message-ID: <8b3d8225-0d86-4e73-86c8-b7f644faef56@lunn.ch>
References: <20260923162339.1375698-1-qwe.aldo@gmail.com>
 <arQ4dVkI9llhXCDx@lore-desk>
 <78724445-4c69-44fb-b82a-1f9275e37e9e@lunn.ch>
 <arTX2kNFGXLg7vdn@lore-desk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <arTX2kNFGXLg7vdn@lore-desk>

On Thu, Sep 24, 2026 at 09:57:14AM +0200, Lorenzo Bianconi wrote:
> > > > @@ -5808,10 +5809,10 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
> > > >  
> > > >  		/* ACS is disabled; strip manually. */
> > > >  		if (likely(!(status & rx_not_ls))) {
> > > > -			if (buf2_len) {
> > > > +			if (buf2_len >= ETH_FCS_LEN) {
> > > 
> > > I do not think this approach is correct since, at least theoretically, the FCS can be
> > > splitted between buf1 and buf2.
> > 
> > We are talking about runt frames here, so less than 64 bytes in
> > size. Can such a frame be split over two buffers? What is the minimum
> > size of the first buffer?
> 
> Why are talking just about runt frames?  According to my understanding,
> this codebase (at least the one in stmmac_rx()) is executed on all
> 'last fragments'. Am I missing something?

That the patch subject is wrong?

[PATCH] net: stmmac: guard FCS stripping against runt frames

I suspect this is an AI generated bug report, a minimal fix has been
proposed, but no actual thought applied to the situation, such as does
the hardware even allow it to happen, does it apply to more complex
situations, such as fragmentation etc. The usual AI problems....

	Andrew
