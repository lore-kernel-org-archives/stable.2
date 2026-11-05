Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793874006;
	b=IO+33+aFSKuVLUgnKx4W7TEyIBnUfA2yEBUe6W/uhyC9e4w3X1jDq1xe2FwR6xRpEJm+
	 CLpQcFamyL6Ez7tuhZHhBB55gI0rUc5f63IT4u4mXmWQWBpAyxngWJgohYX/ELiBn0wml
	 BBTVX0UxA6McCeIPrgfjmL+GpgqUZ8xOPbXqE/a4vHSgqe6stqLMEc1YWVdxItnonvhCW
	 K428KCaZNJmsFu4MIEXeZsaQ5IIPSdDEuMHP4iXAlymZDgNmr6vHr+bgw1jKiwrM003N1
	 MX7WIAzdXSHgkclE23Aaw6lhoxIBhP5sbCeRhWXD63F1s0KMJ2x0TBFGAVkH7JVi0pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793874006;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=bHgUiRKVLZii57YQmx4ogKCKgX1QROM266kYzDsN21o=;
	b=VWlPlSMlUMEaYHs4+rs8GDKJlBJXiYkWiQGQwHB8DbDGmrY19j6mlCqNy3Gvrp+fsEyD
	 C6N6DPRr4TWzMtBRo4idNq6E+vzFsyyUUaZO+1oUFQuPeUj52V9TIgqnPGYLbS9uhCh2T
	 Dh7lDE+ogdCm9NMRFsttAfXMlJ94eEFEq0dlwP4Z08GkaGxgszzXs2IAZAMp+s1nytSK3
	 BT3+zbHr0JV6h9H26yyNBCTiFjcH1kHMD7fJEiVbH68AwZSj+HyZrUuAM3nb34uk5/xy2
	 hGyhQvPDXE4aFUZ5yIfxeEQ7QfNYi3Dmx74E9EWm0/3Mpjox8qcYkkp5oorUUaZY+4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEjxd3iC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16397606A326;
	Thu,  5 Nov 2026 10:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEjxd3iC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D791F00A1A;
	Thu,  5 Nov 2026 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793874005;
	bh=bHgUiRKVLZii57YQmx4ogKCKgX1QROM266kYzDsN21o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JEjxd3iCUhF+b13I/rUIfrZxqJJ7yMQOPr1gvRxNmhTaCyg14ABIYnJu88h3cN7OB
	 0SW0y8GHNH7gF24KNGdq8mlKko3POwL2QzrT2zcSquYxgryQQeKm9kttEb5pKL7NlL
	 WqnCAuXpUWz7drd1OqAN/TyJYDlhhtgGN7r/f8SIPkJ3E6aTf+2P98tuLru29EnnQm
	 YQIt3IcatGuTxMifntAJlhs+A+4ABsLJ13MLjywy09tEVFtTxaj3j964wqOjrCP0VD
	 RbL0LotP4I7SAtA/fAMIjgjd37N6rpo6dTm/dF0lZ1nLxL7x179QQ9n44VdOwx8D1h
	 jwtb3jgH8CeJw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA285391AFB3;
	Thu,  5 Nov 2026 10:20:05 +0000 (UTC)
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
Subject: Re: [PATCH net] net: count last skb of each sk_backlog pass in
 __release_sock()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179387400456.3571518.633147613195063738.git-patchwork-notify@kernel.org>
Date: Thu, 05 Nov 2026 10:20:04 +0000
References: <20261101075145.698399-1-sgzhang@google.com>
In-Reply-To: <20261101075145.698399-1-sgzhang@google.com>
To: Ray Zhang <sgzhang@google.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, kuniyu@google.com,
 pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org,
 horms@kernel.org, decot@google.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  1 Nov 2026 00:51:45 -0700 you wrote:
> Running 500 concurrent TCPv6 streams (neper "tcp_stream -6 -T 1 -F 500")
> on a 2-core Cortex-A53 (CONFIG_PREEMPT_NONE=y, HZ=1000, LATENCY_WARN)
> triggers resched_latency_warn() in __release_sock():
> 
>   [ 3655.311821] sched: CPU 0 need_resched set for > 100006892 ns (100 ticks) without schedule
>   [ 3655.311889] Call trace:
>   ...
>   [ 3655.311944]  resched_latency_warn+0x7c/0x88
>   [ 3655.311958]  sched_tick+0x1c0/0x418
>   ...
>   [ 3655.312578]  net_rx_action+0x238/0x438
>   ...
>   [ 3655.312641]  do_softirq+0x4c/0x90
>   [ 3655.312651]  __local_bh_enable_ip+0x84/0x90
>   [ 3655.312663]  local_bh_enable+0x1c/0x28
>   [ 3655.312674]  __dev_queue_xmit+0x4a8/0xb00
>   ...
>   [ 3655.312782]  tcp_v6_do_rcv+0x240/0x5f8
>   [ 3655.312793]  __release_sock+0x9c/0x188
>   [ 3655.312806]  release_sock+0x150/0x168
>   [ 3655.312817]  tcp_sendmsg+0x4c/0x70
> 
> [...]

Here is the summary with links:
  - [net] net: count last skb of each sk_backlog pass in __release_sock()
    https://git.kernel.org/netdev/net/c/c4e4056b2135

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


