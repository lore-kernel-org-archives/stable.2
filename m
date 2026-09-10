Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CC33955CA;
	Thu, 10 Sep 2026 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789035276; cv=none; b=WyRzCzOb89WWcimuSwGv5YewqIwIWs0dVQClX+INJJvvFXQhJT0QRQaBLwv/fyekqLg0dnACsXyVrhqc4+JdxrnWT8tw97R7vxOfKKjhZJQxVk5CcuEwmpepgQuQiSHXNQZEVw7Q5XjdMfi9Zbt7mCsCQ1b7IYnmzKpibpukuak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789035276; c=relaxed/simple;
	bh=jpVG4p3SMg6F7Y/z1SShMyfoiqGQ5ZswZ/kwFzvBNK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HnziPhHt2OOreWshHq/1axVrtESYAjDwESxpqq9+Iw4ZPXygMX24yNvzE+jiYJy6t0MH2SZuLBcRTBZf/ZG98WMFxuDX2ctO9XiRRWDcUPwcM8U1mWGwe1K3rZIztS1M0DI2k73u/YABwm/lGZ160xNEDxcRIubBUgG7vwBGQfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L5IJxrpH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L5IJxrpH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D461F000FF;
	Thu, 10 Sep 2026 10:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789035274;
	bh=vuN9YgNNVDUDcK9F5V9wjj4jgSHSO9jPfMDMRTl00m4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=L5IJxrpHYACCI3tkKbfR8R+V4hXIzjwQbm69USLqNRck8/aJ6MxyOPfDyv9Z6Xi0t
	 HTl/wQEbF/iISzOx57w+XLzjMSvEdrfejt1OI8HNGOxT5T26hHcL+4PKOKvvQ3aDFk
	 5FrUCFhyKYas1qYBbyC2urL6cG9LDmgZZLOcrqUmhOXIkF2MnnwrX74JwzFFu/myfR
	 wKrrm5O0tihSm/n+nLCZH7FsTnRGtbvbG5NVEUkFlsuSfueWUjjZqG+PfBo1pidDoj
	 aKTLRliAYoM1sLfxR0PY1SVYQgEpTZIkYeS9aQnm/GfPNZ4MiHs4A72rKSGydHwDHS
	 rrf/OXv4UACww==
Date: Thu, 10 Sep 2026 11:14:31 +0100
From: Simon Horman <horms@kernel.org>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: Samuel Mendoza-Jonas <sam@mendozajonas.com>,
	Paul Fertser <fercerpav@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] net: ncsi: validate MAC and VLAN counts in Get
 Parameters response
Message-ID: <20260910101431.GU40544@horms.kernel.org>
References: <20260906233752.87773-1-elb12345@hotmail.co.uk>
 <AS8P251MB0001E99A1865DFEC3C3A16E7C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8P251MB0001E99A1865DFEC3C3A16E7C8B32@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>

On Mon, Sep 07, 2026 at 12:37:52AM +0100, Aamir Ahmed wrote:
> The Get Parameters (GP) response handler iterates over MAC address
> and VLAN filter tables using counts (mac_cnt, vlan_cnt) taken directly
> from the response packet.  These counts are not validated against either
> the actual packet length or the filter arrays allocated by the earlier
> Get Capabilities response handler.
> 
> A malformed GP response can cause:
>  - out-of-bounds read past the packet data when iterating pdata
>  - out-of-bounds write to mac_filter.addrs[] when mac_cnt exceeds
>    the allocated filter size (n_uc + n_mc + n_mixed)
>  - out-of-bounds write to vlan_filter.vids[] when vlan_cnt exceeds
>    n_vids
>  - bitmap corruption via set_bit()/clear_bit() beyond u64 width
> 
> Add three validation checks before the filter table loops:
>  1. Packet is large enough for the claimed MAC and VLAN entries
>  2. mac_cnt does not exceed the allocated MAC filter capacity
>  3. vlan_cnt does not exceed the allocated VLAN filter capacity
> 
> Also check for NULL filter arrays in case Get Capabilities was not
> processed first.
> 
> Fixes: 0b49507fc090 ("net/ncsi: Resource management")
> Signed-off-by: Aamir Ahmed <elb12345@hotmail.co.uk>
> ---
>  net/ncsi/ncsi-rsp.c | 31 +++++++++++++++++++++++++++++--
>  1 file changed, 29 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ncsi/ncsi-rsp.c b/net/ncsi/ncsi-rsp.c
> index 1401528dbd6c..88f3b8db0289 100644
> --- a/net/ncsi/ncsi-rsp.c
> +++ b/net/ncsi/ncsi-rsp.c
> @@ -884,10 +884,38 @@ static int ncsi_rsp_handler_gp(struct ncsi_request *nr)
>  	nc->modes[NCSI_MODE_AEN].enable = 1;
>  	nc->modes[NCSI_MODE_AEN].data[0] = ntohl(rsp->aen_mode);
>  
> +	/* Validate the response carries enough data for the MAC and VLAN
> +	 * tables it claims to contain.  The variable-length area begins
> +	 * at offset 48 (right after the fixed Get Parameters fields).
> +	 */
> +	if (nr->rsp->len < 48 + (unsigned int)rsp->mac_cnt * ETH_ALEN +
> +			    (unsigned int)rsp->vlan_cnt * sizeof(__be16)) {
> +		netdev_warn(ndp->ndev.dev,
> +			    "NCSI: GP response too short for %u MACs + %u VLANs\n",
> +			    rsp->mac_cnt, rsp->vlan_cnt);
> +		return -EINVAL;
> +	}

My concern with this patch is the same as for patch 1/2.

I'm not sure that there is any guarantee that nr->rsp is a linear skb
and if not then checking len is insufficient and I think the check
should be implemented using pskb_may_pull.

Not that any pointers referring to skb data may be invalidated
by that call, so, f.e. rsp should probably be set after the
call to pskb_may_pull().

...


As noted collectively by Greg and Paolo elsewhere:
1. Please include an Assisted-by tag
2. Please keep the number of patches in-flight to 15 or less

-- 
pw-bot: changes-requested
