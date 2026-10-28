Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793179206;
	b=h4wOoJjpQnTS6hBWg7/VH8Km2aA9Yv7GiMu/8yrI1hXnxbtPmqb0/hP0sJsqF8r8p8xV
	 Dh4Ch4fC42fPfvVjrHT5zPoMYcKK44eWlQyC3VpsKL0PeTonBgtfGfROGoxFl8If1X157
	 t77gDQ4bKKXIxMyzkA+vzc6sWeY9W7m1H1/TjwT6EPvp4I5hPVJVX9kGrgSpKfkrdWIQt
	 357QwyUB74lDxH9prREr4o85DZPgq538AgOuSgt5wvH5Gg5IErLMCHNFSspeDuv0EYgKd
	 yJuX0G0D2ECBTBwyU42gd/MBdEPeXRNJSxzURDzrq74iRlH4yt24EVTm+17I0U/2q1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793179206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=mYHauZwpKDroy8kXTCCWy6p2Ztad/9t5QyzrW8JTqDU=;
	b=eJPj7vhcyuaks8qtAm7bfMeFZvV+1mqBFnK2Dj+tLYny79kp5S2HQT/zjMGIPop4OgqE
	 dqu+lpMOtbgF3WPkymc9AX6rOaBMesyR7ZXyyWtKYEPDo6NI01iyTcEswM4FeU3GHIF3W
	 /yvrpdmE1qlMQma/Z92NSuv6EM6ZlWfvUKj1NZbUKgaXYriVXURs/1zYfbUBIQgh9cnOg
	 WNEBkbXW5lhnvS8MdraNKteT8k6MEfc08/dC7qezRvWvJyKStK09E18XUVEidsAq72KuV
	 VtCSjgHe60YqKRNqNz/Y5gPI6zrEo7+d6lN8Iu5TDM8iCzu6xALKyHjHe6W3zdNJNJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FroIHhB0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4A1606A31A;
	Wed, 28 Oct 2026 09:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FroIHhB0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8101F01829;
	Wed, 28 Oct 2026 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793179205;
	bh=mYHauZwpKDroy8kXTCCWy6p2Ztad/9t5QyzrW8JTqDU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FroIHhB0s/FrJvEcpbL7jkbUeaQ547Wu4il570YC+kZBbqTWWoRqpT6adFJ9OA9BM
	 fmuomL3ChDPKOVJxg//DzZEQ+Sb8bENvIuEf7MQmpk6Wt4jfZuheTjpq6cjx53fvdc
	 WC9OBz1AhAwyZDcsAHjbG2kDhV+C7cKQ+GS+xhAFzxK5oY8+OQdYXiqUhumv9XCZt7
	 47EgMqkbVxP5A16r40zfY349M2Wpif1UGBGvVOb9c98lpejDR0vj4XV6a0E32LatzM
	 8mo5H1k/rkZlEMMgEVUqH55zVDvhMLRgxGsqV5fMnXwGduOxUVsM8olXjZgPuhr2Y1
	 im/GeLMsJbUeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 444F73AAA0C9;
	Wed, 28 Oct 2026 09:20:05 +0000 (UTC)
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
Subject: Re: [PATCH net v2] inet: frags: prevent acceptance of partially
 authenticated reassembly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179317920407.601115.5649462867924698317.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 09:20:04 +0000
References: <20261023185118.2588450-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261023185118.2588450-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
 dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri, 23 Oct 2026 18:51:19 +0000 you wrote:
> A reassembled skb retains the secpath from its first fragment, which
> makes it possible for the final policy check to accept bytes that were
> not covered by the transform recorded on the skb. This can affect IPsec
> tunnel traffic, including AH and ESP, and allow a packet to be accepted
> even though only part of its payload was authenticated.
> 
> Reject a fragment when its secpath differs from the fragments already
> in the queue, and keep overlap statistics limited to actual overlaps.
> 
> [...]

Here is the summary with links:
  - [net,v2] inet: frags: prevent acceptance of partially authenticated reassembly
    https://git.kernel.org/netdev/net/c/6fb4e32f2ce3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


