Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9051332601;
	Fri, 14 Aug 2026 13:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786715334; cv=none; b=cwjMkP/YtD0Bq8c58xp4cOu912B+r9yxa18tt4D29LpjgxVxNj+En+3Z5tsVpNIoUpPqF3Ogal7682Jwif5vXXzESfd4R+Xdfx6PPsfw8cTxYqESgaDljbakCU3FcZcraCYJHt7AypTEh34/JT9U+yy/Suxg9dh0pT2fv1mAzpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786715334; c=relaxed/simple;
	bh=EB6xROhyJj/FfLNe64UboqZq0j3u5X6XO8B0djz4u7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=any/grj6+Ie3bCNbO2T3bEFqDCShoBLkreBR0yiSpix1sZ5xlnBTqx5KU3oiw5ppwd8yOqjXbSlTk1L0+t/q9OXY/zah/OxfBnNNxP07lrKCxALz7WA75kxtNopUHUhzNYuMg9g4P/yT9d8uS0vbOxyQ/I7XTyQvrGzAlQKF8Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DL3iqewU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="DL3iqewU"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Mxili9H6FVTnhD2t0VTsYB1Og4LHwN2BHmYMCsPc7Mo=; b=DL3iqewUn6E4PY9edwU7AzAjPx
	xoN/ifFVu8NPGqKvlIW6upAnREcEdpCHV/NjSSuK79XHMZpdLPzBA3SQ1iH/YQfG3b1ECgXHmgPAX
	1MtpTwAHS4jiXWKuBUV27/zVvlyd/yse8qOSjZO4EnAgTGDSxZTyHreW449glmIPV7Qs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wusHB-00HadD-NL; Fri, 14 Aug 2026 15:48:49 +0200
Date: Fri, 14 Aug 2026 15:48:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: diegomancera.dev@gmail.com
Cc: maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: restore XDP configuration when reopen fails
Message-ID: <79d224af-17c7-4853-98f1-4b93921f7fe2@lunn.ch>
References: <CALruWrVTmdRYoCQ9kh7n2KJ_HjGKhMkhX5_ybMYwCgeCJiTnKQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALruWrVTmdRYoCQ9kh7n2KJ_HjGKhMkhX5_ybMYwCgeCJiTnKQ@mail.gmail.com>

On Thu, Aug 13, 2026 at 10:22:10PM -0700, diegomancera.dev@gmail.com wrote:
> Exit code: 0
> Wall time: 0.3 seconds
> Output:
> >From 7691567e29d241f28d1525d99b11faa2d5831f3f Mon Sep 17 00:00:00 2001
> From: Diego Fernando Mancera Gomez <diegomancera.dev@gmail.com>
> Date: Thu, 13 Aug 2026 23:03:56 -0600
> Subject: [PATCH] net: stmmac: restore XDP configuration when reopen fails

None of this belongs in the patch. However you generated the patch is
wrong. Maybe take a look at b4

https://b4.docs.kernel.org/en/latest/contributor/prep.html

> stmmac_xdp_set_prog() tears down the datapath of a running interface,
> replaces priv->xdp_prog and then ignores the return value of
> stmmac_xdp_open().

Is this something you have seen? Why does stmmac_xdp_open() fail? Out
of memory? Is it even possible to recover?

	Andrew
