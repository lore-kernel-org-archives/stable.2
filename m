Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279328;
	b=lYGzLR2LrwEErfhLUOn7a3W6NJReF0Soq5fzUhLd2sawdz7mg5b2ZbK0aaK/szcc7nk0
	 rRjI7xehcVthyfHd6qpAZ9OdnT0e17kBzGTAZ1b2/evWBvNyyCguNRRakvYUb/3o/1UoZ
	 HgZOmBYEfbW2kBm/rZA/VpFdPhYKUq1EHvmfkO27bZOKvnfzkLNrBoBkYZ/1BOJzZq3vc
	 Z6iVLaXAjMKv2Ml0LotREi0Nasnuyk+ypVsjSDx9QM3fvsz3ft+g6zG4v7s0JmE2STHui
	 9op1a5AzEorcqfDXYkMP5aVB5zsvpGHB1ZgrCebNeEEyJui6xj1rSvnHBxfLDDcT4lQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279328;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kprKI/iewFMsq7EdzWuPp4wdFl9lcoIKYhiJgSZ8Ryo=;
	b=rlll6ENsmlPUom7bQ9O2xiLN7/UNPxTcgZST+JU7WDSyDe5ejYl1ld/BVDp+/OpL5Irk
	 x4DmNMhjkBpfdzXE8WpvNI2WHkP7L8qDvsNjrEtBO7dxXg0F9B1AyFWPTmtofEAaZ7ASg
	 M/EIdEOJDCfg/WymvTuxm9E6aSek+PasYU5rxtgnz9tBQDGl+QrqoqZyleyfsYpEtycLW
	 BswzsVqM5sPVLFbG9XInL27jc0cEgmfYu9cKmlUDGcIdScavnAsR7dKQINWzCotH14elo
	 W3VEQa2HY7Z9o7/ZPpZuJ5apcX4dNu/2SXtp4W7lX1kfEmOtqRwHwNUxTAXAp0pWDgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDoXRV5w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDDE606D138;
	Tue, 10 Nov 2026 02:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eDoXRV5w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664781F008A4;
	Tue, 10 Nov 2026 02:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279327;
	bh=kprKI/iewFMsq7EdzWuPp4wdFl9lcoIKYhiJgSZ8Ryo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=eDoXRV5wcKLMo+lJKc2Bsh4Jqx5TdBsLawfFCB8pWrV84gXqAZ9dxCWT+RiK/H77j
	 U2hFuSdLR7NAE0fooUh21X3tZAUcF8ENHXNqMF0Na9KEO7mjy5JShYPgE5/BjiEJlS
	 VMDNaBRDIJT4awjlkzllo8HEXjRfD4Yc5EWPdC2zk4ghhAZiTDlLqzB7t3MHQrur9l
	 Q3jsrIr9wAj+7M2dr5hoPkpkXMqwlr56C7/AhXqpneamMXcobhyLHrPKzhjTSUk2vo
	 8gxTTISmfLlqKcSdNa+dCcuySiJagfrRG/BXydWDoIK1euEgUvTkjMe4soguiRIqf4
	 sdIA10IyzKWzw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5DEC4391AFCB;
	Tue, 10 Nov 2026 02:55:27 +0000 (UTC)
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
Subject: Re: [PATCH net] net: qualcomm: rmnet: bound TX aggregates on
 byte-limit
 update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427932613.3612825.2429027352189229779.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:26 +0000
References: <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
In-Reply-To: <20261031221052.1642262-2-Jeremy.Jean@oss.cyber.gouv.fr>
To: =?utf-8?b?SsOpcsOpbXkgSmVhbiA8SmVyZW15LkplYW5Ab3NzLmN5YmVyLmdvdXYuZnI+?=@aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org
Cc: subash.a.kasiviswanathan@oss.qualcomm.com,
 sean.tranchetti@oss.qualcomm.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 31 Oct 2026 22:10:52 +0000 you wrote:
> If userspace reduces the TX aggregation byte limit while a buffered skb
> is pending, subtracting the skb length from the new limit underflows.
> The later comparison with unsigned skb->len then lets the buffered skb
> grow past the limit.
> 
> Check lengths before subtracting. Flush a buffered skb if it is already
> at or above the new byte limit.
> 
> [...]

Here is the summary with links:
  - [net] net: qualcomm: rmnet: bound TX aggregates on byte-limit update
    https://git.kernel.org/netdev/net-next/c/7bcccc40cdb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


