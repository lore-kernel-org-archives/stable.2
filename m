Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795142412;
	b=Vyyqa72Z7grDo5V8Y+omBLAEl6tmQ0SwxgSQ2rvyZOc+x357cOSTP49Gd7RQy4QZt0cP
	 vy0Ozol/RHmD/C4bIp1csp/oV4lFu9UQVwwPaIlz6x2uvRT+6QS5RLpuklAqlxCYpR8qg
	 NnT6RvyNrQePppeHleoatX0VGeb1KfbS9I1LNgVHiai2kAGhoUlUpiRuFbgDWv+Wu2Mor
	 MqnlF+X0ahuOVIyEN3lQBQmjoXkoNrWlaBrq0YV2jleCQ5Z0u2UiX+MrBi1Hi8n1glLWy
	 hj6FxAYHi3Jrrh7WnjP8dXehTMQiXmOxN9vLYe6KzZMOttuhZwRqzhclPMWHgsqpwZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795142412;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=VOP11MsXC4XqqMFXsauRTKJZG7dhWSQWYPs1r9JpjKc=;
	b=BO7GvyyKSXytOPtK2vgM3oFxYXozIoVAvsVnvpEMmhaNEr8lURbf7zGGTUt8dVclM31u
	 rAY4o5aCUqqQVs94RLGB5oc2i5smtIjqnQMbQEXhE9k6Ds/R831e3heyma8Dz5UZb0Gh7
	 cvOoV+/JxJlExl3hvNt7t3KisXS87a/XoFBsX4ucpxLFWPyfdAH+zGZwNTLmj/bheF4a7
	 HfX/NxjIltbixBBxrJBwYLCqgO7qHew8A9HLJlaseXCu0xLl1O9SbvrYinGfhOR+wdnMU
	 0Uk+57/6kxJD3Z68EA8qG4yA/wZHalwusu6E6qnjY6Y50paUpCvJABi8tFdooQGH3Cw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHZA2bRV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2E606A320;
	Fri, 20 Nov 2026 02:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nHZA2bRV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 059731F000C6;
	Fri, 20 Nov 2026 02:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795142412;
	bh=VOP11MsXC4XqqMFXsauRTKJZG7dhWSQWYPs1r9JpjKc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nHZA2bRVl/4h6FTNp6IHEe8Dt0P7y29W9tQYEo1/wWvyi+TeSbDV1QPvN55VtQWGl
	 U867PaUSdm4CTELA7PeEDLnpXLzm1kNNMow2/iBS6+YUFDanKMPQF5Suws/9buxJkB
	 wUvIQc3tBYwBW5gPpbdYfs//9BJeRXCrERR4QWZfoJIwYYOXVgR5qugwofz+ULlgNA
	 e0X9eWXUdv7cmgofXXJfHlHYTBqrMyF1Z8ZMID/chQSyFy+/fJIUsYnyTxGtJZwd65
	 6bnai+CaBPkR88CnRLWxy0BoOHi0HFsWDqa5rKdQ+6sTx/1tlOST+dTSOTMq0ACCWE
	 uyBmhib5S4K0w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15FD3808209;
	Fri, 20 Nov 2026 02:40:11 +0000 (UTC)
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
Subject: Re: [PATCH net 0/7] mptcp: misc fixes for v7.4-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179514241052.3989712.5106945987218104039.git-patchwork-notify@kernel.org>
Date: Fri, 20 Nov 2026 02:40:10 +0000
References: 
 <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
In-Reply-To: 
 <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 fw@strlen.de, dmytro@shytyi.net, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 quanyeyang@proton.me, petar.sakic@ink.fish, rameshkumar.t@phytecembedded.in,
 mason@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Nov 2026 23:06:07 +0100 you wrote:
> Here are some unrelated fixes:
> 
> - Patch 1: do not send data beyond the window announced by the peer. A
>   fix for v5.11.
> 
> - Patch 2: push pending data after a sendmsg copy fault. A fix for v6.1.
> 
> [...]

Here is the summary with links:
  - [net,1/7] mptcp: do not use a raised snd_wnd for the send window
    https://git.kernel.org/netdev/net/c/ec7cb74c1a7e
  - [net,2/7] mptcp: push pending data after a sendmsg copy fault
    https://git.kernel.org/netdev/net/c/68f465e3d9ce
  - [net,3/7] mptcp: use sk instead of casting msk in check_fully_established()
    https://git.kernel.org/netdev/net/c/bb6081907c60
  - [net,4/7] mptcp: push queued data on passive TFO subflows becoming established
    https://git.kernel.org/netdev/net/c/d7c650916aa1
  - [net,5/7] mptcp: push queued data on subflows falling back at the handshake
    https://git.kernel.org/netdev/net/c/595b7d49d4f1
  - [net,6/7] mptcp: don't send a FIN before the pending data on fallback
    https://git.kernel.org/netdev/net/c/d0e88ecfae68
  - [net,7/7] mptcp: fix dummy mapping of overlapping segments
    https://git.kernel.org/netdev/net/c/3d064436b287

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


