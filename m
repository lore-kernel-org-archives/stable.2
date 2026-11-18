Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794966010;
	b=IGACKO8I5au62/I39So4YHPJPfQfRRX14LxYPQV/Ctcg7MtYvD/cNacJlHbp0AsXwROI
	 x7gqV+3zDq0Nn4fiQrA8O2sCNgMuE+JxrSDpo9HOK6Hg8YrRuNJTa5xPLxFf/YQy3+QVh
	 qXrB/UjYrfXXPUiQ1jpreWej376+LW5/wxqwNHxiatbw58SJTxEapHIPOA49nJiHD6Yyz
	 /K9yp7kLAEIGcr2bH7vhy3yDvaNn9jsWNSWResMO0ZiuHikEYHXki2OOPByXoHtaiklkn
	 WNGgyNoZeekLRx8z45HBLKtfzfM5d4UWf4oqpuaglJJ6OUTzEgvZlev3dDZok7ofqRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794966010;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=QIVDHV5NYJPGkEJel2geQHbQyU3yy/pVdlufAPrIa0E=;
	b=JjGOtU46gz+uMhjAfe4KMC4U6YjzlW2+Mj1jRIp5ZGv+xIIJSC/AwenJegJcF2auVXJH
	 vs4s7I6zgWB5zp9gyLEoW1FkQYGwK7MHUfVwdnZpWzf0tUpqs62cfYu6gVfrq9eDHrtcF
	 yxuZJuLKs3avzewBLQ35STJEQb6lx7G0lJSlC4iyZMIxxcyks03n6TeCIPmekBkkoUUgq
	 vjmm2Kk7LUNMtpYOjPAZwuuncWtI6c5T1o5BXgR7hz/eZhqkw5od8IJvui/4sJBYYeWIK
	 0R2PclIhymnRJVCSApEm+9KnGyeVDwlF9KeS/AVtpcZBVoELQBqn8eQNpZ/k/HYkJGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dX0My12M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADA5D606A32C;
	Wed, 18 Nov 2026 01:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dX0My12M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42E421F000CA;
	Wed, 18 Nov 2026 01:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794966010;
	bh=QIVDHV5NYJPGkEJel2geQHbQyU3yy/pVdlufAPrIa0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dX0My12MISuZ9vAgCNO9uN96m0mvmx1Cu39AIQtzzGrzkiyiCZj8/hyev40z78hDg
	 Zs/a49sXojm9MsYa7P84lXcu0vp65BHCjLhO1Iaa8XKrZGEbjJwSVQC95PquRSUCkq
	 jYo5724s7nhHZP6K7lChSy2hhOM9kuuURouHXQpFEtdcAybkGZpNngfo5aKsKpk59D
	 fqavV6Qv6CNunOXvMelJ7SeXuTrZbdNVMcvUKOvzJe7uE4tbwJGk7IskF7SBoJgR3M
	 1qHMhWkcc+LABfwA1cgqPjqlvCNBQEnv1yiBK/4QW89Sw93SqkVsEjYdtx+cpOsXVd
	 sy0P4FlTzyn9g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3D7392B1FE;
	Wed, 18 Nov 2026 01:40:10 +0000 (UTC)
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
Subject: Re: [PATCH net] net: gianfar: clear the pending Rx skb when freeing
 the
 Rx ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179496600877.1396957.13399889673438703423.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 01:40:08 +0000
References: <20261112143140.1395197-1-anthony.pighin@nokia.com>
In-Reply-To: <20261112143140.1395197-1-anthony.pighin@nokia.com>
To: Anthony Pighin <anthony.pighin@nokia.com>
Cc: netdev@vger.kernel.org, claudiu.manoil@nxp.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Nov 2026 09:31:40 -0500 you wrote:
> gfar_clean_rx_ring() keeps a frame that spans several Rx buffers in
> rx_queue->skb between NAPI polls. When the interface is stopped (close,
> MTU change, reset), free_skb_rx_queue() frees that skb but leaves the
> pointer set, and nothing clears it when the rings are set up again.
> 
> After the restart, gfar_clean_rx_ring() picks up the stale pointer. The
> first buffer it sees has RXBD_FIRST set, so the overrun handling frees
> the skb a second time. By then the skb has usually been reallocated, so
> the second free releases another owner's skb and data while they are
> still in use.
> 
> [...]

Here is the summary with links:
  - [net] net: gianfar: clear the pending Rx skb when freeing the Rx ring
    https://git.kernel.org/netdev/net/c/c35761f43c58

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


