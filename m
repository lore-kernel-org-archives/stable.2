Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FBF8476CFB;
	Fri, 28 Aug 2026 21:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787953268; cv=none; b=KUxhRhtMFxHLVvpW9pjzLxf4qAWGNbOea/V8r1SZz5MJXCiORb1g+3eGcGWpNPwSLC8wV9XSLP663W8zgP5UTU7AD3dDCj8eZjsWjf1GNoIpWYlEU995ivKLNYD/zlz8ZmkwnmpCmUfEdhQiv4MZGIHqM4KXNhg7U+T7gZCFfko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787953268; c=relaxed/simple;
	bh=rwt5+ypRdrvLVrA2A7pcCwbfUJnXIgXaA+587wLysgU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RC7+DvbvNLWFQDhxBEMIhvwLfpy4CrKHSLOEib3Vh7p0ofvdyumoQFWwwdYIXhRI2suELR+RW8LDlHWpR5zEhwu++vyl//zmMm1TrgSAb4BkW2NoowobV/4NRZB50nSfryPL92rDOzpRWN0wNZ17DTbmf7JTO+dhydQEpFxOWzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ibntiLpK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ibntiLpK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D863A1F00A3D;
	Fri, 28 Aug 2026 21:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787953266;
	bh=ZT/IXwHLcilUoOKTLHCvmfdIqaTfsslv5qYDIE9/aRQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ibntiLpKnMMubulldf+aoFj00F+MgvRXZnMJGfTRV7gX8rHCFSsVrGuW+KJIosO4i
	 UpYQOzB3QBGl2v8g32QLRgCge5ACDdwOZgs9K08b3qYnkVhXfzJ/3L4sxvNDYB9OvY
	 KNqiVBZeruV9iagW8GNquu/CSyLydt1LPoNbZGYzVXORsAolpoAQPu/3LHYHlVKwec
	 zRYuvXJVbQioEQFQKV++tIGG/2SNpt5r1QNGaZ30Bmy5Z4miYxp1GmTj1+FNiqh1C4
	 lAeWajouRl5D5T/yLXggt8uCTAhtYC4KXAWd6AlC4Z+VzzHDFLGVe60KloQv53R5H6
	 VLPSdzGd69DfQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A6E380AA69;
	Fri, 28 Aug 2026 21:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] tipc: protect node reset trace dump with node lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178795321139.2809934.6718042248113223796.git-patchwork-notify@kernel.org>
Date: Fri, 28 Aug 2026 21:40:11 +0000
References: <20260825190141.242219-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260825190141.242219-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: tung.quang.nguyen@est.tech, jmaloy@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 26 Aug 2026 03:01:41 +0800 you wrote:
> The tipc_node_reset_links trace event asks tipc_node_dump() to walk the
> node's link entries. Unlike the other node events that request link data,
> this event runs without the node lock.
> 
> This permits bearer teardown to free a link while the trace callback is
> dumping it:
> 
> [...]

Here is the summary with links:
  - [net,v3] tipc: protect node reset trace dump with node lock
    https://git.kernel.org/netdev/net/c/dddf197f29ba

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


