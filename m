Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032316;
	b=kXvoA7kRH1T+CNkszvhRDIsXud1OjyuA8F8RMxSPkO1TafdMOcIXVgPulVB1k8s51YJY
	 PwNtJGlbMlUCxpQed5DF+JecvDX8kbEnAjjyvtoQu0x009/I6UJ423Gkufelia4O8E1pV
	 boJ4V0Rk1rs4/5RBf68ttJlTp15fbC5Vf4DdsqPyz1Nq853G70mtF1Ty0FDaE3o9WfCm0
	 USxwwcADvAnEycQbE5S+OXcTQ9VITa5H71qsSp0oE0jgRbkvaIFRge3QaaZWZgYaYjYvK
	 EguaKIadyBWMVE/IzKUfODsU4NXJnZtAroX2QuDseMb6iGFTvLWMXuae+41e0hcvpSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032316;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EX6gG5Wvj0qVG3HfMkha93w8i3Ry9QCHdZsr2wWz3pk=;
	b=DXIVY+6/syEKupcHlNajoV6lmkr7Z1SlEl+liSgLECQsGDTVjPeIbt20uuhidKYQJ5Xy
	 cJr0prsC5Dloyu4SVuvK3Tea4//eilOt/hywOo7eu+n8hXlalzigPw1rJHsF4Ps2zLjAQ
	 mGkiHvY/m6exWKn/15ktby4xAhdqTekR6ZcH/+6oa3mTbyp8XdFzwAzPKHYO1z3lhnn1u
	 5fN7iakCIqjw18fEbrJIleIw7YydyNBEoaHiJNavmTMjhevu53g5EJNlrsqI0jWf7WpN+
	 0UR2TLCg6wlvoFX5Ke928rjA7u0+rvdq/su6Qtz+cXj3/ENrrGsZqIpO3HBGG1tNu1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNDLLxso;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70A89606A320;
	Mon, 26 Oct 2026 16:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZNDLLxso
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCBF1F01825;
	Mon, 26 Oct 2026 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793032316;
	bh=EX6gG5Wvj0qVG3HfMkha93w8i3Ry9QCHdZsr2wWz3pk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZNDLLxsora9vn+jug1S4dBNpkXPYzKMYU9pyucQpvsnque/2Th7Cdycj1vzP7RVAI
	 QJ+FCQvQmUnjs9Pf8DlYMw+/xWzqS8SSGA8TmC80tKtdikgDrnCuFrntkOpRt3jmx8
	 LXEe5zS43iuZr+3W4t2FfpdKxtDKgUBlWNTbtyRACIb67o7sYr5thpofjc87FX2Hud
	 4+2KYHisxmw0Kh/qdw/NckibVvtb8Pq3OCbaPh0OXsGKjN/CikcCeWvKxWxaE27nu+
	 6kK+Vo6DhVxkcYnDihli2zBxObTY7jTQ//iDrwGjVmixKxdoM2UCpeo6S3tMan9MEJ
	 FYVFp3KnLzVEQ==
Date: Mon, 26 Oct 2026 16:31:51 +0000
From: Simon Horman <horms@kernel.org>
To: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
Cc: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wei Jie Law <98lawweijie@gmail.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: usb: pegasus: check rx pkt_len against
 the received length
Message-ID: <20261026163151.GC257209@horms.kernel.org>
References: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
 <20261021020310.34045-3-law.wei.jie@gt.tech.gov.sg>
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
In-Reply-To: <20261021020310.34045-3-law.wei.jie@gt.tech.gov.sg>

On Wed, Oct 21, 2026 at 10:03:10AM +0800, Wei Jie Law wrote:
> read_bulk_callback() takes the frame length from the device, from the
> receive header on the 0x8513 and from the trailing status bytes on the
> other chips, and only checks it against PEGASUS_MTU before passing that
> many bytes up the stack. In two cases the stack then uses bytes that the
> device did not send:
> 
> - A device that sends a short transfer but claims a long frame gets the
>   stale or uninitialized remainder of the receive skb delivered as
>   packet data.
> 
> - A device that claims a frame shorter than an Ethernet header gets
>   past the check as well. eth_type_trans() takes pkt_type from h_dest
>   and the protocol from h_proto without checking skb->len. If the
>   transfer is also short, those come from bytes left in the skb by an
>   earlier transfer, or from uninitialized memory.
> 
> Drop frames shorter than ETH_HLEN, and frames whose claimed length, plus
> the 0x8513 header, does not fit in the bytes actually received, and
> count them as length errors. urb->actual_length never exceeds the
> PEGASUS_MTU sized transfer buffer, so this also covers the existing
> PEGASUS_MTU check. Valid Ethernet frames are at least 60 bytes long
> without the FCS, so they are not affected.
> 
> Found by code review with LLM assistance. With an emulated USB device,
> a 101-byte transfer claiming a 1500-byte frame was passed up as a
> 1500-byte packet before this change and is dropped after it, and
> frames claiming 0, 4 and 13 bytes were passed up and are now dropped
> and counted in rx_length_errors. The extra bytes happened to be zero
> in the first test, so disclosure of actual kernel data was not
> demonstrated.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>

Reviewed-by: Simon Horman <horms@kernel.org>

