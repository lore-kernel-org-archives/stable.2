Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8139EF1C;
	Wed,  7 Oct 2026 14:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383508; cv=none; b=LOJMk9deUBtan6YTGfygbuD6ypJPL+VdA4ThrA7Pr+GHFouAXLZEIPJx1w1H7j/WpCjuCRaOWEJY6384io5giTZK0NEmLs7vJnzeE+Y8/YACNzBfjLfXRwLvsGaNAzdlWwfwmePF3r+FcKab9cEbqXOwRgS0TbzuXO0mPZRCOts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383508; c=relaxed/simple;
	bh=EWOXX0pSdVpVw0OMH8V6abkv3BIwXFK0qW0lRd/OYK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e9+xVZGMaE42DzrjY9NeNsIGfxEnnLnrRgo2HNvexzzsr+cTFg217MuL92v1Dhzm/Iu/6iRDhE98WEwmhEFN+hBCLmRU/B6USMqPG9ysFizrseqEDDTKEMlUMUIg/DzUQFP/Le/1r+tdKv12Dg2G7+rrtXCRzIYyd1/Zv6LLMrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvkQA9AR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvkQA9AR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D1D1F0089C;
	Wed,  7 Oct 2026 14:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791383503;
	bh=mVdNjo/aJq7ORJIk7eTcpj5IV+csgIa9+cL62v3XkAU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fvkQA9ARbrEG6VR4KEwjSRrfOi0xyixaPV0x+kDwWYZW8tFswTwcusfBL4ubBaLSr
	 q3gzEu7CB1dZJDHsMms4vA7Els7Iz+ZaJLDpT1C4lA+y/DKg+pznLTwZGUfNw7VedH
	 Ccd+YUrArLgz094DZKHyqEfzncOzmJBFfx9r97lkfaJf9vSx5ZTK4XqJmYTixv+waz
	 VU/+MkzOKsNDSt3M0Mf5seAOTwsZg3FSAULjFcme7cXczflXB5PJaf3D2/KGXWIyZE
	 pl0fIck59YPsS0hsu2W0QUZw7bP5njy/3ftBJLG5yRwiFLbhM1JAATQwXQnewXD5zo
	 TJgEYa0gSDlHw==
Date: Wed, 7 Oct 2026 15:31:37 +0100
From: Simon Horman <horms@kernel.org>
To: fredrik.nyberg@volvocars.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jose Alonso <joalonsof@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: usb: ax88179_178a: fix rx frame length for
 non-last packets
Message-ID: <20261007143137.GQ83879@horms.kernel.org>
References: <20261002-ax88179-rx-len-v1-1-f01a2a295079@volvocars.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261002-ax88179-rx-len-v1-1-f01a2a295079@volvocars.com>

On Fri, Oct 02, 2026 at 02:28:57PM +0200, Fredrik Nyberg via B4 Relay wrote:
> From: Fredrik Nyberg <fredrik.nyberg@volvocars.com>
> 
> Commit 4ce62d5b2f7a ("net: usb: ax88179_178a: stop lying about
> skb->truesize") replaced skb_clone() with a copy into a new skb for
> every packet of a bulk-in transfer except the last one. The copy skips
> the 2-byte IP alignment pseudo header but still copies pkt_len bytes,
> and pkt_len includes that header. Each of these frames is therefore
> delivered with two extra trailing bytes: the 0xeeee pseudo header of
> the next slot when the frame ends on an 8-byte boundary, or slot
> padding otherwise. The last packet is still trimmed to pkt_len - 2.
> 
> IPv4 and IPv6 trim the extra bytes, so most traffic is unaffected.
> Anything that relies on the frame length is not. MACsec takes the ICV
> from the last 16 bytes and drops every such frame as InPktsNotValid. In
> our setup that was 0.2-1.2% of received MACsec frames, depending on how
> many frames shared a transfer, including service discovery multicast.
> 
> Allocate and copy pkt_len - 2 bytes, like the last-packet path.
> 
> Fixes: 4ce62d5b2f7a ("net: usb: ax88179_178a: stop lying about skb->truesize")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fredrik Nyberg <fredrik.nyberg@volvocars.com>

Reviewed-by: Simon Horman <horms@kernel.org>

