Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793804407;
	b=lXJqZesWWEpRknyVwfDWdMnIuCrGoTjK5QFIta1iHdUBaApbhGOpsTkegIwqq5LeZkIc
	 7MVir3HSsYvDAvbCmCqVtsdtiTtTaGjuoTgvgt7VjvtTMAS0FHNcwt6Aay1YjsQmXDq3J
	 4ZedB20NIVO3hlrSf7Qv+ZRp6TvQn4SsWBUnOagU0qD+y46qvQ3QvtWRKdknRqFtCMghK
	 tkd3uqW1dms+60LPn88bRL0fJXP5Oi3sQSZWMxz6LP6yiufutSUzgSyWOnBwl1ZOvcWmZ
	 IurWkQLP2gqI2H4JE2umjI5bulYOR5jJIz057kHsIQgJkM7vZP6HZ73rLmY96TvK6Fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793804407;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=H3zrIwsM5Od3j/ojrupK60k2PACGT3gOchQyhe+f38Y=;
	b=vu3AVgxTjNOtJQtjW5evpghxL4Nl5Ry/BQn/D6Ie5ZL6DqvI72dGi/soHruFYaNP25ak
	 8KKUDoWt4vom5AAB+5vdZmm41wl+AeF/ZSy6yyBe8d9+NbZ5/wAjdHnCpQMJgB0GgPsYC
	 h2vCFRStKB28py5hyu+i8tBwRBN05srv5yXsXi9cpPb9sftsukArwvgmeJ73iLplpr+uy
	 d9O08qqWzV7PE6TgMH2j6gbskFQWUdhc9eIc18AowXdwik6PY+NhTl4osae5cYnse6j3N
	 GalPHwrtj75baznD7iUlsL8eY45jM2tkTr8umDMgZGLOjn0O61lPfsJwNbg5GvnIo0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdkH4MMI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F9C606A330;
	Wed,  4 Nov 2026 15:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HdkH4MMI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 573E91F00A16;
	Wed,  4 Nov 2026 15:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793804406;
	bh=H3zrIwsM5Od3j/ojrupK60k2PACGT3gOchQyhe+f38Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=HdkH4MMIbxzv2hIRAOO9odLEbDeDKHSz8toPVfBNt1MtbFLccnBUgKS8Eq20/HQA1
	 4Y7srQbYuqddoczaHFJ1k1UIvoHYRu70CPfsT6KQ2LHzzn29vgpRbQlyyRRQhLcGsl
	 xFD8ZBnO3DvI1kS8Ox5+wRMsn8hsljEKlGwm8IfQmLbLkC4mjZev/0HT5bgzhB5tgR
	 2CF61pon1h59Ach8QJhhfr4WbSD94esGYG0F+SGbgVKeal+NChOj3AW9PvnZw5hvD1
	 JZGvmk/thfPinS0TNzuhcJmz+Vnxgqo6/EKzMUFt4q88JPGzTAG0+l47aHhjI44C3H
	 oeIpyAO6n+xWg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4024E39E8A48;
	Wed,  4 Nov 2026 15:00:06 +0000 (UTC)
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
Subject: Re: [PATCH net v4] mptcp: do not use Fast Open on MP_JOIN subflows
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179380440480.2875940.5423974447556647917.git-patchwork-notify@kernel.org>
Date: Wed, 04 Nov 2026 15:00:04 +0000
References: <20261030-mptcp-tfo-mpj-v4-1-e6eff2027342@kernel.org>
In-Reply-To: <20261030-mptcp-tfo-mpj-v4-1-e6eff2027342@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: martineau@kernel.org, geliang@kernel.org, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 cpaasch@openai.com, mason@kernel.org, netdev@vger.kernel.org,
 mptcp@lists.linux.dev, linux-kernel@vger.kernel.org, yilinzhang@moonshot.ai,
 stable@vger.kernel.org, bug-report@moonshot.ai, jiayuan.chen@linux.dev

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 30 Oct 2026 23:03:51 +0100 you wrote:
> From: Yilin Zhang <yilinzhang@moonshot.ai>
> 
> tcp_fastopen_create_child() hands the SYN packet itself to
> subflow_syn_recv_sock(). For an MP_JOIN request this takes the
> fatal fallback: the cloned child is destroyed and handed back with
> drop_req flagged, but tcp_fastopen_create_child() does not check
> the flag and queues it, so accept() can expose the freed child.
> 
> [...]

Here is the summary with links:
  - [net,v4] mptcp: do not use Fast Open on MP_JOIN subflows
    https://git.kernel.org/netdev/net/c/6d2cf411aba2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


