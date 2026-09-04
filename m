Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A628248F7C;
	Fri,  4 Sep 2026 00:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788481866; cv=none; b=IWkCJVLYStEEl11/+o8eXjr9h16mrleasO1EnW6KIzTTlHnI1/gP0cWOfkRd+tqVgbe6sjW1/eSQH3FJ7XKIlWwm6xu0Y+I3ir0Gl8x934lSC+5tfdV2ki9Q9UwseW9Va0RbEUDGLTtBzQ0OFWzKuflssdnW+hUZ1JgN8JgIOM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788481866; c=relaxed/simple;
	bh=odpes+OAjoDCwF7OS7JQlVIPC/fw0woSm5yRQhPZllE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WtKK+UZlKTjOzeuHZRGFQtsWjIkMWQJCTbbQoGhrkQ5yJ3Ur6Pp0d7eu8i2TVkfUkO84omTx1/TkX/Q+bVPpmncGf4EuZrFYNhcAByRX5N5XePplqwsLMpOD2OsFnxtbURQDtidpLg39M1gc9nVp3FYlvAOLJDlfdNEPjIHTiP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rk7zR25K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rk7zR25K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B87DF1F00A3D;
	Fri,  4 Sep 2026 00:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788481864;
	bh=crL0Vw8cc7DIWD2tvXaK5+CrMo4pMPYXRKSJvrNWCXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rk7zR25KdNwrriCx4Ylunaj1Y0EbpFKJo4zsURHH45U4ERm/ZXsgm/ZyRl/Pk8jyE
	 HtxLd/HnS5HVmc+W7hVkVqhg20uI/5okdSvM5qwywpThh+rOi2daARmUArpsemzPv6
	 N9NXglxXNwnfDttgHE4fVhEhMEXo2zADZmxtYhCTYYvG0LkhnJiWGNK8yvJiazn44e
	 mkmvUYzuyaVGkScXENjyysrH9Vj8iuCsqf7fKQ+w5m4qE2SwYNuEXPQ8pjQOhYof7m
	 qjjofLkS1JqwXltHYKGW4drtI5UbQYkb/cqAyWbE4FPHUD4NggaISHNWttqD4HeJ0Z
	 sqLnaNCIlCaqA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198B638119E3;
	Fri,  4 Sep 2026 00:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] genetlink: pin family module during policy dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848180590.4085709.16082801667183048704.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 00:30:05 +0000
References: <20260902084317.4092542-1-v3rdant.xiang@gmail.com>
In-Reply-To: <20260902084317.4092542-1-v3rdant.xiang@gmail.com>
To: XingWang Xiang <v3rdant.xiang@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Sep 2026 17:43:17 +0900 you wrote:
> The generic netlink controller's policy dump keeps pointers to the target
> family's operation and policy tables in its callback state.  A dump may be
> split across multiple skbs and remain pending after the initial request.
> 
> Netlink pins the module which owns the dump callback, but in this case
> that is the controller's owner rather than the target family's owner.  The
> target family can consequently be unregistered and its module unloaded
> while a policy dump is pending.  Advancing the dump then dereferences
> policy memory from the unloaded module.
> 
> [...]

Here is the summary with links:
  - [net] genetlink: pin family module during policy dump
    https://git.kernel.org/netdev/net/c/6a1094c34d17

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


