Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.12.124.156
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794755934;
	b=HRcTP0+IAdEuP63G1YP0K6Uba+1XOtljr8fPGC7LeCTnTO3PgZEULTEsg6VE0kvDAGC0
	 SEmMRNlhwP3UAMpksZKRXuriCtlLqRLR8l18Nu9TUOK0qwyaKKk5vy7BGmfs5S3sy+MvE
	 8xqaMBgChYZMyyaRZFge2WACc32R9yNBRQzhOYVH2RZgzsWhetIBbD46RnIqJDkzXIYdy
	 49ryuIVEPtOE5eAaIybHqp2lorArsLUTyBq4WYFjSuWzXNYhdm7uWN6Wq1oh9J29bfUCs
	 DraHqbkPtZxYvQHeJ3ZzD8gV7ecoCnFDGPaKeq0x5vVlJztNLTn4WpVkZS2h0cQOKKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794755934;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=jXL3awY87I7bqCpFDm1wxAqeA5Al9Z5LUc/nPR+6gxs=;
	b=Dyki81H9/KwBIN/7hd9NpzT8Lg44LxDErpJL6ukDeoUKalyV8R82MR3MDmU9k4W9U94G
	 RK/gXfUnhUYi8grGMia9l1fmatXJu6hmW7TpRQowCDFawRcj+dVjDkZbLAjWaLUsX+Hnl
	 kKkmuG52ohZr2lylGFpZ2Yl94JQkGgfyAIP3s9bpbopwz1uEosBZ2nQKMeen8tSIDQn51
	 Ca15Wt8JqiazEPdFyN8j2JMywcWnfMlvQ+oMeXA3FJXYMEIH+lJMPy8U+w4N4D7oy/ncK
	 weo8fxfsTh+FJWY6vr/Wsm6MNpFa38S2sg7aWceqQwpfYtaDOwEVOs/vj44Z0RMtxzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arndb.de;
	spf=pass smtp.mailfrom=arndb.de;
	dkim=pass header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=X3fyl0AE;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LN+XwsJg;
	arc=none smtp.remote-ip=202.12.124.156
Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEEA3606A31A
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 15:18:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CEEA3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=arndb.de header.i=@arndb.de header.a=rsa-sha256 header.s=fm2 header.b=X3fyl0AE;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=LN+XwsJg
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 23E357A0013
	for <stable@vger.kernel.org>; Sun, 15 Nov 2026 10:18:53 -0500 (EST)
Received: from ams-imap-03 ([10.64.2.23])
  by ams-compute-02.internal (MEProxy); Sun, 15 Nov 2026 10:18:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794755929;
	 x=1794842329; bh=jXL3awY87I7bqCpFDm1wxAqeA5Al9Z5LUc/nPR+6gxs=; b=
	X3fyl0AEfeBvHFst5Q0V1UEsQeby1BM81HLqcTKPmAuriRvCkJtvXMNqjk3o21zv
	tRZTqOGdm041GVhK72a39b/+gfrMUE98uXp4FKhaSjZZV8oiFStFk3YJoUx30HFu
	emCd5JhI4WFKRIwA0vTUqrxqf7llJjPNxk8UNRXyPYXOGmwjzoGCK/AVELeqyA1T
	Mf3+GebDYnpJmA8POXM/TzFfW6cYecKlX9syieJT3Fc/T/Pfi/I/VHV1QIetjC/K
	ngKqz1MHdYO9Wot9lKt5+xBAcbRSb6bfwcUppMqESa6XU/J/ngZvm1xn67zg7zlH
	CqSBjwTZpNagioRE6sbHXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794755929; x=
	1794842329; bh=jXL3awY87I7bqCpFDm1wxAqeA5Al9Z5LUc/nPR+6gxs=; b=L
	N+XwsJgSy6unJDUxVhbAN9jjR4ChGLpK09UWox0eeTi3aau0ZlGYyDgSYisfeo6H
	V0NpLW6Wt0EJ7sWWpm7PoXWnfTsm6X7EAaLlF2pdx6Hv6tBfS406PDbg7DqMSX9e
	pX20y1bpyPyRZEb+MLH/aF1FGcYJSvyuQMNb+5+S0ZXXSMhvoqIvLWjE7OI18ZOJ
	FXewkwQADJnGK1i8pVgotICZYo1BGU7w/2XVhokJKwC8EzlpkX+pzpVfrN5CrhEq
	aRem9s9O2dN16nywVapYeU0fUkXegPHJ6YXhVJ1yEfu9weCAN/BYB0d3rQtw37zH
	OqGoGoEgun05KfNlkXs2w==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=arndb.de a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794755929; d=arndb.de;
	mf=PGFybmRAYXJuZGIuZGU+; rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:lCIzTq+WPjRNpKxXg5GMozAbAxpeZ/wC5q8ZqlCAA/1mln0
	5HxAkt9eDeBfMecOwAt6dzAZ7BVYO4/MK9ntVLDSgQj2npf8SN7O38NZj1K6wdsR
	QxfgfWKxw/elw0HzXJ+OnVgEWMrWPkUbJPysMd+enarGqm3rvblWJdXkKHrU7zay
	6+iZLOLBhwgC4GH5AKSASMlT5YVyTMsSy5zPXtVO4pJiEaqGOPKqVFt/1SWI39Kl
	L5HTTq/ZjEYifQYMvEhAKZrPR2GRtJ+gy3V9w7Dk8X7L7O3PedRBdRR6v8PV+Z/6
	5IVuipL4mvfynonpGiyVrpQ3DHfO74V+Os3zLHg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:RPRGmgdxnBnNv5uquxYy8MBAVAddXarUAKannPbarMQ=:LPIofgvPCh59qWtpBBu3/xvmkCvTHB5eJOFqs6HnklQ=;
