Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C79381E8B;
	Thu, 24 Sep 2026 01:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790214077; cv=none; b=eJ3xT1clpT4Im91HgAxj2Iikbbb+ilJ4CzgaGy4FwqMuGGOvWNVwHAgNy+MvWr5RkqWkZWX0YZ5bYDrJeQkBwMBxP950bvM0/3/mY4U/oRJste4cS9LviM5mh2CCLFobGiJi6u4GK3pGwO/yHv8Gzhwx0wNctYjIaqUdlavHgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790214077; c=relaxed/simple;
	bh=nC72NqSKgiG5NTFORV9fGD/moqOfIg8oK88apAv18GE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E3/ZZ5/b9xU1lsIjgD/wBl1k0UQty1TXK/zgqpvkXccr/bRW/f+tesEsDZ8cf6gx16hGeo3oH/+6BhV6R67pxc4sKVpxlwhZEyNzM/IqPcTU/8DcCY6RNfaM5Wd+CVfXvW9gbOwyde1xF8eFcw7FM7DaT2h+YD952s60bU3ctHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tb3n0xqF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tb3n0xqF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8424C1F00893;
	Thu, 24 Sep 2026 01:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790214076;
	bh=eqnb1Vg86PARE4GBksgGeAsSXPnDWXL5uidKJJFhf4M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Tb3n0xqF85yHvZxbKU6d98SoDtSiEqWHKPqi3SCi70jSUEr8C/NrWCDwjYdraJ+O9
	 Pr24PJPMbpvcwVwDqDRWadpwxXqo57V2TQcKdlUZVc+NzeV8Kf8I6wd7QnAc///pzN
	 CkQWWoTRrmmOn+8KGzui/IbxzQ46OZd4qE7I5X9SrSPHh0b98lmOdANDTTIlWM1bv6
	 VdgEkpN9tmaCuy8V53NZVCIN5RDiwYIhMMhVMsa4db2vIZpb0svRa54UNslZ6cbLbp
	 iTBOJZqeb6Q74cgJ09hRc5vFMCyiVIGW8D9iLb0KE38phtEsNbxZykiA++LfFGS2eP
	 cZmYsRoI8pYfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568BE39E9611;
	Thu, 24 Sep 2026 01:40:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ipv6: sr: enforce exact attribute length for
 SEG6_ATTR_DST
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179021400590.1269562.2967028555293483325.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 01:40:05 +0000
References: <20260921044025.1535982-1-benquike@gmail.com>
In-Reply-To: <20260921044025.1535982-1-benquike@gmail.com>
To: Hui Peng <benquike@gmail.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, hangbin.liu@linux.dev, horms@kernel.org,
 david.lebrun@uclouvain.be, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 21 Sep 2026 04:40:25 +0000 you wrote:
> In seg6_genl_policy, SEG6_ATTR_DST is defined with .type = NLA_BINARY and
> .len = sizeof(struct in6_addr). For NLA_BINARY, .len only enforces the
> maximum payload length and permits shorter payloads (e.g., 0 bytes).
> When seg6_genl_set_tunsrc() copies sizeof(struct in6_addr) bytes via
> kmemdup(val, sizeof(*val), GFP_KERNEL), a short SEG6_ATTR_DST attribute
> triggers a 16-byte out-of-bounds read past skb->tail into uninitialized
> skb->head memory, which is stored in sdata->tun_src and leaked back to
> userspace via SEG6_CMD_GET_TUNSRC.
> 
> [...]

Here is the summary with links:
  - [net,v2] ipv6: sr: enforce exact attribute length for SEG6_ATTR_DST
    https://git.kernel.org/netdev/net/c/2d959c75c27f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


