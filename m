Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977483C108F;
	Wed,  9 Sep 2026 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788986490; cv=none; b=Q0Ae/V0AaXiMMdfzB89Sketk9jE1YgJzn818RHyB58TVlfZ3Mew3gAd+c8BH9dhJGFYFef3W9tBItgCmqqg5k4wod6vMJCeUR6p5DP/aS7AR5ZLvpkmTt7dLwzSWxxOyFkN8q+P5WGwtf/QSuBdUciLno2FLFaQSopUHH3MMkBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788986490; c=relaxed/simple;
	bh=Lv695M+ET14zQcMLsFvWiig8OxilxbrUcVHK7NozT+w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ttf4BIA+6L19QnN+l9nlbFKsk1VpivtbDwLlKppEjSgYPe9OUb2oNm5WO/DMP7nwBVGsOE4lcfsxESp/H/JhMAAM325IuCP2Z78l9YDwz/Q/aiipnafVwj+aw7Cd1eHuhiff0EvVDRrzP+BNLbJGI22iuq8rk3832YWE9A3vHTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GgN8x0gn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GgN8x0gn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAA31F000FF;
	Wed,  9 Sep 2026 20:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788986471;
	bh=XlRgql6gXyVqTyyC7XPsHaPGMVDu5J/x8i7A2d7OcWM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GgN8x0gnUY4zKgKqn7/6SJcyXo0H85ikpN9dAeR/fTlLRYmPg8yHPKzDJts/9fY4X
	 eumPerJUS32tN7N+eBgyorKqQ2q2g11AsdzMX1tQtRLkYGplUL18pY5QdxsyTyUFpq
	 8SgKNnKssNqiedoLNkVTc9yZe80VAR1W49rIHB67Cvv3QdVHSXjtTPfG7aMZnaDVMo
	 pa0GC91I4C7hUnYVg2ig7BlwYb0tpwRzNeod+pGmJGqxIcWipD8PuHq4PTotQUvf48
	 0xDEVQzPQzRxRgBP1OsgSrItG+zTc3+W2RXidA0V3fD3pJ6zu9LW5S89kY1y5c1dJI
	 i40LQTq1Ds7JA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0D24380AAD2;
	Wed,  9 Sep 2026 20:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 00/15] mptcp: misc fixes for v7.3-rc1
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178898640963.1048067.13477009364378101406.git-patchwork-notify@kernel.org>
Date: Wed, 09 Sep 2026 20:40:09 +0000
References: 
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
In-Reply-To: 
 <20260908-net-mptcp-misc-fixes-7-3-rc1-v2-0-df1de70348b6@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, mptcp@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, fw@strlen.de, kalpan.jani@mpiricsoftware.com,
 syzbot+55c2a5c871441261ed14@syzkaller.appspotmail.com, cuitao@kylinos.cn,
 yangang@kylinos.cn, shuah@kernel.org, linux-kselftest@vger.kernel.org,
 luoqing@kylinos.cn, kishen.maloor@intel.com, kuniyu@google.com,
 kmta1236@gmail.com, jakub@cloudflare.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 08 Sep 2026 16:07:05 +0200 you wrote:
> Here are various unrelated fixes:
> 
> - Patch 1: Do not reschedule the RTX timer for sockets that fell back to
>   TCP. A fix for v5.7.
> 
> - Patch 2: Avoid copying thmac which will not be used and could be
>   uninitialised. A fix for v5.7.
> 
> [...]

Here is the summary with links:
  - [net,v2,01/15] mptcp: do not reschedule the RTX timer for fallback sockets
    https://git.kernel.org/netdev/net/c/e2ab913f68c7
  - [net,v2,02/15] mptcp: subflow: no need to copy thmac during ulp_clone
    https://git.kernel.org/netdev/net/c/29f641951be0
  - [net,v2,03/15] mptcp: syncookies: remember the request backup flag
    https://git.kernel.org/netdev/net/c/b76c0e28b392
  - [net,v2,04/15] mptcp: pm: kernel: drop pending ADD_ADDR when removing ID0
    https://git.kernel.org/netdev/net/c/2ac7d6e62076
  - [net,v2,05/15] mptcp: options: handle MPC data + csum reqd + no csum
    https://git.kernel.org/netdev/net/c/ab36b1a80942
  - [net,v2,06/15] mptcp: prevent race between disconnect() and rtx
    https://git.kernel.org/netdev/net/c/85c580b0d859
  - [net,v2,07/15] selftests: mptcp: fix an UAF in mptcp_connect.c
    https://git.kernel.org/netdev/net/c/730444f094b1
  - [net,v2,08/15] mptcp: pm: userspace: fix address ID overflow
    https://git.kernel.org/netdev/net/c/f9f0068e8813
  - [net,v2,09/15] mptcp: pm: reset retrans_time when ADD_ADDR entry is reused
    https://git.kernel.org/netdev/net/c/f968190c0b42
  - [net,v2,10/15] mptcp: remove unneeded READ_ONCE() annotation
    https://git.kernel.org/netdev/net/c/caa4a79f74f3
  - [net,v2,11/15] selftests: mptcp: lib: dump nstat for the right test
    https://git.kernel.org/netdev/net/c/e1a56368eac1
  - [net,v2,12/15] selftests: mptcp: lib: get counters for the right test
    https://git.kernel.org/netdev/net/c/d23c41366e85
  - [net,v2,13/15] mptcp: options: fix uninit-value in mptcp_write_data_fin
    https://git.kernel.org/netdev/net/c/b110f1dd6cb6
  - [net,v2,14/15] mptcp: being below memory limit is a likely() condition
    https://git.kernel.org/netdev/net/c/a4257a91af7a
  - [net,v2,15/15] mptcp: avoid pruning for OoW data
    https://git.kernel.org/netdev/net/c/f01b8275745e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


