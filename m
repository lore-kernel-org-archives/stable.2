Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793290813;
	b=5GNBOIbMbEMLnms2C9h2G70N8kSlria3WlaovwK0GucT8TmkyiwItMGaKVYMLtmlxyMn
	 8xKXfSBxFMTa0EGgrVKnyEOsrYKSw6dVhPJ1W954cMhzlsufNukg3oTNqCe/bbmANUGce
	 Eeg2ahr1e6SmJJcY6YfbEiHywWiFzjYcZcE0bgyg4CzHFfJa69dZ58rDOD7H6gdsv+1Zc
	 x29WNgSfcK+3rx/aJ+Fo9uZ131CxvgQey12cV1BEnrkGlokMQDALiHfVAM1pMg3eNEtFY
	 TnPfHnjq5g6lzBiAxRJRrKb5dARLD5RtKc6JpLo2c/ThOApIrcxuBNzW+lwjoVID6eA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793290813;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=d47dGBOe1XI6nFR4EvF1EI63qFvux3Z7wAntQRfPwFs=;
	b=cVoWaFjttUw+aCkwQ8K/xPSEJv4Hxk7ltmrXqwWYJn8fZ8ANSJpXVq3tMqmaEyT4ioAB
	 vUzwPzZxp/DjTJVVGNp5iz9cNxinQhh83tSZ7fTxhnCc7PB8JWD8r467f8uZiRY7mFsOY
	 SXxHlTanfRh5mKz9ylGNGN2HLjDhVWnDh6QoFrWuNHlKhb67r2nzd0+6nMISbp4SL7ZgV
	 JAxJRzpwsf4AXQD4ERRUPIBZrcyl8Dg+y4k/oZVfmGgE4+KvrnoUZPbMHfza7JGnC2bwp
	 qCh4SPp6GKbiN0trclAs9CGwyk3AXKzioAJXXi4TpytdkqumELGZV/S5M7lZlQidg6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6o+YMhO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE59606A330;
	Thu, 29 Oct 2026 16:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6o+YMhO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4794C1F01816;
	Thu, 29 Oct 2026 16:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793290813;
	bh=d47dGBOe1XI6nFR4EvF1EI63qFvux3Z7wAntQRfPwFs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f6o+YMhOQj9PGDA6YqomcN2f9MCbnoWQL9qNmb0WTwyZS0nLhbqj/yJM+Cq/7aLtM
	 6lCVVZpR9f2sDJkEiXhuQf6lAocTqmMkkcmRLEDsktRMRgHhhmx8WoWo86PO/wWzb8
	 AQZqTld/kYYvkls7BddFGczPVT0TeEAjtRsqpJazLQ9QscTvMVSKietnKafue+ezOr
	 YJIz/A5lB/x2M43u3sPLw94pN2mgGT8H/dRPV8IbFwsFf4GiEbQUSkwrGKESPDZJz5
	 mRxRsv4QXk0zyuwbZvNMnEMvNjeXW1yKQJhloVfdOKfd9a1vgaf/6Uo7i02WxdQONb
	 x1QUR1L0eysYw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4008E3808221;
	Thu, 29 Oct 2026 16:20:13 +0000 (UTC)
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
Subject: Re: [PATCH net] tcp: fix reordering addition overflow in MTU probing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179329081179.553408.13684640477069150222.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 16:20:11 +0000
References: <20261028160226.2170244-1-edumazet@kernel.org>
In-Reply-To: <20261028160226.2170244-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 kuniyu@google.com, ncardwell@google.com, horms@kernel.org,
 netdev@vger.kernel.org, kylebot@openai.com, stable@vger.kernel.org,
 bronzed_45_vested@icloud.com, n05ec@lzu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Oct 2026 17:02:26 +0100 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> Commit efb8763d7bbb ("net: ipv4: bound TCP reordering sysctl writes and
> MTU probe sizes") widened size_needed and the MSS multiplication, but
> tp->reordering + 1 is still evaluated as u32. RTAX_REORDERING accepts
> an unrestricted u32, and tcp_init_metrics() can install U32_MAX.
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix reordering addition overflow in MTU probing
    https://git.kernel.org/netdev/net/c/c1df9c0c0536

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


