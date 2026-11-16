Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794873008;
	b=b0UkOXBYwh1iVy+EIQbJ8hU+1dIdqkvALdDODeviH2L9Q4gCanpnMImzQ2i4cKlCs06p
	 JgvhRk8p64Swj0gKUlUFGZykvGhFP5zdwpH4NJf7hFlHemDbkcaQxnohxJoo/GOE8QIu3
	 zzTaxptKUi33qq+3T5eyd7FxJ+XoXN19EO2AMuzrz7ztGCFbVQOL5mGMw8GaY8c4yykg3
	 kwgM9ohUlDW1r3YZFKHu2jc0vWHoxfFIzJMPbdtsxwCOvSBj0QZU5/meU3iUEp0Cz+8a1
	 1vgWAMOhYEFM4BqPzFmKfVBSnoco4LBMCBNn3T670VsT6juaNMSWUALS6gwkkZoS+Kg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794873008;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=j9YGFS1vfURmuJvSQa+yC+JqaVeCUndQjeuah01yDdo=;
	b=BlSgrkN1DNsggZwpJ8fvw4LNh5vBaOeyRhrccvY3O1RlQ5P3tgeTdR0vxA8eA4Ta/VxL
	 nevwXGNs2U8Xelfvi0uGp7YNcW893SvWet4/JKq04uFgiUaJBTIbiT8YiUT5Z7oMGZnKE
	 JAx41aXTeyhfZwbeSjtLNGMIsvwuqL8T+RhvFus4ZYAGTigoYEpUDmc2udd//TgLEBaln
	 Pm0zofQT08vWE0YEt4qQUzo9LbBoXlunbkJUIasKdtVrmcoJnrvaVBKrdubiNAMzlMpOs
	 xcVJCHnX2jk/nzKVKbikZFkGYT7UjmtM5s1Zqapk+XIW4Hu58HA+QECrjCVhs9X/XFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5fEV6cF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3551606A33E;
	Mon, 16 Nov 2026 23:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=c5fEV6cF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83BFD1F000C4;
	Mon, 16 Nov 2026 23:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794873007;
	bh=j9YGFS1vfURmuJvSQa+yC+JqaVeCUndQjeuah01yDdo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=c5fEV6cFmui2rM7Uy7v4HfHFdBwlkTln/YvwNf1nH5COblzdU3NvZMzn7zXPO0VEC
	 AZUaBSKOj6kabkZq9i66OPTARtSKydFKzNehchTq38HHAg/KChewMNI0Fjo+nrMd26
	 tbAGGKrhEl6iDNsQ2M9tx1clgxlbQweq6fcI7h8AuBD3vU23eQ8iQT91Y/jZEG7oiJ
	 ag84m2EFOVJr22RMP8WKRqBfzbhtSWyn3roHWxdPN/Az4iAQOjYQYK5e4dNh+ztbrO
	 XVuxZ4xoQDIo0zovt1x7AURyc0jwoEZnkpswlXPg+DwZ71z2Wm5s6rCNh9MUsra9LO
	 PBw6heN8a3yJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77413391B059;
	Mon, 16 Nov 2026 23:50:07 +0000 (UTC)
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
Subject: Re: [PATCH net] ip6mr: prevent info-leak in ip6mr_cache_report()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179487300602.245276.10787515440158212496.git-patchwork-notify@kernel.org>
Date: Mon, 16 Nov 2026 23:50:06 +0000
References: <20261112042415.617221-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261112042415.617221-1-bsdhenrymartin@gmail.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Nov 2026 12:24:15 +0800 you wrote:
> The non-WHOLEPKT branch copies the IPv6 header at offset 0 and then
> appends 40 bytes with skb_put(), but the mrt6msg is written at offset 0
> after skb_reset_transport_header(), so the appended 40 bytes are never
> initialized.  They hold stale heap contents.
> 
> The report is queued to the mroute6 socket and copied into the
> IP6MRA_CREPORT_PKT netlink attribute, disclosing the stale bytes to
> user space.  The stale bytes can contain kernel heap and image
> pointers, and the report is reachable from an unprivileged user
> namespace (MRT6_INIT in a new netns, plus the non-root
> RTNLGRP_IPV6_MROUTE_R group).
> 
> [...]

Here is the summary with links:
  - [net] ip6mr: prevent info-leak in ip6mr_cache_report()
    https://git.kernel.org/netdev/net/c/ea538b5790ee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


