Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.141
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793939178;
	b=0VqnE82SajgTqCYl1PR7CHx6/HNvPaEWEx4EHqvlqSX3yFmmWotvpZnMCPO9wgN8afzl
	 YcLuLiivYSsU6eKllfgSdaSOn/o7WTRIuzkModHSY8Ruu8oVyIc+FKqnFYPp2iklTN74+
	 IDQAddWB2h/jcVJzVXL6NWJm1i8q+C4JqgRTGhHzX65AF9bxY8UOqxrRNJrXrfCbXIlmi
	 fQ20CdwEWs1myYlyvppW1EC0riu9vwMGDjMkKt0JfSHzsgmVYR4bkgvtXxaNar6vqOf6p
	 0LP+WJSNhvaTA+dJu7vcLPCNHCk9O9U1HT0RCDT07TuI+bu3S7Q02aaHeHqioPhCGew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793939178;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:X-ThreadId:Date:From:To:Cc:Message-Id:In-Reply-To:
	 References:Subject:Content-Type:Content-Transfer-Encoding;
	bh=TMhwPXDmKVeLyUGDFiFn31KGASsitjzgjFM3bRDRunY=;
	b=wUFxFwIUI3L92RVYAyCZRnbDHfff+92Ik1caImqYqKWJ23F5jKe3J16EfuwKmknYh7NZ
	 SFOEVKKL1pCQhmXCPslLFlrugVErmLnlpLIfQD7wM3EeVlPqNEohCwm1aPb2jaUdgrugm
	 EzPPYuyTYe5Ons6Ld2qyu8rrribvQjGwIuf1LOjZEfhX6WDQWueZ7659fGcz6W9uREGm5
	 Gr+Qzs4/v9v3nNpOyYHSsZ39JPVz8RhXf8/UHGOsfdwyouvUdldsKKKdMPGM+6HLTzEyH
	 YQZWvboyenqf4eKT/GhCXcYvVU910VfwhPVDnvw2yqGg49xUNUh7a+LeZba+UXW4MiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mckelvie.org;
	spf=pass smtp.mailfrom=mckelvie.org;
	dkim=pass header.d=mckelvie.org header.i=@mckelvie.org header.a=rsa-sha256 header.s=fm2 header.b=TXV2npo5;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rrtbygPh;
	arc=none smtp.remote-ip=103.168.172.141
Received: from flow-a6-smtp.messagingengine.com (flow-a6-smtp.messagingengine.com [103.168.172.141])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14EE7606A31B
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 04:26:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 14EE7606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mckelvie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mckelvie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mckelvie.org header.i=@mckelvie.org header.a=rsa-sha256 header.s=fm2 header.b=TXV2npo5;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=rrtbygPh
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailflow.phl.internal (Postfix) with ESMTP id 4B31B138085E
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 23:26:12 -0500 (EST)
Received: from phl-imap-04 ([10.202.2.82])
  by phl-compute-01.internal (MEProxy); Thu, 05 Nov 2026 23:26:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mckelvie.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1793939172;
	 x=1793946372; bh=TMhwPXDmKVeLyUGDFiFn31KGASsitjzgjFM3bRDRunY=; b=
	TXV2npo5QCu7x1+QKemOfnK9L5Ao2biReIjDX4nqMiyXMF8rDEmy6DzNbA7epCcZ
	86YMiHCi/iOvj8iQBvnK6lvsrkp2t0uFn3idzJaMRcKd1Qssj2qhIbQifzHGNwib
	TClJ1MJB9dMenulw9J3iEdGShbJcJtIJEVKSeAv6PoMmsJXuT36l72FUg8yraJyA
	M5dpx1TyoKmJh0aOUya1aWj6ttSqDhwR3Jwjr5vNB6BDGw/dr0AjgBR1u2r1lZVN
	lJLQcuJx+ulGrKszthM+N5ZVb5qb4CxFWu6r2s2wj46bMw3ACCpcnlwr6hP4iwVK
	0d8Fv2IdG9Ky6I23+WW6YQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1793939172; x=
	1793946372; bh=TMhwPXDmKVeLyUGDFiFn31KGASsitjzgjFM3bRDRunY=; b=r
	rtbygPhjq7hKXggD9DXqL1a5ZGNj5kNR33WwC9SLQ1qk45AsedD52ppD36C6gUgs
	05WF3Z4dftnPFSfaWFrGidh7um05tFXz0LTwY1PiYbsnd9Fc6wlDaqvjHDwA/s25
	hSxa7tNLltFrd2DcLU8HHYhJxFGQEdrIIhkDzhAtOHYtNMgCovmpi1/EGWyzsS2z
	tU5XbUtT1NrlkJAW2A5tszcVH0ieY5ZviVpAmfy8Uwm63PKCXXZq9XrZ87RiIC+S
	FY8m9g6HXJ5YQ3w14l2g5d4/gx91qtmz90tFdUlTtWrOwoU0uMQL+uFEJqg3556w
	TLkm5j6mlp99Oop1KSgpw==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=mckelvie.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793939172; d=mckelvie.org;
	mf=PHdhbHRAbWNrZWx2aWUub3JnPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:NQ59zsbIhGyDC8e+40XVV4j8Gx3TErBRjWnjWdnTGJkKUkx
	Cj3oo8nET+2tQwss4yoG10NH1Yu1uigZ8P2Wh14Ls5Zy9e9G8/jlDUKv36V1InPS
	cE9e8BqP79u57gYpElhFSk15ThmKtjPR1lXYckBTQ9PgX/yUP3n43NpBNBx67BpS
	qKcM1aCctKoIZiRrm76KTbgKACpTMlZYDKDzv8Pv0Q5hp1XXSVXNGbZcVUbSAKJG
	vNozyQLdCGOOcobgll1L9AETwdaXME3PlHKXjc/JSv5byyTraGcrspWU9WTEccyD
	V3qQeUq0IAb1Wblk/9oy6IpjIcLKKfX6s2WoTBw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:1+HEFl9KB+5+ObxqHZUBs0UQSvgDzYmewkMZ5efWyzA=:TMhwPXDmKVeLyUGDFiFn31KGASsitjzgjFM3bRDRunY=;
