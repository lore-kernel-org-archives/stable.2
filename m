Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7793717BCA;
	Mon,  6 Jul 2026 13:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783344673; cv=none; b=KOP5bk28Qq+6/GvUdFFLqp8nS2bV3PJ3Qb518Vwv7KW7NTYocHaRvOEwtwtkQ4hs28vO5ApI3WSyn6wOZSVLEGOzPjjMwluR8BspIvKzBUzVRzgHI9aQ21tE4fDGUrbgha0aRDpfO9DPNVO4IKRuwbjO50rv2/e1NeFnZQojhtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783344673; c=relaxed/simple;
	bh=7x9awA5nmoyx1UqwnEAd0FflOuYZ1NXGJFmepI2KkUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0L6MTR4m82wvRs3jmzTbGohxxL+8QLuz4DQYhKVOxli2Pbt02OMr+Y95Xkm7bAjdgCsvGwbEwD5zGrSgCzICrfQGcKF6JoycWRqiyeIE1zc9tdC4xoOGcq9M5T0Hq9NKXbjB57dihyKLis/BZrhXpPml9udmFRvvSJdBQ9iS/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=dOJKes6/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UF+TIdiw; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="dOJKes6/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UF+TIdiw"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 553B87A0084;
	Mon,  6 Jul 2026 09:31:09 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 06 Jul 2026 09:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1783344669; x=
	1783431069; bh=DFUGFQyQzVPK09g2DuqR4kS0HKfrvSeKc/J6SUbSCZM=; b=d
	OJKes6/uCU7WGHG0Ngj3ZtwdbZuAoyUtO6GmM4b1pXMsQ5mfQ03C5q44GkT6Synr
	3Ax3znTFT0w/T1bc28rt9O+0/lJrozTxVpU2EYhEpimf6Kb+oVibbq9mroePku5V
	w8vXNj2YOnvrMEXVXrEB1kNiaWSTRcJIPUdxHU+v0LNfVacolFdlsWOZKkmxhBHn
	qORL1NxGhDAsdWPl9NA3gkfiTwBrwQxsVzcPF4bpD+hfDMJ+Resy8fXVYpfCrgm2
	2YzwQMuJ51JSRtz8ep3j2ATq0BgZ0UFocG2bfJQFQ1hlEuMfBIHfctmKrGZ8ibKx
	4sEeIjMZz1QfYDC8NQJPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783344669; x=1783431069; bh=DFUGFQyQzVPK09g2DuqR4kS0HKfrvSeKc/J
	6SUbSCZM=; b=UF+TIdiw31W9QOHNCeIqqZzECs+quEagkAirzVlEkULRUpvOjJy
	WzzJUV/5lFLfrTuSadYFMaCxj7WQ30RP63b0anxGFUoS05nzAiLWsofFEurBC38Q
	lvrXMqE2Jxzgmgcz3MQlgtUr6Gw+870SWrWleormz7Em2Fi8l9G2nFir4B/Rjf19
	acZtWgiNDNSsEHjmIcsCWKjXPI/HVVnO0jaiguGwGM/i7qR462Y1Q6rVe4QPRRKA
	JRRRIg9gQ0UoyyxbaLwELURwWiIBFvDreB6OD7GlOTlTc363oiAINltRkupD2YvG
	fRtdZlkEIuYzrpGgUouE0Sxr/EXFf1wVHww==
X-ME-Sender: <xms:HK5LatxvxsNO4CRyVM11tMJIMFJRmLJazsFhdTh41iyPOWedtjQMzw>
    <xme:HK5Latv-bpxCNMvitKc8eGwAG8-RMJcY4KCJoyZo7gLVkJnNljVA0GybW5zKGvaUO
    _ZWj5ieNv9yyB7j5q8XyUwc5YRNqBwKIRmzL_TRu-VjDYATro1aHlQ>
