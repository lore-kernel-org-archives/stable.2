Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105F42750E6;
	Fri,  5 Jun 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780621808; cv=none; b=IRUp1L25NhYBUdehsWsoccU0/UFqRA7Dj8e+Qbi0TdZ+mwhwAQyugsbthUZz8RHjRXim0qyuWrcaTmcTDR6mQ7GBB8syxG0S4d5w0OKmQvu/SaGf5L00amHZCS0EGFepYEfkeB9hPKphXHeWcErZNt2AquTbtIN682kGM8+Ym4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780621808; c=relaxed/simple;
	bh=9JOmf6KJF9lGSZLL1hN41NuukQHxDbeXKeQ0Wxn4Qso=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UWMzeRJkE+Dmq4pjr/y/B3zZa5DnmhPM9mdQjMCWR4RIVDUlvTeB1ClhbG93gDoK0neMRNK5aGIa3g4JqgKlpUYibGkpr2aWKtsMcJ5imvm/AO7ROJun4a8hLib6YE31YAYqRsoEdpuvwbYNBT0Eem36Jjn3Vkh5N8IT4lbdJfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwUUuc8J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwUUuc8J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE74C1F00893;
	Fri,  5 Jun 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780621806;
	bh=bAgGUIuT5Cowg661+H0J7z5VttyhEGD5ilxEI+SIQ2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nwUUuc8JrALZn080+53+lOBCbJj/n3BXPm8Wvu9YA/kTFg2sJcwB3gFnvz55P4UM3
	 jGzSp0g2R9zIrAhaslurHAAyjS2fuxBceKLiIvvlx+7wb8/z21zoeKI1iGRxx+3A5n
	 xv2XcHJRZmSAxhWzX6bE4riGOnHoDN/n+LMujC/hZzeLK/JTxQEn0vqSvcPCjcAHAS
	 UsHdLVzTZJ7A/GChIvX9sABsai/pr6Enx3QUi2uJNFQKagd3yySM9bHbxFjZaXTS9D
	 tRA6xqjuaVHYfAQfA6efox4mz0GinS5teMVPNnZwwzY1/JG8EiN+cAX+GGWFhU+riA
	 bIWzQ1Jwz30Yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939923930A84;
	Fri,  5 Jun 2026 01:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] inet: frags: fix use-after-free caused by the
 fqdir_pre_exit() flush
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178062180740.3088134.15315966161183753620.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jun 2026 01:10:07 +0000
References: <ah6ukYq5G98LshdA@v4bel>
In-Reply-To: <ah6ukYq5G98LshdA@v4bel>
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 stable@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 2 Jun 2026 19:21:05 +0900 you wrote:
> On netns teardown, fqdir_pre_exit() walks the fqdir rhashtable and
> flushes every fragment queue that is not yet complete using
> inet_frag_queue_flush(). That helper frees all the skbs queued on the
> fragment queue but does not set INET_FRAG_COMPLETE, and leaves
> q->fragments_tail and q->last_run_head pointing at the freed skbs.
> The queue itself stays in the rhashtable.
> 
> [...]

Here is the summary with links:
  - [net,v2] inet: frags: fix use-after-free caused by the fqdir_pre_exit() flush
    https://git.kernel.org/netdev/net/c/32594b098549

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


