Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795304665;
	b=lcv8GaBP2JVOQ6MYpBG6X+s/bQezHgIgo9NS9pMFJeG0lWALvBNh2QO+a8SwFrFNENZh
	 85Z2+JpZVmSl3SJJz8mwG4F2qii1e0pa/CaIfHHwnT4qB9zT0lEmexXq5UelML7zuFZtQ
	 V7n1EEb1Bg9NRnWWz1JoIsT3fDc0Aygpn2IvAnEBAC6D0b0mzxUU7L4+AyuBb50MMTJ4n
	 xFbCFj1yXB6PfVk3sRbqOAEGhUasQLhd6UXkI7A86092VPlcttpBOUoxjGk6dnhhuspgN
	 XoMZgU5JSJxT6hswMEPlK8C7laGYnRdW/A78gnqx/tRRIEl/oUZRPIN7faK/Pxl4orw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795304665;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=sRkY7zM0xKaJxy4mzyL5E+209WLLZ6mGzirmGXa5UsA=;
	b=raFdB9q7lAyms2FuGsNHAuwCsquLCDmK0tDO0SPSQcY6b+pBWwawAzt/IpDpHyQ5FH/8
	 HRzNsuuahIpPDc+cjKa826GzCoQ8VZdMFMGwNChkzWOF0FaREJbKOjqza/XOYlws7mdKu
	 PW6u4cN/CQVcfTIM4g/IqwDMTKciifYP6ee5JR9w8KHf0nAN/mldOKcC3uCxXIsMKugqO
	 stjy6HdXT7DC+ojR/tj3Jl4s3/+ue6Mg0fdqA1knvrdFORlDGfUT6Fw18rha6ub10Fpnc
	 1Fv1qGmEi2LgK27r78ZvPM7hl2Oi8k92pXG/MBBLZEJfVeHYb//kzHD3TCvKdxk5QZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCsPkCy5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA712606A335;
	Sat, 21 Nov 2026 23:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OCsPkCy5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8053B1F000CF;
	Sat, 21 Nov 2026 23:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795304664;
	bh=sRkY7zM0xKaJxy4mzyL5E+209WLLZ6mGzirmGXa5UsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OCsPkCy5lB1nuG/GMENesGHpAm0+U044by7TZVn9nnFcS7qFuyG1kE554qObTnSLv
	 SB1HX+zJrCDI+5Cs4sDk6NjBWGCcDFKcenq8DlMqo2XY4b888UbAi2a35JMHxgJh8/
	 1vnB6BBwbKXGVTsLQ+8RoWUS8YXC6Dr5c6eR+kwwteMXU2E24y39UOLgSySsW8hiio
	 AKDE0IWotxi/xOYG8T0xkJAknLTI7s5ZOBF24vKCvfpngcTCrVPkix3g8pfcliL0Z+
	 xECnMLg49uPb1nDcGep67lKLccKfiVSs8cwrkD0J5s6/InWmBPS8Y9LD6m7L5N4tfk
	 Cm1Y+LLX5UVdA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7743E391B08F;
	Sat, 21 Nov 2026 23:44:24 +0000 (UTC)
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
Subject: Re: [PATCH net v8] kcm: reject TLS on attached TCP sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179530466302.1212208.15645522376520311508.git-patchwork-notify@kernel.org>
Date: Sat, 21 Nov 2026 23:44:23 +0000
References: <20261116190111.3317976-1-rjethwani@purestorage.com>
In-Reply-To: <20261116190111.3317976-1-rjethwani@purestorage.com>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, jiayuan.chen@linux.dev, stable@vger.kernel.org,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, ncardwell@google.com, kuniyu@google.com,
 john.fastabend@gmail.com, sd@queasysnail.net, davejwatson@fb.com,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Nov 2026 12:01:08 -0700 you wrote:
> Neither kcm_attach() nor tls_init() rejects the other, so KCM and kTLS RX
> can be stacked on the same TCP socket in either order. This breaks in
> several ways:
> 
> - KCM calls read_sock() from its receive callback in atomic context.
>   With kTLS RX this reaches tls_sw_read_sock(), which can sleep.
> - Before tls_sw_read_sock() existed, read_sock was tcp_read_sock(), so
>   KCM consumed raw ciphertext from the receive queue that TLS parses.
> - Both install socket callbacks. kcm_unattach() restores the pre-KCM
>   sk_data_ready over tls_data_ready, so TLS RX stops getting notified.
> 
> [...]

Here is the summary with links:
  - [net,v8] kcm: reject TLS on attached TCP sockets
    https://git.kernel.org/netdev/net/c/746dbdc5fa60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


