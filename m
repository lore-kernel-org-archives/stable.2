Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978478;
	b=0UTps9iukndtLftFPVRzTTUXN10Siury6UMnjOkE8g0+hmcfocYFw/dvdOkzkG8r80bQ
	 zspLkFp+stVfNylrIfrByOlzpE33J1bYDiWwidyzdveVWqDxnhpRGO/q3u/6pzfabyZqA
	 Pc8K29Uv62l2Obi2VpeKJnm8w1LV3wAprWAQjQ99rzYAapU8b9SWBUsI0cj0/hhA6SRsi
	 0F7LrttJFwawwKKC2NMGuskvPdqzZQNt6qqKg+h7/sLRqZ2Wwa/ZLfD26WJvHqAW4//xW
	 gZq/CswO7tKIKU29wvjNvQV8Z6gmnsC/14TRkV8y1VH6otZUJU94NgCtXXCiZSsDv8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978478;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=34IlpcCYQrCXU6z578TEX6JbzLaMY62FwfWMGoMYWUY=;
	b=GZNNA4R8vAP1P0/efqQ8QjD4xYteu1Nmh6LmiChDX63ao3bAKTf2IgjrO2k7cF6xagva
	 hT9q2uQze6P3jTT+BzD9LH+rMl5OXmT8bNf5Yawa4rtq38xxLrZ5g8R3plw04u4y7lEHi
	 OmMWkvLNFVh6uzH1FJxoDVmVdUOr2w1rcAfyZgNCKLp3U6XPvljnxkVOOh2/9Qw/N8kcB
	 zSR7cpgyZWUjYbZ19qLbh5RfktYRPTzStx5GDVuoH5hB7bpffBST7fvKpycZ0ZkIPaz0g
	 sjY6WM/u+izkpZclMYsfAxRdpYkqIBsjwdrDLkA1mVkk/a3QjFBCg/qJrp1g+C1Cw2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Ph/JeeiL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DFAF5606A334;
	Fri,  6 Nov 2026 15:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ph/JeeiL
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id D89851F0089F;
	Fri,  6 Nov 2026 15:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978477;
	bh=34IlpcCYQrCXU6z578TEX6JbzLaMY62FwfWMGoMYWUY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Ph/JeeiLpDWKn6rHMfLd+3lNX083YMVtVM05S1gKEJauf880dMqZBDMqUcyMNJLNJ
	 ZpAqkVWDACg7c7P/dqX2tYm4SXwpsz7PoLrF6R1TJxhvzlr1V1XOv8ZjoADvwiBJBy
	 dcimnXfBmgrFT+/nOKyc13YycZMNMpn0i34FqEtlhIRdSFnEq2IyKdwBsv6DnI0fjs
	 zdGQJKuBn25K7bwYP7ebvnT+K8tLO50lw98lPBL2TvYhFFB4sN7B7zlsn1lDCP3J4s
	 rksc7uWOXivZAMdEuR0qQ3cIh+b5XrUNroV6sLWjGoezi+uyz1n4d8MSn+GuqOQLxX
	 lD/P7eMbrDiyQ==
Date: Fri, 6 Nov 2026 17:21:13 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] tpm: sessions: bound the primary public area by the
 response size
Message-ID: <au3waVnY6QA8TpPl@kernel.org>
References: <20261106014937.4127650-1-guozh23@xiaopeng.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106014937.4127650-1-guozh23@xiaopeng.com>

On Fri, Nov 06, 2026 at 09:49:35AM +0800, Guo Zihao wrote:
> tpm2_parse_create_primary() reads the size of the TPM2B_PUBLIC area
> from the response and hashes it to compute the object name:
> 
> 	len = tpm_buf_read_u16(buf, &offset_r);
> 	offset_t = offset_r;
> 	if (name) {
> 		/*
> 		 * now we have the public area, compute the name of
> 		 * the object
> 		 */
> 		put_unaligned_be16(TPM_ALG_SHA256, name);
> 		sha256(&buf->data[offset_r], len, name + 2);
> 	}
> 
> The length is only checked against the response later, after the
> hash has been taken. A TPM that reports a public area longer than
> what it actually sent makes the sha256() run past the end of the
> received data and hash whatever follows the response in the buffer.
> 
> Check that the public area fits in the response before hashing it.
> 
> Fixes: d2add27cf2b8 ("tpm: Add NULL primary creation")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>

I think it is not a bug fix without a source.

I.e., unless this is TCG defined behavior, I'd not add fixes tag.

Br, Jarkko
