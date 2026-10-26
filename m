Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793057978;
	b=1gbmOJWVSTTEx94TpLReaV0C4VeKK33f0VApSsFhvskMH5kh9tBoOlzcOY89jkkgvI9D
	 rQ8WblIdJITgwJK8d/WIDDZv62TVumIEVi76tuDqHg/iL5tqc5eRAsvwl/YasFK3bZPjU
	 OWDysPTyYS6+JPZjCLjzuTiCKTCiMM+OGSgRitoHl0JAZUPmI7SzWlViz167oShBcLZ4t
	 ZtgWEwTH8O/tCeKkGmdtOarKIL7rSqbBf+HklhUiNUFAzjeC6Kbg7adm4g49znAk8HcvR
	 pjzsKwejfUXS/0F5OQWx+RIArUJ+ZkQ5kU5tZ+5Gue3+mFZaw42/lGMSCzES/Ty8hqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793057978;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=1hn4CaP171Pv+vV3T1+gKL8EoDmoJ6KQNIPs0XWUgyw=;
	b=bCbFhuPwjrOsTQZwYmLWH5dBXjujT+nmYpSJR4To9RC2KE95M8KnuwhWwmWDE1SoqkGs
	 ZJeO7GzTKCbcu7flanrxbo7Jvt4zdftUnJo+ltpXQfgWkFRBkhdYKJzHpJvrYLus3hNX6
	 4MQ/K9rfLy/dTth0tkG9bJO8nUxuwpSIoQlJzAwU4qc17hfdKQXCR/QGV/carvWV0q51C
	 XrbhIE75GxG+fb6YHMjJyIr2cnbvH1roIYI8NTMM0KFewF8MsQmfe1gdtWLFh0BVa5ink
	 ZVuWtimcVcXendW86uW8ngssRzWK6ob0oVP9LpkX+uCfORUBcFyIF6GlGtcnyLRJdAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3P1ZFXH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7A606A31A;
	Mon, 26 Oct 2026 23:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=b3P1ZFXH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A0B1F01825;
	Mon, 26 Oct 2026 23:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793057978;
	bh=1hn4CaP171Pv+vV3T1+gKL8EoDmoJ6KQNIPs0XWUgyw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b3P1ZFXHJ5JUyJtivhpJfTqSBe75CyZbsDn2/hs39GG9lrzwVS6F/Hkh6UZTPVw6Z
	 sCeesk9+/HXzh9t1EV1oncVN34lMN4ormkCf+vcEcjFbqIcogRe45vd/ZlZotSxPyb
	 9fKmJRAHRAfJhkfu+pGzvOfX8b7KXg9baf+L6oOjtyWw8SLP4dNw2udB9zRJyo1mNi
	 jppn5LoETkGOMAAt9444qlbht8CfS6rMERfjAuomPPTdSz5jYQyvsRdssM1T4nBsu0
	 zxoaz3hLND1YsbtWbumDEg4L0+53KmNzRuQpeJ/iiIs7gV4B6ylVJBV/0VupDJqoRU
	 41S83wl1Tcgzw==
Date: Mon, 26 Oct 2026 16:39:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@kernel.org, dsahern@kernel.org, horms@kernel.org,
 yoshfuji@linux-ipv6.org, stable@vger.kernel.org
Subject: Re: [PATCH net 2/2] ipmr, ip6mr: validate packets injected into the
 register vif on xmit
Message-ID: <20261026163936.04fddbc4@kernel.org>
In-Reply-To: <20261025071729.34967-3-idosch@nvidia.com>
References: <20261025071729.34967-1-idosch@nvidia.com>
	<20261025071729.34967-3-idosch@nvidia.com>
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

On Sun, 25 Oct 2026 09:17:29 +0200 Ido Schimmel wrote:
> Assisted-by: LLM

Hi Ido! FWIW these are no longer necessary.
