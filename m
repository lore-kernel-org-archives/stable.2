Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C948B219FC;
	Wed,  1 Jul 2026 00:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865238; cv=none; b=a8gjReFo99C988Y7P+3vz9rFdwFa+iHGyCXzrvZTeCBXqrvNebQUD5RRhu31Fd7qve7CzQN+q+OJkux8TZFxfAYjWFiEiKCyAOdgVaxFhNmPww2Z0m4z5YX79Gynvu6iGB/pExmvZcFAWQgF8QQM0xb2g0n7maydoDUFTsxAUXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865238; c=relaxed/simple;
	bh=+MtWZEI7sL4Gq/hiLtL10JPVTljMjqSYfZ8RhHj2i3k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JBHFiPTUnQ3bKAXsKrsoVc1AMFIDRO9DVUryU/VwJCPfIzMXF4w78FHNVqrpqnpyFmk6X1fg3wvR0+mHVAOZ796aKn+HFcidJfzn10z1zQNpYKLfhfvKCOkAevANcsvxOFXkwJYEulQI26G0F5PACgnymfJ1LFao6eyWcfN9zIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ObWHs0AG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ObWHs0AG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BF351F000E9;
	Wed,  1 Jul 2026 00:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865237;
	bh=8ha5HOs0BA1n/WIGjOEKvG8bb7gqGwHOZP3aqkyKxe4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ObWHs0AG8s9kpOgHRWK6ESc/Pm1UJVfCjGwmckBw7pxuL9P4uE++5mu4UN8CE/ujB
	 37wH0opS9tu0xMY7e7dMWLVVSVfkN1tK2ueCJstgmPvRM52SXUVKKEr7sSctDeam32
	 d6JyPDDba3eCyv4jJhDqaH8OCzfWM8I1hIenA6xyGo410u/OsR9i95dpt6yz+9vNvm
	 cTI0QD7OHPh1hz86ElUdmGqZnKvf5XFecmEXbQcbE4P1ao2z5SwsnDuTVZdHUNH0Iv
	 9bpbtL/o1gytGPrYv0BNMp4HDWoyNzLt8YSJ2SLswadCuOXbweJORIWDVbSgnZTYog
	 OLtKUA4BmRBDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B2F393A963;
	Wed,  1 Jul 2026 00:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sgi: ioc3-eth: unregister netdev before freeing
 DMA
 rings
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286522113.349616.415560228684093854.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:20:21 +0000
References: <40CD736C4911C181+20260629085053.964383-1-raoxu@uniontech.com>
In-Reply-To: <40CD736C4911C181+20260629085053.964383-1-raoxu@uniontech.com>
To: Xu Rao <raoxu@uniontech.com>
Cc: tsbogend@alpha.franken.de, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-mips@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 16:50:53 +0800 you wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> ioc3eth_remove() frees the coherent RX and TX descriptor rings before
> unregistering the netdev. If the interface is running,
> unregister_netdev() invokes ioc3_close() through ndo_stop.
> 
> ioc3_close() stops the device and then calls ioc3_free_rx_bufs() and
> ioc3_clean_tx_ring(). Both cleanup functions access descriptors in the
> rings, so the current ordering causes CPU accesses to freed coherent
> memory. Until ioc3_stop() disables RX and TX DMA, the device may also
> continue using the freed ring addresses.
> 
> [...]

Here is the summary with links:
  - [net] net: sgi: ioc3-eth: unregister netdev before freeing DMA rings
    https://git.kernel.org/netdev/net-next/c/18a28f3e107e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


