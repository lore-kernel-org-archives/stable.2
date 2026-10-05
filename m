Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F03F58C9;
	Mon,  5 Oct 2026 21:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791235122; cv=none; b=gp0ywc9B2GTTFifexo29vzKajv2OkXW/YbyY17yFZjKjdcxhSt8O+Z1Q8qIvdV89gNg7WoADFduJuLzdUNCVRviUNmqWnPHCN0wdobQ2l4livSrA+TC0hMlU50jBhZ/fxaBYOlEdWuLvk0P5sbD3bh927DR7nljZe0nkeezFjYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791235122; c=relaxed/simple;
	bh=uzRxCjrPOby7teDpJTsYpBxFtosuVxFM0j1PPjdNbIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMP1kEFzz/ING0koKhMEJqUEsDznybgbOtPz0vsF8qsW1krjshfoN4enzpw6GY7MvC/vFemdGl+a9H1i0ODN2SvOwUTpaxNCdUK1k4CHKP06r6RFd+w3SEixRnG9yde3D3EYPDEZ+i2qqZ9vC30hLhXkePLqWoE0QW1B5uNfy74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=EYeFbHym; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="EYeFbHym"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0767B1F000FF;
	Mon,  5 Oct 2026 21:18:37 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=EYeFbHym
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791235116;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ArXPZwkOS21svTqyVFuDaFFdnY9qfU5vfWtScr/h5DQ=;
	b=EYeFbHymVSJkadjsLFpufo37mu0pzdItcuzxYQSucZfWL3N4HCOGN+/Rx5ZANWm8cmtZwO
	scY1MxjrSOus2i0osYjaZHf7hE94krpdUm3jwnBcK7iMGzw/703W5soEUcZGz4nbqO/75n
	VNJwL+yAI3OzCgdtSAyuPuvMFupqf9Q=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 7b51b2b2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Oct 2026 21:18:35 +0000 (UTC)
Date: Mon, 5 Oct 2026 23:18:33 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: =?utf-8?B?SsOpcsOpbXk=?= Jean <Jeremy.Jean@oss.cyber.gouv.fr>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] wireguard: noise: reject responses for replaced
 initiations
Message-ID: <asQUKTOiEn6GB5sy@zx2c4.com>
References: <20261005203555.3552816-2-Jeremy.Jean@oss.cyber.gouv.fr>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261005203555.3552816-2-Jeremy.Jean@oss.cyber.gouv.fr>

Hi,

On Mon, Oct 05, 2026 at 08:35:55PM +0000, Jérémy Jean wrote:
> WireGuard can accept an old handshake response after starting a new
> handshake. This reinstalls old keys and resets transport counters and
> replay state, enabling nonce reuse, replay and packet forgery. This
> breaks confidentiality and integrity guarantees.
> 
> Compare ephemeral secrets under the write lock to reject responses for
> replaced initiations.
> 
> Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> ---
>  drivers/net/wireguard/noise.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
> index 9c0a09bf6c95..88cc9acc7dc7 100644
> --- a/drivers/net/wireguard/noise.c
> +++ b/drivers/net/wireguard/noise.c
> @@ -784,10 +784,12 @@ wg_noise_handshake_consume_response(struct message_handshake_response *src,
>  
>  	/* Success! Copy everything to peer */
>  	down_write(&handshake->lock);
> -	/* It's important to check that the state is still the same, while we
> -	 * have an exclusive lock.
> +	/* Check that this is still the initiation we authenticated against,
> +	 * while we have an exclusive lock.
>  	 */
> -	if (handshake->state != state) {
> +	if (handshake->state != state ||
> +	    crypto_memneq(handshake->ephemeral_private, ephemeral_private,
> +			  NOISE_PUBLIC_KEY_LEN)) {
>  		up_write(&handshake->lock);
>  		goto fail;
>  	}

Could you describe the flow that you think causes a bug? Trying
to recreate your mental model. Something like this?

== thread 1 ==

	down_read(&handshake->lock);
	state = handshake->state;
	memcpy(hash, handshake->hash, NOISE_HASH_LEN);
	memcpy(chaining_key, handshake->chaining_key, NOISE_HASH_LEN);
	memcpy(ephemeral_private, handshake->ephemeral_private,
	       NOISE_PUBLIC_KEY_LEN);
	memcpy(preshared_key, handshake->preshared_key,
	       NOISE_SYMMETRIC_KEY_LEN);
	up_read(&handshake->lock);

	if (state != HANDSHAKE_CREATED_INITIATION)
		goto fail;

	/* e */
	message_ephemeral(e, src->unencrypted_ephemeral, chaining_key, hash);

	/* ee */
	if (!mix_dh(chaining_key, NULL, ephemeral_private, e))
		goto fail;

	/* se */
	if (!mix_dh(chaining_key, NULL, wg->static_identity.static_private, e))
		goto fail;

	/* psk */
	mix_psk(chaining_key, hash, key, preshared_key);

	/* {} */
	if (!message_decrypt(NULL, src->encrypted_nothing,
			     sizeof(src->encrypted_nothing), key, hash))
		goto fail;

== thread 2 ==

	down_read(&handshake->static_identity->lock);
	down_write(&handshake->lock);

	if (unlikely(!handshake->static_identity->has_identity))
		goto out;

	dst->header.type = cpu_to_le32(MESSAGE_HANDSHAKE_INITIATION);

	handshake_init(handshake->chaining_key, handshake->hash,
		       handshake->remote_static);

	/* e */
	curve25519_generate_secret(handshake->ephemeral_private);
	if (!curve25519_generate_public(dst->unencrypted_ephemeral,
					handshake->ephemeral_private))
		goto out;
	message_ephemeral(dst->unencrypted_ephemeral,
			  dst->unencrypted_ephemeral, handshake->chaining_key,
			  handshake->hash);

	/* es */
	if (!mix_dh(handshake->chaining_key, key, handshake->ephemeral_private,
		    handshake->remote_static))
		goto out;

	/* s */
	message_encrypt(dst->encrypted_static,
			handshake->static_identity->static_public,
			NOISE_PUBLIC_KEY_LEN, key, handshake->hash);

	/* ss */
	if (!mix_precomputed_dh(handshake->chaining_key, key,
				handshake->precomputed_static_static))
		goto out;

	/* {t} */
	tai64n_now(timestamp);
	message_encrypt(dst->encrypted_timestamp, timestamp,
			NOISE_TIMESTAMP_LEN, key, handshake->hash);

	dst->sender_index = wg_index_hashtable_insert(
		handshake->entry.peer->device->index_hashtable,
		&handshake->entry);

	handshake->state = HANDSHAKE_CREATED_INITIATION;
	ret = true;

out:
	up_write(&handshake->lock);
	up_read(&handshake->static_identity->lock);

== thread 1 ==

	down_write(&handshake->lock);
	/* It's important to check that the state is still the same, while we
	 * have an exclusive lock.
	 */
	if (handshake->state != state) {
		up_write(&handshake->lock);
		goto fail;
	}
	memcpy(handshake->remote_ephemeral, e, NOISE_PUBLIC_KEY_LEN);
	memcpy(handshake->hash, hash, NOISE_HASH_LEN);
	memcpy(handshake->chaining_key, chaining_key, NOISE_HASH_LEN);
	handshake->remote_index = src->sender_index;
	handshake->state = HANDSHAKE_CONSUMED_RESPONSE;
	up_write(&handshake->lock);
	ret_peer = peer;
	goto out;

And now begin_session is called on the older completed handshake rather
than the half-completed newer handshake?

Or did you see some other flow?

Let me know.

Thanks,
Jason
