Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DED3045D900
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 13:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791293496; cv=none; b=Z7GMGd9J0qXFRT8aJvNPOrf96JeIlXE7YjqRRGrHOvDguIkaTWqMq1/EbvHE1sQOH50raJISXT200w3FoSF/K6+FTW6Cz3mySdzkS2Nx+GrmyLzfvOgcKYbpd22bTjvr5aUQz1hL+pVMUPj03vMiuJI3v7A4c+OhI2T5t3ouyn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791293496; c=relaxed/simple;
	bh=qaXzYrNiiWjeqfWelf3EWiGvOJxOMon5SO68ipwd1Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFY+D0ym+a5osecyQ7MTghTpAT78F73CJ65D9Ie/lDDr0iyLLf1jjfXQPOBBRovkDPhzT/5deq0xKZqffDwhUnRYajLGd+WXWtJDJtQUxa/gTwh1g5FxHgyr3nWWiWzrBYNMW1DrCSjoQjpg1KKgK/TZ6uCVS91kf2Hc6tcwUNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iNfYuGs/; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iNfYuGs/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791293493;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jGs0yeHtAEv/IqKQ632s8QFE8oaBGxldKeQIsDwv57c=;
	b=iNfYuGs/TIoRGrRaD+mv6nTIOpeeuu7Xl1d1l0NbZ+2wtPcX63YlfwJBFiEbwe5AQtU9gK
	WVufC4EkIeZE54hHFqoeIkcrkkONWJq1CqjXnec/i4yPH+J+gAF6EFT3+XKXUnhbajh3Eq
	4QZ/xF0Ht1AI59sCF39mtqxCf2ngb70=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-eyKz8YhpMjaF5k9vfPki6Q-1; Tue,
 06 Oct 2026 09:31:32 -0400
X-MC-Unique: eyKz8YhpMjaF5k9vfPki6Q-1
X-Mimecast-MFC-AGG-ID: eyKz8YhpMjaF5k9vfPki6Q_1791293489
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C9C2D180AE8F;
	Tue,  6 Oct 2026 13:31:29 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.90])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id AFE4330000E3;
	Tue,  6 Oct 2026 13:31:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v12 14/15] rxrpc: Fix RxGK key parser to check enctype is supported
Date: Tue,  6 Oct 2026 14:30:06 +0100
Message-ID: <20261006133011.531806-15-dhowells@redhat.com>
In-Reply-To: <20261006133011.531806-1-dhowells@redhat.com>
References: <20261006133011.531806-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Fix the parser of RxGK keys supplied by userspace to check that the
specified encryption type is supported and check the key length.  Further,
since the checking function isn't necessarily available in CONFIG_RXGK=n,
make the RxGK key wrangling bits conditional.

Also only account the a token to the key's quota if that token is used.

