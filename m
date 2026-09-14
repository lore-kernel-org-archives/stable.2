Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28D4AA1F8
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 15:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789398888; cv=none; b=W+cq3YhDjUkGG8Saa2tIblz47ObVFFRUrZ0FM2op/W471Z9EcgvJMMjE5IuIFx5JecZXeM8j230/GsJUC+5S41RVA+pQ8z3t/x3JD9Sw+6TJZIVCA67nL7AwKgJpvZ4gqFd5neeEFED+Prq1+lzIzYvro8p4PNrkLAUgCCbdz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789398888; c=relaxed/simple;
	bh=S/Lj/pYcJczz56lh3VLaZdxY00WzdPXkbPQOBltxj9w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qfj4RCTJW3NOkT81olxQlRtr7TmGs+80DJ9Dxy9Y1t+nLHv5/ZUl9Ww+rsltWEFhA669bgBqSfz0Mhb5fgaZuvyBoL9C2zo3CYKkz3AOOQltZxgvHNOWoqbsHrYpCNUJ3VdXILSbBJG6r2qpwCxKFMPD0bGG/Oy3bMHEUXjMsJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DjFjO+0V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DjFjO+0V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789398883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZZYqLvurOLNLwad7WLLLlFjkLSEkWNVoz/2rnznaAk=;
	b=DjFjO+0VX7RtI6M04+RxfxHk1ijX9hG5+Erep12j1qkRacqSbT/rqw4lzYW09vLx780J+D
	oLzXnJWhoaruDODeqw28SpNjggDaXZVme6hiGApYxPgag0+tcr92y24+pu6wA5CR1vAF+x
	BM9tA3vmQnlRhNdfKgUk1WZvvJyMOZE=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-659-1HrBCneLP3q01it3SYIIRw-1; Mon,
 14 Sep 2026 11:14:40 -0400
X-MC-Unique: 1HrBCneLP3q01it3SYIIRw-1
X-Mimecast-MFC-AGG-ID: 1HrBCneLP3q01it3SYIIRw_1789398878
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D50771829E1D;
	Mon, 14 Sep 2026 15:14:38 +0000 (UTC)
Received: from warthog.com (unknown [10.44.32.54])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BBAA21800345;
	Mon, 14 Sep 2026 15:14:35 +0000 (UTC)
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
Subject: [PATCH net v10 10/14] rxrpc: Fix RxGK key parser to check enctype is supported
Date: Mon, 14 Sep 2026 16:13:34 +0100
Message-ID: <20260914151340.3227501-11-dhowells@redhat.com>
In-Reply-To: <20260914151340.3227501-1-dhowells@redhat.com>
References: <20260914151340.3227501-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Fix the parser of RxGK keys supplied by userspace to check that the
specified encryption type is supported and check the key length.  Further,
since the checking function isn't necessarily available in CONFIG_RXGK=n,
make the RxGK key wrangling bits conditional.

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
 net/rxrpc/key.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/key.c b/net/rxrpc/key.c
index a0aa78d89289..dc1b3aa51bf3 100644
--- a/net/rxrpc/key.c
+++ b/net/rxrpc/key.c
@@ -129,6 +129,7 @@ static int rxrpc_preparse_xdr_rxkad(struct key_preparsed_payload *prep,
 	return 0;
 }
 
+#ifdef CONFIG_RXGK
 static u64 xdr_dec64(const __be32 *xdr)
 {
 	return (u64)ntohl(xdr[0]) << 32 | (u64)ntohl(xdr[1]);
@@ -166,12 +167,14 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
 				       size_t datalen,
 				       const __be32 *xdr, unsigned int toklen)
 {
+	const struct krb5_enctype *enc;
 	struct rxrpc_key_token *token, **pptoken;
 	time64_t expiry;
 	size_t plen;
 	const __be32 *ticket, *key;
 	s64 tmp;
 	size_t raw_keylen, raw_tktlen, keylen, tktlen;
+	int ret = -EKEYREJECTED;
 
 	_enter(",{%x,%x,%x,%x},%x",
 	       ntohl(xdr[0]), ntohl(xdr[1]), ntohl(xdr[2]), ntohl(xdr[3]),
@@ -229,6 +232,17 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
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
@@ -280,12 +294,13 @@ static int rxrpc_preparse_xdr_yfs_rxgk(struct key_preparsed_payload *prep,
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
@@ -386,9 +401,11 @@ static int rxrpc_preparse_xdr(struct key_preparsed_payload *prep)
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
@@ -556,10 +573,12 @@ static void rxrpc_free_token_list(struct rxrpc_key_token *token)
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
@@ -603,9 +622,11 @@ static void rxrpc_describe(const struct key *key, struct seq_file *m)
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
@@ -770,12 +791,14 @@ static long rxrpc_read(const struct key *key,
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
@@ -856,6 +879,7 @@ static long rxrpc_read(const struct key *key,
 				ENCODE_DATA(token->kad->ticket_len, token->kad->ticket);
 			break;
 
+#ifdef CONFIG_RXGK
 		case RXRPC_SECURITY_YFS_RXGK:
 			ENCODE64(token->rxgk->begintime);
 			ENCODE64(token->rxgk->endtime);
@@ -869,6 +893,7 @@ static long rxrpc_read(const struct key *key,
 				ENCODE_DATA(token->rxgk->key.len, token->rxgk->key.data);
 			ENCODE_DATA(token->rxgk->ticket.len, token->rxgk->ticket.data);
 			break;
+#endif
 
 		default:
 			pr_err("Unsupported key token type (%u)\n",

