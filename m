Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F76D2ED141;
	Thu, 24 Sep 2026 00:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790208079; cv=none; b=XtvxYqMZRiC2fkPpeHM9GTMVW5wkeh6MFrR0pFLuoS1dvOE0HGwlOltxX5527qu5P7t13ZFX5D9cYY2+pUwLSxHPsdKBuV0SGL+oFM/L5Z9qRfxJ+QsZAzrjgbAUkb+CodbSk7VY1KDnO1XREUbYWyW+/WtxSCsPFZOCbnC47ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790208079; c=relaxed/simple;
	bh=jxdVOhJzmMbVcoVsLUhPyPH7GpvilUyKW5zjlxG4pWo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aC9UTISfSnRb8TqjfUKS1HR3LUU/lK9MW2in/UXPIsBXKZLxCseWIgmsEBrn9TlFDvVbtwVxaApNEnLVx03qiC0ssHXwa7BfpBsrXszzDXGAF3QAyaiZjAti7PE8kxDR/kIxUDqrEHkYg7jb+0p6j2ukI1WHPUcIHZ5Vr73Mx8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fVNna8Cl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fVNna8Cl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8CAE1F00893;
	Thu, 24 Sep 2026 00:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790208078;
	bh=Auc887FzkdId58On3DTA9zy75jByf5mTG6zE0R78+m0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fVNna8Cl236/rGiGlMf9S6Ucxj8mXjXlr1pecPJV3hZp5HuikPYPKghtVuDNV/6fG
	 2rGtbzDwXf/AN7E+XP7vgdkxD0yxQ8E5jTLY78cdGPAut4+8w9kiPuu8ySjTj8dVx3
	 3omhLff3DMCY8QZGkPoeclSSq1bRb44tnl39hXJJyCwPZ3zAegVjdYNBcLVrWyLMID
	 +S9pbPZzwE89FEPM7kUzV8Vtc8gPfM8uvPA/OVNpaEHY6GHiGJ+12qsG5IoOOyy0gW
	 xiTnggEG2vfckpnj7dm0mkeETJZj8y5J3IG8YsuJrJeULaJ/2JlcKi7ssKI6kmfrqU
	 wLGiCbetaT2xA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0EBC39E9602;
	Thu, 24 Sep 2026 00:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: mdb: restart port group walk after
 deletion
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179020800742.1240300.14996897175624601551.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 00:00:07 +0000
References: <20260920110852.60293-1-fouriezhang@tencent.com>
In-Reply-To: <20260920110852.60293-1-fouriezhang@tencent.com>
To: Fourie Zhang <littleddfu@gmail.com>
Cc: netdev@vger.kernel.org, corvus@tencent.com, stable@vger.kernel.org,
 razor@blackwall.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 petrm@nvidia.com, bridge@lists.linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 19:08:43 +0800 you wrote:
> br_mdb_flush_pgs() keeps a pointer-to-pointer cursor while walking
> mp->ports. br_multicast_del_pg() can re-enter the same MDB entry through
> br_multicast_sg_del_exclude_ports() and unlink other port groups. If the
> cursor points into one of those groups, the next iteration dereferences a
> stale cursor and can leave mp->ports pointing at freed memory.
> 
> A following RTM_GETMDB exposes the dangling pointer:
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: mdb: restart port group walk after deletion
    https://git.kernel.org/netdev/net/c/ab1404ac8115

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


