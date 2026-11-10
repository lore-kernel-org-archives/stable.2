Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279284;
	b=IHoGlxeg/w5ZnK9LpuP5G/7LNlZD/yUm50MLpV9ic0OCX3e3kFmpWGU9Yu3THx79zoM5
	 v6kJqNe2zA5YzQRboqaiR8MDGZEdFWBZTrczSTmP67Mcd+4WMlbL8YkJMVVhvvlLzHpp9
	 uXMVPSYaoxBvRyUbRVKzzg9ZuEsPAFnPowzkJoVSsyqJcVAzez3GvB9kf5Fo9A2b2oDVG
	 WsHb18NZrq0f5vCiLiSnfScmmeUbtpn1A53Lil+ABrKanaQL5dFTzROMQ5mG8k8R8LxqK
	 IZ1fcPcZ6PD17rS8QMzbMOtf61VTJd4+enF1xwCpyNhlhIvoHaKDO8ZMJXNQfDJ7IJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279284;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kLvh7tubLXt3zphZJJDCBQWndhkqnqxKlZmt/Xu44wc=;
	b=KBn8H3fgZZ+lmO2SF7duNafv3Db4cPR4wmMjW71Cg1EYRZe8IGT1qKWze+K1BI4qqWWA
	 ftuFkX3UebMLbTiJgHoDaj3CJDMjOJ0PiK0wcAU6f+wj52Z8xwn4vq40H/Tg5ZNi6wOrv
	 wBgvxoNNRzuSh5n63eqmv6CPQRma4vrscmHDq/1TLmuxCreqq9DKLDXr12zxJNwLWpCGk
	 Tn4Jr5VuqJ0wbzGauUp5oapk+Kdedb3QheOkw+NWQFr2bbuBLELDZ+ftue679YX/qnolF
	 TPb1RgW5zIPzNZm8BAhv/xqaGxFlpj7J81kUzwWyngDmLovJZHmf2waP4T/6kx8IIDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8K8CueU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28E7606A338;
	Tue, 10 Nov 2026 02:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8K8CueU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3B871F008A2;
	Tue, 10 Nov 2026 02:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279283;
	bh=kLvh7tubLXt3zphZJJDCBQWndhkqnqxKlZmt/Xu44wc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=V8K8CueUa+6xjowSiaNRMxVZs8lztAZ7vRCatxa0tl5NkVniMWQxcEU/GcYV7Jcnw
	 oY1vOVluIx1tPe1uWXfi1PXCTQwJJ3oWmZ6HOwr5hFrsZjloYpP5ZHOjxuVmZTtaNV
	 8e9oqVh7BezJmfSTVmLhckjxsTTSXp3eB1C1hBRMagcmsRL22q0rjPzntUyUK10VRx
	 fzM9cVrGz82s+tk/5UDy2SZnRboutchcVBa4IlLh2xy83V+n+Ysmcf34w7WyEPrZmh
	 /mBPJ3XfF2hqz3iJ5VTUM8MReAOUDveKLNtC0WcAWb66ZqSKDewIlIrBwLwZgQULOb
	 PSAxu6VCEw8qQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B03E391AFCB;
	Tue, 10 Nov 2026 02:54:43 +0000 (UTC)
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
Subject: Re: [PATCH net] net: wait for in-flight device unregistrations before
 netns dismantle
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427928217.3612825.16476819658097015103.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:42 +0000
References: <20261105144543.1624238-1-edumazet@kernel.org>
In-Reply-To: <20261105144543.1624238-1-edumazet@kernel.org>
To: Eric Dumazet <edumazet@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, stable@vger.kernel.org,
 syzbot+1269fe6cc2016008124e@syzkaller.appspotmail.com,
 bsdhenrymartin@gmail.com, kuniyu@google.com, namangulati@google.com,
 pablo@netfilter.org, fw@strlen.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Nov 2026 15:45:43 +0100 you wrote:
> A device can be unregistered by a context other than the cleanup_net()
> of its own netns, for instance a veth whose peer in another netns is
> deleted. If references on it are still held, it stays in
> netdev_wait_allrefs_any(), which rebroadcasts NETDEV_UNREGISTER every
> second.
> 
> Meanwhile its netns can be dismantled: default_device_exit_batch()
> only takes care of devices still listed in the netns, then pernet exit
> handlers free their state, and finally struct net is freed while the
> device still points to it.
> 
> [...]

Here is the summary with links:
  - [net] net: wait for in-flight device unregistrations before netns dismantle
    https://git.kernel.org/netdev/net/c/c164a431a646

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


