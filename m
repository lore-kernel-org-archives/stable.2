Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 390122701B6;
	Fri, 21 Aug 2026 18:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787336458; cv=none; b=py/rdfNG+0Zs4s0c3tRedj2xMqOiEkjF6C6880r1BlT1QPvvw2v5jbjlUwl9pvgTszm8fdRBe8i+oqsZKh5hfKFdM7OgB0o2QruQSD1PcKr1aXFsVI87IWhwcVIQbRZN4BPFSOlZ1FF8YSerPsJOpU3WJ/XfJTHl3owNhf91vqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787336458; c=relaxed/simple;
	bh=zkQFXwSHFFFg1w2Yx9k+cR593307ug8i9pqnHrFvbX0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nCq0i6gzyfhfzQvHDy7rt30DKIi4zRe0I/Eo5Qwbgh4dqQyd03bxCosWR7djm98yg4eIEExp01g03Ue6rQOhR0cufcz2L47m/I8kC2mvNM/GwYWU+QvWpx73QU/sjD+djr8Tel6mKoUiQE2eaPnigpHLCfmM+sLXUXqJ3IguMrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nqGTq6u4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nqGTq6u4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C750F1F000E9;
	Fri, 21 Aug 2026 18:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787336456;
	bh=WpnJd7PytfBF1bLvgntmt1pr91adf5mG+fyXPNCVZ7k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nqGTq6u4pxT5crj32o3Yj8mXIb/PmeGTI8M5saoCf/NWOnby6MGPrvmvTXTuwT5Xb
	 7bH2DWjVknR8hIKQO3uhTqLMuniwf/YEf19pW5h4uGej52Kz5E78E1HtiSE49WrxHK
	 I4K8YKj/TJVI0+JgusiOYnIKu6qP2kaDF4FmCyObL86ATDcdJ/QVfY8CbRYLHpkE26
	 tZ7NBE5gJqvwAWITRWgbRKVNAtBfSjBCN+/XUQsRTT4m6Z/k/Q/jY45Iuv8Ti9Ge9a
	 tiJnoL1QDlAl8JZuXtAOnYlAkEHZr8IDXymR0Df3OprByF9TGN9dcXTRlh3dLcP669
	 qSmzo7re/wYug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9399E380CEC2;
	Fri, 21 Aug 2026 18:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: bnxt: ring the doorbell when SW USO exits
 early
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178733640614.1421394.1715964025180221313.git-patchwork-notify@kernel.org>
Date: Fri, 21 Aug 2026 18:20:06 +0000
References: <20260819233213.3673149-1-joe@dama.to>
In-Reply-To: <20260819233213.3673149-1-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: netdev@vger.kernel.org, michael.chan@broadcom.com,
 pavan.chebbi@broadcom.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 19 Aug 2026 16:32:11 -0700 you wrote:
> When a burst of packets is handed down to the driver, the driver defers
> the doorbell to the end by setting txr->kick_pending = 1. The normal TX
> path handles this, but the SW USO path can miss it if it returns
> early.
> 
> If bnxt_sw_udp_gso_xmit runs but returns early with NETDEV_TX_BUSY and
> txr->kick_pending was previously set to 1, then the TX queue can
> stall because the driver wrote some BDs but never wrote the doorbell.
> The device won't know to do the TX which would generate the completion
> that would wake the queue back up.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: bnxt: ring the doorbell when SW USO exits early
    https://git.kernel.org/netdev/net/c/4e15e89faac9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


