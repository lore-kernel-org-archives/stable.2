Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793059208;
	b=4eO8Y+lSQ/CE+V+fW7SpWXauYEJHDUV5i2Yw+CkxdgcXBaQr3yXdTK9MKe8sr5cxXd1Q
	 OKdrM25jm8jiKvPjiL6Th4Stvh9kcaU1syTj00zzbDKug4sZ8EQ/RPinHCe66rcBv3A0l
	 DwRpcqZBTOY0qZQ5EHvt23TxXlY4QI+B8gvEKh78GiGAFGGs5WLMN+n2PZhwr+0Bi9daK
	 J8pNrwiKiHLAWKKMkeRJSjeS1+6AJKbG+D1Zow42lbk8BRa+kbWC6x2w61hMsXlL78EmU
	 yIR5Vj0kINXPF1tQIF26IYT11XrVpwZPuzbuza7nU+trWnulCXZ9IOWnwDXuztWPi4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793059208;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=sRBxls+fDXcYabNmDkORIlMaTl0ADNtGzRxkQN+pXR0=;
	b=ua8+b6b2lqaZyQdi/8sxXz8+ttAcp6PNMQv5rmLM/hWZrRdeJh6VukyqgEllbY+W8Qxl
	 M6cIJzk40wsHYmokxQwLSTYFF19TQRlRivFdxSo4EjIPVDgnxZy6CZRdmejkemIcqxRVL
	 Wp4ceCy6ogcSeN/9wMPxnMmwBbcdDS/E50emoPkN4JejnIq3TOnVvnddBksl5dixQGZ1/
	 s4dL3sEtj59Vz2pMaAHIluC7aVJysFcfx5Yip7sVvUuxHMKo+JnarGTty4c6CRa/VBeT7
	 uSJuqjj4UFWZ8NfCE0BVRiE97ygwxJQFL587c1qWV0/opfdHKDRAxtbyp2hgAXEm00g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVfFljSR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BE6E606A320;
	Tue, 27 Oct 2026 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lVfFljSR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133171F01825;
	Tue, 27 Oct 2026 00:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793059208;
	bh=sRBxls+fDXcYabNmDkORIlMaTl0ADNtGzRxkQN+pXR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lVfFljSRPcMn+FDAEFbvFCyrsfvBlZtNff4+EsYFi6Ovb/1CgJ9S761Es5oQhtzKV
	 5tWh1gpLEXYa6Ut0c5gEkPs4GHCJtVNRH58UMN7yP7jsNuA3C66kFWvN4OyEAQUKtG
	 jCpnmAxQg8Gsl7196nd9QHIHKqkeDci3e7U20RuH9qf7W2mD3lReN1+QZwHUACtKe6
	 x584byggWLdcO6sINU5U7umgr6FD0mTwwTUctG3TmoYRIctWqLPw6V2q9KPjWoG6l5
	 TH7Y6ILlPg2fME7y4VyxD2m9Wfetj1pX86ozKxdrtga7hAYIJiGqQOBjkMJPiAxUDR
	 AVHY4xgdquP+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 073753AA80F1;
	Tue, 27 Oct 2026 00:00:08 +0000 (UTC)
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
Subject: Re: [PATCH net v2] tcp: limit tcp_tso_rtt_log to a valid shift count
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305920681.3470272.11485380440248270643.git-patchwork-notify@kernel.org>
Date: Tue, 27 Oct 2026 00:00:06 +0000
References: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com>
In-Reply-To: <tencent_31D2FFCCE76C50A695A1270151F825E90906@qq.com>
To: Yingjie Wang <1075151112@qq.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, jiayuan.chen@linux.dev,
 ncardwell@google.com, kuniyu@google.com, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 23 Oct 2026 22:40:36 +0800 you wrote:
> tcp_tso_autosize() right-shifts the u32 returned by tcp_min_rtt() by
> sysctl_tcp_tso_rtt_log. The sysctl uses proc_dou8vec_minmax() without
> an upper bound, so it accepts values through 255. Values above 31 make
> the shift undefined.
> 
> A process with CAP_NET_ADMIN in the target network namespace can set the
> per-netns sysctl. With CONFIG_UBSAN_SHIFT=y, setting it to 32 and sending
> TCP data over loopback triggers:
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp: limit tcp_tso_rtt_log to a valid shift count
    https://git.kernel.org/netdev/net/c/850a7225bc61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


