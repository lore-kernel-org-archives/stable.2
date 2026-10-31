Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.159
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793447110;
	b=MWgwcJ08LKSotOj+IlLlZy3sEzCpgNBESK/Jf+i25HKALd0tLHwUmHfB8xhd/dsNV+Ft
	 z3aQrC0NOdjJsPUPPDNc0hgdkqHSt9nPXXrQr45WiM9QudkeuDj30o7CrQHrCvfs5gKDr
	 6nMBdZ7JdGqEWb4FPmXbQPvxTRlxQP9SR7uOidJnCxoBouxsP7mIWhpWQJCR14BZoATBG
	 AQaHSKTChV4ddWPxAyienMYuY5x5tA/9qHCb5QTNGgb+T98t8mG9w8mtCIjUg1Iji48Lf
	 R0E+VKoBanEJHXWyds5l2EWRo4paZ3RS6z7h5mCp7o0ezaWMY7135vWtmfiBApAqXew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793447110;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:Message-Id:To:Cc:Subject:From:In-Reply-To:References:
	 Mime-Version:Content-Type:Content-Transfer-Encoding;
	bh=yh5/viyfu5/4siOeSTWNKrs82ssQB+LUPwEsikY9lcE=;
	b=efGfQfYXh4s7KXW73dDkUkg3J2kyfjMvpRKGhsoGNYHEd/yY6gtjEPlGQQHP7Zl3wGyK
	 z8WJ5NGIpUm9JvlmIszlqhRbzfr7NRrfjpNn6Ny3vU/REtDE6wMiMzs9bClCRod343i7N
	 9s58vIUYaaRMN7ynbr+FY3oPo7TSat+8R3YPGe5dLhrbzzrf6At8bktkuHNzwYAS6e6B6
	 G7AiHPX2SEAG2qW031fX6E+awGAbjhM6hmnjbG0CbK23frqqjtRMj2KANORPlRoCZcl+j
	 bu0Alfnx/BFQYltW2ZFynix0ZK3v1kxYijJYYisMUsrAiK9Of5Jzp9Goyd6Y4kzcQag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=flapping.org;
	spf=pass smtp.mailfrom=flapping.org;
	dkim=pass header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=cfvKvvQQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZXOkY+BK;
	arc=none smtp.remote-ip=103.168.172.159
Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44105606A321
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 11:45:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44105606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=flapping.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flapping.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=flapping.org header.i=@flapping.org header.a=rsa-sha256 header.s=fm1 header.b=cfvKvvQQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=ZXOkY+BK
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8CF461400214
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 07:45:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Sat, 31 Oct 2026 07:45:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flapping.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1793447103;
	 x=1793533503; bh=yh5/viyfu5/4siOeSTWNKrs82ssQB+LUPwEsikY9lcE=; b=
	cfvKvvQQK0Till+ZvkhKrooF1GFzpPk/cTtcTzL5C42uYaftGbASwExLaMnH2SqE
	53XYMevv7BltNRV7VHEcNq4zZYwpGtE/bWwZsgHCPEn2oigpnBSYjh+EPdHidMIs
	FBX7L1xqM0OI7sXBCYrcsvdwmp4AsqwJF8jU3uSqRDvHw8sQntfCGD2TQ52f8Xsk
	s9mTaJN0jULB6/NVXkzRt+T5Uzaj8N9+fjVFoLmS65CtgSW22tZ1tFa3efw98EuF
	H87mIrEWu+DTiG5QJj+XrkNjUNA0FkKqmAioTI4JMfFc1jkhk8Mgx6uvU0nF8UB3
	JrVk/NB0imxkEaLtT0f8SQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793447103; x=
	1793533503; bh=yh5/viyfu5/4siOeSTWNKrs82ssQB+LUPwEsikY9lcE=; b=Z
	XOkY+BKfZHTse5dxNa54bPDrR9vMh419do6VV7dAGlC6Q/6+jCMD+HQaRYM/3D6/
	ehw/Xoshfu6FSzL9sEvSVfDQiXJx+y7VCX5foC+4z+JL0gyGw7W5ATrBigZqxikp
	iFlTmCReA2UlbkGQ0djdeI+C83HwXOEpGPO8ARX0yueGtMzgwwllZEV0hGNYhzqU
	c3eskfCbz2WDinXmt+jgzh4GxhyJlwougFkEHsVxFKRjhHgb/rJOZdgSeNwE4nwR
	+D/dkZLvF9632nZSdl9G83+IPYVnyYtEppo6nhiR2hX9DtsVavVDHsOV1Q/z9DoE
	XYnnDDPAVd5xCL3H6I3kA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=sign d=flapping.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793447103; d=flapping.org;
	mf=PHRvbW9AZmxhcHBpbmcub3JnPg==;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:ZloP2hJW1pcHuzb9Cj/9PC6ndhsINXvKvTwBmZRkYuPzLta
	Tm4V1c4ad1cDh/vy05LPTqF7z4i3HuFiA9HOsMFAv3NbSKGE2/xHp+p5PHjE1vVh
	Wr8j7H0zBWwpMsfQdBVVBpfdfO7Q0AHutUM/HIvoA7NwKiEy29NvRC4pLCHCMEBH
	r/VOgCE8mbRdPXm4immqZPY+VOIcuRV+zA7orJZ7CMrl14UXm11d3X0oLwvDjSoN
	he4tEmZqiiM4t6AzluYk9cSpkIoc21crlKyooYWbCQL6uYu6QROKPRu0xYWaRywZ
	WKUEryPL7LDI5lPmFkizJ+nxpba3Xc+uSnJmhsw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-08;
	repo=github.com/dkim2wg/interop; date=2026-10-28; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:KXLoH1m/hV1wdE+3oTpYMjEPpvFJYk5uqNHzi4shSqA=:YyWA9MNFewHphcHPyxED9CWS9/SONiVR5GIBBIDtxTo=;
