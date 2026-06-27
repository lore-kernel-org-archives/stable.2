Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B183812DA;
	Sat, 27 Jun 2026 22:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600650; cv=none; b=mMbe9SOKSVkgkAResHjyFHPBtzEgcIEX/pp2hIs902hiIjOWtOEVvdZAt0OcOZcoYe5DjK8ILdjXW6LDLBMlIkC/yTbSlvJa4Ey3dQXPUv7/kQRNybaZeJ8qQpCV9NrYS9j7F0XSJ74xq5jGWK0+rFmmNLswsyczbtbGwIEmMJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600650; c=relaxed/simple;
	bh=C+NG5QQa4hOLhinEOftJWLkyUGE6/PCuJbIe+d6jj88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ghkGmKIermQqgERCa+olj0aJS8ESuT0V7oyQ5PEaSxNkr7X5k9e1elr6tUdmOtyq5v5Di2hHUeixgEhXHdz1d1iV800Yd7dzqN3+3uq9VucPqAQjvkNu4pGdyclrCVMlPtgl/os60kOrnKAPHhMiYzQzKzy1MwJOFwwww6dGFvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lugLdlzx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lugLdlzx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146841F000E9;
	Sat, 27 Jun 2026 22:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600646;
	bh=kZWjOiSImPrfh80sKo7yeGE91rVFd7WvXtigqP3CJC4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lugLdlzxZ9Aosx77zfBgZmZ7ReTImSIcanXbGjA93UdeuxF1rUYqGyWXRMVMR7Ca3
	 gKB46qN+JWKd54frifVcgbS6NqmO9zRXhEIKMBY9CrdRPFyO2+hZy9z11XD6oEdtI+
	 j6rGFrIZ0XpepY+xemRol5xUNrUrOPVFT+pK7kKwseQyow6/1jzE8ZNetQNQEK3Tfi
	 /1JYMhIjZVdLrMlGr/wSU7kqDnT9p3RvS7ArRUZVaVimK6/X4x6BQrIYRWxGozJa6P
	 7V/NufDb3O9YDbdl+huOGaY2Rw/WKZJXA94dD+s4hbc8745RTQQbZfTjPieNVHJW1M
	 duBQj7wPPGpnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198673938452;
	Sat, 27 Jun 2026 22:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netpoll: fix a use-after-free on shutdown path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260063154.1451849.16906699436504289458.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:31 +0000
References: <20260625-netpoll_rcu_fix-v2-1-0748ffac1e98@debian.org>
In-Reply-To: <20260625-netpoll_rcu_fix-v2-1-0748ffac1e98@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, amwang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, vlad.wing@gmail.com,
 asantostc@gmail.com, paulmck@kernel.org, kernel-team@meta.com,
 stable@vger.kernel.org, pavan.chebbi@broadcom.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jun 2026 05:03:18 -0700 you wrote:
> There is a use-after-free error on netpoll, which is clearly detected by
> KASAN.
> 
>       BUG: KASAN: slab-use-after-free in _raw_spin_lock_irqsave+0x3b/0x80
>       Read of size 1 at addr ... by task kworker/9:1
>       Workqueue: events queue_process
>       Call Trace:
>        skb_dequeue+0x1e/0xb0
>        queue_process+0x2c/0x600
>        process_scheduled_works+0x4b6/0x850
>        worker_thread+0x414/0x5a0
>       Allocated by task 242:
>        __netpoll_setup+0x201/0x4a0
>        netpoll_setup+0x249/0x550
>        enabled_store+0x32f/0x380
>       Freed by task 0:
>        kfree+0x1b7/0x540
>        rcu_core+0x3f8/0x7a0
> 
> [...]

Here is the summary with links:
  - [net,v2] netpoll: fix a use-after-free on shutdown path
    https://git.kernel.org/netdev/net/c/45f1458a8501

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


