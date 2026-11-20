Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795141922;
	b=YDfVHmtwl8OIGSsKKwzWHNLKpKGhUiJDA13oHTtrqAhijnPSF7e0+EEdTKBN+nJhJojj
	 Zf1XRWHvN6EB596Im43qPjIOWoIV2lIA/RuDA9VLMrhVdECaiUQs2O15iKqfHnZ2T0eZa
	 zUsu91/wyQ/FLbj39zegSZfmgU91S0ZcQzwCybbVtNU8Gb7T5KN0uIqShxD+73G8c3k8M
	 YUN2oVRX8A4vlkUQsU0elafSVBlRKpa1salItGCwH/zP2JuQzN7reXAuJ/QMfD3MNkYPW
	 5kb9HQFvQWZTGFHWRKvd2i0ddOLrG/qHfnbiTt+cPlycmn2Rza2tQF0vL4b7aD4bzJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795141922;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rkSK/wNIPIw1Wi1sSdM3kFmLGiju15tFnWSbcknF3Jc=;
	b=NL66sCu9FqJ3QGeQ0LV4enCFeiMRrtqEI1X7Kej+6o1OxPVoX0xOdx/io0GOznZUZE5i
	 QINdJ/D7h3RAjEJXqd+AoH+bcIVO8VQcmtmNRNnigM38ToKv01I3Urv+3yqcdkmYfvHww
	 oYN1wPZ+Z9gxorzU4GPX1R9D89Awimmqmx4yyonzM4EDMoVgcXLVdWSmQg2uFi7+ZhGCY
	 la0stXjYyfwudLNOakCgiLQTJbdSENtaVqLxfMFkKtGOUwPh63/V4YmXLOYGh7E6go3xV
	 72zcaaGYvzi/VoPKSa50ehDuioVkswwLIXbNmrx/Wd/yYTDARZgtZj9IyDF9lW6FX1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="gIIoQ/ku";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701AE606A325;
	Fri, 20 Nov 2026 02:32:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIIoQ/ku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EC231F000C6;
	Fri, 20 Nov 2026 02:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795141922;
	bh=rkSK/wNIPIw1Wi1sSdM3kFmLGiju15tFnWSbcknF3Jc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=gIIoQ/kumDmnnAD+kIxTAeyDPzetjRKBULzpnGJayWdkEmJatzZhMjqviXDZwh5jF
	 zmdO4xVmRqWK1K6TTYYxrbFKMg8rciC3u9OusKPw9Q5mkiyAYYwVN8iJAIKOaPmWtH
	 JSO/zFcVNLR2306cAgsCrq3wZlZfMBM1WGNYq0M2W7IgVcxt5bjjHqrAD6yehWnNll
	 rV5WgA7B51kf8i7m8Xd0XNjQSORPQLiSqeFR8BNsseYZo2wsMamLoazLFPcOIVPjm4
	 1RWnCZDv4xSvlPs/uibrxFKQTtBn+g6lEaaSPCTF7QEOPu+TuFMZQ9NQfAX9C69/v2
	 TJ9/jh5jkNSqQ==
Date: Thu, 19 Nov 2026 18:32:00 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Geliang Tang <geliang@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Simon Horman <horms@kernel.org>, Florian Westphal
 <fw@strlen.de>, Dmytro Shytyi <dmytro@shytyi.net>, mptcp@lists.linux.dev,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Quanye Yang
 <quanyeyang@proton.me>, Petar Sakic <petar.sakic@ink.fish>, T S Rameshkumar
 <rameshkumar.t@phytecembedded.in>, Chris Mason <mason@kernel.org>, Mat
 Martineau <martineau@kernel.org>, netdev@vger.kernel.org
Subject: Re: [PATCH net 0/7] mptcp: misc fixes for v7.4-rc4
Message-ID: <20261119183200.27386123@kernel.org>
In-Reply-To: <869ba3ad-381e-41b1-adfe-2ef86fef5ad7@kernel.org>
References: <20261116-net-mptcp-misc-fixes-7-4-rc4-v1-0-bf7656de653e@kernel.org>
	<869ba3ad-381e-41b1-adfe-2ef86fef5ad7@kernel.org>
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

On Wed, 18 Nov 2026 23:05:24 +0100 Matthieu Baerts wrote:
> Note that patch 2 should have another Fixes tag (sent in my reply to
> Clashiko). Sorry for that, Sashiko/Clashiko didn't notice that before.
> If changing it when applying the patches is causing troubles, could you
> please drop this patch 2/7 and apply the rest?

Updated the tag when applying. Sorry for missing the PR.