X-ME-Sender: <xms:5FbtakJaXn-Su2tkyqaaMn7wccsuHE-wiazY91NVp1wHqViRZPm8zQ>
    <xme:5Fbtau-NqkyV6xrK67CcCSXopI_YVRMNA6g721Zq89KxUDWl_QTtleCwbzF_K-6d0
    obG82Xph94P95npg_hq1fvhwU5740DrZE-JzVJ9UFpwchZN3MyDcNL1sg>
X-ME-Proxy-Cause: dmFkZTEH7DchhBBhKr2X6eIb3gkhg9GBwSJ9UIS1CRl8HFDrMjbkYXlpYQ1NuKZM5TnCgR
    /AD9Iyr7jtsz9Va19ChvZIlvwGDzMTLDlg9KtLax1QbA0dh20LVPaLlGAxe6Sj2vAeReBZ
    vugNAyzW3ai5VnL74/vvuQasLU2AGLukCqQJkwfgWZk8zOABEmwnu0LoWE2M9hpCmzBXAv
    mc/t6hlsGJ3eQmSqCrN/r0XeMkTyH/GHvCunQVO6yIxEpmDpAMxJVsy6S4e5hlwuxDMlhU
    dZFVAiPNrDnUe56sltFgSElxq/xT3xgonYjr0HMUVL7Vk1Dt+eXhmJScot/rEcq/HutpDj
    RMYV0Ix4Kj7y/QXZe1plecK1Gn7nUDYj93FBiCvXdtBKMuR+ZiMUD6bL9jwUmsDJbPInOY
    hMQLjs4jCUKNha9nhhBDZANjnGf3wd5cgn6fUXCmuRFfUucFwhWwMTASfM1o4t+s+EvwIk
    DSgxBDfYeE6mOdHTXw6kHvTIQH4Bfd5ArBdDRhU8FqT4Gh56N4oBSSG02h/tmkPexTLt7h
    KKIFovSkOSmu7N9ZuB/D4SdZApFZna4lmK2nYs1WQO5B32FJ+RExPS/mzjCIXoKg9fR1lx
    3I8brP41c9Ju23RxLhVIy7vrzBbgdCEZFhBiW8JD7Gs8pfaXxK1UCjjDeQ2Q
X-ME-Proxy: <xmx:5Fbtaj2uEgF4WwuyFkdrc61pOagzNuDmPDxGThx2kljffSejseWoBQ>
    <xmx:5FbtarZtqKeNXWF3-wFB84hMIJ1MmsPlw_eSSU6tIi0qJp_THr7Mzw>
    <xmx:5FbtarIJhhPKMRJbGtdUzoA1suPcqQ42IELYHqwOOz3y9D6TgMXqbA>
    <xmx:5FbtaqErEJjmZULwsbD8xUdxOwnpjHsJv9zMPNv_DE5M1erRsVFZ4A>
    <xmx:5FbtaqCmBna4gFkBA57V9X77QxNC04mOhyJc7HFOzfm38vayaiQaWwh5>
Feedback-ID: i53594642:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 0367DB6006E; Thu,  5 Nov 2026 23:26:12 -0500 (EST)
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
X-ThreadId: A9qJPwTAQC4c
Date: Thu, 05 Nov 2026 23:25:45 -0500
From: "Walter McKelvie" <walt@mckelvie.org>
To: "Eric Biggers" <ebiggers@kernel.org>
Cc: herbert@gondor.apana.org.au, davem@davemloft.net,
 linux-crypto@vger.kernel.org, stable@vger.kernel.org
Message-Id: <2e4c2648-72b2-4249-89d3-8dd111b84395@app.fastmail.com>
In-Reply-To: <20261106041439.GB3877@sol>
References: <20261106034150.1159818-1-walt@mckelvie.org>
 <20261106034925.GA3877@sol>
 <47a49300-5b78-4723-b67c-4320aadfaf43@app.fastmail.com>
 <20261106041439.GB3877@sol>
Subject: Re: [PATCH] crypto: algif_aead - Allow gcm(aes) for privileged users
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

> Can you document explicitly in your commit message that iwd can use
> "gcm(aes)" indirectly via libell's TLS support

Will do, I'll send a v2 patch.

> Do you have evidence that AES-CCM is used as well, or did you just
> assume that one would be the same?

Yeah, I just assumed based on the ccm(aes) binds in init_supported().
I double checked and it actually isn't: the only AEAD user in ell is
tls_change_cipher_spec() in ell/tls.c, and the suite table in
ell/tls-suites.c only has L_AEAD_CIPHER_AES_GCM. I'll correct the
commit message.
