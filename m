Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CFE135C6AA;
	Fri,  2 Oct 2026 07:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790926207; cv=none; b=VBvVWk8heh0anXViscMg9x0iQwftABCE4uVA2zHurfvXau4ALoQB6u+22t71XWE32wM3/tgcdNma3uPQO7PriTG3lg58YPQ14gafdmLlChsN16Cmxd3GP8//9RUmaXP1aVv+rmOLTDcAV1JRc1G4tyagmI/SWBVpz1KeXFR4lAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790926207; c=relaxed/simple;
	bh=Nd0fjneF96yIVsp3qnke4j5qEIwLcG9X8KvV/SKsIjk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MeixdCj8azkXjp8oC1nqHsC/VuNKaPCQxwbCXJIi9/F1LPW8F9BtdEmytxc+7AW1sUPWh24Ii4J8ZeWOfG/w4OJTPGN39CHaLG4gw/E5oQjsqSyCmhl8hJvSniXk7QKY3qlqUS9CYXusAQOGsresUcfoS44/3gLNiiTQkM41lgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJC6qRQM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJC6qRQM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120181F000FF;
	Fri,  2 Oct 2026 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790926206;
	bh=QAaLyPv0/0tcql3svo+kfIsNBiiGATP/ZF3KR6QpkW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VJC6qRQMMw3z0kSgpXKlvZTTdDJ6RTmWM9YDO5x7t22HmhGGlsh1IQl+nMMo4pbaM
	 Fmr4YAS/46wmkrVagpHLhChkjtT27bHVMMx1FWXqAZsg+9lr195emVtLPzBHVDYPCt
	 sOKxYLkIIuqPIJPE0hwQiH/UBuVehSPxcPIl+tgGelWrSvN8RmrZBhgB9mrUvapER2
	 7+LcYoTBP9zHOUFJhdwbUrgGaXnYOIB5REKVo1qUPjrK0Uut9NNTjzdAJqL2N02VAj
	 mTPJBNPz3HsZITAUwTkSoF+vvChvGyajlMbTFrB3F3nOqXo/77ZTL3k6JiQhOBMJVK
	 ODi1hDQEJZSNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15C138119C9;
	Fri,  2 Oct 2026 07:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] tipc: fix connection lifetime during netns
 teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179092620470.3255919.5798329949179493943.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 07:30:04 +0000
References: <cover.1790157006.git.xuyuqiabc@gmail.com>
In-Reply-To: <cover.1790157006.git.xuyuqiabc@gmail.com>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: netdev@vger.kernel.org, tung.quang.nguyen@est.tech, jmaloy@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, ying.xue@windriver.com, paul.gortmaker@windriver.com,
 tipc-discussion@lists.sourceforge.net, stable@vger.kernel.org,
 vega@nebusec.ai, weir@nebusec.ai, xuyq21@lenovo.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 28 Sep 2026 16:24:37 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/tipc/topsrv.c. The PoC
> supports --userns (CLONE_NEWUSER|CLONE_NEWNET) for an unprivileged
> user, but the captured traces are root mode.
> 
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] tipc: destroy topsrv workqueues before closing connections
    https://git.kernel.org/netdev/net/c/3acdd44385bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


