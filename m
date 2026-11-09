Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794242240;
	b=CIaTH8nc8iP1BXmAlcGIgxO9avz/HG0y+i4OEk5sD1z//a+BQaNIX+tn2LdhfUcG/iVJ
	 yrIBoXV6ZHcQLYvl0hGwzQ+qXjfC3YbJas0OcqtpYNsjkV+RAzfZM7kLA2F/sucYcJ3lq
	 uA2tHeRuVPU8L5FERgT+Ptj9Qd+BThWJZ8qr552NBiQn9qibxgNZRraGXz9hsBsFYLDRa
	 oalLGeMWdGgKp/3Z5mWC8gePgvqqd6B3Le1qyIvSSrR8ctq5pcWKclu9A3x+J2qSYsx01
	 1B2NR+p8t0sKcnZ8O5qdltqaNoVLNyms9ZttuCAc5nTm9hg7814EnHuCPfc5sozu92g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794242240;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=eaeDip5yy0FF8SCIX/1UWm1Ikp0/r1QeQQKcFD3VElY=;
	b=ZPVOtQt0Hxe6dNKCCGOXJ+BB8v3hH041Jxdyymzer++tZ2ZAXtOdAGHRTiI0BL+HpoWP
	 LBpVaq/qTRS7s42Vq8qg08M8XsJRHpdbI+PTtOddMnxmXkK9PYO+TgDW0oB2QVedovzZa
	 T0g8vPjB/3JmRXgIsq20Bslnx1bCrSXUjStSe/nhg8H8S56XE5oM5WYxpkq4T73Xd2kqa
	 mZwL5J9WuC1oVHw+Zzp21Ell9+hIovhbAu4nFWUuY0Td+pSZAz//kTIdskpbVss4CAlXT
	 r8Ms73h4xtoNLwEzHQG+F4ow+m8NIahpN4ZtN34YIof/XLrlZLr83/pj3aIvx/mD7VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="d/WYzf4E";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84137606C730;
	Mon,  9 Nov 2026 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d/WYzf4E
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1D81F008A4;
	Mon,  9 Nov 2026 16:37:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794242240;
	bh=eaeDip5yy0FF8SCIX/1UWm1Ikp0/r1QeQQKcFD3VElY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=d/WYzf4ECjeuD/81NWrh0x5HGDdfTJrdvs93UvhC6he9Hw+cxFt/mbwwKekc+cYy0
	 Fvw9zDv2NbKFvaXwXvllJZtmP4Aun7/ruhTRQfb0h6KgqK9OuJKr3d50j+WezU0M1m
	 1obtjz6Tbfz8g1cXAQtEiY2bQfYg1t+UK6KKTRNaaA/HXWIHqOm4vmyzRyXp2TJn+N
	 2KrlM3QrYDe+kjQstHK2eIIY91JArp1gDe+LBRAH9TzmmvJ9CG0Tz/D/+JxSlNHKU9
	 aXGKAmPLKNu6d1o9O66tydi8du93kLQl9wwM8XypqjTM2Z1u81MDbz5OVuDdKI6DwX
	 cjHo8nSqDxnuQ==
Date: Mon, 9 Nov 2026 16:37:15 +0000
From: Simon Horman <horms@kernel.org>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: Bryan Whitehead <bryan.whitehead@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: lan743x: disconnect the PHY when PTP setup fails
Message-ID: <20261109163715.GQ18859@horms.kernel.org>
References: <20261103102852.1340530-1-vulab@iscas.ac.cn>
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
In-Reply-To: <20261103102852.1340530-1-vulab@iscas.ac.cn>

On Tue, Nov 03, 2026 at 10:28:52AM +0000, Wentao Liang wrote:
> lan743x_netdev_open() connects the PHY before opening PTP, but if
> lan743x_ptp_open() fails it jumps to close_mac, which skips
> lan743x_phylink_disconnect(). The reference taken by
> phylink_connect_phy() is then never released, and the PHY stays
> attached to the phylink instance.
> 
> Add a close_phylink label in front of the phylink disconnect, as the
> pre-phylink conversion code did with close_phy, and use it on the
> lan743x_ptp_open() failure path.
> 
> Fixes: a5f199a8d8a0 ("net: lan743x: Migrate phylib to phylink")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
> ---
>  drivers/net/ethernet/microchip/lan743x_main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/microchip/lan743x_main.c b/drivers/net/ethernet/microchip/lan743x_main.c
> index 82d3ec20ba25..390aec639c71 100644
> --- a/drivers/net/ethernet/microchip/lan743x_main.c
> +++ b/drivers/net/ethernet/microchip/lan743x_main.c
> @@ -3331,7 +3331,7 @@ static int lan743x_netdev_open(struct net_device *netdev)
>  
>  	ret = lan743x_ptp_open(adapter);
>  	if (ret)
> -		goto close_mac;
> +		goto close_phylink;
>  
>  	lan743x_rfe_open(adapter);
>  
> @@ -3374,6 +3374,8 @@ static int lan743x_netdev_open(struct net_device *netdev)
>  			lan743x_rx_close(&adapter->rx[index]);
>  	}
>  	lan743x_ptp_close(adapter);
> +
> +close_phylink:

It seems odd that basically this unwind logic existed before the
cited patch - even if the internals of the unwind differed - but
was removed by it. And yet, the unwind happens for other cases.

>  	if (adapter->phylink)

As an aside, I don't believe adapter->phylink can ever be NULL here.

>  		lan743x_phylink_disconnect(adapter);

Please do answer the email from netdev-bot+sinfo requesting,
elsewhere in this email thread, information about the providence of
this patch.

The above not withstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

