Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795769407;
	b=2Zong9IOj3tWNGyHZNLbpGl/VDhGWWSzwHDNEWd6o3q0Vpa53sjafrlY58236qHu6EQF
	 BxxyCk/cbiaJRvB6pdM2c9LI9nSpCwvpFU8xNRkZ3TWPLHXKsDkbrDZThSBr0zVoBs6cA
	 zg467YU6Ox7Snm77EV5vf3f4n85HhV0TBqFghvCz9JlinyKPLjy0nDu/DZpPlPkRfoKn0
	 eyiW3w1vq1EjmJ5SXshHRLrzj4rDXPh36Pe3pHaPHDYuJIZYeBzNwr0iI7YSKYgoPmPK7
	 zPeHoTECqEJvlfebKAoViTzo+Vf90Gc96ZAZoaBueZeafQKUkF78wq2Wn7xwEMbuTSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795769407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=FwpufZCw+Xn7S9e1kafrdEzrsvtMwbuoxI1+UTWoOug=;
	b=5mG6c+lqWC2EmP+LCSR94sqdw0TgIrti7v1e4ht2nVsWlKCY3Zr80KEr794uOEnNSFnW
	 yypAR9kfeCRk7ESRh6CXen4nRK+xrHuqRzTGtan9Q7cgrckmGaRf3R326rH7RQLKC0r10
	 avfKpmgJETQ21UOpp8JKT0/nsHbMVbdnpUCAj2MnCny7oqoBJ19DwRqcwy9w14XoOKsb3
	 2XU5Hb4fzm8femP0gP8PkasCaxo456sAlQqwAsBBcm/cLjeR95ojpENkZnln5159dQ2g0
	 lCOsa1QV9zm7zt/MwOoPeZUX+z0dYmrBbYatmLIo9keTGMIFvjBtCv8c5cVrMyZnTcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMsmkA6X;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79534606A324;
	Fri, 27 Nov 2026 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HMsmkA6X
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5E21F00898;
	Fri, 27 Nov 2026 08:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795769406;
	bh=FwpufZCw+Xn7S9e1kafrdEzrsvtMwbuoxI1+UTWoOug=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HMsmkA6XbVmrn2kxU+d+0yAtYT0iKjQD6V8KS8PcsYgFSoDUkrTEx+em15W/0qX8D
	 uDjccSRcLp14MyJDJcSWiLMd93pEgWMYcsDFudalrBWOt3x/o2yZYbsfLNu9sNBu8j
	 bL8F2mTLesXQ0uTC1VidPClAHvYfnd9R5qWgMNvBXxKL/MEktT9vY8rO1zWYvjzvkD
	 astlmh2QgHSDEAvbKz5Z6V9MECZQrTYhD5cEnG/3A0Gv5qDv06IE/a6w585kfqqC57
	 A8FUAlqiJcDxypkIuvPwU5TIKrLkbpQqcKMAoH3YHXe/2RWIkI39vXJxwMcexixfJP
	 bXKJcKzTaZhMg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 718E5380044F;
	Fri, 27 Nov 2026 08:50:06 +0000 (UTC)
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
Subject: Re: [PATCH net 0/2] ipv6: fix IPv6 scope check of the source address
 in a VRF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179576940525.841859.12748371355867383566.git-patchwork-notify@kernel.org>
Date: Fri, 27 Nov 2026 08:50:05 +0000
References: 
 <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
In-Reply-To: 
 <20261123-for-upstream-ipv6-vrf-saddr-scope-v1-v1-0-f667ab150ade@free.fr>
To: Vincent Jardin <vjardin@free.fr>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org, nicolas.dichtel@6wind.com, shuah@kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 23 Nov 2026 15:30:42 +0100 you wrote:
> When a packet is sent through a device of a VRF, ipv6_dev_get_saddr()
> first checks the addresses of that device and of the VRF device,
> and stops when the best of them has a scope that fits the destination.
> 
> Since the commit abb9a68d2c64 ("ipv6: take care of scope when
> choosing the src addr"), the check reads the scopedist of the best
> candidate, which is an issue:
> 
> [...]

Here is the summary with links:
  - [net,1/2] ipv6: check the scope of the best source address candidate in a VRF
    https://git.kernel.org/netdev/net/c/b026cc5ce2f1
  - [net,2/2] selftests: fib_tests: test IPv6 source address of a VRF
    https://git.kernel.org/netdev/net/c/c83fc88d628f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


