Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792465207;
	b=oR94LJaMRj7zDeQwF1byR5zPHqLRNXeFDHQuLbuIKaOg2huaPkhido6AF26le6DhJkDb
	 I2F8t+r9nnM65maIkHWzfjGIaMfrX76mJL6O/Y79BGiLgoNUt/gvzRsSx82rgyT/7nWtB
	 BTpKh+dQGj2LafrBsdtGQSWtmfGg1eSFX3yAfMyY5ZjURSi9xMP/SWRiNDAoDNyauFIB8
	 d/FXLtxCbNjT3ln5zSigVI2HRHKd3ivy6WsExt3hO5885PJcrHDo22iwIcd62Hw1CHejB
	 kKoeE+lDXM4IkJroMgotM91RAHG4LnuhgrjjdE14HZdrNVYMjSeUJdf7CRLaSs+aBeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792465207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=LLU3IDAkcJ517K/+XbdTzGRryYF+KBNYwub94onqkuw=;
	b=WHDFbJV5JghkZ6nzeF5/idV1vdEi4w0MGMfYcT8b7M1eQGMgtMP9DV9fabihsztIUJny
	 BpXJR//BCxbGu9W65UT+mt2CXp0EnudmGSZtBuxUwAaSaZ/gv+obrH2ontRuC0YamP7Te
	 F52Gv2SGyQk7IXbkiq7wlsUNUUOJsRgXiOtMRr+rBrLpdl+S4wNktbreZwNV5u99A/FfI
	 uSz0ajHjv4BZoPFqT9i1OoAg8dEcITeFt8knriwHKbr1vlBG+39ZojhBcj5fJ+91QP/eQ
	 jpRtDD1Bz8x7lfMBKrYAZfZew7MWp0uy0kCuYdmEyjCFiDPX2LOA4zpzlrEWz0eK5ZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Psfyw63l;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00D84606A31B;
	Tue, 20 Oct 2026 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Psfyw63l
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830271F000C4;
	Tue, 20 Oct 2026 03:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792465206;
	bh=LLU3IDAkcJ517K/+XbdTzGRryYF+KBNYwub94onqkuw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Psfyw63ltsfp7qgwVwL28W0xzMoJqM7M5vyR0+zlxbu6pYpueAIZ0RaWIIx+tZvWw
	 H8qFADS5ZJZkDfPbLKMA8BRLo4Z3AAZ3n38DXnCR/oXuw9ux5Tiv3AsRxP+oN2rGjL
	 id8VNig8zev47ls0LfHgry+0IA3OPvUbeRMqUgtVr3uBYnQMnoGsKclS+w7BVE5jld
	 sIIJrDN13WnjZN6MrYsIygxVk0QM2JOGhs506Rj4YYWMAR6bZ8DM7JIzIARyZHf8Qg
	 7NYqlZcbYRqLmdXlV8AsrTABrRaBwD1WcXLTiLmuDnjncdvmsLwW6wRJxx9rg4ic02
	 xzlOE2ieU8hoQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773923924A70;
	Tue, 20 Oct 2026 03:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net 1/2 repost3] net/sched: act_api: reject duplicate
 actions
 in a batch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179246520503.3454580.1042472378869646593.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 03:00:05 +0000
References: <QDISC-K1TH.v1.r3.20261012134653-1@mojatatu.com>
In-Reply-To: <QDISC-K1TH.v1.r3.20261012134653-1@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, victor@mojatatu.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vladbu@mellanox.com,
 marcelo.leitner@gmail.com, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 sashiko-bot@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Oct 2026 14:09:25 -0400 you wrote:
> tca_action_gd() builds actions[] with one tcf_action_get_1() per nested
> TCA_ACT_TAB entry.  Each successful lookup takes its own reference to the
> resolved action, so repeated TCA_ACT_INDEX entries in one request yield
> the same pointer in multiple slots.
> 
> For RTM_DELACTION, tcf_action_delete() then consumes two references per
> slot: one in tcf_action_put() and one in tcf_idr_delete_index().  A
> duplicate therefore drives the refcount to zero mid-walk -- the delete
> frees the action and removes its IDR slot -- and the next slot calls
> tcf_action_put() on the freed action:
> 
> [...]

Here is the summary with links:
  - [net,1/2,repost3] net/sched: act_api: reject duplicate actions in a batch
    https://git.kernel.org/netdev/net/c/f67b3ed1308d
  - [net,2/2,repost3] selftests: tc-testing: add duplicate action delete batch test
    https://git.kernel.org/netdev/net/c/044ad3c90d9d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


