Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D881B16A395;
	Fri,  4 Sep 2026 00:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788480668; cv=none; b=fg4xpvBlyne8QHgcBFICvPNuXq+xLTslwwULTweXJ6XDDqq3rOeOMlhhVFOIxdxATEoryq6E3yR9KBUOH1UMBTbCu2DJyoSJAS8aqomwBgIV8OXj2WfwV0WnOFb2/AFDbC63K7dtklEkaV804U2afmxP5hVJCrOzbDK7wWqhZws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788480668; c=relaxed/simple;
	bh=Zy4Pe/31sCmar74qhSVi+J/sWWHLBlupWQq6NW7Q6yE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mErQUAdufgZJFNMLSP67SYMlLcXapP0l2wZ/u0hkIUxdzpSyrYQwgAZccR+eFIJhPR5/6iyKfgA732P5OrTmZ+ZlbaH3CJ9bOeSb3zsni1dfgQ803rK8rBbVena6Ok6LsstGMISHAHZ+u3ICP6FLFbCjXV9suaRR01MtLDXjTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YLbfX8BN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YLbfX8BN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78A321F00A3D;
	Fri,  4 Sep 2026 00:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788480667;
	bh=UmKCDy4rbTq5qHNHOxJVlHn3AKbwyfzyTAi+5rJBWek=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YLbfX8BN3V+/hfOAD5100V8m0xSsytyIAtxGcQjsz5AkZJKqLiRUdEn0u6qBLXm5v
	 prhoB0kLkYhGVRP7lbJIRYoMPX+mxK95I7DdL+GFMaFPOyUdiXHVJ+qHfu2yHIuoCW
	 Jt918u3In2rHDKia9ddAGVcEtVuzmproTHDk8/VwAS9BtszAJofVc/Ob/1NBeEFmm6
	 akLayqrMspX0BFPPV1zj25TTCkfQZXdAiKzizkdoyxgpymZsqvV+TEJfxbKSH5JT3D
	 YJ5ktPvFKZ/yl8r7vLxAhUpV7P/Umq40Ubjw7zEE5D2Bq3pCMXszdPf6fXQDvdBJ16
	 E6h2NE5aKAcVQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D08AE38119E3;
	Fri,  4 Sep 2026 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] ipv4: fib: bound automatic table ID allocation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848060839.4080441.2295691911091405845.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:10:08 +0000
References: <cover.1788258884.git.zihanx@nebusec.ai>
In-Reply-To: <cover.1788258884.git.zihanx@nebusec.ai>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kaber@trash.net, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Sep 2026 10:59:03 +0000 you wrote:
> Hi,
> 
> fib_empty_table() scans table IDs from 1 while holding RTNL. IPv4 tables
> live in a 256-bucket hash, so a dense set of IDs makes each probe walk a
> growing chain. A table-0 IPv4 rule add can therefore stall unrelated
> netlink operations.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] ipv4: fib: bound automatic table ID allocation
    https://git.kernel.org/netdev/net/c/efdfb1e27a33

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


