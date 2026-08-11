Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625504052D0;
	Tue, 11 Aug 2026 09:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786441850; cv=none; b=qeTctkz74URhEKnog/bhqLp9STdf0U3BTb7KP9IU1v4ZVOn0/DG5g4WaHquo2/k1/C76sCToEyLiWoSf7OyxJMhJJ0/2L6Fq2Tv5EOBpmNEHtEhBODpxQOlxY7KDS1L2EG/rUS8BeOuKVjjS7JGu6u0X0CEoJudRbLuCYvVAOB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786441850; c=relaxed/simple;
	bh=8tVcFbb5DaBNqcjb75DqxE2j5SM+cGjXMSc9o0kqSSE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WwJKamgsjqg8QIev++AjXiVRjOwjk1NjjV93kzQGY9SXr0GtIwlh2qTyClYiCmVhb54Oa3DqnH8kvyMjpZA5Y8Bjqp997Z4FU7QMFn7kv+bJCIVyeG2naqKwXXCmm3DT7xxtEWXU1yfyEEGcRqg0yvUn02IIOtLRC39vrgk6UUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+KdWTb0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+KdWTb0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8E2A1F000E9;
	Tue, 11 Aug 2026 09:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786441848;
	bh=NMb7wFNbCTCWnWg96M+q57B996nGDYG9s1EJb7bzAKg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=T+KdWTb0VKL2ddd+yDxK9nIOQ2P0j9Wt3H2xtbmYkdKHEkTjqRoKgZ1Zhc3o3tZQW
	 lRxHtYntXn1F9FWdG22OCv6KMq7ZtWt6miMN7OW//6xJ+bquFXJoGnSWNlzBU/rcya
	 6fb/uSlPNCeARlJHFVHBEN46nY4p6WJry6o1naT1/PDXYvjq66JhgWqSx98DZO6yox
	 07iEtNPEEvIRZDEIqBsio7oHhYc3uUKnIf8XGjS60oAlSyJqLcuHqi7YwEjrswtJ4E
	 1XkW5WvgKT6ysAVrL/e6mqeQEnPTKbXnNWFj1zgOQt9FpdWbVqere5U6Fe25F/bK9V
	 WF9zlZRD6C5ig==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5680639263B1;
	Tue, 11 Aug 2026 09:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] vxlan: do not arm the ageing timer on a device that
 is
 down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178644180515.447232.7349065220132702287.git-patchwork-notify@kernel.org>
Date: Tue, 11 Aug 2026 09:50:05 +0000
References: <20260809111829.78834-1-baul.lee@xbow.com>
In-Reply-To: <20260809111829.78834-1-baul.lee@xbow.com>
To: Baul Lee <baul.lee@xbow.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 federico.kirschbaum@xbow.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  9 Aug 2026 20:18:29 +0900 you wrote:
> vxlan_changelink() arms vxlan->age_timer whenever the requested ageing
> interval differs from the configured one:
> 
> 	if (conf.age_interval != vxlan->cfg.age_interval)
> 		mod_timer(&vxlan->age_timer, jiffies);
> 
> There is no netif_running() test, so the timer is armed even on a device
> that was never brought up.  The only synchronous cancel in the driver is
> the timer_delete_sync() in vxlan_stop(), which is .ndo_stop.
> netif_close_many() drops devices without IFF_UP before
> __dev_close_many() runs, so that cancel is skipped for such a device.
> 
> [...]

Here is the summary with links:
  - [net] vxlan: do not arm the ageing timer on a device that is down
    https://git.kernel.org/netdev/net/c/b37971686ec5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


