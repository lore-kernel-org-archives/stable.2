Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7C8381B00;
	Sat, 13 Jun 2026 01:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781315412; cv=none; b=tbsP3nT+yM39Iv49dhAF0ZNSNg13+PvV/343BERbbdkRYzJk5fouQtzb3SSlSrVMoEUx4/hB1ZQp2MCKyzbRC2vqWqQZ1SfLZwdeFeR/jdnhe/y6/1GLuHOIAxIuLdN74ZN9lssYBeOAunwby64CuQOphVaAnflomgtOEuE1qcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781315412; c=relaxed/simple;
	bh=TRzImSY2SWfPCS/SC4hzYAUtCdHbgMPdEyve7qgHvYw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b83pWgD+9GAgx44rTMQVfIO+d1oNOf8iZ9VEnUMfIBOy+2nuqJ65iU59sNTLqnYU6+UC0RKQjydC+fmkBe6QBDNX9fK1D6Wpt5rYRgDmtSCGAAsHt5fnFbsiryg4UWnCEEnlqDyg0bwjQtobap0mKkW/EK0Hhcdq5dSaI0G/aqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nty8gno+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nty8gno+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4EED1F000E9;
	Sat, 13 Jun 2026 01:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781315411;
	bh=BOrpAwxya2ulIk5fBuqfmGjMy6iJn8EB2CWDGvWEvVQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Nty8gno+USU0MPJhHhS/9BAxmozZ8icTE0SgdpejcL/tH2L3owgJemxxL8aTxXznI
	 0q3rWUJsuSglcxJRQXK+Yt6FoZA1nhE0BX59u3yFhswOayKo3f1814KOS8f8Ia7hLm
	 QAAGtQNClt9dgG3i0/+DDRWEt6CoumNzEa3HnyTnh3fbFFXo4Jr+P1YXp87Eu7dt3Y
	 NAt0ka22rKt7BYUSpC5it07gaFc+dOqpKDAQVcMuSr1NLIWfdIO07HmucAQIW7O+SB
	 y53SeuC9bJf5Id9YESiiYNUxAZHhelVoDbWVZ0kdaFoclmIzz7f/BZKn27IKd5GTVP
	 VHeuAlORJHwOQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939A339E9607;
	Sat, 13 Jun 2026 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: qrtr: fix 32-bit integer overflow in
 qrtr_endpoint_post()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178131540813.1328827.18042311383082528410.git-patchwork-notify@kernel.org>
Date: Sat, 13 Jun 2026 01:50:08 +0000
References: <20260611125455.2352279-1-michael.bommarito@gmail.com>
In-Reply-To: <20260611125455.2352279-1-michael.bommarito@gmail.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: mani@kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jun 2026 08:54:55 -0400 you wrote:
> qrtr_endpoint_post() validates an incoming packet with
> 
> 	if (!size || len != ALIGN(size, 4) + hdrlen)
> 		goto err;
> 
> where size comes from the wire. On 32-bit, size_t is 32 bits and
> ALIGN(size, 4) wraps to 0 for size >= 0xfffffffd, so the check
> passes and skb_put_data(skb, data + hdrlen, size) writes past the
> hdrlen-sized skb and oopses the kernel. 64-bit is unaffected.
> 
> [...]

Here is the summary with links:
  - net: qrtr: fix 32-bit integer overflow in qrtr_endpoint_post()
    https://git.kernel.org/netdev/net/c/20054869770c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


