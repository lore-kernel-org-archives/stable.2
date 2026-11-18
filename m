Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794967208;
	b=SB5VtGCYs+FRO4p+//6+Kuzv4P2um7gv4QHJIqKmjazpWDam/N6jFcSmnyUQ+SqkvvaY
	 J4HNJ76qOeb2pjf4rIREbxTvYaLhrv7/CqjM5Dol9qE7d8TBURKZNO2fs2zM8ibKrS1c7
	 znC9OsApoKMSMCTioCUf0l1xW244+uWKcQUqu0lu2gvGEorzG6iPhEw6PTkfmfpJ6EC5Z
	 k4L/Fl3m7SoZvLUnrwFeMdYvOMrBKO/qZfgvNeKKnf/oOrE8EZpIPrWwHwmj/72aZR8p0
	 LvBY/ToYTswSLMzGp7AeZSP+A7ZCN7XejljYud4pFIcvQ2+rG4EJInso5okQjruiKag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794967208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=rysQnyo3q2q1PCSB5zwI+CF9MYiqYHtXoPwnkzo0XVs=;
	b=Klx0O2rimbg1lVo3yjxQUtQi5VlemBMIRKnXuyYxHwimdwAGHqCSDK7MjksGDNZbiV+2
	 PcXtV/aazW41f7EHcuwMF5hwSwUY+jWt0/XecfLW3lYyubAcnqnk9m0kFEvkYFiI+LN/i
	 fI/MDjH78UxUs3VLuDeth25IW9KqgchkfR6+kQ+r8+ujZwOm4CP7L0Tcx3O8UzZn5qabz
	 z84pq3eIMizdlyzOVTt7cw64Sk1xvgt/PFl312BjyiIb66iOONgolW6A75uFEalPhxZJy
	 F0CngJ73qSCNstUarFPPe8MSyk39GdvKM3Z27gKUd5I34klJ6zaZ0SzyWKU9xQXtK/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKILQxMm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F2A606A31C;
	Wed, 18 Nov 2026 02:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hKILQxMm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D5371F000C4;
	Wed, 18 Nov 2026 02:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794967208;
	bh=rysQnyo3q2q1PCSB5zwI+CF9MYiqYHtXoPwnkzo0XVs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hKILQxMmbL6IeQNW2Gh+AJLNiaRgwPTb4uEKnMxgqzGhzZBGKAo+0/11wqAkQr76E
	 VkhmGiaWNWICew/29sChe9irFbze6kvie9BDTlaJhQsSj6mAYb5uyIW5yr1GvoxNiv
	 uZ7ontFdoMX3HLQbtsfZlo4R366jjUOgfyQqdx28sEq0D75yhv1L2fRC3ljrf91hNn
	 jqKe3gtTlkeyUBVoPIbXxRgdkId+8Hx4g/RiyWcrhUIDReYhZR94wvwsYZ6wUsSGcp
	 K8NvgGg1kwKevzeA9DVgj3M/Zi3nHd8OMrQrWKMPnrU9D5bljkvaJoR2H0V94hxfPO
	 7c2+Y4zXAjD1g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1470392B1FF;
	Wed, 18 Nov 2026 02:00:07 +0000 (UTC)
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
Subject: Re: [PATCH net] net: stmmac: re-enable on-chip parity checkers for
 XGMAC
 ASP 0x2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179496720653.1405006.4159910100773001022.git-patchwork-notify@kernel.org>
Date: Wed, 18 Nov 2026 02:00:06 +0000
References: <20261114015554.2187341-1-zxyan0222@gmail.com>
In-Reply-To: <20261114015554.2187341-1-zxyan0222@gmail.com>
To: zhu xin <zxyan0222@gmail.com>
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, horms@kernel.org,
 0x1207@gmail.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 14 Nov 2026 09:55:54 +0800 you wrote:
> Commit 669a55560e4b ("net: stmmac: Check more MAC HW features for XGMAC
> Core 3.20") made dwxgmac3_safety_feat_config() bail out early for
> asp == 0x2, assuming that configuration has no parity protection.
> 
> Per the DWC_xgmac databook, the ASP field of MAC_HW_Feature3 selects:
> 
>   0x1 (AS_EPPE):  all automotive safety features, with ECC and parity
>                   ports on the external application interface
>   0x2 (AS_NEPPE): all automotive safety features, without ECC or
>                   parity ports on the external application interface
>   0x3 (AS_PPE):   all automotive safety features, with parity ports
>                   on the external application interface
> 
> [...]

Here is the summary with links:
  - [net] net: stmmac: re-enable on-chip parity checkers for XGMAC ASP 0x2
    https://git.kernel.org/netdev/net/c/9c9863f9b9f1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


