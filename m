Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCAFF226D05;
	Thu, 24 Sep 2026 14:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259030; cv=none; b=XVy7+Se9K5oSqRsfuLlMYet1sGc10/gxKavZn22cZdT/HiqjrEbACUbfRpkkOljRNz8x9vyZKHblWrxUOQLynnwNu01rIlufP5NWItD21MbcCOyKqfF4WAKm+TdeJOxFRbObyK8YZf/L8WkI4rsiTNRKjrZcMK+lO6dWX9ie9AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259030; c=relaxed/simple;
	bh=aM1l7xWpk7Nk9FZ6Y4cSOcCke0Ue1Ak3K90xdmwzNUE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JyXtjhCmmvY3MxFefUbS2THvdP6EQgew+wGopfl82UlMPWYT7DFtmdRLaJhCqursQml5S5NgpilpWOEZOhCF341Nv2loE/ElG6aJbLtFHe0lfny9a6hAzz/peuH7/UD2MJxI6TGEQ4cyzrbUcx9vZzD2t8XZ3hpSQNvQP2rkewQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tuPx3f7D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tuPx3f7D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=EGjUVyBqiUHIChv/xiYG27ZIn2mAGCIWx0iT0s8Mbrc=; b=tu
	Px3f7DqcaBG5pm8gODsd1RHxL1XmyRewbX51QApDoPZ2dKwuNQbjmny+NX38bhndBEwr61oQqHRcX
	icQ+ncY8wYhlv3H4+38VmVNeA8aT5BwU+7f6Oeu75oWtDPHsyK6DW1US2zmqXY7aVOmC0UVAn7aR3
	psntzXOz5LoYk90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9k9Y-0070YL-BH; Thu, 24 Sep 2026 16:10:24 +0200
Date: Thu, 24 Sep 2026 16:10:24 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aldo Ariel <qwe.aldo@gmail.com>
Cc: Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>,
	maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCH] net: stmmac: guard FCS stripping against runt frames
Message-ID: <64d3ca1a-7218-4c90-a110-6ff7defb56ac@lunn.ch>
References: <20260923162339.1375698-1-qwe.aldo@gmail.com>
 <arQ4dVkI9llhXCDx@lore-desk>
 <78724445-4c69-44fb-b82a-1f9275e37e9e@lunn.ch>
 <arTX2kNFGXLg7vdn@lore-desk>
 <8b3d8225-0d86-4e73-86c8-b7f644faef56@lunn.ch>
 <arUhV90af6coj2IK@lore-desk>
 <CAP48HfvkCNb2_UnpvTvn_O3K+vgtDK55JjXPBF0cbBrmb_6oCA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP48HfvkCNb2_UnpvTvn_O3K+vgtDK55JjXPBF0cbBrmb_6oCA@mail.gmail.com>

On Thu, Sep 24, 2026 at 10:51:11AM -0300, Aldo Ariel wrote:
> Hi Andrew, Lorenzo,
> 
> Fair point on the subject — the trigger is not limited to runt frames.
>  
> The FCS stripping in stmmac_rx() at lines 5810-5817 runs on every
> last-segment descriptor regardless of total frame size:
> 
>     if (likely(!(status & rx_not_ls))) {
>         if (buf2_len) {
>             buf2_len -= ETH_FCS_LEN;
>         } else if (buf1_len) {
>             buf1_len -= ETH_FCS_LEN;
>         }
>     }      
>        
> For a multi-descriptor frame, the last descriptor's buf2_len or
> buf1_len carries only the tail of the frame. With the default
> dma_buf_sz = BUF_SIZE_2KiB for MTU 1500, a 4097-byte frame splits as:

Is the MTU programmed into the hardware? Will it even try to transfer
an 4097 octet frame when the MTU is configured to 1500?

   Andrew



