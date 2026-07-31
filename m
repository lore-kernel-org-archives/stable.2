Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307C74086A;
	Fri, 31 Jul 2026 02:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785463268; cv=none; b=QznWj5OXoL4faTuc6rQ+9zdAUgi24AkmhYihw1PEdbjPYZFe82rMsV/LGrQq7NMnFg5/XnrBw0PD0RJ7eUNOaCPXXw0cwaX6RiWJlm73c2TCzgMlEd8k1a9KJG5hY/+M5PBhbYKWb1W9J19vMIliKMpwut0CdvJFg+HbNw9VwkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785463268; c=relaxed/simple;
	bh=fgY/9viFpFSc73wlVcyZIycsQYY6lt363EUfsWqXVPM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PHBrqE4mmJGHpE2AMDzNJrKKj2V0+3/2jh3yCwihTHSE+GKd0F+buSNk0ehDYwMHa5V3uOg0OJ9LWmxMZT+fiXtNv/Gn2YmPCpu5W1/e7uTYnL3IjEkYrXW987DGpApSS+Bi51I0O+udaYXbFJ897UfB9C1CNOb4TFq8m4UkfGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JItkOlPZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JItkOlPZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A49E1F000E9;
	Fri, 31 Jul 2026 02:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785463266;
	bh=odbSB9AyyvyDG+8P6r7FXrrazemEezv/nq6e1pBXhBE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JItkOlPZHPoefNEJqauHMtePlYVDY8fM1hEh0QW9zDRNoxgRpZHXT2os4qJyBG2S9
	 46YY/MpIt7gv4NXllwtzjaa696aJYxOwPGsz3w5UOF2FTXaHw3pXbykjcnzZPLLa0L
	 CEESX1o/qgydR6caBiURsRmL/uj3enVTqNW+hBJs8+jvHkFVn3oNc0Viv6Wp/eQiuR
	 UIogo7ASkZ79qrSArxM6mib8B6LaQbR/c7NOkplNp1vMtIv9kSIhCmhpVlRFk8EzrW
	 efuxm5vrYzL4k9ZXM4ascNX0qtHSQrG12mPILDAZO3jGD/cx9fLEjAJ5U8SdnSmOlq
	 wgo6p7gg4nnqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B563924477;
	Fri, 31 Jul 2026 02:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/x25: fix use-after-free of the socket by its
 timers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178546322939.81545.6396322960380105483.git-patchwork-notify@kernel.org>
Date: Fri, 31 Jul 2026 02:00:29 +0000
References: <20260726220342.47245-1-baul.lee@xbow.com>
In-Reply-To: <20260726220342.47245-1-baul.lee@xbow.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: netdev@vger.kernel.org, ms@dev.tdt.de, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew@lunn.ch, linux-x25@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Jul 2026 07:03:42 +0900 you wrote:
> The x25 timers are armed with mod_timer() and cancelled with
> timer_delete(), so a pending timer holds no reference on the socket and a
> cancel does not wait for a callback already running on another CPU.
> 
> x25_heartbeat_expiry() also rearms unconditionally, so it can reinstall
> sk->sk_timer after __x25_destroy_socket() has passed its cancel point.
> The following __sock_put() frees the socket while the timer is still
> queued, and the next expiry uses freed memory.  KASAN reports a
> slab-use-after-free on the kmalloc-2k object freed by close().
> 
> [...]

Here is the summary with links:
  - [net,v2] net/x25: fix use-after-free of the socket by its timers
    https://git.kernel.org/netdev/net/c/2195424c3da2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


