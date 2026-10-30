Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352007;
	b=oV9YIyDXctRvW+bCxsqMX4d+zaNEv1tmeC/wZBLTXsXm+MFGVNuLYP6V6J9r8kV3AWah
	 W43v4xp+Vdz9BiMvhHl+1HFP5qW/L2QzsOrIYlu+JZaV1pptsNZfS8s7sx0cVzaUQW9yu
	 x0GBKTU6MoV1q8UmA528AGiR4xRKcsOedxQdQZ+Kt8jJ1LvvtKuBRNoRgimn1WASfZMnR
	 d4aPhL0nj+YyVYTcSF8mprZpCfx6O6l3HUamP/1fY/6TNXqExUSPTOLyros2JtqmwZQ+O
	 7RqdnSuqXPBqqOIC/YeIHJkU6XmiQorlwZAZW3bLCyI49uLP0Rbzu/8tiKjPpwQKM8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352007;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=wMjH5QFfbXjou1hlcW2es2kuGLk3Uu/YVisNAb4ULls=;
	b=HHj7SnDBJtv7rSzOVksq/RXze3UgoxQ9b/PLRykH0K153RMoWGK4h4Cw2KD3x2ShAkMg
	 0FB73YUQNuLZVmgn1gCfOTNzNAqsEZfmlOh5BaFffm6g5GMaLYO0N8IDVfTNLXnVXx4SK
	 /VcZxb9WbHL3eYN0yHscPSt61On0q3zFH/ztdtuUW5jAboOnHS3J3tjUSHzhure3m1l9Q
	 ecr2+4kviNoEYBCniH0cF6Q4pYtYtZRcHV7vOkT76sKFHSOu/rJzGsSFRrfCV13/LHELw
	 on5+6/y400CNgy35Q5+ubE7vwXdpPso/ZNMo18d4Gh84pqwr60+8mK02vvQLo14tv/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kM2bE12P;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1439606A31D;
	Fri, 30 Oct 2026 09:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kM2bE12P
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DCF1F000C1;
	Fri, 30 Oct 2026 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793352006;
	bh=wMjH5QFfbXjou1hlcW2es2kuGLk3Uu/YVisNAb4ULls=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kM2bE12PJtFlNjin4JIptVk0qKzFENz2goHlmx1tOlx8SkT11h5y4WWPFe0kvZ2zl
	 ke7U4Z3ZBiDdI0VU5rd+Aq1mRiK2fSTTp1GUTKnhvHd6GdHIn8yGf/unFxJ++eowgE
	 9VYbtXaQQbFTTnTl5uCtWKKKY+dlGGgjSL2HWszPsGHAeTemyDwP0f1KbPodtVWR/7
	 KCpaB83dRjnNXZU9/b6mRG+K1qzq01gfDvIJGYusRLpZ7e/K3mMeLfDR+hB2s4E48i
	 bOXOUTVqvR4LP1ryYaQxzb8NnLkLtsqB45L2BtWEBe+z76yyHGGVrxAP/nIJQW0dcl
	 RYx9uiFmv1Gng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4017138007EC;
	Fri, 30 Oct 2026 09:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: jme: keep RX MAC clock enabled for WoL
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179335200508.949794.12076819632653160478.git-patchwork-notify@kernel.org>
Date: Fri, 30 Oct 2026 09:20:05 +0000
References: <20261024-jme-wol-v2-submit-v2-1-7a89ef6fb4c9@gmail.com>
In-Reply-To: <20261024-jme-wol-v2-submit-v2-1-7a89ef6fb4c9@gmail.com>
To: Franck Baur <franck.baur.67@gmail.com>
Cc: cooldavid@cooldavid.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Sat, 24 Oct 2026 14:40:44 +0200 you wrote:
> From: Franck Baur <franck.baur.67@gmail.com>
> 
> On the JMicron JMC250 revision 03, the MAC reset performed during
> suspend leaves GPREG1_RXCLKOFF set. Although the driver enables Magic
> Packet detection, the gated RX MAC clock prevents wake-up from ACPI S3.
> 
> Keep the RX MAC clock enabled while WoL is armed. Restore the gated
> clock state immediately after disabling WoL during resume, preserving
> the RX engine initialization ordering.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: jme: keep RX MAC clock enabled for WoL
    https://git.kernel.org/netdev/net/c/ed9179fc7228

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


