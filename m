Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EC3246EB;
	Sun, 27 Sep 2026 14:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790521202; cv=none; b=Py/VwXW1BRn5NF0Wy2bRtk4Qf45qcKW1uAxBJALkwvJdX4auI5N5BMod6xWy/BblSctcq4n/41TVXrK1WI6jHj/U8cmbporLpO4OjarCNCsV+u+CPhDA2k82w7UVQpFVfKjiaCTb54sk6wJDUG3BUzppwFi8amtRpQ54wkzpIYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790521202; c=relaxed/simple;
	bh=J5vlvOBmHGwH0FRYjntFQpYEhUBK1jNvUMyVDFeretA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HhY6Zjeig3E5Tv+WeXiWGzc3iN2Eck1+nn3NfXN4o27ah2ogKFMgsGg4Y7tIqA3XJNs6wdJB7Dk/5qvt4+XzIEgfEVomQ4TKMGl6PCZnts/z1Pa7DaE3wjfQnkCCWfTFIhM30aY12YJisKs8uSBh4D0dFegdmOwpe/G9KBUjaxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=luSEkLeB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="luSEkLeB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35ED61F000FF;
	Sun, 27 Sep 2026 14:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790521196;
	bh=5R3ns/ZIcdsOXOPE3fcSOXj+sFgEDeSqv5fnjvD7tIU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=luSEkLeBCAgShcKLIhcTkBZLftHPcBpp7jkWDrnlvpxhEJz1p3eU41sbEnYqld3ui
	 FKLnZ7OlAVoGlMnGMzQZC5BdC7tJnCkR4Kp9nacRFzwIJxX5L1UPSJbQ5xQp3jp9Kz
	 m4VSp2X1+D3DUYJ0DDXmnyP15EKOHbehfnD90hO3A6SvqtGANfdrOf2MFz+aKZKK+6
	 ka4m6yv+rCksQzvLr2b5xnBdhMv968e0DKVAcqk2zkj7OwdgM9nRdNbQYPrbzxI/5+
	 G4rJLp3/qca9+5MY7FBQx32ZfiEqnSYQT+D0rYCx0wzsjeG6rltnKWk3m4qJa3uafM
	 sNcWT7eY7oonw==
Subject: Re: [PATCH net v11 13/17] rxrpc: Fix RxGK key parser to check enctype
 is supported
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 qotmddnjs@ajou.ac.kr, stable@vger.kernel.org
Date: Sun, 27 Sep 2026 14:59:55 +0000
Message-ID: <179052119580.2160803.17216459884431219026@kernel.org>
In-Reply-To: <20260923133706.1496540-14-dhowells@redhat.com>
References: <20260923133706.1496540-14-dhowells@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch rewrote the RxGK key quota charge in
  rxrpc_preparse_xdr_yfs_rxgk() (net/rxrpc/key.c) and dropped the size…
