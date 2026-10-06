Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AC141F346;
	Tue,  6 Oct 2026 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791290455; cv=none; b=Y0DMEYYMAtnlwbf67ODKAkJl6++HIyLicqA104KIyh1bpmy3JBtntMWpL5vFXLBlfalxFnSHXXB1xhsSxpIpUXQGRCDVQ1xyf00jsyGBA2F5TW4hTt+WafCd3+IJ6UTFMwSvX9Tf9AGGpTSlIgSLpH/RVoCKNY5M8sjs8EJSOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791290455; c=relaxed/simple;
	bh=qT8rW/O876G+4Yt+1zDgBgjsJlnol/SEJDrkSKSrFiA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=e6LaeV+csCetJYVwTqqlY9mdL25szoP/bizQvmGWNUeXRia7tjcAxidfgrJDwHRtCLeOfDdenTJj/g+kvtMI1KpyRUQFAQJyqirvgguRxOBx+0KZF5HVB+mQbXSAtoiu6QDKo4mFf2x+yjMLF+Ji8wIjSEcQaPOK49zOpBTV9IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=ofLKih+g; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="ofLKih+g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	Message-ID:References:In-Reply-To:Subject:Cc:To:From:Date:MIME-Version:
	Reply-To:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=RMKvOm3tpQtiWc6NdWQkSiodihlG2BC4aWDKz3Ya8dk=; b=ofLKih+gutjQjU5/KhvwKfnewt
	jumS/SiNOYjtwvY0jswadaA4FWbHB/bdRcT6/iWaws/ndkmmNLEg00DiROFGJNRf7mjNXjC9MGuXa
	+DVp0JIrXMRV/4TVCHz8CTn014YM/eyMrjDmw+0x+fBIfeL1BGt1iRCbvRHeBehr1UMjowkiVAD64
	UH0koIHlOqGM4Qd+1dMLhlBdwwVzH6jjQ3ZBGfakgXEZj60ZL0ESWxMtVV3VPmerJN8roeKjoKPiY
	hX0N3gKEcBLZWTv3Dd62ptlbOaJJ3nQ8gRXcBJOZFmcEGUCoUwSkAQeUQ0iZqL1l5Rxb4BjrH1ODZ
	B0vmFkAg==;
Received: from [::1] (port=34840 helo=pf-012.whm.fr-par.scw.cloud)
	by pf-012.whm.fr-par.scw.cloud with esmtpa (Exim 4.100.1)
	(envelope-from <jeremy.jean@oss.cyber.gouv.fr>)
	id 1xE4TH-0000000FFL6-39cm;
	Tue, 06 Oct 2026 14:40:38 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 06 Oct 2026 14:40:36 +0200
From: =?UTF-8?Q?J=C3=A9r=C3=A9my_Jean?= <jeremy.jean@oss.cyber.gouv.fr>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: wireguard@lists.zx2c4.com, netdev@vger.kernel.org, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] wireguard: noise: reject responses for replaced
 initiations
In-Reply-To: <asSo7kefA3IQFpQp@zx2c4.com>
References: <20261005203555.3552816-2-Jeremy.Jean@oss.cyber.gouv.fr>
 <asQUKTOiEn6GB5sy@zx2c4.com> <asSo7kefA3IQFpQp@zx2c4.com>
User-Agent: Roundcube Webmail/1.6.19
Message-ID: <fbeae2e157e335504157b6a6683fb505@oss.cyber.gouv.fr>
X-Sender: jeremy.jean@oss.cyber.gouv.fr
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

