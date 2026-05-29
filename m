Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF1E93B47CA
	for <stable@vger.kernel.org>; Fri, 29 May 2026 21:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780090933; cv=none; b=se81RKZCNFha5UEqCRat+mTQ4k8rzKksjq98TWATpJ+nlzdEmTayNh1Nv9lW6zv3S/EXDGBap1FsaZtLCh9u8/czbeFaDVZvUqJSxZY0xg7aoJjEAuorGUbBPXPtagRIFr3K3fjtyc58ZUfmQdglvLfmRnQa7MVG27JJgXrChuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780090933; c=relaxed/simple;
	bh=xNhYWaPn/sHoEDIb3v6vi4Nn3huUNl0AEi4+gTzt2jg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ufy5ixR5nGU73vNSwsviDbxer1cA4eWHWjF2zlMpdoJdrll+mzjHsMxCdxAoUWVvsKGlnwUrJC7eagjIU4CPYoSuDWB9cXXpVYV3O/5TM81pyEeFHb3IbYg8qxZbKg0Ym7gdPv7sTbHbkPB/ZmN6ln1otwh1SRazPDVxB3BxrF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzvS1/zG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzvS1/zG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 338C31F0089A;
	Fri, 29 May 2026 21:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780090932;
	bh=ln24HMhKlXXAbRf/ANTSOd7BQcdCD3HyOf4D6N5Fkxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SzvS1/zGYds1wWTglSVyzkFablMfUC5cYrmDfecFQR3GWHeN7bSwk+5aXSlM5Xieu
	 S6PmRQSFc2Y/8qgEijZb/tM2lxpy2fqLHJCRlfLA8OGZGbE+gldHHUpcCLzkzVdJnM
	 kPkmfodgTzUSx7ThgfojxwEeXmMXSURIh9U4qwh9Z3LOPPJnTtLpJxKYC2Xk06m02i
	 uDjMMrphaSKJ+Sg5jBgMm9fOfcp6GusuWKXjiuSTt44z3u7cCEg51vuenVr/OFtHiw
	 JUGfSelrW6oSOnTU7AMZ+dy3G7WbwvCc3aRk9Cb34POqy+5Vm0DltQt3ZxMkwzEA5b
	 fNiey+zRxSL7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jeffrey Altman <jaltman@auristor.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer
Date: Fri, 29 May 2026 17:42:08 -0400
Message-ID: <20260529214208.1792984-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529214208.1792984-1-sashal@kernel.org>
References: <2026052808-unroasted-trace-cf4d@gregkh>
 <20260529214208.1792984-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit 8bfab4b6ffc2fe92da86300728fc8c3c7ebffb56 ]

This improves the fix for CVE-2026-43500.

Fix the verification of RESPONSE packets to avoid the problem of
overwriting a RESPONSE packet sent via splice to a local address by
extracting the contents of the UDP packet into a kmalloc'd linear buffer
rather than decrypting the data in place in the sk_buff (which may corrupt
the original buffer).

Fixes: 24481a7f5733 ("rxrpc: Fix conn-level packet handling to unshare RESPONSE packets")
Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Closes: https://lore.kernel.org/r/afKV2zGR6rrelPC7@v4bel/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Simon Horman <horms@kernel.org>
cc: Jiayuan Chen <jiayuan.chen@linux.dev>
cc: linux-afs@lists.infradead.org
cc: stable@kernel.org
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
Link: https://patch.msgid.link/20260515230516.2718212-4-dhowells@redhat.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/ar-internal.h |  5 +++--
 net/rxrpc/conn_event.c  | 32 +++++++++++++-------------------
 net/rxrpc/insecure.c    |  5 +++--
 net/rxrpc/rxkad.c       | 29 ++++++++++-------------------
 4 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/net/rxrpc/ar-internal.h b/net/rxrpc/ar-internal.h
index 914176b027afb..61dd1298124f6 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -270,8 +270,9 @@ struct rxrpc_security {
 				    struct sk_buff *);
 
 	/* verify a response */
-	int (*verify_response)(struct rxrpc_connection *,
-			       struct sk_buff *);
+	int (*verify_response)(struct rxrpc_connection *conn,
+			       struct sk_buff *response_skb,
+			       void *response, unsigned int len);
 
 	/* clear connection security */
 	void (*clear)(struct rxrpc_connection *);
diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
index 3a58fb9210383..ab66903e4d72f 100644
--- a/net/rxrpc/conn_event.c
+++ b/net/rxrpc/conn_event.c
@@ -229,28 +229,22 @@ static void rxrpc_call_is_secure(struct rxrpc_call *call)
 static int rxrpc_verify_response(struct rxrpc_connection *conn,
 				 struct sk_buff *skb)
 {
+	unsigned int len = skb->len - sizeof(struct rxrpc_wire_header);
+	void *buffer;
 	int ret;
 
-	if (skb_cloned(skb) || skb_has_frag_list(skb) ||
-	    skb_has_shared_frag(skb)) {
-		/* Copy the packet if shared so that we can do in-place
-		 * decryption.
-		 */
-		struct sk_buff *nskb = skb_copy(skb, GFP_NOFS);
-
-		if (nskb) {
-			rxrpc_new_skb(nskb, rxrpc_skb_new_unshared);
-			ret = conn->security->verify_response(conn, nskb);
-			rxrpc_free_skb(nskb, rxrpc_skb_put_response_copy);
-		} else {
-			/* OOM - Drop the packet. */
-			rxrpc_see_skb(skb, rxrpc_skb_see_unshare_nomem);
-			ret = -ENOMEM;
-		}
-	} else {
-		ret = conn->security->verify_response(conn, skb);
-	}
+	buffer = kmalloc(len, GFP_NOFS);
+	if (!buffer)
+		return -ENOMEM;
+
+	ret = skb_copy_bits(skb, sizeof(struct rxrpc_wire_header), buffer, len);
+	if (ret < 0)
+		goto out;
+
+	ret = conn->security->verify_response(conn, skb, buffer, len);
 
+out:
+	kfree(buffer);
 	return ret;
 }
 
diff --git a/net/rxrpc/insecure.c b/net/rxrpc/insecure.c
index 5514403fd18d2..4a3b96aed933c 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -44,9 +44,10 @@ static int none_respond_to_challenge(struct rxrpc_connection *conn,
 }
 
 static int none_verify_response(struct rxrpc_connection *conn,
-				struct sk_buff *skb)
+				struct sk_buff *response_skb,
+				void *response, unsigned int len)
 {
-	return rxrpc_abort_conn(conn, skb, RX_PROTOCOL_ERROR, -EPROTO,
+	return rxrpc_abort_conn(conn, response_skb, RX_PROTOCOL_ERROR, -EPROTO,
 				rxrpc_eproto_rxnull_response);
 }
 
diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index bb8b7858b8c26..c4d946ffc7deb 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -875,7 +875,6 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 	*_expiry = 0;
 
 	ASSERT(server_key->payload.data[0] != NULL);
-	ASSERTCMP((unsigned long) ticket & 7UL, ==, 0);
 
 	memcpy(&iv, &server_key->payload.data[2], sizeof(iv));
 
@@ -1024,14 +1023,15 @@ static int rxkad_decrypt_response(struct rxrpc_connection *conn,
  * verify a response
  */
 static int rxkad_verify_response(struct rxrpc_connection *conn,
-				 struct sk_buff *skb)
+				 struct sk_buff *skb,
+				 void *buffer, unsigned int len)
 {
 	struct rxkad_response *response;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rxrpc_crypt session_key;
 	struct key *server_key;
 	time64_t expiry;
-	void *ticket = NULL;
+	void *ticket;
 	u32 version, kvno, ticket_len, level;
 	__be32 csum;
 	int ret, i;
@@ -1054,13 +1054,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 		}
 	}
 
-	ret = -ENOMEM;
-	response = kzalloc(sizeof(struct rxkad_response), GFP_NOFS);
-	if (!response)
-		goto error;
-
-	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header),
-			  response, sizeof(*response)) < 0) {
+	response = buffer;
+	if (len < sizeof(*response)) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
 				       rxkad_abort_resp_short);
 		goto error;
@@ -1072,6 +1067,9 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, ticket_len);
 
+	buffer	+= sizeof(*response);
+	len	-= sizeof(*response);
+
 	if (version != RXKAD_VERSION) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
 				       rxkad_abort_resp_version);
@@ -1091,13 +1089,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	}
 
 	/* extract the kerberos ticket and decrypt and decode it */
-	ret = -ENOMEM;
-	ticket = kmalloc(ticket_len, GFP_NOFS);
-	if (!ticket)
-		goto error;
-
-	if (skb_copy_bits(skb, sizeof(struct rxrpc_wire_header) + sizeof(*response),
-			  ticket, ticket_len) < 0) {
+	ticket = buffer;
+	if (ticket_len > len) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADPACKETSHORT, -EPROTO,
 				       rxkad_abort_resp_short_tkt);
 		goto error;
@@ -1177,8 +1170,6 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 
 error:
-	kfree(ticket);
-	kfree(response);
 	key_put(server_key);
 	_leave(" = %d", ret);
 	return ret;
-- 
2.53.0

