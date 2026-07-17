Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C73E556C;
	Fri, 17 Jul 2026 09:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784281866; cv=none; b=I7sMh3gYhPuOvHUIHW9LYbRzJbyqq40SltEjj7YlLZWeCPj2x9j5hITTY8LuUakbHQ6o1l9iHB0gomfQdf2awEbtviV25P38mqMU/bMvjdkDDA4+VYQPQ3lMWIeo/nH82K4yGLxmvFduWnbzhAobkdIUimi5BykBiT5kipZ5Src=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784281866; c=relaxed/simple;
	bh=mUWMf9MNONinFiabu+hEz9VcTRG5x75XT9idOiPkO2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bZWB/5zqMwg7tAXw40pi4mAdw6iL1mSBHcYwEu4QQsJjFLpi8BEb0c8p/nQqEqOY9l70PpLaRxpedo3U79GPf1OgQ8K7lu32k9mdi9at+CLeeupTmJBvMVl9EcGn20EOYpShqKiIZbTLzHHM6LJ/312BKmFmRVNK8wHDvLWu6QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iT+8eI6Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iT+8eI6Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121131F00A3A;
	Fri, 17 Jul 2026 09:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784281865;
	bh=mKO1Fiakkh1h+AOr/G3m12sMtIzuxXO//589j2cm15M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iT+8eI6Y1txWm5tXZ63k7xQoy6/SAph+D/9UJBUZpOJIYDeYsaBv9GN8mlBJOaKb3
	 DrHzbOg7hTsspo4GrP9mTh67woEt9TNZXiXP0VfJ2lPNCs9GmyrYJrQSSK4lx1SaVb
	 Xo4GpniTL/XJdIiPuxIzh9aG7oKYfH/QOMPA4xXnkNyd6jhGRU0hay9ZBlHsAwdV9A
	 cme+0PiNVD9cAkbGxZynhek23loyJNegih24xOXIDi1En+k2Zqu2aM495bFhfP1ZE9
	 Z9SNeA6FMoH18cIFYOuWa5COlEQ1j5b+hNu4/vtPV5fOCr24wlSvURTPnuAM+QMxzw
	 zS7wfZBbvxBpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0CBF380CECD;
	Fri, 17 Jul 2026 09:50:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] can: esd_usb: kill anchored URBs before freeing
 netdevs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428183738.1639384.11588765728790272276.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 09:50:37 +0000
References: <20260709164159.497640-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260709164159.497640-1-fanwu01@zju.edu.cn>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: linux-can@vger.kernel.org, frank.jungclaus@esd.eu, socketcan@esd.eu,
 mkl@pengutronix.de, mailhol@kernel.org, jedrzej.jagielski@intel.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Marc Kleine-Budde <mkl@pengutronix.de>:

On Thu,  9 Jul 2026 16:41:59 +0000 you wrote:
> esd_usb_disconnect() frees each CAN netdev with free_candev() inside
> its per-netdev loop and only calls unlink_all_urbs(dev) afterwards.
> The per-netdev private data (struct esd_usb_net_priv) is embedded in
> the net_device allocation returned by alloc_candev(), so once
> free_candev() has run, dev->nets[i] points to freed memory.
> unlink_all_urbs() then dereferences the freed dev->nets[i] to kill the
> per-netdev TX anchor (usb_kill_anchored_urbs(&priv->tx_submitted)),
> clear active_tx_jobs, and reset priv->tx_contexts[].
> 
> [...]

Here is the summary with links:
  - [net,v2] can: esd_usb: kill anchored URBs before freeing netdevs
    https://git.kernel.org/netdev/net/c/c43122fef328

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


