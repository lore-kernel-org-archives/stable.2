Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795448407;
	b=q5IymUeYpakYXFpwVCcUu3UluLngcKa24kl+uQFL4SMA21vPVN/Dg+U0IMdFfCS09iqa
	 DxsaWwjSyEHIM4SWRmAp5tVr8iL7PzMyKl3IIFcZi/D4NGtpRglaRCKkibUBedXynt31H
	 hBSwi5z2lcOESSHP9ghQfLIAOrc/8yJM7sn6V4HaK0nlKG3vLBhAuZNcqpgJK3GKkEzR0
	 H4MbgZnaSvpHzdvC8IEDN+GjwNNi0LAB8ffQN2Z2S6SGPDLNMr8nxjHjf9iy4E0JqeEyF
	 psrk/gSlKmO9H6POYbGWLk0yvJivPr8tCBMyko8nPzFTv3ETdJCWetS0ZadCRSYSr0w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795448407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=OefWWDM6765zS8UeXsEa0lfO1VMuF0rqbjFE03jLU2U=;
	b=xEJ3RBpsavY0F5OyTUohm6zAf+W6RTYf7Szw7lZfkqLy1rR3rndDLe9Rfgi27Gfpd1Cu
	 5sJaIOND+0i29DEN5wtmHmgHQXY020n+wjsB6DncK5qzdI2mIPtMJSFSjHiAvZY9RIlA5
	 EN4Z5Rd9UW0nf9xWZaJLNKXQAZQXIflVS8Ws8Ox7zq48eD6uqvVLz4zELu9EL8uTqvrL6
	 Max+qe34ok2Ysul4cYPF11+8yzcXSo3HmgOxUc4urNa1J0Hgd7QgXN5TqB0bIveQhz2/9
	 WZKqUwWENiqr/0fEcW8maqiv2OLjx15SPvZ8US+yHRtmTbJyAY/PlrbCzjCWn58BQkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="CRi/AjKi";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD96860A3806;
	Mon, 23 Nov 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRi/AjKi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 465B11F000F2;
	Mon, 23 Nov 2026 15:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795448407;
	bh=OefWWDM6765zS8UeXsEa0lfO1VMuF0rqbjFE03jLU2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CRi/AjKi4ehlkE4PSAya5g8d7tvW4OSud7sc9Pg8fH40HXBLEs2tvnoejsHdpVAQO
	 KUEWHcY7c1o0OrfflSZro2e3gz1vVQmmfo6Z7GhuuYscWwRYRKUqoRZxSASxB+Y7hT
	 ZiYuOP94M5x1WnXCz6zE46plzqY24R2fM/HBpGwl0AGRsU4wKmHbQEs7qNyz/QAhmN
	 xUHgoJs0YhOFDxiiwtrcfoW4Yx+HQapnsQDSsGuM6SYycICAV4lnTBfcQDb1H1XeDx
	 2eWAAu87tMpA5rbUBMy1k1jaAKVw39U/7SR6PmoLIbVSeYACdYl+DZqJ3dxfU5e2og
	 GcUBce8Tr0lRw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A5EE392EE0C;
	Mon, 23 Nov 2026 15:40:07 +0000 (UTC)
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
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: do not override PHYIDs on
 external MDIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179544840577.2474785.6234725190698108233.git-patchwork-notify@kernel.org>
Date: Mon, 23 Nov 2026 15:40:05 +0000
References: <20261119-mv88e6xxx-fix-v1-1-2db604f3516f@airbus.com>
In-Reply-To: <20261119-mv88e6xxx-fix-v1-1-2db604f3516f@airbus.com>
To: Blake Alexander <blake.alexander@airbus.com>
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 f.fainelli@gmail.com, vivien.didelot@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Nov 2026 11:50:00 +0100 you wrote:
> From: Blake Alexander <blake.alexander@airbus.com>
> 
> Some variants of the Marvell 88E6xxx family (such as MV88E6390) support
> an external MDIO bus (in addition to the internal MDIO bus for
> configuring internal PHYs). A typical use-case for the external bus is
> to configure PHYs that are external to the switch. On switches that do
> not assign a PHYID for internal PHYs (i.e. the value is 0), the
> mv88e6xxx_mdio_read() function traps read calls to the PHYID registers
> and sets the PHYID equal to the family ID of the switch.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: mv88e6xxx: do not override PHYIDs on external MDIO
    https://git.kernel.org/netdev/net/c/dd206ec7ed36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


