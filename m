Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795075431;
	b=w/plE1iAplqxoxIjo/5PnRcMj3VvXRZpjqhVFhpVTIaEwX9Ml+6F0PuF2OvYdnRBGibH
	 Jhx4/s48py1QXZDUQAy7HWLiaeHsj+cIYaVRmEJQ47uUArwc/3H2oRxY5eH4O3QG1TgZO
	 lN+CpJfaV1mHkZkpRsdbiIEBbiLol5pvgF5vhzcmSlUSvYFgTQ/yX/gJitVg37Guttsim
	 uDMdxL4birKVuxfyM9nT7HNqNG8wTre4fvO9JTajOlfSusK1lbgr97qMcUl/E+yWt7Slb
	 5Z9J+Sg8nD1gE0y/kxdnZeAIqIaY2b4ayW2Sm3RwHk3N3jl7MhN35vO3cTcpfTWahFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795075431;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type;
	bh=zvtIOukQliNBIGTgrX6fEI3+EJQR189chGORkbgx7OQ=;
	b=nyxlD9JkuLX+V9hM1Lpv9h30OCgLCXtm0/Jk3P3vYxafGt9Mg9RCGtV/hxOrCqcK8gme
	 Sx2GJlXaEhQWI8uoxcZhSy6bUEsTxpc1raFrelqhtXaGYBKvpp2vVWh8+RK+QKRMi/pm3
	 Qys9BgCmceM/R/Rx48vcHm7gSfCcgCZghXRIaGMaZA4v/Qb3b8vkWuBv0GufqnoAdBNtY
	 F1IfgV8AuWBlo6W4MbFK1icGWnxrLSRRIu08mZW0ST5uer2ww2BWa5X3hGg2ogfOpjCWs
	 fkJsfztzinJN/bYaL1ARjyKVN/PFXKlsR975qOnLw8pu6O3uigkQ7Di495MePo0QNxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmZNiyQC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2D59606A320;
	Thu, 19 Nov 2026 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YmZNiyQC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 200521F000C4;
	Thu, 19 Nov 2026 08:03:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795075431;
	bh=zvtIOukQliNBIGTgrX6fEI3+EJQR189chGORkbgx7OQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=YmZNiyQCx2+SishDJRUGIuXOWkmAJL/FwSO7cZAKfBW1ulT5rC0wA0Z0Mdk0U7LFl
	 XoZZt3jdSd9xWi24M73YdY1Wi4r3sgQz+AfvGaevAK3Y8lw4o0hvDZ/8b8pR6q7GYp
	 uGx5EeRwDTAFjCD2FODLatPBd7LkpgiWNAN2MC5ySwQ4jd5Y8TBx6ZZryMT+jJY5Ke
	 wOsi80tPUCGMgZaI+SpJE+BFYAl9xzbtffz/UMX4JG5+hZU6l3FhbAbuSpIuwbxxY2
	 +qLcYPcZNoqVv6VCTU/dGYyF98Ea9xbVqPcIQHb5soeO//iLrrTpXGsOL81rQL6Fty
	 lIxK2lYHEIXTA==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: peder.bergan@gmail.com, Miguel Ojeda <ojeda@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Alice
 Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot
 <acourbot@nvidia.com>, Onur =?utf-8?Q?=C3=96zkan?= <work@onurozkan.dev>,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, Georgios
 Androutsopoulos <georgeandrout13@gmail.com>
Subject: Re: [PATCH v2 2/2] rust: str: add an example for Formatter::new
In-Reply-To: <20261117-formatter-lifetime-v2-2-e216d86ffb57@gmail.com>
References: <20261117-formatter-lifetime-v2-0-e216d86ffb57@gmail.com>
 <BjdeE68zWP72joq06ujtSi964NHnVa7CiYdvK3JLUv2QGYJwC9VUUUyZHY0Sdi_pY5oNFSgS5KyDXPLDpPpErA==@protonmail.internalid>
 <20261117-formatter-lifetime-v2-2-e216d86ffb57@gmail.com>
Date: Thu, 19 Nov 2026 09:03:38 +0100
Message-ID: <87v75ttfhh.fsf@t14s.mail-host-address-is-not-set>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

"Peder Bergan via B4 Relay" <devnull+peder.bergan.gmail.com@kernel.org>
writes:

> From: Peder Bergan <peder.bergan@gmail.com>
>
> Document the exclusive buffer borrow held by Formatter::new() and show
> formatting into a live buffer. Check the number of bytes written and the
> resulting buffer contents.
>
> Signed-off-by: Peder Bergan <peder.bergan@gmail.com>

Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>

Best regards,
Andreas Hindborg



