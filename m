Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECDA348C7C;
	Thu, 25 Jun 2026 16:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404457; cv=none; b=Fy0Kfjv174b2JAfAFxvLV9V0bRfduCGcuWyXYs6RpIDqW5fpeRPp5sJGFpP3AR6KiIL4YOaOy7C41Uw76mOLaXem9PYtOzjcCElFuQ/uCNNwe2nZDCnb0SIlagSKMJpBeo4U7wFX8ZqxvbdrfelLttCtnordsBlNtwPm31/gREM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404457; c=relaxed/simple;
	bh=JPExWHoNlPEqwaD4nqODBhUKQ4ugk8ZGQOJ6a/PZtM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N58IH46a6rdIbKJSP/+t1ky56yd0hKQq/h51q0fcosMY7w38bTbBvXvkb9UTw56hU/OzpDoCi8x35xw5p+kwIbajq3zjSTAPNAIYDMBr9PqLQcqi5I/AKLuBZwCEyBjYnX7mk4S0YhCS1Ew62WvJMjoPOAhwLfpEF8wIP4Bvj4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SWfaIE/F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SWfaIE/F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC4401F000E9;
	Thu, 25 Jun 2026 16:20:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404456;
	bh=redyJIzOVlH6SSwsO5/FcYyXZxM5UVBYoloKFR2p79M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SWfaIE/F6fsJ/3yPZLDOfI98cvJZefn+oEgH18/LkuK8hq/9AQLjFxsB2RdWN6AKU
	 czD1ITqDLTB5NOtrqT3gZR7j2FQ7gF7uFR1CGBji4gVK5qKkD3dQIj06wg7BZ44KLL
	 wCtrURbFlI054twrtgII5j2yfEt2v++j9NXGIPFMndRWSnTFvuPPKe0XP3SJV5Mlv8
	 5ahrvHHne+pmSZRRl9xe9O/l4cIHxg0cH0dm31V+gOk4mMudBE4LFRY/TxE+axJK3y
	 1D79ob9PKNweAVC1G2Y6j6rRe/5sS25xsJdGgAapJCJyH0MVvqkfvMIXxrxPIOshm3
	 uQsmF/IyiM7uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A23AD449A;
	Thu, 25 Jun 2026 16:20:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 net] net: mana: Optimize irq affinity for low vcpu
 configs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240444427.3803792.16004003411741167135.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:44 +0000
References: <20260624072138.1632849-1-shradhagupta@linux.microsoft.com>
In-Reply-To: <20260624072138.1632849-1-shradhagupta@linux.microsoft.com>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: decui@microsoft.com, wei.liu@kernel.org, haiyangz@microsoft.com,
 kys@microsoft.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 kotaranov@microsoft.com, horms@kernel.org, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, shirazsaleem@microsoft.com,
 mhklinux@outlook.com, longli@microsoft.com, yury.norov@gmail.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, paulros@microsoft.com, shradhagupta@microsoft.com,
 ssengar@microsoft.com, stable@vger.kernel.org, ynorov@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 00:21:35 -0700 you wrote:
> Before the commit 755391121038 ("net: mana: Allocate MSI-X vectors
> dynamically"), all the MANA IRQs were assigned statically and together
> during early driver load.
> 
> After this commit, the IRQ allocation for MANA was done in two phases.
> HWC IRQ allocated earlier and then, queue IRQs dynamically added at a
> later point. By this time, the IRQ weights on vCPUs can become imbalanced
> and if IRQ count is greater than the vCPU count the topology aware IRQ
> distribution logic in MANA can cause multiple MANA IRQs to land on the
> same vCPUs, while other sibling vCPUs have none (case 1).
> 
> [...]

Here is the summary with links:
  - [v5,net] net: mana: Optimize irq affinity for low vcpu configs
    https://git.kernel.org/netdev/net/c/5316394b1752

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


