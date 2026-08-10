Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A747348C4C;
	Mon, 10 Aug 2026 23:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786404058; cv=none; b=Owrf4oxqDOLhH7ECcVmnW7LjV75NXdg6/oxrdVGWkk1yUPD1pJaSCADSi5vPKzlxuNMvW34WmhlxhmBlKFuT84PFgdzU1PACNP1xgF9fQcfTlgMjrmhO5Y5lMyYnm1ZdN9JE5Hz2DuFE2TdqUEnO720C24xqvBR5hCLkeE49yGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786404058; c=relaxed/simple;
	bh=6yuPPZ6jW0C9JFmsxsgYyLuUjc5F6JFWVY2EpnI4MFM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DR/pN1CRWxb6zxgtCI2iA4Ek2P+yHgIyH1dLA1jg+0UAFdQx1Us4sPlCxdxXjnEq6Y+CM/qpZ2Fkd6xy/3aEeea4n+QhedPTcXEo1fUMEOcxeTXQ0IJ3H1zqeRR/wAr/FXsoVwTkU41mYk1U2sYsZHAFNWZpnPmDk5nTttwem7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4q0LoUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4q0LoUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5450A1F000E9;
	Mon, 10 Aug 2026 23:20:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786404057;
	bh=8IPFPqxafpQbjQyrDeppqoUbU9mgf+5Nu0nFh7KSTWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Y4q0LoUSedcGZWjMG+lYOmPUrUks+Box/Q8RUltQeHCcT/O0jbqGMfE5Ru+LD9BEp
	 L49C9xDkGpZHddoDD8FUZrtQ/pf6tbk8okMSLYYUzikdt0IpPJGxSBkSdrlUJIqRJD
	 fREyBkl0mZyZc+JOpdLMkp4dO0nu3A0GIePfPQ1JaklyHq8yeunHI/v4R5xSGX+/tJ
	 elNgOlr1IKlQEEocsWlXEk+zl3LhvanhTvQNO4C06yAnqcPwnX4+fTpEUENfg8y9Y7
	 C0RmcGCFTcPQmW+Ix04o96BTzizmWhooXvz4xXieqqVXlB8yqm9C3wo8pRPuWFhiat
	 4uxM0TzK1FHEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19905392626C;
	Mon, 10 Aug 2026 23:20:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: expect instance lock in
 netdev_queue_get_dma_dev()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178640401364.250217.82789217556428963.git-patchwork-notify@kernel.org>
Date: Mon, 10 Aug 2026 23:20:13 +0000
References: <20260806225627.3998672-1-kuba@kernel.org>
In-Reply-To: <20260806225627.3998672-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 stable@vger.kernel.org,
 syzbot+a78926bdac2adb52dc0e@syzkaller.appspotmail.com, axboe@kernel.dk,
 io-uring@vger.kernel.org, asml.silence@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Aug 2026 15:56:26 -0700 you wrote:
> netdev_queue_get_dma_dev() uses "compat" locking assert which wants
> either the rtnl_lock or netdev instance lock. This is not right,
> the callers are taking the instance lock unconditionally. All entry
> points for queue config are purely instance locked.
> 
> In other words the callers use netdev_get_by_index_lock(), not
> netdev_get_by_index_lock_ops_compat(). All the state we will
> access is effectively instance lock protected (it's const for
> devices which are not ops-locked).
> 
> [...]

Here is the summary with links:
  - [net] net: expect instance lock in netdev_queue_get_dma_dev()
    https://git.kernel.org/netdev/net/c/92465f46f3c3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


