Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793181736;
	b=xnXQPiGoAwwyJBJdjmyyP/fe5d0AzT+CIzE9SsENiEu24gvE70ZWfDuApvNI4IKJHz17
	 PEKvfk9s4N+OekeYvbKzt2sZmx660jufPBhR1VUueyQFqVDDwJiCqV7FnKvsPjvAWIVGQ
	 B4EZvVITnozKHuk73VV9XgOhfsAmgWltw5hBtb+TOYvEGFmBYq6uk1OVXWz6xUNQPi7HY
	 xEj2+CM+3Y/DmtJMrAfGILxQimCNcGAdgpSnWAJQvjPqu1dJRvqd31TNHoifPzENGSRIn
	 QY8OenL/Jx0JM37qoQz2x6xezn2ylYYX7AhzkI9tlQD3fHHKXdfk9/h+IHJ3fUHAaJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793181736;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=6vWbJ5WEX7+Hhe9l+MsNMHI+M51QuBqwCDm+9LW/q2E=;
	b=4qVn8MnQjCy0jOoJ+/4zcBIno4WqukB9/TJjrAS6VzVThxY03L+6QZtPj7lr5XtVIP6E
	 X0sA+f0obZtHdaCz0W740xHnN2BUueorCSUopOkObzuTqGtjm8lEtlTqpB4VyKc/YUk75
	 hCy6SRuMJULCdo1FEFf4AsYV41EIgvceqWpuN0mC4TpJ92hRhLV+X8PBb8U+d+iZf7uPS
	 CxpMJjuNf4b4gysTc9LmfBsKWrdUOpOAw8WzkrXWAy+0z6pL3QrIzL0PDT2USlyfAz701
	 E7tIKpK46tyQHqNJT5QsmGM3eFpR9DL7yYZX19R9Wc53SZlj9K3/QS4ysULvGegh+Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBbBgVE6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE39606A31A;
	Wed, 28 Oct 2026 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LBbBgVE6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 528751F01828;
	Wed, 28 Oct 2026 10:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793181735;
	bh=6vWbJ5WEX7+Hhe9l+MsNMHI+M51QuBqwCDm+9LW/q2E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LBbBgVE6CSOJogR7vhGc5bl09bBLRy4+dWwQZoxYu+7np6H47zoTRur51fBqdAgF7
	 1w0kLdMZPJezlbklJqzUlUtnIwl6u3H8S82mDKbBht70ciII25Dw1gF5Fd8rREq1Mb
	 UVI8hgZ9TBQotQ2BOdkq7Ro2l1Ti+6jkis/8ZvJbAAdwjuKpQk+qcjJtWITZygQ1wE
	 FGggmshSb3hD89yQZ4LXjgjp6eHp6umSI6nLVxMwMwPO0uenXpUzCUr68NOKmUohVb
	 n6MXylFaKAcIave7aVUPlpazKrA4I3LmXXpSKEEG4HU3hVcYa6eQlYR+VtBHplAQK4
	 wtwVFhl9D9ADg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 447313AAA0DC;
	Wed, 28 Oct 2026 10:02:15 +0000 (UTC)
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
Subject: Re: [PATCH net] ppp: fix stale pointer access after pskb_may_pull in
 ppp_ccp_peek
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179318173377.622019.1649392373971211231.git-patchwork-notify@kernel.org>
Date: Wed, 28 Oct 2026 10:02:13 +0000
References: <20261023195309.3527129-1-tristmd@gmail.com>
In-Reply-To: <20261023195309.3527129-1-tristmd@gmail.com>
To: Tristan Madani <tristmd@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, qingfang.deng@linux.dev,
 linux-ppp@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 tristan@talencesecurity.com

Hello:

This patch was applied to netdev/net.git (main)
by Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>:

On Fri, 23 Oct 2026 19:53:09 +0000 you wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
> 
> ppp_ccp_peek() caches a pointer to skb->data in dp after the first
> pskb_may_pull(), then uses dp after a second pskb_may_pull(skb, len + 2)
> in the CCP_CONFACK handler. If the second pull triggers
> pskb_expand_head() due to a cloned skb or frag linearization,
> skb->head is freed and reallocated, leaving dp stale.
> 
> [...]

Here is the summary with links:
  - [net] ppp: fix stale pointer access after pskb_may_pull in ppp_ccp_peek
    https://git.kernel.org/netdev/net/c/1e860f42f41c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


