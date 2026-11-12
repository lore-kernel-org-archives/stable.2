Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794501780;
	b=3eURPYLO7TglfgNmVkTbQCnKjXIRkNBgf5ocjE1AbziTvU6OdMOpVKc0AqR2AlkSM8Nu
	 bRV1GGjYfVsvmvkU2JAW87TSRiSNO/oWtWoWBy+F5FQzqTQoWIcuofKuTtMeuq6w7AzG/
	 9idlDFnrqj8oWFCEAF/ikaY7lkRVr5B3jB+4lBhOTx3E6/kam2gEntM/pdz73w/B9YMGM
	 CjIE++pPKUOSDVA0T01rOb87tdXklV8rRg599BlTq8cMy8FMe+FmPapYcd9lsYpMx23U4
	 nZQQOItYeRk7WprompwjpJZd/etCbanHy3FFBD/TsAQI2umMQga0rBVRLIDgKs7zpFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794501780;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=Qi0GHDoo0d+sgVHHbsbvf3TVWeYwlShut9QGcVyVR/c=;
	b=p1EgziHgMDwFrPOkBdS0CacO0VkaS3S84TJYN95F3xjj01181i57hUclMPEXoljXo7sS
	 eI5APW8SyRiGGwHTEV3XrT72mEFYvjtn12UOvVMLo7BDHOo9ivOXzVOiUixiL2ObXeiwD
	 JFOzJ+z+hQpbhC7wuhNkw36nHFIKRHJWJv9Etl588zHqhXf93Db1AK/pFJBHZVgVY7UUO
	 8zd9pRRJ2xbWrnVQ4cx92NdVhH7+D01sG3iwIN0ZlLSaVkWS+efVcsOqil9KnEbS0mGCP
	 cm2ntNxraOpNkWjtsh82iHASw4mFu1aHMsn+7xjx7y4WcltO3KOwGlsRpI41XyUodpQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=4CVmn4gH;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8769F606A327;
	Thu, 12 Nov 2026 16:43:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8769F606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=4CVmn4gH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Qi0GHDoo0d+sgVHHbsbvf3TVWeYwlShut9QGcVyVR/c=; b=4CVmn4gHc58+kdPEr6KQHyRLM6
	7CsjW9eILTwcKAO6a/Wno1mZdbmfykAM8wAaz6f1tnw1xBbC1WDEin9GwhVlxqMHleHb6BUhOi+tW
	UPQhyVz+dYfjCPdB0ag3KhcQgObIDXrLW/sP6CnHViWSgmBLTEdGhgGdipySpTnot6mc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRXsw-00G4X8-PW; Thu, 12 Nov 2026 17:42:50 +0100
Date: Thu, 12 Nov 2026 17:42:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: joasantonio108@gmail.com
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	mim@microchip.com, Eric Dumazet <edumazet@kernel.org>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: usb: smsc75xx: reject frames without a full
 header and FCS
Message-ID: <cec36b10-1344-4ad1-9440-a6af8f5f6b00@lunn.ch>
References: <20261112-smsc75xx-rx-fcs-v3-1-6ad0378d0384@gmail.com>
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
In-Reply-To: <20261112-smsc75xx-rx-fcs-v3-1-6ad0378d0384@gmail.com>

On Thu, Nov 12, 2026 at 04:23:27PM +0000, Joas Antonio dos Santos via B4 Relay wrote:
> From: Joas Antonio dos Santos <joasantonio108@gmail.com>
> 
> smsc75xx_rx_fixup() takes the frame length from the RX command word
> supplied by the device and strips the FCS by using "size - 4" for the
> allocation, skb_put() and memcpy() of each frame that is not the last
> one in the URB.  The length is only checked against an upper bound and
> against skb->len, so a device can report a length field of 2..5, which
> gives a size of 0..3 after RXW_PADDING is subtracted.
> 
> size is a u32, so "size - 4" then wraps to 0xfffffffc..0xffffffff.
> __netdev_alloc_skb() adds NET_SKB_PAD to the unsigned length, which
> wraps back to a small value and the allocation succeeds.  skb_put()
> adds the length to the 32-bit skb->tail and skb->len, which also wrap,
> so the skb_over_panic() check does not fire.  The following memcpy()
> then tries to copy almost 4 GiB from the URB buffer into that small
> allocation and writes far beyond it.
> 
> A malicious or malfunctioning USB device can use this to corrupt
> kernel memory or crash the machine.
> 
> A frame that holds an FCS but less than an Ethernet header is not
> valid either.  usbnet drops it when it is the last frame in the URB,
> but the other frames go straight to usbnet_skb_return(), where
> eth_type_trans() reads an Ethernet header that was never copied into
> the new skb.
> 
> Reject frames that are too short to hold an Ethernet header and an
> FCS, which covers both cases with one check.
> 
> The driver does not set FLAG_RX_ASSEMBLE, so usbnet already counts
> rx_errors when smsc75xx_rx_fixup() returns 0.  Also count
> rx_length_errors for these frames, as usbnet does for the short frames
> it drops itself.
> 
> Found by LLM-assisted source review.
> 
> Fixes: 1b3b2d9e772b ("net: usb: smsc75xx: stop lying about skb->truesize")
> Cc: stable@vger.kernel.org
> Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
