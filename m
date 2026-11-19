Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795054609;
	b=jDgMCKBGW16iP3e7BiQ6PrOEPf+/dac2RtHNsufNx8JDwGE9xqpCnMCg64L4sndEsXWM
	 WD/fVSk4s+frLpmpaqbQIqZ9+OpfL16DHkeRa4wmI842IICKi61b47RjKbwYIqa5Kzrd2
	 Xc57hdwMpmXLD3TUIolVasmR5AbUERLMIrJQEiVsfcgBb+ULkK6oIAfoQDyq3QTq3trM8
	 yDBueOhbivok6u0iczWTM/P/XjJez7IKXNkhlFWPQi5oHbOvnTSis1TE5vG2oYyjFJTu0
	 4X7KPiyyFOCx3ABAW/YHhOcMyufLEPJA3nPOm5XXkvj7PDqn7cXhSylBWqC2MqjENnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795054609;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=bmh4loVWol0LBPWCG2+dUQ+10rziSJFOM/khKB5QwLU=;
	b=OGBBmtyAAc763aGNmAXrhroCki21aruh85ibIAUZAkuz3B+Rf+N2tnAIUPAP4L3q6hZe
	 D0A9DN1Bj2/EQRVPF9lKe5WK7EtiI/jwxgI4cAf85OFLGXGUNQAEieYM7zdigV/faatTA
	 4ZRj/hthZe0D+sMXw5FESTEsjpm9qZ7gSrWCcuJFHkSgxb7LgFckCl3kM8BN3+pEdU0of
	 ABmT3nMiREqniIGcGPLOkijBUU6dhYwfxu7StezykPNNrVLqtM8hHA0ONptFAHesD2vKS
	 dXZZPK/aP6cqan0j3naM5CZWLGxbJE96hzDxkGhxWgyFGVhXb13/I44NPWHUp1jmSUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgTUxL5U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A34606A320;
	Thu, 19 Nov 2026 02:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgTUxL5U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320B31F000C4;
	Thu, 19 Nov 2026 02:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795054609;
	bh=bmh4loVWol0LBPWCG2+dUQ+10rziSJFOM/khKB5QwLU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SgTUxL5U2Dkk0yVUgNDenyM8oQjzcgwovmEPPF/WHd2RTv9mTWad23oF7pcBYRvYy
	 zPCsC+/LQ9J58ZTPvPkWoei9ZdVk/jPt+pAkZohTshHlNJ1GlB4ZJJQ0XokMueUxdq
	 BilFPE18k1lw9eyKZTWQxaP6DD1GRtAEhGFCbuW2HKgdJWkKpy2wQl+LcMpbP3NHrH
	 KEyyzUCIiVesOkErnWCm9R27P2UQeva7cRTCGi9cVRHgT2x1mF7d2wmUR4WsknRpAe
	 WjmK+DtT/m3Evw9hDm8pa6pFbo2KPejZEK/m1+i2zzxCWz6JCx7AsRaYKBhbhF5IqI
	 J0DVjKElqzGsw==
Date: Wed, 18 Nov 2026 18:16:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chad Aldreda <ca@modelmiser.com>
Cc: Richard Cochran <richardcochran@gmail.com>, David Woodhouse
 <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
 netdev@vger.kernel.org, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] ptp: vmclock: keep the device state until the
 last file is closed
Message-ID: <20261118181648.0ed9a202@kernel.org>
In-Reply-To: <20261112161514.1647680-2-ca@modelmiser.com>
References: <20261112161514.1647680-2-ca@modelmiser.com>
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

On Thu, 12 Nov 2026 16:15:27 +0000 Chad Aldreda wrote:
> vmclock_probe() allocates struct vmclock_state with devm_kzalloc() and
> maps the shared page with devm_memremap(), so both are released when
> the driver is unbound, but an open /dev/vmclockN keeps using them
> through its file state. After an unbind, read() runs on the freed
> struct and reads through the released mapping, and a poll() in
> progress sleeps on a wait queue in the freed struct. KASAN reports a
> slab-use-after-free in vmclock_miscdev_read(). In testing, the same
> read() faulted on the unmapped page once the device had been bound
> again.

this patch needs a rebase after recent mass rename of kmalloc
-- 
pw-bot: cr
