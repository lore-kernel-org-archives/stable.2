Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812C36C9CC;
	Sat, 17 Oct 2026 00:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792198212; cv=none; b=BJM+oayZL9PcURh+cNHwZEJx2fBX9HkL7dCcRNbHNya9mlXwn4DGavdL5igtYxwMLLs2AzyBMRgMszv4I6F4voQc/TklXgz1hw0QUW1tfXYWzJ/ZZgwB0flgC73zW82LPlgtTlRW8dmRVzB7q0vPoe6X1qAzQGi6J+xHId+VX4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792198212; c=relaxed/simple;
	bh=W6yq8O3fEZIHpqqHwRdqGSFRhvdet1UmGZxYV8Euet8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f/33QV3Smegbq2I25yd8wVFCYMIxC7tkOIUSuAH/gRLTaQKbIiEvZOCO/cNfLy13LLLuqYex11me9KS8UU3txj5ERBUjj2SZU87DsobTPvhsK9W/00EibAqFbqdREbcgwwcoBG5fZdaD5WqiFlC7ZxDsjL72o++H50NGkg44ah4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+vCcdtx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+vCcdtx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 072B91F000C4;
	Sat, 17 Oct 2026 00:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792198211;
	bh=WSsewT0O7zwyZFVvwibqnIyNUpBWyXCyrZ1sLCBPw1o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O+vCcdtx7VUaC21jKUiwy2kZs4LpJUKriSewon78iPaB3pESPuvLERis5NNdSBWe7
	 +lm+QJgGaJ7fCwYBlROH9TB9SLgeRpaT8aaXEukSOx4GBpeKOpX7OEi0yHckxwAsMs
	 z6JOumHEWPvtLFwArTVObybPwCeRnYSZfXkCHs1gvPrd9Kis65RkLQjnbe6m4qBy6Z
	 0qHgYd3Tnr1s66KZQJHiCfsIDttSTHVbADHQwcwP7pb+n9uKFVYjj9G5yW6IPN4LxA
	 6EJkh04S5fS6uSBARvQ8RWe6vNkYEZYl+ew4tM7sZuskO40/JXXxjzQh+ymFnT/DwD
	 Lg6zHrLOnGLUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1514380CED8;
	Sat, 17 Oct 2026 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipconfig: fix use-after-free of device list after
 ic_close_devs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179219820952.1034269.12970180804161410066.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 00:50:09 +0000
References: <20261010085003.3261587-1-bsdhenrymartin@gmail.com>
In-Reply-To: <20261010085003.3261587-1-bsdhenrymartin@gmail.com>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: vladimir.oltean@nxp.com, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, kuba@kernel.org, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 10 Oct 2026 16:49:58 +0800 you wrote:
> ic_close_devs() kfree()s every ic_device node but leaves the static
> ic_first_dev and ic_dev pointers dangling behind.  When a DHCP
> negotiation gets an OFFER but never the matching ACK, ic_bootp_recv()
> accepts the OFFER and records ic_dev = <list node>, the round times
> out and ic_close_devs() frees the whole list — node included.  The
> next failed retry round runs ic_close_devs() once more, evaluating
> 
> [...]

Here is the summary with links:
  - [net,v2] ipconfig: fix use-after-free of device list after ic_close_devs()
    https://git.kernel.org/netdev/net-next/c/befe96ed37d5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


