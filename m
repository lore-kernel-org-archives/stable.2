Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FD18BBAE;
	Sun,  5 Jul 2026 07:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783235428; cv=none; b=tNG4TDkN2ax7nuR5j97e4YUV9pzeb7fi0/GJNKWIsqYIfgi0ATTvTswPm3KoCA3+YTC8k2Q70HQ5tSHdbeV0Rg8bs1ySaTIMbgpUB+8m6Lz6vaMMvu+Swiqc5+XU2w+oET1KJhiBsJvi5NvY0YAB0D9Ji5uMS+3pvS0vHeRndek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783235428; c=relaxed/simple;
	bh=lUzCzUI4dD1yXFU4jZ83WN0tPnOkGUz2pjoRIq8EFrk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dHiFNOE+1IemZOthUvy/IU/tX9XeXZW8V4Ouj4lm/SyDBjTLhYFSUcHLxgDXb0IZ9RJvlE1JduxaB7F91efkpoZG4NfvsKfMHG72VPbRDYkC21K8BBjwYt3fsnxI2mjpWjeI/0ufmyza0gWojqf3Z2MnRI+l1T13Zxu6cKI02Ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzW+ry2e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzW+ry2e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCFB01F000E9;
	Sun,  5 Jul 2026 07:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783235426;
	bh=yLqt6XvlOd9pDIhAXizheEtnZmuRGlHag0r5a930MTM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=SzW+ry2ePCYbOP2bavxU6ErlOYWH6qqf4Yr5oizEVjoE1xayupy4EU5rOQRh+vFa9
	 cVt+dHgzOn4H5nJi/4FM3NmlXqqzfD0cg5n/IPidvM9i2XH2szNGIdHExLNHFz8FtN
	 N4CzE2BEIVGZmrJFcDkPP92+2OiPXsDdQYiPCS1t3g+IWHZITMWAS1w478kaGxceKp
	 sNOWGF24AmOHER0HXLjQdaF04Si69zPfo+ebsDA5LHBLNBFK/uvU38DDZoNktuMiZj
	 e4pEQxC2pUhfgEY5HgMFGVc7b7dsPK4he8rr0pIl39X+VnOK4xacYVLvMGIW7e82ze
	 q6iiOWi54iQGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56894393A94F;
	Sun,  5 Jul 2026 07:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] llc: fix SAP refcount leak in llc_ui_autobind()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178323540814.3748336.3025291993654697174.git-patchwork-notify@kernel.org>
Date: Sun, 05 Jul 2026 07:10:08 +0000
References: <20260630194856.1036497-1-shuangpeng.kernel@gmail.com>
In-Reply-To: <20260630194856.1036497-1-shuangpeng.kernel@gmail.com>
To: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 15:48:56 -0400 you wrote:
> llc_ui_autobind() opens a SAP after choosing a dynamic LSAP.
> llc_sap_open() returns a reference owned by the caller, and
> llc_sap_add_socket() takes a second reference for the socket's
> membership in the SAP hash tables.
> 
> llc_ui_bind() drops the caller's reference after adding the socket,
> but llc_ui_autobind() keeps it. When the socket is closed,
> llc_sap_remove_socket() releases only the socket reference, leaving
> the SAP on llc_sap_list with sk_count == 0.
> 
> [...]

Here is the summary with links:
  - [net] llc: fix SAP refcount leak in llc_ui_autobind()
    https://git.kernel.org/netdev/net/c/660667cd4066

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


