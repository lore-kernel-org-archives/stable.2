Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279326;
	b=WXZ8ndkDgUNuwT8CGCBjvyo7eGwV7ksr97aqylL+E0w7hke7EpmijwIAI7jWJXf/JBPv
	 HHvKZYCUEHLsS9fctz/ay4eRl6VxlZmLPPOB5WmCrhF9puiZdOztPWYc7sFZhsjtv4Lp2
	 5RQF4bKt9AOUjq4knDNVUyFvIGUkUhdUcJaylp8v9h5voiwPE2qPnkgbzjBnMn4ORCx6l
	 pXRMUMqnOQvA0LcT3PlKq8rp4eMPJlCV0bvOen/OgxOukL3d8zGXkDkb46cyxgiWGF4n8
	 xJkhHaOXqEssZ3ZsEB2YdrtM08FN4tuxsqzG1Jp6ULTw42j7xot/1Mx71/MO6gUS1Cg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279326;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=yzbqzrXHNeakWLUFfYy0kiXw+elLkCR7kWvTIuAA1SI=;
	b=Llu1vT1PlMMFrp9F2oA7eGjXEQMaLi4idfb1rkXemo4kFAqZTsjxgK+xlI+gbcvzljX7
	 3Z8unZP5QJwUMEvVez2XZM3gVCNIAkMsKTfHM5gw1XZrJXrmd88PbbTYVAeV3+jJEJKlp
	 2iO6B+HzXfDJW2KzXtgo3NGz45GDQN+dXYGMNJUynhu06NQ+JfZZRHV/zX4PJKvrDxyrq
	 8Cj3qYxJCCpilqK6kdSAzonPzLqx+basBXc1jwnDQErMVqtTaDZO7eNXuKvdpGJJSTpLI
	 ZFITONca/IVUeH4mX3bmb1SjZKKah9YkS+2epWao7D0+JfY2WElAXHLpig6PfMaebgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3xLxsL6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102D606D11B;
	Tue, 10 Nov 2026 02:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3xLxsL6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235391F008A4;
	Tue, 10 Nov 2026 02:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279326;
	bh=yzbqzrXHNeakWLUFfYy0kiXw+elLkCR7kWvTIuAA1SI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=b3xLxsL6vGu2KbJDR/sJr9hp9FTUFAlpct1X014CHIIitMBSU2fkFTPbTCzhmXtg0
	 gKwEMywNwghXc9k1OxzoYLjv0sEtB98uyB9TaLWhD+e7r0Hs9UNc+ethviqbDVdaM9
	 uOhc3WZJYjJxywLDzCtP/Udusopso15nrHuL16sb7SArXBmtXuY1aC29JdWgR63cRO
	 n9PiAgPtg06hHoM1uarVWZJ/n0dC4oYEM9IyeTQ/kj58rO3ZFJOQ+TtSzQ/U0B0YKn
	 C0V/mJBYMq0TF5qtohQy70gkID3v5sHJ7CsBqhyP/FIz4E063WgQ2KSfF3cdbMLv3y
	 XzUB6nrfX49Cw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 18CDE391AFCB;
	Tue, 10 Nov 2026 02:55:26 +0000 (UTC)
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
Subject: Re: [PATCH net v2] net: qualcomm: rmnet: avoid stale VND access on TX
 drop
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427932474.3612825.13986957054931266186.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:24 +0000
References: <20261101232354.2047804-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261101232354.2047804-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  1 Nov 2026 23:23:54 +0000 you wrote:
> A struct rmnet_port stores a pointer to the most recently created
> RMNET VND in port->rmnet_dev, but userspace can delete that VND while
> the port still has another attached VND. When RMNET later sends a
> buffered TX skb, a failure in __skb_linearize() makes rmnet_send_skb()
> update the drop counter through that stale pointer, which causes a UAF.
> 
> The stale pointer can also be used by rmnet_unregister_bridge() when a
> real device leaves bridge mode. In that case it is passed to
> netdev_upper_dev_unlink(), which dereferences the freed VND and leaves
> the actual bridge adjacency behind.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: qualcomm: rmnet: avoid stale VND access on TX drop
    https://git.kernel.org/netdev/net-next/c/4f89bcfa1e16

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


