Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795461171;
	b=LUECjcBIEOzd8AfBPxNByx3qObP/hq6qh3iqIhyez2+a9v+OqUSD25aPji8AOATEGCze
	 2OmOHy8LvBUaEOl8e62Ozm83PScSKJF8BAIhAL0JsKB7shpPDVGsDERQzQZy6hnkM3vYf
	 jQQr75RXy4+cAZ5A7CHeQ5l+ebHLGG0Ooe/rSuRcsZtKClQ+KT7xyEgNNyREL3wmGAUA+
	 qiNx6XUw8Ec8HYkrlQcyhEW2P6Fzh66h2TDfp6wYHPZy/N3/uXRClJgqPc8jl607UTXIq
	 J8YaAm33Dd2vVXeXN3WGG0GgTUqDfTFNTbvTivOIeLMT99hyUNKLBJ1cFSghZeOVNTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795461171;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1aSuqE91A4JA8nziXePdbRYInCs8V/0AUq1tsDNXB2k=;
	b=0ha4KHQV8YBkomY1+/XknFGvABhLKyGyxP3re3Un4eu6DppKpc8SKy+bWAJYG6Cc2S9Z
	 NlYLVfkzR0ClE2yX3mW7V9sgfHDxDg2YkbLXOR5T8IDuGl93ZTZHYsn03rx9K3IuEXDRM
	 xh6JwV7WPDXt43gN21U0Iaf7qrvwFXppxWjUIxHSXQZmpmte8miciXlrIVojd/B15qwKr
	 1nPrTBGbt9Q2sfg7IGUzMaV6gNdfoRmNjWhLMOnT7f+/LMnvj/6HRjKqy2UqQsa5RhXL2
	 Akaeoi4LJw8VWYptpHlLnseL/pOJT/GYdUU/0nw21+2CYYJVtG3hAFFhzN9qiaMdmJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nt5GC4BA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 427E2606A32E;
	Mon, 23 Nov 2026 19:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nt5GC4BA
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 7994F1F000C4;
	Mon, 23 Nov 2026 19:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795461171;
	bh=1aSuqE91A4JA8nziXePdbRYInCs8V/0AUq1tsDNXB2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nt5GC4BAe3Cpt9xRhfsbWl4ijfqR7/5oz7Aq532m7vMKgPvaJDDZZahV8kK3qw3BW
	 7cmRdjOri6KvQ7Dwx4pTKiQwBJp5MggDtt2A888eRn7EO8sEVvwGg5A6I69TICXd5m
	 9dQVgIPmRkRpymfoIgJby/ZdUo6jur5RFmRXb58B6lEvVqH4bjl8I2PtQaFmQvEdyb
	 dA1e/HoX/07ZwmvvSeqkfpjIOomIB27vogZuQnkNZvn+TB8I0n7uD4NLac99Ok7O9P
	 lttWSnQvUGJrRwDkOj2g1sD/9iizp9GyU4pkcdJbwDoXnhZWi9Sr0jjBtKYymUyyFZ
	 zGHAdyYakULmg==
Date: Mon, 23 Nov 2026 21:12:47 +0200
From: Jarkko Sakkinen <jarkko@kernel.org>
To: Henry Martin <bsdhenrymartin@gmail.com>
Cc: dhowells@redhat.com, paul@paul-moore.com, jmorris@namei.org,
	serge@hallyn.com, Jason@zx2c4.com, keyrings@vger.kernel.org,
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] keys: fix crash on big_key read or revoke after a failed
 update
Message-ID: <awSQL3uLNktPEwIo@kernel.org>
References: <20261123165443.4092852-1-bsdhenrymartin@gmail.com>
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
In-Reply-To: <20261123165443.4092852-1-bsdhenrymartin@gmail.com>

On Tue, Nov 24, 2026 at 12:54:43AM +0800, Henry Martin wrote:
> big_key_update() destroys the old payload with big_key_destroy() before
> calling generic_key_instantiate(), which can fail.  The destroy drops the
> payload's path and data but keeps payload->length.  If instantiate fails,
> e.g. with -EDQUOT when a concurrent allocation grabs the quota freed by
> the destroy, the key stays positive with a gutted payload and a stale
> length.
> 
> A later KEYCTL_READ on such a key follows the stale length.  For a
> file-backed payload it hits BUG_ON(!path->mnt) in dentry_open().  For a
> buffer-backed one it memcpy()s from a NULL payload->data.  KEYCTL_REVOKE
> passes the NULL path to vfs_truncate().  All of these crash the kernel,
> e.g. on mainline v7.4-rc4:
> 
> kernel BUG at fs/open.c:1145!
> Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
> RIP: 0010:dentry_open+0x7b/0x90
>  big_key_read+0x141/0x280
> 
> Fix the ordering: instantiate the new payload first and destroy the old
> one only on success.  There is no need to release the old quota first:
> a big_key payload always reserves a fixed 16 bytes, which was already
> charged when the key was instantiated, so the instantiate of a positive
> key leaves the reservation unchanged and cannot fail.  Releasing it
> first was what allowed a concurrent allocation to take the quota and
> make the instantiate fail after the payload had been destroyed.
> 
> This issue was discovered by Tencent CodeBuddy Security.
> Cc: stable@vger.kernel.org
> Fixes: b6f61c314649 ("keys: Implement update for the big_key type")
> Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
> ---
>  security/keys/big_key.c | 23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/security/keys/big_key.c b/security/keys/big_key.c
> index 268f702df380e..3bf371f6c28d3 100644
> --- a/security/keys/big_key.c
> +++ b/security/keys/big_key.c
> @@ -193,16 +193,31 @@ void big_key_destroy(struct key *key)
>   */
>  int big_key_update(struct key *key, struct key_preparsed_payload *prep)
>  {
> +	struct big_key_payload old = { };
> +	bool positive = key_is_positive(key);
>  	int ret;
>  
> -	ret = key_payload_reserve(key, prep->datalen);
> +	if (positive)
> +		old = *to_big_key_payload(key->payload);
> +
> +	/*
> +	 * The quota for a big_key payload is a fixed 16 bytes that was
> +	 * already reserved when the key was instantiated, so the instantiate
> +	 * below does not change the reservation of a positive key.  Do not
> +	 * release it first: a concurrent allocation could take the quota and
> +	 * make the instantiate fail after the old payload was destroyed.
> +	 */

I'd leave the comment out. It's very time variant and commit specific.

> +	ret = generic_key_instantiate(key, prep);
>  	if (ret < 0)
>  		return ret;
>  
> -	if (key_is_positive(key))
> -		big_key_destroy(key);
> +	if (positive) {
> +		if (old.length > BIG_KEY_FILE_THRESHOLD)
> +			path_put(&old.path);
> +		kfree_sensitive(old.data);
> +	}
>  
> -	return generic_key_instantiate(key, prep);
> +	return 0;
>  }
>  
>  /*
> -- 
> 2.53.0
> 

I did not specifically check the Sashiko output.

Br, Jarkko
