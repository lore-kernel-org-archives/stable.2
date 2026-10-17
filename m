Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB0B38550E;
	Sat, 17 Oct 2026 01:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201218; cv=none; b=l7RBg9/c2K7HhQoSZ5DzTTnBK9VkVbmS8ve5PwztYcgz2qwKHqrYE3nWF3OTh78j+J3Irq08mD+V0WOkQrfXVJKzlj3qDq7RElrbHxfURY9bSUncFEg1OXjs3yz473FCJAEsYDs56mDO2xg8pLhc9+pw3Cv77aJQNxIk2Z7/2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201218; c=relaxed/simple;
	bh=OjI94ysJpX2K5r1PNJ5d3g4UcWqb3+ItTogJjArhhFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XA5vpaI2GD/TBRQZSlOOPShC8t53raW1d7l/BbcapWL9KsU+gCVMWiqf0piy3Zr6l+5cXM2agp/bxCCOVZULBfhivkFxnU/apWNZ75BjdY4A3O7QoA7mOrcDp6LlcZSpyF9ESmCobYSjmdhjyTowPHv3jNZi0qYEtkJvmaCZq3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MgK09Mtn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MgK09Mtn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 087781F000C6;
	Sat, 17 Oct 2026 01:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201215;
	bh=n9nh2kG+i/gBx9kwNBoZa3tMJRwxBESHMVixHtegqJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MgK09Mtnqwa0HukbW+ENA3arUwTrqUX0VXHtraocWgB+bxY0jTE/Yl7FNw5xyZi05
	 l0yNp1vF3dFz7J096LlfGFDDzcfZ1ueHXLgjW1yOTntzNpMOWia0teXUME1e3b+GvC
	 Yf5mY7+Rlyg3laaD2qWTr7m9M3hcete5TnW6b0SFrlvTLu/XkYKuaOYj1ummm32ic2
	 QYR0bN2kYuEjQlGl9FWUtsZnmugIdoHO6F/Bu4V8FewWkIPFvP/m8ScGFz+qs3a1D3
	 PeXgKDWS8I1oiGj3GcZuvBoGNc40lTLvmWHTwJjgkw9jes00pZTgqBx7HYRwIGZ45O
	 evOh/AC0EPd4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F160E380CED9;
	Sat, 17 Oct 2026 01:40:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/4] mptcp: misc fixes for v7.3-rc8
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179220121377.1050340.16852423271530294795.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 01:40:13 +0000
References: 
 <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
In-Reply-To: 
 <20261013-net-mptcp-misc-fixes-7-3-rc8-v1-0-932c9b182fc7@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 quanyeyang@proton.me, stable@vger.kernel.org, caoruide123@gmail.com,
 kylebot@openai.com, david.lee@trailofbits.com, vega@nebusec.ai,
 weir@nebusec.ai, ncardwell@google.com, kuniyu@google.com,
 daniel@iogearbox.net, kafai@fb.com, sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Oct 2026 16:29:18 +0200 you wrote:
> Here are some unrelated fixes:
> 
> - Patch 1: fully reset the msk state on early connect failure. A fix for
>   v5.9.
> 
> - Patch 2: avoid using the subflow status bitfield for a field that is
>   used under the msk context, not the subflow one like the other fields.
>   A fix for v5.12.
> 
> [...]

Here is the summary with links:
  - [net,1/4] mptcp: reset msk state on early connect failure
    https://git.kernel.org/netdev/net/c/29afe67082b2
  - [net,2/4] mptcp: fix subflow bitfield misuse
    https://git.kernel.org/netdev/net/c/7538fa33bb2f
  - [net,3/4] mptcp: hold MP_JOIN msk ref when cloning reqsk
    https://git.kernel.org/netdev/net/c/c9c90cf437a9
  - [net,4/4] mptcp: fix MP_CAPABLE token migration when cloning reqsk
    https://git.kernel.org/netdev/net/c/2093bc7fa500

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