X-ME-Received: <xmr:HK5LaoBBJvlJPA5mjEV4RPVEPnPseTnrgp285oGxYRiJTsR0wIEoBu00o1Q>
X-ME-Proxy-Cause: dmFkZTFD7wJ3IvjMz1MIxwtJ6Wnrm2HM6x/4TCwRPWChgA+dgF6zRTZ95J23b4iSQHLSGM
    WwBHaXUIeiaOTXXzS1mVPLK1lj7Gtw//28L+z+hap+rJbT+kuxH0zTWrHUWq33UqAY7Dw1
    MAqea8gDL1DMqYf5gpipWAWnW3aqydoNu2Eg2VGpmLIOWo1OaUKEh6h1hTJOIseya2JDTQ
    U0IzsR5vVlg9AtCI/n2i3V9Bdu+Djd2RStBrEY4qu0hrQZgGw2QYAZQutJv1NmS9KICom4
    9ch+GMNCsGMsDCLPIBlTdBtjTS5m2FOv40caTkNObC9g3f6FadUD+ZuSJ+9sO6jknmVDGK
    5+6ddZFQ6jUCpfZyu+03ySDjE4OjpyQV9D7e8PyqcsPX8C1uvDtX1m8Adxll32w7psjdGv
    YlOCfwzlvGQT+9jTyild7bLeH1fl7lTI4zD5NzHQWR9im+7RivF918oDp5JUfJrww2HMdq
    /ZvST1/0qbsY9vilB0iqkEksndN4O7KwuowXaJQNsPJXatLH9yGqa8ObK6PsJSUNKQcUbJ
    TESbf8SlP0KXmCFJg+5MNG47MPuqvGTZQFzdEtyLDdiJSA+5h+T5Fn/qo/oAjbuwd2dzlj
    LZrOTpJgoBukGwLVlzl80en+rX4uznz2sQQq8jm3f8Y7a55cPC4yPWNaU0mQ
X-ME-Proxy: <xmx:HK5LanHK7k1Q5FPku9uzTd8tkovMuAe9v6Amb7EbV1KjeazkQMgYqA>
    <xmx:HK5LagDxX8oVPgWKSDEHzx5Ds4GXENiQLciT04OpkKNHkBLRHZMv2g>
    <xmx:HK5Lalme1Llgur9qLk4Xb3lHWdikjIQZ8P-H8dGBboMAW6FOBb_Veg>
    <xmx:HK5LauM59amSlS0KEh7hABM8BeQH7KVtKYbxVwJvl6-mOB6CkSP8iQ>
    <xmx:Ha5LalNUBIHgb0rJK6bQwaW-7DlTB2x5SUsokqcwxcrTkpQsifIFRaNS>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jul 2026 09:31:08 -0400 (EDT)
Date: Mon, 6 Jul 2026 15:31:06 +0200
From: Sabrina Dubroca <sd@queasysnail.net>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] macsec: don't read an unset MAC header in
 macsec_encrypt()
Message-ID: <akuuGhf4aR7V33eO@krikkit>
References: <20260703083634.2035145-1-4ncienth@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260703083634.2035145-1-4ncienth@gmail.com>

2026-07-03, 17:36:33 +0900, Daehyeon Ko wrote:
> macsec_encrypt() reads the Ethernet header via eth_hdr(skb)
> (skb->head + skb->mac_header) to memmove() the 12 source/destination MAC
> bytes forward and make room for the SecTAG.
> 
> On the AF_PACKET SOCK_RAW + PACKET_QDISC_BYPASS transmit path the skb
> reaches the macsec ndo_start_xmit() with the MAC header unset, so
> eth_hdr(skb) resolves to skb->head + (u16)~0 and the read is out of
> bounds: a 12-byte heap over-read that is also emitted on the wire as the
> frame's outer source/destination MAC. KASAN reports a slab-out-of-bounds
> read in macsec_start_xmit() on 6.0; on current mainline a CONFIG_DEBUG_NET
> build flags it as an unset mac header in skb_mac_header().
> 
> On the TX path the L2 header is at skb->data, so use skb_eth_hdr(), added
> by commit 96cc4b69581d ("macvlan: do not assume mac_header is set in
> macvlan_broadcast()") for exactly this purpose.
> 
> Fixes: c09440f7dcb3 ("macsec: introduce IEEE 802.1AE driver")
> Cc: stable@vger.kernel.org
> Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
> ---
>  drivers/net/macsec.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
