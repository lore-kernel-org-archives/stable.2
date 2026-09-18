Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7987D140E5F;
	Fri, 18 Sep 2026 00:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690273; cv=none; b=I8kmQvY1zWmFs9m3XT3v7g+kmGWU4sHYkVB3vQgrAIC6OHDfild8JHzNH1nI8XF2CMVYuVPdXA2CsCVJ3K7E6T+sb2GGFKz2FPL7bzMyAIZTcnTPII1VhvRbirrYk1mobWgWgDKGEoXo4axL5FmDKP/gChphSe7MtMJwfDFu9+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690273; c=relaxed/simple;
	bh=QnHVE7/+jXfvLHKUeLIxfFVDN7S6avvCPrex7Sgj7yo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RAzExbwVi8yIYE04gK+2yEivbYeHIEIis5M5/w+7SgIRzFDGGTZPuA6BwXNJftcLz5x3xc8IW+uILfiOdJRTsyAJLBdz2T6heWNsOJkZMImWdekps1wYd5hhNxqph+o6bMwby9CfiCR6lgVlrTd/WUbCSXbJx6tTF7IK9zxDLTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BThgLsCC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BThgLsCC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA4E71F00898;
	Fri, 18 Sep 2026 00:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789690272;
	bh=UaVKucp9ESmc7Y/Ub3lqEQtQxufHm5lPuwAfY1hSqNs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BThgLsCCT2mG2JBigxSL6JYW31N/IV3jFmgEi7Sjw1yQIAfJs82ACC2zEHuGh5TQ5
	 47oip6papcOzai1gMO88g52OuKuY7/TCavFKO1+tVMXS0ri2pQ1ZhTZ6/PGpBTed1l
	 Jbz4j3PXlazhtVf3kNr7v4kmqWwxZpfQ9rsQLgV3fGdGkGFhlGN4xJf28uOm7rghd0
	 vj25TJb7kD9pohYXVwsYP8R4eU2K2I3qNRhpKmMcYVYgWRc+wPy3ws68Cal216ZrQH
	 NkPF4WIiLqi8hCDVWf6EBSHyUIhWnbaAh4Ew+H2y3U8c0VMN1X+SwTGrC70ro/f08e
	 gCl7HyoJ7wK8g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93CA9380820D;
	Fri, 18 Sep 2026 00:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: cls_u32: fix manual hash table handle
 IDR
 aliasing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969020513.191233.10717761906823039417.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:10:05 +0000
References: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com>
In-Reply-To: <QDISC-LQFE.v1.20260911041746.1@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 alexandre.ferrieux@gmail.com, stable@vger.kernel.org, sashiko-bot@kernel.org,
 victor@mojatatu.com, hybris@mojatatu.ai

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 06:01:14 -0400 you wrote:
> A u32 hash table created with an explicit handle ('tc filter add ...
> handle 801: u32 divisor N') keys its IDR entry on the raw handle, while
> the destroy paths free it under handle2id(handle). The two key domains
> disagree for handles in the 0x800..0xFFF htid range:
> handle2id() folds them back into the auto-allocated id space (1..0x7FF).
> 
> A manual table therefore leaves its raw-keyed IDR entry unreachable on
> delete (a permanent leak), and its delete can drop the idr entry of an
> unrelated live auto table. A later auto allocation can then hand out a
> handle that aliases the live manual table; u32_lookup_ht() first-match
> routes lookups and TCA_U32_LINK for that htid to the wrong table.
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: cls_u32: fix manual hash table handle IDR aliasing
    https://git.kernel.org/netdev/net/c/0a5f5d9e94de
  - [net,2/2] selftests/tc-testing: add u32 manual table handle IDR tests
    https://git.kernel.org/netdev/net/c/960ab631f3d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


