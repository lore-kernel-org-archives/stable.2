Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057414;
	b=2qZkc/nLLwgJpen3Mj19k0yOudqQO0r7NCpq40Pa6aQZx51y8BczhxPIjoJI0xlFIIJ7
	 MwYQaES274ZCdgLpMZja+oUwIXfDWAQ257R1qhybUH1NWo5LRFD68s+u+2vXiFePzA113
	 Yhs8O1G8xnmSnf3/ed7aEWpVWeI934IuC3O6TrxEXLlmWnkEdsA0bM3TZR5pzKAupX0Dy
	 IIYvPVgISP2lhLPeBdWkxQyCT+rchA3SGCLcVnL7HRlViyMEfzsTevN8PNdc6FFE5R9iQ
	 tCA5Tc5gUCaE2w+bjXdmlHdkONln4ysQDuUCc5MMvIGXVN2Nyo2tUVc8+JibUY6gF4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057414;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=GyAB2DeZ0z/TsvQJ6cGgsLN0vuvR71jHpUOFZE1ySgg=;
	b=gC83C4o7EVkQ5Ac6Y2tfLDqqexqRlfXV/o4I9t19tTMEP7/FuBpS25MReTFETlMQpK/I
	 QSy+s8e2bBMRW1hDKDPFGSjQ9wHRgS4BRZ+FM/BN0U00jl7qJAbdThnR5UmaELBYVaor6
	 baqKj1GhsEP/TKrrd61M8j4moet8mKsmsgqTc6XpyUA76ztbLl0V6tXiQtu7N+/vfvhcC
	 N3+ZCHEPoDNo1rTGBe3B7ZOnEew2odshrTqco1qNnFPjHzmhL1P0c1VnQYbU1ZvXfhmLX
	 9PzbnYHmMzpDjwa670E95mTn4FkQWwd+0In4UlRlwFbvvFqhiWCv2Wp+eMhVg98nqgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifZ+sDVw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8E660A2615;
	Mon, 26 Oct 2026 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ifZ+sDVw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C80E1F031E1;
	Mon, 26 Oct 2026 23:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057413;
	bh=GyAB2DeZ0z/TsvQJ6cGgsLN0vuvR71jHpUOFZE1ySgg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ifZ+sDVwJtHc+1Q8JXbpm94kWzCMW+2FtS4kNsu2EB3nRM1GNF0ntK4PPwQPxlIwU
	 pILTIEMJhiAiu7IOauYJbpKe6QnD3P12yArAZnOhcQ7paIAzzP+ryXputCtbir7s30
	 xCBcPb7+Gs9wZJhUx+MLtU4D94REDZjCVRbXpM7xmTp3OCROmCT/5lmSI0vglxjZ5h
	 sMUT18rwpIgOLF7zauWbIB9LBrJO7JUXSHzfSJ2RqWBiUWpU3HueV5nfyF/ltjHv4F
	 YSMXUW2rPHC+vDoe7/C85aYJ6STRCH6j5J9jIrdCY+Uny71UMRAGou6VodyRVNzGC7
	 +nqwXiF+gJ2kQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7471B3AA80F0;
	Mon, 26 Oct 2026 23:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: fix out-of-bounds read of arp_ip_target
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305741222.3456332.4784974230471120721.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:30:12 +0000
References: <20261023104528.232427-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261023104528.232427-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, jv@jvosburgh.net,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, razor@blackwall.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Oct 2026 18:45:27 +0800 you wrote:
> arp_ip_target is a module parameter array with BOND_MAX_ARP_TARGETS
> entries. In the loop parsing it in bond_check_params(), arp_ip_count is
> the number of accepted targets, while i is the index into
> arp_ip_target. Invalid and duplicate entries are skipped without
> bumping arp_ip_count, so bounding the loop with arp_ip_count lets i run
> past the end of arp_ip_target, e.g. 16 targets with one duplicate:
> 
> [...]

Here is the summary with links:
  - [net] bonding: fix out-of-bounds read of arp_ip_target
    https://git.kernel.org/netdev/net/c/a81513bf5bdf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


