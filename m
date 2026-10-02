Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDA528726E;
	Fri,  2 Oct 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790903408; cv=none; b=Opoi01Fqolcjz6fBhb3Y3q+EWBKmdxV0xbY5/j4BLMzrp2GAdi9SzehWI6sPmphkusc53dbluILQwlDYxjWtprvIZ1BnNjSPTN0+4hlG5ibBGAmW295RkBWBdDSw3/ij9KYSWjuWu0u79fd0qoxTsiLMQJN+u4TUNekX9XKIktQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790903408; c=relaxed/simple;
	bh=a3x8Yq3wnH61BhsMbKMX8/B+zVbPj6bZ2RWisp36igc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G927aN3zCIHIGD51GwaheFr/KQvpdsbWwhzPKWW59nHLRzcktu1I1PhD+jQgXmrFBWxLKdsJICv9fQzQV9MAN0AV1GLTqoTPOUvLzs1bdBCK3hEjplbjydjUXIOkJLiGA38EbKnPyO+6eIWAP+BfkFlJPr4G2nrnk3UEjIcYOAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwO/UpC8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwO/UpC8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 803BD1F000FF;
	Fri,  2 Oct 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790903406;
	bh=tEOB8pWLZ3+eNozcZcTVvW43IJq9VdtE+IsbwtiHpjM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=jwO/UpC8qvC8MtshSGoXckZrgoQ/4okj/eNQRee/8FsdeHbqGY1dYRySk0vreWc66
	 RGkIqgZ96tA87M0AMRIGDkE25YV6iorzywpqtdaM3k3qptjlV/vrfiyUOV0+DM7T6C
	 Y6FJ5MCZVyPL9coCRJavW7JYIZxyq8GpQz7zenmlvYvWrA6c0HBH0kRPlMfKnuVcz4
	 XZNI0udv4kliyp5/Fis9yXvnmMoeT6MK2j+HYmufC67zQUO2nDC5GIuJGRwIqOQrTk
	 tiZ3CmWmYU0Bw5CCkzw6tiW8WST3ILXsaOI11toDF0+f9Z1vD68KaS2/pGuBcs/Zcq
	 WdpQH/WM7ZLng==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 77336381197C;
	Fri,  2 Oct 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: em_text: reject unterminated algo before
 autoload
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179090340503.3165918.7074749420466888679.git-patchwork-notify@kernel.org>
Date: Fri, 02 Oct 2026 01:10:05 +0000
References: <QDISC-2DIU.v1.20260929183844@mojatatu.com>
In-Reply-To: <QDISC-2DIU.v1.20260929183844@mojatatu.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 victor@mojatatu.com, tgraf@suug.ch, hybris@mojatatu.ai,
 sashiko-bot@kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Sep 2026 03:31:02 -0400 you wrote:
> This is a follow-up to commit 9c572a83037a ("net/sched: fix potential
> stack infoleak in em_text_dump()"), which zero-initialised the dump-side
> struct. Sashiko pointed at a pre-existing bug that exposed the change-side
> input-validation gap open.
> 
> em_text_change() casts the raw netlink attribute payload to struct
> tcf_em_text and passes conf->algo, a 16-byte array with no enforced NUL
> terminator, to textsearch_prepare().  On the TS_AUTOLOAD retry
> textsearch_prepare() calls request_module("ts_%s", algo); vsnprintf()
> walks %s until it finds a NUL, so an algo[] with no NUL reads past the
> array into the adjacent struct fields and payload and feeds those bytes
> to the usermode helper command line.  This is an out-of-bounds read and
> a kernel memory disclosure.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: em_text: reject unterminated algo before autoload
    https://git.kernel.org/netdev/net/c/c9728fcf2e7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


