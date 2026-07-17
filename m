Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA59126FA60;
	Fri, 17 Jul 2026 11:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784287236; cv=none; b=mVPmoGwD4KlTutmP+dDlNrJdKeceNzQBoSRZSjoGwbI2z8l+ziq9dwX3SsU0rBexBAUP3lW19kBtav2D0eLIC3iBIQQxL9lANaVr6KDGGMv3xuJaEwcYS8yzedFuSuPFos9f+Ng++7LDni+/IvhPkaq9J0GWgEVSzMheJXnQG+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784287236; c=relaxed/simple;
	bh=m30UymqwzVqrj6AZaoiU6gVDHWQ5gR5TAUZzYV8pN5k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kzr0SeaeCkhO+J9Wur++EomBePo0PKqDtJ4GrhJghPbhrddTj8i2yW4PYGU9VbikISOwhLO2RP7sPRVW1VkSc3E/pyWXxyPHMyKM0LLBXJu2Wvoo69BhfrjG2Gt9ZJP8+As9IKIOUAi/V27LCmH91S+Qq0MixPf6JXDm4eAQKoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iz08pqqZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iz08pqqZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 945901F000E9;
	Fri, 17 Jul 2026 11:20:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784287234;
	bh=R0OJXfSfK+Ku5jhIInxV5CFhbrB6aCdAmTCBDCSYgWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Iz08pqqZ29w86CRLsMQBlZLICXpdDbAQ9+nDHAyXyKN//cGHzMhtrG11eeo+MJM/q
	 HIX+m6E6nLb8FW0oLRal9wIfjact0nD3EUlHyx6avRl2Xacb4oHzgDNjGlmibeHPCB
	 GfhtrW89rbi22vSQZnF7Pi65Ct9YQJvAFC00A2sE7sTMS9z4TaPbXNqFtDNffi1gv7
	 00otY/7rpEP6ppV6Ro3COz8tQ8zxZwpESwPGRgyn+FQYffWvHikTh+73luSzF1fr+H
	 dXSXOHXpKTnOEvIRnm7Azi8M+PC5bGdzQT6igN1EDygMZketFjfkEJ0NnbG1HJHAKD
	 T02PeakvqMDTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56836380CED4;
	Fri, 17 Jul 2026 11:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] llc: fix SAP refcount leak when creating incoming
 sockets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178428720714.1673922.10721054190774288958.git-patchwork-notify@kernel.org>
Date: Fri, 17 Jul 2026 11:20:07 +0000
References: <20260712130343.518797-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260712130343.518797-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, opurdila@ixiacom.com, tim.bird@sony.com,
 luoxuanqiang@kylinos.cn, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun, 12 Jul 2026 21:03:43 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> llc_sap_add_socket() takes a SAP reference for each socket added to a SAP,
> and llc_sap_remove_socket() releases it. llc_create_incoming_sock() takes
> an additional SAP reference after adding the child socket.
> 
> This extra reference was balanced by an explicit llc_sap_put() in
> llc_ui_release() until commit 3100aa9d74db ("llc: fix SAP reference
> counting w.r.t. socket handling") removed that put. The corresponding hold
> in the accept path was left behind.
> 
> [...]

Here is the summary with links:
  - [net,v1] llc: fix SAP refcount leak when creating incoming sockets
    https://git.kernel.org/netdev/net/c/2c72eb628634

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


