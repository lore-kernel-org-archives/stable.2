Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279315;
	b=uZ4lKi+STTUHHPRmKSPzlbaoReQRHpKrdAI3lRdEBTaTyt/ZyUPtHQ3WblRVdp/VpHA8
	 0jtJaczmiLRrWth17ehp4zgHxjaG6cjfCfhgp1jJWYkbzqgjqlJvRaLFP+06QpM3m1Cr2
	 DqQjTg5scVfsJx8hMKxD6Lh30UGfSeC3i+3G4r8VHaOBWfRRyEHl5f+CXqDapyUPvm51t
	 WBEI+U3dhV5z2olDKlELIcFYcqZHNcazfiqLZh8Ofujl55I0BxxJRfuWSI3R2sCmGKMl4
	 BYCnwQW5uiTiyZQyzKKtGJhFnTnzDIqrfQF586rVNN/fYIyqB8ThJoH3DLmxitmhFYQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279315;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=lMUy+oeVAvoh6ufrm1galjkJuu4L+8997wZoAZsX6xs=;
	b=mrR/H3Bvtq83II3Gseq2iohQVUmuvE39gaWoLMHXuYFKkcctI3Dl6FeHljsGpwq60PwN
	 fHNr5S4t5yr8coiEXNYazezgEDjrySyCktM+jPDh+vogIrlcy4Ek+/RIYQ2lIXwMvQ/HP
	 /H7JA9q88kvdJqQZlbLNNYLt5Q9LZRBoCX8kLwRAdvTD8gJR/Rl/o+WSSl81/08aKwazI
	 MVBuEzGuwj8ZwHX9qQhQsQQ6X+anz3Hj/KOIOuLkxTxEiRWUrLW269uaggJkCzkCPggTB
	 94zAAOyuWsRZCsHlocJaE1yDVQEvnV/g1s6NGT04gor273CexM21tKc6ajZ0RYQ3BjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdkceB9p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA68D60A263B;
	Tue, 10 Nov 2026 02:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AdkceB9p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50D11F008A2;
	Tue, 10 Nov 2026 02:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279314;
	bh=lMUy+oeVAvoh6ufrm1galjkJuu4L+8997wZoAZsX6xs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=AdkceB9p6DMXd1n07vYXkmDl1KBNYyDkRjZ0TvvPcYjQ7Nh8VQaGxqaPuqWtfH8W4
	 4aDXy8NtqDo/7zbEW29fQ/RJU6RFmRxFKxp+/auMWqgutEaqsREJSQdRm7HkTP1myI
	 lweIYEgB3aViQRwopDlMt2dHzvcQTBaZiKtPSiXRN6F8hSfxWQCk0wY1emGgW268DH
	 siq2MshbhBdkFEXd91pRMeCJlK2BV9rKVhTc6aq08yMhOWL1Jt+p8nZcPoIQaQP+Qh
	 2WrPfWAoXTJR1io+VbXVK31z9YXGh7h3l66JcECamzIaJyYLe9ooASuQY/JaS+Mxt6
	 zcn0HZ7ecrfeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B09E391AFCB;
	Tue, 10 Nov 2026 02:55:14 +0000 (UTC)
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
Subject: Re: [PATCH net] net: qualcomm: rmnet: fix TX aggregation teardown
 race
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427931317.3612825.6946637670658534464.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:13 +0000
References: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261101233427.2050688-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Nov 2026 23:34:28 +0000 you wrote:
> There is a race in rmnet_unregister_real_device() because it cancels TX
> aggregation before unregistering the rx handler. A transmit that already
> obtained the port through rmnet_get_port_rcu() can wait on port->agg_lock,
> then create a new aggregate and rearm the timer after
> rmnet_map_tx_aggregate_exit() has drained it. The timer can later queue
> work on the freed port.
> 
> [...]

Here is the summary with links:
  - [net] net: qualcomm: rmnet: fix TX aggregation teardown race
    https://git.kernel.org/netdev/net-next/c/0af0e210b5bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


