Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794350500;
	b=lVd8UPX4LHdnFzCWsZntFU3lIUPfE24Y8curULulwtcbxKa5dFicdbo3YM9d3gGG47V3
	 7pUB8vnaEl3zlfOPekQ+Wfx/2M8Xr/6SJp0W/2J6RQz1op5uYz72r/WZmsDF4Y7vho8mL
	 kHcOCUNkHX6XAz74nf336bE3FzCb9d8TfU+e2mNXJkygVYaK+5fShj+zzNJFrxAP3Oglk
	 gAU4V12IOjIupl/4IiQDyG09TMdqS/8FXNGNyhTAVqmzYwuPRLsG9w0K7O2JKWjGq7xoe
	 BbumZN8INMwa5zXH1ERn3ZaXyXePUwMQGR9UGzFUsd6lKGoFBOsJmm2ciWexJFRMfAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794350500;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=NijWXXvdHVUP6AQHOboqPYVhaLdHKiYRLTT2DOKoP9M=;
	b=xbBO5hsESSK6O4dsHPEiVkYSioA+jn11aL6nfS9NXCOnH234v6YPWl2CotPPC6Cxe1iC
	 Y73wP53BTnXTUSqQne7XMuyp9R8W6NfdXs82UB/lm/QIS2X6EUclAcn6e/isBE7IApXi9
	 +meNxhwqzoiDyWrAK5Kly6PfO45p5A0pUSGrEacNBvVpqCQqUQx3vyYY6thnb+aZcPBng
	 UgX3ymQSf/S6SgBcSO8/nJPUxOeICxULVWaUIbggjew5GPbNPjkgLIPFR6+AC9rRr+cN+
	 2dHKQdeCh/QQnGwJmmhPJjeXGFUyKklaMszsWiibx0yG6rrieauCf12crwazfEnv/4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=T6x9htG2;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA6B0606A31C;
	Tue, 10 Nov 2026 22:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA6B0606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=T6x9htG2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NijWXXvdHVUP6AQHOboqPYVhaLdHKiYRLTT2DOKoP9M=; b=T6x9htG2JWq3vI26F++miy+joo
	D3sjp0DeI/7GWaX+8eA5RzAUSTl9nuN9EX5FjvzvVdp6p/vup/wUoyEvOMelo/eq2zmyZosuGxKbA
	X25FIvBqu9Zf4okRNNa8GqlCugPh/kTzkgRCz6Kq/xpH9XkQnEdbZVdJ3NLTRYaYjtwg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xQuWx-00Fb2E-5f; Tue, 10 Nov 2026 23:41:31 +0100
Date: Tue, 10 Nov 2026 23:41:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: joasantonio108@gmail.com
Cc: steve.glendinning@shawell.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: usb: smsc75xx: reject frames shorter than the
 FCS
Message-ID: <137b3cc5-7077-45d9-8ba3-ea4c584f1992@lunn.ch>
References: <20261110-smsc75xx-rx-fcs-v1-1-4e048bfc28f3@gmail.com>
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
In-Reply-To: <20261110-smsc75xx-rx-fcs-v1-1-4e048bfc28f3@gmail.com>

On Tue, Nov 10, 2026 at 09:03:21AM +0000, Joas Antonio dos Santos via B4 Relay wrote:
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
> Reject frames that are too short to hold an FCS, as lan78xx_rx() does.

I assume there is soon going to be another check to ensure the frame
is big enough to have an ethernet header? Can these checks be
combined?

	Andrew
