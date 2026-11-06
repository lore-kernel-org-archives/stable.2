Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006606;
	b=B6+ziC5WFW4IUPiRusbHtUn70J4hlztF9uhefArOJkP8C5wh1VopIKnveAc0geAPWq+h
	 TorjguBfihyhe9Ert+tRCYrO27KSa3IjMUnjYmDffy/uBW+3wGzqgsaiwCbMXrH9GkSfy
	 HoRAN4hnTtE9o4+5C+svc15VMHdPJ6j4bgaQW45I3TyT2iWoYCAC8EgqspgBMKZMLpaNo
	 Ktv7VHTJyfDEceIHCkmhnXEwyNf2xfjNgQeNn9rKSOVQDIeRM8EkAdCl0NFafEEAO2ZhN
	 kfS43nRILFnU+7rpJqVcrfVdMnUH1Lg0OF9fLSC0/evTMaCAj0RgwfcYT3tF9tJJyJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006606;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=JaXrBaVnyjZU1lKMK9ogNqtByExq8qXX8r4mH+X8o4k=;
	b=uFVKaknwjcG4JqlMyf6nMAoVjVtHLu5IStCtH1yaVXez5ItBAZ7LGA2e/hYKYXfS79NN
	 jFHVe8Kul/+gLQqv+s2+VsqgXUKebPWTr6YzA6dGvjvAUZvlj3bTgZS3myLEsrJ9nMLRM
	 Xytjli4oJ2oUJvbN7fEcrEhK4Gc4wj4m6LGlqINqiK9NeB3hBbBCUPdlc+iNq6sMuopc5
	 KvwlcS19uXTkzhtno9VVSICKVM01w7M4MfHyqWAfuhbOa2YqukDD1dJXJghYGh3TYipou
	 +cy1f6fQ0AfUIyTH1OSPC2oDhfhYzqgOz63nwPxivhlVHpG29nqnQFP6/xwXFbkqvog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZC5S2snZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BD0606A32C;
	Fri,  6 Nov 2026 23:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZC5S2snZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 299D11F0089F;
	Fri,  6 Nov 2026 23:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006606;
	bh=JaXrBaVnyjZU1lKMK9ogNqtByExq8qXX8r4mH+X8o4k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZC5S2snZp+7TLHFg0BYJBDFMLqvaNc3BYskD0REpRbZ9uLBSFso9nY2jjZ3oTiytQ
	 zGn4wMVEKRqUD8aEMcI75rIzfEyhwJaJVeG0RM20ZIE48G193TTEiEsnwtB3aSoiSY
	 xkcY8+QAHTZztYpfptexoRW9nxlWb3K+/yUdudoG4lHzCVIciCIPHCZKXotlbdExzY
	 LhskzNGDw5CcwQLEMj4g5rmiHZr6hltranP3kWbo89+g0065sh9ZxApjDbsdvdy0iD
	 YzHZmPWMhWU/MiO9x0IfOqqJkT6G/4Y/bXM22beW/UY8+8nZSXpXIBv/xDt+dns0j6
	 e2Jw7qw72783w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 20FED3A55EC2;
	Fri,  6 Nov 2026 23:10:06 +0000 (UTC)
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
Subject: Re: [PATCH] mlxsw: core_hwmon: unregister the hwmon device on event
 ops
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400660493.920475.6127092463819151784.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 23:10:04 +0000
References: <20261103102850.1340455-1-vulab@iscas.ac.cn>
In-Reply-To: <20261103102850.1340455-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 10:28:50 +0000 you wrote:
> If mlxsw_linecards_event_ops_register() fails, the error path calls
> hwmon_device_unregister() with line_cards[0].hwmon_dev, but that field
> is assigned only after the registration succeeds and is therefore
> still NULL. The hwmon device returned by
> hwmon_device_register_with_groups() is never unregistered, and the
> error path dereferences a NULL device.
> 
> [...]

Here is the summary with links:
  - mlxsw: core_hwmon: unregister the hwmon device on event ops failure
    https://git.kernel.org/netdev/net-next/c/08f643794931

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


