Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D03A48CD52;
	Thu,  8 Oct 2026 23:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791502817; cv=none; b=HKgZEWEyPfAHn/v3nEKpXn4KHkbZF0dMN136G/g1g5QY0gzP9sD6RTtohq0r5SieGQ/+KtQ/n3SV1Mijo84yHS125zjc+2i4/bosB03vkMUr6JHoYHlLMT4f7JKrXMSbNcNo3xAeooeADVODOoIL8NTzL3T2kN/zax8vHbGv7f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791502817; c=relaxed/simple;
	bh=83s+/+kzqrYx3wvMv/SxaW/p3ZcMKq5FxF86opACEuM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EcGwdOUa8Q8GFZCZyROK33IYByZeXNWQl5516ob1ZEl0Sitj+C5nsR4XwN22DeL1R1njqKNbgJFQnnrFfIVqn5MbPGlzze3uJ9SpXlGcckwHRWyfLmNu6UBMw0LIewPoQvmhN4AvcuJOTisBsGlsnGlT8IKT3czX551Hx8B/H1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRrHTsyd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRrHTsyd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089C01F000FF;
	Thu,  8 Oct 2026 23:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791502816;
	bh=dUfciEI5zcVKUGB/2vgTjS4wLXJEXEQcGwe4tIjelWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CRrHTsydHxWiaN9imL+eE5gwmutWDi0X5uHrLdFjnPWO23zr3TUeHTf98PWZ577lV
	 1wm8cA14AgFgWmW97jieoNhAH1A2JV37V7dhGn7u7hr+3z+ednoAl1GPhKGKWF2ZAC
	 U1GKaOuD17lCi3P7AHfM1XZR+TfKggaipo2/u0g0oJbZkGLxUsh67Q4DSKBP9dI0o3
	 t7xVinhF02QO6yOGkO2IPENEIDe9Aecku73wBPYC77xJd+QOLMPD3VIXFvHqRREdgF
	 LNQPNu6ERClb6PTm/TmiN6g0vIfyv884+UffaIbQm3xr2A8vgrC0XffKEFwFYc2Pb+
	 qysCyKNgg7oUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F174B380AA60;
	Thu,  8 Oct 2026 23:40:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip6_gre: let collect_md ip6gretap send from the
 unspecified address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179150281451.481494.16961080980832187357.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 23:40:14 +0000
References: <20261005191227.894665-1-littlesmilingcloud@gmail.com>
In-Reply-To: <20261005191227.894665-1-littlesmilingcloud@gmail.com>
To: Anton Danilov <littlesmilingcloud@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, u9012063@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 22:12:27 +0300 you wrote:
> ip6gre_xmit_ipv6() drops an IPv6 packet whose source address equals the
> tunnel remote, to avoid a trivial tunneling loop. On a collect_md
> ip6gretap device t->parms.raddr is not the exit point: the outer
> destination comes from the per-packet tunnel metadata. Such devices are
> normally created without a remote, so raddr is ::, and the check never
> matches a real tunnel endpoint. It matches every frame sent from the
> unspecified address instead.
> 
> [...]

Here is the summary with links:
  - [net] ip6_gre: let collect_md ip6gretap send from the unspecified address
    https://git.kernel.org/netdev/net-next/c/f3f5d7ab19b5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


