Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792661488;
	b=tAeOETjjU/fWePVZyfcZOz/lukUrnGiVBLJ69HkCpoy/BOGSbq+0Yg6J3w12SaJkKkWs
	 +Lo+2JhR0yw7DOYJRgwX7xqJLwKAT6vrGnpM+6YoPnAAoMX7FXieb5JeNs9Dan5eAvpfj
	 llpFubRWC4CydM2LC7/Ej0poKxm6tOQwFnlD3vivnhj888bjr4En4Hnu3JGZS5i9aigui
	 mW74fOxVeQdbyXVYEq54+XU1YFYbzGzVNporuASibPFEP6C2fcGiHX50EZZpUUK+1159R
	 Ii9Q3Johu16OQVPUGrLUDYTlpbHSvz41tOmf+zi7NQgOjPv31QDSbrEeLRbt8JZdqSg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792661488;
	h=Received:DKIM-Signature:Received:Received:X-ME-Sender:
	 X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:X-Mailer:
	 MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type:Content-Transfer-Encoding;
	bh=5RVGwZT8t4e1zVjXKKi0e2LIbMh0nK8upWy9XAQnYqk=;
	b=jwERpd9zG/LdcXWNaU8nODfo5q7DweJWVBJxWTZHCWJOqMW5HcBlmYIQRUug+yxjxiL4
	 PGOW1IEB0X1zl3lSDwGwp8SsJXDHHkrjhQJjmVMXfCseva83JrJpAZ9thiXSi+SQBXhcJ
	 fnX4OwVDuTeWupXDSabCgMutVYX/TzxwdHyzhNJEQaq7/wyt1Z3M8C49fxk/XbbOKohTU
	 DYn8ia7BhU2muS868Z/OSSIwajS6S/KN5J7KAIUC2eyZPOowmz9W9HSKhPv200JEr1WP8
	 3immMkewtM1Z0k/ODiNQRPHswr9khww3dH7eBqnLRQVbVHoydPV2xwOhDtyD3qSjMfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rqlaoc0I;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B2F0606A31A
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rqlaoc0I
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5441F1F000C1;
	Thu, 22 Oct 2026 09:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792661488;
	bh=5RVGwZT8t4e1zVjXKKi0e2LIbMh0nK8upWy9XAQnYqk=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=Rqlaoc0INXySVzNSPtqkJ7/DXE3rU5CiEBuItg5SQIZQKe8rcuNJKTThDaTHHWOTF
	 T6eV8iiYS+CeP/aTDPixVPklCvujjS8QtcDBHjpQDYQNoHjFoUVLQYi1RSoCe2150j
	 flXZxbqRKZsHpQmHzA8IhYrIJG4c8PREKuehaSKLgM+yRXjFnnmvFUOt2bttFisdKx
	 dYY3svlqGJtC17g3lN9zcx4H8D4g4pKF0hpJlQO4DBtaYrS5uRx9yzXJoo9qHLrFsv
	 c79IFEk6O1W49WxhVf/LFloPWd+zMh1byyQaxT2jmLMTn3ihWZEm9HnrNhT2sB5sUS
	 I5j6+Qup6pGyg==
Received: from ams-compute-02.internal (ams-compute-02.internal [10.64.2.62])
	by mailfauth.ams.internal (Postfix) with ESMTP id B8876198003A;
	Thu, 22 Oct 2026 05:31:25 -0400 (EDT)
Received: from ams-imap-11 ([10.64.2.31])
  by ams-compute-02.internal (MEProxy); Thu, 22 Oct 2026 05:31:25 -0400
X-ME-Sender: <xms:69fZaqQVwK1DFmdVlAoU2bxJ_E28AzXZnczp1Smr41RqUhpz-BLUlw>
    <xme:69fZaqli-ZSdZd43vyDjdOc5PkJreKYp2Sm1xUHu51_HEVnMk7H2-aPFcVAvrTJs7
    9qXLj3wGSSSAshC7Z8RXTG2wXOCo67StvEqIN6vfPQPUma5i3DhjLkdMw>
X-ME-Proxy-Cause: dmFkZTG0yNsCHIv43dX9nlqrm6DZoOzZrDEcMcejC9UYmP2BqAxOZkNM5VrjFz5aZYVxdY
    YJ0uxjzCchmGI0EEDIqUjVB95pRmB+py2X4nj3BTe8suTrDbq9sEbkO+dScUYAdp74FWbS
    2eEhL2agWbq9FGXjhcju7qvhHIZljJCT+gwgGAreouqyKbrKFAEYLD1CxLN66+awuzbmFQ
    y7nD6Sd3MnXPeBNFP5C24iqg5L/cA0VY0ws0QHOLEngMAkiA6MWBIXOc7jP1bo5qEsNuF7
    hhk6J8Rk5mu8j4B/qBQq98Rj6xHZKoZaZykv6LbipCWV+GCWvPRjQvhHP4pD1jL18APaRD
    fqU74uW5GFbgpWReW7YD5jTROrU55tWPWg1/ofw2dzG+X6ekUnK2hYuaQvMWB4ylVE7VTk
    hvk4U5I/nRcdET2cnXxzCgUw+/PxYlmYxh024BMO2oTayUpotTU80psPK+/4yelcycPcJR
    Hexny9E06HWl/icHwk/NtOs3fnUf/u7lulq/Kq4OmT/FjWGuWUkMwORPICHg15teBeroMw
    GmLP2BJCY36TxT0PSSsl7gJmK34SjZ+zclc6jzlimyykmDl3oQdQKZQDvN2G4QRKHd/N2C
    P35JkbKYy5PjCFnn2sb5WYtH8yBE/Iz+qEmos2wiX1J1eLSB1QCbjpkO4qXg
