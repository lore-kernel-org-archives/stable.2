Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B60C4A92CD;
	Thu, 24 Sep 2026 17:31:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790271086; cv=none; b=CbGbKfUwQiZNJyJfkuDkPU7KP/KsIpNfSYUveOHDcjKDU9Z+77rUBokJO8acsCa23dIh7zJWDvU5lqeaUrXUJS0Yp1d4kZUUeuQRNyBEGm+B0213aTiwmdxqjmRAXmLK8c448dWvcn4bvae8p7ir5t7JyzFZY6yrdd15p98MX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790271086; c=relaxed/simple;
	bh=75yp22glZCb9zuTwwdXSGtx6eVb+PBGQObvswGDTn1U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XsPSw/L3TQRxmqsEtZ44ma88lkxwiGz6zCeEHsUc1deukpGsIlC1NKlFxPrBmegI4szKvGZWgu4GPrkwO9n5diwTy4I3eXh7bvExEFCRJEXiPmFAjwz12YYw04a4l8IMEo2cRhBKoXOEO0ivGsnuXMTuu42XF02D5vOR5UoGd60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bv3RfDz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bv3RfDz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D3BF1F00899;
	Thu, 24 Sep 2026 17:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790271085;
	bh=+HOaTT6NFgdxpfVk4cVtY/dZngkmWLnZAxPyUSj22VA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bv3RfDz+sEpudexZGcKimHMhO/ALc8K8bp9vtyuQAcHTXZbRRm9nAuLvQ1CMKumOz
	 t901COyY9jOL/gOxnevB32eILXGMgjCQVTMYMTRsBEVAVEdY+ZuTbDlYax3IBHrpQV
	 tzZ5qor3vE1U3izWkRL2rTdfhcW0YcfKE8W88xvCBhVJQBV9kK3zFdXxjTgrbDF3i4
	 tCImwLGvTlhFrjGPkWYHcm2tlx1nNsP/Htcyt8edhUyFqeJSbnUtCU2eVXzWvv8uxX
	 PLMCREl6PWgFgakBnNiSEHvn32TwGuSsnXhICSerKvHP3KSoqoqx87alRch0Dy7vLv
	 GMQkkJ2Qd6XMQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56AFA3A566DB;
	Thu, 24 Sep 2026 17:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: phy: intel-xway: workaround 100BASE-TX
 Link-Up
 issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179027101415.1669750.10138214734106545986.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 17:30:14 +0000
References: <20260922075251.23386-1-alexander.sverdlin@siemens.com>
In-Reply-To: <20260922075251.23386-1-alexander.sverdlin@siemens.com>
To: Sverdlin@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org,
	Alexander <alexander.sverdlin@siemens.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 olek2@wp.pl, daniel@makrotopia.org, john@phrozen.org, hauke@hauke-m.de,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Sep 2026 09:52:46 +0200 you wrote:
> From: Alexander Sverdlin <alexander.sverdlin@siemens.com>
> 
> MaxLinear GSW12x/GSW14x Ethernet Switch Errata Sheet states:
> "An issue has been sporadically observed after device power-on on the first
> link-up attempt in 100BASE-TX mode resulting in either the link-up taking a
> long time, or failing to link-up altogether...
> 
> [...]

Here is the summary with links:
  - [net,v2] net: phy: intel-xway: workaround 100BASE-TX Link-Up issue
    https://git.kernel.org/netdev/net/c/b94773dc4df7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


