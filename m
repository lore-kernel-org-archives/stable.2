Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC0903515FB;
	Sat, 22 Aug 2026 20:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787429460; cv=none; b=spgSlfqah/OOEfRGqSaEwekGMX7of62krMGGMUUp0onmkWs+8BTJ+20GEfwyDCg64IYF6KbHT2QLVy1ywZfvlSWBS7lOICBkOCoNvLrzDbaPVHTw8qB8E0SASt+q88fnFNLI5DmO8FYFNz8EVRkk3Wywk4mLw3SFfRd86u+uR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787429460; c=relaxed/simple;
	bh=5khJHWdcWYIACRK41K3hC600pm5yYsM61DIkK0NeQtk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OqmaVZPiQZArSNlrby6Tmslvme29rP+12tNvkNsJSFdF0aeL4lnwr/RTDmlTYvvXsMuvP9vnTV1zhErKzD1rILE1dthSRAxABmXYnoXzdAsYAZDmcAxL8WgW0+tDXysQIyayc+4Mm0UJ8GHWOedyRgVDG+Ouu1vr/LMM74NS35I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VzPAg69A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VzPAg69A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 531C41F000E9;
	Sat, 22 Aug 2026 20:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787429458;
	bh=L84wfsmH/CALgLVUn56gri7GrPoqM/XZHImyKHDI0uo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VzPAg69AdzgXh0Vhw/RLXyDyLIfvSc/z3UP/o9lh0Kb66T+66hMlITfOvLFEmNg9M
	 12a07bQ6+wx2CCPfDpMZdpcvwqul8fWuzvtWW7o/s+wFNxRZ7VmQuDElGXiPTPMR8e
	 xB2HLIxYniLOaGUspjIGGiC7M5Ov5ADorCRmY6p7GUWun9IciE4wQtyt7RoEjrkuBd
	 OhqbPsX4dx0tvlF2mkNIl9QzKafkj/fo9QhPKo+f+auL5r0i9YI07Nrf6T9QAuBc8J
	 pihud91TZMEl5lmzzgHELGb6OvbKO/plDJ4AJVUR6RID2Jmf0WRVe4vo6pgc1T0qIY
	 S3rzgi2pX807Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569C7380CEF9;
	Sat, 22 Aug 2026 20:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: account classifier filter allocations to
 memcg
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178742940689.1814690.7978395844526546815.git-patchwork-notify@kernel.org>
Date: Sat, 22 Aug 2026 20:10:06 +0000
References: <20260819143733.57538-1-jhs@mojatatu.com>
In-Reply-To: <20260819143733.57538-1-jhs@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, vega@nebusec.ai, victor@mojatatu.com,
 takis@issaris.org, ast@kernel.org, daniel@iogearbox.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Aug 2026 10:37:33 -0400 you wrote:
> Allocations in the tc classifier *_change() paths (filter objects,
> per-CPU counters, and per-filter aux data) use plain GFP_KERNEL without
> __GFP_ACCOUNT, allowing unprivileged users to pin kernel memory outside
> memcg charging. The shared tcf_exts_init_ex() action array allocation in
> cls_api.c was also uncharged; this patch closes it along with the
> per-classifier filter-object/percpu/aux allocations that remain
> unaccounted.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: account classifier filter allocations to memcg
    https://git.kernel.org/netdev/net/c/1beb81947eb4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


