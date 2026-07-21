Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B15332913;
	Tue, 21 Jul 2026 19:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784660490; cv=none; b=ovlgMOH/jUDRVB9Ecr69MmHZAUJ1hybNpsjiD4Ta502hL2yoqqpsfaQ7s6atdksoPmTIB7+SlZmjest8tovpDAYV6TEPJmZaf+w8YHBLsfROs2PyZJFBxjfodZTEERXLE/kpZgWfTUdPmGY1aXT4qX+7XOHkNxWhiEa6UG9VpJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784660490; c=relaxed/simple;
	bh=wNCyKJLYwbw41gEGw7oQ6t/yBuhlDJaeVHiLXl/bTu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a0463C3sNeqEOC8r2abScXxYQCKgt93DLWkmWPRfFbX6IXaYSlc2RGbRh9fvysQmcLhkhZ/Mt2Xyb/XE/SYjYT7A2XEvpMPmOoiS53wwgerUv+7PmqfZhbhmZL77LgIZbGuh4a2SCxSdDZt+aQFsPxC9v8Xtxn+r0H9doNIWVso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWVPOc28; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWVPOc28"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5765A1F0155A;
	Tue, 21 Jul 2026 19:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784660451;
	bh=UwtjOB0Zj20D3ATPYXjm0ZXlhSFaikQJlwm+B1jRySI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WWVPOc28TYbhvxcr1f8G9B60aQgZalU6v4rgzN0UTqHkq1TJezJXXJisCdgRidLhQ
	 bPDwc84OUT6aTPLwFh96G4rxHsgcQVMUDWQGH5QY0ihwCRWY+MWo/gyR63FdookGrs
	 HEbiITkbR1GQ3qztUl3xnRolAMvjMbg0ZrvmiIJfh43/mTr50ZDYMmUjXDGufriSIT
	 2QPkydxe7+ixI9TRwi+UlID65RfYjTMiOc2hOMT2K+xt5zSFabayyXS8mCrZBoAcMi
	 3cHPL9XNkzDuW3YTHyIJSkgHc3GXTeZsRBG3womCE8oQZdwh2xzJvWJA/P9pwNR+zI
	 QUX5or85Flk4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1984639253F6;
	Tue, 21 Jul 2026 19:00:22 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: mvneta: bm: fix device reference leak on failed
 lookup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178466042064.954483.15403749887126592985.git-patchwork-notify@kernel.org>
Date: Tue, 21 Jul 2026 19:00:20 +0000
References: <20260709082713.829446-1-johan@kernel.org>
In-Reply-To: <20260709082713.829446-1-johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 gregory.clement@bootlin.com, netdev@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Jul 2026 10:27:13 +0200 you wrote:
> Make sure to drop the reference taken to the buffer manager device when
> attempting to look up its driver data before the driver has been bound.
> 
> Note that holding a reference to a device does not prevent its driver
> data from going away.
> 
> Fixes: 965cbbec7f20 ("net: mvneta: remove data pointer usage from device_node structure")
> Cc: stable@vger.kernel.org	# 4.19
> Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
> Signed-off-by: Johan Hovold <johan@kernel.org>
> 
> [...]

Here is the summary with links:
  - net: mvneta: bm: fix device reference leak on failed lookup
    https://git.kernel.org/netdev/net-next/c/ede0f99cef53

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


