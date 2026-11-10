Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.148
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332079;
	b=tUPCTuKw/XTXnz5dfYFf4iaOjBiYwGHr2WQMZHgsC7xc9QKMRJ2fx7nWg9MH2zuq2l+s
	 ZlV+nUb9/j0n4mnHzyWMnF7x8O2GeD5vXJ0vjHnfpeATHAxdYG+DZM/VJhVF9YGpF3ZFf
	 3qkE0YDDFNraY7W1JsxC7NlrdwnBeOLX76gTVA0lCnh4SLL42CMy6ugJ81XXRL+MAMZ2l
	 Zhz0fWdwB2yKovoAMg3qhsyC/L9QJeKr3TNVKHrV+cBiwHJrnN8XAByVKKH9wH3KgcPMD
	 djL07hkIL+Y2XDyn4wX+iqw1YNtt1meCErF8XGG8uBYpcOZ9qN2H0EZwjE5AU2HT6YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332079;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-DKIM2-Info:DKIM2-Signature:X-DKIM2-Info:Message-Instance:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=34ODEgh3+FAJD5JbhVVbTI9a7jDrFzMiTcv8klwjWlM=;
	b=qmtua/Og3Gh52Nek22xOHgUjK+qILo1Lyx33ha0pvQjuG2hG1cIF6uZ9leoCsixYVPie
	 7mqGCiJL6hRqeFsvbCqaZGjg6W7Wx+Opx1CVq6buGVvy7qAyaCeeiZspQgct/eOfei/5a
	 qffoJmQj0jbcKXTPHO7y3lgEfmSM6bLHNMaVqJUG4g8tn4RF1f947ok1TeNJo60N2DtBU
	 aMTkZJ3kjBf2J1rCtETN3dnMxLFq82tZsAlRVx3GLqW4NMV/FIAWkfr5f0jkeeAH8pRkx
	 Lnhjff67ODRKSV0lFBswwPdOF7npy7XFG+nJQcFr8Zrz0EYA8cMGDHh8lg2AANg1h0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=shazbot.org;
	spf=pass smtp.mailfrom=shazbot.org;
	dkim=pass header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=1kkmLxfe;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c2X0TOdI;
	arc=none smtp.remote-ip=103.168.172.148
Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2B0606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:34:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F2B0606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=shazbot.org header.i=@shazbot.org header.a=rsa-sha256 header.s=fm2 header.b=1kkmLxfe;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=c2X0TOdI
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 53599EC0622
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 12:34:37 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Tue, 10 Nov 2026 12:34:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1794332077;
	 x=1794418477; bh=34ODEgh3+FAJD5JbhVVbTI9a7jDrFzMiTcv8klwjWlM=; b=
	1kkmLxfefJ1GOpeQDRHT5oyBPcD39lMZN4OoMlQzflxHNyJZBPrtkzINXhLdGsfp
	PyCVT8c4Ro4fKiD1GQpm1HfJ+cvSRmiKfw4Ii0cUBQt1sYMgp532GQihIJbXVUCq
	XxUi8yP5aGH31M/cYzaq7OwyC+z46Mpd7I4rel1T83EMFzLA/qmbuqJGbxL+h6Qj
	a2tDRIKc0r6cmTt40gbeNtGGyygvqRzgstqa1PRJ0VmUdgCX0mV5cMjLuAJ3+LJs
	rufS3QW03ytSU5o2np56onR6nUbNJjCDvLAI9UVoQWfo5y5twIOB5uItBpjHg55p
	64tg1lh1d2D8Sm5ZGpxKEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794332077; x=
	1794418477; bh=34ODEgh3+FAJD5JbhVVbTI9a7jDrFzMiTcv8klwjWlM=; b=c
	2X0TOdIo/hvbcYO8lUEIzueX7J63fTGyOnpl83eqvV2hDFNZQkMwGpyEOjymlz1P
	/oskVMvWUT6DrfatMjpOtGYjWWDumVMdqbvCvGHrNCnSizezWGWpgEnLnZBwCwsN
	VdV7LYVsAYwo/MdGLFlBZZu3YMkD17N1Gzu+aIfFkZADjS9Zw24uwIhbO7yao3C/
	f6InulNT/3xtqprnd4AzOM5Mfn0yVXMw6gWkoZt5zTABmd6BzHZYYSMhvkqyhnCX
	O1CRLioG371jQIgURocPFeyfEg9soTeXn3/aguoNC0fyh1JXVZZP41CflfhJ/GJI
	fDOk9lHT5JSRCykwaBT6A==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=sign d=shazbot.org a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794332077; d=shazbot.org;
	mf=PGFsZXhAc2hhemJvdC5vcmc+;
	rt=PHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm2:rsa-sha256:HoJtw9SOYp7sVY1RLRDE/7u6VNxrDUqM3xgAxo1+igytY/R
	jFJt2GvR/iR21QkLGEyLxbhTW2NuqRfBKL5dj69TXQkMDqecNTILtqrg7SZ0GKiv
	M44JS5ou2Gyhnvoo5JQRbKF18ovd5sJokGCXQ2kPkLstcKViAhqp0wNVyUgRkatN
	xOdN2GlhPD0NwGfxp4fkOkwpeKJBdi+ExCxqaIyA6EB/i8mr9GQbqbPntyoAv97N
	ijpiL4fbk/Ug3gzu32kNU5+nw7owvjITnC+4X0lpp80KQcIeN8awVZONeha4KjCG
	HWDjP+VpOZouSPqX4QdazCERYzZgruYG/f2hDUA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
	repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-transfer-encoding,content-type,date,feedback-id,
	from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1; h=sha256:j5EGXVVw93SNBXUJJ2dE05PR0u71RYfBjN/3IoGlRkc=:OizvlOtUbcQjOUuDe6QmyFt73nQXIcMPGe5y0Z0BmS8=;
