Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA33032C937;
	Sat, 19 Sep 2026 00:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789779079; cv=none; b=jjxRTpne4aiROcxo1cvPfKCm5G9JEPWAqkquSZ+8HR5SX6LTTLKVQh/py1pqvCOpkEjgD0vKMo1VSkAZF710hn5RE6wwf6HVhDb1fWmGxhR2ktXdY/+BQ23fFaEzL6E7zuae1fZCYY6Nn86cXh5l2C4PVDwx6vhiTV4/jTjkc/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789779079; c=relaxed/simple;
	bh=HilSvSQ4yLUiKHRmolkzokAMmeJPgM9mLWksF322B28=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rrWucQDtU1sycA2NxbZAlJPMFs6JEGkKOmgiuTpMoeNuB4Yz5+MopmeyC2G4d7NXq3KT8l1ZJtEGVcSUQQ7pr64WWWzZNGq4qHDCrfKBPboPdwFwuqj4udZK32hlCx7TjL25Z+2jk0CK8X9EWLlHV5ucPwZ2RIMFu+8F295Y1e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H7yKy1Bo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H7yKy1Bo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31A8C1F00898;
	Sat, 19 Sep 2026 00:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789779076;
	bh=APJRPQQ8l/sUsDmP3jOOlOOG5TW1M5rYEXlJvTnGoew=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=H7yKy1BovtIlUFapscNWLtJS1P+8pDS06rsyqHpBK+coAb2daOtF9dgqIBRGmRW2u
	 6b6NLTizS0FuvRFl6cDsJu78H0NzC8GJS7nLGapynq2q52xBgt2PJdCsfIi4gTfosi
	 2EN1TSvESz1kEzeBUFd6o+weP6LMOjOzyqcqFrWTl704MRhrOKqlCJk2DTbJDBh2pl
	 6yDmSJ2U/GurQwBTpZvQL/EG3w6slt5hxPK0m+rlO6WBdJ/CZ9+ELS88YfxtZ7uWAE
	 PN9mgP8gi1x/WWuPGMqzbRXLLyhBac8t3sXhIT2xFcDLY6QpC/wlnWp8+ontM0HgS1
	 NmfLbWdmvsWGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569AA3811978;
	Sat, 19 Sep 2026 00:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: phy: micrel: Advance register data pointer in write
 loop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178977900889.1211687.16787571187832684308.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 00:50:08 +0000
References: <20260916231928.1336305-1-abhishek.ojha@savoirfairelinux.com>
In-Reply-To: <20260916231928.1336305-1-abhishek.ojha@savoirfairelinux.com>
To: Abhishek Ojha <abhishek.ojha@savoirfairelinux.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, horatiu.vultur@microchip.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 19:19:28 -0400 you wrote:
> lanphy_write_reg_data() does not advance the data pointer while iterating
> over the register table. As a result, it writes the first entry num times
> and leaves the remaining errata registers unconfigured.
> 
> Single-entry tables are unaffected, but tables with multiple entries
> leave every entry after the first unapplied.
> 
> [...]

Here is the summary with links:
  - net: phy: micrel: Advance register data pointer in write loop
    https://git.kernel.org/netdev/net/c/95c4d54ed022

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


