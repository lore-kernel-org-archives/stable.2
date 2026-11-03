Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793740814;
	b=g/gKctKQhnCP29tds4WENmHbE5hFnbpRxk/ggae/vCHknNqICdGH2Qm3qZ1uA4gac6o0
	 zF+Nqr57zEBgvcfylpv/8JuxxLi2oLCpnHF6rtn4FRc/OImB7aF7s4dV6QxA7po7EDqEq
	 jv+icfHf98GfkROVd329r5gk9rK7lu+zZEW3csEGNlp4Wf5OdqQSSOFtxELSfXvlJVrES
	 rJn7YiLSzlfK4U++BEH6fEtxIEWsMJn3KET8lcvbFDQypkdI0Ny7p81v21anFTSZIJPQ/
	 nUij1kjJK0zec7BghBsbwSCbMDFO3QhynlbKlavQcGmU+nt5v2RxqNyq4CSbGErPFTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793740814;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=Cc2iVEQpQJW4KLsTKA8podEQySXEWAU58+noOxhAGL0=;
	b=TE8SNs2QEvqtG6wsb0c0Wz2F/fCl6zXJhLzY79p4wpj0vOmIfiAZPq34PnV4tJSK5T8w
	 fdRj6Wv78+oKQhBfQ8CWZkHI3U7d2bh4rdwIMaygNQVWRUVK5SiCmiK3mw5w1AuCTw5tD
	 ycdiC+0YHNXiL1Sl0BywaUbvMxz402KE3KibOJo8dkALU/Ve7NaBqt9dD0xO0jgB060XT
	 0P5g97yEmIz6XHo4NQby3K3+anSB+GIdTrDlZWD9Xi0Gt0lPztkanAu6byIb3tcDsGz46
	 Q1btH+GmTqX8ub7GoO2xKpZgHGZPmJrkqdtjl3mwBfl0JIQGZRUb9+HAcauSFMjXsGA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7YEvj15;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0C4B606A31B;
	Tue,  3 Nov 2026 21:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T7YEvj15
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88D181F000C1;
	Tue,  3 Nov 2026 21:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793740813;
	bh=Cc2iVEQpQJW4KLsTKA8podEQySXEWAU58+noOxhAGL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T7YEvj152cyitGbQQzBDunWm0wQoXuf7hoRcqpIF0rboWwUMIzwctHdk7XAoDTG7u
	 zfhIgolpJlqFRoaNBxjy5RyjjfTaGG0v1oISmH5ZYiIdzKe2v/NxNWudpYz0Fmgmsp
	 8kTkd2E7pJaZftWzb+2B1Po+EPHJjNFEBo7S3WZNYGA0UAcmV4e+32tNlr1ejR7j/p
	 0IbqhFPOmvuO/nXfP4nn89YogLmg21VeE1BpiI6eH9YLbaYSxNjSgxZTgYGXRBbTyu
	 2IqT3oxrvSI026DNzxz/T+fKh7c3pN4F3yDt51cJXjf3iJnFfqYAELLK+swBemLL0W
	 KA05ACvfBGoyA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D20D391B0A1;
	Tue,  3 Nov 2026 21:20:13 +0000 (UTC)
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
Subject: Re: [PATCH net] ipv6: fix device binding after failed datagram
 connect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179374081204.1885738.206457161503439442.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 21:20:12 +0000
References: <20261029135822.448299-1-yanxia@cmss.chinamobile.com>
In-Reply-To: <20261029135822.448299-1-yanxia@cmss.chinamobile.com>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, tpluszz77@gmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 21:58:22 +0800 you wrote:
> __ip6_datagram_connect() can change sk_bound_dev_if when connecting to
> an address that needs a scope ID. If ip6_datagram_dst_update() fails,
> the old peer address and port are restored, but the new device binding
> is left behind.
> 
> A UDP socket can then keep reporting its original peer while sends and
> attempts to reconnect to that peer fail with ENETUNREACH. Replies to the
> socket are also dropped by the device match. The same problem occurs
> when a scoped multicast destination picks up np->mcast_oif.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix device binding after failed datagram connect
    https://git.kernel.org/netdev/net/c/bc53aab4881a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


