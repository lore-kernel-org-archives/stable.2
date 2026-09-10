Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E7762DEA68;
	Thu, 10 Sep 2026 01:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002068; cv=none; b=ruvpw0BbFWGkAKV3FZ5utL9hdbzFOPKNyYLqHVCRTOHr5H6kOnNrkTkBrkmDOuGC0eTs5P4Sz1GKnoLVM9Tt6hS+2df2/KaDoD8zvqI/x09aCT09xAovo33LGx/2Hx/ImnyrV791P4Ekz9ifQMC+snNVX1D8hFDij6zMASl3IFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002068; c=relaxed/simple;
	bh=47w4npGG1jEzm5hqVY6kVRdow4PK0LNqZSQJWWsPKs8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tn1pSx2JdzITpsjsy/ng+U5eHy+26PjQDgr06PaPx6OwK+bajPBCL/zmADJ3EAnFuQaYjs77rWwUtMtB5nuxzIarnHA57XGUnrqNRBGL1h7GJP9T8WiIUcXay6pIjpoozb9WRTRw+sbmC1cGVfdFNHUHsGbFMK3vt8LePo4Ybpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ks20I6eg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ks20I6eg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120D61F000FF;
	Thu, 10 Sep 2026 01:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002067;
	bh=upRWXKOW6qsi8qG5/lmOvkNZDGI2QbB1gMMJxCDp9qA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ks20I6egi5D62y5+qJ4JXZ3lCRmjKxiP0omGiFx1PcOUDl/1zCSxD+7AOKE/cF776
	 R+FPMXjb6cckRuafXdCGiMLTIUSJo/RnQzfuSjjHXHr+rsuujRCkSMK4OC7HM6tbCV
	 z1wV6pr/hCyODqnnnd7cV/9cWYf1hFFfARZa96p1h7IWjtyx1nxEIktfJ9eU8L1cPk
	 qoXHkBcTJzAg4WbUwFC7hHdb39f4TSQcAmvmowp88yK4PLcJHg24YhAr+FkhkWO+lI
	 2ZjNLLAsxBj7zoHBk62opAds3CKwwReQ9aCUORcm9AmFGpTcpz2cNOwwHuCcQQsqxJ
	 iXgvmpth3KLrg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198A1380CEC5;
	Thu, 10 Sep 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] inet: frags: invalidate queues before flushing them
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900200463.1131357.2032127339947818719.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:00:04 +0000
References: <20260904162800.1095662-1-yilinzhang@moonshot.ai>
In-Reply-To: <20260904162800.1095662-1-yilinzhang@moonshot.ai>
To: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 bug-report@moonshot.ai, shiweiming@moonshot.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 00:28:00 +0800 you wrote:
> fqdir_pre_exit() flushes the skbs from incomplete queues without
> changing their completion state. A fragment which found a queue before
> high_thresh was cleared can then acquire the queue lock and reuse stale
> reassembly metadata. A queue concurrently killed after fqdir->dead is
> set can instead become INET_FRAG_COMPLETE|INET_FRAG_HASH_DEAD while
> still holding its old skbs; skipping it because it is complete leaves
> those references behind until asynchronous fqdir teardown.
> 
> [...]

Here is the summary with links:
  - [v2] inet: frags: invalidate queues before flushing them
    https://git.kernel.org/netdev/net/c/b824476c56a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


