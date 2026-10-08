Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B2E3B27D5;
	Thu,  8 Oct 2026 18:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791484811; cv=none; b=EJjewfadhDD8wMlwj5fe95R0CMdpuY6MoH348bWN40vYXBmqdTWT8TXKXGDjF210bNjoyqLpGOSUJg13cIo8Pj9tqjyg3u1jZ/DTQvHaz72Vh1Ngmm6Jfmp5RFjzEMFRSRUsUsRnFyKXdtbiKsxQjwO4jy5HVrgEeWioA3O4G7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791484811; c=relaxed/simple;
	bh=lILhYBtXwhrrEHftfa4CZK3Rce3JTA7gFVoMEw+Ffss=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MTkB5ck6bnsNjWxreCXkgb21K69W33GSMaqjFVoRiDXL21gwgpVHxasya2L1PvqEswdK1tuJf1Xyu011uGBheC7ss/ARmVbSg1HrJLQ8IrGPQy7EBsuIlUP8WFtPkmL4XpwTwiFZUK9t5L/nQfQwfhUccIevU3Z2OX4d+Pg7afE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFnYGdAP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFnYGdAP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A23C1F00893;
	Thu,  8 Oct 2026 18:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791484808;
	bh=XOy9VCsw6wr5foJLfeAQGfzThCHf/MXSMumL1DRZnYw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZFnYGdAPg+aN8Gw6kFG2XdkqJEbC76kf//c4JAVpB/2G6RScHAir/8V9QeXXk58K0
	 RjT0DWozxc7Q1AEIULPkH9EbZ6PLRB/JQmLsbtPbZdU8x5gr6vmvljpQNGav+VYmcj
	 0UCsFLleKbCc9sSVpBxEctTVuc/Z3UOS7nfTPGAjgzXtbPoxBG8m87bH7M0KBimKq3
	 4IK+V6jWTtj9AJEEJc6oC+B0AMhz/fmj6CiehZP/dta3THNsLQiT85lRVD5JI2dLeB
	 QRSUU2FF2org9dRKGS/TCqmMphP0Ok8eIw3MzOqJCSgyG9SBL7CRZUW76SVhIPNvUI
	 WIc/JYfKvQlYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1CFB380CEC8;
	Thu,  8 Oct 2026 18:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] xen/netfront: don't leak the skb when
 xennet_fill_frags() fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179148480652.386807.10828311641077520646.git-patchwork-notify@kernel.org>
Date: Thu, 08 Oct 2026 18:40:06 +0000
References: 
 <20261007-b4-xen-netfront-fill-frags-leak-v1-1-a8a01ff9cd52@toxicpanda.com>
In-Reply-To: 
 <20261007-b4-xen-netfront-fill-frags-leak-v1-1-a8a01ff9cd52@toxicpanda.com>
To: Josef Bacik <josef@toxicpanda.com>
Cc: jgross@suse.com, sstabellini@kernel.org, oleksandr_tyshchenko@epam.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, xen-devel@lists.xenproject.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 07 Oct 2026 17:57:32 +0000 you wrote:
> When a response chain has more slots than fit in the skb's frags,
> xennet_fill_frags() returns an error and xennet_poll() jumps to its
> error path.  That path moves what's left on tmpq to errq to be freed,
> but the skb being filled was already dequeued from tmpq, so it's never
> freed.  Each chain that overflows leaks the skb and the pages attached
> to it as frags, and the backend decides how many slots it sends.
> 
> [...]

Here is the summary with links:
  - [net] xen/netfront: don't leak the skb when xennet_fill_frags() fails
    https://git.kernel.org/netdev/net/c/93ccaf1c26e2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


