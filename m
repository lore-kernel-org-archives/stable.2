Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619D150EBF3;
	Thu,  1 Oct 2026 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790812815; cv=none; b=KnK+PuzTB2Wnam0JON+1yERS8NYNPayjUqRNexzAErc3bQjp1uocSk50Imh4xdoZBPeNNrZyhUtygBnyY/YiCEfIhzEPOv7B191ox3jOjG+tkRmr8jUFOCyQuhkJIa0oMVZyqQhZiXS9hS5iZqU5srbnU2xyxDufK5uCx3JjFx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790812815; c=relaxed/simple;
	bh=WBtHv2h2EXvMHa3e8nPmx+irbLJGc+x43L8IoLWZI6s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XxTiYfA9ew8YfKIAJ3FMq8kcysupj/YwYQWWgQ/ZY9k0fziYwMcu50YWFDuOX8zva7ohvJzhUd0TUn/HsEseHv2SHnyY4/dJMvdEbZVb0asohxSos6J5Ih4uQPssH3oX6SZnWdvO/V3VW4uAtLu7f1Sh/zKuQhfRFdcAqO1uKEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcf1pbfw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcf1pbfw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 447D61F000FF;
	Thu,  1 Oct 2026 00:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790812813;
	bh=pNfChoSajGhfWOPVeoF7VAoXyvssorcmQEafSm+VYUo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bcf1pbfwcWcawFJkZIGjRvaUURr/Vo25kHP7x6cJMv3xItSKFrfqw/Y99eYkWpeKf
	 7gZb4Ke2Ks6JgzpZm+5vHJxt4YaKup7sgtu9DjSEvNgAKaI0WO10JQnHjzdY0+mpyd
	 uMy8Ttusc9aHg5fnW935ayV580xSpfS8qxonrQ3XLVLLVudMh2MvwkoMk9CIqRO+o5
	 1igTcgkGAHEW3p1F8lIlgH/J/HeEXdPefghrpUfPLTNwepgU/ilGq6JocooAoUZJPg
	 GzRQEQ8PMw4Y8tNLo05aEwj3RuUQm770ZQ7VZrPo+RVQgRXNBlcl5tjfYTh1NbJOH9
	 JQjOvNG+P0CKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3E03AA6A61;
	Thu,  1 Oct 2026 00:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] net: stmmac: do not keep the new TSO MSS cached on
 mapping failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081281177.2182141.16737247267026791615.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 00:00:11 +0000
References: <20260928123422.1698785-1-xiaolinkui@126.com>
In-Reply-To: <20260928123422.1698785-1-xiaolinkui@126.com>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 xiaolinkui@kylinos.cn, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 28 Sep 2026 20:34:22 +0800 you wrote:
> From: Linkui Xiao <xiaolinkui@kylinos.cn>
> 
> stmmac_tso_xmit() fills the MSS context descriptor and stores the new MSS
> in tx_q->mss right away, but the descriptor only gets its OWN bit much
> later, right before the frame is handed to the DMA. Every error path in
> between - the dma_map_single() of the linear part and the
> skb_frag_dma_map() of each fragment - returns with tx_q->mss already
> updated while the MAC is still programmed with the previous MSS.
> 
> [...]

Here is the summary with links:
  - [net,v4] net: stmmac: do not keep the new TSO MSS cached on mapping failures
    https://git.kernel.org/netdev/net-next/c/6b76e4efe73f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


