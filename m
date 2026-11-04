Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793827206;
	b=MN/bZTJmMUMA3tezfnpqxOd6oFRHmGl0WxRGXCswjeWEeZme8dCBw14/AbWeYP7T4fn+
	 mfuiHxaoJUrtQv3OspXPxM7juEI9TnRal18yYAyTzrDgtzH559srsHszNdsBIDkKlGnx1
	 mtX+POev2BYX3qPAzRD6OFtblymXAL7XgP7I/SYZy1wkobcnMUmzSbM5jvP2PMIiBpgRo
	 l8mzd4SI62vvyghhydNdnizGN5HpnzK57RLsacFRQhkDLShCbbl9h6i7Rk0X6J1b9ndDs
	 9wX72rYiYYFfUtMqTEFe5NTopKlrl9ZMsgzxMIjjiuYnk1pStUrXeMKd9rTG/tyX5qQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793827206;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=UEo2NWoGyE8ES2/cBdC2d8fMHRdabnSxMHMTsK/eZ/c=;
	b=U3PzhK72lcWOhjptUo0+nqgOGEc75jEqTKGCveUaCJB7GOh2uWDRhnVQCITB+MSycM/S
	 J9Ca40Y44lhDoZ5RXR5GPw1WbhjHYzat5b1HC0PTzpp6ShyIJvu1hJI1CMntjnvYo/Rqp
	 50nMD1NgnRJbakiQMVMu4bfoTIFhDSFqliE5AYlrhCyT+6YmQeGPsenIeTDdGWa3M2ahf
	 pPnkKt3Dxqa9EVfZ9WXDi/KTI/V8mCZzyeqbCJfNVO7VtfDf9BFdF6sCalP4mw1nmcT3I
	 F3x4rihSN8+j5EfDq7BL+T4/el1veYNn+IuDWKyisx3lcbk2jezxImADYvyYkjzvwaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOrx4Aa2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC5B606B2C5;
	Wed,  4 Nov 2026 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOrx4Aa2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78BE1F0093A;
	Wed,  4 Nov 2026 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793827205;
	bh=UEo2NWoGyE8ES2/cBdC2d8fMHRdabnSxMHMTsK/eZ/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fOrx4Aa2LNpVlorhvzEapOUohcPAjK1dCYbxWzBtm+SkxS8CC2YYCh63Ug7ZihNXM
	 H3qO0jOX4VmS3bHWCLIKIg5kQltwvhZgFvD51Qu6bbDYD/eyLxHr6T34OqK/rEnoUT
	 WLgFgYAjCuc3x2T7PY+q5zx9CnzRGUAL5EzQnarxFBxstO0T0CsmIGUPNPwPT2cGKd
	 1bAQ6KNac2QGwGGx+C2PIRP3JyWDekIAs0qMH+EAWaOfWg3K/8vFtaIfD1yhJRAiCG
	 JSAHLWvOhIFCzqxkG6dljk7zfPJHXbRT+Drx3D50+07l3c7k8d/SnK0tShtqHm5O0h
	 Lc1lv3w8nvc9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA342380047F;
	Wed,  4 Nov 2026 21:20:05 +0000 (UTC)
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
Subject: Re: [PATCH net v2] l2tp: only return sessions of the given tunnel in
 l2tp_session_get()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179382720463.3223324.16769779750927973517.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 21:20:04 +0000
References: <20261030032617.4065353-1-hengyul@cs.unc.edu>
In-Reply-To: <20261030032617.4065353-1-hengyul@cs.unc.edu>
To: Hengyu Liang <hengyul@cs.unc.edu>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, horms@kernel.org,
 jchapman@katalix.com, tparkin@katalix.com, gnault@redhat.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 23:26:17 -0400 you wrote:
> Commit 5f77c18ea556 ("l2tp: use IDR for all session lookups") made
> pppol2tp_connect() and the netlink session commands find sessions with
> l2tp_session_get(), passing the socket of the tunnel they name.
> 
> L2TPv3 session IDs are unique per network namespace, except that
> sessions carried over UDP are only unique per UDP socket, the socket of
> their tunnel. However, l2tp_v3_session_get() only checks the socket when
> another session has the same session ID. Otherwise it returns the
> session, whichever tunnel it belongs to. As of now, a session command
> that names the wrong tunnel acts on a session of another tunnel, and a
> PPPoL2TP socket for a second L2TPv3 tunnel fails with EEXIST, because it
> finds session 0 of the first tunnel.
> 
> [...]

Here is the summary with links:
  - [net,v2] l2tp: only return sessions of the given tunnel in l2tp_session_get()
    https://git.kernel.org/netdev/net/c/a75facf4bb3e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


