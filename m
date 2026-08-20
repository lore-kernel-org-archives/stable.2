Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42DF3C13F5;
	Thu, 20 Aug 2026 21:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787260864; cv=none; b=Hc4xWpi2Y0WGl1oGvx60ya+t/QwI20GRBM/r18DcesivJoj1v8wZ3vJrsLO2G0lse5iZIsUx6yYH7Okw9qVd220G32lMDi3dpv9LW/p7rHbylXxuQ8eABL+lv1wBqTvpezAECaFbNstXNT5W1GMUqx3HtEo5at/U+cMhc3PzDhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787260864; c=relaxed/simple;
	bh=DNcgQTkBQf2hIYzPb7ktk7cjetRYxnCKlQ68rhPpbdM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F83f/YGkIsN1ARE8pNtTlcswKhpT+Q9qPvt5B+8fupshs2QyoGZgs+5iUsHwlayCFuoRH8KtEGcrZFMhDwgc4qVdUNraqi0zrtBgz/kqa16PKMxkuGOJ5wnFDWKZ9SbRy6kC6wlIg1Ig/rnArlq5dnVPDtDUHiwIFjOcBEEpewE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdDZ13lj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdDZ13lj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 747231F000E9;
	Thu, 20 Aug 2026 21:21:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787260862;
	bh=/MsSEeUrcW/6FkkcmaBIPSVkJ82YiN7xLenniToTdDw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=hdDZ13ljdGisw+qb4tXoiJXBynhWxnMiUocwI4YT0u6a21mpLOZ/XSuOUrfVsMd9y
	 g/0s14JRc1+i4rJZq09uC39q/Q/2VNXhKfbEY9UPbXg45AZXPDfzLi5BB6TI55J7JO
	 0AAXTcCHn8zYjx3JdNiLeVLyWy2m6nVwk9KVGdtEpszgw7F/AWLm/vAF5t/yU603QC
	 uq7ql1ZD0DW+tBQ2jv/PBwZVoWy4UKuFKuJsu2iZYAEBGLKVzSpj6ED0EkO0w/wjF3
	 AXlF1cd+d/sh7YMxSMh2ZANz4Tzi1hSVOLi09x10wAfLTAiZv6Li54I8IVCPIrxmz3
	 LaBgqQj1QluqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09BC3924468;
	Thu, 20 Aug 2026 21:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: phylink: correctly validate returned PCS in
 phylink_inband_caps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178726081238.489531.4616366200802806687.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 21:20:12 +0000
References: <20260817213009.13924-1-ansuelsmth@gmail.com>
In-Reply-To: <20260817213009.13924-1-ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: linux@armlinux.org.uk, andrew@lunn.ch, hkallweit1@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 23:30:03 +0200 you wrote:
> In phylink_inband_caps(), the PCS returned by mac_select_pcs is only
> checked if NULL but mac_select_pcs can also return an error pointer.
> 
> This can cause a kernel panic as phylink_pcs_inband_caps() only checks
> if passed PCS is not NULL and directly dereference ops from the phylink_pcs
> struct.
> 
> [...]

Here is the summary with links:
  - [net] net: phylink: correctly validate returned PCS in phylink_inband_caps
    https://git.kernel.org/netdev/net/c/f2849b1fd059

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