- [Medium] The new key-length check in rxrpc_preparse_xdr_yfs_rxgk()
  (net/rxrpc/key.c:235-238, `if (raw_keylen != enc->key_len) { ret =…

--

rxrpc: Fix RxGK key parser to check enctype is supported

The RxGK key parser now checks that the token's enctype is supported and
that the key length matches that enctype. The RxGK key handling is now
built only when CONFIG_RXGK is set. Quota is now charged in both the rxkad
and RxGK parsers only after a token is accepted.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
> index cbd26da449510..904da3fe7e478 100644
> --- a/net/rxrpc/key.c
> +++ b/net/rxrpc/key.c

[ ... ]

> @@ -202,10 +203,6 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  		goto reject;
>  	}
>  
> -	plen = sizeof(*token) + sizeof(*token->rxgk) + tktlen + keylen;
> -	prep->quotalen += datalen + plen;
> -
> -	plen -= sizeof(*token);
>  	token = kzalloc_obj(*token);
>  	if (!token)
>  		goto nomem;
> @@ -229,6 +226,17 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  	token->rxgk->key.data	= token->rxgk->_key;
>  	token->rxgk->ticket.len = raw_tktlen;
>  
> +	/* Check the enctype is supported. */
> +	enc = crypto_krb5_find_enctype(token->rxgk->enctype);
> +	if (!enc) {
> +		ret = -ENOPKG;
> +		goto reject_token;
> +	}
> +	if (raw_keylen != enc->key_len) {
> +		ret = -EKEYREJECTED;
> +		goto reject_token;
> +	}

[Severity: Medium]
Does the server side handle this new -EKEYREJECTED return? The server
reaches this parser through this chain:

rxgk_verify_response()
  -> rxgk_extract_token()
    -> rxgk_yfs_decode_ticket()
      -> key_instantiate_and_link()
        -> rxrpc_preparse()
          -> rxrpc_preparse_xdr()
            -> rxrpc_preparse_xdr_yfs_rxgk()

rxgk_yfs_decode_ticket() compares klen with the ticket length but not with
the enctype. It returns the error from key_instantiate_and_link() unchanged.

The cant_get_token switch in rxgk_extract_token() has no case for
-EKEYREJECTED:

net/rxrpc/rxgk_app.c:rxgk_extract_token() {
    ...
cant_get_token:
	switch (ret) {
	case -ENOMEM:
		goto temporary_error;
	case -EINVAL:
		return rxrpc_abort_conn(conn, skb, RXGK_NOTAUTH, -EKEYREJECTED,
					rxgk_abort_resp_tok_internal_error);
	case -ENOPKG:
		return rxrpc_abort_conn(conn, skb, KRB5_PROG_KEYTYPE_NOSUPP,
					-EKEYREJECTED, rxgk_abort_resp_tok_nopkg);
	}

temporary_error:
	...
	return ret;
}

So the error is handled like a temporary error. rxgk_verify_response()
then does goto out, the RESPONSE is dropped, and the connection stays in
RXRPC_CONN_SERVICE_CHALLENGING.

Before this patch, the same ticket got through key instantiation and failed
later, in rxgk_generate_transport_key() -> rxgk_set_up_ciphers() ->
crypto_krb5_calc_PRFplus().

For the RFC3961 enctypes, a key length mismatch made rfc3961_calc_DK()
return -EINVAL, and the connection was aborted with RXGK_NOTAUTH. For the
other enctypes, the authenticator failed to decrypt and the connection was
aborted with RXGK_SEALEDINCON.

The ticket is decrypted with the server key, so only a buggy or
misconfigured token issuer can produce one like this.

Should the cant_get_token switch in rxgk_extract_token() get an
-EKEYREJECTED case? Then the client would get an abort instead of being
re-challenged until it times out.

> +
>  	if (token->rxgk->endtime != 0) {
>  		expiry = rxrpc_s64_to_time64(token->rxgk->endtime);
>  		if (expiry < 0)

[ ... ]

> @@ -257,6 +265,8 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  	_debug("TICK: %*phN",
>  	       min_t(u32, token->rxgk->ticket.len, 32), token->rxgk->ticket.data);
>  
> +	prep->quotalen += sizeof(*token) + datalen + tktlen + keylen;

[Severity: Medium]
Was sizeof(*token->rxgk) meant to be dropped from the quota charge in
rxrpc_preparse_xdr_yfs_rxgk()? The removed code included it:

	plen = sizeof(*token) + sizeof(*token->rxgk) + tktlen + keylen;

token->rxgk is still allocated separately, and that allocation includes the
fixed struct rxgk_key header:

	token->rxgk = kzalloc_flex(struct rxgk_key, _key, raw_keylen);

The rxkad hunk in this same patch still includes sizeof(*token->kad) in
plen, so the two parsers now charge differently.

The datalen term doesn't make up the difference. rxrpc_preparse_xdr()
requires the remaining datalen to be 0 before it calls the token parsers,
so datalen is always 0 here.

So each accepted RxGK token uses about 72 bytes more (on 64-bit) than
generic_key_instantiate() reserves against the user's key quota.

Should this be something like:

	prep->quotalen += sizeof(*token) + sizeof(*token->rxgk) + datalen +
			  tktlen + keylen;

> +
>  	/* count the number of tokens attached */
>  	prep->payload.data[1] = (void *)((unsigned long)prep->payload.data[1] + 1);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923133706.1496540-1-dhowells%40redhat.com
