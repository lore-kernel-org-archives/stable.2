Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978679;
	b=Z3+9dGVzCj3gg4TG6BOaTzCoeyDbWLAXukmPjfkDWHCUuU1Fuy1BmpDWHZrQDTKBo0I9
	 SORxFGn7z1DA53lOc7M937pfll4ZSWnU5nAKkNgZ2ny1kvo2RqaRRru29XrHfA5LDcRkf
	 e4AAhHH2V6uj+OnXCbB+18nEIG/hcl5JczmmsDFgWSawEvPHJs3DpRXbNLRD7NNxcb4o+
	 /NiNUg4MXXx1WPQDlJsXNR1DMuebhAG2+3EokMex3etfYhmPQc8H4NzV2JYIBW/beqCiV
	 K/RZkVmg0Rj+xnBRhKNOrCKFM3YlQvcq2dGsg+0ve2czxdzkTKL6YCj1GMFXzjxvbDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978679;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=VsmKhMCPI5TGuiotzbDgLac51lD11IUhvG6TQedGDOc=;
	b=Y7NIvA5IAxw4Z1AO6LnvGLfD6ESmRfKx/FGT2gQ/hf2nr8WyCk4Gm7Shu/7wg5LgiTNi
	 slALQYNASlYdHkB2hqEObV+RpiV1ffTaydPSm7UqYEMd9HCRCwK7ItJFvPntHN2K/rYTf
	 NOgR8kjjwwu6g7rNsAFFZsrlI5wISlWDT2ZCDZqzCImNuR9yVWLGwg9drNJIaJHpdvHC5
	 yZBzMwmxMz7Y5dzs1qDcFDpYql3nc/kSjrCpDXAy49q6lRlgw84oISa2WjFvH/BEHxAl5
	 pYjatJRDNwio6FG+1MwCeERv+UX1glT5a7+g59LbtrSC7lXN2vMz9UxgaOr4fEJRQfQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkb1w2S9;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 76206606D818;
	Fri,  6 Nov 2026 15:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fkb1w2S9
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 8EFE51F0089F;
	Fri,  6 Nov 2026 15:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978679;
	bh=VsmKhMCPI5TGuiotzbDgLac51lD11IUhvG6TQedGDOc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fkb1w2S9YfZl9PyYR0g0GUMkYYob+m+kDMqQTOfGKB4sZBjfCI6pgKG1l9HZS7WCe
	 Wn6aN3BCEhrCgMTfZmIT5GCi7l/22whgq8NeHK1q/+eskLG1eJHEQwvyAB3oAKFTHe
	 plNpOy5qsdUGVbTR/iXyEekllI+fZoZlbtAlnE7CpuLVagrqXcsxX2PAI/mjPaovji
	 d9cGQb4Jx0pnBrirleEmesXmT0Cxwsr0Z2TzlGau4yZkTYxxLDXJQF9rDKSIfaIYIa
	 roMU+FoYjDsRv7KhSvD76wEx8I/kU6pKwDBEPdc3HdB9vrFS03E2UQo0eeaMsMs0Q0
	 cJgDnqe4JKQ1Q==
Date: Fri, 6 Nov 2026 17:24:35 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	Ard Biesheuvel <ardb@kernel.org>,
	Matthew Garrett <matthewgarrett@google.com>,
	linux-integrity@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] tpm: efi: reject a final events table with an oversized
 preboot log
Message-ID: <au3xM-7onNTtgceh@kernel.org>
References: <20261106014956.4129904-1-guozh23@xiaopeng.com>
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
In-Reply-To: <20261106014956.4129904-1-guozh23@xiaopeng.com>

On Fri, Nov 06, 2026 at 09:49:56AM +0800, Guo Zihao wrote:
> The preboot portion recorded in the main event log is subtracted from
> the size of the final events table taken from the firmware:
> 
> 	/*
> 	 * The 'final events log' size excludes the 'final events preboot log'
> 	 * at its beginning.
> 	 */
> 	final_events_log_size -= log_tbl->final_events_preboot_size;
> 
> Both sizes come from EFI configuration tables and are not validated
> against each other. A final events table claiming a preboot portion
> larger than the table itself makes final_events_log_size go negative:
> the subsequent devm_krealloc() can then end up with a wrapped, too
> small allocation, and the memcpy() that appends the final events log
> uses the negative value as its length, running far past the buffer.
> 
> The boot path has no way to fix up such a table, so fail the final
> events log instead of appending from it.
> 
> Fixes: 166a2809d65b ("tpm: Don't duplicate events from the final event log in the TCG2 log")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>

Ditto.

For all four address validation vs bug fix intersection. I did not
check throughly enough to be exactly sure of all four.

Br, Jarkko
