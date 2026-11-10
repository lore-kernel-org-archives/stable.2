Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794334995;
	b=MtMVXfZIv3dFYRA97NJjNqpJMKD7oBcS/FTXZDoss8kNJd8HDo65T6xBnPwHdvFxEYlJ
	 Q0qmw+C4EpF9M/NGEZLrUlWbOdr+ywIiW/EbxylELm+f+ltW+VF51WAPE3u7e6YS2GBrS
	 7hWgq78HBRaVcOy7xpvvg/2DbMQiZLSaw/j4cz2aCAd6ssX/vYSZSOlU4qV7aVii/YDez
	 kXhGvZ7E9DwBTtqzq00PaF8Ed/Nfopf2geXQNMH58IY9QIlVDUF/U2YQE9G2ayL44rIIp
	 lSkbb3m2C+xttYycMz7HHVarQth3GUDdt6cU9QpXCIoYtAZitfe1LByS+1Lbaa8kNEg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794334995;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=We72cBQExcEry0dpzv58lEZ3IS/nG1fvq2tyV0GkB9A=;
	b=lf3oZ2iscooMpuzQQ5U9bqo3V/J4gye4fKwkdhrDzHYT8f3f9AnAvVQqEz5wXP45kIoU
	 fDAXZ2AeIYKpNmGyE03PLoBShU2FSONiKGbL7Sjrq2xScTqZEPTs9YPgmNCCDfnWyTeRP
	 cZ3a7R7IleyGWfXb414AS3jFUZK34sQCOOVTwCkrM1ZfcF8b2A6Ch6EGQeskxxYx+OrYs
	 2JdkHy2D+9gHoGNhibdL7ll3pG66MagTD8jRYOdxEn8T2B5eFhtC4W2GpKv1Ms5hdxj0F
	 +zgGGYK2hDA8r5HstwGcgohvVBGxNbb5ADsusMasuD3tH+SlzdIRnXO256UqWcZ5yig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cldSBui0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1809C606A327;
	Tue, 10 Nov 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cldSBui0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A50161F008AB;
	Tue, 10 Nov 2026 18:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794334994;
	bh=We72cBQExcEry0dpzv58lEZ3IS/nG1fvq2tyV0GkB9A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cldSBui0L+HHGmkjZa92Gf5hoKSc5DFfJZjU0c6UovfrDp6NPzQwQOIWk7kZvAcSs
	 XE8eO7P/CxBGNvZMX1tja06MFooyZahbp2OpR5saavkr+nEo8pvru+t0pmQt1n+lqu
	 5pBiyUa4Uuf6WYe0Ex8ec41UHZdVzI9QPoLtzSRaW5tTA20QEr4qZZoD0LE6dYz+rf
	 PHguTH0KW6JtalXRTvusX1tIj2a+uQUt9Nl+ssM4o0Cc6r/RqeDmCosa8TtFVG4OL8
	 No1MOiqt6+epjWfDyIVw7nUS7H3kVHXa1iRN2JNSsjywD7ktUFUFKZ6U+G1EK7ISJR
	 FYbQhk7+8fo3A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B0D039D608B;
	Tue, 10 Nov 2026 18:23:14 +0000 (UTC)
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
Subject: Re: [PATCH] mlxsw: spectrum_ptp: release parsing depth on MTPPPC
 write
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179433499317.4118637.15079674330639490953.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 18:23:13 +0000
References: <20261103102851.1340480-1-vulab@iscas.ac.cn>
In-Reply-To: <20261103102851.1340480-1-vulab@iscas.ac.cn>
To: Wentao Liang <vulab@iscas.ac.cn>
Cc: idosch@nvidia.com, petrm@nvidia.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  3 Nov 2026 10:28:51 +0000 you wrote:
> mlxsw_sp1_ptp_mtpppc_update() increases the global parsing depth
> reference count before writing the MTPPPC register when timestamping
> is enabled for the first time. If the register write fails, the
> reference count remains elevated even though no timestamping
> configuration was installed, and nothing will ever release it.
> 
> Drop the reference count again when the write fails. Also only drop it
> when disabling timestamping after the write succeeded, so that the
> reference count always matches the programmed state.
> 
> [...]

Here is the summary with links:
  - mlxsw: spectrum_ptp: release parsing depth on MTPPPC write failure
    https://git.kernel.org/netdev/net-next/c/1dadb4afc18c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


