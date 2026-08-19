Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B19A13D6682;
	Wed, 19 Aug 2026 08:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787127082; cv=none; b=A9q/56vdivYw/xdM54oNtiPt6oufHjFswDdW/sWQjnyTPncxozOpyaAJF6euczlgw/5CLBdm/zkQVxwY0vN8uB+ssciHlSkSd0QNtcOXDkWboxljDnUGKAZK6drEi4DKdUuphThlLskTiy4N0q99QlFM99jKAZIcnu+HGyEo26w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787127082; c=relaxed/simple;
	bh=VF8wk4DO3nDBthkgYFWg2WJwxHbTw8J1y0IaWlC8rdI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=izpNBx5mT4p2pYcRLXmMfoeoW97kwZnsC/rH0bxQW3lp8xk969J8LmPe2LGIb5+Wzkj4qzg0Uoll5D0hdlWzFwJHohX2DDVSeDkzvcGioOKlgBfLqxOjcPSKshulzZ59r5ZOJ8Ifyi5SEwOdAhBERfi09EllgYXJwODS0a0RLaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKdiq+5I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKdiq+5I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2FFC1F000E9;
	Wed, 19 Aug 2026 08:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787127061;
	bh=ZfX2dr5pD+KYvTUNAwivqli+kg4ObqGcu5E3bue+BTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LKdiq+5ITa5RCkThfYFRrcoqn6zq4SbjdrIjr1KWoYXc8IKn/PgZB8rq7LaQ9J3ZB
	 JwZM0IuEY7y4cUQRQRnxOpA0iwFxj+pJT8KdExVYU5R5MbKXXRSAty3ad0rfAHWtKb
	 7Rz2uBaIXn2DqgYyeNvB9HuWzv8uWjEBD17VcrmzZeaWL+sjCmk41GfET+WKxNjeK4
	 fUq3OcAcTp+3FgHWV5dGG0fhLovsNTj+YmtV03swIPMUUqGqsXf7OdZjC3YiODObGs
	 zIZYezhX8pfxtzJ1d0ElYTSvNtixCqSI8SIRmRq2ViLxP5oPZJs1SjBXF5MiQgwMCt
	 LdteV9Lev4jkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19912392720B;
	Wed, 19 Aug 2026 08:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: use RCU iterator to dump route exceptions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178712701263.2921663.3448660025445141729.git-patchwork-notify@kernel.org>
Date: Wed, 19 Aug 2026 08:10:12 +0000
References: <20260815084651.69477-1-sigefriedhyy@gmail.com>
In-Reply-To: <20260815084651.69477-1-sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 idosch@nvidia.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sbrivio@redhat.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 15 Aug 2026 17:46:51 +0900 you wrote:
> rt6_nh_dump_exceptions() uses hlist_for_each_entry() to iterate over
> RCU-protected exception lists. The caller holds rcu_read_lock(), but does
> not hold rt6_exception_lock, so rt6_insert_exception() can concurrently
> add an entry with hlist_add_head_rcu().
> 
> KCSAN reports this race (irrelevant details omitted):
> 
> [...]

Here is the summary with links:
  - [net] ipv6: use RCU iterator to dump route exceptions
    https://git.kernel.org/netdev/net/c/564973a259ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


