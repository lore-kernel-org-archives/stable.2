Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048208;
	b=vfe30XtUuWorYXjXBsRhv11SRHzU/iF+iA+/+YH25flg1MPGl0TBA8X8DktXxoZkOR/f
	 v6Yjqi6fPIn4OXlHrYzADRRelPBYNutdHCqFLoep79DZ/LkaqGEroq4wQff0eOZxSZ394
	 mB2tYkpfnS7Z+NhI1zrQ1v+me31w9ICuMRpdl2GZDJRPTnvbWI1cbwzDT8gP6gNN3bSGX
	 lG+Kt9ecYyhLqBK6o6vOM3qNIav4HPhGlCo7vkMyMJV96nVglkniLAquYnvKh1YirtGAh
	 g3iLz640/Mx2l2mjuVpxI5fFE5nX7ABmBhfzMDKE9bjsUx9Qs9bI1yIAOJ3KGGtI00A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=vLkljH5SDXx0IeKaAwCJhAMjKvUVLeXJNvmdVHGfrO0=;
	b=b0El8bPB4m2x1W5X8W1E7os10kLfybLgq/JuboBrZS5ADjeZFV2DEv2vEVlhvaAErBfU
	 jIBUhKGN2x8RaGCrHzu0e2lk2Veaueo45eC1QWp3+cxIYDorwLcHjMp++711zNC5fwiOn
	 l3zE4N1irlTEnegUYGlNOLywM0SafPqu5RSm6RbDYMLzRXRUnWds6qQqFvVdlUwMV9wgO
	 NNCzAddxrm6yXmsG42w+GGFlHY3qi/MTgqiwcB/7jJQzgAIn4JP6yAqZCaIipoxODfHIG
	 37k0YKd+c9RhK3HaEmT3f28sMVXXCt54Tgh+D0SfuKfTYiX8yD0pEgMtRpWyZKumYAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMfXbFFl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAE606A332;
	Thu, 19 Nov 2026 00:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eMfXbFFl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06D981F000C4;
	Thu, 19 Nov 2026 00:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795048208;
	bh=vLkljH5SDXx0IeKaAwCJhAMjKvUVLeXJNvmdVHGfrO0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eMfXbFFlHWv1HxmG0QmKHqjCfZ/Eiio/JZRGDj/nRPYvDgKTiXqv9XYYqQvkUMGMq
	 qpBjsvMsBj8J+tj+4AOOK1mfYKsZ8b1Rnbk9JTN54qOzamX0JcmBxxj71ErGF1wsph
	 bhS5xKuSA0Flxm+4Qr0z0jRIpB+sycGjRVfMEqg1avOxOafFbOL97PxHF3fDiDA08S
	 PeDMh6+wxWswyyBhRAocrJgGtI3nYy9RO1/U4T/n+kc4EWWBikPwxPE2x/vE+aMyeJ
	 E4ghclge45yWsmpkn/e8g2CAN+mpOLAY+IEHnUslgQZN699hI2mh3J1fSbVA2ALJQn
	 nH3KL0l/ATQxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F17FA3808210;
	Thu, 19 Nov 2026 00:30:07 +0000 (UTC)
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
Subject: Re: [PATCH] net: phy: realtek: fix listing of sysfs directory tree
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179504820653.2657179.4672591477512368848.git-patchwork-notify@kernel.org>
Date: Thu, 19 Nov 2026 00:30:06 +0000
References: <20261115214045.3704-1-mat.jonczyk@o2.pl>
In-Reply-To: <20261115214045.3704-1-mat.jonczyk@o2.pl>
To: =?utf-8?b?TWF0ZXVzeiBKb8WEY3p5ayA8bWF0LmpvbmN6eWtAbzIucGw+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: andrew@lunn.ch, javen_xu@realsil.com.cn, hkallweit1@gmail.com,
 linux@armlinux.org.uk, kuba@kernel.org, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 15 Nov 2026 22:40:45 +0100 you wrote:
> On git master, listing the contents of sysfs produces an error:
> 
> 	root@mateusz-debian:/sys# LANG=C find -iname foobar
> 	find: './module/realtek/drivers': Input/output error
> 	root@mateusz-debian:/sys# LANG=C ls -1 ./module/realtek/drivers
> 	ls: reading directory './module/realtek/drivers': Input/output error
> 	'mdio_bus:Generic FE-GE Realtek PHY'
> 	'mdio_bus:RTL8201CP Ethernet'
> 	'mdio_bus:RTL8201F Fast Ethernet'
> 	'mdio_bus:RTL8208 Fast Ethernet'
> 	'mdio_bus:RTL8211B Gigabit Ethernet'
> 	[...]
> 
> [...]

Here is the summary with links:
  - net: phy: realtek: fix listing of sysfs directory tree
    https://git.kernel.org/netdev/net/c/f16d85cd3de9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


