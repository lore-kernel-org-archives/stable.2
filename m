Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455022579E;
	Wed, 16 Sep 2026 00:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789519874; cv=none; b=CHemOijU6qsy7cL77JeRucs03yaI1XgXazXRiu29HkZdlrwKyQpONFCEl+fU9q3aaI8wEVuKL60zan9M9cGjbnTbPJdV2QbRgbNa78l5O1USpHem34S+vxDcFmqCrFEY92Zrriw3BV4k+KkDrcvLarSTxs5m/S07X0lkWBTQc6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789519874; c=relaxed/simple;
	bh=arRfOlNEmXIpOVWBOgXYpyuxN1gXr1S7cIaegzSmHL8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JVp8uc48l8h3SMW2pvmpnUAY4cqXn19E0p3TRzaglB99SZapdHd6uR8BTsfKQ4bRSQPVUGDVmL0+4sELJQ/oieJGLu6dYkepeHKjWcQ4fgo//kzAECGj4wXHeXPyBiuTzQEOLxunfl/s6jHRsfzQBCJZznUHvtcoHjXWtQ+CXec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EL5MYjkV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EL5MYjkV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 008CD1F000FF;
	Wed, 16 Sep 2026 00:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789519870;
	bh=BxjCEMiTXxljFVqlrSqpR4ljJsuj7IVvEXFsAOdSYUI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EL5MYjkVkQKF5CivANgDH9apPXFxUX6g9G62Z25P5KpJPx/wnpnlKeRGfBWciY1Ch
	 9wFDvLtN4L7HBgM58ROIdX/TN5mnDhU2DAbCxOtbeGzARgNP/gNiy/kVdwf7eW6N0d
	 5Y8cG7heZsKCh5fska7RfxIrQQoXoNoRwYFegp6pe5PiMJJrqOF83TqVutaMNc5RVD
	 WPTr3C+RzjTlRgHjZXdW53dEyPYkGU3SgAIK9dyCWZNPguWCiq+J5lzTMeVkEj/LFz
	 pIc/077PrdJlGJpwV7hQlpCqF803wo6HN2sJl9WwF50NXwMfTl1CcuPw1md31yI6xx
	 eeNzkCUiqDFHg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A43927074;
	Wed, 16 Sep 2026 00:50:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ip_tunnel: initialize `options_len` before
 referencing options
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178951980439.2341174.3543067231110573907.git-patchwork-notify@kernel.org>
Date: Wed, 16 Sep 2026 00:50:04 +0000
References: <20260913090851.468216-1-cnfourt@gmail.com>
In-Reply-To: <20260913090851.468216-1-cnfourt@gmail.com>
To: Gris Ge <cnfourt@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 stable@vger.kernel.org, horms@kernel.org, kees@kernel.org,
 gustavoars@kernel.org, cratiu@nvidia.com, gal@nvidia.com, tariqt@nvidia.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 13 Sep 2026 17:08:50 +0800 you wrote:
> The following command triggers a kernel panic:
> 
>   ip link add d0 type dummy; ip link set d0 up
>   ip route add 10.30.0.0/16 \
>     encap ip id 300 geneve_opts 4660:66:11223344 dev d0
> 
>   memcpy: detected buffer overflow: 4 byte write of buffer size 0
>   kernel BUG at lib/string_helpers.c:1044!
>   ...
>   ip_tun_parse_opts.part.0.cold+0x10/0x10
>   ip_tun_build_state+0x116/0x2a0
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ip_tunnel: initialize `options_len` before referencing options
    https://git.kernel.org/netdev/net/c/455ebeadf714

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


