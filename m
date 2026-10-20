Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489207;
	b=RrdwKFY1Ehg86XRd+UzSPNMs1bWUADqQJwgdd2LY5V2TxwXIci08q5ts3Tsl78Sn5YSf
	 pNd48HICmzI27Bm3nDdtTmaQs3SgBCvwYdMGhKpRNc8J3hvn9L5duyKQb6ru+ahPTfgVc
	 z0ERpam5eHRp80S0uzvXImx8T2IpgjT6U7FmmS4+I/5hc/VhU9z/yD03sTt2YoY//pBY7
	 0LICflgaA6mGNGyW64T0b5RprwuqmESr2Ljr49J8JgcP3NJ2XZzL9WWO6vMes15rrHspk
	 +LnCHzSElJBB9qLf+ToLKoUpJmBVWyZQo3Thmb4noz/pDJsvw/O8MQ/dmtkNdThuPsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=b8Aj3vH1ZwXNXY68nNpwhdnagcEoLEnr43eZ/ot6hJM=;
	b=MivgA7HImFKKyxFbD0NlqgdPLTMsbiFwLFokO+K7F4kkryvlaEVqNhV+q62xV8xLrYZR
	 0hGhPZanMg6xhM53lytceXNRXXvbRXK8I5doVaOEaHNU49jweyVAlsUtL+C/BxITkodo/
	 VzOBYaDJAF6Zsk9oQg1MDVWNaoR58PEMGKZ3khx2bI0yE2AG11snjxWgCZ4V2rt9VeoAv
	 o14haWB7CUeY+SUXHEhPmNJrRGx/ua/ma0hhKuCFEJkEXciGn7++swypYzANrqHvQ5UQO
	 cC3LPEZeEEQTb+PvO5/gEdzQXdQULQhD3c43SnONOO90w8QI0yt4SC9zTlbjx3gug4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YII2U8Y0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E3B606A321;
	Tue, 20 Oct 2026 09:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YII2U8Y0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FBE1F000C8;
	Tue, 20 Oct 2026 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792489206;
	bh=b8Aj3vH1ZwXNXY68nNpwhdnagcEoLEnr43eZ/ot6hJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YII2U8Y0zbkHAmdkq1rGQ+wLmCYHVeXegwaI/F77rEZzVFCguVNGLuqTYT53y42+a
	 eToK5T7uwTgySKcjyPm2L3sxsMWnSpI6R0ItN/rIHx+H7085vvLLqnYDzjolOzzOmz
	 8TVEsefnYk3ZJB9wgo6uSbxYrftPSpo8P6uNMFyuhIhZVUj2hfd6Z/qYI/DmBCVbqf
	 aeodu6Oop378dw4EazpVy0T627oSg9JGwbu2UesHdvDw/INMzgYzCxGt6O9lp9w0Zo
	 /aiBX0s39xOzssNtzZDVvhZEIonTUY2HNI+3/gRC3cAb3xyDTfnYs1b0zOKxVz/ugD
	 DHJJlH+FvYBxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774873808209;
	Tue, 20 Oct 2026 09:40:06 +0000 (UTC)
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
Subject: Re: [PATCH net] l2tp: snapshot sequencing state when building
 transmit
 headers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179248920528.3616761.4424083944726406723.git-patchwork-notify@kernel.org>
Date: Tue, 20 Oct 2026 09:40:05 +0000
References: <20261013090500.1180376-1-nicoyip.dev@gmail.com>
In-Reply-To: <20261013090500.1180376-1-nicoyip.dev@gmail.com>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: jchapman@katalix.com, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 13 Oct 2026 17:05:00 +0800 you wrote:
> Updates to send_seq from netlink, PPP setsockopt and receive-side
> negotiation race with packet transmission. The header length is updated
> separately, while transmit reads both fields repeatedly without
> synchronization.
> 
> For example, transmit can push a ten-byte L2TPv2 header, then a concurrent
> writer clears send_seq before the header builder reads it. The builder
> writes only six bytes, leaving four bytes of uninitialized skb headroom
> in the outgoing packet. The reverse mismatch overwrites the beginning of
> the payload. A later hdr_len read can also make the UDP length disagree
> with the skb length.
> 
> [...]

Here is the summary with links:
  - [net] l2tp: snapshot sequencing state when building transmit headers
    https://git.kernel.org/netdev/net/c/d06ae66516e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


