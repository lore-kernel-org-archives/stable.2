Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792524607;
	b=zpJG7Kj9Us6aR83KPPnJvgCacgabjsrqwp4Dzrq05X+EnKCmDPbAJbOUZO8pGA3H6hIf
	 XmG4v5h1tuVIqA34/Z4IdI1/NvogSNpY1wCGBX4Psr4vap7NFyrU4A2/QNy1jbNPGKV3W
	 kS82AqZ9/O0do2cs0rESRgPirDHRPNnFemhDzI31UMIBeSwhGyjmk1huEC5G5FZOIIoag
	 uUMwUtOEJV6Sy/XU8ix9x1pMlxPUdbNty9IKWPShR6Ld2gqShkImdiHa8klxgFd9HLVQP
	 gWTo6FRX7/perli3ijD6ue2pgfZMldyrsOSh+tUJE2bor0JP+FDK3Pr3bfvDLWrWyvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792524607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=wYg9cotcoU0u6A8/hr+EYwsFGArgBF9NN7BKO2SM0po=;
	b=5DZF6IBY9Lo8kI12OhMz7N5saJ57n8HByXIe3n23iw6bWUJj0e/jCAxuuONbqV6LJJm/
	 SseytcKHBcdn6phvL9LcYPvm+gSoQqC/CFaONb+aSeQMbSD1Q/x2yQBYvW/qlCWaH/bzR
	 Wtdlz4HrUky/vX9sUehV7hxWaw+YCuzihjC0omb3Tdsx0AUKHU05N1n6WMWB+xFmdEFU5
	 OdDLFMT0sXAc5XEBG4cMgo5XeKKBIZ/aKfRVUr4G8bIeh5CU5jEcI62pvocmr9NwCZL0E
	 89iplQDGt7YmZH2AXxCNkbppT/AFzRPIV3Z+nmer2u08YU0ipLx/+OSjwgOLF79pf+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlVIDa9w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8E606A322;
	Tue, 20 Oct 2026 19:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nlVIDa9w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073011F000C9;
	Tue, 20 Oct 2026 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792524607;
	bh=wYg9cotcoU0u6A8/hr+EYwsFGArgBF9NN7BKO2SM0po=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nlVIDa9wW+uOYT5mUetEGavF0EsvitauQHKUabhlYAb6qwusxhS8KE5M1t5uxENXZ
	 6CtgWcWfha3GUBpEsM5MODslh+VxjuuYO5OwwhBnAz8xsZndVB4qnjD+onfF9t4m/k
	 Yuimsl9hw0WqOKBJsS2ie90qujWCs01rLX5yzk9Lj6F16URCtkbxbYxjToW1UtGT3P
	 3O53QD56IORCzQ+sP9lkzV5PPJWDjXUdi5Y1BlGr9HRHywvbWiF02M2IfiSvK0TfwQ
	 At1B9Y0mL6BT5IHaQ1URvaCwEScR6NmgErOmNrQAYG+3KJVCB/SImnL75QnRAqOIA1
	 c0JlfOitYGesg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15B33808209;
	Tue, 20 Oct 2026 19:30:06 +0000 (UTC)
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
Subject: Re: [PATCH net-next net] netdev: Hide the netdev_priv() origin from
 GCC
 in netdev_from_priv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179252460578.172302.12338872662372096525.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 19:30:05 +0000
References: <20261015165959.i.798-kees@kernel.org>
In-Reply-To: <20261015165959.i.798-kees@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 gustavoars@kernel.org, qingfang.deng@linux.dev, jiri@resnulli.us,
 spender@grsecurity.net, pageexec@gmail.com, morbo@google.com,
 justinstitt@google.com, netdev@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-hardening@vger.kernel.org,
 yeswanth@linux.ibm.com, stable@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 10:00:03 -0700 you wrote:
> GCC 15.1 and later can compute an object size of 0 for a pointer that
> container_of() derives from a pointer into a __counted_by flexible array
> member[1]; Clang gets it right. netdev_from_priv() does this with struct
> net_device's "priv" array, so when GCC can see that its argument came
> from netdev_priv(), FORTIFY_SOURCE sees a zero-sized net_device. Since
> commit 9027497a25e3c ("team: use netdev_from_priv()"), adding a port of
> another type to a team device can then fail the memcpy() to
> "dev->broadcast" in team_setup_by_port(), which GCC sees through after
> inlining team_port_add() into team_add_slave():
> 
> [...]

Here is the summary with links:
  - [net-next,net] netdev: Hide the netdev_priv() origin from GCC in netdev_from_priv()
    https://git.kernel.org/netdev/net-next/c/56f8d919739b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


