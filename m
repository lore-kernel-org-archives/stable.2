Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700607;
	b=fMEWjWqqdcuwTTXca1uCxnTz+bReUGhYBOwpWHZCqKYslaQl7HlAvnbA+obpQcWKy3Se
	 ODvmGvK3Cn1GHCLu845E5CA0v7uqCn0u57KPqm0Ut36EASd56t2sv9R6YpI1fO6xzjCaC
	 7nrWWFcQnAtJ8AFnsA/3p8/X3DkbNqMrBND9aHfvO/p+ociLrojtnYIwnpSS8zZL0lFxc
	 F/vxCxq+5oTht6F3gr5oDdHaCdGOrlYBFplxPOHZD2PiBCkzqHzQkJbm8f0hWU1s+ezE3
	 cZ65LpVH/O2VM0QhtmaZfY7XQcvaC7TPGmFL/sTrdODbZm6j7ju1GO4VInmsTVbnOvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700607;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=niugKN3h12HLfTn/26B6Gp5GTK1Zggnm0Tn/6dV20T8=;
	b=rjmcGuVQRbvAFLu5KNn+YX1G/L5US27cFUowYgzZQIlutOnPRaar793j8dkeONObXMd1
	 VTfmYQrf9TuqagtCX7oGSd6HGngO22sod9OsO5dwC1eZjhDE3Z9lKRUj+0Ow0D0qrICD7
	 1qRdcKfYymitZkUL2MyU0qMVDgAkBGHNFA4v1ugzyaXw7nWv8DD5lsY1ThC+h0uDUKHRr
	 GsIU3JKa3PPDNPP2mGC/vp7CyNOgwGl3WkgullDe5VH4QwLN7ZS+XPtuDU8DbCnMnpFTK
	 Ha8fMCdnmP5HHtrHgXOa84JeFuCL10NKMpy7sAu5Q9ZKvvC16Ulj8eXQY2lTXuCdbbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gRm36Duk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34D9A606C56D;
	Tue,  3 Nov 2026 10:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gRm36Duk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F8371F000C1;
	Tue,  3 Nov 2026 10:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793700607;
	bh=niugKN3h12HLfTn/26B6Gp5GTK1Zggnm0Tn/6dV20T8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gRm36Dukz/p0ICOfXF4/susgewgpNZKzMRUTErZz1XR1/jpAP8KLpv/I5XibZYN/E
	 KrgVIDFUWnRN/GnAf3qR5Jiznv231FXrKZKLaaOU545dBknemuXyRs0+HR8ybo+alZ
	 f2mOYGk7IWESkToo/X37567fekDJXZyiub3Q1aPGOK019+BLpu73/Z1lq8tMZXino0
	 JyxVzpF0l8ucHnNG6qyxcVTNFTmeQfdYJDgD4yeoNNPu2oDvABD/t/d4qOdmeWBxJ6
	 977zuRTgr2M76mlDE8l7jqNywJEV0qzqA3Kc52yAj/A4mKB3GsbKCod9PysfGuvhhc
	 Xnrr9ytDHUiZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 030B93805CCE;
	Tue,  3 Nov 2026 10:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/sched: sch_qfq: prevent aggregate
 self-replacement
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179370060580.1006110.9602692459097169277.git-patchwork-notify@kernel.org>
Date: Tue, 03 Nov 2026 10:10:05 +0000
References: <20261029180957.43015-1-david.lee@trailofbits.com>
In-Reply-To: <20261029180957.43015-1-david.lee@trailofbits.com>
To: David Lee <david.lee@trailofbits.com>
Cc: jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, kylebot@openai.com,
 dominik.czarnota@trailofbits.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 29 Oct 2026 14:09:57 -0400 you wrote:
> From: Kyle Zeng <kylebot@openai.com>
> 
> qfq_change_class() snapshots the current aggregate settings while
> holding the qdisc tree lock, but drops the lock before selecting the
> destination aggregate. During that gap, qfq_enqueue() can move the
> class to an aggregate matching the requested settings.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/sched: sch_qfq: prevent aggregate self-replacement
    https://git.kernel.org/netdev/net/c/2e54b3e18730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


