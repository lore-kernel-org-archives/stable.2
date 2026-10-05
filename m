Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB103AEF34;
	Mon,  5 Oct 2026 23:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791241216; cv=none; b=Ct7SqXik/y5FPzeg75lNrDcxJy4VnJ0udnbvFe0fYj0xa8Al/tCwJD1PkMYcW+8G9/5gc18Ww37bzSLkekY4P9qGCfnS/fpQGa58tSgXLjYP0edkld4W1PvvA0+ZEFZrRkIeTxAk921iliU6TybsNnzup3996wlwYaELe7a50qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791241216; c=relaxed/simple;
	bh=o43liJqJNbFN3+C78wuJlsruteMBju/ohu9rC4ZdoEQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iGIrwlxDfxYKzf0ezh81X0VQKcEaLJbYfAbjBvCorWbKhUJU0wBgZAjmh8ZtqWUn55JEQIDuvkledDobIjiV7l48nUSun4FqlY0ovlyw7q/tFPThc27ckPQ+5SdChIyPHmlHF7pTw3v6x2LfSmvOAT0f+1CjRXniswEqE/Z+2AY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KJrThIUT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJrThIUT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEC841F00898;
	Mon,  5 Oct 2026 23:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791241214;
	bh=+KifzE8OuwlSMxqAzy77ToDN+y0cXJJv9XDlsHSB4jY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=KJrThIUTHmdwImcAqLGIbuaSzAMCYrAAGTSefytylpYUEX5Y4qAROKniCcXU0xSSB
	 CJbwpT6OlaB++wylSBQru7w1/SSNi5GnVIkL6jOZ3PvCBGUPgeJQ2couhnu+m+WdnM
	 0cOwwmXdTGrayOP01NPLKKv5Nf+VcaR0Gzd3IsbnpDXatmhNJAK0+fTfuPb67b6ZtO
	 BGaccjtr+tx2mvvvlfbxPUPM5Nw85X3+IM/26N9jaWqotxg1OvfjxHDIqVf78yhxH6
	 N/fKeXn4M5LIg24HjId5adDc4yk9t47+thFwkTrzymP0Zf1dGsqtT5MiHROxiE+gUu
	 dO6SP6o1T+KNg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B433B3926677;
	Mon,  5 Oct 2026 23:00:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net-sysfs: release queue trackers before allowing
 reuse
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179124121327.1929441.6321889114483475605.git-patchwork-notify@kernel.org>
Date: Mon, 05 Oct 2026 23:00:13 +0000
References: <20260930181106.271547-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260930181106.271547-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, broonie@kernel.org, brauner@kernel.org,
 atenart@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 02:11:06 +0800 you wrote:
> An interrupted sysfs_rtnl_lock() can drop the last kobject reference to a
> removed TX queue without holding RTNL. netdev_queue_release() clears the
> kobject before releasing queue->dev_tracker, allowing the queue to be
> re-added while the old release still needs the shared tracker slot:
> 
>   CPU 0                               CPU 1
>   netdev_queue_release()
>     memset(kobj, 0, sizeof(*kobj))
>                                       netdev_queue_add_kobject()
>                                         state_initialized is clear
>                                         netdev_hold() installs new tracker
>     netdev_put() releases the new tracker
> 
> [...]

Here is the summary with links:
  - [net,v2] net-sysfs: release queue trackers before allowing reuse
    https://git.kernel.org/netdev/net-next/c/a9d60b086944

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


