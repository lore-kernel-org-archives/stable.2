Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9304924BBEB;
	Fri, 18 Sep 2026 00:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690280; cv=none; b=alH8GHrz/QSWbqGnIkJy6WDYYvhpaUwyNBemvbuZ7UwJefXQ/7SYwX1k/II/MpQ+XWTx/1Q85vtz6lV37W6lpd63ZRmJVJ4/T4RkEk13gVJ9BhZ9Qy6bjVjrfy/RKFPqHqS0Nev86hRHxd2MplKxSgRCNkMYjlntEJ4u6giyykw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690280; c=relaxed/simple;
	bh=KUd7GMM4bx7huwiUqN8UXHIQg4swWBcFU8kNP3qC7R0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gr859UjT8MfYuqgSpUFLks52jupU5QuJO4YY1l/KVYCpnA0MPcnPV5fIU/PFJ1RYK5yr7k9C4mKNGqmH4rrr120Di5BiiKf8sYdo04j3yQLo8gzJl+xMmYvz7sKgNOfQNDA1/xgHS5dhQl8hEP2Kk1Us8+lvjCugScQZfAyhwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ddi1RNQb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ddi1RNQb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33ADE1F00898;
	Fri, 18 Sep 2026 00:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789690279;
	bh=pVHCPTLLZxYwMNUFm4GzFWylUOsYbhB5GcBZowUNl78=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ddi1RNQbB9VbSc4kLmX9KfFmmaH0218TKHN3xIc3ZqJpjlkCxUNqGurm0JWxis3U4
	 vict35VvADDH25vdCgs2iff9g5Ogg5G81tZCCHU/rh7Lc/atPvTglK/nnURcOOR2Cu
	 4U81drNaa2676hKd2/Ik6kUJbcwASbjOxGbHXktLTYm3KsTnVuQIOBhPhvLwdFaEyu
	 Ag1vtpVwARPTbUcdUAiZ+TVIvQaS9B61kbO80mOKEbtI4N5uXVQuFV9HM8gxWnffIt
	 4rbnlHb0ZYo903BDw46kz6YikJIKG0IWU+tV7vkuSulKQP/0ZmT2p4kY8/TRS7tDiB
	 PhNeIjxxYPInA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A02380820D;
	Fri, 18 Sep 2026 00:10:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/2] net: phy: qca808x: fix the active-high LED
 polarity mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969021237.191233.5401753089399778631.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:10:12 +0000
References: <20260915223138.321307-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260915223138.321307-1-donggeunyoo.kernel@gmail.com>
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux@armlinux.org.uk, daniel@makrotopia.org, rosenp@gmail.com,
 ansuelsmth@gmail.com, sashiko-bot@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Sep 2026 07:31:36 +0900 you wrote:
> A QCA8081 with an 'active-high' LED node does not work today, in two
> separate ways, so this is now two patches: qca808x_led_polarity_set()
> rejects the mode outright, and once it stops doing that
> qca808x_config_init() still will not put the bit back after the reset
> phy_init_hw() runs.
> 
> Tested in QEMU against a synthetic MDIO bus that answers as a QCA8081 and
> emulates MMD7 0x901a, with the reset clearing BIT(6) as f203c8c77c76
> describes. One kernel, one harness, three arms, x86_64, 7.3.0-rc2+:
> 
> [...]

Here is the summary with links:
  - [net,v3,1/2] net: phy: qca808x: accept the active-high LED polarity mode
    https://git.kernel.org/netdev/net-next/c/5117ce8c35d1
  - [net,v3,2/2] net: phy: qca808x: keep an explicit active-high LED across the reset
    https://git.kernel.org/netdev/net-next/c/f1b4766d67bb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


