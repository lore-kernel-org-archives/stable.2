Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE91A366049;
	Wed, 22 Jul 2026 15:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784733037; cv=none; b=mHBNwjosMaSArTvchlnh9BunmaetJ9XQ5T6YexcWq1Giorq3sTJeXQIV8/jDmurFfwycWnskf4rLNZzlca+mrt5wxOenkjxLS0QP2TnfR//6dEO0wq+drLqtwCaqADPJQJ26OYLLg/uzJt9vCZqRw9p4ZGGY+b3w1l5RBcGOolM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784733037; c=relaxed/simple;
	bh=EyMFgRirtFlp2FXlMobTARMQwZoL+fjvFhnTvFND3tc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VMXlUVsM9mCCEhA5czrxmXVfJ1O2mJ99YMMZrzTiAIt3QkbIXyv12Arnc8yxhBtsYcDxiYwwXesCtesvAwlW1T/0caQUzta04q/lXyIHOTsneC/aJRB1xLq5JoiW8+Ayv1YMUeWwFieescRIIx1nOgK2XMCmowDn2AGxSOkFDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHDlCNTu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHDlCNTu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 796311F000E9;
	Wed, 22 Jul 2026 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784733036;
	bh=LpkyDoxWsDzMJKbzEZ40N7NPjt5kljcGX+Xsz2rh6k0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LHDlCNTujGyKrBOlqaX+MgIReO+OdJ3IYi/InNE5O2jizp9edppevqZ/2c/aFROiP
	 kPL4Gl4PgemFqOq+EUj0Lf0FUgITZEtLa6YiPbdqmMoWhv1YXsk334EGYjaLVtHx+L
	 62VxRDr3uL6TjgdkDr+Q0sWkItvROlPmpzx6kO7CBebMFJ581YiVnNRQCAF7ewB9FX
	 1KH8cmArPFMBZVqo7NxwKlGrY9hu48qIBcFfiWvVCIF/htCpYaY8EQbJdKrpFrarh7
	 7ls16z4Tn52yFMzkivNlL0+NqCn833GPQaHPhXw5TyT4pJqtsRbvoierJ1m3J4Uyuq
	 vm85SIBrJ2VNQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93A8C380AA5D;
	Wed, 22 Jul 2026 15:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: hip04: fix RX buffer leak on build_skb failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178473300515.1448721.7322949329898065339.git-patchwork-notify@kernel.org>
Date: Wed, 22 Jul 2026 15:10:05 +0000
References: <20260712142729.2057636-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260712142729.2057636-1-fanwu01@zju.edu.cn>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, przemyslaw.kitszel@intel.com, horms@kernel.org,
 shenjian15@huawei.com, salil.mehta@huawei.com, dingtianhong@huawei.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Jul 2026 14:27:29 +0000 you wrote:
> When build_skb() fails in hip04_rx_poll(), the driver jumps to the
> refill path without releasing the current RX buffer and its DMA mapping.
> Installing a replacement buffer then overwrites the slot references and
> leaks both resources.
> 
> Keep the current slot intact and return budget so NAPI retries the same
> buffer.  Also free a newly allocated RX fragment when dma_map_single()
> fails.
> 
> [...]

Here is the summary with links:
  - [net] net: hip04: fix RX buffer leak on build_skb failure
    https://git.kernel.org/netdev/net/c/14fa65d10f56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


