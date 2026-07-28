Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E12C29B776;
	Tue, 28 Jul 2026 11:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785238242; cv=none; b=q5bP21BhtX8n0Vbvye5H9apW2UqGUW9vNkmcoRjZJXAMWEtV4n8AhCcO5gu0t0m9ZaFMJzIP9z+FTpJx/9PY310Ag3zegMm/xa341JfhFJfmrcQbWPLzmp+1Dl0B12N5HyDI2EYKbaGx9EBRuVzuBF1TOCqacMkktTQfWW7i7N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785238242; c=relaxed/simple;
	bh=Pqjtp9PwERB+gD9g1Dy2sg2LURgkEgwmaaYOJeyVfSQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RBp7cFbwJVHkhFwE142fyUxy+m+r2uj1zoNxhWwGojI5T/Od3VaRxPwIcuiMSYtL/VvyzAWh7jRegkuMNMgdm+hqjHQD7umzKCp9wsDEkPAElIZgZAHNJxY5aqbglpAhceSBqStI46wESxid983iU+rIiyV7tTguHazgtdpYKG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MEV15YOY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MEV15YOY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAFF1F000E9;
	Tue, 28 Jul 2026 11:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785238241;
	bh=/iJKmU0xlDly44THjFsufyWLfPwdlzxcUQVLyLlXWXs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MEV15YOYOImjQ0tNHuSORRrbnoEAd9w9leU+KzhhLM7CI+6qp1FxNdPTyoyyu1Aj9
	 qbdphxkhE6brgoD3uxwQ+pwGnT1HvZ+F9axxHoEAJMhjq8OXD61YMONUVU3geR3IqR
	 yKc7SRuFUQS9LqQWs///WDO5HDiTiKHS3JgvJ7gQHyclImmq4IFc2c6eEhr6dmliR4
	 fvMXhEKMgteu93vpNamm2gw5cUvhlaD+nQLVwIXOo++uVu3Fhk91WLBquyv93rUl1q
	 FJCFGaX88dwv8/FbfNL5UgnrOW9ku6+g7zotXaCSTIAeD9/Lv2hT3GogROzd9z8KvZ
	 mppt5NX29EzJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 568BF380CEC4;
	Tue, 28 Jul 2026 11:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v1] bpf: lwt: Fix dst reference leak on reroute
 failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178523820589.1686123.3080651446763119610.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jul 2026 11:30:05 +0000
References: <20260723060445.21926-1-xuanqiang.luo@linux.dev>
In-Reply-To: <20260723060445.21926-1-xuanqiang.luo@linux.dev>
To: luoxuanqiang <xuanqiang.luo@linux.dev>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, daniel@iogearbox.net, ast@kernel.org,
 martin.lau@kernel.org, posk@google.com, luoxuanqiang@kylinos.cn,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 23 Jul 2026 14:04:45 +0800 you wrote:
> From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
> 
> bpf_lwt_xmit_reroute() obtains a referenced dst from the route
> lookup. When skb_cow_head() fails before that dst is installed on the
> skb, the error path only frees the skb. The skb still owns its previous
> dst, so the newly looked up dst reference is leaked.
> 
> [...]

Here is the summary with links:
  - [net,v1] bpf: lwt: Fix dst reference leak on reroute failure
    https://git.kernel.org/netdev/net/c/88c17de85ddb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


