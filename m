Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7710D361956;
	Thu,  1 Oct 2026 00:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790814621; cv=none; b=OvK+oFdqrCah2Wi7MrU5dtVZqX87t87NyHkHSKUh+Bvsb+hMGpJiGSbG71NUcQMDXq5v1MequqjkSjsmnDx+rQcXjsInXLcHzVjP/uNY/BAIvbBsU2bedVaictt/PMfwVrcSemsMJkJ0KwhmQWjnT3FBvESceILuDFYJ7+LLFXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790814621; c=relaxed/simple;
	bh=TeTQJyycTND2QGmXG/Gep4YBTsBRs5Ub5sVRgIveszU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T0ihVi0VMitV7Y5GVUCs41y7ah9l5bmYvFHSqz15q3oo2cs9h4ESwpCjds8SQ5MP7kT8FrgLz7aXGfe/dqTElZo4TT6ShApZTrjlj0xSvuY5gbrWuW8M4EjEK1yF+IsueNcXqubN4Rzqx/gaAJsQwuPHFvtMwbO9hjhWzMW55LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hO/6svfv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hO/6svfv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD45F1F000FF;
	Thu,  1 Oct 2026 00:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790814614;
	bh=ZtJLqcxMHhJNiuVnAUU0P/r2uSqXZNpcwoj0hTfClWo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hO/6svfv43D0oZCzzm9aiy0VIKw5o5zd6KNCwRzAirqkwvLQ+OtrXUhIWvC7fUmtx
	 Dh+93pSSMlFTNEvL8KfLlADHH+ROzgrpt3lih+CR80CCsEGZ9QGohN4wGYpma51Hkf
	 uo29HNH6oMEaYrNel0+U6YDbZ5wcNZa8Y2L5wXVbyhLye1cYRcYljZkKtuZ38v4xD3
	 //Zgs74SzgQ+3vIXEYqDtVz9HWLvfWfmPxf/c2d4yDxGuX9jC5lM6R8ysvzWTyi/iN
	 MIBlbzJrrqXezul62Hx82DffpcDUcCr+fSMqwXLnysBl2qMbJiWygv1oiLNFfVisci
	 nNbnENAm6m2Eg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B449A3AA6A61;
	Thu,  1 Oct 2026 00:30:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1 1/1] r8169: disable EEE on RTL8168h/8111h
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081461327.2189941.5041238879527277665.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 00:30:13 +0000
References: <20260925071040.2137178-1-o.rempel@pengutronix.de>
In-Reply-To: <20260925071040.2137178-1-o.rempel@pengutronix.de>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: andrew@lunn.ch, nic_swsd@realtek.com, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 d.piecha@ymail.com, stable@vger.kernel.org, kernel@pengutronix.de,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 09:10:40 +0200 you wrote:
> Force EEE off on the RTL8168h/8111h (RTL_GIGA_MAC_VER_46) at PHY connect
> with phy_disable_eee().
> 
> Commit 202fef9bbbf5 ("net: phy: realtek: fix EEE advertisement write on
> the internal PHY MMD path") made EEE actually advertise on the generic
> Realtek PHY; the write had been a no-op before. On the RTL8168h that
> un-masks a latent defect: once EEE negotiates, RX silently stalls after
> ~7-20 minutes. The carrier stays up, no counter or dmesg moves, and only
> "ip link set down/up" recovers it; disabling EEE keeps the link stable.
> 
> [...]

Here is the summary with links:
  - [net,v1,1/1] r8169: disable EEE on RTL8168h/8111h
    https://git.kernel.org/netdev/net/c/3cdeaef1754a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


