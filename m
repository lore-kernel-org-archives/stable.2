Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7141DC1AB;
	Sun, 21 Jun 2026 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782080425; cv=none; b=glhmdIAp6DfRyTLFoZ12GffTW3Qfjqc/7KuGS+NgeT3a2pDqzghd4R2NlrI/6XGleKIzJoB/kwlPrEizcEokNMC3acZuXW/KlSM8epVjLGm9wCPlVA8K5lVVoEyol1+zprRMucA6hciP0inMrdA2XFZUJIdzibkq/Ry9ZKvPGoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782080425; c=relaxed/simple;
	bh=T5VUv1Ga4n7x+9385+Sru3gH6NETsqNWlX+DwZVTA8E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Egkzhz6qrirCQaLK5XzDB7jQ34CCviIn0oAekNjRWPDuSFXCIw58REFpWx0zwmcUA2iLDYnu+bqa0E4lXTpgaXR3Lw2ROIwUjE7EO7vWiSjx/Rx+Hx9Exf3e4V/ZnYSl8uM+ptSW4qPts/jZinhALtyQcGfx2dS2OHMgTPyqgKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZGeXYCJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZGeXYCJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 546EE1F000E9;
	Sun, 21 Jun 2026 22:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782080424;
	bh=WCmA0qQBJ2YcrfyBTEx4uocETIQnp8oA9pluEsWaoew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CZGeXYCJ8Zn0YgYqVPcinLWDRFNBGiNhV2OkIBkSSUfnviUynfIDFCTHoEwH6hgI+
	 uxm6+yw+Tnen22aoFGO5ckbno5lRccq/JBp1Y3Kp6pJUNNpviuHnOgUzd0fj33TkK6
	 Qh7x7kzlDQjWOKQE4biC5MJBVT/KIf6A9/UhHr4VTKgj/yBiLKJbCz0YNhvz1xvyQe
	 sKkd2WEkkWjanOHNWcJSBEb76zdFUQALbikIQ1V5Jn3dA4F28EJhP69szWwcBSkoY0
	 cJjRUaWkBFp56ewc/INuh7zdqEuL+Dt7j+wFpsYUanp8qnlQSPrRj3ZSTyOZSn6GPQ
	 kTVaMbIdtwmRA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09FB3AAA6EA;
	Sun, 21 Jun 2026 22:20:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: sit: require CAP_NET_ADMIN in the device netns
 for
 changelink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178208041545.521994.18016551360259263471.git-patchwork-notify@kernel.org>
Date: Sun, 21 Jun 2026 22:20:15 +0000
References: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
In-Reply-To: <20260618070817.3378283-1-maoyixie.tju@gmail.com>
To: Maoyi Xie <maoyixie.tju@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kuniyu@google.com, shaw.leon@gmail.com,
 nicolas.dichtel@6wind.com, kees@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 15:08:17 +0800 you wrote:
> ipip6_changelink() operates on at most two netns, dev_net(dev) and the
> tunnel link netns t->net. They differ once the device is created in or
> moved to a netns other than the one the request runs in. The rtnl
> changelink path checks CAP_NET_ADMIN only against dev_net(dev), so a
> caller privileged there but not in t->net can rewrite a tunnel that
> lives in t->net.
> 
> [...]

Here is the summary with links:
  - [net] net: sit: require CAP_NET_ADMIN in the device netns for changelink
    https://git.kernel.org/netdev/net/c/27ccb68e7ccc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


