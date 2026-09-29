Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18EF14EF12C;
	Tue, 29 Sep 2026 09:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790673626; cv=none; b=em+JY1rrbJkyx7wwmDyJZohFMxlYkFFDLS50kn65vsB32Bp56urTuagSdaHaDEsGj3wRGxPq0+GAqUhFTIVe+pEwNH9GrH2EsTEwJF2gr624RA+q8zYNt4vKEQvDGwY4DipqbUeSAgJZzeYNNlsxfNKWJQOtxTRL+HYZNIIAIUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790673626; c=relaxed/simple;
	bh=Cz5J5hXOTvxxa6sIV1oRjYwI9oS2uYhgmM0bjjSvJ84=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YwHrc8e4WagCojFziclD156Lu+QZk1tlPsSaNKu0M4ID7UCvGiRIJPxXbCmlYSo0uo4+iNyGp7Ts/GL3q6WeGi5/53fkbkUouP99B49W4e6SXKC9PkkiAkWXBXL6SkQimWXQSl2iv6ifojjiRthQ9lsnYU+e8wHGpVCjLPZFUCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=THYGCLfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="THYGCLfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F9761F000FF;
	Tue, 29 Sep 2026 09:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790673606;
	bh=I5hZb6guvoipS9HtAUx481YfbXCPGSCJ/SNKLBEhgo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=THYGCLfEoufO1vJxRiTE6D634vgWS8OOEPrFdv3JWBnvCGAHwg5rYc03lM+ER9LL0
	 a5t/8JHWdepyUA2t1V/1E9HhCseubmcKGBAb4leXmTCEUY/6aBGXRPO12Us8qxSnlH
	 LwfWjnYSwG901ryiNZOfhQXcTPS9IK3nrR7XXrcsLml/UzyiJM5ao6OSXhy1SvozsU
	 NPgZjX18HqdJg4rYyYyv+GRPeHa8AU9U1hHFGHmErGXMcSJ/OUDwkquVSBspyTJ69l
	 3UsuHcXE0+WbVcRzKbaNj4vaW9Qz6IJ+V98vZVWmaO5H5rNmfD4Hx6NJGuqz8yZxOL
	 Xo1F1xXSMNPSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774193926393;
	Tue, 29 Sep 2026 09:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] pfcp: fix socket lifetime on netdevice
 registration
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179067360528.377252.5580728114357524841.git-patchwork-notify@kernel.org>
Date: Tue, 29 Sep 2026 09:20:05 +0000
References: <20260924055252.33488-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260924055252.33488-1-xuanqiang.luo@linux.dev>
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, horms@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 aleksander.lobakin@intel.com, wojciech.drewek@intel.com,
 marcin.szycik@linux.intel.com, linux-kernel@vger.kernel.org,
 xuanqiang.luo@kylinos.cn, stable@vger.kernel.org, luoxuanqiang@kylinos.cn

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 24 Sep 2026 13:52:52 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> pfcp_newlink() creates the UDP socket before register_netdevice().
> If registration fails after pfcp_dev_init() succeeds, the core calls
> pfcp_dev_uninit(), which releases the socket and clears pfcp->sk.
> The newlink error path then releases it again, causing a NULL pointer
> dereference. This was observed with failslab fault injection:
> 
> [...]

Here is the summary with links:
  - [net,v2] pfcp: fix socket lifetime on netdevice registration failure
    https://git.kernel.org/netdev/net/c/0f17d2e3dd9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


