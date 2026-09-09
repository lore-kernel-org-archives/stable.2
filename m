Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEC53C4B6F;
	Wed,  9 Sep 2026 20:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986485; cv=none; b=KtdKUvT7ZJvfdNOXTTknc4BQyrLFvM4Qy+uuuZESPtFamfJfuuqprK6Gs3ijM/tEPZGetfM2r8j35qnRgNvLPHwTQAJVrWi0dndN4qC3wYJavRQzrNdw0xJ6k38HCeQ1YFcJ6qCr18qPcF7PzB5ffQNIswd9H6PbUr9n1PKk/IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986485; c=relaxed/simple;
	bh=ukHD+YLjXnIDABKJcQo8x5gwNr/XGasbypYzUBvbS/c=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RXI+uWU9B49UmV+PXVJ6PyktF3zi/Ot9lIUDO67ZqHoKyhzyWHKCjUfRUyTic7H81EEypn6GteaOi9vIOU/ThZhoMeLO4vro42L1e3/1cgh9rFJThxxXNqG1s3ygx+rMJmL7hymWiwTDsswzDl9Sz35OMZzpyyTNXOqGBLAIG9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iTvlE+q0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iTvlE+q0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F92F1F00893;
	Wed,  9 Sep 2026 20:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986473;
	bh=iUzflG7B0N9sDNtHEMAJvZLywGxQmMBQk8bi50rj9xc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=iTvlE+q0dwtB1f+prYRCkN5WxKSpz5u6xbqYV+XwIE4VHCQd3+lWwFYarHBC71W6F
	 gKM1pIqpIE9hQkBhlff48EKFZ7r2nvvfxUghUQr//dY6pigbO+JFJF9D5mNNrBWZ4E
	 wITyXJ6kYNnUgxr6JsapLgwUDokKExGeYgJfBNX71ZWnoXT5hAjs+sIRUmmZswXKjw
	 ff5i1sh+JcPL1y633cl4RtwtIWZmRpZNBIDnjV1hOrUL48fqQS5m42ELwc3jyj2eC3
	 JLxPoVa9tzMd8acGM2GWhdB2RKFn8OB8KEbSbmKVfZUKWWVI/Q92AjPSewE2SpDjPm
	 mi0X1uMPvGenA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A11380AAD2;
	Wed,  9 Sep 2026 20:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: tag_brcm: legacy FCS: request needed
 tailroom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178898641089.1048067.423729789793911145.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 20:40:10 +0000
References: <20260908165047.2786340-1-bestswngs@gmail.com>
In-Reply-To: <20260908165047.2786340-1-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: florian.fainelli@broadcom.com, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, noltari@gmail.com, xmei5@asu.edu,
 co+28eef7d8af9428e6@bugs.sh, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Sep 2026 00:50:47 +0800 you wrote:
> The legacy FCS tagger calculates the CRC over skb->len bytes starting at
> skb->data. When a nonlinear skb reaches the tagger, this reads past the
> linear head into unrelated slab memory.
> 
> The tagger appends an Ethernet FCS but does not declare that tailroom. As a
> result, DSA leaves NETIF_F_SG and NETIF_F_FRAGLIST enabled on the user
> port, and nonlinear skbs can reach the CRC calculation.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: tag_brcm: legacy FCS: request needed tailroom
    https://git.kernel.org/netdev/net/c/5be081b83abd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


