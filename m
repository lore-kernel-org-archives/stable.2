Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43853C2795;
	Tue,  8 Sep 2026 20:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788900594; cv=none; b=WY157KIHRdGUraxEZB76LEQKcJkI7OCaTxXLZXxO7vG9Ja8b7whF0wynLVzVlnzNjNX37GuQ83z3xI9HXQQy3l6KjkispnM1zum63eaD3TWvjGdAk27g9eWir1PAIZy+e5F6w4p9U/9octwkpqljcy3uxVfpMsiPlZv03w6AGzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788900594; c=relaxed/simple;
	bh=cgJLVHJ0ipk6LIs5e9Gm3n74x4PoLzn8OyvodcsTR3E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Xrgxbu2xq92Fk6iUqWRMUKOUzwFP9HPtvRcNpx3AUrCv/0wjrVSDNdh+lTMs61Rq14QtGviOwcuz82KSK/PSrw/fcghM4z6ty7OtxAjnKpXEH11eykFvRcMvNuElaBnvmtFw+bFVvt3tqWkEPGAfgVGRnyF7bkVSoBH112xZRaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPRlLwfj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPRlLwfj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FE5F1F00A3D;
	Tue,  8 Sep 2026 20:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788900592;
	bh=KgbmGUI+qqk/o7LUuP5e2UCjU/EZVdtdYLPLisDOkz8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=jPRlLwfj7cLXv1WIOBqNe0gb/LdvRovoVmhskGYY4/OmS/NYw84QzjevO75ex0Gu+
	 w+nBTRWeS9yzniSzD6EV4K7u1IGA30cij8mI+F/SY6q0UswnDYxkfD/9HDhuaG+m/e
	 YR1XE7f1RuUgGZwIbzv/L78ULhsTVunSKamtDs3AkFhbSdYz5ujSXCbRuL+riPyUqs
	 OHBM6nlWFKzzM1y28EnUlJ6F+QQlEJXM8+PBbqoFdz9BLjjBYOWauzCjz1HzvA2U/h
	 tE45OMdhImmxyZIBtQ2VMya3/B37Wbvc2fm80wgm9qpe5UaDV6F2+M/yQLfZJYvR/I
	 cLfTM3XQDLfJQ==
Subject: Re: [PATCH net v9 14/14] rxrpc: Take write lock when publishing the
 initial RxGK key
From: netdev-bot+sashiko@kernel.org
To: dhowells@redhat.com
Cc: netdev@vger.kernel.org, marc.dionne@auristor.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
 nicoyip.dev@gmail.com, stable@vger.kernel.org
Date: Tue, 08 Sep 2026 20:49:51 +0000
Message-ID: <178890059184.219967.732859722625940443@kernel.org>
In-Reply-To: <20260907113743.1453210-15-dhowells@redhat.com>
References: <20260907113743.1453210-15-dhowells@redhat.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 (2) · Medium: 1 (1) · Low: 0

- [Medium] The new critical section does not cover conn->security_ix /
  conn->security_level.

Pre-existing issues:
- [High] Publish-before-validate leak of the transport key context.
- [High] Wrong array index / lost reference in the rxgk_rekey() non-crank
  slow path.
- [Medium] Unsynchronized read-modify-write of gk->bytes_remaining.

--

rxrpc: Take write lock when publishing the initial RxGK key

This adds write_lock(&conn->security_use_lock) around the initial
publication of conn->rxgk.enctype and conn->rxgk.keys[] in
rxgk_init_connection_security(), so that the initial publication uses the
same lock that rxgk_rekey() uses and that rxgk_get_key() reads under.

A few questions about the placement of the new critical section and about
some neighbouring code it touches.

