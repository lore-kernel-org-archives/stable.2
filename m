Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88CBB3EA97A;
	Thu, 25 Jun 2026 16:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404472; cv=none; b=ZmaYyrceXAdFl3Fu9ydXPX2M/6chavq1JgjP8c7F/3QcktEVfp3ogpqX8HhFMhDDEN8u3X3DQyCGD57Vc5CLD94Ja61QQTohcw31Y7+tm9TwrNhs8cj5D5uDZ5lkjSz1hw7+AQJIeRGu+NwhSjRMxzEgzj1np6pz8P317h8E9qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404472; c=relaxed/simple;
	bh=INaDuTRFqYElc6+fB/jOiazccjxObdXLRlN/Y11QhSc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BBQXzjf+n036Mznd5S8MQa5U11InGDppobodbRi6FfKS4zB1KHu/35cT5cCYwTCC3RZAjRrmw1V79cV/YW+0AcY+VYQpEOR6bJqtidhSaiD/LEdAvbSHHRNmmOB78ZgQUTXt+WLw9M3XR5BFiRkymqMZX2XBmBkBSu+BE7AeEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndxHX1GR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndxHX1GR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300FF1F000E9;
	Thu, 25 Jun 2026 16:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404471;
	bh=V4H6/goFQ8X26Iq0t9DZzkF/OyHuhaCv/iBh+9th8dY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ndxHX1GR0nAR9XyORBpojUMj4UCr0VXnsvytFFTHC23utd4YoGW6JCoGL+46xcFd7
	 t1a/yGEPY7qr1nFROOeFN1+S2SmfGGCuxkO2pX3fiU1e69RLUv3vtHh9r76iXytKGf
	 b+6LhKMdTeNnwIdPRUgCfSkngieJl12xx5euEOucaQZXeT8l7cmUVgMlsNSgv55sxW
	 rm21WVaxM9B0x1dGDbwCYRn4MauP2YloKnr/y4GnUbmLHwVIpHGEntc0YyMKaKax1S
	 wHmb1ybNAyHqIzZL/Mk9raLFdB71+133XQ0rO3V9Aj51kGtapoci3wjLsXOEF/L6A9
	 8at5VmplXVOBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1988C3AD449A;
	Thu, 25 Jun 2026 16:21:00 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] octeontx2-af: Free BPID bitmap on setup failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240445858.3803792.6928560337070977816.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:58 +0000
References: <20260623114316.2182271-1-haoxiang_li2024@163.com>
In-Reply-To: <20260623114316.2182271-1-haoxiang_li2024@163.com>
To: haoxiang_li2024 <haoxiang_li2024@163.com>
Cc: sgoutham@marvell.com, lcherian@marvell.com, gakula@marvell.com,
 hkelam@marvell.com, sbhatta@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 23 Jun 2026 19:43:16 +0800 you wrote:
> nix_setup_bpids() allocates bp->bpids with rvu_alloc_bitmap(), which uses
> a plain kcalloc(). If any of the following devm_kcalloc() allocations for
> the BPID mapping arrays fails, the function returns without freeing the
> bitmap. Free the BPID bitmap before returning from those error paths.
> 
> Fixes: d6212d2e41a0 ("octeontx2-af: Create BPIDs free pool")
> Cc: stable@vger.kernel.org
> Signed-off-by: Haoxiang Li <haoxiang_li2024@163.com>
> 
> [...]

Here is the summary with links:
  - octeontx2-af: Free BPID bitmap on setup failure
    https://git.kernel.org/netdev/net/c/36323f54cd32

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


