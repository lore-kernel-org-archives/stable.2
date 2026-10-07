Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8AF1C3BFC;
	Wed,  7 Oct 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791335408; cv=none; b=HHgvMSZSQ6n/YmhLzhYzXXyN9RqQqwVhHWzH/iU6ynGwRn2kacmATRZSwIAEEj7NwSVFDwxXv5EiQ2ETEhT5UA+N5b0ysAIkouvA7WwSis4XsvcJqBnmOdrYY2kvZ4bC7h3XTys+t0prMR/TuqpOqILLYj3i72L4uUaUehd0zqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791335408; c=relaxed/simple;
	bh=cQdcxRpdoeNpjsaYHCEW+b01lYwJIMirtnRbKOc94+k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h89NhUZXRsiYOKThifgnI1rs891Ezk+S3luoQJjCLbwgjCSfVLsZof4ZwyZUBESYKkCc3OOVT14eo9SxA4uf1tpiCiWXprxYOqCoxZfMmp2QlTOHXIyh0ZckvyLPl2Hps/0h7wowwPOY6uUUC1VwcyA9/OooHnAj2XYOFeLktV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OWBtg5U+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OWBtg5U+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7771F0089B;
	Wed,  7 Oct 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791335406;
	bh=L3gcB5mm6CS7zv1bVH8eLb8wFAAfCibYhSkNA042kqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OWBtg5U+ewvUguAeFEybkIq1Zke3CGQeIx1ktOXhV7z0c9/m99kgh1qUvOc+0pMOa
	 EaF1Gf5/nN00ftBjnQ4XBAA1NRdSBTEcheCrfISW1l3I3stgO3N0f7DL2bHy17QN3J
	 iQ/h22Fb36uHtOcLKUCS+OlYDxaXTTNCfgL82Jn/UpZkcvTKg8OztU2mGE3aIA3DBh
	 OL7J4m0lJe4BFKipVnKQB/EPwBSuGOGpGedU8s9Eeep1+yHN85kbm0MT10p69WQ0Zk
	 6m1pQUUyfxrObbwaAo9FF5TLn7qsNaJ+NsmNDf9nKPC8dqK/F+DUBl/6baXKVfpfjZ
	 SI36atb/vub6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44973806541;
	Wed,  7 Oct 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] net/sched: cls_route: reject change with no
 routing
 attribute
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133540553.2853870.2338348628143032646.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:10:05 +0000
References: <QDISC-0JB3.v1.20260929143022@mojatatu.com>
In-Reply-To: <QDISC-0JB3.v1.20260929143022@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, horms@kernel.org, edumazet@kernel.org,
 stable@vger.kernel.org, hybris@mojatatu.ai, sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 12:32:00 -0300 you wrote:
> route4_change on a filter change that supplies no routing attribute
> at all (no to/from/iif) reaches route4_set_parms with fold set, so the
> handle-mismatch check -- which only fires when creating -- is skipped.
> nhandle is built as the all-wildcard bucket (0x8000 | 0xFFFF << 16) and
> the filter is rekeyed to 0xFFFF8000, so the handle userspace already
> stored no longer addresses the filter. (The netlink reply carries the
> new handle; what goes stale is the handle the caller holds.)
> 
> [...]

Here is the summary with links:
  - [net,1/2] net/sched: cls_route: reject change with no routing attribute
    https://git.kernel.org/netdev/net/c/b72e025ac556
  - [net,2/2] selftests: tc-testing: add cls_route no-routing-attribute change tests
    https://git.kernel.org/netdev/net/c/6fa2e7db99fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


