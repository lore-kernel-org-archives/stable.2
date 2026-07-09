Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FDD3401A3B;
	Thu,  9 Jul 2026 09:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783588844; cv=none; b=EyDeA6b7q8/VMSuKw5w8bCGxz/8FGDWSXrZwWGzDFBgqifyslgSjwLI1PMJ3Hjru0EFnKGhuWHFS1to9okM69cwfzfZDtSbJoPTRy+pkDIfUNOKNGJhTbSlPsd9G1Zm6LNiSUUOQf7E2OrQRrfdNt6kWdOhFh2lAqbj5OCQZTTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783588844; c=relaxed/simple;
	bh=FrzLWWdqcRrv5gVMZcsezR+LdPa7lbMl3s5asLemMQI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZsPw4SYgxiMO4Utb4foPQlngVjU9tB85UzUZRTdj2i0ySl8jWdYKQTn3nux02hcVy9LUnuL+kLuqngG4vxBNvDZv+YMeWc4uPCoyCYzRX25N7PVC3qvDBZwhuXTp80FEclQrOq8HACNWNKHt7O83VYXb84X5nCN3wnzezzKOSmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCNUL24U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCNUL24U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA661F000E9;
	Thu,  9 Jul 2026 09:20:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783588842;
	bh=K3oDSCq0e8fq1E3kfwxiBNJ3XGysx97IQDwhOEiZyFI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kCNUL24UMlODqSOgMyE/UcsKJA04LYuGHy1ArpYvMMQFDRq5lvSjSBuxc4UpvEw3B
	 dY0G0nqr9bdQa/rEkWk5tYJmsAx+qJbjg/nL9efqMP7CHYfwu+ESyos8IShg66DLjr
	 osoXJeAgcI54NaSBfBFLpLvCX4SPgTpD1D822y0o4OA3HPKfnPHtpb3eO77RVAeqG3
	 DKK97htGTLU3wnQ0+AH/baFwbrIeFo+1+CyhbcuoQJthICjM2F6Gap4/Em1P7JJx3g
	 VXqGU1buhU4uU9eKJzdLRG6Q+UX/oIS+jCTQmb5JYsloojheoLkcaANuKUsjGSudFv
	 2YlbQDWKo+RRg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939F3393A564;
	Thu,  9 Jul 2026 09:20:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/9] batman-adv: ensure minimal ethernet header on TX
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178358882114.3359576.16875111531041578494.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jul 2026 09:20:21 +0000
References: <20260708091821.314516-2-sw@simonwunderlich.de>
In-Reply-To: <20260708091821.314516-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@vger.kernel.org,
 sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Wed,  8 Jul 2026 11:18:13 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> As documented in commit 8bd67ebb50c0 ("net: bridge: xmit: make sure we have
> at least eth header len bytes"), it is possible by for a local user with
> eBPF TC hook access to attach a tc filter which truncates the packet and
> redirects to an batadv interface. But the code assumes that at least
> ETH_HLEN bytes are available and thus might read outside of the available
> buffer.
> 
> [...]

Here is the summary with links:
  - [net,1/9] batman-adv: ensure minimal ethernet header on TX
    https://git.kernel.org/netdev/net/c/49df66b7993c
  - [net,2/9] batman-adv: fix VLAN priority offset
    https://git.kernel.org/netdev/net/c/fdb3be00ba4d
  - [net,3/9] batman-adv: clean untagged VLAN on netdev registration failure
    https://git.kernel.org/netdev/net/c/8669a550c752
  - [net,4/9] batman-adv: tt: avoid request storms during pending request
    https://git.kernel.org/netdev/net/c/27c7d4000823
  - [net,5/9] batman-adv: tt: prevent TVLV OOB check overflow
    https://git.kernel.org/netdev/net/c/7a581d9aaba8
  - [net,6/9] batman-adv: frag: free unfragmentable packet
    https://git.kernel.org/netdev/net/c/6b628425aed4
  - [net,7/9] batman-adv: frag: fix primary_if leak on failed linearization
    https://git.kernel.org/netdev/net/c/353d2c1d5492
  - [net,8/9] batman-adv: mcast: avoid OOB read of num_dests header
    https://git.kernel.org/netdev/net/c/38eaed28e250
  - [net,9/9] batman-adv: dat: fix tie-break for candidate selection
    https://git.kernel.org/netdev/net/c/98052bdaf6ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


