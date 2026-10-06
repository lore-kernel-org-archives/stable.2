Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93DC3BB11D;
	Tue,  6 Oct 2026 07:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791273206; cv=none; b=uiieEn17VSSGDGkpkzZRW7dXsxyA3P60RKbibKM6WJ/UtbCLjSbDXSD6UyPr+tCCgfes69MWMz3cRSuCmH5BM4GoXo+TyDig+/DFrAczkcr0POpOXKr2LDZDo2Kbl5NXv7gvxNGujIR6FkYQ/WYc4H5QHXtiMmaxkPys5TvPhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791273206; c=relaxed/simple;
	bh=FjO6bp90v+Ow1iB9vvw1Ih/o45XD0XPZREkOaK/vzYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe57cFocJVDYnxLdxdnsRvUVITliQ1CuQJp9SiHbFbqSYCME+nQwpeXlz5SH74ardIB8rR0q9nl3dNErENuePACkpkbTvefKgFsmO8xXM7iut0l7j2bZNnHtPBMjiRFBkohcHSxLSykqw3Qpye45b4tn3BvCqNtuA07zBgJv0Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=WGt5Ui8I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="WGt5Ui8I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7731F00893;
	Tue,  6 Oct 2026 07:53:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=WGt5Ui8I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1791273201;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YDN5wLU3vlNSuQ2COxUOy67n5o159K5goSdjDTHVB9I=;
	b=WGt5Ui8I1lx3TVb6wUDWdHAAQLu3qmyK3ikh3buD1UqRQJgMoUPg71l9OeCHA8/kI0yN/2
	TBS8JIxtB+YOA0KpfWDMkML73SkoXoUt7noE+D23nhEmKTdJewd4Y1rYjyqSoz9MpafVXK
	BReb+O7WNj6n31keFVduNsAHbn1vASY=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id b38590a0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 6 Oct 2026 07:53:21 +0000 (UTC)
Date: Tue, 6 Oct 2026 09:53:18 +0200
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
Message-ID: <asSo7kefA3IQFpQp@zx2c4.com>
References: <20261005203555.3552816-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <asQUKTOiEn6GB5sy@zx2c4.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <asQUKTOiEn6GB5sy@zx2c4.com>