X-ME-Sender: <xms:Vs35auF3ZKeoxzwOsUYqSkStVskbs4R-NGUIdeyhfyeixyyk9EN3ZA>
    <xme:Vs35aqIEdga0nfRUy1jvgxGicKyLl7wz4lxqhsowM6MD8fEPuqveb7hRDmyeV22hw
    eqH_O14ewKa36SMvMq3UQGHhWn8C5qo0Qy9uxzoAAV37KTnw9Vp-1Hs>
X-ME-Proxy-Cause: dmFkZTG0KPJjbF0MaYzlr1rMKbFVKZccD29mlx5DJ2nDT7gsDYCCpAPlozFsGDxohcC0/r
    rBNTGt6QIyhi+iHgRSTHcMZwGyMov7EYB/dRho9I5EtscXX8S47EQ95GzVnNrVZ7/87yQl
    W+t2L/rmREhnML0NmZgivhr89fiMdi0TupTTBVSxjvICnNewjWK5RL/9Aauzl1KonQ6Nxe
    NEWqX4k3HjKJETMzrTNMg238sNyGliWAM3YNCpjFRAvg+11+z0nJt6eJjlFMdihuPNbgIm
    oYg+mzbAvXGVjFYQFNtth3taHKaeWEkuhsGKNyHHNPiZcPoe08V914VpI6+MtAPh2X17cw
    FuBgm7wf7JfRdStmmfKL1GwGzkX4/BxT6+huZ7YIOqNgCkcHUAVroQ0OnY222fxJk82r9S
    UouzJSAmkJtqWmfeYCPE7yv5BfOT00gCZ9RF/HnUOSO2cSH4QXPDYMPsFB1melKmKAd5DE
    U8ZEMFMDe3MXzPL0Bf060i9FZ/du702JWrVBV7M8iUjqjTFwJk2g2RT2y3wMmwXo2p31BO
    TS/nfxaAXtBzKxURMxws+YH3t11fQ7Sj2TFX0JKgypZhMZtveSU2ZgNCOA9Z3ygn7G4BG7
    imxonf/MrJU+NVTafWwmyXTbOjFMBCs94nvQjGLiLz4+9S7XgAPqgyQWVsGg
X-ME-Proxy: <xmx:V835ahrv4y2-PQDiHSsLS0XYo1QHdz5R1BdqX1MXkUm-FttaFVZsxg>
    <xmx:V835al4upEkIi7RJYjYyJk2fjijUGXxBNFBHDXaCSkP3X5EicHxwUg>
    <xmx:V835agcOfApQazsMJguSEf37x-hfOcQn58VFpyTCxaMteRTE03SfOw>
    <xmx:V835ai6xj3oYcT99JabivV--4v_uh8k8TdJQfAbpvVX23n2U379t3g>
    <xmx:Wc35amsAonV99wwPoCZRTnv44dyVVUBYx-zoO6bdqCvwHDlfQyhY36aI>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 5C25C32A009C; Sun, 15 Nov 2026 10:18:46 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-ThreadId: A4hrlnFi848o
Date: Sun, 15 Nov 2026 16:18:26 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Nathan Chancellor" <nathan@kernel.org>, "Kees Cook" <kees@kernel.org>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev, stable@vger.kernel.org
Message-Id: <dbf6e2a3-ac52-4d0f-a2df-b78163e9d57a@app.fastmail.com>
In-Reply-To: 
 <20261114-lkdtm-usercopy-wunsequenced-v1-1-d9f288701932@kernel.org>
References: 
 <20261114-lkdtm-usercopy-wunsequenced-v1-1-d9f288701932@kernel.org>
Subject: Re: [PATCH] lkdtm/usercopy: Avoid unsequenced accesses to cache_size in
 lkdtm_usercopy_init()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Nov 15, 2026, at 05:37, Nathan Chancellor wrote:
> After a recent improvement in clang to warn on unsequenced accesses to
> volatile variables [1], an instance appears in lkdtm_usercopy_init(),
> which can break the build with CONFIG_WERROR=y / W=e:
>
> drivers/misc/lkdtm/usercopy.c:431:9: error: unsequenced accesses to 
> volatile qualified 'cache_size' [-Werror,-Wunsequenced]
>   429 |                 kmem_cache_create_usercopy("lkdtm-usercopy", 
> cache_size,
>       |                                                              
> ~~~~~~~~~~
>   430 |                                            0, 0,
>   431 |                                            cache_size / 4,
>       |                                            ^
>
> Per C11 5.1.2.3.2, accessing a volatile object is a side effect. Per C11
> 6.5.2, unsequenced side effects on the same scalar object are undefined
> behavior.  Per C11 6.5.2.2.10/12, the evaluation of arguments in a
> function call is indeterminately sequenced, meaning any side effects in
> the arguments are unsequenced.
>
> cache_size is marked as volatile to hide its value from the compile time
> constant checks in the hardened usercopy routines. Refactor the
> calculations based on cache_size into their own volatile variables to
> keep the values hidden while avoiding unsequenced accesses on the same
> object.
>
> Cc: stable@vger.kernel.org
> Fixes: e47e311843de ("lkdtm: Update usercopy tests for whitelisting")
> Closes: https://github.com/ClangBuiltLinux/linux/issues/2195
> Link: 
> https://github.com/llvm/llvm-project/commit/955715460eaf9188c241c74750637fc82dfcc423 
> [1]
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

lgtm,

Acked-by: Arnd Bergmann <arnd@arndb.de>
