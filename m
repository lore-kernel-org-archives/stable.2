Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D17730674E
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 12:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785415625; cv=none; b=PNIsm+mN3DMX1cShZiGOXDzKnXdFQpqguksPqXEEcCz5bB5h1uVoqZRgx+cb1ZfmJpAbU7uhHp+Z+j3GJj0HlkSt96+rRtxwnLxPObwwpK5oTTe69/xUFW2UzPVFMrPojJQ4HcHYMZ75//9d0BPcH4rhJK7NxpN6eMTW+M2u9X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785415625; c=relaxed/simple;
	bh=rwb+asvub3ylKYMkVNM5RwMNsX9uViy3o5RmUH+bMeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GxalJ6ynD+GszBl/zYeuZ99RRXxZabSw6bl/DnrRFN33h5AkaCGKEDBRbsTX2HpbJ0liTznapXJRlKB95uXSnOXZc/ZaIL2RVURe4HjF2I+G6nNAoKCcz3xbkV0wwc2NZ6BcG82c1BSmevZ+y3tNC8z6pTSBYGwgcBPVH24Wh4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com; spf=pass smtp.mailfrom=kroah.com; dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b=n+T4AlV2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UV59c6bq; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kroah.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kroah.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kroah.com header.i=@kroah.com header.b="n+T4AlV2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UV59c6bq"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 206AA7A00A1;
	Thu, 30 Jul 2026 08:47:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 30 Jul 2026 08:47:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kroah.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1785415622; x=1785502022; bh=sd+GAjpmGF
	xlDqQbcfOK+su92G4NEJIbembi4A7j+SQ=; b=n+T4AlV2oO86G8chAj1Bml0ql6
	bFgmxStTLZyl/IfTufc03LaovpTj/Ns+V1REXxofUjpYPb8FPwyrmT8Xv96eb1DN
	1ZuliNSUw5NPwvdjy/Uh22XfxzCFNyKS9IJug/8CcK4a7msayPlRRfCK+U2pYIdz
	i4yDddTHg/b8FW+/BoPikDoW4h7GxjYs1XdUP6MpwcF9okPdhN51UrEz4kO6224V
	LfN2z5Q7VY2I+EtJqLTIN0O9wtyWaTpmXk08DddG1pZbgiyX08eIYFNgRkYwF9nc
	NHLWlBf1dl0jswEpQjkr5kzX3j+FmS+F6YhQVnFmeNlIL/LIQaLK88y6RRfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785415622; x=1785502022; bh=sd+GAjpmGFxlDqQbcfOK+su92G4NEJIbemb
	i4A7j+SQ=; b=UV59c6bq10FMPT/ndrkRJrLxqATtI68aueRacb/GfO+q7GGXS4o
	OpdTUcF4B6qV3vzhgQ+9FUi9Eyu4I7gLBtfNvM1qqbVvG8Xb9aES6w7XmpkN8SfJ
	6Dsmn9JrRDs3CeTYOLqOdxvCR8z37xjXQXF5vttwrOHXYbWr+yQG/XxVE88CFT5X
	6oVyYAwz410pRJEFgnVreMG3ODZKh4iJ2atXDDHAvuDt/TGOxOEG5tyBKepgqxCs
	WzcMbfWII8kfe85dV+VB/Ikkw75Zbgq6G1Z7Kv/LrIZIWxuiuMGPDyXwKy54OIXw
	MTIiserd+19pryXlTMKeTydUSn5h9GpC5Ag==
X-ME-Sender: <xms:xkdrak-gYxb8mxQ1baSo3zLbn33RGmlwoOphtzHRDKywOYK7i7q_iQ>
    <xme:xkdravw8u4UMGp-XNswfRmRJZk79jSHc987etN73stAVZrgRMatZloN8Cill0AY6Q
    SuYFidNaFtEOeG0T35QkLgo6BWjrcivf9bZlNRgaxj79KjT7w>
