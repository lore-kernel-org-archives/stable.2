Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340D1418365;
	Mon,  5 Oct 2026 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791239408; cv=none; b=g+y+3uWySFv2jgCQwyM2eXcmpqRL+MbhnYprHDJ4G93mvdq1XnfFmgCV1MxgZiVV09Elj1imiUV2q7hBxhs5/gcPm021tpL3NvbZxxsgGFc3lo3AT3jCU+wzyhYwsCkh486C9cWpwy/IITvkbJsLFwP+YNa5LmlVSiP96jDNmHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791239408; c=relaxed/simple;
	bh=66+mYwg8x26Nbax05dCHN+lnk2sJ3fluJfsi+4jWwjI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VTSaNJ2a5CWfe1Lz9wBaa4XhhSgYoqW/Lw8Oepm9af0li5x1hlrypgL/YBO06vS7wB26QYK+coXh/INNe7o8qDrUOqsx3ZDA7OlSiYORTZvtg0CwVTkiSX/T02Vah3P8+1MyNMmju2eMxAFSZ+lKMD6rcIxWMB68Qnszo0naf9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WxRCWgR6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WxRCWgR6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8336F1F00893;
	Mon,  5 Oct 2026 22:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791239406;
	bh=IakaSmsvRMiEtwvqJc+Xi4lnGJTyc2wyd++QcK2x4/c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=WxRCWgR6WluGuLJzLM6qPtOJHb2LWs1YTG3yiG3fG1tjUgYA/IpKOe0eGwd3MXdKn
	 twAmPPh0iP68T7MENKn0o9eBeAvllh4lHaGVHU87sYM7HtoS8iOUcLeP0natEoQO/+
	 bofv78zmBPByvqCuCM4ebxnHxMDimfsFlDpF34pgDisHUUMuRLVWjyFjTDpIQ3jSam
	 HUdGZqkHHBxM1q1MkDkgWnEwQ9FONZviWvGIe38Pu5SNaYnCZ8Xq78eVI8uQNDXTQr
	 C/vRlSlYDicHTdD8t3++2wdznY6i69ko/ntYlLRk23/6mY+jDA3pECwKzmmiwORZrS
	 YLgiMM0WyVuPg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773953926672;
	Mon,  5 Oct 2026 22:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] rtnetlink: wait for RCU readers in
 rtnl_link_unregister()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179123940528.1920004.6228673079027005154.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 22:30:05 +0000
References: <20261001143040.28467-1-parri.andrea@gmail.com>
In-Reply-To: <20261001143040.28467-1-parri.andrea@gmail.com>
To: Andrea Parri <parri.andrea@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, kuniyu@google.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 16:30:39 +0200 you wrote:
> rtnl_link_ops_get() finds ops on link_ops under rcu_read_lock() and only
> then takes ops->srcu. rtnl_link_unregister() unlinks ops, then calls
> synchronize_srcu() and cleanup_srcu_struct() without first waiting for
> RCU readers. A reader that found ops before list_del_rcu() and has not yet
> taken ops->srcu is not waited for.
> 
> Such a reader then locks a cleaned-up srcu_struct and keeps using ops
> after the module that owns it is gone. rtnl_newlink() and
> rtnl_dump_ifinfo() both look up ops without RTNL, the latter for any
> user that dumps links filtered by kind.
> 
> [...]

Here is the summary with links:
  - [net,v2] rtnetlink: wait for RCU readers in rtnl_link_unregister()
    https://git.kernel.org/netdev/net-next/c/3b70edea393d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


