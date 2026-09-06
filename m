Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D681F23A99F;
	Sun,  6 Sep 2026 14:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788705068; cv=none; b=H6OHCiNgJR1d9MP367SecSc7dNMM+wXZplwBSNhfH9bLObTQYvDpwrwZIEwxYF5+8FEhohMV7PQnBMXk3UHc727fQpuGVJoU/zE1LJb8Z8iUbRX5YqAnihgif1aNh1V2UOb+dSCyXfeUAOdD6S7hNjur/WVkr9u2AiBqETERDNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788705068; c=relaxed/simple;
	bh=CzhtNfqSn7y+zPaqaPdGpILPjs+gdDH/tfxu790fchE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KQYEI++UqBvLWaJhFeSF9ZuGJg39zeXmSg6CvhfYPMuKc8dNLPpgLJJ3hZXQt5C2PmnpAlp+8BhRJOFTd1tfeLfOeXtoO9D83xCt/VxTBRZkYK3c4Z+v5lfZHupfkT+vbIXdaa1ZZO+bmveIXMcGAH6aUL3mJi1edf4AP/nFdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LDdpf3v9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LDdpf3v9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E30C1F00A3D;
	Sun,  6 Sep 2026 14:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788705067;
	bh=tna64wOLyHrKxDUvqiaZj8paqxCRPkRUaREiyzKay5c=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=LDdpf3v9L5C/S6o7KcdZMvwHFdAGWUnDmsFMEFjbTRZ1BLw7YOXhH8uavnwRr4zad
	 PX7EmghOYn59ZUn+FyRQdDeN6AqsVHgVIGwNJBN/w3RpVj/TtJdJsvXhCsD/wW4TAO
	 /38HrNktkTtwXLEsvVMnjIFSRTcGGFmpWM7YfCgL/cElTWDzCIkNQ6c0ALjjhKWndT
	 h4zWPBjQTPFyyVJGsTU+EyGv4HklxKxbzfh747kWXJTpB93gQX/jS+CJBWUJx6PGwk
	 og5R5AASz+pNnxjsOhvSvUNwd5tgBPioZEFxOtYgcJWs0a2+ItTnZBK76jqLvkiynU
	 9HRJ4bNlZO36w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A5E39253F7;
	Sun,  6 Sep 2026 14:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf, riscv: Make arena support depend on ZACAS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178870500689.1578634.17690662717423907051.git-patchwork-notify@kernel.org>
Date: Sun, 06 Sep 2026 14:30:06 +0000
References: <20260902061451.1416-1-cp0613@linux.alibaba.com>
In-Reply-To: <20260902061451.1416-1-cp0613@linux.alibaba.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com,
 bjorn@kernel.org, puranjay@kernel.org, ihor.solodrai@linux.dev,
 eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, jolsa@kernel.org, emil@etsalapatis.com,
 pulehui@huawei.com, pjw@kernel.org, palmer@dabbelt.com, guoren@kernel.org,
 bpf@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Wed,  2 Sep 2026 14:14:51 +0800 you wrote:
> The arena range tree allocates its nodes with kmalloc_nolock() since
> commit f8c67d8550ee ("bpf: Use kmalloc_nolock() in range tree").
> kmalloc_nolock() requires slab caches with cmpxchg128 support
> (__CMPXCHG_DOUBLE); on riscv cmpxchg128 is provided by the ZACAS
> extension. On systems without ZACAS every arena map creation fails
> with a misleading -ENOMEM.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf, riscv: Make arena support depend on ZACAS
    https://git.kernel.org/bpf/bpf/c/536b523b4073

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


