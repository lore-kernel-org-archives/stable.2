Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FF144212C;
	Mon,  6 Jul 2026 10:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333227; cv=none; b=L8yDuIebbq4xTGsTykgym8OBRzttgpzUoWKK4fY99Da6YgmO21tGIoyal8GYucG8EvEcR82cm4ytOMZV7Axnmv8jVK4W6x4Ymsvh+6E2FbHcEfH6L1e7r2C2/lEsFD6vzAPYN007evjRdyVm5CPy2jQcF5FG+OkzrJknJfFjlJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333227; c=relaxed/simple;
	bh=TbS4whPA7BqetYpEMyEfBenVEo1dobd9dMMAgwfY94Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tgrgELM0DyyUtN89EcqncC3crXPWmOc9oMMP3pOqCOyzdZQKdnhpTXk23pkgYvybSHt12JxgkQy0V+GmiM8SR5lcHPbucNiD2+SX7Wppo4qJo8FUc7gTiBXSiRbJSVChcGWPioIVfWTC8uASYR5SyaaRwG/EM4WsATIpg9i7rHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQl8/0sF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BQl8/0sF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3241F00A3D;
	Mon,  6 Jul 2026 10:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333225;
	bh=pYbEhN7G2VytXVvQ6vuXrI5sYUDrK5WlwR9Yr1E3c9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BQl8/0sFFHS5FeLF+kQs0gAZwN62CM8E9VYzKAOxtiYEDYI9fAzlWVq/9SB1UXYx9
	 UiezOOqMBpU/NeykE9PQynnc28TfinrN0aIt2IDPJ9T4gEupoj4txSU7gdPtV0QLAX
	 Fz0BZO8lDmh/O0BRBKMVm/tFBmJwmJEmkuaQEZlwMiY3jS80wv/PIek89ODuXxUgJC
	 CzwcTQpWnBHymD6JfqeMTO+5GkaLzixjq85FpA3sOm/D6E0stBJae8XYDPgTLWYaIL
	 NZiOyaExseO4zo+1W/rTmK3X7NgyovPY9ZA/3ctOYbw4TWyoBzobn7bIyFHGiJkQIs
	 kLC14LzCudTzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939C83AB1394;
	Mon,  6 Jul 2026 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] selftests: net: make busywait timeout clock
 portable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333320639.484760.17349135118133429852.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 10:20:06 +0000
References: <20260630165157.3814871-1-nirmoyd@nvidia.com>
In-Reply-To: <20260630165157.3814871-1-nirmoyd@nvidia.com>
To: Nirmoy Das <nirmoyd@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, shuah@kernel.org, netdev@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 09:51:57 -0700 you wrote:
> loopy_wait() expects millisecond timestamps. However, Ubuntu Resolute
> can use uutils date, where `date -u +%s%3N` returns seconds plus full
> nanoseconds instead of a 3-digit millisecond field. This makes
> busywait expire too early and can make vlan_bridge_binding.sh read a
> stale operstate.
> 
> Fixes: 25ae948b4478 ("selftests/net: add lib.sh")
> Cc: stable@vger.kernel.org # 6.8+
> Link: https://github.com/uutils/coreutils/issues/11658
> Signed-off-by: Nirmoy Das <nirmoyd@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] selftests: net: make busywait timeout clock portable
    https://git.kernel.org/netdev/net/c/dd6a23bac306

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


