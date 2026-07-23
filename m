Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFB47D448;
	Thu, 23 Jul 2026 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784828445; cv=none; b=CELAgOyoZOSSXuFSjee6wsCOGwvndwYUnuOBDW6eKgifJvM50nOQRIGKaN8B/7wmXqn9idoRinCSjJzZdCKMCx1mRBi5lU83c0dImlfsrrEZ2U5LmOD6oTGDsRvHLvO5S3zGLJVWMv50PGA/vbGI42nMl9sxW+FJlG0TiD/qnHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784828445; c=relaxed/simple;
	bh=YNfm8hZl2b/NKJKpWmMhe1wgEsUpRbnanwOw75XkVvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mz+SR4GZjcQSe9Ko5kN2UQKEpAd9GuHXXq2zT/GlvrF7Xq0dvr6SJjndDrVIjc3jbaHAP7xOo0MAIIOZftDF+DnYAU9N/8inv/gySP7NiApLIiUV2NDjC9YOaOkGaX9Xdlx2Be8wsbwSyQK2Q5t//7+qkOqvAEVVr90ddbCw2OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwJKEcAs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cwJKEcAs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E69E71F00A3A;
	Thu, 23 Jul 2026 17:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784828440;
	bh=OrXvV0qF0Jj37tCljb6zqgeFqTaRxTIDpWTIiD0NyMI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=cwJKEcAsBFowyKrxDzXZLaUo1X/ZeX030GBsj+nOMMz8jUC189I8i2BkqZ6wQjAMq
	 8z6PH1yJp4ZL0XPnQSOTTVuDMFX/s6J8TJ116Z975oI9aB9ftGrIzNYig/YCts49HP
	 G+UsNkzB96B3Uq/1OaYM9xBno7oHBxr5buby2F4PtvNtVjygrShXm6YRD51oWrauTk
	 QBtlDD19yGktD/agDTvk6UAetDxexyMMPfWiCCPDnhPmaGvimnhZlnJfOqN+WbFwVG
	 s1g7vIkayV0TejrsWgxj0kn1oRJeBH8Os1DKxFMDGtafKMZzAWgmZKV4nOiRmdVwhg
	 OEzdfFaB/kA4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3484B39244CA;
	Thu, 23 Jul 2026 17:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] mac802154: hold an interface reference across the
 scan
 worker
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178482840899.2802214.3672009527883372357.git-patchwork-notify@kernel.org>
Date: Thu, 23 Jul 2026 17:40:08 +0000
References: <20260721211228.34578-1-security@auditcode.ai>
In-Reply-To: <20260721211228.34578-1-security@auditcode.ai>
To: Ibrahim Hashimov <security@auditcode.ai>
Cc: alex.aring@gmail.com, miquel.raynal@bootlin.com,
 stefan@datenfreihafen.org, kuba@kernel.org, linux-wpan@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Jul 2026 23:12:28 +0200 you wrote:
> mac802154_scan_worker() captures the scanning sub-interface under RCU
> and then keeps dereferencing sdata->dev after rcu_read_unlock() and
> outside the rtnl -- in the failure traces, in
> mac802154_transmit_beacon_req() (skb->dev = sdata->dev), and in the
> end_scan cleanup. Nothing keeps that netdev alive across the worker
> iteration.
> 
> [...]

Here is the summary with links:
  - [net,v3] mac802154: hold an interface reference across the scan worker
    https://git.kernel.org/netdev/net/c/234e5e898b71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


