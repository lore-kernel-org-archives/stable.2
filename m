Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795373832;
	b=qb3biJistaTA02AUacQ25m++en3SL9EZcdJn+YKrbtelzeSwDEf6yR9LKQuT6EEbB0lA
	 kdRHWTH2TzzZGi/RjEuc0hdZp0SWvVUBuYgK4QQTSZgJmfHNnwEBm9UoS+/5YyA8SIQ5j
	 8nGanhNv/d30N8viE7aPS5ETmHfhSYN78akvycnYMctyH8CWM1PSFcmq8pBycB7X/lkYQ
	 RvkRWkeRka20pS6oxDkj9EvJVOmA1/8ne4IpKdhJ3OQJztP278nN5Hk6Jwq/leXfYbB9q
	 sRr7CXtZAKBdkMbwHHKmcLOmpT2fcpFyLaxSj7+KzPqZMxEc1OphLEEWRJjpWCIY46A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795373832;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=8B8Z/Qk1nK5Bur2fvtAfwzJGSgXNSKiCnAjpMw2EVs8=;
	b=oUA06YiwJv791qVNpVprsAd6OHWzZHx/215sO8US8l9nr0QfZYzKPozqr9cDkWkvg//8
	 l3fFSk3HcM2q2/9lgQFMr41TOBN6L5s0Q/Lk1t2ycpDzmX8Q8B1m0WGsONSvzZvjOy39K
	 mqWFqCelhca8t/fldd9rQzyVS59mltgLyabw++nag4snBHAA6S3bvELGr/t5cLGeZhDLf
	 u1spOqYOTIjzGgzjEboin+AetC27GNjIZIHQJuAXYu+W8Y+yKj1F9v5eDjKx9YzvUyZDX
	 aMFqWXUl5QveGfI9XGR8UbaMjQ1iK3nnD5VtWDs+Kd6aiWneOBsn8Nyl1tCgD5z4kyg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=U0uJ3VV2;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E624606A320;
	Sun, 22 Nov 2026 18:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E624606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=U0uJ3VV2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8B8Z/Qk1nK5Bur2fvtAfwzJGSgXNSKiCnAjpMw2EVs8=; b=U0uJ3VV2VFvLy98r6f+U5S2PYJ
	aY6uIU5DawC2aNmwGsjQEQ/LQUylIdw7NupDyC7brvskQK5VDDZxee/2CjDaJRaPDrSfbF0reSgsK
	2Pq66Jyz2qD35vyeU4FWOp7dUcKTwnFByWT8aRQIvGcBFWnwF8jfuvSiiYUgbvlNPMbQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xVCkA-000bb1-BM; Sun, 22 Nov 2026 19:56:54 +0100
Date: Sun, 22 Nov 2026 19:56:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: aiyengar1990@gmail.com,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	LABBE Corentin <clabbe.montjoie@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Nicolai Buchwitz <nb@tipi-net.de>, stable@vger.kernel.org
Subject: Re: [PATCH net v2 2/2] net: stmmac: dwmac-sun8i: Limit the MTU to
 2018
Message-ID: <002c36a6-c049-4ad3-9b1f-18f2162eaa71@lunn.ch>
References: <20261122-sun8i-emac-mtu-limit-v2-0-c4081e5b83cf@gmail.com>
 <20261122-sun8i-emac-mtu-limit-v2-2-c4081e5b83cf@gmail.com>
 <CAGb2v65_vY86WqvKr1m=g0N1Qr2UhLC1v3OHKPG3x+oURUKp7Q@mail.gmail.com>
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
In-Reply-To: <CAGb2v65_vY86WqvKr1m=g0N1Qr2UhLC1v3OHKPG3x+oURUKp7Q@mail.gmail.com>

> The STM32F4 reference manuals has this note:
> 
> Even when the start address of a receive buffer is not aligned to the
> system databus width
> the system should allocate a receive buffer of a size aligned to the
> system bus width. For
> example, if the system allocates a 1024 byte (1 KB) receive buffer
> starting from address
> 0x1000, the software can program the buffer start address in the
> receive descriptor to have
> a 0x1002 offset. The receive DMA writes the frame to this buffer with
> dummy data in the first
> two locations (0x1000 and 0x1001). The actual frame is written from
> location 0x1002.

> So for normal descriptors the buffer size is bound to (2KB - bus width).

There is a second use for this, unrelated to bus width. The ethernet
header is 14 bytes in size, 2x 6 octet MAC address plus a 2 octet
ethertype header. By offsetting the start address by two, it means the
data after the ethernet header is then 4 byte aligned, making it more
efficient to access fields in the IP, TCP UDP headers etc.

	  Andrew
