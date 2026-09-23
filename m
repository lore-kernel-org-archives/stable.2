Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD2138DC51;
	Wed, 23 Sep 2026 21:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790197241; cv=none; b=JXX66jUAbHT1pjtSHIxBUOp0kMa18XSbERH8Uib6rIZKaeGNIga5YPoTy82pqAQLs5kt9exRcE4Qx50J54zU2OM1/ca0SEO05XuFDV7LzkStiCX1jvLWeGDhH6Fa/tKMSi37OXiEMzn89bixrLOg9FmHb3xJSFlWssm/vKFRoWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790197241; c=relaxed/simple;
	bh=S+SNCZcy44CB/39ivTUasJwQYKdkPpF8LDx9nTgiq9A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gET6ENg9DnR4BEcviRrMrIAQLgMIfg6b99pHzYYxD+uQjBrBEbGoFfbcrX876oO184mznFKcdpFLLSHvDOFcpSelQJT9wVKp2BfUXDpVusmLSByrtnaOm/4ooux7ohlffmdzKaGlx9zuol3UuyfS59JK3lyoAZkUQAxoM775Spc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TLjRQtL4; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TLjRQtL4"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=2G/ro5nrQZ9Hoeba7QO7BP5eHd1XYA/VI+vWQytblG4=; b=TLjRQtL4bmzUBTNwv/Wi6JZERR
	FSLDRlHTLFNzzwWAyuTR47AmFE2s9N3MNHvYWZde+eTDZmd3m5oimNias9xdoxKtoFcXCWjqkH+V5
	Mp9A9VhmTnEY5WKJerzGVHKWPVR+4YuUeEeJiFnN5kjd3jEe6N1/zI00NNk+CEEZdGZA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9U4y-006sJr-Bg; Wed, 23 Sep 2026 23:00:36 +0200
Date: Wed, 23 Sep 2026 23:00:36 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Cc: wei.fang@nxp.com, frank.li@nxp.com, shenwei.wang@nxp.com,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net v2] net: fec: reject oversized fragments before
 bounce-buffer memcpy
Message-ID: <f3c05fe4-b90a-484b-8b3f-0cf0b101a20a@lunn.ch>
References: <20260923203738.1583735-1-qwe.aldo@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923203738.1583735-1-qwe.aldo@gmail.com>

On Wed, Sep 23, 2026 at 05:37:38PM -0300, Aldo Ariel Panzardo wrote:
> fec_enet_txq_submit_frag_skb() and fec_enet_txq_submit_skb() copy
> transmit data into a per-ring bounce buffer when the source address is
> misaligned or the FEC_QUIRK_SWAP_FRAME quirk is active.

ndev->max_mtu = fep->max_buf_size - VLAN_ETH_HLEN - ETH_FCS_LEN;

What value is this? Is it greater than, or smaller than FEC_ENET_TX_FRSIZE?

	Andrew
