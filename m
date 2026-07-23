Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E03D313547;
	Thu, 23 Jul 2026 17:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784826036; cv=none; b=PL6f8gtin6QXspEBuVryqn6A4aaiF6M3xA8XtyzIdE+658nQQhiJBmKyjDmcDmWmw0BRBP1dsMviZcKQefL+x+TKkhmlWijekrRepDyZunbBZjEL2rQdE8n5TDzW8ocxcEFlB2DD6Sk1q07LL322y2XE86YsyE/pv5Y9o+kuAKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784826036; c=relaxed/simple;
	bh=4/WPPcLtQaNmiBTxz0XiP9q/NGGJRPYQovCMyuAy5hc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OizZtBQLWWFBQgc9/z/sGHgHAqZgeXLm82ZcmryvQ34auonGXXAwVx4WVbnjleV95A8dGWCn0x/h+RtstaZ06jHoBYJXlDh7jTO3DQtjDhlnSnre5x9O0Vh5ODEO2gJH9upU/m8p1ouo3gT1jiWxyN9zM5ufcO1ILiSz4r9Px3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jLXWgp7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jLXWgp7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD0B61F000E9;
	Thu, 23 Jul 2026 17:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784826034;
	bh=4/WPPcLtQaNmiBTxz0XiP9q/NGGJRPYQovCMyuAy5hc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jLXWgp7CPhrNf7fjr7I7seEEtw/vOn3szHTchl+R68NrNyh5ZTr3OppyswBHRCxBz
	 fHuN6scPYa55z+RrfZDIOCSQ/D1umU/S0lYmqBML06pvzhfxBbkQvsKphhMtxQuUSB
	 5o7WVU2N37T78FD8rMBszxcj2IekngeyZ+Qh3PId3hQCsmc5Sfir/h0vZDAz0i3fen
	 7/XGGTpQ7XpmbCC9MWtmmolShtQIpw+GeY/SYWwYLsejL5qvTubIPWYqDZcHl5vxSZ
	 g9EGye4MUVKXpfCn18e+nPcnRabCnIUX6rg3p9qPkKEvjsjC5ii3pzeno2HjPNJ+nn
	 nUFvGwRjCH/yA==
Date: Thu, 23 Jul 2026 10:00:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chengfeng Ye <nicoyip.dev@gmail.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, John Fastabend <john.fastabend@gmail.com>,
 Jakub Sitnicki <jakub@cloudflare.com>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3] bpf, sockmap: Fix cork ownership in
 tcp_bpf_sendmsg()
Message-ID: <20260723100030.3eee6d51@kernel.org>
In-Reply-To: <20260723162602.3275661-1-nicoyip.dev@gmail.com>
References: <20260719161630.2901208-1-nicoyip.dev@gmail.com>
	<20260723162602.3275661-1-nicoyip.dev@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 24 Jul 2026 00:26:02 +0800 Chengfeng Ye wrote:
> Subject: [PATCH v3] bpf, sockmap: Fix cork ownership in tcp_bpf_sendmsg()

Since you are spamming the list with the reposts of this could you
please add [PATCH bpf] to the subject so that netdev CI is not confused
into caring?
