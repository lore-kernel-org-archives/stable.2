Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8DD3B7754;
	Thu, 20 Aug 2026 19:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787254282; cv=none; b=LO7uNeQe6Mk8/nasxhtiKSjIAaSUJJQFcSUAOJ61QCSCe5SV4fMPutZ3+1thdYqkcUPncQF3E/c+fWKRuhwn7tsGvUiGd5sw+OEnCJvN8WjwYfY3cv+VM6vkavaLjyP57TaJx5r2hiy1HE6dl9T+Rwl0fagYHeRqzT1kUm5lGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787254282; c=relaxed/simple;
	bh=ElGyM0yAcz521CbqcIbqAlmTGiZGHHLtOrSc2QMwevI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HZHcDqbK2QKM8BanDg7+aljt6A1euyUYG1Rfmjc0uq16Y59LpCuOKE6zzn1hMPugJfSxgYOpU/IV0Me2Vf/sSn49kGeyZ2A9HLqC+u1lJJP+6Nj1rfv6Q8Fq21p/Zgt8u8zmSpotoWSU6EJTCFgzl3ELxf+p2JJ9J3OT0ADpjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZW0Kmwiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZW0Kmwiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 251D31F00A3A;
	Thu, 20 Aug 2026 19:31:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787254279;
	bh=robnWwwNB+54qJB/M3NxFb8nKSzBS4OCaOxsDmFGSk0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZW0KmwiwR7AVmeHulzhe2VWEWcPl5NiToqRS67ny4uELFrVYfQB69earEvFXyRUkA
	 WDJVH/L7qMAiZjrZvLFxYm5AgMcOqoYF1/NnfmnjlMSdDOo7HO7wBQqZ6m0JWXTOfG
	 YvizhPYwhdG/1MyoqMECkSvEw5s//jspk4o8P+0hiCIBPSEyZDBohCPOtMM5LIJCfa
	 rsY/xttbrqpvmRK+xWkVvX4fqgYhWXGL7Q6Fk/wWPQWs0a7846Mifey640Qw8KAAtI
	 1M0FgbQNDEPkssBOpw6vJ9QVVOvaIICpoDaVM/a7NtLiMF74Tvcw9BxIrrZsyCd3wi
	 Xs+lR7X7wKVpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93B4E3924459;
	Thu, 20 Aug 2026 19:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] ipv6: rpl: fix NULL dereference of idev in
 ipv6_rpl_srh_rcv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725422913.446762.11873517686880170201.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 19:30:29 +0000
References: <20260817132644.2223-1-andrea.mayer@uniroma2.it>
In-Reply-To: <20260817132644.2223-1-andrea.mayer@uniroma2.it>
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, idosch@nvidia.com, alex.aring@gmail.com,
 justin.iurman@gmail.com, bestswngs@gmail.com, stefano.salsano@uniroma2.it,
 xmei5@asu.edu, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 15:26:44 +0200 you wrote:
> ipv6_rpl_srh_rcv() dereferences idev from __in6_dev_get() without a NULL
> check when reading idev->cnf.rpl_seg_enabled.
> 
> When the device's MTU drops below IPV6_MIN_MTU, addrconf_ifdown() clears
> dev->ip6_ptr through RCU_INIT_POINTER(). A packet that passed the idev
> check in ip6_rcv_core() can then reach ipv6_rpl_srh_rcv() with
> dev->ip6_ptr already NULL.
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv6: rpl: fix NULL dereference of idev in ipv6_rpl_srh_rcv()
    https://git.kernel.org/netdev/net/c/f826df95332c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


