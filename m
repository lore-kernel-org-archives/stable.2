Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794502807;
	b=dgaN/9WDisVUI/z0dGoMA0OGhOYY05yq22uiorWohNSUOznSIlq87RtxmvXi8tx7+n9p
	 A37SgIe97kMcQcyCzDuY4HlQeM1SQSgqGZql6C3Df5yuL2SrUee8fyTMdlpDCTDXeuGNE
	 ibl7vM2iCAv6sQu0F6dlWDYJjCS8ZTX3heX8hSegCSkZ6+N2VB4m04oBgYD6sRbQj79XF
	 iFsnJd9ceRddYBB4XQa2P9PMIntnxtsal+2UwETGSNGTgrwnlqG4LckEqhUx7kz+9OXKf
	 d02/3mbEeE9vR9zGeD4ltxvNJ8TckcjO/gwZOhElqrafmGMtntOa9WUtoHHCzqaC5sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794502807;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=2t3rma/Ew3CnXoPjdRN4C34eFYI/aS1ma94AQq7BCFM=;
	b=QVGZhOa8EPcJQlp/uXbpYgckPiK6HwR8V61qdleUrb6aLyXGW0ZEIxwx0Q8icF6XPWfe
	 HVG0xuqgjGvR5aJEHMtKUWUUMQ9+i6Ko9ql9+WOpaT262/OwDDoaCspbj+o077t469vc4
	 TCt90NFvG0njJHsNcZAfYlrOtN921hqAwDrKCUyaC+CUr6JtxDuCj0p3IycEAn8EsEPY+
	 dp/yGPOlrCyBktuHLOBFYF5pY5BdrlW6PSffCzXnTXU+Gc6kDgVVVyVun344fsftVkgb2
	 e/7MBMMPfIpul2C7qDEUHj2QkSF1k1N08MggA1xZJ6c8HAtyFBHdgo8Lx6Vl9U4CzXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVIbPuJp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92818606A32D;
	Thu, 12 Nov 2026 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GVIbPuJp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C936F1F000C5;
	Thu, 12 Nov 2026 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794502806;
	bh=2t3rma/Ew3CnXoPjdRN4C34eFYI/aS1ma94AQq7BCFM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GVIbPuJpt2daDa2Cmj4ciL9lXYBHUbxhVyQh/XPnkYNB+9PVo7WLwwVCbZgUN2l03
	 xdA++VzAKpIHN0SxKrCn0RLLElp7ADLuPY0LaUYM3C1unsoYSfbtDKlrF2bXga4RQq
	 zjOymZqbxxfPot2XudOH6gnGQIaOYqQfAR91WdVCmFsoaQFvhnQB63PX+1YVT8i1I8
	 BbALjaArVnhmELBkEpDBSAwA9hgGjxnuKMItexDxOxDI0ur2tCWig8jFi9qzydU2DN
	 lDry8qnMsLBizxglkuUtZepM3mjyZfkw4nh6tilwyXpyVCQUEcTUvOv+gxn6mfsMwp
	 GDsd3NdNJP54A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B42CE380AA75;
	Thu, 12 Nov 2026 17:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v3 1/2] ipv6: fix cached route reuse for control
 messages
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450280527.175938.11721831202062050976.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 17:00:05 +0000
References: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
In-Reply-To: <20261109014400.9025-1-yanxia@cmss.chinamobile.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, willemdebruijn.kernel@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org, willemb@google.com,
 tpluszz77@gmail.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 09:45:25 +0800 you wrote:
> A connected IPv6 UDP or ping socket can reuse its cached route when an
> SO_MARK cmsg requests another mark. A packet can then bypass a prohibit
> rule instead of failing with EACCES.
> 
> ip6_sk_dst_lookup_flow() reads the cache even when connected is false.
> UDP clears connected after parsing IP or socket control messages. Ping
> always passes false.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] ipv6: fix cached route reuse for control messages
    https://git.kernel.org/netdev/net/c/f778e80b3daf
  - [net,v3,2/2] selftests: net: exercise SO_MARK on connected sockets
    https://git.kernel.org/netdev/net/c/6785ad21822c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


