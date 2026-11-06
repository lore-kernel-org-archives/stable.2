Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793978519;
	b=Ju8p2Q6tGVdhJrrdIrzxaN2ugJoyTuzt2ysAjgQqkXGnJwdA0tAuB4Sys/5hCeupjljz
	 jYwkLAiDpnPTguvvd6hfollXHb+SbQJNRsssSDjUEcaf4LUIvuJx9UFNZ+JAxj5BWdtfo
	 82Yixv4drcEoFqKnboXYMDELIzY8n428nuVhk6cd58Xi2v2yyF7lwrzLGab0+QhuVexBt
	 NnIUktZmAQStgCawM4XDF/NJVF359cw6+n7nEfV818f2CEXM4L7Yx4Df7fDTyFpOqy2FZ
	 OYk04AtLvrSu1uPYS+Lpr1Q4frb1ZryCTZLeOT3z6LM6tp8EjfozyxW87SR2E1aFmsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793978519;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=YTHJ8+MpM8193qn5WoJpMEdilL1LiuEkd+kPgOio/gg=;
	b=tZ7RVBDIjyfPNYHxXqRJM7AjDm7TEze8Qi4m8099PQ3nzG2p6QZFvGzkQ9KbfmwI5BE0
	 +ko9Yv6T3shSjorPNK2iNAPqtcArMMkRF4bEQo9COdc6GQOZwNrV4zUYGq07N5Gy7fQcA
	 C5d/tqepMG7cOogfk2KofavTEpTKo97oVdhHkbMdShApSQOUb/VlQWRpfxuYPWlr9zF1P
	 uEeqzfnGIoJPYq2PiUcRzafIAj/mxasC8wNN/sOjNCG0fosPXi8rzxEWXMAmW3aZu+8u4
	 +1mxtPQWkg98LDnCtYhrZpRnRoc/MGQepvlfIXbdTWWaPLwJ/j1QNe0xaXGSKX+E9Cg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yq5aTuLL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 0256C606D80E;
	Fri,  6 Nov 2026 15:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yq5aTuLL
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 294A81F008A7;
	Fri,  6 Nov 2026 15:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793978518;
	bh=YTHJ8+MpM8193qn5WoJpMEdilL1LiuEkd+kPgOio/gg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yq5aTuLLFna6cHSMgBty/+ZT8blngfZawZPcRtQTuHXQak4fp1zdcfI2a1Xr22qf0
	 JbLBr2UKFzFBKE1wkoebjsF1yvyKqr/20M3kSqzmkZ7e+tAgGeSY8RUHymvVicjpSQ
	 27T4tX3/UcToB4wmoLjhrxM5LNR6ZVOOJt3lTi5UQx5BMapNw4d33YgXk3p1Q8Lm5l
	 kZ7zwhFppL3SdJKdpo11cQuOecDLmdjusTb2sUnHcNaUx8CAhsBKAgbBYb+xp8HAyq
	 g3OLvB0GKEaVi0/Vi9xVtk8TUnHgbochRCIAoFsCt6Zx9QPxCdqp/PPdxrZ/MP2CE6
	 HwocXofcAy16A==
Date: Fri, 6 Nov 2026 17:21:55 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Guo Zihao <guozh23@xiaopeng.com>
Cc: Peter Huewe <peterhuewe@gmx.de>, Jason Gunthorpe <jgg@ziepe.ca>,
	James Bottomley <James.Bottomley@hansenpartnership.com>,
	Ard Biesheuvel <ardb@kernel.org>, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/2] tpm: sessions: bound the parameter decryption by the
 response size
Message-ID: <au3wk32xa9RjdFy4@kernel.org>
References: <20261106014937.4127650-1-guozh23@xiaopeng.com>
 <20261106014937.4127650-2-guozh23@xiaopeng.com>
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
In-Reply-To: <20261106014937.4127650-2-guozh23@xiaopeng.com>

On Fri, Nov 06, 2026 at 09:49:36AM +0800, Guo Zihao wrote:
> tpm_buf_check_hmac_response() decrypts the parameter area of a
> response for sessions with TPM2_SA_ENCRYPT set:
> 
> 	len = tpm_buf_read_u16(buf, &offset_p);
> 	aes_prepareenckey(&auth->aes_key, auth->scratch, AES_KEY_BYTES);
> 	aescfb_decrypt(&auth->aes_key, &buf->data[offset_p],
> 		       &buf->data[offset_p], len,
> 		       auth->scratch + AES_KEY_BYTES);
> 
> The length is read from the response itself and never checked
> against the buffer: every other size taken from a session response
> is compared to tpm_buf_length(), but not this one. A TPM that
> reports an oversized parameter area makes aescfb_decrypt() walk
> past the end of the buffer, and since the decryption is done in
> place, this both reads and writes whatever follows the received
> data.
> 
> Check that the encrypted parameters fit in the response before
> decrypting them.
> 
> Fixes: 1085b8276bb4 ("tpm: Add the rest of the session HMAC API")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guo Zihao <guozh23@xiaopeng.com>

Ditto.

Br, Jarkko
