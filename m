Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA4A41F5D8;
	Tue, 11 Aug 2026 09:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440652; cv=none; b=nYXJaziqlAI/GDJFi9vm6nXhYWDieVmIptztSbR5Edis4/Ksvko/oBqyfjSCYQRSp6mytaWjH/mmif6HExLS35/9bIDXceP3RoG9dobu00g9ATAqBeNN010UJgt1m9JvQkMnWhwbS8yKOotCy/yQUrVNtRllieXEqJThFF20CeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440652; c=relaxed/simple;
	bh=x6F2fIM/izl7jnzM0T6FO60z368V2ehOA23zJZM3CAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GQ8ZnbYtsDbGvddKUQrQGj/wOqiwpt7szhZZU+VFB1Gv8nvXQic9m2KObJYK0XYr92wQ5/81CiygVcdSu4tFZMhYFbxFKyXPev/GYNSbT8eDcTKZT19UtbREOlmGdm03DVj6lYD3UHxJ5sdydYlA9l8EWfRxhBdU+ukchLkDZEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TUVgZnCY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TUVgZnCY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C471F000E9;
	Tue, 11 Aug 2026 09:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786440650;
	bh=QXgw16eI2nQUWbkq9XxFuTT0NlEMucmCFRNM50iTRRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TUVgZnCYY9aR1aWKifOx4G9L/DpSTW2ba42aC1c0M8IpfxZ6c05KNXnN7Keu9SAlD
	 wY5MyIwxtIk7RDquPdDcu3cLyKHdn8KFzoTr9MeQguwGTtasJ2wjyZF9CIoDt25SjB
	 35bbYoxZwwto/AjeR5zb3vBUFr37nK3MKrDLu4v8Ff31WSzf3wvfpvdljz3HUwOJO0
	 tF/lp0EbscGSshPjA2Ta9pH6wTMkZoe8pDs0sP6DD+5QdIaUSLznkm7N/Y3xsAqg+M
	 NkUdOnC13gskwv9Sc/ZjRYn9vBM44t5z58Fb9RueJH7m5Uk9xj+jLIlaDLBdWcbQTC
	 qhoBuuAU69VbQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5690D39263AD;
	Tue, 11 Aug 2026 09:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv4: fix use-after-free in fib_nhc_update_mtu()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178644060690.437668.7502162978674316301.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 09:30:06 +0000
References: <20260807181710.1178747-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260807181710.1178747-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sbrivio@redhat.com, sd@queasysnail.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  8 Aug 2026 02:17:10 +0800 you wrote:
> fib_nhc_update_mtu() walks the nexthop exception table under RTNL, but
> RTNL does not serialize this walk with PMTU exception updates. The walk
> uses rcu_dereference_protected() with a constant true condition without
> holding fnhe_lock.
> 
> The following interleaving can therefore occur:
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv4: fix use-after-free in fib_nhc_update_mtu()
    https://git.kernel.org/netdev/net/c/bc5bde9ce3cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


