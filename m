Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1F9345CA1;
	Mon, 22 Jun 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115768; cv=none; b=ZcdbSkC19h7jjU8pRhZdppK3lDjvDgC+zpgtjLv7dxFXzvHCgemd0G5209/5Cpj0z/w4FWpOwW1vKQhq0ix4hS16ac7M1/092yWny2CAoj42QLcjQdwr4+nhrTmfMqQ14AKtzyyyKTKognRBeuwUV1eW8yQrN45SlSKl+mScumc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115768; c=relaxed/simple;
	bh=kBSaxasdUpSBApMp8lPp+2UF19a9J1gBJMFb36DxKgo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oNsNvQibjKUG2vV7QxMWFO+YAZZ1OcXsGgYmx/E52am++z0RBEf+AOjWqA+hoqXHtcpKxizS+t9Vf0k5rWzrJCXWFwv3sAhCat0CBfKZv9o16XN+XBG5RCtf+fPYVGOGszhEvUftukJoJp66eWxO9goTzobwWSVRLZA9LIh+D/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xqk+evGB; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xqk+evGB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LDq3f4iBwMZLdwHtzyFKK39pq/ztqthvsDddqEESusI=; b=xqk+evGB7ouG2cO+A1vTL+0Bbn
	H4zCeI3IZXur6NE460llhAJh7tuglZCQLSdQ02t0LDeagbsujhCjiLhB/e02bUoexTRKqhxc+l/UB
	NlgXlLGyL7bncg/FiUBlvwkc8UJgZlFYUcBjvNxaV5AMiocXwUgBkmhIKXtrtFStlGYA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wbZiZ-008nbV-Cu; Mon, 22 Jun 2026 10:09:19 +0200
Date: Mon, 22 Jun 2026 10:09:19 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: Oliver Neukum <oneukum@suse.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] net: usb: kalmia: bound RX frame length in
 kalmia_rx_fixup()
Message-ID: <4aa18a37-cda7-4849-8f29-d0aba76bc933@lunn.ch>
References: <178211531778.2216480.12637613349790980750@maoyixie.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <178211531778.2216480.12637613349790980750@maoyixie.com>

On Mon, Jun 22, 2026 at 04:01:57PM +0800, Maoyi Xie wrote:
> kalmia_rx_fixup() computes usb_packet_length = skb->len - (2 *
> KALMIA_HEADER_LENGTH) as a u16, guarded only by a pre-loop check that
> skb->len is at least KALMIA_HEADER_LENGTH, which is 6. A device can
> deliver a short bulk-IN frame with skb->len in the 6 to 11 range, or
> leave a short trailing remainder on a later loop iteration. Either case
> underflows usb_packet_length to about 65530.
> 
> That bypasses the usb_packet_length < ether_packet_length truncation path.
> The device-supplied ether_packet_length, a le16 up to 65535 read from
> header_start[2], then drives a memcmp() and the following skb_trim() and
> skb_pull() past the end of the rx buffer. The rx buffer is hard_mtu * 10,
> which is 14000 bytes. That is an out of bounds read.
> 
> Require both the start and end framing headers to be present before
> subtracting them, on every loop iteration.
> 
> Fixes: d40261236e8e ("net/usb: Add Samsung Kalmia driver for Samsung GT-B3730")
> Cc: stable@vger.kernel.org
> Signed-off-by: Maoyi Xie <maoyixie.tju@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