X-ME-Received: <xmr:xkdrako38UVWYD7VmtDTqqQJ2CoyX6J10cDvxaZYD8j1S7c2RvCQDQb7KZHs_p3B7JElc8B7jm_8RVPJ3a0RB-fSLC7DDsiRZfdyfQNg2sw>
X-ME-Proxy-Cause: dmFkZTFBGHQnh+uxDreGUeT+W2FMoEwkPqyn/Z/xoolM5HdgKM72zqiopKhS6HiFESsX3e
    5C6yEshieWQFC5Y1oCtqUjRAyv9P2Kf/GpsHQ4bmGr8S4jD0idhH32qENl1LDgd7j0BmpU
    RjIW2FXYs6KdIuuatmfYDJ/vW5BSPFLjKx1xzhgBCNYsRXASE2Xx7pxsv5AU+itH3MKpcv
    DFXtDrH4tlGdtVzRVtwRVLu2yfx4Yma5K/CzU66md+0lio8zBkYZHfSThePCqdNNlrHjlM
    AIj3lC92W6vWUCGQ2Mk5l4T+E6O2EebeaIfzFu1uxsKql5IfNSxB8KhGdIuLK9je7aj2PG
    aWeRvSOxYxFi+xAouo9etIgA9JQNUHXKdNwbaFmVJehfv9A1OqYzBTpxSGQWEtRGIEkbER
    BtA1Y6CCwgr/7I9tXzO9W3RSHklkPic5COpozrbmofCxuOL+/IA46w4ByLsTWgyF0/fTiA
    N6LyLiT9feY6GG05N5D3XIKe0TY/TU4fMn4spha8s3v3RfHx6LE9RwyhYxHUEuu6/O8we+
    3CXmYeroTop1WPLuGTykgicx1bknAJ6XWuAlmvgc1h7H8FMgMbvnuJBJNJIU8HMzHfaGbN
    8yVoQli7z8R5eUHuCLI4eNyU7PNoUL0xvIpYz3AxfBXNhnSv3QHqNfiPvNAg
X-ME-Proxy: <xmx:xkdragp-m3wXa0uJg-GEwNmee8NVzPouHxXIPa54dejFkUruVTVenQ>
    <xmx:xkdrakAPajLoH1HJxAs0vq04YDub-6zsrvP1SYRtIs1nWL4WanBbXQ>
    <xmx:xkdrausOThIFajCY3I8_B0Tpv4OAdYBbSyR_KmXwg9gpfugmgbFSpQ>
    <xmx:xkdrajI-wgCU0O2IqiyxB3auie_xOX3HYBXu2k-B4-tnKTTmxbqk1g>
    <xmx:xkdrakWPeHbD-rgPpLliVjGi9SMEKhsarcfKoHtzRfo3Y5eE3yMAlo9n>
Feedback-ID: i787e41f1:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Jul 2026 08:47:02 -0400 (EDT)
Date: Thu, 30 Jul 2026 14:46:49 +0200
From: Greg KH <greg@kroah.com>
To: Sasha Levin <sashal@kernel.org>
Cc: stable@vger.kernel.org, "Wayen.Yan" <win847@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH 6.12.y] net: airoha: Fix register index for Tx-fwd
 counter configuration
Message-ID: <2026073041-radiation-atonable-b8d2@gregkh>
References: <2026072102-stack-mardi-5c7c@gregkh>
 <20260729203537.447604-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260729203537.447604-1-sashal@kernel.org>

On Wed, Jul 29, 2026 at 04:35:36PM -0400, Sasha Levin wrote:
> From: "Wayen.Yan" <win847@gmail.com>
> 
> [ Upstream commit 1402ecccf5630a0b7fa4749d7d2e72abc3f3d73d ]
> 
> In airoha_qdma_init_qos_stats(), the Tx-fwd counter configuration
> register uses the same index (i << 1) as the Tx-cpu counter, which
> overwrites the Tx-cpu configuration. The Tx-fwd counter value register
> correctly uses (i << 1) + 1, so the configuration register should use
> the same index.
> 
> Fix the REG_CNTR_CFG index from (i << 1) to ((i << 1) + 1) so that
> the Tx-fwd counter is properly configured instead of clobbering the
> Tx-cpu counter config.
> 
> Fixes: 20bf7d07c956 ("net: airoha: Add sched ETS offload support")
> Signed-off-by: Wayen.Yan <win847@gmail.com>
> Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>
> Link: https://patch.msgid.link/6a2b40e7.4dd82583.3a5c46.e566@mx.google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  drivers/net/ethernet/mediatek/airoha_eth.c | 2 +-

This file isn't in 6.12.y :(