X-ME-Proxy: <xmx:7dfZanyHPPsKIL31IXY9JXk8gnle0lL2d-6_kfCSgt1zGPM1Hex87w>
    <xmx:7dfZar3-mkDMAMtXx5cZi50kORsKrYCtzKtRyxO5Xe2M02Lp319Q3g>
    <xmx:7dfZalx9vvIMdmee0OzhAKwKdeexltv9Q2TQppeN7gCiaydrCMG6Cg>
    <xmx:7dfZaoUJAQmNHQRaikfFM4qU7BB7GIYI_pdbuW3bnvRhTHWuoP02MQ>
    <xmx:7dfZap9juDy-mV7hJBscy4KhOdwvEZrbGllpe9O7zxU86mFTvC_E-KhP>
Feedback-ID: ice86485a:Fastmail
Received: by mailuser.ams.internal (Postfix, from userid 501)
	id 82660F8008E; Thu, 22 Oct 2026 05:31:23 -0400 (EDT)
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
Date: Thu, 22 Oct 2026 11:31:03 +0200
From: "Ard Biesheuvel" <ardb@kernel.org>
To: "Eric Biggers" <ebiggers@kernel.org>, linux-crypto@vger.kernel.org
Cc: "Jason A . Donenfeld" <Jason@zx2c4.com>,
 "Herbert Xu" <herbert@gondor.apana.org.au>, linux-mips@vger.kernel.org,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Aaro Koskinen" <aaro.koskinen@iki.fi>, stable@vger.kernel.org
Message-Id: <40d8586f-6572-4d98-b271-ffef69d8f78b@app.fastmail.com>
In-Reply-To: <20261022054450.20746-1-ebiggers@kernel.org>
References: <20261022054450.20746-1-ebiggers@kernel.org>
Subject: Re: [PATCH] lib/crypto: mips: Disable Octeon SHA code on little-endian kernels
Content-Type: text/plain
Content-Transfer-Encoding: 7bit


On Thu, 22 Oct 2026, at 07:44, Eric Biggers wrote:
> Kernels built for the MIPS64-based Cavium Octeon SoCs are normally
> big-endian, but little-endian builds are also supported.  Currently, the
> SHA-1, SHA-256, and SHA-512 code using the Octeon crypto co-processor is
> enabled in both builds.
>
> This code is untestable without the hardware.  However, based on the
> code itself, it is implausible that it computes hash values correctly in
> little-endian builds.  Such builds write many incorrect values to COP2:
>
>   - SHA-1 and SHA-256: The 64-bit integer that contains the last two
>     32-bit message words of each block is written to COP2 entirely
>     byte-reflected, due to missing endianness conversion in
>     octeon_sha1_start() and octeon_sha256_start() to compensate for
>     using native 64-bit loads from the message bytes.  This differs from
>     all the earlier message words which are written correctly.
>
>     Furthermore, the state is written to COP2 with each 32-bit word
>     byte-reflected within each 64-bit integer, due to incorrect use of
>     64-bit endianness conversion in write_octeon_64bit_hash_dword() when
>     the state is kept in memory in native-endian 32-bit words.
>
>   - SHA-512: All the 64-bit message words are written to COP2
>     byte-reflected, due to missing endianness conversion in
>     write_octeon_64bit_block_sha512() and octeon_sha512_start().  The
>     SHA-512 state words seem to be written correctly.
>
> Big-endian kernels aren't affected by these bugs.  These bugs also
> aren't new; this code has been broken on little-endian ever since it and
> Octeon little-endian support were first added in v4.1.
>
> Commit d2a948d2db68 ("MIPS: Octeon: Make octeon-md5 driver
> endian-agnostic") made the MD5 code work on little-endian kernels by
> adding 64-bit endianness conversions to the COP2 macros used by MD5
> (some of which are shared by SHA-1 and SHA-256, despite those algorithms
> keeping the state words in native-endian instead of MD5's little-endian,
> causing some of the strange behavior described above).  However, SHA-1,
> SHA-256, and SHA-512 were never fixed to work on little-endian kernels.
>
> Therefore, disable the Octeon SHA-1, SHA-256, and SHA-512 code in
> little-endian kernels.  This causes the generic code that actually
> computes hash values correctly to be used instead.
>
> Fixes: 82be2dcfa6a1 ("crypto: octeon - add SHA1 module")
> Fixes: c3d0def62001 ("crypto: octeon - add SHA256 module")
> Fixes: fbaa4dfd51a0 ("crypto: octeon - add SHA512 module")
> Cc: stable@vger.kernel.org
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Acked-by: Ard Biesheuvel <ardb@kernel.org>
