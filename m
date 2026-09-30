Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004D332B108;
	Wed, 30 Sep 2026 01:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790733012; cv=none; b=cuz8pBNxsfzv5cnodpxClOKBR90gBV/vf3bJlHb6HEGihU7aPJDV/Dk8sKjQERYz1b5A/bxdE9z3E/wuqxtK5m9b4Ygp3anBfzrtV61sSEmZVyD4/MteyM9IoZO6XicwhfSg2juGU4yI1x9hTA+tme0OXy8AGm5xW0u5n7Qv/fQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790733012; c=relaxed/simple;
	bh=a+slvmsZPKZkyZ8WiqL7DTCI0H2DXv8QicxBj8GQEvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=stfxQL2j3OoYDyiYj4YcttWEmLeEEM8WxRBS/1Ph/xl46zgcIUTYDRR5UbVcfYLGzU4p+n45gDrSlnNmvXuGrMGqwlsgbzgYNMacvpGe8MH2pSh22NRlwpWLEQP03GGC9JLd2A0qrywAnuISJPs8TUyrVXtV7Lrm8MVNW5Nwt/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e6dFcVkE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e6dFcVkE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81B241F000FF;
	Wed, 30 Sep 2026 01:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790733010;
	bh=PI9XA4h5TFUaOqrILfrf8I8MEW99C4rzuMYoIE2Ubwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=e6dFcVkEQe+nsOFbVnCk53Qt/f9kkSlnj/7HXR+2Tp3jxk0Dr1+JEaX/DQr1OyLwI
	 y6DQe9bI7uQ6CfWWNTun4dic3OIznePu/PKQi41ggtjADtSKve6bIv/I2XmojyVakR
	 kUc7MCVvbeeGEEMIn0MBmNrtYjlGTV1QKExaLQynBF7xy060hzHtUXea0KMW9jLbP7
	 oX1XHHe4USTUVgy9Ya53u+vC12pwS/sznsJmPmcQGF3SxjyRCG5m7Yg4awyYeojwSr
	 sng0zkUZGpcTLjXwj3PgiDw4/IF5aFnCKp5WV5sx4HR/Q5iciPEwSr+Y31QBhs2Lpu
	 D4OSt76KAAX6Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 775803924FEA;
	Wed, 30 Sep 2026 01:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net: macb: fix close races (and RX refill
 error
 handling)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179073300902.1202110.8723363040296722029.git-patchwork-notify@kernel.org>
Date: Wed, 30 Sep 2026 01:50:09 +0000
References: <20260925-macb-close-v2-0-360efa565914@bootlin.com>
In-Reply-To: <20260925-macb-close-v2-0-360efa565914@bootlin.com>
To: =?utf-8?q?Th=C3=A9o_Lebrun_=3Ctheo=2Elebrun=40bootlin=2Ecom=3E?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: conor.dooley@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sean.anderson@linux.dev, atenart@kernel.org, edumazet@kernel.org,
 nicolas.ferre@microchip.com, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, nb@tipi-net.de,
 vladimir.kondratiev@mobileye.com, gregory.clement@bootlin.com,
 tawfik.bayouk@mobileye.com, thomas.petazzoni@bootlin.com,
 maxime.chevallier@bootlin.com, stable@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 15:59:33 +0200 you wrote:
> The context-swapping series [0] has been ongoing for a while. The most
> interesting part is a proper hardware shutdown sequence, which is truly
> lacking in other parts of the MACB driver: at close, at suspend and in
> the HRESP error task.
> 
> Instead of introducing that sequence for a new feature, apply it now to
> fix the main offender, the close path. That fixes the races listed in
> patch 3 and will allow the sequence to be reused later.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: macb: never give hardware a NULL RX buffer
    https://git.kernel.org/netdev/net-next/c/efd90b64ce25
  - [net,v2,2/3] net: macb: propagate RX ring refill errors
    https://git.kernel.org/netdev/net-next/c/9ea465c4fbaf
  - [net,v2,3/3] net: macb: quiesce IRQs and drain BH on interface close
    https://git.kernel.org/netdev/net-next/c/4fcaed2cb1d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


