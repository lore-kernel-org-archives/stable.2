Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B72377EC7;
	Thu, 24 Sep 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253656; cv=none; b=SoPq7AUuGwiP0+JWBjL9tXv5WSJt0yYy54Y8kX0pXT7C4mPdKm42uzH7y08TIXUcf0FrPaIKmA/+ldKLLNcNTho51N00/YDLHRmPkDxp7Pco2+cA+4UnbHlX5IJpFmEYJ669xm61SZynmomqpOp3xZKuMJT9TF89awvlG23VKvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253656; c=relaxed/simple;
	bh=ZcNh+l6SeSrEevzUyaiIbHJKDijrGi3F9DOB0SBLJpQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ptMOMmF6xAJ2N1jcI4IEOdL38V6cw/pDgLCrIFCg5/XCKJkJ9AQ55G1o0FHvB0qIEB4DEmyXO04RtY2PYztlf11kc2cxzL9eKf/dyrU/QMfziIOmdektC1Zn1hmOqqN9N0EtMOMynLUOuhmUnYRtSJMIGnYfUmJilRZx9y0rf98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=eEpIPmlD; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="eEpIPmlD"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LlhL8lPQK+mGmThvRzcBFWd03/EYCS0ROgcvO+lg6ns=; b=eEpIPmlDWOZam71wIcPWwH/Ioz
	eo5DxMECgO/mlGeLs861lSC0kURUaOMryIZVvkatNfERA1W5avV/zuuPs4N1UW7n9eXUEsiJ/lhTN
	yHa8qqjgAawkok0KNH0/I2quTGeu2QdlYVO8+6ZpDh3Poqa49od5rLEnxgCcHVjF1s4M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9iks-006zVy-Nh; Thu, 24 Sep 2026 14:40:50 +0200
Date: Thu, 24 Sep 2026 14:40:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aldo Ariel <qwe.aldo@gmail.com>
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v2] net: fec: reject oversized fragments before
 bounce-buffer memcpy
Message-ID: <a230cd62-db31-4128-acfa-93501d30aa39@lunn.ch>
References: <20260923203738.1583735-1-qwe.aldo@gmail.com>
 <f3c05fe4-b90a-484b-8b3f-0cf0b101a20a@lunn.ch>
 <CAP48Hfto4qc285B3Jw7ZRuC-wGf57JOBPZOdrrAt-aDfGcas8Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP48Hfto4qc285B3Jw7ZRuC-wGf57JOBPZOdrrAt-aDfGcas8Q@mail.gmail.com>

On Wed, Sep 23, 2026 at 06:22:01PM -0300, Aldo Ariel wrote:
> Hi Andrew,
> 
> PKT_MAXBUF_SIZE = round_down(2048 - 64, 64) = 1984
> max_mtu (non-jumbo) = 1984 - VLAN_ETH_HLEN - ETH_FCS_LEN = 1962
> 
> So for standard MTU, max_mtu < FEC_ENET_TX_FRSIZE and individual
> fragments should not exceed the bounce buffer.
> 
> However, when the device supports jumbo frames,
> max_buf_size = MAX_JUMBO_BUF_SIZE (~16256) and max_mtu reaches ~16234.
> Scatter-gather fragments in that case can exceed FEC_ENET_TX_FRSIZE
> while still needing the bounce path for alignment or byte-swap.
> 
> Should I respin with a check only for the jumbo path, or is the
> unconditional guard acceptable?

Can bounce buffers and jumbo be used at the same time?

How is the scatter-gather size determined? Maybe the better fix is to
set the fragment size based on the size of the bounce buffer when it
is in use?

	Andrew
