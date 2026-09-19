Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3738133BBCD;
	Sat, 19 Sep 2026 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789860675; cv=none; b=SiIBKE3HQxlnUXW+PuwKRVhkuElvsuUN1XtWIwM0OvUkyZvcXDEVJ+nSsfn5o5z1vGhrnqLUSRDIJI0EmDd9l5eHry39LkQjLvZNQx6JqUIYIeYYmdboTkBNMXB1Ux5xT1oZajYVyNNxl5x/pvC4wTQVoHCJKf67Ir0LE/k8dj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789860675; c=relaxed/simple;
	bh=Uc6riLnBz5+J8dYqDHj3zzGSsYAXRgnidFsH6sDHDE4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hLTqXXU+w9B0ppDANn+FJkhbpKCM/NCRSOWECVmuHiMYH8MLz2SzeaExq2yPtWuwbexzJovYX0oxI98QXTHoZiQklfjKVg7oSboMJjr6wH31rdb0RP4nhYL8F4A8rR0mumiPEhkMa1NQ6QiZGXPOVCU6VJ89Ih6GUShyCkKN2fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNE8Q2Sf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNE8Q2Sf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A1A1F000FF;
	Sat, 19 Sep 2026 23:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789860673;
	bh=TXB54+NWb8Funxwz7w7i+S5lnrzAQ9Mim6+8OjJPVgw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lNE8Q2SfZ+0fSu4KbAWRLsD0luqqtvqmPXzdnLR8GaGC9O14PEfliQ2N9rHDARSa+
	 algKbc4YGwUbib7Yl8k2FxqYNF19ZG6yAP8GqPS4ol1+WRVdOwj6hw6FhHUz+9oDep
	 BqNJ2BqwmUghHN7ULQBSxN/69Ttoiy0njq+9kgWm6Lm31az25qhdvo72iGkx5aw02V
	 VtlVuAsMYWybhtMTeC08ZtkWwOGQnNgkO23bbQlXXpU0LzbXHIwDZp4n+xQaEJmpyR
	 kLk26OYqip3KObvJEsBuILxljvHYHZffXnRbaKERH1MEVQyqCNJtuvT7vaQB4n9/4Z
	 702EpTDSCgf4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569DB392447F;
	Sat, 19 Sep 2026 23:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf 0/1] bpf: crypto: check params size before reading
 reserved fields
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178986060614.1492995.17864006434061147722.git-patchwork-notify@kernel.org>
Date: Sat, 19 Sep 2026 23:30:06 +0000
References: <cover.1789802413.git.xuyuqiabc@gmail.com>
In-Reply-To: <cover.1789802413.git.xuyuqiabc@gmail.com>
To: Yuqi Xu <xuyuqiabc@gmail.com>
Cc: bpf@vger.kernel.org, vadim.fedorenko@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com,
 martin.lau@linux.dev, song@kernel.org, yonghong.song@linux.dev,
 jolsa@kernel.org, emil@etsalapatis.com, ihor.solodrai@linux.dev,
 stable@vger.kernel.org, vega@nebusec.ai, weir@nebusec.ai, xuyq21@lenovo.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Sat, 19 Sep 2026 16:45:01 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in kernel/bpf/crypto.c.  The reproducer
> below runs as root because loading a BPF_PROG_TYPE_SYSCALL program is
> gated by bpf_capable(), so a user namespace is not sufficient.
> 
> We've tested it, and it should not affect any other functionality.
> 
> [...]

Here is the summary with links:
  - [bpf,1/1] bpf: crypto: check params size before reading reserved fields
    https://git.kernel.org/bpf/bpf/c/a11212910cf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


