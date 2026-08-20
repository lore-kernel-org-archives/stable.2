Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B51F3D2FE6;
	Thu, 20 Aug 2026 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787257872; cv=none; b=u+Jd0k39IebbImMW9FRNkA12zkhfgMOyePUT2Yp/pIvb2UqWNNfGhKsA20lW0Ua9XdoynFy+ugw9GwjVIr5LnB21yWvIw6Ur0Y7rWvaW8UX8Ii/AYr7qCmlyanjzMXjDYGTgAH/KQO/lDr1tpRHXLD9SAFmhXUZtNgkUCcdTbs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787257872; c=relaxed/simple;
	bh=gKEKXhDNriZQ8i/RRktlgFJlOhsxTsiDMiZDo2xQxoI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JkStNpY482I6X7dD8SBkyWqUGLGCWPtqt8dJhIfWx7W3swHgSUDk6lKrVCoYV4h2G3kHp/b2vIE7mkuyDZ+6qgOg/KgHdRfktYflXujF3xCYPtIF3oq+EF4IjeeJ1YmbsEyJz0vqJx3mjVJfKe8lGI8qzA5MIdLPPRgGlpW9Wps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FyJpO8Sh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FyJpO8Sh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F601F000E9;
	Thu, 20 Aug 2026 20:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787257869;
	bh=0jhyD/9w9IsKrKUNFtDuiTkvj7rdNRc3WgqcQm5GhXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FyJpO8Sho9jgu9VNqPyw1/mRFdCSUqa7MIutqXuLyZeRShtmMd0aadB/KO8nOF+ox
	 eXVlTcOVm407kwxDSOd35MPBAeSrTLxCVMEgP1zpxJ7ebDwkwSlZhF/natcshrOOK3
	 Sw8Kri5Ck+qaw26oEE14F25Fn3A/8zH51h9y0NhEB/VJmqK60rHVhZkmXVOoT5jGsg
	 LV62LRhI4QqeTrK12fIr4pRALnYYlCMkLfwWeCwixqt8O6VebFJaZ5Cxji9wuHAL5H
	 gJwYoWy8gA/kvL3n0RLEPpQ93ripwmfS/gZnMLRAZtwgRV/CkPIQKxDmZQyAhArTpG
	 J/wf4II0MLyjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A43392445B;
	Thu, 20 Aug 2026 20:30:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v4] ipv6: seg6: clear IPv4 control block on IPIP
 decapsulation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178725781939.470503.5520923908508734046.git-patchwork-notify@kernel.org>
Date: Thu, 20 Aug 2026 20:30:19 +0000
References: <20260817085839.946321-1-david.lee@trailofbits.com>
In-Reply-To: <20260817085839.946321-1-david.lee@trailofbits.com>
To: David Lee <david.lee@trailofbits.com>
Cc: andrea.mayer@uniroma2.it, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kylebot@openai.com,
 dominik.czarnota@trailofbits.com, nicolas.dichtel@6wind.com,
 horms@kernel.org, stefano.salsano@uniroma2.it, dsahern@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Aug 2026 08:58:38 +0000 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> End.DX4 and End.DT4 decapsulate an IPv4 packet through
> decap_and_validate() and send it directly to IPv4 routing. The inner
> packet therefore bypasses ip_rcv_core(), which normally clears IPCB
> before IPv4 interprets skb->cb.
> 
> [...]

Here is the summary with links:
  - [net,v4] ipv6: seg6: clear IPv4 control block on IPIP decapsulation
    https://git.kernel.org/netdev/net/c/44930446dde4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


