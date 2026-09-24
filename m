Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B98363D1CA8;
	Thu, 24 Sep 2026 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790215880; cv=none; b=mOalbgbL/+RS37JlB77t17UoG9phzKwmcZn1VVh8lukujlnldqVIeRil3ohU/N9xtG/Ot78C+cPEgdYoR14A1rBay24Fz4DXdF80Ye2Hc/LZd1ZJXr09Xyq6WtB5hmn+iDXF/Doep4E2aZ/gbBfPmU8IewtMMzHY+caAxrXxU2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790215880; c=relaxed/simple;
	bh=mBu0WSQ/AwjUAODewwxl5iIYor0biSbLUUWCAZyhWuA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lAh85UrFjPtolCUYc8tauSFmjaKF9Cg1Nx5O4uGTALk1Wept+Aj1Isj2Wr2X76WJN9q7vSjOb3bGZeenoTlr5OKLMvNK0nd9O0TPKQeLj9jpkvVXNcF9RL+KI8GNRfo0Lq6bpVHVQ8TexPqySgDHUjV2H0gepIsiUrNjZC83+LA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfvQFj5u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfvQFj5u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BE8A1F000FF;
	Thu, 24 Sep 2026 02:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790215879;
	bh=18HjCD9A8+DuIyl1hezJHD5Af2V3TogDRTGby2Iruic=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lfvQFj5u7aGWmNbUI5l+4BUDiN5L4A/brjtLZToiPhjJ6/HFMYyxUNG1AzIi9ShT9
	 ttQgnH0bQULp6GJjkx0W9tAoCsEapMDSkthYeyVGBNsd1pXJ7pkIgYjj0tLMqGWRvr
	 iO3B9PUbA+4ry72Tg4Spfi+QGSqs8296/yyA8pwBvvnj+RTmEgCIttFCFRsDneku5w
	 eBucFsR6v/++tR1kjU9VgKKzQ1WsEPpjhcrRRLhB6EX/Z2KzJb3pmmhZzmIosn3x43
	 UMdoR5b9wi08MuGpVLjw9Uj0fgvF0hTWMaRXbyZwbXAJcm6ZcaQobo5dYFs/+0I8Tx
	 h/ObqkFDbiJmA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1990039E9611;
	Thu, 24 Sep 2026 02:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] fou: reject omitted FOU_ATTR_IPPROTO on
 FOU_ENCAP_DIRECT
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021580864.1277764.3665747130369583062.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 02:10:08 +0000
References: <20260921045920.1613098-1-benquike@gmail.com>
In-Reply-To: <20260921045920.1613098-1-benquike@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: kuniyu@google.com, hangbin.liu@linux.dev, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, therbert@google.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 04:59:20 +0000 you wrote:
> Commit 7a9bc9e3f423 ("fou: Don't allow 0 for FOU_ATTR_IPPROTO.") added
> NLA_POLICY_MIN(NLA_U8, 1) to fou_nl_policy[FOU_ATTR_IPPROTO], which
> rejects an explicitly supplied FOU_ATTR_IPPROTO == 0 attribute with
> -ERANGE.
> 
> However, FOU_ATTR_IPPROTO is an optional netlink attribute. When a user
> sends FOU_CMD_ADD with FOU_ATTR_TYPE set to FOU_ENCAP_DIRECT and omits
> FOU_ATTR_IPPROTO entirely, nla_policy validation succeeds and
> parse_nl_config() leaves cfg->protocol as 0 (from memset(cfg, 0,
> sizeof(*cfg))). fou_create() then creates a FOU_ENCAP_DIRECT socket with
> fou->protocol == 0.
> 
> [...]

Here is the summary with links:
  - [net,v2] fou: reject omitted FOU_ATTR_IPPROTO on FOU_ENCAP_DIRECT
    https://git.kernel.org/netdev/net/c/d22609f3d13f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


