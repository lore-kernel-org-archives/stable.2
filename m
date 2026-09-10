Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9E004A485B;
	Thu, 10 Sep 2026 13:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789047068; cv=none; b=TA90G/0cTRG/y0uAH098hWeamAppbM9rlb4SCZg7uFRf+5+NVmZ0qg2hy2d39bfR2+I6sf7OslhDB1DQty/qsSesZgEFSyTTCceGqxqY3Os/SwDzJDo0dppR75Io6drgh01nu3R15Ya0CBy22oPqwO/pwFoLoQi3kxZetZNSkOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789047068; c=relaxed/simple;
	bh=r78VSJQbgNsXqgrkVLFN1nVIfb1vA9A6FI58i4NW2rg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oNOdK2s7Vi938c1p3leiwwH+ogkrwqMsp2PxzU69fmBmd2blCqn2FIEfTNW9iv+lyngEdFWG1uRMXIvRCbmXXLGFRflVELzoxJre4WGJ9092QkexV5NoSxjCWV+ofZ41vWwJOrw5aKVvTXnGiYKflOauu+dUpubc8OhARl17ev0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWtPK9vh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWtPK9vh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 595491F000FF;
	Thu, 10 Sep 2026 13:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789047066;
	bh=PFXRqaE3YXcSZGppKYCptpAv4MYpPmaE2fMJsIIP7H0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nWtPK9vhytS/BfzxQAgngJ/vnhILxOosf03VE3yH0OQZjLguJ4VUOBhJzcieRa6yN
	 +9Kj0AH0WHCOZwJ1nFKOmFBet6tAWcwpaOc71SRqIKEWKOQzEG3I8COczH4Aoy//GL
	 +GWqE97LNc+C/zuZLaYAYYMTc95hYDtj/BrSjYgtMlft9EJmXXOPNA9iNaVsM6qbYM
	 b0gCe83MY3EucXRTHL4grifYFr6NtA1eC1yjRnN9OGVbuKCWLJvU6GqHsCmIYLFHuU
	 Bf2mTYUNFHJY/ZA4x3/lIAYIs0b4yk5Jq133CYc+PLF7Yr1Yr9cMomrJQU0xfGYITC
	 7lme/UgcDMonQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197CC380CFEE;
	Thu, 10 Sep 2026 13:30:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: net_failover: Fix the deadlock in
 net_failover_slave_name_change()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178904700389.1430169.9302164279799283543.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 13:30:03 +0000
References: <20260908040708.3972058-1-faicker.mo@gmail.com>
In-Reply-To: <20260908040708.3972058-1-faicker.mo@gmail.com>
To: faicker mo <faicker.mo@gmail.com>
Cc: stable@vger.kernel.org, sridhar.samudrala@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  8 Sep 2026 12:06:29 +0800 you wrote:
> From: Faicker Mo <faicker.mo@gmail.com>
> 
> This is a sibling fix of commit
> b84c5632c7b3 ("net: net_failover: Fix the deadlock in slave register").
> There is netdev_lock_ops() in the upper callers, so using netif_open()
> instead of dev_open().
> 
> [...]

Here is the summary with links:
  - net: net_failover: Fix the deadlock in net_failover_slave_name_change()
    https://git.kernel.org/netdev/net/c/985a663bf007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


