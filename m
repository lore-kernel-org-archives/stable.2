Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793608206;
	b=iGDkjnwjrib//dlUDOyYczkNt8bkvpUzRqQyYpa+sYbipvlrC2VqgI4qjnu0Xsk2gm6X
	 bqQfTtWMK7GkHmDIq+D8otvYfhNfCBlftSzUz5ZIP3FX1MoCBQKvo+Ehd8IA+fH4sphxd
	 3HS6hO5xfQ7Nkm+HN76lsJuSx8cgXO5b2Gq+iirUQMBExIGO18A8wqmRzHNGHQvZxCqzy
	 pVTHsY43ApiEHrsPa9sjwsc1ymWyUa/EP8Fqjgkj45iAAmw3NrD9Ee/otuo2iC4Lz07cN
	 wdyu59E8y64i6tDkSOJ2EzKFWeHxJUBYGpMQiha0f11blF1SRRiEhsPKrV55aPO3iQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793608206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=S4bdUGJ6Wq8ONmznrpPJdLbwjjINsUOdaR8Ihv8Nrkk=;
	b=U1hGMTwUAJmN/xQdoIsN+LTMNTmVXKVLcsJd7x+4MwYsyUr/zK5SoNcjawvzsnhftShb
	 bq75KDHmeDwrz+wlZqoyyCe3MObNM/0ufgCAoYdKaKttnKQvjv5SbCRuAlSJr62D3yvqu
	 0y4923DoCgKDShC4LJLDeXX81Y/rim9e/oJM3zYsG8Z1rAnvVHl++jEhygXF76zhecxE1
	 tEVn9AVtPD0jgSOvxmO9T+frDO9cfvJH9eC07tSRFppU0iRU+ygUrH4/CFz4a4Aml2ZsF
	 WqskPpZpR2WYId2jjMnDGebLsd2RlKAcLpmvO9yYvo7VWP39aGl6yHZRuBXuKKTPhaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4N+X2HQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A74606A32F;
	Mon,  2 Nov 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4N+X2HQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3FB91F000C1;
	Mon,  2 Nov 2026 08:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793608205;
	bh=S4bdUGJ6Wq8ONmznrpPJdLbwjjINsUOdaR8Ihv8Nrkk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=f4N+X2HQ3smXcK8NPrzjcX1p5/ap3eN0zPjgQA96kZqBVk2V9aCcl84lbHhFe1KnH
	 vALnCKpvbI73XU0Zg+5iqW8HjU6xcRyI3BykumxU+wmpCaLx/xwtWwLKBUXqXYNYuM
	 7liUUIG8va8hgtn7kRuZ0+t36iCsuArz9SZt2C5iip0EFJE9FdaPtJR52m4r0JDH6C
	 R8wvbBxQxhX1sLvoiS2d815fbrZg48FqgIH1Gg8ZSRWKy1+7+LjIIIjV9kW416jJ1C
	 XMITvdqgwe/6JxYIx6G10M5YDF6m8d8uZq8d8k3KlVxNdHowIpPL7nG494EfeB8jxj
	 ZGskUNJcffUcg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA296380821F;
	Mon,  2 Nov 2026 08:30:05 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: atl1c: drop oversized RX frames instead of
 panicking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179360820455.3860315.16760613731907588447.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 08:30:04 +0000
References: <20261027115151.17092-1-federico@rimpianto.com>
In-Reply-To: <20261027115151.17092-1-federico@rimpianto.com>
To: Federico Musto <federico@rimpianto.com>
Cc: chris.snook@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Tue, 27 Oct 2026 12:51:51 +0100 you wrote:
> atl1c sizes its receive buffers from the netdev MTU plus a fixed set of L2
> overheads, which comes to 1522 bytes at the default MTU.  A link partner
> that sends a longer frame - in practice a MikroTik CCR2004-1G-2XS-PCIe,
> whose RouterOS side defaults to l2mtu 1600 while the host stays at MTU 1500
> - makes the length reported by the RX return descriptor exceed what the
> hardware wrote, and skb_put() then either includes bytes that were never
> received or trips skb_over_panic and takes the host down.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: atl1c: drop oversized RX frames instead of panicking
    https://git.kernel.org/netdev/net/c/c4ba1716853d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


