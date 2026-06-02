Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF6258CD0;
	Tue,  2 Jun 2026 20:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430415; cv=none; b=M0OU5dDzWvuv+NeeAPhNXqdoOMWQrYZUA40xp0kh0uEwrlV9KeVZBdJybSBE7+UfYa+4YDwMB0xoP0k6G3Agb4h9RtNtKgbh4oK7BRyPtpef8/4I0JjQm+2xIzLYMH2eFqxFvk40wCnF71hN/2CunI3zy7+YRQE/YygUHxk6OtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430415; c=relaxed/simple;
	bh=pp1ACkXvTAv6fQjODUDO944IZztNmwcrFY+RNu+jx+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TXBM4Nw3HSM7YVU7e8QeB1k7yQoV3PWjxnfHMD7HylOySEQekrqfgQMVLwnr0gtPpmf+FYxt8kPJx2ZoTiZIgzQpMz3dao2Rj1fm3P+pWlePhNZTv5zqqVOoFm2pO2f8NzbbT35RnyCpR4baMRzrTtE8XrobwJnFcPe9b3orxIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvUyxlfV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvUyxlfV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4341C1F00893;
	Tue,  2 Jun 2026 20:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430414;
	bh=9vkwn6/HTRIlP9ph5Nq9SfktdmRKpAL4kJ8i3VZyYGM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AvUyxlfVAMp1AIyT5fb2HYz7BMlC2uxGpEEH0XRU/3k6Lc8ea/6DNEJM+9dfh6gT6
	 32tXQ/Dlz+l0ptJxHLYeiUkSA2dFdJE1wHtVQF6+vWT7M+JQfs5mkDw0tCE9j7kto1
	 Cee5lSC+5s+FBeZqaNkOVUoKo+GoXK5s1oY95wBTDfHFxdwcXUfn8BjEVyvXFBF+3X
	 WEOjlbWs6AEJNVHEYSEqnyk0+MY6wotba//8z5VUpIm4NMZSLW1PuQtiSktysMv5BI
	 FZjm5mCv/tK7ICxxNjQomnbpF++Jc5g0/WhIbXBfqmWv7PC+aymyIhofZqSrDQfaW4
	 YUPqn28cJ6GDg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A8E3811A6E;
	Tue,  2 Jun 2026 20:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netdevsim: fib: fix use-after-free of FIB data via
 debugfs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178043041589.1026900.5518951073080196283.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 20:00:15 +0000
References: <20260529135718.1804031-1-yzjaurora@gmail.com>
In-Reply-To: <20260529135718.1804031-1-yzjaurora@gmail.com>
To: Zijing yin <yzjaurora@gmail.com>
Cc: kuba@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, idosch@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 29 May 2026 06:57:17 -0700 you wrote:
> netdevsim: fib: fix use-after-free of FIB data via debugfs
> 
> Writing to the netdevsim debugfs file
> "netdevsim/netdevsimN/fib/nexthop_bucket_activity" enters
> nsim_nexthop_bucket_activity_write(), which looks up a nexthop in
> data->nexthop_ht under rtnl_lock(). If a network namespace teardown,
> devlink reload or device deletion runs concurrently, nsim_fib_destroy()
> frees that rhashtable (and the surrounding nsim_fib_data) while the
> write is still in flight, leading to a slab-use-after-free:
> 
> [...]

Here is the summary with links:
  - [net,v2] netdevsim: fib: fix use-after-free of FIB data via debugfs
    https://git.kernel.org/netdev/net-next/c/5893cc75a191

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


