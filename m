Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795225547;
	b=42Pp35mhzBhq6X0oTFXF2/ccf3llzmmXXy5ppGCy/LeNRvxTcilTEkzZHmoSeqYipRYV
	 Zcglj93DUqB4rJJ4RJ+4z34S5TaaggJ7y1M/29yZ+amv7cDja+qXq76X/hqOIFrx8F0tC
	 cUkok0NvKK1Yl40uUb0Z/IO8MZAxAHwGePvb9pf2kRAEA/zTP7alEWzxiVHpGVvn+Ei3o
	 Sr9YtLtT4ST6+T9uGbIjVwBN5/ODu16BxBjp4Y4s+kbThfAM6cO7BCbCct2/ps6GQIbJh
	 HELjEjNPQHsXLTGIsOPeRLnXyiXuVlcyU2kUqqqLiRQuuKw1o2nz4t8XpXFjQ5mBl0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795225547;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Gg0DO4l27/o8+FC5UG6Cg2wJ3YOTCzBBcLI+Ro4cbI4=;
	b=EyUhRoosrIezmy2gAIEJ7pnJctZMNJ0jW/f2v4g/a0EVb/+w+rzPIO+urL01lRnY6jrZ
	 pZ7kCr9sEw8HZXKLlMN2N1qfspJHSCrRU0JCoofzjy3Rc9J0qQqTXJtF67R5wZ6riQPJB
	 2DpVRoetQd2k/L2b5hsN6WceIlXA9TyviXy3ApsOs9VHdKIDKkEGX84o4KLsCh6S96/Ld
	 dxXgO/88JIG5dQl6uNRVMOf1HZdJmGFgYJSMgUYuacYZ2tPvVxQFzDw30mT+qrytN3bNA
	 6Wls89YPUXbc2RO9n7TkktZbQKI2CDuRQ8fyi7MTvm9cM5EonqyaPoGahrjcuRJVFzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HH6jyPtt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4495E606A695;
	Sat, 21 Nov 2026 01:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HH6jyPtt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC381F000D0;
	Sat, 21 Nov 2026 01:45:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795225546;
	bh=Gg0DO4l27/o8+FC5UG6Cg2wJ3YOTCzBBcLI+Ro4cbI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=HH6jyPttLfQZqMgeq3I5uFU+qtRlxZZ8Zya0VtA4ZJUm80dNLK0kRbANDWoUvbftd
	 EGLh7ztpYcWd8kfnjAKCKaN3+6b29uzkSbU0Ls93cS2L7toI+ttS5G8XdRr6gxiFXE
	 fCyElH166nta3vxkvo/SrPSYZdIxWnIs3aaC+ZD73If85c3YvcUSqHuuZN4YuExDBJ
	 YG7mT5tbtTCNPVCixwuqfG17c7tRS3Yriu13/OBPDgOQ0/3jS0WP77exWQHnWKTSSz
	 drblQgrANL4h7ExLkhHNp/7+Ep/xkf0xeHZwLSv3zyUCy+eeAciuYuhLzgNMs+wbN0
	 nTFqyAUSUFGYA==
Date: Fri, 20 Nov 2026 17:45:40 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sergio Lopez <slp@redhat.com>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa
 <vishnu.dasa@broadcom.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Stefano Garzarella
 <sgarzare@redhat.com>, Bobby Eshleman <bobbyeshleman@meta.com>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v2] vsock/vmci: reject datagram binds in local network
 namespaces
Message-ID: <20261120174540.37d152de@kernel.org>
In-Reply-To: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
References: <20261117-vsock-vmci-netns-isolation-v2-1-d6f35e86416a@redhat.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 17 Nov 2026 20:01:52 +0100 Sergio Lopez wrote:
> VMCI already rejects datagram sends from local network namespaces, but a
> datagram bind still creates a receive handle in VMCI's global port space.
> A VMCI sender outside the namespace can therefore deliver to the local
> socket. Its handle also prevents a global-namespace socket from binding
> the same port.

Looks like someone (silently) applied v1 :(
00f445721c7f ("vsock/vmci: reject datagram binds in local network namespaces")
Could you send an incremental fix?
