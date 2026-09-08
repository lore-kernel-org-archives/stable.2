Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8043B8BBF;
	Tue,  8 Sep 2026 20:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900589; cv=none; b=R+paE5Vzgq+42WViLdaTscBNlj1sepQf1BZMsT35Fe5VsL3xW6DMw6j6bqqHXuGo73DkAEyT4wGAXE0aGtEXcn/pnh4d0ypH/mNsly9Aw313jBYFY1oNPUPkln5VZ2XqvVAvcNqwVis8lQLHzpPxnb8HD9k/AD1SuAMD/KRoLjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900589; c=relaxed/simple;
	bh=u7mwmmsjUXcaMxYzYCre67B5bYQgeioNRtkc6sE4XnM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Q7+qNifVOSy7Y42qyO4VchNEIrbR/qHjzo7LgLeq1CJo0m9FQwHnlXKKEWPjcBxGt0f5Pj7MEIc3Ghw7Bpdkh8c33EtXdmswjpd/LMKz1I9jSJId4mS8zCBDCDYOB6STc+wyr/c+Qbgfu9Cd9pTImizggBKyrWTJEamf4+4peso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4Dmt3VI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4Dmt3VI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 241EB1F00AC4;
	Tue,  8 Sep 2026 20:49:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900587;
	bh=rJwHXgADXF6nyo4DuE1AEPXI3fC4zTIhMX6IA9GPpBg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i4Dmt3VI93uYG6KbxnQgCc39CcpvHKsnt+pb3WsLF2Wc4BUheNtGENLsagQTcB3pY
	 YjaUKIR8ICctoDVADnJDcM7NIpA820Fd9pL+q4j2GJN18tLYaWmN0Fk49I1BUuYSUj
	 Mz1Fxo6dtB7sMqYpvgF3ViyKxQ3V7SlXF7fZvkp/GmhQe+zTDObtIW3X4N5QD3NoU0
	 70vS0TkEpYDUdvZ9eUIKR+sDTK+M1WTHKiScde691OPKL1jVHiUhaD48/YmVsyUuyu
	 yQOb9rRgRkItayzEphsIv1KC3QRxojqcFl8GBudpZTp+sAUJDhDavRCbII0Y3BZfDV
	 qjRzUCcpgpniQ==
Subject: Re: [PATCH net v9 10/14] rxrpc: Fix RxGK key parser to check enctype
 is supported
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:46 +0000
Message-ID: <178890058672.219967.10512339930697519360@kernel.org>
In-Reply-To: <20260907113743.1453210-11-dhowells@redhat.com>
References: <20260907113743.1453210-11-dhowells@redhat.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 · Low: 1 (1)

- [High] Link/modpost failure in valid configurations: the newly added
  call to `crypto_krb5_find_enctype()` in…
- [Low] Key quota over-charge newly reachable: in
  `rxrpc_preparse_xdr_yfs_rxgk()` (net/rxrpc/key.c:206) the full token…

Pre-existing issues:
- [Low] `rxrpc_preparse_xdr_yfs_rxgk()` now resolves the krb5 enctype
  handle but discards it, so the user-supplied session-key length…

--

rxrpc: Fix RxGK key parser to check enctype is supported

The RxGK token parser in net/rxrpc/key.c now looks up the userspace-supplied
encryption type and rejects the token with -ENOPKG when the enctype is not
known.  The return value of rxrpc_preparse_xdr_yfs_rxgk() is changed from a
hardcoded -EKEYREJECTED to a new local variable so the new error code can be
propagated.

Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com

> diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
> index a0aa78d892897..30d6db052c216 100644
> --- a/net/rxrpc/key.c
> +++ b/net/rxrpc/key.c
> @@ -172,6 +172,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  	const __be32 *ticket, *key;
>  	s64 tmp;
>  	size_t raw_keylen, raw_tktlen, keylen, tktlen;
> +	int ret = -EKEYREJECTED;
>  
>  	_enter(",{%x,%x,%x,%x},%x",
>  	       ntohl(xdr[0]), ntohl(xdr[1]), ntohl(xdr[2]), ntohl(xdr[3]),
> @@ -229,6 +230,11 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  	token->rxgk->key.data	= token->rxgk->_key;
>  	token->rxgk->ticket.len = raw_tktlen;
>  
> +	if (!crypto_krb5_find_enctype(token->rxgk->enctype)) {
> +		ret = -ENOPKG;
> +		goto reject_token;
> +	}
> +

[Severity: High]
Does this build with CONFIG_AF_RXRPC=y (or m) and CONFIG_RXGK=n?

key.o is built unconditionally, while crypto_krb5_find_enctype() only exists
when CRYPTO_KRB5 is built:

net/rxrpc/Makefile:
	rxrpc-y := \
		...
		key.o \
		...
	rxrpc-$(CONFIG_RXGK) += \
		rxgk.o \
		rxgk_app.o \
		rxgk_kdf.o

crypto/krb5/Makefile:
	obj-$(CONFIG_CRYPTO_KRB5) += krb5.o

net/rxrpc/Kconfig has AF_RXRPC selecting only CRYPTO, CRYPTO_LIB_DES if
RXKAD, KEYS and NET_UDP_TUNNEL; the "select CRYPTO_KRB5" lives in the
optional RXGK bool, which defaults to n.  So AF_RXRPC=y, RXGK=n,
CRYPTO_KRB5=n looks like a legal configuration, and the declaration in
include/crypto/krb5.h (reached via include/keys/rxrpc-type.h) has no
!CONFIG_CRYPTO_KRB5 stub, so the failure would only show up at link or
modpost time as an undefined crypto_krb5_find_enctype.  The same would apply
to AF_RXRPC=y with CRYPTO_KRB5=m.

The other rxrpc caller guards this exact call:

net/rxrpc/rxperf.c:
	#ifdef CONFIG_RXGK
	/*
	 * Add a yfs-rxgk key to the security keyring.
	 */
	static int rxperf_add_yfs_rxgk_key(struct key *keyring, u32 enctype)
	{
		const struct krb5_enctype *krb5 = crypto_krb5_find_enctype(enctype);

Should the new call site be wrapped in #ifdef CONFIG_RXGK too, or should
AF_RXRPC select CRYPTO_KRB5?  Neither net/rxrpc/Kconfig nor
net/rxrpc/Makefile is touched anywhere later in the series, and the patch
carries a cc: stable tag.

[Severity: Low]
Can this over-charge the caller's key quota?

Earlier in rxrpc_preparse_xdr_yfs_rxgk() the whole token cost is accounted
before any validation:

	plen = sizeof(*token) + sizeof(*token->rxgk) + tktlen + keylen;
	prep->quotalen += datalen + plen;

The new path frees the token and returns -ENOPKG without undoing that
addition, and rxrpc_preparse_xdr() treats -ENOPKG as a per-token error that
does not abort the key:

		case -ENOPKG:
			if (ret != 0)
				ret = -ENOPKG;
			break;

So a payload holding one parsable token (say rxkad) plus an RxGK token with
an unsupported enctype gets instantiated while prep->quotalen still includes
the discarded RxGK token.  Before this change every reject_token path
returned -EKEYREJECTED, which hit the default: case and failed the whole
instantiation, so the inflated value was never committed.  Would it be
simpler to do the enctype lookup before the prep->quotalen update, or to
subtract it again on this path?

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but now that
the enctype descriptor is looked up here, should raw_keylen also be checked
against krb5->key_len?  The returned pointer is discarded, so the
user-supplied key length (bounded only by AFSTOKEN_GK_KEY_MAX, and allowed
to be 0) is still unvalidated.

The server-key parser pairs the two checks:

net/rxrpc/rxgk.c:rxgk_preparse_server_key() {
	krb5 = crypto_krb5_find_enctype(enctype);
	if (!krb5)
		return -ENOPKG;
	...
}

At use time rxgk_derive_transport_key() passes &rxgk->key to
crypto_krb5_calc_PRFplus(), and the rfc8009 profile just does:

crypto/krb5/rfc8009_aes2.c:rfc8009_calc_KDF_HMAC_SHA2() {
	ret = crypto_shash_setkey(shash, key->data, key->len);
	...
}

HMAC accepts any length, so a transport key gets derived from a truncated or
empty session key, while the rfc3961/rfc3962 profiles fail later:

crypto/krb5/rfc3961_simplified.c:rfc3961_calc_DK() {
	if (inkey->len != keylength || result->len != keylength)
		return -EINVAL;
	...
}

All consumers honour key.len, so there is no out-of-bounds access, just
acceptance of malformed key material and inconsistent late failures.

>  	if (token->rxgk->endtime != 0) {
>  		expiry = rxrpc_s64_to_time64(token->rxgk->endtime);
>  		if (expiry < 0)
> @@ -280,7 +286,7 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
>  	kfree(token->rxgk);
>  	kfree(token);
>  reject:
> -	return -EKEYREJECTED;
> +	return ret;
>  expired:
>  	kfree(token->rxgk);
>  	kfree(token);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com
