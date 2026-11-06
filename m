Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794006608;
	b=aeApfoOI7Pb+q4YYxUS2a0p2SAqWhbtfLdsPYSJPziK8+UVA/bWVH7y+yMHnLGf1Z1an
	 1HtEFvfojN9d7h+BCLIpVxDB90NBH3IIj2OJeh85CFRO1OfbeA5YAtKofk9FjkS1KICb9
	 p/+TG2D0rTMXgqGhrGsbnMzm3R+8DBuvRy4C3zo2yGLRW9ocfWeuacmbQQFFNoPwR64z+
	 wYCmq/7GlbZzLSw9Li6DiszLM3yBNGlz8rPzveWK+zSO/W/c4DenroH/87tmSbc3L9qxY
	 fnM0em8xwqSjqpTqZUM+aX9dmGEL9K9yyoYRDPnUZeBBhw9Tz2E0T86xcr7d1bCsQfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794006608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=bmMGLvGICq0Rb/7+JvY57l+jYMHs7zel+LqqRHUR0KI=;
	b=aUQU/Jppco44l09CEPrWAE+amAD/acZDUYYTvj+6TvulvZmc4VD3gz5s90IBdX1TlltA
	 c6/pfw1+bsGywlf29nQRDOi785XQRP45KkzLAi9si20NK2VId4H2MBaECHwOGcFcU26Ue
	 NM75ca9Wu+1VZ2z8GTjkkrNyQYAmXr68oBmt0vfE8ozI8IeDbLfqHBtKbxgBZymnAOlzz
	 AB5VrbQL21D6ZOpizPlYBL2lNxM6o4SUjqT9e6BNlwUbaZizTChf6eQSLL6ePTS1njTBf
	 766UgXSMeZ0dNrY1j1hjJ6vWeDoDdRNnC9O0z6LyhkuNTxM4+JGPJdaPBAElsb9TsoA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPz4riLp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB102606A335;
	Fri,  6 Nov 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPz4riLp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A595D1F0089F;
	Fri,  6 Nov 2026 23:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794006607;
	bh=bmMGLvGICq0Rb/7+JvY57l+jYMHs7zel+LqqRHUR0KI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=BPz4riLpIDix0UABQvGuNsw9cB6c/yMuvRFXhPiCTcM0+Viu4IbbUlQ664LrNWw6S
	 r+d+mEjX7fS7DSS5JzXFwBLOAFq9oXBz9stq1K95nneM8GHRqUFvB4l/CDV5kkembj
	 MsLjwf0rps3yA0y+2RR/4XiEjyI6k2HkV4g8Ula3ySCtmuxcJizlDFVhcRFqPkNeDv
	 GVDSnKpSzFrF5bA97JSJ3Y3PS3Lz6mtYd6elj+fMY/gWIpW2RV3npqN1gWjGIU/dCb
	 7s1zmwAEqPN/5hnc1/9ouRdSttb7KEkcLFGO1WakV73O3KYClZ7XZjCa4OWEULeSw8
	 UZkRRZXKUzaqQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B2B23A55EC2;
	Fri,  6 Nov 2026 23:10:07 +0000 (UTC)
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
Subject: Re: [PATCH] net: prestera: release the ruleset in
 prestera_flower_prio_get
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179400660617.920475.5988715499810227348.git-patchwork-notify@kernel.org>
Date: Fri, 06 Nov 2026 23:10:06 +0000
References: <20261103100532.1309990-1-vulab@iscas.ac.cn>
In-Reply-To: <20261103100532.1309990-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: enachman@marvell.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 10:05:32 +0000 you wrote:
> prestera_flower_prio_get() looks up the ruleset with
> prestera_acl_ruleset_lookup(), which increments its reference count,
> but returns without calling prestera_acl_ruleset_put().
> 
> The ruleset reference is leaked on every successful priority query.
> Release it after the priority range has been copied out.
> 
> [...]

Here is the summary with links:
  - net: prestera: release the ruleset in prestera_flower_prio_get
    https://git.kernel.org/netdev/net-next/c/fa5196392691

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


