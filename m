Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC7F371897;
	Thu,  6 Aug 2026 13:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786022455; cv=none; b=GleCWcfmcSdg8J3+/ok1SPnOt1eI+UGnyiOutlvTfxXyx0o1wikza/dISD1ivpJkJCH1J1IyKt3QvvMSNW5iewp7QTXtrhnbi9g+Bl0ZyS/HwV++E2FYLhGAD4cRFE9bRjX6mmwYkZG8afAIlXdEhEXZ2K72RnctFKQTlOp/R/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786022455; c=relaxed/simple;
	bh=UV6ksYxjBjcF6snCyhIG5tK7/qFstSsI9////vM5eks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pUMssgRL7kH2JXQx5cYJHYxXt6fvMyZHTDyrLWFmufa/uxdCl41uu4MU98xL++YIC7k7+yEhIm1JUc4gQUBN20ZXjqJ0DlY76n7tm7gLtf3wID4MD1vuXT1LIg+R1zwW9rJ/qHiUmYG24W9YOmGjJNS6rMvFvwD3DbsvA5ENhaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLgLzMAm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLgLzMAm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D04D1F000E9;
	Thu,  6 Aug 2026 13:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786022446;
	bh=Surlx/2l+z2Yj4QRGGQoSLMlYGJNw9MVjsoZRAbVsxQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hLgLzMAmob8Q5ytVF67nN5OhQWQqYvkDnjyxAwcja0dUB5ly/jxUUbrMO/EUtqYrg
	 Y7QQB7xKu/BEJY6g2uUREo9NsAUNwgLTKnmrz+R9i/Fy95ozisaSK1RXP9OOCyZ2wO
	 7XfI5qX4h0VIu+UG4gsFe2/OpmSJwf2Jv6KWR+7MgNoFsyR4twzR0AfdT5HsFHjY0W
	 qHJxMjNwfC3+NFrHqs8TFCOvXINvkGfPaect4l3JttrZ4weQVVHb3/8rRdbVEKmp6e
	 EoPHHhlFQ5dqaFutr9l9iBar9s1MMazRpUqFyJvlAInZXJLqc7TYus9LS2ldFesY2o
	 J7e5x3Yf83J+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1996D380820D;
	Thu,  6 Aug 2026 13:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: octeontx2-pf: Fix UB in shift operation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178602240564.840277.12436088481002390035.git-patchwork-notify@kernel.org>
Date: Thu, 06 Aug 2026 13:20:05 +0000
References: <20260804120446.1955448-1-Sergey.V.Frolov@kaspersky.com>
In-Reply-To: <20260804120446.1955448-1-Sergey.V.Frolov@kaspersky.com>
To: Sergey V. Frolov <Sergey.V.Frolov@kaspersky.com>
Cc: sgoutham@marvell.com, gakula@marvell.com, rkannoth@marvell.com,
 sbhatta@marvell.com, bbhushan2@marvell.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 naveenm@marvell.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, lvc-project@linuxtesting.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 4 Aug 2026 15:04:48 +0300 you wrote:
> From: "Sergey V. Frolov" <Sergey.V.Frolov@kaspersky.com>
> 
> In function otx2_get_egress_burst_cfg, when the parameter `burst` is
> 255 and the max mantissa is 255 (0xFFULL), `burst_exp` is set to
> `ilog2(255) - 1`, which equals 6.
> 
> This results in an unsigned wrap-around when calculating
> `(1ULL << (*burst_exp - 7))`, since `*burst_exp - 7` becomes -1,
> which makes the shift operand 0xFFFFFFFF. This value is greater than
> the width of the left operand.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: octeontx2-pf: Fix UB in shift operation
    https://git.kernel.org/netdev/net/c/7e2d693af0d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