On 2026-10-06 09:53, Jason A. Donenfeld wrote:
> On Mon, Oct 05, 2026 at 11:18:33PM +0200, Jason A. Donenfeld wrote:
>> Hi,
>> 
>> On Mon, Oct 05, 2026 at 08:35:55PM +0000, Jérémy Jean wrote:
>> > WireGuard can accept an old handshake response after starting a new
>> > handshake. This reinstalls old keys and resets transport counters and
>> > replay state, enabling nonce reuse, replay and packet forgery. This
>> > breaks confidentiality and integrity guarantees.
>> >
>> > Compare ephemeral secrets under the write lock to reject responses for
>> > replaced initiations.
>> >
>> > Fixes: e7096c131e51 ("net: WireGuard secure network tunnel")
>> > Cc: stable@vger.kernel.org
>> > Assisted-by: LLM
>> > Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
>> > ---
>> >  drivers/net/wireguard/noise.c | 8 +++++---
>> >  1 file changed, 5 insertions(+), 3 deletions(-)
>> >
>> > diff --git a/drivers/net/wireguard/noise.c b/drivers/net/wireguard/noise.c
>> > index 9c0a09bf6c95..88cc9acc7dc7 100644
>> > --- a/drivers/net/wireguard/noise.c
>> > +++ b/drivers/net/wireguard/noise.c
>> > @@ -784,10 +784,12 @@ wg_noise_handshake_consume_response(struct message_handshake_response *src,
>> >
>> >  	/* Success! Copy everything to peer */
>> >  	down_write(&handshake->lock);
>> > -	/* It's important to check that the state is still the same, while we
>> > -	 * have an exclusive lock.
>> > +	/* Check that this is still the initiation we authenticated against,
>> > +	 * while we have an exclusive lock.
>> >  	 */
>> > -	if (handshake->state != state) {
>> > +	if (handshake->state != state ||
>> > +	    crypto_memneq(handshake->ephemeral_private, ephemeral_private,
>> > +			  NOISE_PUBLIC_KEY_LEN)) {
>> >  		up_write(&handshake->lock);
>> >  		goto fail;
>> >  	}
>> 
>> Could you describe the flow that you think causes a bug? Trying
>> to recreate your mental model. Something like this?
>> 
>> == thread 1 ==
>> 
>> 	down_read(&handshake->lock);
>> 	state = handshake->state;
>> 	memcpy(hash, handshake->hash, NOISE_HASH_LEN);
>> 	memcpy(chaining_key, handshake->chaining_key, NOISE_HASH_LEN);
>> 	memcpy(ephemeral_private, handshake->ephemeral_private,
>> 	       NOISE_PUBLIC_KEY_LEN);
>> 	memcpy(preshared_key, handshake->preshared_key,
>> 	       NOISE_SYMMETRIC_KEY_LEN);
>> 	up_read(&handshake->lock);
>> 
>> 	if (state != HANDSHAKE_CREATED_INITIATION)
>> 		goto fail;
>> 
>> 	/* e */
>> 	message_ephemeral(e, src->unencrypted_ephemeral, chaining_key, hash);
>> 
>> 	/* ee */
>> 	if (!mix_dh(chaining_key, NULL, ephemeral_private, e))
>> 		goto fail;
>> 
>> 	/* se */
>> 	if (!mix_dh(chaining_key, NULL, wg->static_identity.static_private, 
>> e))
>> 		goto fail;
>> 
>> 	/* psk */
>> 	mix_psk(chaining_key, hash, key, preshared_key);
>> 
>> 	/* {} */
>> 	if (!message_decrypt(NULL, src->encrypted_nothing,
>> 			     sizeof(src->encrypted_nothing), key, hash))
>> 		goto fail;
>> 
>> == thread 2 ==
>> 
>> 	down_read(&handshake->static_identity->lock);
>> 	down_write(&handshake->lock);
>> 
>> 	if (unlikely(!handshake->static_identity->has_identity))
>> 		goto out;
>> 
>> 	dst->header.type = cpu_to_le32(MESSAGE_HANDSHAKE_INITIATION);
>> 
>> 	handshake_init(handshake->chaining_key, handshake->hash,
>> 		       handshake->remote_static);
>> 
>> 	/* e */
>> 	curve25519_generate_secret(handshake->ephemeral_private);
>> 	if (!curve25519_generate_public(dst->unencrypted_ephemeral,
>> 					handshake->ephemeral_private))
>> 		goto out;
>> 	message_ephemeral(dst->unencrypted_ephemeral,
>> 			  dst->unencrypted_ephemeral, handshake->chaining_key,
>> 			  handshake->hash);
>> 
>> 	/* es */
>> 	if (!mix_dh(handshake->chaining_key, key, 
>> handshake->ephemeral_private,
>> 		    handshake->remote_static))
>> 		goto out;
>> 
>> 	/* s */
>> 	message_encrypt(dst->encrypted_static,
>> 			handshake->static_identity->static_public,
>> 			NOISE_PUBLIC_KEY_LEN, key, handshake->hash);
>> 
>> 	/* ss */
>> 	if (!mix_precomputed_dh(handshake->chaining_key, key,
>> 				handshake->precomputed_static_static))
>> 		goto out;
>> 
>> 	/* {t} */
>> 	tai64n_now(timestamp);
>> 	message_encrypt(dst->encrypted_timestamp, timestamp,
>> 			NOISE_TIMESTAMP_LEN, key, handshake->hash);
>> 
>> 	dst->sender_index = wg_index_hashtable_insert(
>> 		handshake->entry.peer->device->index_hashtable,
>> 		&handshake->entry);
>> 
>> 	handshake->state = HANDSHAKE_CREATED_INITIATION;
>> 	ret = true;
>> 
>> out:
>> 	up_write(&handshake->lock);
>> 	up_read(&handshake->static_identity->lock);
>> 
>> == thread 1 ==
>> 
>> 	down_write(&handshake->lock);
>> 	/* It's important to check that the state is still the same, while we
>> 	 * have an exclusive lock.
>> 	 */
>> 	if (handshake->state != state) {
>> 		up_write(&handshake->lock);
>> 		goto fail;
>> 	}
>> 	memcpy(handshake->remote_ephemeral, e, NOISE_PUBLIC_KEY_LEN);
>> 	memcpy(handshake->hash, hash, NOISE_HASH_LEN);
>> 	memcpy(handshake->chaining_key, chaining_key, NOISE_HASH_LEN);
>> 	handshake->remote_index = src->sender_index;
>> 	handshake->state = HANDSHAKE_CONSUMED_RESPONSE;
>> 	up_write(&handshake->lock);
>> 	ret_peer = peer;
>> 	goto out;
>> 
>> And now begin_session is called on the older completed handshake 
>> rather
>> than the half-completed newer handshake?
>> 
>> Or did you see some other flow?
> 
> Okay I think I worked something plausible out:
> 
> - two threads begin processing the same response
> - the first succeeds. the second gets halfway, when it blocks on taking
>   a lock that a queued initiation has taken
> - the queued initiation does its thing and resets the state
> - the second thread resumes and completes the old handshake and
>   reinstalls keys
> 
> I'll continue analyzing real world feasibility, but in all cases, thank
> you for the patch.
> 
> Jason

Hello Jason,

Thanks for your quick reply. Sorry that I could not answer in time.
Your analysis is indeed the scenario that I had in mind, yet, the
second thread does not really have to block, I'd say it can just
be slow?

As for real world feasibility and impacts, I must admit that
I have no idea.

Regards,
Jérémy
