Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794309608;
	b=KZawiZ4nLiSUpSnPjv8JOQKJiBGTt5oJMICZqznEtVUMnhI493UOHsta0cONv40jZnLG
	 ve4vaUbhnbU7zEKJiUP8WWp/VUzsZOK4RsteLwrSbUpCub53p4SuDnz/Uq+/BJfCnNS9x
	 /maTSCtbP3W3akmnovnlAqsbqrxqjf90g+W3ONjzXLB80VOgG04V3+sAtSy+jW1PB3QMj
	 GZZyl9OaymsYVJuyayk5Gz+ozxlHn5DfyYF/LUTFpAqswFcO5ZiQHZYu9UvbzzUCYd5Jd
	 NeFXQWRhE8YhPKremTBnv33ymiORD5tLY61HvhvobFo3MGvTVaJ0GOFGeA3fXlLSTFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794309608;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=P5LItDkofLGLIRMGwr48t7RGGDVxJcFzQKJIYZivfrQ=;
	b=R6BsxOgRoPi+2murWnYRe2/AiAOwKf5agIKkqdkhTICmcZVndDbJZXTSE5StC889rwoP
	 2rMhV4/W7LKW2Qh3IHAqucjgLnNkFEyjbCnBLW7gRQrvYvGh6PJvtcMMM3sA6OCXbCwCj
	 4auqxz5yTJrrL1wmzwgIpIo0QNP5qw7+wSWGaErwRO0SD8hbKwN084LJZx2ttTSvjdouT
	 yRbqBiX8bK9n8ldmTKGuyoVqi1pOq2DM+KUgepNccTzOH2WypycvUkd6gqYHptp3cwEGt
	 waxDHb5IpG3dnWdxUM7fdB6OIJTWtmthdiVwzYDhW4F8cS5QTJAYiXfrty3XZUtYEQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRnjS46o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3C606A31C;
	Tue, 10 Nov 2026 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TRnjS46o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 672D81F0089F;
	Tue, 10 Nov 2026 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794309607;
	bh=P5LItDkofLGLIRMGwr48t7RGGDVxJcFzQKJIYZivfrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TRnjS46osjZE0KcJjgC14/NubVQMO3BVX1nvaJ1wXUzYEXR/sE0661S6Gv0NWphi0
	 GBqPJkj0MOa7iOKPYD87aT9TWk38oGdaOV5TcPC8FJJ3wk5JVvnjLgJ4SC7vrwXAip
	 ed8e1qcp4DDbanf8tPaMhfVpyvr8ockrj9RYJDlSlGgAAnbbn+aM5LyBH0Xd3jvDeY
	 lPp7kXuAtunEeji0cuzR3UFCI4uhYQVF4ldOz9G9kDDQxi7Ptb/jOBxBwsePcaqPmF
	 JCoWkium5qr9c4IVL1ciFAnWsYePksM/FFGW+0gceD4XS3gkA7hMdm/SaFoTP5TjBh
	 /JQUiPR1Vt+qg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5E073391B17B;
	Tue, 10 Nov 2026 11:20:07 +0000 (UTC)
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
Subject: Re: [PATCH net v5 0/2] xsk: fix multi-buffer TX software checksum
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179430960617.3882254.727568151015351636.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 11:20:06 +0000
References: <20261104034809.24545-1-testwrzwrz@gmail.com>
In-Reply-To: <20261104034809.24545-1-testwrzwrz@gmail.com>
To: Rongzheng Wang <testwrzwrz@gmail.com>
Cc: netdev@vger.kernel.org, maciej.fijalkowski@intel.com,
 magnus.karlsson@intel.com, kerneljasonxing@gmail.com, sdf@fomichev.me,
 hawk@kernel.org, stable@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed,  4 Nov 2026 11:48:07 +0800 you wrote:
> This is v5 of the AF_XDP multi-buffer TX software checksum fix.
> 
> I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
> two-descriptor packet had a bad wire checksum, while a single descriptor
> was correct. There was no production or syzbot report.
> 
> Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
> the point where the last descriptor has been added to the skb.  The old
> code calculated the checksum after the first descriptor, so multi-buffer
> packets only included the first fragment in the checksum.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] xsk: defer software checksum until the skb is complete
    https://git.kernel.org/netdev/net/c/f2eddafbfcc0
  - [net,v5,2/2] selftests/bpf: cover AF_XDP multi-buffer TX software checksum
    https://git.kernel.org/netdev/net/c/c112921763e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


