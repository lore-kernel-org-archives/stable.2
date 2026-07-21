Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60AD3B4E87;
	Tue, 21 Jul 2026 21:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784670637; cv=none; b=miFsTts1bBfScTs/uxsq1dV64dDCNzUuOb3OsedVYXiEY9AsqW/mM94zIntKV1BUw4Pv+VjSomXKijUzskcTZdOfs/X7oW+S3FoUN1kUpBdorUjfTf/a4VUUNf+xeDAYXU7+tI7QymkeBnNcOv40NMqXAkSEQvPHCCNlgHk9Qr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784670637; c=relaxed/simple;
	bh=mmDp6KtvmpCCYrQNDSxwmxVb4WkkzeKnrEedZz6lktw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dkp5/rS453i3WTqYl5Pish21kdowbKz3L636DiqApPkK882omvjlnN6Srj/+RpN0OLuO9QT2MjinqPknVWV6fLqcZ4GdLrwBAyLfh+h35hbFTxYfzOv+zDTzTTX9ubsX5ZRvWHkSxPXtiHIkMIsD+kbqUI70gInAauuJcyMtSgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LwjE5agm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LwjE5agm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05AD1F000E9;
	Tue, 21 Jul 2026 21:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784670636;
	bh=Mcam1qbTN5NGekmZTRnNnLbz4zTvKS77aW3ghNSTnhE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LwjE5agmmd3139osG/F6doehV7Ta8ly/P4qyqURHF2d1pTyaTV3gTfWX3awXpSXG7
	 pJmnElDBtT77B0DbODweYQfDw6eGb9hJtZRQ5U4+CAXolhnGxKD9wwG9S7L72R2kZ0
	 JiEcoIZCgG14iiJl7Vo3NBP1iB6ak00Ib/QglBjStHfpsyxAqxbWBX2lvW+sFYQQ/P
	 GWO4qkcjJnME6FdNgFV2piKFUD/oA+Qr+VAGyx3aiZ7t4/0+VYU512mOGX3YoqqibZ
	 YX1JhDCrz6COk+GNe8dE7YKd5Ahg073KKyMpJUv/UJo/EuPxefom7Iru7p4rlx12pf
	 FLJgnBAIWH5wQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569B2380820D;
	Tue, 21 Jul 2026 21:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] gve: fix Rx queue stall on alloc failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178467060615.1100105.13388292280071884550.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 21:50:06 +0000
References: <20260709211906.3322883-1-hramamurthy@google.com>
In-Reply-To: <20260709211906.3322883-1-hramamurthy@google.com>
To: Harshitha Ramamurthy <hramamurthy@google.com>
Cc: netdev@vger.kernel.org, joshwash@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 willemb@google.com, jordanrhee@google.com, nktgrg@google.com,
 maolson@google.com, thostet@google.com, csully@google.com, bcf@google.com,
 maciej.fijalkowski@intel.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, eddiephillips@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jul 2026 21:19:06 +0000 you wrote:
> From: Eddie Phillips <eddiephillips@google.com>
> 
> When the system is under extreme memory pressure, page allocations can
> fail during the Rx buffer refill loop. If the number of buffers posted
> to hardware falls below a critical low threshold and the refill loop
> exits due to allocation failures, the queue can stall:
> 
> [...]

Here is the summary with links:
  - [net,v2] gve: fix Rx queue stall on alloc failure
    https://git.kernel.org/netdev/net/c/b65352a1bac6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


