Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=80.241.56.151
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937636;
	b=VLTeR5AnGLcNwacKEnnLw6oFmuGsYQKl8j5hjk2BTfibP5md0zWmL3OhnuztHnBtF9pI
	 eQZfskQivwUamDYZsQZ4XWDy9jmlvY9SR1d/ap6jXwTK4ulihVBrAGNMGDwzEvCoF6qdw
	 OxlZFy7VyyDeFtIU6IEY8bzhRTSlmSfXS4i9yCd/PdV4CVCK3JpTq54ZulxYle9kHZeHX
	 Q6WzABPKGKYOudhHx7m5gTlFz+k8yeArLnsPFuBXVJEIv2RS/En2sVZpjKUR9adtxawWW
	 dPOJ38ddj5tT9LqDjQhtAL+ZDftdZlIHNyNDQsNsVDLliWjT3M+mXInXkDDHplmRQqQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937636;
	h=DMARC-Filter:Received:DKIM-Signature:Message-ID:Subject:From:
	 Reply-To:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version:X-MBO-RS-ID:
	 X-MBO-RS-META;
	bh=/lX51Mfz1mJ4y/S3UG7mwW4k5DzJAY1kWSKMs4mbXKg=;
	b=Y5Lb9Tw7CHGK15CEPqg5jNG6qJbpgDagi2sDa46ikUE2yX8zMCBiI2OiLhWHppqKOv9r
	 DVY60gMfQ5EW5Df1C7rYFOxV3R3JyBVWc1ArASEEDi4Pif/I7yfC2bT8HWjRuL96+Q3CH
	 27wIxX13p/H41voiFQFPBsFzBi4BpLOgaeyJj6gXaiKLA3JVQtumc4y16KecHbYJ2kXhC
	 Z+iBJwkGT5r2m1YmCY35jVbR1lKy2uQJaa4XAHr4s37NBk5nfRMA/LfoHcXVdlreSnjfh
	 vjCqyGaHIrWDfge8G7nc+xq1GroscdybPsEaEKnFNMr+5BHOYqv/XiiAAKBzmN5Jkng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=mailbox.org;
	spf=pass smtp.mailfrom=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RYTOeDst;
	arc=none smtp.remote-ip=80.241.56.151
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67995606A330;
	Tue, 17 Nov 2026 17:47:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67995606A330
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=RYTOeDst
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4jTXHL4Pwcz8v5T;
	Tue, 17 Nov 2026 18:47:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1794937630; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/lX51Mfz1mJ4y/S3UG7mwW4k5DzJAY1kWSKMs4mbXKg=;
	b=RYTOeDstKKPOhsZfw9LnuApiBQ0YwHDBumHIFGRDBY1WybOVpRVW4hgychjVPHh/UKowN7
	X4flyauLehyoqxmP1gIB+N5QX+s/lTn5WTNQR3S/P1am1iCxZk/Wo+VbmMlaiTlkMw4c4r
	re+Z/B1DR2mzn+GYWbPnfgPMhLJDf3A6d49/FNQIfz2VngzfL8++OTAFZEh9wqqYEoSjGi
	/sRxZzEhFLobgp/+moiCkLBQuyj8rsSF/fh1eFmUFwcL21WoYr8fBkhsrjOBIavBiYWKoH
	EzMlxnG8EX3BtgpgYCrhbD1IrLE8+ISllrHU1c/dMSwwrs384zMb15+vIuK5RQ==
Message-ID: <3005c4692d538785e225f9372e4a261dc457edb2.camel@mailbox.org>
Subject: Re: [PATCH] dma-buf/dma-fence: Prevent misordering for error checks
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: Christian =?ISO-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Philipp
 Stanner <phasta@kernel.org>, Sumit Semwal <sumit.semwal@linaro.org>, Simona
 Vetter	 <simona.vetter@ffwll.ch>, Chris Wilson <chris@chris-wilson.co.uk>,
 Danilo Krummrich <dakr@kernel.org>, Gary Guo <gary@garyguo.net>, Alice Ryhl
 <aliceryhl@google.com>, Daniel Almeida <daniel.almeida@collabora.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Date: Tue, 17 Nov 2026 18:47:08 +0100
In-Reply-To: <efce5fe0-6e7d-417c-93a3-35247b431448@amd.com>
References: <20261117090144.581909-2-phasta@kernel.org>
	 <efce5fe0-6e7d-417c-93a3-35247b431448@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-MBO-RS-ID: ecb0f878edf8740d1a6
X-MBO-RS-META: hx6d7wgupk6yr6hyqbay1awpyj4e9j6c

On Tue, 2026-11-17 at 15:55 +0100, Christian K=C3=B6nig wrote:
> On 11/17/26 10:01, Philipp Stanner wrote:
> > Many users of dma_fence do things like:
> >=20
> > // Thread A
> > dma_fence_set_error(f, -EINVAL);
> > dma_fence_signal(f); // <- Takes lock, which orders against the above.
> >=20
> > // Thread B
> > if (dma_fence_is_signaled(f)) // <- Does test_bit(), no ordering.
> > 	pr_info("err: %i\n", f->error); // <- Can be loaded first.

[=E2=80=A6]

> > +	//=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_and_set_bit() should do the tri=
ck.
>=20
> That should probably be a C comment, e.g. /* ... */.

huh, how did that happen=E2=80=A6
-ETOOMUCHRUST

I provide a v2

> Apart from that really good catch.

Found without any LLM 8-)

I saw it while reworking Rust-fence to force users to always evaluate a
fence's error code, i.e., you can only check whether a fence is
signaled when you also check for the error.

dma_fence_is_signaled() incentivizes wrong behavior.

But btw. we really want to carefully rethink our beloved signaled-bit
and its semantics. Mind all our past discussions about it.

This patch is more like a temporary hotfix. Much of our API is quite
fragile.

Regards
Philipp
