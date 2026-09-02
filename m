Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8E84A99DB;
	Wed,  2 Sep 2026 18:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788374504; cv=none; b=fpv96nGltf/rgAGWpcl3wqaJMV/4LYIv3/Y2BUETLQGGeU9CUKtNmwEyVzHrfJunZtXTxw6YqD+3K7noRn+Y8sdN/4TeDJdvFWzjv/bCQoLu4jcpRsTotE8HTx2RSqe971UqBEjaI0pBpknv/HLC2SLHXuXp6Y7pkd3U+0N8agU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788374504; c=relaxed/simple;
	bh=2T+oL2DyaEkOIyxo2iCCLOICyM0qOTxCA6ezLrNFSh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KYF8mYHpFRvYXxAMdA7vT/SiRNN0i3aeJMTKpbeIdLK27nGX5avtRed43Gza8yVKXUiRYtjmYaOndkfyYG5sl5i6RpB+qMf4Pxw5OkpZPGKNQafo9Yq/H55ohmAPFRs/+WpUQEaFuBGQOsb5Xickj7KpnSZXnI28bODppe9WiM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc91Iixw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc91Iixw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B595B1F000E9;
	Wed,  2 Sep 2026 18:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788374503;
	bh=UGPjPRycuDkNEMbvc9w4bT6qlMSUhqWdTKay8iwI1ZA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Lc91IixwC3QnpEoFelZp9Yxza2uax7t6erD1LNy7uZyCn77VYoBjCVEbEGNSoCjWg
	 RH3cVZvAd9ybWuSYZH8bR6bR+heYJ3bcWVEJuHlplc16Mb7vCw7mRKxz7bvwCPrxql
	 aBO09BADL+0epamAs+lIPHCnzv4cSpPCwFdZpEZq/Nw+77gTraVCy8N8ftvh9boflO
	 Y4EjHXL2wfhohrvEpHLltT1t2/uM3xe5pP95B130ZZwXfogdTzWpXnaVmBBESxAked
	 dWhiSLXTsTdAGDr0YbXR/pBqj8Xu3r3yyFEV1RSsXCk9Zd+EU+BQdTIKnhobNtLjzN
	 dGEIj37om9kMw==
Date: Wed, 2 Sep 2026 11:41:41 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH RESEND] xor: add missing vzeroupper to AVX code
Message-ID: <20260902184141.GA7698@quark>
References: <20260831212248.213805-1-ebiggers@kernel.org>
 <20260902133706.GA21538@lst.de>
 <20260902162359.GA2497@quark>
 <20260902191956.0834eaa3@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902191956.0834eaa3@pumpkin>

On Wed, Sep 02, 2026 at 07:19:56PM +0100, David Laight wrote:
> It also depends on the instruction encoding used for 128-bit AVX code.
> If the VEX encoding is used the high bits of the ymm registers get cleared
> (rather than preserved) and you get different delays.
> Flipping to/from VEX encoded 128bit instructions adds delays on some cpu.

All instructions operating on XMM registers that aren't VEX or EVEX
coded are typically called "SSE instructions", not AVX.  (Even if they
require something that wasn't in the original SSE.)

The point is that "128-bit AVX" exists, typically because the AES and
carryless multiplication instructions have typically been 128-bit only.
256 and 512-bit support for those came much later than the rest of AVX.

Just to give a random example, aes_xts_encrypt_aesni_avx() and
aes_xts_decrypt_aesni_avx() are "128-bit AVX".  And they indeed don't do
vzeroupper, because they don't need to.

Some cases such as lib/crc/x86/crc-pclmul-template.S skip providing
128-bit AVX code and just have the CPUs that could run it instead run
the 128-bit SSE code, but that is a tradeoff made in those cases.

- Eric
