Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4E04446FC;
	Thu, 24 Sep 2026 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790241077; cv=none; b=bgRWG8I2xX9cZVFsxBcUX8zzh5J56zhcOCHRhFUClEsSB5wfLjxELQqy4NRuWi+E/cTia2iHYENEMWzj3zGw5t51STa8Or4YO/sULPmhPPW301ehrhfcAVPlKg65ANAvWO6g6PfqwFCIKltixyxCZENTXLXwPN8sN/Y7kxLvFoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790241077; c=relaxed/simple;
	bh=UvUiJVYAQ9rY09y3Z0MMOKLOwLLmx9N+YaThfpWjiDI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=F8BQ/1niK1+PSo3TaakfqA22bFu0SDokeyHJlylRMa/VcHHrAyNsFcm2BkaD/MYrIM9K9/yKbl0JR/T2r9oSOAmoHszUgl06lfNOHiGQthzDRr40iFuo7+kwhtlZErashzrBXtwerSLIZQqlzMpsvDzpef/Gpz0SJdDPvaaf/II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDJxVeSB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDJxVeSB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90A3E1F000FF;
	Thu, 24 Sep 2026 09:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790241075;
	bh=GZfgzrbUvvFCBkVZOq/CM3Z+p6HIjpOgO0+7DQgIAc8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LDJxVeSB+A8SXjQ2ES4K0ov8L3xp7z/QTCft3XjeBemFIV51DvkQwlKZ5cCcNVpHL
	 3a12RVY79bNSu9HwqMICvTUHG0VhGVBtS0knfMGyhsHIT0OqTPbM1hm4oBZJtzm4P3
	 o9a6ly8cdDrUy13E+SzzusTZJxBWSK6UIHKUQo4flFZlG342WJ0wdR2pfA8wK8z0xC
	 H+BPCMbx2lVw6pasxfmE56Gdg+iKOfmqlZev49rYLB1riPqqcIuvrREVMBAEfe3D1L
	 zGayBsHfF26IWIrtvGPtdogin0HpHQrqWmFpr2YSvYvTjWuwsccWIN+7hRhozjbkOU
	 wKBdwWmXywC0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1994439EAFD2;
	Thu, 24 Sep 2026 09:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/1] net: ipconfig: bound DHCP option construction
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179024100489.1422440.2291512880873856008.git-patchwork-notify@kernel.org>
Date: Thu, 24 Sep 2026 09:10:04 +0000
References: <cover.1789798023.git.xuyuqiabc@gmail.com>
In-Reply-To: <cover.1789798023.git.xuyuqiabc@gmail.com>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, stable@vger.kernel.org, vega@nebusec.ai, weir@nebusec.ai,
 xuyq21@lenovo.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 19 Sep 2026 16:45:26 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/ipv4/ipconfig.c.  Triggering it
> requires control over the kernel command line (the ip= and dhcpclass=
> boot parameters), so it is not reachable by an unprivileged user; a
> root-controlled boot or a malicious boot configuration can still turn
> it into a boot-time panic.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: ipconfig: bound DHCP option construction
    https://git.kernel.org/netdev/net/c/e47a1958e12a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


