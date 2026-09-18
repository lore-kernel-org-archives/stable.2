Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066237BE84;
	Fri, 18 Sep 2026 22:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771886; cv=none; b=Jt5n7uXRzU970xW6ZKLD97oL649cvo64HlO2KESdBBet398Vj7K61UR0ZQlSXe14YPE5+Xahbe5hli78JDbTivRV8CMgG9xERVzAQuY0dOkXF4llL99mRfllbh1bYwUab/4FJIwOONgUHGq6VKb1E5fiLwigmuspqK2qWrXbsFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771886; c=relaxed/simple;
	bh=U5v0btgtclZk54nmhxVfszjH+0mPB8dQGNxmEoCzxjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lz2UCClO6ffDPRbW0TMaIgXoqkq3Y8RJEhLeUF1Fy+oEBVPgSqq1sceJ9z0PbchdzyCkKT4inIKYq7RoUJZhV6YW5qHy8OC4cEHU9tPqwaxE6t7yvD+6mDp79L7xijQ4hEEhuOk1/Atm5LcXhai5HtAAOk18wCOBx09Atovv3iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLzl0m4Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLzl0m4Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F5C91F000FF;
	Fri, 18 Sep 2026 22:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789771884;
	bh=731a6XXeceztXL+ac+gkERlPUJ3cREl5p8bl8/NcrVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hLzl0m4YKl6hlT7zNLemKa+uY5mMBThfRbfwb7wkVXmNUKHb+pX1HgD/Sgt1d9+zy
	 5TMFya3Ly67PVe3CXn+Idn2AsOTZ60ko7pYgrUU7cHGjb+ersmoqxa1MmKpt1lP4b2
	 rZqVkLmog2qVjeZ1Y20RI8EaXzouyqCMh6CJks37wIwARZGqIvP18OeTFJEemhgf40
	 y/ouYmzNitzaOLqrx4UK0uyu3pvldpaQM4rPN5f2zHariYPvZidnosS6n/Xa9Y8SBb
	 hoDoq6COg2Ab4+iy36+peVot1ObiWIf5dyr6a1+HraDejHUmA7RBbzzEv15/b9oyGw
	 kGO6ieWT2bI9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A02381196A;
	Fri, 18 Sep 2026 22:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: fs_enet: fix platform info memory leak on remove
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977181739.1178488.919668465552936249.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 22:50:17 +0000
References: <20260916031414.2875022-1-lgs201920130244@gmail.com>
In-Reply-To: <20260916031414.2875022-1-lgs201920130244@gmail.com>
To: Guangshuo Li <lgs201920130244@gmail.com>
Cc: pantelis.antoniou@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, jeff@garzik.org, scottwood@freescale.com,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 11:14:14 +0800 you wrote:
> fs_enet_probe() allocates the platform information structure with
> kzalloc_obj() and stores it in fep->fpi.
> 
> The probe failure paths release this allocation with kfree(). However,
> after a successful probe, fs_enet_remove() tears down the network
> device without freeing fep->fpi, leaving the platform information
> structure allocated after driver removal.
> 
> [...]

Here is the summary with links:
  - net: fs_enet: fix platform info memory leak on remove
    https://git.kernel.org/netdev/net-next/c/4a6764900678

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


