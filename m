Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792443358;
	b=hcuhqdnwOFABF9mqJ5kUC+gkEMZn0pSBc0S5Ecjj+mw+ISSxt/maMdZ5htBLJphMQ/ND
	 jB46jXDmoX91jAKbDkvajeZHyNGOXN3CFy5KDLiJzF31X+y7T2LU8KnPZ0tTwsnJ2aE5v
	 +H9goKG5JIlJvJXBCV2zM1C82N8MCb8BPEM3L/HiihJSJPjTqdGVxmfWNjps1UwViRAw7
	 +wQ1VJUE1ehhBeHMx47LCQx6v5ASeZvX3rAUjwJ1KQ0GoQUSe0jX5t7tFk95B/o0aW4Yq
	 +A3H4wupf3PUv1VNVuuxLPXHgK/JnwMnTsB/NVqUL8Xehj3CucPI9Wfg/tcswsum9yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792443358;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aLWmd5YiIY9sjhgpXGX9flzJouEgomn0PxCVfbbT2Sc=;
	b=WMkO5cf4xAO1aDwLC06cc9gpjz2K3zDBh3h6/N3AaKLWi7nZfmFRtFpkz7AOrfOPGACe
	 WK9Fe152shJLuCpbdwdBs5i4UW3lc7GWolPjViGeltMmixAF5EaYQYr6qJp56lGGgAKdU
	 X7APzHffqW3l6nrrAu9AK9A+9zcLeuZd4FEAqtVd8IA5xocjXZ99llNj+PqeQhlBYbj81
	 3hzLZrldHPwSaFxasrd4WvC7pOEBrh5kUDL/S4gbTYjWWs1+UgJrp2fezCrzrJ7XDeKQU
	 T3TeQb4PymHcBV7X5+VgJomlpSfI5LwZBUqDdX7qAV5r92WhhEVxTmu7hBW4rX/qO/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaEy5M4Y;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F4606A326
	for <stable@vger.kernel.org>; Mon, 19 Oct 2026 20:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZaEy5M4Y
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DDEC1F000C7;
	Mon, 19 Oct 2026 20:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792443357;
	bh=aLWmd5YiIY9sjhgpXGX9flzJouEgomn0PxCVfbbT2Sc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZaEy5M4YPOn+NO6i8QFw38/Bal4xhGz4hVTx7QiH+Uj4e56uL9k34yu0R6uSFM+1u
	 imJLUHsqkDiFise1DFa7IBfjqJIaWVrwE7kk7HIScg7I0ojGbTnevTt4FH/TNjbTFF
	 g7KmvnkY3QnPQ1DFUb6+9Gy4HHT2E/lAizd84/2AAwW9G6OnHIC4AM12M5sswDeTPq
	 TBi/tt8O47z9f7Gnof18JtwHp/cSMxo0pYpVfBnBLi1RcAv5/sxuqEOLC9KxyIKwzT
	 EkXX4VHUryOuJXKnBfLSHYRHn0DI23UNHfylE8AIW32x7l0+wESn1VLeDR6a8JVHvj
	 KSlq/IdyBzQjQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	security@kernel.org,
	Willy Tarreau <w@1wt.eu>,
	Abdifatah Suruur <suruurism@gmail.com>
Subject: Re: [SECURITY] netfilter: nft_byteorder leaks uninitialised kernel stack on 6.12.y with CONFIG_INIT_STACK_NONE (CWE-457)
Date: Mon, 19 Oct 2026 16:55:34 -0400
Message-ID: <2026-10-19-1-daily-reply-0008-nft-byteorder-security-declined@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179239012164.14465.16534329674629579851@gmail.com>
References: <179239012164.14465.16534329674629579851@gmail.com>
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

> Stable maintainers: would you prefer this minimal init patch or a backport
> of bb061d3de4170741?  Either works from my side.  The memset preserves the
> existing multi-register ABI and is the smaller change; Florian is fine with
> either.

That commit has an explicit stable+noautosel tag, but now it needs to go into
stable?

-- 
Thanks,
Sasha