> diff --git a/net/rxrpc/rxgk.c b/net/rxrpc/rxgk.c
> index 77a67ace1d248..b49221f57f677 100644
> --- a/net/rxrpc/rxgk.c
> +++ b/net/rxrpc/rxgk.c
> @@ -251,8 +251,10 @@ static int rxgk_init_connection_security(struct rxrpc_connection *conn,
>  					 GFP_NOFS);
>  	if (IS_ERR(gk))
>  		return PTR_ERR(gk);
> +	write_lock(&conn->security_use_lock);

[Severity: Medium]
Should conn->security_ix and conn->security_level be published inside this
same critical section?  They are still stored with plain writes earlier in
rxgk_init_connection_security():

	conn->security_ix = token->security_index;
	conn->security_level = token->rxgk->level;

and rxgk_alloc_txbuf() reads the level with no lock at all, and before it
calls rxgk_get_key():

	switch (call->conn->security_level) {
	default:
		alloc = umin(remain, RXRPC_JUMBO_DATALEN);
		return rxrpc_alloc_data_txbuf(call, alloc, 1, gfp);

This is the path the changelog describes.  The second sender does the plain
load of conn->state in rxrpc_send_data():

	if (call->conn->state == RXRPC_CONN_CLIENT_UNSECURED) {
		ret = rxrpc_init_client_conn_security(call->conn);

sees RXRPC_CONN_CLIENT, skips initialisation and goes straight into
rxgk_alloc_txbuf().  Since the pre-init value of conn->security_level comes
from rxrpc_alloc_client_connection():

	conn->security_level	= bundle->security_level;

which traces back to rx->min_sec_level and need not equal
token->rxgk->level, can that sender read the stale level on a weakly
ordered CPU, take the default arm above and allocate a txbuf with no
crypto_header/sec_header reservation, while rxgk_secure_packet() then runs
the AUTH/ENCRYPT path on it (rxgk_secure_packet_encrypted() writing the
rxgk_header over payload, crypto_krb5_encrypt() failing with -EFAULT and
the call aborting)?

The read of conn->security_level in rxgk_secure_packet() itself does happen
after rxgk_get_key()'s read_lock acquire, so that one now pairs with the new
write_unlock; the pre-lock read in rxgk_alloc_txbuf() looks like the
remaining gap.

>  	conn->rxgk.enctype = gk->krb5->etype;
>  	conn->rxgk.keys[gk->key_number & 3] = gk;
> +	write_unlock(&conn->security_use_lock);
>  
>  	switch (conn->security_level) {
>  	case RXRPC_SECURITY_PLAIN:

[Severity: High]
This isn't a bug introduced by this patch (it goes back to 9d1d2b59341f),
but the new critical section is placed before the security_level validation,
so does the reject path leak the rxgk_context?

The store into conn->rxgk.keys[] happens first, then the switch can fail:

	switch (conn->security_level) {
	case RXRPC_SECURITY_PLAIN:
	case RXRPC_SECURITY_AUTH:
	case RXRPC_SECURITY_ENCRYPT:
		break;
	default:
		ret = -EKEYREJECTED;
		goto error;
	}

The error path neither clears the slot nor calls rxgk_put(), and unlike
rxgk_rekey() there is no WARN_ON()/eviction of an occupant already in the
slot.

The reject arm looks user-reachable.  rxrpc_preparse_xdr_yfs_rxgk() accepts
a level of -1:

	token->rxgk->level	= tmp = xdr_dec64(xdr + 2 * 2);
	if (tmp < -1LL || tmp > RXRPC_SECURITY_ENCRYPT)
		goto reject_token;

and struct rxgk_key::level is s8, so -1 widens to 0xFFFFFFFF in the u32
conn->security_level and falls into the default arm.
rxgk_generate_transport_key() still succeeds for that level, so a full
context plus an AEAD transform is installed before the rejection.

Is that then repeatable?  rxrpc_init_client_conn_security() only promotes
the state on success:

		ret = conn->security->init_connection_security(conn, token);
		if (ret == 0) {
			spin_lock_irq(&conn->state_lock);
			if (conn->state == RXRPC_CONN_CLIENT_UNSECURED)
				conn->state = RXRPC_CONN_CLIENT;

and rxrpc_may_reuse_conn() lets the next call reuse it:

	if ((conn->state != RXRPC_CONN_CLIENT_UNSECURED &&
	     conn->state != RXRPC_CONN_CLIENT) ||

so every subsequent sendmsg() re-enters the initialiser and the store into
conn->rxgk.keys[] drops the array's only reference to the previous context.
rxgk_clear() only puts whatever pointers are still in the array at teardown.

The service side looks similar: rxrpc_do_process_connection() discards the
return value of rxrpc_process_event(), the connection stays
RXRPC_CONN_SERVICE_CHALLENGING, and a further RESPONSE re-enters the
initialiser.  rxgk_verify_response() also overwrites conn->key with no
key_put():

	conn->key = key;
	key = NULL;

Would it make sense to move the new write_lock section below the
security_level validation, and to rxgk_put() the evicted occupant the way
rxgk_rekey() handles its dead key?

[Severity: Medium]
This is a pre-existing issue and the changelog already says so ("That report
is on the key context's byte counter rather than the initial publication"),
but should the counter in the quoted KCSAN splat also be synchronised?

rxgk_get_key() reads it under the read lock to decide whether to rekey:

		if (time_after(jiffies, gk->expiry) ||
		    gk->bytes_remaining < 0) {
			set_bit(RXGK_TK_NEEDS_REKEY, &gk->flags);
			goto slow_path;
		}

while both rxgk_secure_packet_integrity() and
rxgk_secure_packet_encrypted() do the read-modify-write with no lock held,
after rxgk_get_key() has already dropped the read lock:

		gk->bytes_remaining -= ret;

With two senders on one connection, can decrements be lost (and the 64-bit
value torn on 32-bit), so that the byte lifetime set up in
rxgk_generate_transport_key() from key->bytelife is exceeded and the
bytes_remaining < 0 rekey trigger is delayed?  Making the counter atomic, or
updating it under the same lock the reader uses, would close that.

[Severity: High]
Not something this patch changes, but while looking at the matching locking
in rxgk_rekey(): does the non-crank generate_key path store the new context
at the wrong index and drop a reference?

When rxgk_rekey() is entered for key_number == current_key - 1 and that slot
is empty, it jumps to generate_key with crank still false:

	gk = conn->rxgk.keys[key_number & mask];
	if (!gk)
		goto generate_key;

The context is then derived for key_number, but installed into the current
slot:

	write_lock(&conn->security_use_lock);
	if (crank) {
		current_key++;
		conn->rxgk.key_number = current_key;
		dead = conn->rxgk.keys[(current_key - 2) & mask];
		conn->rxgk.keys[(current_key - 2) & mask] = NULL;
	}
	conn->rxgk.keys[current_key & mask] = gk;

The eviction into dead only runs when crank is true, so does the previous
current-key context lose its only reference here, leaking an rxgk_context
plus its AEAD/shash transforms?  And since the installed context's
gk->key_number differs from conn->rxgk.key_number, does rxgk_secure_packet()
then stamp the wrong number on transmits:

	txb->cksum = htons(gk->key_number);

The selector is peer-controlled.  rxgk_verify_packet() passes the wire value
in:

	u16 key_number = sp->hdr.cksum;
	...
	gk = rxgk_get_key(call->conn, &key_number);

On a connection that has never rekeyed (conn->rxgk.key_number == 0, only
keys[0] populated), a DATA packet with cksum == 0xFFFF matches:

		else if (*specific_key_number == (u16)(current_key - 1))
			key_number = current_key - 1;

giving key_number == UINT_MAX, so keys[UINT_MAX & 3] is keys[3], which is
NULL, leading to slow_path and rxgk_rekey() taking the branch above and
storing at index 0.  keys[3] stays NULL, so can a peer repeat this for every
packet?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907113743.1453210-1-dhowells%40redhat.com
