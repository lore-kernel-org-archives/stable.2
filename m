Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC6145B27;
	Wed,  7 Oct 2026 01:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791336607; cv=none; b=unct04fcJirv94isCot6yCB/s+zJtSvF6CeLqaX3fsUC/rfUpx3Nh/rCCLcBFJlDkD5f+ORkJUP1raESmfDQYDi2bfcP5jgc/o4W67EvIVL279aoBU4OvXfTtZgGTf8O2rspaTnbkplkZI12D5qO0yaaOBab/nm+bRGUq4cG1/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791336607; c=relaxed/simple;
	bh=ahygckC5FaOdVaE44k1lagRoxk0oCnwx30CF8Dl6BUc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UIzNxjJHIOPhsoCI8qoqJ32Hc81mS1Iqy6blAaUduZ5nL5B+d2DVebn3t+UlgpEdL3D73VLAREUCoudXEJtfj2ZKK5anIG2WzFJ4l4ApeXJz6UA+SoBV80Kjks+qo09xH1g5WzALM5sivGCQWuf5YP62r9ZdRcnGYu7ybColqoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cf4morXZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cf4morXZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FB341F0089B;
	Wed,  7 Oct 2026 01:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791336606;
	bh=awJeGQram6SRjFfk8HbLvQpyIqW2EVj8fUl9tSRvlQk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Cf4morXZbdu6uTiKbzOmOzyQemZK6XG0SnYkqqh8u3HHzvzaiUSnN+6DyubaTePfc
	 uXVsEEwXneia2Ggm/DMLNnQ3uJ3EJAnLTf5rdYi7uzSdO9gGnK5K+uj7KWqP44O1Ll
	 aedwKXH67xNfJeZWccaNrmTkmo3FTdDSt7gohMXnQcD9Ern3wvU/QqhZkmJaIHjaU3
	 3WsyNR7wTSKEZVki04CYCCD/6jbGAUEvS4Ja5HEwWCvPjYnY9tpEi1GDL7UTM7LWlK
	 HwT1mQqbG2Iahc7fYlPaFSLiaPi/yqPaiYVoLb3qe3/iFoYzTgRxPC6ZPd7jCgXX5L
	 Qa9lBeb/8ihAQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 773413806541;
	Wed,  7 Oct 2026 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] strparser: make sure __strp_recv isn't running
 before
 tearing down the parser
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133660529.2858290.6732628309915462102.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 01:30:05 +0000
References: 
 <425d9d926709b542ed5331110c19fee4aee1f28d.1791206940.git.sd@queasysnail.net>
In-Reply-To: 
 <425d9d926709b542ed5331110c19fee4aee1f28d.1791206940.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, imv4bel@gmail.com, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 15:50:02 +0200 you wrote:
> The comment above strp_done() claims that if strp is stopped,
> strp_recv will no longer be called. That's only true if the caller has
> a mechanism (eg locking) to guarantee that strp_recv() calls that
> started before strp_stop() have completed by the time we call
> strp_done().
> 
> This adds a dummy lock_sock/release_sock pair to guarantee that any
> in-flight strp_recv() (which runs under either bh_lock_sock or
> lock_sock, depending if it's called from ->sk_data_ready or strp_work)
> has completed.
> 
> [...]

Here is the summary with links:
  - [net,v3] strparser: make sure __strp_recv isn't running before tearing down the parser
    https://git.kernel.org/netdev/net/c/0984ebc63179

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


