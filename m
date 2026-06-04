Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAA5480DC6;
	Thu,  4 Jun 2026 16:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780590026; cv=none; b=KbdOsyekkjiee3et1zEmD8Dq+4fpOd1zDYBjz7GKnW+EQpAye70ri7JSdTTN+JlO+4MG2/n5F45vcmsFeKxlI9W0GXEwfVooZ0r4zW+2DIJwb26gR8hxmTT86q8c1u76tyIaMQqBeQMmDzngfva4CXbpJNSqSmPCGDFxasIxHwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780590026; c=relaxed/simple;
	bh=HSkb/Werf41K9alE+Ly00tTdUC7xm8kkykztTsixCDw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g5AIz2qG8UwKT0RJuQZOV0qIdh3cGYJsl7eKXaSM1bRAXAkZPT/Yj5Mr6BCaK0PiMer7L+eF78Wzbl7Gc48gGrQkV+L/pGrccoVIrc3x06gBR5or4dKGzsoBvGx6/IlVdwGla3RnNtz9Pu9fbZRg1pApqcNIv2GUVDpipD0cdF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ngKbWz0x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ngKbWz0x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD381F00893;
	Thu,  4 Jun 2026 16:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780590023;
	bh=P5YbH20m2XNrJfxFZ63yuHRp1sMQ7lNWvNETjgksdyU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ngKbWz0xAQH7oWFienZ+17T4Pc+b8vYgH+MsADgXI1YsrJR/rLnQndqdy+uPWXYgt
	 DStJgfdFTegJ21Ljneeqo3WaEHbpKEmw+xe3vh2AdtpZUdfWjZ+DudrE+neNc4nM6u
	 fXGzBDS0sK9aAI5ejcKWaf7o0NzpMmaWDOnGuSf7i+rEG+t3EMo+EeIu9TDfHsRbqx
	 79KRLGYfRg4blv49686NYyE1GwFCDKHvJT3c3P2kRJ6RLdt7p97YUfV+tOSZ4FxAaU
	 e0aB0bxcidhiwz+XwF/8nthfEz0YymtLVFUuWDLmqfBqcjZQqJeUrtQhUFGSRVFnqc
	 6jk/6IaXBbFnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 5697A39309B7;
	Thu,  4 Jun 2026 16:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] udp: clear skb->dev before running a sockmap
 verdict
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178059002389.2502005.13388357073387787000.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:20:23 +0000
References: <20260603162737.697215-1-rhkrqnwk98@gmail.com>
In-Reply-To: <20260603162737.697215-1-rhkrqnwk98@gmail.com>
To: Sechang Lim <rhkrqnwk98@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
 john.fastabend@gmail.com, jakub@cloudflare.com, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 16:27:33 +0000 you wrote:
> On the UDP receive path skb->dev is repurposed as dev_scratch (the
> truesize/state cache set by udp_set_dev_scratch()), through the
> union { struct net_device *dev; unsigned long dev_scratch; } in sk_buff.
> 
> When a UDP socket is in a sockmap, sk_data_ready is
> sk_psock_verdict_data_ready(), which calls udp_read_skb() -> recv_actor()
> (sk_psock_verdict_recv) to run the attached SK_SKB verdict program in softirq.
> If that program calls a socket-lookup helper (bpf_sk_lookup_tcp/udp,
> bpf_skc_lookup_tcp), bpf_skc_lookup() does:
> 
> [...]

Here is the summary with links:
  - [net,v2] udp: clear skb->dev before running a sockmap verdict
    https://git.kernel.org/netdev/net/c/3c94f241f776

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


