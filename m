Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1D1C862F;
	Tue, 18 Aug 2026 01:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787016659; cv=none; b=I3O6ETYoDo68xv0MDRgy5V0qTl1cT7Gy8B0fsFqwo3eQGwKDEgWZxUpoP1ASd+Qv17XRXK4IncJE7E5SfvtfyseRpkFLz2GwJrXwu4iEHIJgh4TTQczIW3JOJyzYQq2Bi4v6H38zR2wAS905Q9MuDcwwPreY9tsCaR255XOWE9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787016659; c=relaxed/simple;
	bh=qrsUKyGPXaYwnwxiDADTZsQ1smw/Gfza8oJDandWqdQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FoThI4HgFwz/Kf8lFIb9zRb9MbQ7MVpYRqyHroA3us7EN/lgS04rrLpDUy2RLw5s9dsCAuzvJb0dWJDr4r+Otlcg/cZA9Ibtu8QXqdQhMF/aJef+3cZ3H26DykLIqI32NjLWfojyXvmsPuopEoPZ6eh7aWRbNeBWPL8UyjUPEvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b/jHCvOd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b/jHCvOd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D852D1F00A3A;
	Tue, 18 Aug 2026 01:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787016657;
	bh=gZ2npz4Jx7z109nco+dv2pFuCWDUSvOcqwj31wnlvOA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b/jHCvOd+fuR0r0xIh/jvHIuLLcyxLugjc8rbOAqzZd8ZAWxeN5eTyM746+cP+BEG
	 /7GllaUCBZoTiZV5OEvXNz0B2WNUXnE+5YNwbyaSTKbOGPW/d7R1wTnYeD7n/nRfHf
	 zQLtZN60n8Rxu1Qu43oRf2OhWDvNF5w4dzCekyi5Dd9VIlmEa4xfFCbua9Ozzmkpeu
	 SB7lZde3kb3t2yAIiUJ7K5DAYRJB3oY0y2w29G/SXgbPPKVhz/Bq2XluQAwGNEuqPu
	 TfCZgsY2cSNgMCrgrjN/HUr0ZBAqAsBELOFwZixmvR6xLmXtXo25rxOoTT9PN49IZy
	 l8ROcU4M7hVDw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198F93926279;
	Tue, 18 Aug 2026 01:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] net: dsa: realtek: use
 gpiod_set_value_cansleep
 for reset GPIO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178701660963.1820167.14181032995734666492.git-patchwork-notify@kernel.org>
Date: Tue, 18 Aug 2026 01:30:09 +0000
References: <20260814110102.2362246-1-o.rempel@pengutronix.de>
In-Reply-To: <20260814110102.2362246-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linusw@kernel.org, luizluca@gmail.com, andrew@lunn.ch, olteanv@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 a.fatoum@pengutronix.de, stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, alvin.sipraga@analog.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Aug 2026 13:01:02 +0200 you wrote:
> From: Ahmad Fatoum <a.fatoum@pengutronix.de>
> 
> rtl83xx_reset_assert() and rtl83xx_reset_deassert() are only called from
> the probe path, which may sleep and is not timing-critical.  When the
> reset GPIO is provided by a sleeping controller such as an I2C I/O
> expander, gpiod_set_value() warns:
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] net: dsa: realtek: use gpiod_set_value_cansleep for reset GPIO
    https://git.kernel.org/netdev/net/c/fb58b6a696b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


