Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349603612F3;
	Thu, 23 Jul 2026 17:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784827843; cv=none; b=JBeAi0J6nV1bD1aDfX030yXDLItdPo40xbYzjmwGqHg3WwXW0Zzi1INVwrkVC7z6JE8Nv2WChzvJb5Jasko0UKW9n06bMtIMmKks969mZLlFiDiCkuZJ9wvygWIALvPgrClnobkGBQyqED2E1wgWMtBobgkQJVaWKFzBQC21Brs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784827843; c=relaxed/simple;
	bh=EhkPXcaWHqfkLc8Bw2AnjM/eZzUNUz7KcwVW+Zr55nc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eV+Xg64+r7+XYnXZ+QJUoQyN2WW0Nd24JMe0POm/GRlG2nX9ks/LJEhtNAtAeoSfXALxDROuXFw9Fwei9fzhsxiUKOH1vKw76+pC4TFhFHoEUYel6GZJLxyH3CbY2By9qkhEpRWZD/N2rX7rwEWBjZz/JTcs7yN3qWeeT7tPFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KtEzjkHV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KtEzjkHV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB59B1F000E9;
	Thu, 23 Jul 2026 17:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784827841;
	bh=sFjB4cztRoztsgQjY76DRZh6+AU7bFekMTTKOZnbDeA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KtEzjkHVQdDR/SeWgKfsTNKsINAjBlglCPylzkndTCfV6nlX26U2HJdeggLtzb/dN
	 lv9lHi+i8LTXk3kByFvbOlyis55WEr1be08E6s9MYvzD7EfpmXWvgrA2Aex2+hkBYD
	 +7FCOViXJB3PvgCIP7hlkOboL2bvQnFB5ozbiyTUQuBzoI8mtJKixl9LBxIaLL7dbQ
	 AlNkyRwIzyvfaGU5EwYaffsTnejEJqfwU2NVsSMDCe9A8frTbhMjNU5yXgKXetZ+EL
	 Z9buxqOyW8+kcW+RBjMuxIEKIyF1MbFkOnK6kr27DvkxorIYlPrrm950n9kJMiJWWX
	 0E5yjcwoYlfKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1986639244C6;
	Thu, 23 Jul 2026 17:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] phonet: pep: fix use-after-free in pep_get_sb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482780964.2797885.9364408026538103530.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 17:30:09 +0000
References: <20260721-phonet_get_sb_uaf-v1-1-95fd7881cc4e@debian.org>
In-Reply-To: <20260721-phonet_get_sb_uaf-v1-1-95fd7881cc4e@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: courmisch@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 remi.denis-courmont@nokia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 01:58:45 -0700 you wrote:
> pep_get_sb() doesn't consider that pskb_may_pull() might have relocated
> the skb data, and continue to access the older pointer, causing UAF.
> 
> Reproduced under KASAN:
> 
>   BUG: KASAN: slab-use-after-free in pep_get_sb+0x234/0x3b0
>   Read of size 1 at addr ff11000105510f50 by task repro/157
>    pep_get_sb+0x234/0x3b0
>    pipe_handler_do_rcv+0x5f7/0xa10
>    pep_do_rcv+0x203/0x410
>    __sk_receive_skb+0x471/0x4a0
>    phonet_rcv+0x5b3/0x6c0
>    __netif_receive_skb+0xcc/0x1d0
> 
> [...]

Here is the summary with links:
  - [net] phonet: pep: fix use-after-free in pep_get_sb()
    https://git.kernel.org/netdev/net/c/0f71f852a96a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


