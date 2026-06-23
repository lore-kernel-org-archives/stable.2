Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D174384254;
	Tue, 23 Jun 2026 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782175219; cv=none; b=idDBCjjzKTb4L8Jgws58RwD6i+jXapxPGeih6NzCda3aIpLgcqHlhRkSnsxoXVd7dnd2kGOcnDcbDw5Q4Ycv2hSlqoXAnvCCsKJq9yvuocNWWhp/HRBBYIfKNeZTSdBSrvIchcNAYrYyuYfNWfp7VOhEzSArQFlRbAu5LDiy13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782175219; c=relaxed/simple;
	bh=jR+8piwKKC18zByzQZJ8iz2QHs5Ule5av7qKhfUfMH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f6oS18P4OtEoq175FOnwJY+B+VZ1GCVbDx80tXoFrP80nlJY8cRhj3FsKIuhg3g8Uy1Op2uREgXbUKfe1n3WoBmwqbxs3Q98fgujE/krysnnP0dMBm0qs+hIAvZy8Xy8fkZmiC5j3nz9hIctm1YdrpPpcjglv/oJApPRrJuHQY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjdBRNag; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjdBRNag"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6044F1F000E9;
	Tue, 23 Jun 2026 00:40:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782175217;
	bh=7WwV7C+/RLdDadamoZpqAbgcBr1uPP2MLzfTS8DLY5Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bjdBRNaguj22PXjdacq/w3hYWxHJgbesC81IPiW8FGBjN9WHlCL0PDHIDRjpCrOZj
	 OMUiCwPqFi0UYz1sZPSX2aaGBsl0PRDJdXiymFUTLnsNfobvs6HjWcii1Y/Ghqz5QK
	 WYHlwMxHQ0Gmuh7rZr47pIsAOdoXNnZD3M5QZhVHVCsbmhax7aoPNWYv/S8lr6jL3w
	 kp0SiI+DN6xZg+Gk8mqkxbju9tzoiZgBKi5zpvv3+e9NGvOumh5/QZQ7BYc7ofsY+f
	 va56l+1DMJ655GupUq4KFdQf9lfODVQKX/pAqhLg6JxlTMK7szoY+1XxYFKAb2QdKy
	 VELpMfsq0/S0g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B14393098A;
	Tue, 23 Jun 2026 00:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ethernet: ti: icssg: guard PA stat lookups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217520750.1479120.9274219966916752634.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 00:40:07 +0000
References: <20260618093037.3448858-1-dev@pschenker.ch>
In-Reply-To: <20260618093037.3448858-1-dev@pschenker.ch>
To: Philippe Schenker <dev@pschenker.ch>
Cc: netdev@vger.kernel.org, philippe.schenker@impulsing.ch, horms@kernel.org,
 danishanwar@ti.com, rogerq@kernel.org, linux-arm-kernel@lists.infradead.org,
 stable@vger.kernel.org, andrew+netdev@lunn.ch, devnexen@gmail.com,
 davem@davemloft.net, edumazet@google.com, jacob.e.keller@intel.com,
 kuba@kernel.org, haokexin@gmail.com, m-malladi@ti.com, pabeni@redhat.com,
 vadim.fedorenko@linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 18 Jun 2026 11:30:24 +0200 you wrote:
> From: Philippe Schenker <philippe.schenker@impulsing.ch>
> 
> icssg_ndo_get_stats64() unconditionally calls emac_get_stat_by_name()
> with FW PA stat names regardless of whether the PA stats block is
> present on the hardware.  emac_get_stat_by_name() already guards the
> PA stats lookup with `if (emac->prueth->pa_stats)`; when that pointer
> is NULL the lookup falls through to netdev_err() and returns -EINVAL.
> Because ndo_get_stats64 is polled regularly by the networking stack
> this produces thousands of log entries of the form:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ethernet: ti: icssg: guard PA stat lookups
    https://git.kernel.org/netdev/net/c/27b9daba5060

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


