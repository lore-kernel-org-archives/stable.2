Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91294E73D9;
	Thu, 17 Sep 2026 15:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789658499; cv=none; b=Rd2SY7OpUgREXG4Su5xqebgnH6OxJgqmubHBpB82MwLdMx2WFUca2dLq3b9V1GLSYRh+yOItwJI9PjECQrgEF3IyDAVHWI4ORGciak0Ih7EF0ZBKd3BO7HNZP6/Eo/2IQsGkwa4kCCz5WJ9VHVNVGVotYN4r/rtKNEOB6ENeQZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789658499; c=relaxed/simple;
	bh=EoDQYcmlmzYWhQ14Ug8v9jjj2b1NvYIykJ/2zcRxV8I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dbWygP6akxXwIY1BouRYvXKXIzgUpNembCHGG06Y4UuNo+EzCi52JjQ8z+TNhS1H32uf1mdTy6/ri9xjeg/bUmftrDpSf9hgd3PPV0CChIrT29WVpKxdjIdPG9LFBwdHVWv+MBgfGPZsAwZ53CFSfLJPAJd7DX8yVssvjYH/8P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1xurqCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1xurqCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08D741F000FF;
	Thu, 17 Sep 2026 15:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789658485;
	bh=ZAUtXlQuc8YNeon2C/KLEgN1HKZv6V7DhtdVbe3voOk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T1xurqCX8DQMbCMfPSg+KcUQyB9VUGVVpW1G39zeJI/O0C0c6aNiq7U+qDhlx9kUG
	 o7L/LRzhGdlbOxRml74p/vzDhNrBQvrJHLBdqvWj+NqR57/ZkWqq+YlAOMLgmW+bAC
	 8psP/9FUlSMjybp5p7TlaBm3j9MXZ2moIZYZaDrYNhQzqH+kEvWSuP7+h9pn354VIg
	 jJKlWT2kC/5p4L8cnNr0/Ha53kqbKocYhD0pZNzLUbUJjyQYfSqn5ZSzxrgIWGZWIp
	 kTAc2tfjt/Infew3hLo2z5vp0lkBvsPTLJmf0XPPRiiAxEgRcGuYmE7ufGP4ZvpLiP
	 9J80QnlfZjgxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A073811976;
	Thu, 17 Sep 2026 15:20:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] mptcp: misc fixes for v7.3-rc4
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178965841863.3702673.15491935848418424018.git-patchwork-notify@kernel.org>
Date: Thu, 17 Sep 2026 15:20:18 +0000
References: 
 <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-0-0cf5c72667c8@kernel.org>
In-Reply-To: 
 <20260917-net-mptcp-misc-fixes-7-3-rc4-v2-0-0cf5c72667c8@kernel.org>
To: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, stable@vger.kernel.org,
 xinyang@anthropic.com, shardul.b@mpiricsoftware.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 17 Sep 2026 15:05:56 +0200 you wrote:
> Here are two unrelated fixes:
> 
> - Patch 1: avoid unneeded actions on subflow reset. A fix for another
>   fix introduced in v6.12 and targeting a commit from v5.7.
> 
> - Patch 2: close a possible race when scheduling a closing path. A fix
>   for another fix introduced in v6.0 and targeting v5.10.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] mptcp: avoid unneeded actions on subflow reset
    https://git.kernel.org/netdev/net/c/2b0f561f21b2
  - [net,v2,2/3] mptcp: close race between scheduler and state change
    https://git.kernel.org/netdev/net/c/42064de57fb8
  - [net,v2,3/3] mptcp: fix bad accounting in __mptcp_subflow_push_pending()
    https://git.kernel.org/netdev/net/c/f3ef03357396

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


