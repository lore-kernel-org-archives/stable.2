Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794487739;
	b=xpJEAARj3se6uPKiEbfipqwIT1sUJM2ItFzj22LhDbWauSS29wC/Q251eRGkZweVQNvR
	 iCc/nW8y5B02l8Q341orxU3DHh6366pIx6pz/Oz9sF+spGL945rDgpzhZtya5AxET07E+
	 lfgBT6UxM96ArLqlAo+AikY2KIEHoWyxQo1lsyP0j3YA/x/VrS15skuDqvffcn2Y3DBGY
	 UBQECPAHm0BCHP2Q2kwv+cxLfPkAU8eBk5Gu3uT6VZXC74AFbBhE0zGlekdoRJosYbaFy
	 bVjkQTXsnUFrzuIPrK3WWXeoGZGq1B0PrJOvZc3ZSEsDP8eorRlFnE4ljRICEDIwbow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794487739;
	h=Received:DKIM-Signature:From:To:Cc:In-Reply-To:References:Subject:
	 Message-Id:Date:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Mailer;
	bh=WNjSPI9i0E18hyAz79IHT35Q9bphYXezxWEHllFLAWY=;
	b=dn5cOu5gvlELQT2emNj6QTtXBw8xN5ir+dDAcq90fcNOdz5W9E2onV7KlOGn2wvy10kG
	 DKkLGzeLUvA1dDp9SRrI/meeFP9lnvVf0Sq1wGgBLp5fIjNwIz8DdEJYoHz59i2MsM0CS
	 abtWBv2PGs/OyF1mY6iHqDyqF2y1K6RFgJs1JxHuf6paImX46ri2IxiuxmowLLQJrCkUP
	 IXJSr7rOVDX6kqRHHMj+rcwsn8ab9pXGMbGKsVls7ok0Cy5yK6WiCT5P8Zsck9PgbMw1+
	 snrjhRb1TZVJJKtOoPPXHBld/xA7GDUaU5RbIB34CHH6wbBsC+SL5D4cLay+AxEc74A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXlf6O8a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA90606A33D;
	Thu, 12 Nov 2026 12:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BXlf6O8a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 182EF1F00A07;
	Thu, 12 Nov 2026 12:48:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794487739;
	bh=WNjSPI9i0E18hyAz79IHT35Q9bphYXezxWEHllFLAWY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=BXlf6O8acfLBiqc68Kp6LNTKQs6a83pBYz57Sod4IW0xUkaXP7D2l5EwWDGGVVXJx
	 1acFzjbbPO+or7iweUmDv7NQs4I6tfG+UfA7oRIkboiVX/J2oMHvSDGK0QIO4Z9zsq
	 1kyOszMBVRAykDsro6JwXbu81DFpViGVTP0FEgQ+a6DWLRZ/dyyMZOVmGk40MI5nAl
	 cOTWbhkLQL8hryuGEcMvNsNunFO8TX2Avy9+2Y1wntlNResmzPZyWFn+zR0iTGwLMG
	 +YeJfcNP9QGUYgDiehE0FtFzRbth4rLTnoFd4v0SMrsTZBc1N30RUjv5iaxl5KtH2O
	 CdF3zzbLVnybg==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: rust-for-linux@vger.kernel.org, chenhan <chenhan0017.work@gmail.com>
Cc: boqun@kernel.org, fujita.tomonori@gmail.com, frederic@kernel.org, 
 lyude@redhat.com, tglx@kernel.org, anna-maria@linutronix.de, 
 jstultz@google.com, sboyd@kernel.org, ojeda@kernel.org, gary@garyguo.net, 
 bjorn3_gh@protonmail.com, lossin@kernel.org, aliceryhl@google.com, 
 tmgross@umich.edu, dakr@kernel.org, daniel.almeida@collabora.com, 
 tamird@kernel.org, acourbot@nvidia.com, work@onurozkan.dev, 
 tomo@flapping.org, georgeandrout13@gmail.com, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
In-Reply-To: <20261031103206.24051-3-chenhan0017.work@gmail.com>
References: <20261031103206.24051-3-chenhan0017.work@gmail.com>
Subject: Re: [PATCH v5 2/3] rust: time: make Delta division and remainder
 fail consistently
Message-Id: <179448764512.621816.4917112282648020557.b4-ty@b4>
Date: Thu, 12 Nov 2026 13:47:25 +0100
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev


On Sat, 31 Oct 2026 18:32:05 +0800, chenhan wrote:
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
> [...]

Applied, thanks!

[2/3] rust: time: make Delta division and remainder fail consistently
      commit: 9687257afe8c2c2c257e2168bc6c44e5145dc73a

Best regards,
-- 
Andreas Hindborg <a.hindborg@kernel.org>


