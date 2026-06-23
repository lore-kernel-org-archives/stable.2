Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E069369234;
	Tue, 23 Jun 2026 01:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782178223; cv=none; b=Xz/vN9L5L8wklYdjO2VWnd7y6BP9q+vLMcXJub/Pcl3h/yZSafI+B7nXXapuZIBk8lHJWnKLUMu8cz9S2uV8cuAL529135nH3d6xW8QwTKyHZWdDfX/dyKjt0+BQPoWihqD6BTkNNM9dSWPyhlw9lK50HNq4x+/L9EXqLW1mJS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782178223; c=relaxed/simple;
	bh=YF9ftz5RCBKjYnIjEwLjeaRvCaZnre6RWM+aLZ14O4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ocaqm5vPA+5+IRykDkI/WX8vkDrjjYs3AR3vFQrtJmZ7ovM2GKzkVGeY6CQ8GulAQhQcDbgfTpcZENKVpZ+tNUZSD7dq7dGMVXBzyZ28Cl+dAFh10C1V21VKD5BwDSjxRYRi2rPREyC/zrfdtEQJl3wCFoQUfHKTkRMpEf11jqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N55a0gJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N55a0gJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BE81F000E9;
	Tue, 23 Jun 2026 01:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782178221;
	bh=eR7JjrV3zhpo3lRNLX6zAdd9ulOAgIgurKLwWRFmcG0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=N55a0gJhOuRzunH+uiN4s4MTVymbigHQMAUGvay4i9/zBleVOb3s5DKen0k6SsTTA
	 TfZZAKoj4UbuRV8aAgMMSYiSzZDLRnk0Ee5QO3Oy8aOLEwvK+Hjdz/qrctUn+HM3Ze
	 z4yhFbzB1+nhJxFnoEcWRe1pi6RTkSqqnlWKKjsddzBxBD5cbCBTbMdC8hNmX0okA/
	 KFsv8uW1FFpITP5v7h+JRmkXuvDWh9oUjSG2ugsbdx7jy4S38OQ8EBAm/KVo2RdyMG
	 BtFlpNcLIrMgbfFusx1NggIMymmDE7vgz9Jjg66EYCXUpz4xLVrNUJ4Yiq1OQ6LBap
	 JblNFafQ5IAKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56C8C393098F;
	Tue, 23 Jun 2026 01:30:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/wan/hdlc_ppp: sync per-proto timers before
 freeing
 hdlc state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217821199.1493333.4954244089937861432.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 01:30:11 +0000
References: <20260617020518.116319-1-fanwu01@zju.edu.cn>
In-Reply-To: <20260617020518.116319-1-fanwu01@zju.edu.cn>
To: Fan Wu <fanwu01@zju.edu.cn>
Cc: netdev@vger.kernel.org, khc@pm.waw.pl, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 17 Jun 2026 02:05:18 +0000 you wrote:
> Each PPP control protocol (LCP/IPCP/IPV6CP) embedded in struct ppp
> registers a timer via timer_setup(). That struct ppp is the
> hdlc->state allocation, which detach_hdlc_protocol() frees with kfree()
> in both teardown paths: unregister_hdlc_device() and the re-attach inside
> attach_hdlc_protocol().
> 
> The ppp proto never registered a .detach callback, so
> detach_hdlc_protocol() performs no timer synchronization before the
> kfree(). The only cancel, timer_delete(&proto->timer) in ppp_cp_event(),
> is partial (it does not wait for a running callback) and only runs on the
> ->CLOSED transition; ppp_stop()/ppp_close() do not sync either. A
> ppp_timer callback already executing (blocked on ppp->lock) survives the
> kfree and then dereferences proto->state / ppp->lock in freed memory,
> leading to a use-after-free.
> 
> [...]

Here is the summary with links:
  - [net] net/wan/hdlc_ppp: sync per-proto timers before freeing hdlc state
    https://git.kernel.org/netdev/net/c/c78a4e41ab5e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


