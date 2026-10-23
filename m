Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792789223;
	b=LlIQ1LTpj0eCdapC36xEPg/zxH2gC1+/9M8SES5oanvvsICTHXuPeJk7WH50+HD4Xmrt
	 He+RjO5/JekUq2jzDw1hpSgrnlE/LpJvllWZ3UDnY3mVh10z6l42d4TLtGg88/yChkzAR
	 l9o27XsXTf3X30+35cS+BkBVePgXiGx+LWkoNuAn4sR0HIvd52nq6yTaILfVGR+Jl3krv
	 UXBI83YtVoCEm5RnXfjtBaVHR6Uz0r8U0WZLPaPlHXiYNgSaoBgJlSNQ4oOeBKYwPQ0Qs
	 eP9V+RamwEY8aH4K89MZznhfP+7BtL/P9t4j3dSIEP8NyBhXy/GqtgoQKy6aWT+ha+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792789223;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=jYZIYMBd8UVK6BNo8UCuf5+CZmWdq5SaCGptMRiApvg=;
	b=jSJIvXODCmLuMuoZVOXcyrqehaI0LNUZb2GGTyMc5gEDMUbJuL7PbYYbwnZbVrIxHgIG
	 5r7TsJ3OfN2edGcOyqTi/svOy1vRa3X6jy863fi84g0+oObYK2TbukVJMgS0OQgSkVRDV
	 zb0gzxiiTjh341apA88n/doAcrfBv8lI4kx1KhU6pSA85I7uJ+Zn1LNALEb7q0qvTa7Fv
	 kMcVawoe8bA3y0vyN4/gyERxmNeEMy+7B7NaVmgcz/iNVkx1lW8Gc0q+YEb5825C36x+4
	 QYjPI94RkJylJicUIszfpxcQ0L4ntwRCa6apEfuvjoLIgVCjiBw2dzX3t4Si+qmjFxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cj8Ta3rK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE5C0606A31D;
	Fri, 23 Oct 2026 21:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cj8Ta3rK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 897CB1F01825;
	Fri, 23 Oct 2026 21:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792789222;
	bh=jYZIYMBd8UVK6BNo8UCuf5+CZmWdq5SaCGptMRiApvg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cj8Ta3rKCWsYnSXSk1mSV3LnwSX19itCnyXb5OX5n+KEBm1m6Mt/SYG5xqFpde/bv
	 rDFtNjfCyGOtJiGDMJfAC+w2nzncR85+Sim4ak6Wmotw7g+vHYd0E+q8l7dSW+nzjC
	 0etCEkKUTfmHIwzGEXzdkAwOr28ad7juj/YoWC4JBtdIxO66tmdq3KkfeCJqWQuYkQ
	 gB8OjmtjGEp1MKegI68ENsuDDJmXzzgcHFpxm59IvxTi/X9Wnhg3enHphWM6N/ci2M
	 7RcChHAhdJ6aUU9vNyxLS46jU5emYnPhhMJBjknF/kjUtfJXXyu+GUyUmqnSeA0Mow
	 F20mk/kUOQxzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 81705391B157;
	Fri, 23 Oct 2026 21:00:22 +0000 (UTC)
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
Subject: Re: [PATCH net] gve: fix out-of-bounds read in
 gve_get_flow_rule_entry()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179278922106.1268720.5910307752725835435.git-patchwork-notify@kernel.org>
Date: Fri, 23 Oct 2026 21:00:21 +0000
References: 
 <AS8P251MB0001135AF3233180DC42DCD1C8672@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
In-Reply-To: 
 <AS8P251MB0001135AF3233180DC42DCD1C8672@AS8P251MB0001.EURP251.PROD.OUTLOOK.COM>
To: Aamir Ahmed <elb12345@hotmail.co.uk>
Cc: netdev@vger.kernel.org, joshwash@google.com, hramamurthy@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 20 Oct 2026 23:33:46 +0100 you wrote:
> gve_get_flow_rule_entry() checks the requested location against the
> first and last cached rules, but rules_cache_num can be 0 while
> rules_cache_synced is true: GVE_FLOW_RULE_QUERY_RULES returns the rules
> from the requested location onwards, so a request past the last
> installed rule - or any request when no rules are installed - returns
> zero rules, which the driver accepts and marks as synced.
> 
> [...]

Here is the summary with links:
  - [net] gve: fix out-of-bounds read in gve_get_flow_rule_entry()
    https://git.kernel.org/netdev/net/c/45e0a63f9c86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