X-ME-Sender: <xms:rFXzaklCw_4KhbgHn5Xfc4Vb1NKY3xPGCSkAjXPuk_UGWfo2-9vF4w>
    <xme:rFXzavgHo8MF8TRhu-QnIMVztHSFcvmgRp7yd97xzZ2M9vU5ASATyC3cpg5HPXUvH
    KNHF7amjxl0lOTTn-ngSK-cGHpIU9gSrOPhUoKGJbWPcWHbRfHK444>
X-ME-Received: <xmr:rFXzavE1qF5hjtOqtdHvCjrs7W1QwtVy1afVmXR0HylPdSWDRo8zPaDTsvFtnw>
X-ME-Proxy-Cause: dmFkZTGCd/In14w3y25iKTyFC3yOKrM7gSzH5eAyn8BNxBG+Q329vrnfJ+I9l/0vqPLDdt
    wg3SVRYPpsxeJoVRXLa++PDjg/lC5Wfg8aFVaR1E4E0D9baFoXNFtTv8dn/n96TvQBYKB7
    ezwYSNLTJOeosVGKnKp7IDvk+e1NJdZzxdH2j2Of6rnk6JKaTuzfJcgEZoLhTabZ3mbbn3
    wx6wsF/FK04d3hCyKsWaW4R3OCDlHU0VuHL9GZ0TixTITLQGgxvsq+dmcKbgRg5Av9qMIr
    y5EpX2PKOyHOOb+4EMLtMD1i5pfKlHcGHudbQQkZrfadKJMo6LXTTRYk4RJ2U+UNxAEsTS
    se/yc+qkpzsbZHQpTOJR5RNDtksWihVCLIY1n4hJ6Txz4tJ5ArdOMTBivJRuCemZGDyMs0
    3vD07PCrYDsx2mZ93bQfUHzAHeLdlfIUbF74Tekuq7ZJyz5uSlR33rpgsWFlmM65Hd+/wx
    v3Gvfa5wNrKiGFlGDK2i9rGPOTR8Rg1uwoODrkND7ux1vygGMIC3dG7dCov37mS8TYiI9F
    HhyTG0sQ2+uFWDmBiofyDmcerqUt9S+SAVDl/kUU7PuBWlUGhTDY31amus4JRYJa4Y+t9e
    KyhbQpqXsp2G7H7qGtO8IOBNS/jNyqC0MEo022ppWLkO4KGuocCOSsX3WCCw
X-ME-Proxy: <xmx:rFXzaptVX4JX5D5shB0tRw2sj1TPIuakCWrt1Ild_iDOD0JpslheGQ>
    <xmx:rFXzaocsZ1cRzbpfip9cgMs4FYtWdKYichEjJqMcX03iVAXD43hiAA>
    <xmx:rFXzanmoI5vW4PT2ac2kO-hX1a3Z5Ba3FXIwrXn9AX_s0ySlKtpv-Q>
    <xmx:rFXzajCCiRf4Ecb887FMZnry0KIc-O8rIAJ8NCKt4GDENh40XEdDnA>
    <xmx:rVXzavIlDOEBxljooTqE24OwAE7Bv5ZkikK2fPOS1UD5KEKuueks_MN7>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Nov 2026 12:34:36 -0500 (EST)
Date: Tue, 10 Nov 2026 10:34:34 -0700
From: Alex Williamson <alex@shazbot.org>
To: David Matlack <dmatlack@google.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, stable@vger.kernel.org, Abhishek Sahu
 <abhsahu@nvidia.com>, Raghavendra Rao Ananta <rananta@google.com>, Shuah
 Khan <shuah@kernel.org>, alex@shazbot.org
Subject: Re: [PATCH 4/5] vfio: selftests: Add sysfs_kernel_warn_count_get()
Message-ID: <20261110103434.48709eba@shazbot.org>
In-Reply-To: <20261029203324.1637772-5-dmatlack@google.com>
References: <20261029203324.1637772-1-dmatlack@google.com>
	<20261029203324.1637772-5-dmatlack@google.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
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

On Thu, 29 Oct 2026 20:33:23 +0000
David Matlack <dmatlack@google.com> wrote:

> Add a helper to read /sys/kernel/warn_count, which counts the number of
> warnings (e.g. WARN(), KASAN, and UBSAN reports) the kernel has
> encountered since boot. Return a negative value if the file does not
> exist, e.g. on kernels that predate it.
> 
> Factor the code to read an integer from a sysfs file out of
> sysfs_val_get_int() so that it can be shared by both helpers.
> 
> This will be used in a subsequent commit to detect kernel warnings
> triggered by tests.
> 
> Signed-off-by: David Matlack <dmatlack@google.com>
> ---
>  .../vfio/lib/include/libvfio/sysfs.h          |  7 +++++++
>  tools/testing/selftests/vfio/lib/sysfs.c      | 19 +++++++++++++++----
>  2 files changed, 22 insertions(+), 4 deletions(-)

I have a concern with this approach.  I run selftests in parallel as
much as possible, using multiple devices, each targeted at specific
tests, with other functional and performance tests running
concurrently.  When wiring this into my harness, I initially saw a
failure, but can't reproduce and have no log from the original event.

I've updated my local CI to keep a console log so that I might have a
chance of chasing the next instance, but I don't much like the fact
that any warning occurring concurrently with this test can trigger a
failure and the test doesn't provide anything to go on in the test logs
themselves.  Thanks,

Alex