X-ME-Sender: <xms:v9TlarEctQ-huGeWNrppPKwYyaza21w2Ojw5JUGUKFrXTNYGCcax9Q>
    <xme:v9TlalyD6qv5t36r7s2n2Fqv1xZlIpRcCPyDh9DJxX-_77lNw2qnnkrS8VF-5IwN8
    JziAoZV9b8e9lM4Zfy06zwlg2Wdj7_Fp2-oDohU-I9M_5FgNul1pEMb>
X-ME-Received: <xmr:v9TlatFR_-O6CJYslIWGYvPQXzccM2WHzJtZHn5OUKg22ay3RQA0EKun-L7Ja93olMPwVS2npeK301d0fT8KmM0J>
X-ME-Proxy-Cause: dmFkZTEZRQ55MN00/HAZ2yP690811VpJh/TI4buxn6M2o3NJe5GvuNqDXbYicOWvZwLzOb
    e/PEMlu2zxYPd1bx0ooNMwpUS0TPxcwzYtgt9e9SloI/dF0FXE2HTWTmaVLrAN+opzQ3MA
    N9fFCrr0rPPRJaOZ2jUGi+qSI2xTPDpp8bYwwsy3Yqm8MY4JavcjO0sF4UiCZDUm41M+gy
    gCu/2VBFATHVcV0EJKNJzzL2fuLWhbl2EGpXaXecQm6JUrTQBuOF4RwxiQfahFAhyBJybg
    v0Kbdyr8PFkIShXSBd5B++zc6oOsa38ZOTNZk4eGeSWhlNRsXNIGsP4AvFNkKQeC9OeylK
    FsSxQA5PwNbk04rZdcVTnKKr6sjE7Lt8zgKaoUDtCLgMk+ZWK2C3doYUT/h/E1so9XRRKV
    1gGSMrSNfn0le57VMnceK1BjzW8c9f0Z82a3r7DM9G12XJtDfmKY7KJJdnKZTs7R8eNumz
    QCHTKrUF76FcGM2tHGqqW+bNyFL1JbOOGOvkNlmbcYnghrsZQdL5NeMTGX9HJuyUhTLiTz
    0ZP3XPIuGfRXIsl9YnrmiNJSD84ro3SUVgTXnBvq2OPfJ4g5oqQKosSjKDPOlIxtrfecwB
    B8Ru6h0xplYIs08HazmRSBG3ud/bTte+wzRJYwDtFMKtGEMbKURVaWyjU9Qw
X-ME-Proxy: <xmx:v9Tlaqs0KIwHRU9mLi5NOVXDb4VaGfxhYgmN2xU3gPWojxSZxXSqNw>
    <xmx:v9TlahVn2M5m4y1RxFQLjmTuxAsgsX6GBTbzow17p6bvEMG700O4HQ>
    <xmx:v9Tlaq7zeq23eCyj2tYhE5kuo27K2uPKifOYwCXNx4dNriboIIzjew>
    <xmx:v9TlalZ-gSbYk3vQowgasPq_sj12coZfzISKRwz5zB0lD6r0XDqmmg>
    <xmx:v9TlaiJJD7PBCQ1JQ5_seJXitBfxJqMUQKxheitCtz2DiVgHyaVVSuFa>
Feedback-ID: i51fe4b43:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 31 Oct 2026 07:44:56 -0400 (EDT)
Date: Sat, 31 Oct 2026 20:44:53 +0900 (JST)
Message-Id: <20261031.204453.2065904807866384795.tomo@flapping.org>
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
Subject: Re: [PATCH v5 2/3] rust: time: make Delta division and remainder
 fail consistently
From: FUJITA Tomonori <tomo@flapping.org>
In-Reply-To: <20261031103206.24051-3-chenhan0017.work@gmail.com>
References: <20261031103206.24051-1-chenhan0017.work@gmail.com>
	<20261031103206.24051-3-chenhan0017.work@gmail.com>
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

On Sat, 31 Oct 2026 18:32:05 +0800
chenhan <chenhan0017.work@gmail.com> wrote:

> Delta's division and rem_nanos() use Rust operators on 64-bit and C
> helpers on 32-bit. The report shows that rem_nanos(0) can return 10 for
> a 10 ns dividend on ARMv7, while the same call panics on x86-64. The
> i64::MIN / -1 case also differs, and neither API documents these inputs.
> 
> Check for zero divisors and i64::MIN with -1 before the architecture-
> specific code, and document the panic conditions on each method. This
> matches Rust's signed division and remainder operators, including when
> overflow checks are disabled. Valid-input results and API signatures
> are unchanged; invalid inputs now panic on 32-bit too.
> 
> No in-tree calls to either API were found at the base commit. The checks
> stay in the existing methods so the fix does not depend on introducing
> a math module.
> 
> Fixes: 4521438fb076 ("rust: time: Implement basic arithmetic operations for Delta")
> Reported-by: Georgios Androutsopoulos <georgeandrout13@gmail.com>
> Closes: https://github.com/Rust-for-Linux/linux/issues/1254
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: chenhan <chenhan0017.work@gmail.com>

Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
