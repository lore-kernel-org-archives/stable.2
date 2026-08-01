Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C3035FF5B;
	Sat,  1 Aug 2026 16:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785601849; cv=none; b=ADij3LDFAM8Sgzg3xLP0LK04gJpAmG/Lh0b+0nUj4Fjz6tSHZ4lCab0KBBGamHtqRUeo1LFk9Z1C8kvNF5sRAljrPAjnYqJ1BdYWMlIXzKvnW9lP5UjnKCtRVqlfZ9Wkxb8VMP/u9eww/6mH3tOxMwPX16Q08sDa/kMWZu6Ggj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785601849; c=relaxed/simple;
	bh=THHf2s6f5M8yK6sLlDQb+HUJUiFIsn5iaRWa8TfPhkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R5XWmhgaAEIbHzoI+60uYZWc4OH0H/r6CwCwRqx2LN8tYN6IKz9asAWl/vW1qhELj9AU5nuEtyPn80Y4MqAFI4M3G3muYHGQRoe3LkAKtOJtgNXu4LWkHBbZx7mtOYamaaPfUnlFg3uDuNmbENzafu8YeKx2RB9MGNOoR27VWrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MyMJehsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MyMJehsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92CB21F00AC4;
	Sat,  1 Aug 2026 16:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785601847;
	bh=reVMyis/q1AokOK9scuNdV1PzAtIyRQUGuR/xq03Gm8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MyMJehsDvhRgFH93WT1kSL+W0qCaIzo6mAifxrybOdTqB1HFKYwcNHJR7T4LOQCCL
	 M9BfwAi0f7QEZXgLm/S8m0EQ5LgqTw0mk3Zxrr6/XPt8qKCsp1p2ZESljWzLwjbEVJ
	 dnWowZXxwlmcGecQ13y+HQ1Usp50BL7iPCadEtr1hHJ7YpTwY0aKWg1zKfnE9nrqHz
	 sW8lVBmROrs6O4s/21OrBWCHyFIChSAMIN/O7Xmbc6+HRO3pZlFYlsFpScv2b6k3ls
	 Ps/XvZqcVcG/kbiKb/1QRcGhVwNtv2/en6X2KRn1SAn40X07LiDVo9Hz1PrLwGov3h
	 xUICmfsXGY6ug==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199C1380820D;
	Sat,  1 Aug 2026 16:30:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] bpf, sockmap: Fix sk_redir use-after-free in send verdict
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178560180972.1159589.5381756854712893742.git-patchwork-notify@kernel.org>
Date: Sat, 01 Aug 2026 16:30:09 +0000
References: <20260719152207.2892156-1-nicoyip.dev@gmail.com>
In-Reply-To: <20260719152207.2892156-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: edumazet@google.com, ncardwell@google.com, kuniyu@google.com,
 john.fastabend@gmail.com, jakub@cloudflare.com, jiayuan.chen@linux.dev,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 daniel@iogearbox.net, ast@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Kumar Kartikeya Dwivedi <memxor@gmail.com>:

On Sun, 19 Jul 2026 23:22:07 +0800 you wrote:
> sk_psock_msg_verdict() takes a socket reference for psock->sk_redir.
> tcp_bpf_send_verdict() copies that pointer while holding the source socket
> lock, but does not take a reference for the local copy before dropping the
> lock around tcp_bpf_sendmsg_redir().
> 
> When apply_bytes keeps the cached verdict active, another sendmsg() on the
> same source socket can consume the remaining bytes and release the cached
> reference while the first thread still holds only the raw local pointer:
> 
> [...]

Here is the summary with links:
  - bpf, sockmap: Fix sk_redir use-after-free in send verdict
    https://git.kernel.org/bpf/bpf/c/a76624733730

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


