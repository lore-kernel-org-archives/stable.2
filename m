Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484EA23393E;
	Thu,  6 Aug 2026 12:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786019734; cv=none; b=JMYVVGVjcrqLljuK6ibpEc1op/5Ea/9LlymwUKeH7k1GAV/A6mbcD4TSASYdg8KHnInKexaKkOkmB+pEHIB2ODtyZG9atBGUvuCBRJ78zIu+DAt6cAXWw1LL8fky/WefcoSA0xvLOJZfn43PXb2NUb/bfiCEqw8E7VbbbGCnGUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786019734; c=relaxed/simple;
	bh=22f/ORFy9xHXyp3amJMw/b8KiBFLeSRgzjCPwC7cs2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mgtRazL4o81SOBKrC5+9O117Ku0aSS1qP9zwMJlUYCa3lYMjWn1kBwRkSq+j2IPC8h24Q7E99uPtWBKnZwgw9FXK5UfECP9LlpCpC43sGKru5iwWGrDGQnwg2LehxzOhTVZA5aAfIVpNCVD0MG09QOJLRALWEx/g6eH4GPGAE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cABUQWk8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cABUQWk8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 620EC1F000E9;
	Thu,  6 Aug 2026 12:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786019732;
	bh=7HN6AZZ4wJc8929yZyjEuwHE1pPCwfY73BVphBRGBWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cABUQWk8e+JYhNZ9tstdj2vCf1N4c82POmA2d9yFmgKjf4Cyw6FiAkJ7t4fAOKuCQ
	 SWEvHnOAiYtoefTnhOhae+zHqS77jL++3ys7y5RaKoasrIJKtVUlxyUWGiJazeylBC
	 oYhRWWBl/1gO0L7UdQ62ot/qLJct83E9BgN70mWdOI3Ns/XAz4m+dXNrugvmHoxi/O
	 pGnPIveTL47PodCjw0+qt9pp8At8DvkYos3nKKhuc14iiJQFvfPW2I+gn508qWzKTT
	 BLaJhbV3LG/ffWQydL0c9v6jRjGHxqcMPbyj8250wLuwH+/TDrfVMZgxFB5xorTXKN
	 jp8X9lJUAEF6A==
Date: Thu, 6 Aug 2026 14:35:30 +0200
From: Antoine Tenart <atenart@kernel.org>
To: moonafterrain@outlook.com
Cc: Sabrina Dubroca <sd@queasysnail.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Yuhao Jiang <danisjiang@gmail.com>, 
	stable@vger.kernel.org
Subject: Re: [PATCH net] macsec: check offload ops before inserting TX tag
Message-ID: <anR9qnWz4-_hbUf5@kwain>
References: <20260805-macsec-fixes-v1-1-634d7679a030@outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260805-macsec-fixes-v1-1-634d7679a030@outlook.com>

On Wed, Aug 05, 2026 at 12:52:10PM +0800, Junrui Luo via B4 Relay wrote:
> From: Junrui Luo <moonafterrain@outlook.com>
> 
> macsec_insert_tx_tag() takes the ops pointer returned by
> macsec_get_ops() and dereferences it straight away:
> 
> 	ops = macsec_get_ops(macsec, &ctx);
> 	skb_final_len = skb->len - ETH_HLEN + ops->needed_headroom +
> 		ops->needed_tailroom;

phydev is read again later in macsec_insert_tx_tag, that probably needs
a check too (I don't think it is used in practice).

> macsec_get_ops() returns NULL whenever the offload is no longer live:
> for MACSEC_OFFLOAD_PHY, macsec_check_offload() requires
> real_dev->phydev to still be attached.

From what I can tell the same issue could happen within
macsec_check_offload and __macsec_get_ops too (and so macsec_get_ops).

Also looks like handle_not_macsec has a similar construction, does it
need a check?

> phy_detach() clears real_dev->phydev, e.g. when the lower device is
> brought down and its driver calls phy_disconnect() from ndo_stop(),
> when the PHY driver is unbound, or when an SFP module is removed under
> phylink. A frame sent after that point reaches macsec_insert_tx_tag()
> with ops == NULL and oopses.
> 
> Check the pointer, as every other macsec_get_ops() caller already
> does, and drop the frame through the existing cleanup path.

Looking at phy_detach, could the PHY device also get freed? If so things
could get wild, but that is probably out of scope here.

> Fixes: a73d8779d61a ("net: macsec: introduce mdo_insert_tx_tag")
> Reported-by: Yuhao Jiang <danisjiang@gmail.com>
> Assisted-by: Claude:claude-opus-5
> Cc: stable@vger.kernel.org
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/net/macsec.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/macsec.c b/drivers/net/macsec.c
> index ee0e2eb7dbc6..86c8009dcfa9 100644
> --- a/drivers/net/macsec.c
> +++ b/drivers/net/macsec.c
> @@ -3436,6 +3436,11 @@ static struct sk_buff *macsec_insert_tx_tag(struct sk_buff *skb,
>  	int err;
>  
>  	ops = macsec_get_ops(macsec, &ctx);
> +	if (unlikely(!ops)) {
> +		err = -EOPNOTSUPP;
> +		goto cleanup;
> +	}
> +
>  	skb_final_len = skb->len - ETH_HLEN + ops->needed_headroom +
>  		ops->needed_tailroom;
>  	if (unlikely(skb_final_len > macsec->real_dev->mtu)) {
> 
> ---
> base-commit: 075b74841bd0065a3bda3440873c747938e69b68
> change-id: 20260805-macsec-fixes-d280baf70552
> 
> Best regards,
> -- 
> Junrui Luo <moonafterrain@outlook.com>
> 
> 
