Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B884A3DEADC;
	Tue,  7 Jul 2026 10:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783419628; cv=none; b=BN7C0KOQes0Os5NOEd4+Qlaq3xcjks2AL6MDbG11Z1a62VEi25jdoowhKCX6ew62ZGFY0OFCXFN66WHH39CjW9ElSLH09iqr+N+xqvqWxYgi4qDMUsQmz2oG2flNjSFvuxUol2CSONxSTB5brj1xZr3s7OYQ9sswyU8dRAW087k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783419628; c=relaxed/simple;
	bh=BF6QHr9IERaxUJGLyi9UfdrrpYkPazFlm84hoewfZKw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oIYRGAnLAN0eIFcsnmuPxiw9qDMQdl+qXyS8s8NExee0B+5IbNq3qDurk2q6eMfM/K8uz24uRR+SjNwonk5v5lKKvclCSzrxNtXAWYObMmFp5Gxac3AJj/Ivsy/b6FIsSdpZyQO0ImTb8CqRBQG5Opgl6Xx4vbI928Je93NXse8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W2UHv+lZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W2UHv+lZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E741F00A3A;
	Tue,  7 Jul 2026 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783419625;
	bh=/1C4Wt0mf4QAVu/tAVPWfuZuAk6WIVrygpQsGGgS53U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=W2UHv+lZX4WabMkk1QFfDq1bxiy1rEme1FiQ2AHaHi5cAW2znbCbCqv8eF7gINECr
	 mVNENRF7qTIxSsIugtYJoCtlc0AMfBLRArSZIk281oZ/uPvENh8ZfGd6CYen+UNd1H
	 pT2w8JJwytCAx483S/M9v913EmoTEGs4tKHbDeMTEpJvFN4dcCSirbxIF6K/5wdQoN
	 4TzxqcjwJ7qonh81QXzEfi0s95eS5EviYM3AJxtT88xh+bju2Lv4jsKGYyyw2YqyKA
	 7Z0g22E2hxz6AyooxoCSmBMHrvWAZXM0NtF11fYGOG56rW/nyIB0SppIAGIFOSR044
	 Rc3FVZD2V/C+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198883925475;
	Tue,  7 Jul 2026 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv4: igmp: remove multicast group from hash table
 on
 device destruction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178341960589.1475811.13391372946000599222.git-patchwork-notify@kernel.org>
Date: Tue, 07 Jul 2026 10:20:05 +0000
References: <20260701235014.73505-1-yuyanghuang@google.com>
In-Reply-To: <20260701235014.73505-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, xiyou.wangcong@gmail.com, dsahern@kernel.org,
 edumazet@google.com, idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  2 Jul 2026 08:50:14 +0900 you wrote:
> When a device is destroyed under RTNL, ip_mc_destroy_dev() iterates through
> the multicast list and calls ip_ma_put() on each membership, scheduling
> them for RCU reclamation. However, they are not unlinked from the device's
> multicast hash table (mc_hash).
> 
> Since the device remains published in dev->ip_ptr until after
> ip_mc_destroy_dev() completes, concurrent RCU readers traversing mc_hash
> can still locate and access the multicast group after its refcount is
> decremented. If the RCU callback runs and frees the group while a reader is
> accessing it, a use-after-free occurs.
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv4: igmp: remove multicast group from hash table on device destruction
    https://git.kernel.org/netdev/net/c/7993211bde16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