Fixes: 0ca100ff4df6 ("rxrpc: Add YFS RxGK (GSSAPI) security class")
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260824091645.415423-1-dhowells%40redhat.com
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Dumazet <edumazet@google.com>
cc: "David S. Miller" <davem@davemloft.net>
cc: Jakub Kicinski <kuba@kernel.org>
cc: Paolo Abeni <pabeni@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: linux-afs@lists.infradead.org
cc: stable@vger.kernel.org
---
 net/rxrpc/key.c | 41 +++++++++++++++++++++++++++++++----------
 1 file changed, 31 insertions(+), 10 deletions(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index cbd26da44951..904da3fe7e47 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -71,14 +71,11 @@ static int rxrpc_preparse_xdr_rxkad(struct key_preparsed_payload *prep,
 	if (toklen < 8 * 4 + tktlen)
 		return -EKEYREJECTED;
 
-	plen = sizeof(*token) + sizeof(*token->kad) + tktlen;
-	prep->quotalen += datalen + plen;
-
-	plen -= sizeof(*token);
 	token = kzalloc_obj(*token);
 	if (!token)
 		return -ENOMEM;
 
+	plen = sizeof(*token->kad) + tktlen;
 	token->kad = kzalloc(plen, GFP_KERNEL);
 	if (!token->kad) {
 		kfree(token);
@@ -112,6 +109,8 @@ static int rxrpc_preparse_xdr_rxkad(struct key_preparsed_payload *prep,
 		       token->kad->ticket[4], token->kad->ticket[5],
 		       token->kad->ticket[6], token->kad->ticket[7]);
 
+	prep->quotalen += sizeof(*token) + datalen + plen;
+
 	/* count the number of tokens attached */
 	prep->payload.data[1] = (void *)((unsigned long)prep->payload.data[1] + 1);
 
@@ -129,6 +128,7 @@ static int rxrpc_preparse_xdr_rxkad(struct key_preparsed_payload *prep,
 	return 0;
 }
 
+#ifdef CONFIG_RXGK
 static u64 xdr_dec64(const __be32 *xdr)
 {
 	return (u64)ntohl(xdr[0]) << 32 | (u64)ntohl(xdr[1]);
@@ -166,12 +166,13 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 				       size_t datalen,
 				       const __be32 *xdr, unsigned int toklen)
 {
+	const struct krb5_enctype *enc;
 	struct rxrpc_key_token *token, **pptoken;
 	time64_t expiry;
-	size_t plen;
 	const __be32 *ticket, *key;
 	s64 tmp;
 	size_t raw_keylen, raw_tktlen, keylen, tktlen;
+	int ret = -EKEYREJECTED;
 
 	_enter(",{%x,%x,%x,%x},%x",
 	       ntohl(xdr[0]), ntohl(xdr[1]), ntohl(xdr[2]), ntohl(xdr[3]),
@@ -202,10 +203,6 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 		goto reject;
 	}
 
-	plen = sizeof(*token) + sizeof(*token->rxgk) + tktlen + keylen;
-	prep->quotalen += datalen + plen;
-
-	plen -= sizeof(*token);
 	token = kzalloc_obj(*token);
 	if (!token)
 		goto nomem;
@@ -229,6 +226,17 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	token->rxgk->key.data	= token->rxgk->_key;
 	token->rxgk->ticket.len = raw_tktlen;
 
+	/* Check the enctype is supported. */
+	enc = crypto_krb5_find_enctype(token->rxgk->enctype);
+	if (!enc) {
+		ret = -ENOPKG;
+		goto reject_token;
+	}
+	if (raw_keylen != enc->key_len) {
+		ret = -EKEYREJECTED;
+		goto reject_token;
+	}
+
 	if (token->rxgk->endtime != 0) {
 		expiry = rxrpc_s64_to_time64(token->rxgk->endtime);
 		if (expiry < 0)
@@ -257,6 +265,8 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	_debug("TICK: %*phN",
 	       min_t(u32, token->rxgk->ticket.len, 32), token->rxgk->ticket.data);
 
+	prep->quotalen += sizeof(*token) + datalen + tktlen + keylen;
+
 	/* count the number of tokens attached */
 	prep->payload.data[1] = (void *)((unsigned long)prep->payload.data[1] + 1);
 
@@ -280,12 +290,13 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 	kfree(token->rxgk);
 	kfree(token);
 reject:
-	return -EKEYREJECTED;
+	return ret;
 expired:
 	kfree(token->rxgk);
 	kfree(token);
 	return -EKEYEXPIRED;
 }
+#endif /* CONFIG_RXGK */
 
 /*
  * attempt to parse the data as the XDR format
@@ -386,9 +397,11 @@ static int rxrpc_preparse_xdr(struct key_preparsed_payload *prep)
 		case RXRPC_SECURITY_RXKAD:
 			ret2 = rxrpc_preparse_xdr_rxkad(prep, datalen, token, toklen);
 			break;
+#ifdef CONFIG_RXGK
 		case RXRPC_SECURITY_YFS_RXGK:
 			ret2 = rxrpc_preparse_xdr_yfs_rxgk(prep, datalen, token, toklen);
 			break;
+#endif
 		default:
 			ret2 = -EPROTONOSUPPORT;
 			break;
@@ -556,10 +569,12 @@ static void rxrpc_free_token_list(struct rxrpc_key_token *token)
 		case RXRPC_SECURITY_RXKAD:
 			kfree(token->kad);
 			break;
+#ifdef CONFIG_RXGK
 		case RXRPC_SECURITY_YFS_RXGK:
 			kfree(token->rxgk->ticket.data);
 			kfree(token->rxgk);
 			break;
+#endif
 		default:
 			pr_err("Unknown token type %x on rxrpc key\n",
 			       token->security_index);
@@ -603,9 +618,11 @@ static void rxrpc_describe(const struct key *key, struct seq_file *m)
 		case RXRPC_SECURITY_RXKAD:
 			seq_puts(m, "ka");
 			break;
+#ifdef CONFIG_RXGK
 		case RXRPC_SECURITY_YFS_RXGK:
 			seq_puts(m, "ygk");
 			break;
+#endif
 		default: /* we have a ticket we can't encode */
 			seq_printf(m, "%u", token->security_index);
 			break;
@@ -770,12 +787,14 @@ static long rxrpc_read(const struct key *key,
 				toksize += RND(token->kad->ticket_len);
 			break;
 
+#ifdef CONFIG_RXGK
 		case RXRPC_SECURITY_YFS_RXGK:
 			toksize += 6 * 8 + 2 * 4;
 			if (!token->no_leak_key)
 				toksize += RND(token->rxgk->key.len);
 			toksize += RND(token->rxgk->ticket.len);
 			break;
+#endif
 
 		default: /* we have a ticket we can't encode */
 			pr_err("Unsupported key token type (%u)\n",
@@ -856,6 +875,7 @@ static long rxrpc_read(const struct key *key,
 				ENCODE_DATA(token->kad->ticket_len, token->kad->ticket);
 			break;
 
+#ifdef CONFIG_RXGK
 		case RXRPC_SECURITY_YFS_RXGK:
 			ENCODE64(token->rxgk->begintime);
 			ENCODE64(token->rxgk->endtime);
@@ -869,6 +889,7 @@ static long rxrpc_read(const struct key *key,
 				ENCODE_DATA(token->rxgk->key.len, token->rxgk->key.data);
 			ENCODE_DATA(token->rxgk->ticket.len, token->rxgk->ticket.data);
 			break;
+#endif
 
 		default:
 			pr_err("Unsupported key token type (%u)\n",

