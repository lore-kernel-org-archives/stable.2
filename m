Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794355208;
	b=K8orllu8syhrRJmM7sRyAE3oRcuSn7381IU4UFDzI+GMdlpy4s/yHC11bi3a51pOaQxR
	 IdqvuH4h3eXoPZpS9uTLXLJOSe/jFaWHVP9vxeok6PHEq6LpYOsOXC5+8fvp/v5j5iiH/
	 wkgAd09QcjVyjnMm9sCOVFc5s05QKfYVj/491UQyYd1Te41iii/YpiaklH/FWfv6P6lFM
	 A+GdjQXWWmQCq07uO7H9djgiVMU0pNaDHDTKw3v+yPbneUF9Vs8AgyuDzREvZHqY+QOWD
	 UpzXqov/WfIkZrtYF84AzXPGJKGek3VJSO8Vv4RA46+Rw+U/U3DVhf3A3928JcmSWYw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794355208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1xI8mFsWhxaCEvah7c5AwxXHf7+I7ZH4XAbMp+s2uPY=;
	b=ayd7WY4Y1irYjo/ln6YcYX3i+F3mUSMGDRrlE4UxbVxbM27RoE2AVsE9vQjcHplAIxJU
	 ZaFtCGXMHkw8p2CZpiBmKDv3E2lFn6DkTBz17El271b45XhWe3VBXGCqwtWXTe1oFr6mf
	 U1PcbJOYs+rREYcYkd1Aj+yf2FIbtxTVlncuNHTBGoCafu/7IqyZic4aTEjVKOEHxJZiP
	 iRK23k/8iDWeXqkEsmpUrsifUIdT2oLE2Qi1uKNijtfa6xn9Bgiri/q4aYl+O+dcydEeR
	 MC4J9JGSAe1L1iwEdU0RP/cj/M1vzCYvK5yac015cAPCrddr5HvwTx5e/mNKO8s1gfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdZBEnlh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7B93606A321;
	Wed, 11 Nov 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MdZBEnlh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9E3D1F0089F;
	Wed, 11 Nov 2026 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794355208;
	bh=1xI8mFsWhxaCEvah7c5AwxXHf7+I7ZH4XAbMp+s2uPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MdZBEnlhlQjwwbZGiW4qyuZG7c45i4MFFVYcafh5BisGgMhZfCX6LWWkKQ1SeauKC
	 dt/OsB1ASS8WKH6Tay1wyGNByhObs9KHydrUb57vAmvcGaCG57cwCKnsQwvFNwXfQ8
	 guUCXf59lH58mjL+zhVW3ajyUQbo+4s3+P5Eqc90UA6C94fTNcXnZlXfUYZP/38Wu8
	 9atR5i8P6k6urSuQsP/EfxbJDLoG3g8UDrgmfew1YbFblV3KW08fHs8Lo0nrfodYWz
	 aIFJBwRCrs8KkOv3CkGsrzUouGQzHqbzr0zeeJ4jMVF+SiIF8cUxjvI+/z8AuXKaYT
	 YZ+x4RlsC0lMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D819339E8A4C;
	Wed, 11 Nov 2026 00:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mctp: accept MSG_CMSG_COMPAT in recvmsg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179435520668.125436.11446104566062480316.git-patchwork-notify@kernel.org>
Date: Wed, 11 Nov 2026 00:00:06 +0000
References: <20261105160704.2546031-1-dave@stgolabs.net>
In-Reply-To: <20261105160704.2546031-1-dave@stgolabs.net>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, kuba@kernel.org,
 pabeni@redhat.com, anisa.su@samsung.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 08:07:04 -0800 you wrote:
> 32-bit userspace running on a 64-bit kernel is unable to receive MCTP
> messages on an AF_MCTP socket, even though sending succeeds. There is
> nothing for MCTP to do with it beyond not rejecting it, as af_packet,
> af_key and can/isotp already do, for example.
> 
> Fixes: 833ef3b91de6 ("mctp: Populate socket implementation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> [...]

Here is the summary with links:
  - [net,v2] mctp: accept MSG_CMSG_COMPAT in recvmsg
    https://git.kernel.org/netdev/net/c/350e1d0d3b38

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


