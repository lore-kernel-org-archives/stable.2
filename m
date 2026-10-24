Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792852018;
	b=cRLnxJL2DUReGn24hC+hxcpNIy8O2WbacVKMfFd53c9nscqWr8AVo/nw7+wYyhMY1d73
	 Lh9HyPdwopy2jk+25dkCHAymyCgG7O/VT3pLgz/g3NeRgqWZvHiW5/wXdYNVbMFRZ0QR3
	 nk2CGANoCeZsqMH5P1W5CHWe23u8AO3Ps2sZj8sNVo5vaOLwKeRDVTdMlt3JMbGNZidYb
	 wHLwgwzEi1ssH6xK3CubqKjQq7xDHodyHBQq5NtPuKoV6k6L9I+04m1cli1lhnH1iHob9
	 izMVzzbyIHRiqibwr5XxWQYcIV2e0R+gBH87nzqem+6iRmfBiJR4E4EG2HvlnHCCqIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792852018;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=fNT2weTfXGqP24QgIk4JqCmw3KyFKnutR+03EZi9Dko=;
	b=vTJowRMl9J/Aq9mqn9ZYzPd8G7HyNW8MQZc6HnpP16vHvJWw4bfc5fE4JB5r6Ybn4W3N
	 YYEy/hiqwfLRvMuNYCYO9fMKl9bb7n3vRcEmabdeEtqLmWnb323tv4Afn7dkJRERf7TNr
	 EjodHUTQvRtzbWTrHurmpS7l7w+qFS1pC+c5eOcOeRv5TsSUMxVIyI5qtSqpcRXz3zK64
	 2/J6+8Jujo+npVBgx9LpZSEqx/6WmxS72bVeEB7ceDjm9Tpsw1KxnkFHNSpUgCZJL4JCN
	 viIvq6ElxWvJg+4mH70NpaVKbCCPypmzAtX+TBnwtyZbfth7C0cc99wHv/hGFt/36yg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyQ7ykwJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE81606A31F;
	Sat, 24 Oct 2026 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JyQ7ykwJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E45921F01828;
	Sat, 24 Oct 2026 14:26:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792852017;
	bh=fNT2weTfXGqP24QgIk4JqCmw3KyFKnutR+03EZi9Dko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JyQ7ykwJR54enKN+x8pnz0iFTXCkgBMRvwE7nEK1MmtK+tGeh8qlAntHHkydbnZQ6
	 7rdfjjMQTBL3LQuIEpLTuZzUwvm/R4BGhNbkDIX4Mfa14y76eMl0MiN7iTJKfJDi0+
	 F6WeDkyOjRalvTBcFYISanedcig+xH2ROsomczsNMlkdMeyjoUmSunG8yWIBPRLCxb
	 wWMGYcs7Rl4n/PpadGXNBAHO/4flM3AegH8Yk1goO/ytSlOysN7eaG8BqKjBFU/5/9
	 ggj7uG+vmzmbtkWL6PHUyLTeZH1dfB+CmHAwDvwWx3kO62OIizMSZyvwAEM1wruMUB
	 Hz1GVErvU6eZw==
From: Sasha Levin <sashal@kernel.org>
To: Ting-Han Hou <ue081723@gmail.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chris J Arges <carges@cloudflare.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Weiming Shi <bestswngs@gmail.com>,
	netdev@vger.kernel.org
Subject: Re: Request: follow-up fixes for "net: add xmit recursion limit to tunnel xmit functions" in 6.6.y and 6.1.y
Date: Sat, 24 Oct 2026 10:26:53 -0400
Message-ID: <20261024-rc-reply-0003-tunnel-xmit-recursion-limit@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261024093010.485-1-ue081723@gmail.com>
References: <20261024093010.485-1-ue081723@gmail.com>
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

> For 6.6.y:
>
>   c38b8f5f791e ("net: prevent NULL deref in ip[6]tunnel_xmit()")
>   77facb35227c ("net: increase IP_TUNNEL_RECURSION_LIMIT to 5")

6f1a9140ecda has already shipped in 6.6.160, so these are fixes for a
released tree. Your follow-up requests for 6.6 (77facb35227c and
c38b8f5f791e) are noted, and have not been acted on in this round.

> For 6.1.y (on top of the queued 6f1a9140ecda backport):
>
>   77facb35227c ("net: increase IP_TUNNEL_RECURSION_LIMIT to 5")

I have dropped 6f1a9140ecda ("net: add xmit recursion limit to tunnel
xmit functions") from the 6.1 queue for now, so the 6.1 follow-ups are
moot there.

Thanks for checking this and for the build testing.

-- 
Thanks,
Sasha