On Mon, Oct 05, 2026 at 11:18:33PM +0200, Jason A. Donenfeld wrote:
> Hi,
> 
> On Mon, Oct 05, 2026 at 08:35:55PM +0000, Jérémy Jean wrote:
> > WireGuard can accept an old handshake response after starting a new
> > handshake. This reinstalls old keys and resets transport counters and
> > replay state, enabling nonce reuse, replay and packet forgery. This
> > breaks confidentiality and integrity guarantees.
> > 
> > Compare ephemeral secrets under the write lock to reject responses for
> > replaced initiations.
> > 
> > Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
> > Cc: stable@vger.kernel.org
> > Assisted-by: LLM
> > Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
> > ---
> >  drivers/net/wireguard/noise.c | 8 +++++---
> >  1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
> > index 9c0a09bf6c95..88cc9acc7dc7 100644
> > --- a/drivers/net/wireguard/noise.c
> > +++ b/drivers/net/wireguard/noise.c
> > @@ -784,10 +784,12 @@ wg_noise_handshake_consume_response(struct message_handshake_response *src,
> >  
> >  	/* Success! Copy everything to peer */
> >  	down_write(&handshake->lock);
> > -	/* It's important to check that the state is still the same, while we
> > -	 * have an exclusive lock.
> > +	/* Check that this is still the initiation we authenticated against,
> > +	 * while we have an exclusive lock.
> >  	 */
> > -	if (handshake->state != state) {
> > +	if (handshake->state != state ||
> > +	    crypto_memneq(handshake->ephemeral_private, ephemeral_private,
> > +			  NOISE_PUBLIC_KEY_LEN)) {
> >  		up_write(&handshake->lock);
> >  		goto fail;
> >  	}
> 
> Could you describe the flow that you think causes a bug? Trying
> to recreate your mental model. Something like this?
> 
> == thread 1 ==
> 
> 	down_read(&handshake->lock);
> 	state = handshake->state;
> 	memcpy(hash, handshake->hash, NOISE_HASH_LEN);
> 	memcpy(chaining_key, handshake->chaining_key, NOISE_HASH_LEN);
> 	memcpy(ephemeral_private, handshake->ephemeral_private,
> 	       NOISE_PUBLIC_KEY_LEN);
> 	memcpy(preshared_key, handshake->preshared_key,
> 	       NOISE_SYMMETRIC_KEY_LEN);
> 	up_read(&handshake->lock);
> 
> 	if (state != HANDSHAKE_CREATED_INITIATION)
> 		goto fail;
> 
> 	/* e */
> 	message_ephemeral(e, src->unencrypted_ephemeral, chaining_key, hash);
> 
> 	/* ee */
> 	if (!mix_dh(chaining_key, NULL, ephemeral_private, e))
> 		goto fail;
> 
> 	/* se */
> 	if (!mix_dh(chaining_key, NULL, wg->static_identity.static_private, e))
> 		goto fail;
> 
> 	/* psk */
> 	mix_psk(chaining_key, hash, key, preshared_key);
> 
> 	/* {} */
> 	if (!message_decrypt(NULL, src->encrypted_nothing,
> 			     sizeof(src->encrypted_nothing), key, hash))
> 		goto fail;
> 
> == thread 2 ==
> 
> 	down_read(&handshake->static_identity->lock);
> 	down_write(&handshake->lock);
> 
> 	if (unlikely(!handshake->static_identity->has_identity))
> 		goto out;
> 
> 	dst->header.type = cpu_to_le32(MESSAGE_HANDSHAKE_INITIATION);
> 
> 	handshake_init(handshake->chaining_key, handshake->hash,
> 		       handshake->remote_static);
> 
> 	/* e */
> 	curve25519_generate_secret(handshake->ephemeral_private);
> 	if (!curve25519_generate_public(dst->unencrypted_ephemeral,
> 					handshake->ephemeral_private))
> 		goto out;
> 	message_ephemeral(dst->unencrypted_ephemeral,
> 			  dst->unencrypted_ephemeral, handshake->chaining_key,
> 			  handshake->hash);
> 
> 	/* es */
> 	if (!mix_dh(handshake->chaining_key, key, handshake->ephemeral_private,
> 		    handshake->remote_static))
> 		goto out;
> 
> 	/* s */
> 	message_encrypt(dst->encrypted_static,
> 			handshake->static_identity->static_public,
> 			NOISE_PUBLIC_KEY_LEN, key, handshake->hash);
> 
> 	/* ss */
> 	if (!mix_precomputed_dh(handshake->chaining_key, key,
> 				handshake->precomputed_static_static))
> 		goto out;
> 
> 	/* {t} */
> 	tai64n_now(timestamp);
> 	message_encrypt(dst->encrypted_timestamp, timestamp,
> 			NOISE_TIMESTAMP_LEN, key, handshake->hash);
> 
> 	dst->sender_index = wg_index_hashtable_insert(
> 		handshake->entry.peer->device->index_hashtable,
> 		&handshake->entry);
> 
> 	handshake->state = HANDSHAKE_CREATED_INITIATION;
> 	ret = true;
> 
> out:
> 	up_write(&handshake->lock);
> 	up_read(&handshake->static_identity->lock);
> 
> == thread 1 ==
> 
> 	down_write(&handshake->lock);
> 	/* It's important to check that the state is still the same, while we
> 	 * have an exclusive lock.
> 	 */
> 	if (handshake->state != state) {
> 		up_write(&handshake->lock);
> 		goto fail;
> 	}
> 	memcpy(handshake->remote_ephemeral, e, NOISE_PUBLIC_KEY_LEN);
> 	memcpy(handshake->hash, hash, NOISE_HASH_LEN);
> 	memcpy(handshake->chaining_key, chaining_key, NOISE_HASH_LEN);
> 	handshake->remote_index = src->sender_index;
> 	handshake->state = HANDSHAKE_CONSUMED_RESPONSE;
> 	up_write(&handshake->lock);
> 	ret_peer = peer;
> 	goto out;
> 
> And now begin_session is called on the older completed handshake rather
> than the half-completed newer handshake?
> 
> Or did you see some other flow?

Okay I think I worked something plausible out:

- two threads begin processing the same response
- the first succeeds. the second gets halfway, when it blocks on taking
  a lock that a queued initiation has taken
- the queued initiation does its thing and resets the state
- the second thread resumes and completes the old handshake and
  reinstalls keys

I'll continue analyzing real world feasibility, but in all cases, thank
you for the patch.

Jason
