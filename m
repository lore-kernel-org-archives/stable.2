Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795516207;
	b=NisW0lFccBda+N/YIHNfQAb7cR/CGaNWQNwuZ9iDlHoBs2XcOYRM5S/PkNaFF6RqpG/o
	 j4p3mSxBtnCmcV10HRexJyuOBcckjIsGc8p8lMPuv62MwNQuvq7ZD7452jC5f8UC0avkl
	 3PZ1Ln86vtSJwqJv8puRxaywwGEbDgqCobX/ykmK7DiWs+pcDY625O+EntEETLr0Bgq7E
	 9ru5KaSJELdLY+epPITT4eYRusXFqTncfPYyeDOW0iFcHLkIlNEx2MlzSr5NdlxWNKoyI
	 w1Jx2vo3wx3NfYrbrkDz6vHV4QxgfcOdyNiyEZnKm5D4MFDUyo/jsMGoknZ4iUD3bBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795516207;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=p04gJ0YIJ5K6riQxsGKSSOf2n8Ia55dpM/nGFJB50fg=;
	b=iUtY137DhrMm9HdjZ59J/wMRZ9w0zz5MOgVv/fG6ed4b72rMdFu7QHBPY9l59mikV7uY
	 kb4/0FlqIiKtkVnIEUD7th2R53JW42K7Dtmw0HHPik+DyeSEM2AWkc2NL4kzWKhqm19p+
	 QYbOAt3RxfE+1BkOdwRf2beP+U5eSDod3mkZbNlS17NPOThQ6QTKAOoJVkM6AjdYaqTiz
	 KMyxjealyvE4Qs99Kncgmb3a/BUpf6IUlLCUGACGBAhnqEMWIKaFQr/YFoWJYACVdkRNQ
	 gwRro2v1aljHT8OcNzd9c0S7Frs1pHfN4l/qrBUNUfV+ZNCyx4KyJlK6NLPo+cdpE1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lZYGD/b9";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337AB606A327;
	Tue, 24 Nov 2026 10:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZYGD/b9
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 431441F000C6;
	Tue, 24 Nov 2026 10:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795516206;
	bh=p04gJ0YIJ5K6riQxsGKSSOf2n8Ia55dpM/nGFJB50fg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=lZYGD/b9PWZnsLKFV2Jpl+y8igi5teKVAdohlAf2virTpMeHDZT7Xma+03f56SxRl
	 Zj40lHQ53eQNr+L8AwHiRwNbx69ANdq8y8TflYO9gh1FSgEWjTPKeKWJU4Z5dXUesq
	 SVqUI3wmiGh4GVrj4DgIYLLMFDvZoSND9Ad5quWiPe4YSFIvpCUG9bLLaqOnFw2frV
	 gerOKEnnN6bTgHJY0TSHBnw26E7zDD3yFLx+Uda0k7dOY012z0R5GT5SYByozZhcX6
	 JDEoekpq+e2U82WuuohN3NdsOeZ124XNwyx0dR38t7FHnjhQj34F3Z0TmwLNSSy8dD
	 OAGeLWFbboDPw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A46E3931025;
	Tue, 24 Nov 2026 10:30:06 +0000 (UTC)
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
Subject: Re: [PATCH net v4 1/2] tcp: fix shift-out-of-bounds in SYN-ACK
 retransmit
 timers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179551620503.3433632.13292310482168574240.git-patchwork-notify@kernel.org>
Date: Tue, 24 Nov 2026 10:30:05 +0000
References: <20261120040447.195446-1-jiayuan.chen@linux.dev>
In-Reply-To: <20261120040447.195446-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, edumazet@kernel.org,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, willemb@google.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org,
 rdunlap@infradead.org, ncardwell@google.com, kuniyu@google.com,
 linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 20 Nov 2026 12:04:35 +0800 you wrote:
> req->num_timeout counts the SYN-ACK timeouts of a request and is used as
> a shift amount:
> 
> 	/* tcp_reqsk_timeout() */
> 	u64 timeout = (u64)req->timeout << req->num_timeout;
> 	/* tcp_fastopen_synack_timer() */
> 	req->timeout << req->num_timeout
> 
> [...]

Here is the summary with links:
  - [net,v4,1/2] tcp: fix shift-out-of-bounds in SYN-ACK retransmit timers
    https://git.kernel.org/netdev/net/c/9f2264b0730a
  - [net,v4,2/2] tcp: fix shift-out-of-bounds in inet_csk_rto_backoff()
    https://git.kernel.org/netdev/net/c/c5de2ce2fccd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


