Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613606;
	b=Y7NR9Rx4WQxUjSev1DgKo01/iNvYYQT8koJ75G/tSEAQ0EB+xaFFBgJ4pv/xGZ7rL2y2
	 f7AVjNGJP5oOEpb+xc1l+FKBk8ohysn3sNA1ExJAdRzhvQNVtgHIpFtMLBemiu0uYr2gv
	 6vOonSdXk/GKI1ncXtjflEM6u7ZzlTb3DPepDKpSqIbW/zZqQuEE4FaBjLvB4o+PU3B6m
	 BRU2HRp+rPp+CrewwHqfHzXFF9eH9KPomhiCppV7+ypkcqlxrGchRExvaPkRDFOTZgIdv
	 /KS0LFMoonD6bYi2XfAGe0RKYotIJ7WSHSoL4GV9xhmBiCu/mtD/c3WjTA1lwNGDLnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=ycSP4BP7IN/HYEUUAZJE22/srTDwxFMfS48u7Bhri5Q=;
	b=FAGXRt5m3DRjD8HXVcsxwIHvXGVXTMTr2DE+mdqtrKOMtwgAWBAQMiS8XkMv659Ji8Iq
	 sp94Z9fbLEqY4VYZDQSZd+kb6FzfrXAH4UMJt0iTPDkxpVg4zOYrzaMFrOqY5J+x+1lsn
	 TWtjWCnzSgBOMsh6zLGcV0hn19y17ZjxhnNAYaBk9Mvvacu0kFtZd2JhaIqYCgEysxCwi
	 1gjRTG2Ox/pwWhhR2DMBON/SLGFWIrtimxlreZRbK4NefHzQpB6uLIPsB+cNqKtfXVHvG
	 EFkLw3JSUaEAmDSoBuHpivu6i1AP/MkKciPqu+h7iceHOKrPGAY9wId3ke1Mkyz1Olg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPlcSFcG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B047606A326;
	Mon,  2 Nov 2026 10:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WPlcSFcG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 111DF1F000C1;
	Mon,  2 Nov 2026 10:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793613606;
	bh=ycSP4BP7IN/HYEUUAZJE22/srTDwxFMfS48u7Bhri5Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WPlcSFcGljgmoVdQKBFyGrzHlN6n+5/24y9zRbs4lif8ivVx8C+V1oZBtp8qKhMQB
	 tiPOef5xtS+erbjYDDN8+cLYE3HjihiHip+KbpYrGjvDYgjDi37IPsa1utkA5HxCBs
	 OR07fUyfsbABWw0/RqTfaTziLCj6NxDkd8zwsJLm9m+K9QRyU8ldgDGw0fBLCpsKEo
	 lM4BXYGx3T6rU1R9eYK4RIyfMYv+Oj4l2CxNNh/B/0eDrgz9l9AuD3eXnuKjYe/Ddp
	 G1vh5ACxVBpkBOSkvWqhl1+pTVWPgZBatrSWvX0VNKOraisLdhMhRQ10TDDAHFpLrv
	 1oIVNPDxI0HNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 03149380821F;
	Mon,  2 Nov 2026 10:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v2] ipv6: fix fib6 walker UAF on NLM_F_REPLACE
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179361360481.3909240.670465426010441805.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 10:00:04 +0000
References: <20261028160018.73299-1-cenzhang@linux.microsoft.com>
In-Reply-To: <20261028160018.73299-1-cenzhang@linux.microsoft.com>
To: Cen Zhang (Microsoft) <cenzhang@linux.microsoft.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 mazziesaccount@gmail.com, greearb@candelatech.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Wed, 28 Oct 2026 12:00:18 -0400 you wrote:
> fib6_walker uses w->leaf to remember the next fib6_info to dump, so an
> RTM_GETROUTE dump can continue there on the next recvmsg().  This
> assumes that whoever removes a route from the tree also updates the
> walkers pointing at it.  fib6_del_route() does: it moves w->leaf to
> the next route.  The NLM_F_REPLACE branch of fib6_add_rt2node() does
> not: it removes the old route, fib6_add() frees it, and w->leaf keeps
> pointing at the freed object.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: fix fib6 walker UAF on NLM_F_REPLACE
    https://git.kernel.org/netdev/net/c/23fec4bd7690

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


