Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793600406;
	b=pMA7haJwmScKKpqqOL8ew6AfoUyIyJY/wFFW75UIpn/WlkPJuWWuXsXO86VK9avNRZSP
	 eP+c4BCMbQu9TSbeY93sk+cD2MThYaDB9IBSFRjTvNh1c5LIYJyzb8BhSxmTi0ft9St82
	 AnSiy+5vgQBZA1iWul0NsSrGpubehE6KpYcUd2/mD8+fd5Pn8wSmOtqzp4Uh6Zv+ASbij
	 9P/Dlf6bUOYjZC0yxK8aqhFozJX5vaKON+212+vFI6+cnPqhfOQIGEsujEHGCfKqlhUOu
	 duPk2NKw1D9rCi2U+cYSWffYydfsxy606bIFm9CGlNwlmagDBd5TDqNy/dxIK2vOFzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793600406;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=LXyWg33upMW65/HmtZ46qnH2orkC6Dp4INq2qjqF2WE=;
	b=Ym2sdA6eXGwdNOV/8OQH0PX0FcEDC5A3uw2K6yfvvGZFnol7E/XfqjReC88kqa+ekNGt
	 nEWMwtyVuRoXtCbqJBfD9GBqPqL7X9temGuQ7w40Ok40cAB0QaV0Pklx+k6eZsNg6BWXX
	 YwMfESMjsjimgMfO/1rN87pwEb3UHTvvVp0D9GBq6+I/ChPH3RCzY5x3mFQaWwSthexiC
	 DMMUfYmrQVj5gAmLNeedhtpDsUoCZW7e+UeYz7pI7rchkG9lVWXhy4XUg2YumOkuEwsvF
	 sCh6oY1pS7rzqCvSKlwpOfr61zW9OWVPBaG2qiohV87UToc/F9+QzvaWwZxfsssLqiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CopKWGU2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18699606A32D;
	Mon,  2 Nov 2026 06:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CopKWGU2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88FF01F0093A;
	Mon,  2 Nov 2026 06:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793600405;
	bh=LXyWg33upMW65/HmtZ46qnH2orkC6Dp4INq2qjqF2WE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CopKWGU2zYFWcKIPDV/S/gqmkRilp1iyux9ZshWqTS7AYJ2MDlz5PjVjV7rjip/nb
	 OFTwQ/XHuF0MDX5jrVYw0Ow99L0GGOEqjaqQXxVSyNZlGtmHgamWXcXdhQYHgliozr
	 WBiilr9JrL94vhRtR7xA+aA/EFw69yMKpXA0PDYTXrURmikd3+DgDnovpmyNMFp9+W
	 fQtRfNUQIkULbFXTktpcvcK6gtj9HNqeNLU7GXHyDZwa1Ja8tlE2H8YYBM/V+TMCpJ
	 ot4cwNj6WougQqXxVE1OgrBGZaB2mk1vrODZgfb8WpRHoh4hVy/cXHuZktP2UaEQeE
	 dyq3aiTI7032Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D1EF391AFF2;
	Mon,  2 Nov 2026 06:20:05 +0000 (UTC)
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
Subject: Re: [PATCH net] bpf: lwt: Free the skb when bpf_xmit() fails to
 expand
 the headroom
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179360040431.3799098.11662321290376218283.git-patchwork-notify@kernel.org>
Date: Mon, 02 Nov 2026 06:20:04 +0000
References: <20261101182343.17991-1-izaiahsun@gmail.com>
In-Reply-To: <20261101182343.17991-1-izaiahsun@gmail.com>
To: Yuqiang Sun <izaiahsun@gmail.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, daniel@iogearbox.net,
 martin.lau@kernel.org, ast@kernel.org, tgraf@suug.ch, zirajs7@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon,  2 Nov 2026 02:23:43 +0800 you wrote:
> When an LWT xmit program returns BPF_OK, bpf_xmit() makes sure that
> the skb still has room for the link layer header. If
> pskb_expand_head() fails there, bpf_xmit() returns -ENOMEM without
> freeing the skb. Its callers, lwtunnel_xmit() and then
> ip_finish_output2() or ip6_finish_output2(), take any return value
> other than LWTUNNEL_XMIT_CONTINUE to mean that the skb has been
> consumed, so nothing frees it.
> 
> [...]

Here is the summary with links:
  - [net] bpf: lwt: Free the skb when bpf_xmit() fails to expand the headroom
    https://git.kernel.org/bpf/bpf/c/5e96760b25fd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


