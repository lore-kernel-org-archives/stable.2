Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794333749;
	b=LZaBdvAT68nKbPzwp9JidSkgQOdIyTFAgeTHQELtFivNeJwgHg1ApnKmu4ubs5Gi8zZb
	 57buFBo3m7Z01ZGaz3LcnFf883V7KbUVlMhjrM1FHcBEq7Pk4+wOTJ5JLUpmrXEzFWILW
	 7t6+0rtGRmmSpcu10qBXXMoeVQsPC/0jxH4ZTwmrtX/w9DJkXL/K8bGaYXVpF1AfP1kSz
	 iJfsmw0x6FpGrMzRBE62izJiOHxlUjP9dHFH4yQyboVkxwAJq8CMoeEcEBXyxrUea6BYF
	 k5Hj3j6P0Tnh0KgpU4Cx/Yl62g78kHdroiLkrN1WaFJ0xeJ4qGnhhLtZnQZgmVQBwGQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794333749;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KZM+P45GMMku+OUOrW90NWAj7DSZ8D2oRmj7UZG9ZX0=;
	b=fYXPteCpJnGP7iNhl43Mv5jpjdz23bxjorRrBstgfiOkG5t6V/7u0FKwq2yusBlL+YCq
	 iamVGG0hQ/nBg5JtmBUt9O+wd3wCBZty8uI5w13r5igQCNExKPkKBFO4Qqq2V/TWCeuj+
	 0zmZyArYEFtK3P9N51CLYH04F+RC/NTZS+ApN/aLKaQRUwWyktcE08ctykZaMSkIRo55h
	 RccKCDDssxgKaezspfdoMAGQxtSYopjmdQU9blYe4bYNh10WskTTMgPWZPpEUZPI7Nqh2
	 VYHp36uOsyQ7/WFIeJJ5pX761kVgVjiFOtwvbYNxOzp64cELVu9H4VDJi/oxTreINHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Yq/hcIPp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97FC606A334;
	Tue, 10 Nov 2026 18:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yq/hcIPp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB62C1F008A2;
	Tue, 10 Nov 2026 18:02:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794333748;
	bh=KZM+P45GMMku+OUOrW90NWAj7DSZ8D2oRmj7UZG9ZX0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Yq/hcIPph+w+2zxxSAqfNydltKPCYmgBIfszhb8UZh/i/2l2HfV+2kufbM/v3cjj3
	 dc4P95/8zKYuOiNVfPI3QnIYyqUPgitunR1guzGMCE37mHtxfJdRzHOTFzmgB4cS+5
	 dm5jX7GrMealc9WxFXoKoNLPqZR8jw6VJbXrdowVU0rX2kwD4WJZIScQwX7DWAQVaj
	 g5grFyMX+rm3e4Ysjyj0X2hdRcRo/O2IC9Ro6kt6xgt8XBq616KgkPLAfwipJYzbvg
	 L6tVs+CTcdufnIoX88VWmb7Qeoi3jnk9RDxRKS8G2m1xavv3ikAr9JlsanYDmJ80j0
	 63kMwEy8/t6RA==
Date: Tue, 10 Nov 2026 10:02:24 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Xia Yan <yanxia@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, edumazet@kernel.org, ncardwell@google.com,
 kuniyu@google.com, davem@davemloft.net, pabeni@redhat.com,
 horms@kernel.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, yana06070@163.com,
 netdev-bot+sashiko@kernel.org, jiayuan.chen@linux.dev
Subject: Re: [PATCH net v2] tcp: fix device binding after failed IPv6
 connect
Message-ID: <20261110100224.57cbf548@kernel.org>
In-Reply-To: <20261102143352.135769-1-yanxia@cmss.chinamobile.com>
References: <20261102143352.135769-1-yanxia@cmss.chinamobile.com>
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

On Mon,  2 Nov 2026 22:34:52 +0800 Xia Yan wrote:
> +	if (scope_id_set &&
> +	    READ_ONCE(sk->sk_bound_dev_if) == usin->sin6_scope_id)
> +		WRITE_ONCE(sk->sk_bound_dev_if, old_bound_dev_if);
> +	scope_id_set = false;

Just restore the old_bound_dev_if, I don't think we need all these
pre-conditions complicating the code. __ip6_datagram_connect()
already restores unconditionally for example.
-- 
pw-bot: cr
