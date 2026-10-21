Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.144
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792568010;
	b=odi/7EoIy5fwysP6STtj6/N7C6jhoIqCzAwysHDkJjJ0tWfm93uCqNShEAkUlLvOeA3L
	 0j6CsGV6yDgCL0Nw2sOAwikStzXHl/9hA4tn43tCtyfIszpP6XAYfBb9TAhuVWJAcXzn5
	 z1muJstObzpxobLfzCEqMJcyn7ZmhRqLx+GDDU+55SXzsLeN4dKciPF2RL8xKO0W+vZZD
	 iJsM+wU107+xb7+no5xfs2ktW35mCAC2HlJpp8NAHKyirED4hbV4rsOwN/VrQEkgEwSq3
	 X55dBSjS1xSJDhKM6U+ne/OpFoUB0FfwmSecAUaXuPLJV3p7jWeGsLcWKN7mtPLjD4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792568010;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type:Content-Transfer-Encoding;
	bh=uVzGXGFEaDe1Jv5P3wq/EEUrc9Mo9DIHRPQwOT1ZGe8=;
	b=y9nO3QJnplabp+ddRUvq3B6Ks+lMGouE2/j95PZtEZmPGOq8dAbLHx45wNjjFyrkQKQs
	 OUpWKvOSBHd0/KX8mTBimrQ+pal9bfY9shfp97Ay5lX0q/VUX+VodwLYwxQMVspD1xVMx
	 ABY9vAf9sttVjIrQ7SJjv/xcDGKOqRs1noho5XMvBl9nHHrCmThjPHNx4R1Bg5hZkh7++
	 YiDj6da/lKkGpkFe5AJ38hXKocTL7m9cqXyLYPJQ17uUaSTC0R/jqviY2aWe8bYjByZ4w
	 8raZLliDGTeNVs0RqOW1K4/TkxpY/N/9Q71otjaovexSwD7NxyeoNmD8r9uFaTJdb8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=H2CZAlNU;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MeoTVJvo;
	arc=none smtp.remote-ip=103.168.172.144
Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9377606A31B
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 07:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E9377606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=H2CZAlNU;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=MeoTVJvo
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 58B6AEC01C0
	for <stable@vger.kernel.org>; Wed, 21 Oct 2026 03:33:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 21 Oct 2026 03:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1792568008;
	 x=1792654408; bh=uVzGXGFEaDe1Jv5P3wq/EEUrc9Mo9DIHRPQwOT1ZGe8=; b=
	H2CZAlNU4dJN4nZ+deU/xL+rLNt40eM9yOaxC7LoCAEUdPRkldX21YR12nJ+XUr8
	3DMKxEi7kNuDzLriFSZllXka9gGUOjbF/jobdAoHm1X8y+yeb6WCv50xto8eOuZq
	MfRiuA3eyOYVMdHsLTMYmvnJ66WUswmi7bLyWgPKNEnb9Wq4TLC4dRjYCshqRx2T
	eESh/Q+eU4B0ZLGXNhO81jgV31NxsmIJHlyYMZj5WetcngX+m3LLcJvwkpGwG5pR
	y9B+72ASE8sdAzEUhE73wxnqvYK+jr3A3VrYgZUdy5nshO0sqW/Toaop8UHw6Qg8
	aMyT9DiUNpNaCs4GWwxFVw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1792568008; x=
	1792654408; bh=uVzGXGFEaDe1Jv5P3wq/EEUrc9Mo9DIHRPQwOT1ZGe8=; b=M
	eoTVJvoMSmfhJTi68FsgDFtBIPRrDKDuWAX3leqxy4fMbvGClEdkC7RBvOvqWkur
	ca9rkNDo8bEsfq4uIlhNoSzxDX8/4LQXzdSJSPavLatUAeGNiA2cdW4EmTu+oD/u
	6KI98tIHVnATZaQP2KZI3vutc242IoCPYfAlsJqxbbZZFOhigAvFzp28cdlQDTFg
	C2Enm1Qv2qBKQYjoDfE2xh+l3TeMJqfMdNHocQHAe0cuIGOZAfTon+kcFBqDxx30
	Cz4ssk+s8DHvy41TQVAZ+GGVr/W1DxPpZbTT24YMU+MpFGci2MWRplgXh1YzzmCG
	nk9zGAmocLUsb22FfDzcQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792568008; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:rmJIIDJ3z5aTBMKM1tE5EYmn0qbYJssRXdBRDdZ1p5gY8aH
	hqzbuKVm5TJ7YQQBOSPajrzcSpww5a1GDo58Psewx5G3C6Majw2XW0b19R9Dze8H
	Hkq9M5IJg5sJgozs/KpPgPLdUJmzerTW/Z/OwDKJCVzkqM5fVRUM23rInmU5mMTB
	KpnrGixJN63cmUfglAs7ciqB1Zy4VxBhFhrpy09IZCvpm7PuVlqtEfcagz50McSs
	3geaONeWwLYdjIZwViuoiImy/UbX42cjfSTguMv14K4HKzy7QM4mHfBfQqIn2Etr
	feKJwVSnSrcyo0HbK1cr5UYh2XGIX/jaVC9ys0g==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
	repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:sE7oviaG2W9U03+NUO1ZCJgJ5kzaLF7Ubos/2J9o5AA=:aIxrJQw6byJSSpI7JG68txUCarZU1Hc6/3WckQFzdGc=;
