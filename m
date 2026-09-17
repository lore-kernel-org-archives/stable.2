Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C2764973BA;
	Thu, 17 Sep 2026 15:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657558; cv=none; b=aoVE+ly8ZSujstC3ra8atYeckytguZvWxewJgFovZ0DWeEApd8uToFC+pC1LLPqPT2eUx8+QwfGxDo9A4qMb6Nxoi1ARiVScb3OlPtv3/8NhQR9JAYp63kKswDNGAWVgSQcE21ETPT+pIh2gzV7a69lzkg+tKJI+/DSI/0E7r44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657558; c=relaxed/simple;
	bh=LqL/0kljGKJhXL31YOmzbq3nfv6vRF4UJIBHY7IP5Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uzxMpdaBBvd8ItUexv8s1YPhgN4Q5jgcpy/73le86XudTDc/frMnLTb9eH3HlruHfsHq3dAju6+vmvWI/fs9RWYNpKmsooarZtFoSWHNdOv+Fx1iSwvolSk7foOp6wDJebx2jxikrTc9oOHLBO9HZx/vSV4rsbmUrwbuKEszy5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=t2/qzzzy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="t2/qzzzy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=xJOwgYi9AsLFETj5P07KS7icxDQTYVsi9d2yzmRT4T0=; b=t2/qzzzyp9tTNVrahR16BD/kfi
	QGsz5UiuR0lAl4EpGn+qCgG78KupUM6RXniV88PUv3kprugmNm3aT5Xm+smJDRlIbg55yRhPd42ba
	2qfi/hL9zPhWcg78bfSyCnRipuf2Qhzqwev7E2gYZyXWIrlJHyyFFbuIRCbcipo9cGkk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x7Dft-005hJS-1x; Thu, 17 Sep 2026 17:05:21 +0200
Date: Thu, 17 Sep 2026 17:05:21 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Linkui Xiao <xiaolinkui@kylinos.cn>, stable@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: ethtool: validate TX coalesce before
 reprogramming RX
Message-ID: <15b8cbc2-f3ca-4845-9a93-7fff6c5aede6@lunn.ch>
References: <20260917131235.1360959-1-xiaolinkui@126.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260917131235.1360959-1-xiaolinkui@126.com>

On Thu, Sep 17, 2026 at 09:12:35PM +0800, Linkui Xiao wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> __stmmac_set_coalesce() applies the RX part of the request first and
> only afterwards checks the TX parameters. The RX path already calls
> stmmac_rx_watchdog() and stores rx_riwt[] and rx_coal_frames[], so when
> the TX check rejects the request the driver returns -EINVAL after having
> silently changed the hardware. A following ethtool -c then reports the
> new RX values even though the command failed.
> 
> This became easy to hit once the per-queue interface was added.
> __stmmac_get_coalesce() reports tx-usecs and tx-frames as 0 for a queue
> index that is RX-only, and ethtool applies per-queue coalesce by reading
> the current values first and sending them straight back. The next set is
> therefore guaranteed to trip the test for both TX fields being zero,
> right after the RX watchdog has been reprogrammed.
> 
> Move both TX checks in front of the RX block so a request is either
> applied completely or rejected without touching the device.
> 
> Fixes: db2f2842e6f5 ("net: stmmac: add per-queue TX & RX coalesce ethtool support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Linkui Xiao <xiaolinkui@kylinos.cn>
> ---
>  .../ethernet/stmicro/stmmac/stmmac_ethtool.c  | 21 ++++++++++++-------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> index 154cc0c7623d..325db062f72a 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
> @@ -850,6 +850,19 @@ static int __stmmac_set_coalesce(struct net_device *dev,
>  	else if (queue >= max_cnt)
>  		return -EINVAL;
>  
> +	/* Check the TX parameters before anything is applied: the RX part
> +	 * below already writes to the hardware, so rejecting the request
> +	 * afterwards would leave the device with only half of the settings
> +	 * the caller asked for while reporting a failure.
> +	 */

Why such a verbose comment? Look at the rest of the code and make your
comments similar in verbosity.

    Andrew

---
pw-bot: cr


