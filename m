Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415707;
	b=ESdhTqrM5BV5iQQNh1Lex2FyCUP3kDMEW3BWiw9T7DotYpj7u+GKRlvMW5j+KiG/SEJq
	 llOboz9IDBrQ4bEy1pLIzKOhAfz4hTDaGu50yumSmmh6lE85oWk66dGQ9Ai1zMiqONRV5
	 2NcHArOOvxmwfBrpmEkyvsLZLtO+NrhnXH+cNqHXJcCfSIDQdENFiy/Ig6gp+5KFnA3Gz
	 wvX6w+okDasJQNO5iAnOtoKwno8WZdEtQ0jHd7hyYNSMRZc2Kkx2dLQjWqEiz5Bvlwdpw
	 QiI3U8qTTXsR/xBYj2FvaE2M25pjWWnp0tZEpcoeT1luruawVs+RbYwumj1TEMtSjxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415707;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=0sydFHNzITW/W9RiZ5lrBlSfj6odwN80cmBBE2TsUzo=;
	b=DMaG1oScvXebnHPukm3lvGfM4nM44VS9QpWXkxdrstvizyiKZ2N/x7Ip90uPIfEnSdSC
	 9cwlST1SB9qtbQsnbSqt6YHqDe4gg4xzvsq5laAucKFmYcbMxfMfsthCq/7H3x8SwNNcI
	 JfljXvDjql5JQrZlGVOSSkC+hDhBzC8ZuFQ7lQJ4f6id9aV/LSw+RQN67runW5sWKNfUm
	 ENdd8KW0da9IA6CPivQK5bmZiUfeM50WRuCuzoccVWX/p38UP/Bys5Obshne411YVJjHs
	 zEz+H8/RHTJuz0ly4AeN72zGTpE5v4GLiu4VpqPaTHG7J+RuXsrwS4PIRi9LQEA+/Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dyHdbNbZ;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB49606A321;
	Wed, 11 Nov 2026 16:48:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CB49606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=dyHdbNbZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0sydFHNzITW/W9RiZ5lrBlSfj6odwN80cmBBE2TsUzo=; b=dyHdbNbZ8KfDHmZzWygnexSWkp
	vxdIR0q/Nyu3ONUYl8xOsXtkPy0E+7DA1dun3kA+Wv/u0AoStyC68/1gZnroCLRnlH2EG5MclmXD8
	X1C0Iq7Nl/vCyDH80En9gEWCh5IkC3bc3Gov4Bdc87NZr9EyilnA4v2p1UqKM2NIGkRo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRBUg-00FnDz-HB; Wed, 11 Nov 2026 17:48:18 +0100
Date: Wed, 11 Nov 2026 17:48:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: joasantonio108@gmail.com
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2] net: usb: smsc75xx: reject frames without a full
 header and FCS
Message-ID: <e4a20579-2576-4c2e-9120-b675a175a1da@lunn.ch>
References: <20261111-smsc75xx-rx-fcs-v2-1-216a5f26842a@gmail.com>
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
In-Reply-To: <20261111-smsc75xx-rx-fcs-v2-1-216a5f26842a@gmail.com>

> +			if (unlikely(size < ETH_HLEN + ETH_FCS_LEN)) {
> +				netif_dbg(dev, rx_err, dev->net,
> +					  "size err rx_cmd_a=0x%08x\n",
> +					  rx_cmd_a);
> +				return 0;
> +			}

This looks good as far as it goes.

However:

static inline int rx_process(struct usbnet *dev, struct sk_buff *skb)
{
	if (dev->driver_info->rx_fixup &&
	    !dev->driver_info->rx_fixup(dev, skb)) {
		/* With RX_ASSEMBLE, rx_fixup() must update counters */
		if (!(dev->driver_info->flags & FLAG_RX_ASSEMBLE))
			dev->net->stats.rx_errors++;

What is the value of FLAG_RX_ASSEMBLE in flags?

		return -EPROTO;
	}
	// else network stack removes extra byte if we forced a short packet

	/* all data was already cloned from skb inside the driver */
	if (dev->driver_info->flags & FLAG_MULTI_PACKET)
		return -EALREADY;

	if (skb->len < ETH_HLEN) {
		dev->net->stats.rx_errors++;
		dev->net->stats.rx_length_errors++;

Should rx_length_errors also be incremented?

       Andrew
