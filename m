Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793635809;
	b=FrLm6iHqaTFqXcDP7gAj6g5puAd3gA1giXnYAsrDHGWXiOErKiA4CW0D3YPX3UMTEb/a
	 VJQLKwGWMg+x8+u7AZi7B+Ogkf2z0DbtLNOAkyOesm1U2O4xIwqCCotNiLHojdYi1/Zor
	 +Apu0zt2EvrTsaywkIX96nlUZJAWJiSyh+ptToXI2a9aoMplgRTKxs1W5FjAbrv7DOB1P
	 3Rq7Wa94VWqE7tiq5QQcNgBQ836gI/npway/Zygv3DVh1wVabdsZB9NXJ9hPaYwNpOnN2
	 nVBGiJOE8Ix7sKTWvIXeeDujj6Plcr4j5cTbee5vGzWwClu2EQ2Xvl2er9W4AmkGF7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793635809;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1DmlXTDBEeOIul91z+cZdwbI2R3LzJN6ZNUCtNildqA=;
	b=bonY/MI0+0Ssi3r/ooVPIrk4ub+0F6qNtoYGUkOvRhhm6NF+zg5WDxscRkQGNZqANHwy
	 ad6QOLgr+X9rC1WCyUGoKcmczvdzlmwYfCi+M7mXyuEQVgz4L2crs7u8l5ZCiUDEZIaMg
	 EJ7ysqFGaNXF+ApsUsGtjpXenUb9VQBkbkg01PKjMA+kxFVQftQdkJG7rLs5QeSTTQK9S
	 wesfN/Ixpw7XpyehH77zpUum4NP+y/aFxUL0jUZ2iIWdgmFNysmto6Qx/WHHra2Te/sXV
	 xqFHWuLtfSa2yC987AJ8UlEAPX9evY5MqegpsZQZ1biNkqDeDIb47+7GCQOyRx8HiXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ8Ft8oB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E27607E0E7;
	Mon,  2 Nov 2026 16:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PJ8Ft8oB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C59D71F00A16;
	Mon,  2 Nov 2026 16:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793635807;
	bh=1DmlXTDBEeOIul91z+cZdwbI2R3LzJN6ZNUCtNildqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PJ8Ft8oB62r/3227XHJek9GoQna/Tb3Ict382nFzSsbSGp3lvRfcpTQbHiVQzs1SI
	 bLj+Z6QL3OKUJEfl9Zzh5FWPVcSguuwjNJ0GoheFE8U1H9A2VkkaJP+PyDURi771lB
	 zUZt6TGbuBnYmd1BTP290fkKdHl6EPn8bjYyi4tYPCYOvp4hRorWdiO8TSNmwxJ5Ru
	 HUAqNPgVoBLyQ+us1inONf3zyYxqNR/m4N7tKqkbE4nWSD/LVUu3CxZ0p4ypjLQ/xe
	 U37wvQcwUq7jaIlZeae/oAH63BOYqz6PlxDIuN/sYsUHWwpk8KzIuF83x783ahzYGe
	 DGFv37bblSZiQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA2D6380821F;
	Mon,  2 Nov 2026 16:10:07 +0000 (UTC)
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
Subject: Re: [PATCH net] vxlan: Stop rejecting dynamic FDB entries with a
 nexthop
 ID
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179363580655.29416.13658087045613427026.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 16:10:06 +0000
References: <20261030133750.28668-1-idosch@nvidia.com>
In-Reply-To: <20261030133750.28668-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@kernel.org, andrew+netdev@lunn.ch,
 horms@kernel.org, razor@blackwall.org, dsahern@kernel.org, sf@techfak.net,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 15:37:50 +0200 you wrote:
> Commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that reference a
> nexthop id") started rejecting FDB entries that point to FDB nexthops
> unless they are configured as "permanent" or "static". The intent was to
> prevent such entries from being aged out by vxlan_cleanup(), which runs
> without RTNL and can therefore race with other VXLAN devices that modify
> the same per-nexthop FDB list.
> 
> [...]

Here is the summary with links:
  - [net] vxlan: Stop rejecting dynamic FDB entries with a nexthop ID
    https://git.kernel.org/netdev/net/c/7308ef8b4a67

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


