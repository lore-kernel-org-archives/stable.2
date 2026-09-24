Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C961424D47;
	Thu, 24 Sep 2026 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790248277; cv=none; b=hr5P92+AUhTyvNI51wbYofN29KpBV2tcIxXZLCMVDwpq5Y+oboVMdhP8yPzWUB2aZU95gslKAG0Wtt2pV0OjkYIzzi35uXLY29EQJx+8nQIM7cplk7sjFni3jTOxk7nwmpUrcIDeusrggQPzMKKBXj0pPMR0gQOEJ0sJUeUUDtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790248277; c=relaxed/simple;
	bh=bsqMwbnYsU9IFJZ5b/yjqdvjfmshX1PCc8YY3IyoMvQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WJCFCu8DNpJalukfVuUjNlk6u9oZwve+7oCEPAYCyyHZ4y7AhSR41NgIZL3xhKodh5+5nyTJ+kV8wU0vWbicoGCwykclSY5qhGBT2M6o4zCN+XHZHtTVP1CKuHDuiolBGJAjfuvx9Pkam+z2mqI2p+dkaX71p6OM/1BWJ5ljEE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dPRiXmnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dPRiXmnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E284E1F000FF;
	Thu, 24 Sep 2026 11:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790248275;
	bh=M0m4v6M+T1Mdbf0aU8kI/3LeWp+VXMErNwlcxVOP67A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=dPRiXmnXREwMeUPd1bzrPqSantsP6AkHuLSpJWoR7yl/v/N31FcsT7XcNnvArBQ6A
	 x4i6McyXshg4nAWrP+lQEJKauczYD8pxWSbpRt9kQB7GbJerrDKh469qbE0b95UrHQ
	 IAs0Fcvt/sIKzewJOSQeVa5jsY2cV/T3ilngc7XnnA3twsHRJkl09asWGKXjVMRjiM
	 JL11GR14X5LQLtE5iYxpMVTwebiP550bzXULIzOzK8wuB3cXGi8R87C8rA6//YY45Y
	 7cTasNrRxVJ+URPR/WnzjitbWW6DJC1IPrx9lY3Q59Uu5vwiC1QVwBOsZWEMZMflHF
	 M/ndKvFC+rxaQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5687C39EB075;
	Thu, 24 Sep 2026 11:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bna: prevent IOC timer rearm during teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179024820515.1482887.3609644266293399580.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 11:10:05 +0000
References: <20260922014605.588040-1-mhun512@gmail.com>
In-Reply-To: <20260922014605.588040-1-mhun512@gmail.com>
To: Myeonghun Pak <mhun512@gmail.com>
Cc: rmody@marvell.com, skalluru@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 GR-Linux-NIC-Dev@marvell.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, ae878000@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 21 Sep 2026 21:46:05 -0400 you wrote:
> bna: prevent IOC timer rearm during teardown
> 
> bnad_pci_remove() and the probe disable_ioceth path call
> timer_delete_sync() for ioc_timer, sem_timer and hb_timer, but not for
> iocpf_timer.  bnad_iocpf_timeout() then takes bnad->bna_lock after
> free_netdev() has freed the struct bnad.
> 
> [...]

Here is the summary with links:
  - [net] bna: prevent IOC timer rearm during teardown
    https://git.kernel.org/netdev/net/c/77b1718e39e5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


