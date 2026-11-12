Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794508806;
	b=u4Rd9OwpqjcEAMCms1vygVtgYPqT2TAsLZvw8RRVE5vzwHe8KpoQubbmU4hTovPPmgbA
	 bBFi2XzWsLzADwn7dHu8R3w8JwDzpxIxnDmCuO9axHwJW4zlk22UDh+uONrs2ToQXikzd
	 gU+J22eHWbgQBLj6SXsKkZqNDvW3ySJt1dl469HuASWj0IpFWuVO8CEmzM1v1vDVFcg33
	 vfeKYFsUouaOm1+R83+3M2pfiG4juiJlpr4O+1uUr7YSHoMre6XjUTpdENU7VKzVAEF4q
	 OUPR+txji0KslenUEOaWpT/37d5EFkOjTHFP2OvSXMF5nrmlS2LxqLgHuV+ilwY9mXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794508806;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=//DGCwL3Y1u1mfVqzISzAnZGj/wOqtSDLZS1SHCj9Es=;
	b=YaAl0OFz4tRLUaFvQjlV8wpmcCB6ARTMLvJAcIcyRWGlMrk66BfxOjHdbrx4cTWcyRSI
	 4O/LN3ulc9debkH/21CqcmjyqKu0jTabeS5JEYfLgLbxA6sITHeroXoZWUTgvnktHNAzU
	 lC1JWAwUJjUmbGwMsbePCO9nuIsnw1OsshcwrcsyhwBLo1cPM19RTV+e2p5QBhYT+4Zt7
	 nxzpahR4wkSc2IKjbiagIrD1Sy5gdiwb7JrIh4ooRlOXwVH0N8FyBTw5hz3/MUwLx74Mn
	 nBDw3wRjgOMtlbAL5OQbrU+l5z02AdO30EG2BfE+wSyUJ2iL6JmHFgopqDzVG66dk8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpmtM0TP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B66C606A32E;
	Thu, 12 Nov 2026 18:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpmtM0TP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0753C1F000C5;
	Thu, 12 Nov 2026 18:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794508806;
	bh=//DGCwL3Y1u1mfVqzISzAnZGj/wOqtSDLZS1SHCj9Es=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cpmtM0TPt8HPg8KetPSukxQGiC6Y8NS2UWC03RfxMyl4AkR+dA6hQ7An2GXvXzeXx
	 3dq5u7gcnApuQvVEXmWxW16XMi0SbjazYND54ORM4+cIGHBQ3/nLy6Xr4Q7326+40N
	 VNTMm3xBudS+qXvf0F+3LQKtLQu5YLzHinF53pgMYfIUAI8Ucgeg9SgFJSsTBzxKY3
	 LlOjGe9DjSuCWWZMbqeP0AC4+8pmAoER9exX+G4BUUJwHxi0nJ1HQeRZCdnuTbH++P
	 obaUe5iy90y0+S5jOWR2Q4hJJQD3L3fkO57Djd7Ly7HlDj2YqZyKN8wKMsYdGsHe+i
	 6J6yU+Keh+cqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1586380AAFF;
	Thu, 12 Nov 2026 18:40:05 +0000 (UTC)
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
Subject: Re: [PATCH net v5] bnxt_en: Take RTNL before netif_close() when
 aborting
 FW reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179450880478.585389.16589339038635282296.git-patchwork-notify@kernel.org>
Date: Thu, 12 Nov 2026 18:40:04 +0000
References: <20261110044235.204386-1-bcochrane@google.com>
In-Reply-To: <20261110044235.204386-1-bcochrane@google.com>
To: Bryan Cochrane <bcochrane@google.com>
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, sdf@fomichev.me,
 joe@dama.to, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Nov 2026 20:42:35 -0800 you wrote:
> netif_close() must be called with RTNL held in addition to the netdev
> instance lock: __dev_close_many() asserts it, and the NETDEV_GOING_DOWN
> and NETDEV_DOWN notifier chains it runs rely on it for serialization.
> 
> Commit 004b5008016a ("eth: bnxt: remove most dependencies on RTNL")
> replaced rtnl_lock() with netdev_lock() in bnxt_fw_reset_task() and
> bnxt_fw_reset(). That is sufficient for the paths that only tear the
> NIC down internally with __bnxt_close_nic(), but the abort paths close
> the netdev via bnxt_fw_reset_abort() -> netif_close(), and the error
> path in bnxt_fw_reset() calls netif_close() directly. Those now run
> without RTNL and trigger a WARN_ONCE() cascade when a firmware reset is
> aborted:
> 
> [...]

Here is the summary with links:
  - [net,v5] bnxt_en: Take RTNL before netif_close() when aborting FW reset
    https://git.kernel.org/netdev/net/c/bf83b257423b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


