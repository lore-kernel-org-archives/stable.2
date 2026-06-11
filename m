Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E54472D1303;
	Thu, 11 Jun 2026 22:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781217020; cv=none; b=NOir6LvFH/ilhqFhLnoKMRzA+/nCMBwByIAZAEvTPU/NCIlVBzAS5ew3YtJNSN3vaEYY023gwtF3D/mnXtW5g4sWKZdT1XaTed4xBJJ/M1lArUsaGr1L0xUa4K9vvF47Qf84ZyZZpp+1ePpCdobn3Ee1nY7B1pI5q7Ldb3WOoW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781217020; c=relaxed/simple;
	bh=eiT7h/e3FoeYoNZj6W0e0ctH5vKCvLL5rqIVcRkUu48=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gnsacmLzHPnJb2H2HPS29i1WIrzH2qVN4CbMiwEsQzsAOm+HWo6PRFG6RQHg4uctBFNUDbPM/MUS589VbHoRrUW77UHAB2gk6YaYSRbb9crLd4jPntcbzezcOpsIqJYct+fFV7JqT1xyhvWGpsh4jvQeXJKMIHD8kqubNEQhABA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DLwn2qea; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DLwn2qea"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8A901F00A3A;
	Thu, 11 Jun 2026 22:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781217018;
	bh=USld46YDXirMgWtuzZU2ioEbXHi6IBJv4M4nBp60DEE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=DLwn2qeaXXg7Z1JAyX+XncKWYMnsaPSFX6NgnJMygXUq8X0ZJhunG5aABOqSBCFw9
	 4IXenByviZQbHdNzUY3opiA/6+BZS1rRo7/2n0rhMPHvWjYTMQfrbKCm6312F6u7yU
	 g0fv+A2zH71O+elwBnT0BvbvYJ6Q3TfvVV+p6c0c56i+QyvajfxCnhMXJ7SjO8GW+o
	 PymucFWy+T1NbHrFIvRhz+KtHZfEx14uD2MXSShftY1Z/rclZsG/TRlvaKG5gBGhaq
	 gn68oXa/hYzyMiorWq6B6EvC3KAg9NKVXZ/ZstoM9eQDTFrIg+NXWGOM4pSrscp/EU
	 YnkEvOobYSSKQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198FB3930FAD;
	Thu, 11 Jun 2026 22:30:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] 6lowpan: fix NHC entry use-after-free on error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178121701563.389578.2230008630812658511.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jun 2026 22:30:15 +0000
References: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
In-Reply-To: <20260609080054.4541-1-zhaoyz24@mails.tsinghua.edu.cn>
To: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>
Cc: linux-bluetooth@vger.kernel.org, alex.aring@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-wpan@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yangyx22@mails.tsinghua.edu.cn,
 wangao@seu.edu.cn, fengxw06@126.com, qli01@tsinghua.edu.cn,
 xuke@tsinghua.edu.cn, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  9 Jun 2026 16:00:52 +0800 you wrote:
> lowpan_nhc_do_uncompression() looks up an NHC descriptor while holding
> lowpan_nhc_lock.  If the descriptor has no uncompress callback, the error
> path drops the lock before printing nhc->name.
> 
> lowpan_nhc_del() removes descriptors under the same lock and then relies
> on synchronize_net() before the owning module can be unloaded.  That only
> waits for net RX RCU readers.  lowpan_header_decompress() is also exported
> and can be reached from callers that are not necessarily covered by the net
> core RX critical section, for example the Bluetooth 6LoWPAN L2CAP receive
> path.
> 
> [...]

Here is the summary with links:
  - 6lowpan: fix NHC entry use-after-free on error path
    https://git.kernel.org/netdev/net/c/1720db928e5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


