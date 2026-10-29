Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793270410;
	b=SRS6kOvssn+Na8Hhhz6DiFlbosn3AkHTSFfpBFplQ28IDHzPTrUPXxUFRsnVuETu9gU7
	 y+ClZMJXcpj0G3Mw1vqf1HACVKUKMx3d1yQvXh4OZZLCgmHwj4xJKczigWXuy/Ry92pez
	 e5nIkMvSjYA9npzGPwLObX3w2ZOT+SxGJpb2x0REaGcyB9TPzRJladxWAaA9Y3gPa1H/w
	 5kpy/dTPS7/EfPiTzX9JZBZRvdZMKt/PTn/fa59RLR/Nc7UUPcx3p75rmceU9FHsxBcs8
	 ikt/e7jE2OcFfrfuYex0mi1OZ1kaugjwS2mc/ZtNReF+m9NknuEhjEyGSg1OOlw0G3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793270410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=KpcMQnfJGwMQCcW7VaQhfVtYgNMtGChndnjnEs9p2To=;
	b=ujf4OIGZ2s1ce1GPIE95krDiBPfuGZlwTjpPYROqiHBNIgjdx4LnvCU5TuHftLCYatUZ
	 kIuIXR+/ePbIwBZ2UhXCdD4GggKTVwB8QflGMwS34LFIf8kDYH2iGgu1gS60ewfF9HE59
	 bNlFPXRhuCxt7johSFPrXNCpIpR/nGn8WFLZokQz3zaotUk4R6Sx/NYjX2bByeOLWpLy8
	 hOAa0OfkPfpA5jt23jQsshY0yfin7yA0aa61iUpa5b5aVQ8Q86hiON45wSfcyiieDw/pG
	 /0r6EO1jelKCQmTRlWs25Dbz/9PRNgeBu0WBI5ccvTIaqmc05hc+LgifH/yp9GTU7Sg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxAS8ZNg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0BD606A31A;
	Thu, 29 Oct 2026 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QxAS8ZNg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89F271F01825;
	Thu, 29 Oct 2026 10:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793270409;
	bh=KpcMQnfJGwMQCcW7VaQhfVtYgNMtGChndnjnEs9p2To=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=QxAS8ZNgtrT1Hm0QaFoYB1AsdzTrrJKIDAblzkvZpakkdBW/iRlxcdvSrHwTFXA4D
	 JtgrEDzN86HHB7skvosJDgyxAyrMtxbTd01J2gsI/WTaMR0T0oR7JUpIx6W1AZXpPz
	 8fLCLJrxAx6a2UUw2nsHs9aPi6LY0AoexYOHeAhhZ4mMBpso4cEu91vTBWo3Ave3RQ
	 ed+hDfZxAw/jeD2i2LQQJRBHoe7/ytCN9u0xDPhg6Fqivp3y9kb61MCRHc1YvdaW7a
	 0xOCECotW6iC07Vj7ppp8ueTslBzGN1R25/anQdJggryFECIA8MAYMlOFgoxJnmxpJ
	 ElpvXwJU8JCMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 815353ABD290;
	Thu, 29 Oct 2026 10:40:09 +0000 (UTC)
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
Subject: Re: [PATCH net v2 0/2] net/sched: sch_teql: fix transmit-path
 regressions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179327040831.1748467.7929052383444979787.git-patchwork-notify@kernel.org>
Date: Thu, 29 Oct 2026 10:40:08 +0000
References: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
In-Reply-To: <QDISC-Y0BY.v2.r0.20261024060625@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, victor@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bigeasy@linutronix.de, clrkwllms@kernel.org,
 rostedt@goodmis.org, owen@verialabs.com, linux-rt-devel@lists.linux.dev,
 stable@vger.kernel.org, sashiko-bot@kernel.org,
 zdi-disclosures@trendmicro.com

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 24 Oct 2026 10:34:13 -0400 you wrote:
> v2: resend of the two-patch series.
> 
> - Patch 1/2 is unchanged
> 
> - Patch 2/2 now fixes the drop accounting raised by the Sashiko
>   review of v1 (both providers): only NETDEV_TX_OK and NET_XMIT_CN
>   count as accepted transmits (CN can accompany acceptance of the
>   current packet); any other consumed result, e.g. NET_XMIT_DROP,
>   is charged to tx_dropped instead of being counted as a good
>   transmit.  The skb-ownership fix is unchanged (Sashiko-gemini).
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net/sched: sch_teql: fix slaves_lock IRQ deadlock
    https://git.kernel.org/netdev/net/c/8b2043279dae
  - [net,v2,2/2] net/sched: sch_teql: fix use-after-free on lower qdisc drop
    https://git.kernel.org/netdev/net/c/782d6bb8f9b8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


