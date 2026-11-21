Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795303406;
	b=qTDLGCaenKuX4L9mGvlotmgJ86i12mi0Ij5lQ0s1fqocbQBIl04SOkhAKMvd+6L9W6w7
	 w5BSkcyx8gJD3DMQcPzRqr4xt0iCDx9ZOShpVXEyQLtewLuW/NMIuUufaNzpx+szF4LNb
	 9iOkOXwUmXjaeSRU0gPCmjPFEyDfbTEbcyWqPLPBmAcubQL/bD+uu5ZRuQ3whRdMrmJyj
	 scRlLZjmGcUYYuCRdyDy9QfWqieTE8AkDrnthjZ4zvvEWPBtq8cSdtlgWy6TlD14qL1nv
	 lLCUnrjXSFRGBkDtvcbm0K3Sxe0a2+f9qCvb3+4OE2uJcwO/W3R8BjOw89soCUKtGQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795303406;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=7sqG9gb75j1vctVyhUurGv/N0RHBklikVVxEWQimDps=;
	b=tzqptg90EKbTpuuQxC7ImNxcorNiQsW6Gv00YCfc08wBNL4CRxbJU4gvLOjnMzYzXSMc
	 86KDfJ5I8T2a1K2v6Zz5cF0S2IuRVX4Mz4C2HRjdQRRuFyHGqgwCFU8IXO7kKfvBdYn12
	 EhW8/T+9ihPaKuEVD1iGo8hqNVIHjTNMppIAbWjqrvhyQeuNlkKPA3+tw2WaNsX4GvU2m
	 b/K4NAqtBjgRtDumdJgIEvU0WcxcZgrTw+P1mv16UhQgRwQ5O/Ar9Y8b5G0u/CC6e/4Ab
	 X3h1+pjQO05HFYq8Dmq7rkHkFs1UeD/x0I3t/6zzgEGKFdsYuaoWrwVDgALv8LwQcbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkAIkRds;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29C4F606A320;
	Sat, 21 Nov 2026 23:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YkAIkRds
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 583761F000C4;
	Sat, 21 Nov 2026 23:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795303405;
	bh=7sqG9gb75j1vctVyhUurGv/N0RHBklikVVxEWQimDps=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=YkAIkRdshxcGs/X6aToNzcz/zWjOgH0MR+RWg6m8FXiZTaom1+7fNN2PZgjlHGgzf
	 E9GE1RWUJKy2YsSHRTqEQ0BEg1XRbqMTVN6j0zcBeBr4GLuvd7yWrFRaxfRRj7ocjd
	 hE0i3lrUrIQt5NELHQQ7F2n+37g4+9shL/Uyx/kQojNNdMSexjxw5/qw1IIuqwGtqf
	 ilZPtHAG58Q3vWGL8G/lUtpf2Plzhnl+Vi9HnVbsslY886z7VokiBDSdfk6AmIKSqP
	 f3U1ZGCD1MdwhYgeN8yk7C31sqQ0oO3DFBKO660HRuBeXB0lKdVRE/fIiI5IPbCsFE
	 0RccIYG4GxQrQ==
Date: Sat, 21 Nov 2026 15:23:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Rishikesh Jethwani <rjethwani@purestorage.com>
Cc: netdev@vger.kernel.org, stable@vger.kernel.org, John Fastabend
 <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alice
 Mikityanska <alice.kernel@fastmail.im>, Tariq Toukan <tariqt@nvidia.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v5 1/2] tls: fix socket use-after-free during
 device-down
Message-ID: <20261121152324.668463ca@kernel.org>
In-Reply-To: <20261116183519.3314837-1-rjethwani@purestorage.com>
References: <20261116183519.3314837-1-rjethwani@purestorage.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 16 Nov 2026 11:35:17 -0700 Rishikesh Jethwani wrote:
> tls_device_down() pins each TLS context, then drops tls_device_lock before
> switching ctx->sk's TX validator. The socket destructor can run between
> these steps: the context survives, but __sk_destruct() frees the socket.

Looks like it conflicts with another recent fix. please respin
-- 
pw-bot: cr