X-ME-Sender: <xms:yGrYage2hmGQ4G-an03e3gvYKy9AfCVIu5WbSu0gTLw7ukE9GiJlpw>
    <xme:yGrYavoQNMHup-ZRl0i_Nl0LAvFFiFvkYwozl80MotUsNYVH-5k_n5kCV4GuQ7d8F
    O0LUeEx8lkQjZGcPXqJsO-AHFAVnYdpzayerwV8aW0fnYYzh5cnpTLV>
X-ME-Received: <xmr:yGrYaheSNJsJEpEBKQlG7lWCRiv2OjR01-BfOSJMuNPeH8wVnCOrjIc72gWJKvsQEQnMyyuaPZwA1I7_D1oGe_ij>
X-ME-Proxy-Cause: dmFkZTGpVTHn+SydJJT+VRdoTPrvGprGGVNIRF+afNyksTljI/Xz7ouNtYDX7THXy9XbOF
    JGB8Rol1p2S2ksGNH3skRUpPGxxs44MvhLa+/OyhtEeBcu5j5bRa+cVNNtZz5jmWl58RGz
    hfJCyX8x7mn1S9MXhKBvzTZYRkP7Tq+4cVthmDwsOA5BzUbNhG9TVk84hAQDq3xMKEd1Rf
    xm3XJuochdBuUcTdvClfqF/K49B3YJJ5o1n6zBZIgTW6o1rpwa9XaDDihmK9mmzsnGBq4m
    tqxXHJ29g24JySuuiiOVHgUwmIWcZRskKzfvX47BXmuutqmStjXWTN8t/v1IDQT5Gr5yBv
    IbbsOlJZ4cbWNBjVCOYa1qAbVz4TRJRd3tPVKSh7vQTQ916/jf581kV3OzXBS1UtYN0Aap
    RdA0ire71HaAkF1igf2U1BQIofJGw70oV80d3UsrfsybdWclUIvSlSdC76TlEwAFdTwTcm
    nJdmIfCaKGyxk+4T54+lF61F8D7qr+bzlmCPmofv1GV02iYrwL9kS1bW6oPWHIqRe3Um5Q
    Up2W57m5l4QTBw2nGif0a54AZyK7y8GFHgcFhs1L4bRLnLabHmGJhBKvxdqOdWLUjCQKYa
    rLM/9v4esMOAr+GS4xFx3wpGQrYwRarizTc81eNig2hL7ld/CJEnYAFryA1g
X-ME-Proxy: <xmx:yGrYanl2G1ptoFiX593oJTYOnLd7XEq2CDDYMCNjN8FSiVaizO4xpw>
    <xmx:yGrYast_clruEqrFMBFv3KJvIVdxfpcX74yWbqGKyQhMhRj2RqP2UQ>
    <xmx:yGrYaiz9EiwnTP6rDnWon3ax5og12YoCNZcX8NwRtdAThlcDx211hA>
    <xmx:yGrYavy87Klf-1Zw4c4YKRU77MsPTmBuaUfGAni7lPyQxLVYhUun-Q>
    <xmx:yGrYalNcEYcYdl00-2zGjMBALGGtnnZ0_Yws_plbzRuYV_smyg9KPS5R>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Oct 2026 03:33:22 -0400 (EDT)
Date: Wed, 21 Oct 2026 16:33:20 +0900 (JST)
Message-Id: <20261021.163320.943019405320974844.tomo@flapping.org>
To: chenhan0017.work@gmail.com
Cc: rust-for-linux@vger.kernel.org, a.hindborg@kernel.org,
 boqun@kernel.org, fujita.tomonori@gmail.com, frederic@kernel.org,
 lyude@redhat.com, tglx@kernel.org, anna-maria@linutronix.de,
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com,
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev,
 miguel.ojeda.sandonis@gmail.com, tomo@flapping.org,
 georgeandrout13@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Subject: Re: [PATCH v3 1/3] rust: time: rename the rem_nanos() divisor
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20261017111134.22546-2-chenhan0017.work@gmail.com>
References: <20261017111134.22546-1-chenhan0017.work@gmail.com>
	<20261017111134.22546-2-chenhan0017.work@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

On Sat, 17 Oct 2026 19:11:32 +0800
chenhan <chenhan0017.work@gmail.com> wrote:

> The argument to rem_nanos() is the divisor, while self holds the
> dividend. Rename the argument and correct the documentation. Drop the
> architecture-specific implementation explanation from the public API
> documentation; the argument type already states the divisor's width.
> 
> This does not change the function's type or behavior. It is a preparation
> for documenting and checking the invalid divisors in the next patch.
> 
> Cc: stable@vger.kernel.org # prerequisite for the Delta division/remainder fix
> Assisted-by: LLM
> Signed-off-by: chenhan <chenhan0017.work@gmail.com>

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
