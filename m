Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792531207;
	b=c2D2qFXmZyWSofJ9/K6q5VbSNy21NmdVP43erGgkkDHpnNsZgy0rALSqWdOVxEPUXT1G
	 xFEBz/L9xdLZ+l9kW0RV4JNa5gDDCtZvNXMKNJTBEdTAA9wZh4c/z1tlmQZRaeL8Y5RBo
	 IYFfkHrMs4wjy2cdNuDCvijiTbxh5IQsgQoiEZFVXGMBHRzMu32LU60t8vM7rJAX9w6+N
	 4GN5U26o0gfnmNVHrQ8Rv/i8x6a72xhJ1QiAFrQ0InB8Udt/CAnSkG4JsPKulptskHdGT
	 rV30Ngv8SMCnJzZKCTMFhqFNWyuqJEP2Z2d2mg5XfLT+x9INlx6vKrGo00c+eDPpqfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792531207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=1HifwW2tzpw/dBlqdN30sk8tMvZZs/3YEkBT2Gwdt/U=;
	b=ONYOoTlGQIsHCSbfxnOHsbJt8ACd7Po7MdOjJ7LvHMbL/F28x/tPLIjM+t6DriNlt5Wu
	 JbRoVlnxMaRxBtgJNXoKbVYiSlldLrVqcdELb+cK8Xt92h/9+VB7WQOOa9lHiVIR+NQ11
	 cQ+R73sY6uEXhN3gXGTGdajVqWPLSQqbU4cQL8aooxR2dPANLBMyPjyJIdnfjMYsx4aYE
	 wK1+vaCIeR5wZit+PjfPXDaE42GqX04UGS0vBtmrL1h0qFMnYG2s+oHOfFCYZbEwwyqlU
	 03NpRQc+pIFqOmP3tBxo6GNpu5Z6mQ2xUVsjUGIPkDpOrPezt0rbxqzL/PluQ6f6FMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="F9ycV/1B";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA95606A319;
	Tue, 20 Oct 2026 21:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F9ycV/1B
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 141011F000C9;
	Tue, 20 Oct 2026 21:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792531207;
	bh=1HifwW2tzpw/dBlqdN30sk8tMvZZs/3YEkBT2Gwdt/U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=F9ycV/1BiyxFr1paMzQQaBRAsw8fTP6WrSzclml0+HVNypOI1utWbllyri+gYP8AP
	 hnm7xQep0JwEtYCvd5lZBHpegLWFHBwQVkElddzJdMHxi+wdu9d+Y0DS+gThAgqf/P
	 XisB6HdwyS9LMaILGHhPQUZLde3yYW4U+J57DEdPW4GJUMH8nCWfCA8PkkRwzEmNop
	 jarMbfBFjoPeFWil7xgKT6mfrFrRK+lh2gYNz9C3WGmeZTPyCjX2Lj96XZiRLSGO5u
	 a4ye/rJQkn7Z3e9qn9uhRQG5DXM0IbSAs+QZTjBZnF7+tDtAAKX9JIcsbTqtTcF/wr
	 5jwv6/vGX2PUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F16633809A09;
	Tue, 20 Oct 2026 21:20:06 +0000 (UTC)
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
Subject: Re: [PATCH net] mlxsw: Initialize register query payloads
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179253120553.216428.17809324600646525016.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 21:20:05 +0000
References: <20261014173117.26305-1-mail@tk154.de>
In-Reply-To: <20261014173117.26305-1-mail@tk154.de>
To: Til Kaiser <mail@tk154.de>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, idosch@nvidia.com,
 petrm@nvidia.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, jiri@resnulli.us,
 vadimp@mellanox.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Oct 2026 19:31:17 +0200 you wrote:
> MFGD register queries can exhaust EMAD retries and leave Mellanox
> Spectrum switches stuck during boot or shutdown when running OpenWrt
> built with GCC 15.
> 
> An example failure is shown below with the second line wrapped:
> 
>   EMAD retries (5/5) (tid=9b544fc100001f35)
>   EMAD reg access failed (tid=9b544fc100001f35,reg_id=90f0(mfgd),
>                           type=query,status=0(operation performed))
> 
> [...]

Here is the summary with links:
  - [net] mlxsw: Initialize register query payloads
    https://git.kernel.org/netdev/net/c/15b7a86a8888

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


