Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279306;
	b=JYOCxyH+mMLeeUM6W3s6KiAqicfdSOacxe8A30/J6/+6xv8pykhtSk1ugtfizshoxxNq
	 5nL9+BDSYY2YX4jaFmS6xh1ee2Su7O7TnsxksLHqI06OiDZ7HRFEYpiim1QgeHQpsGdxL
	 D4BAhCLEiQPKTnE4SyzzkwZVauGc9fT6URuqukBnQLNnKNBqrektLNReUIDQsItgldGvA
	 kesMCzK3o1nzG/jh9tDl5eDcPjfuelVcM0fzCzb1hLE/0go+2I70H92/Gr+3JLsGG69ID
	 EBL+fE+aK3x0n5XC0N3TIQaxXhPoDMLX7qa9mhXykA0sMcNVxCGayZ6GgY4YStw8mig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279306;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=3n572mO1vWHbrUT40EU2i5Mk6sLDXAheIiNLOL8Aqt8=;
	b=C69manjjmNgn6wEbU75/s1FlMXRLHL/MR4/igM1j+PCMWHxZcYNAfehCM6LKVCRX6yY1
	 RIhR07gm7Hnrlcclvjli94pXmJiTA+sN85Mn3STK7OaWPfqgK0ltOIHiH+qScKAsf81ni
	 MYbtVKVeJH4OXxAJvZPHyNhB6W3NGhuiMkEOmoFRO09aSXL2tAxryyNfSKwLVHO2mT9j2
	 1PmYYMPjrwXqeeJAP4fcDMpYfA904TApxDFHclZIrzbPI2FYW9YFHHXP8cFfDhxzkMF61
	 QkBCmmrHoXRe7pRtKoYcN3cpFyFBqeQ87PHGmcO9NLgis2aQKqyDgRaWDSxMAaLyGTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjtVTBwH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D442460A6F76;
	Tue, 10 Nov 2026 02:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EjtVTBwH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4DB91F0089F;
	Tue, 10 Nov 2026 02:55:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279305;
	bh=3n572mO1vWHbrUT40EU2i5Mk6sLDXAheIiNLOL8Aqt8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EjtVTBwHM6cRw01Z5w6fT8+MtxUfEwCjABoTc9s4ONsBVRMAK1zlzfodb4AtrGCIe
	 jg6HR+6GX+K56GRPrnYxsQvPMGI2AhJullh3T1WodOkQXm93ALKdah+wT2j6feJqKj
	 hX7ie7LF0sKZdFGaNAwucLOTY1SjCBsGhZ4LuopIqw6WLLKWa7i7ig8zG80dDs5yBy
	 Nc1CBN/42JF7Yaslbh+KDVRtOBdK5maSb4D+xhB2m76opyWl9RAfMpwmnQHvLjbgsU
	 bXac8Mgy3u9qzr0TF8h9y/t61cQgNd6VMKTp9lWzYRU6OYYOPEEj77i9Thb4ZTO07F
	 NM1Y33SGbRvYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9B131391AFCB;
	Tue, 10 Nov 2026 02:55:05 +0000 (UTC)
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
Subject: Re: [PATCH net v3] tcp: free saved_syn after an RCU grace period
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427930421.3612825.1201326223779642356.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:55:04 +0000
References: 
 <38fa9f2cc476502e9b1c1fef09ebba1df5dd5901.1793795528.git.x-professor@outlook.com>
In-Reply-To: 
 <38fa9f2cc476502e9b1c1fef09ebba1df5dd5901.1793795528.git.x-professor@outlook.com>
To: Yingjie Wang <x-professor@outlook.com>
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, sdf@fomichev.me,
 martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org, eddyz87@gmail.com,
 memxor@gmail.com, song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, ihor.solodrai@linux.dev, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Nov 2026 12:32:19 +0000 you wrote:
> tcp_reqsk_record_syn() allocates saved_syn separately from its request
> socket. bpf_sock_ops_get_syn() can load that pointer while processing a
> retransmitted SYN under RCU.
> 
> There are two ownership transfers which can let another CPU reclaim the
> allocation while such a reader is still using it.
> 
> [...]

Here is the summary with links:
  - [net,v3] tcp: free saved_syn after an RCU grace period
    https://git.kernel.org/netdev/net/c/2b9fd1a0abf0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


