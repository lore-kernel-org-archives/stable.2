Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F65A2E1746;
	Fri,  2 Oct 2026 00:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790901008; cv=none; b=BQ+q7+Ff8dG7nx41WuNfZ7QYJN2J/29cVkuRV5sGsC0MhCq5LnwPMeABapB2JaBJ4qt0hqH2GNyiCG3kpacN9+E17BCCpY1/AEuP4OaLE/q5QiJRHBw3S5m1bS3aaPSRid/FAsDqD0OGPK8c0rMu3xdoqaD6trSB2Wg1s50XB1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790901008; c=relaxed/simple;
	bh=NZFd7UWntHHADC9Vja86uW6nk0ZTcrQ2TzpLvDX4LJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RupwsQgcYPbEsGy9IyjZM81g5wUlQolh9mBgzQjITabQHsWHA8OjNFCDi51CZ3/7cbQhqyOgcKl62jNvKE7MIcSaRORA51ORJYDceMo0H6r0wymQJbWV3NthPXh2eth6uneLWuTVN06yFpXcChl1On8MgAzW2TIVMxLJ3gd2diA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/tHw/6Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/tHw/6Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830A51F000FF;
	Fri,  2 Oct 2026 00:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790901006;
	bh=WaQDoNsWcwlQhPP7PHRLC3BVkRiglB04QToivrC/69Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L/tHw/6Qg/27Hl+hrp8ksdTqGLAOQiP8Nnmf0hIrdhQNYLSlfJ6zWZTqHvr0xRUsE
	 feSuC/PsMKN1ET3xbHEsh7V0xyI2R9gc8L4k9dadJpxJZ5sEAsscywS5OCOLLq+7zZ
	 Aq3Zo98aEbc7o+hZtN21/a//mHWZYrXLN03gqG1k3hRamHyepGY0Cb0CxiLKVcLl6o
	 HmFGWRo76/7aVVmUW4BJ6SlSPFlKUHQBDKNAdjQYSmFra07f5Wla+Elt2fggemEkvJ
	 rqwYBfwC+3xScOl8ykEp+psFmhEGVoIPm0UoHfs+UCAion+nBOcb8kE6nuHb3qc2eu
	 MJQK7vRNX5rZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7739D381197C;
	Fri,  2 Oct 2026 00:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tipc: hold a reference to nodes found by link name
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090100508.3156447.17895622143731503956.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 00:30:05 +0000
References: <20260928161246.1895273-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260928161246.1895273-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: jmaloy@redhat.com, tung.quang.nguyen@est.tech, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ying.xue@windriver.com, mohan.krishna.ghanta.krishnamurthy@ericsson.com,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 29 Sep 2026 00:12:46 +0800 you wrote:
> tipc_node_find_by_name() returns a node after dropping its RCU read lock
> without taking a reference.  The LINK_SET, LINK_GET and LINK_RESET_STATS
> handlers then lock and access the node, racing with timer-driven cleanup of
> a down peer.  Generic netlink serialization does not exclude the node
> timer.
> 
> The following interleaving can leave a handler using a freed node:
> 
> [...]

Here is the summary with links:
  - [net,v2] tipc: hold a reference to nodes found by link name
    https://git.kernel.org/netdev/net/c/17e73bae400f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


