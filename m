Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE839FCBC
	for <stable@vger.kernel.org>; Fri, 29 May 2026 23:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780096861; cv=none; b=X9E4Ij6UEM5VhbMflD3xWXOmoKRzWELhg1SUMu2E9sI0XU6rJY6aWQGE7E+TH0cIzNAr/dvEC7yqbl/xuTpQIgOXiW1v23cbJqsEikRAKPmv1Zp2nJEZqVhnERId9PUMtQ6jwF4ysKw7fqVvY57tVb50eGQkOrBTjFV+OgEZUWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780096861; c=relaxed/simple;
	bh=claybWqF29yBQ9F3qkGEyjDD/epOnht/komDl3mxzhI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I3VTcDmk5znJwaGY4/8in0OFyAm1ND3DKU+wXk9Oj9RpNIcT/RjHQU/O9sH2Kh2F5Hjg7cLPIrSRwG/OOxXQsWiIa6R/izw0202MTzPrhC2QK/x7UlcPZhaGCWJraK+6CKvJZTlamOHYg4tl5b3Ea/6nchLqyVYr0TlKk6cXL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFWRXAZh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFWRXAZh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209011F00898;
	Fri, 29 May 2026 23:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780096860;
	bh=s6FNuY1Y4G8pDbD9d/pQEQ5W9bsINVK99dMi6hsarPA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RFWRXAZh4oinEqA2zmd8dFQi06xtNs3qkIASel2nO+22A0x+707G/Q/CtEAfUzJnE
	 G/LTDzqOuO6GP7+C6CIt5QB+ss+LKteF5iKNg4K0WMivW/oef3mt9kkd1DDCfM22G8
	 3fhrGbHqts8rePCRnjCxliBQ/6htcni/ArLG9yjDNOFO+waq/cvBMgsPoPyEfL5rW2
	 YFToJ/XXcmTVSzuDtlZ8jhCrH42Bi94g6D8hH9moG42uEAK42vQaIXofvZT+X8da9w
	 t/k8Znu++njkBdWn7xU3ZmkdI1absEWkwthmhPzuAG1a9pyRhVbXIINjS4/CH7em4F
	 BQB6uqzqs5WNA==
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
Subject: [PATCH 6.6.y 2/2] rxrpc: Fix RESPONSE packet verification to extract skb to a linear buffer
Date: Fri, 29 May 2026 19:20:56 -0400
Message-ID: <20260529232056.1870836-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260529232056.1870836-1-sashal@kernel.org>
References: <2026052809-espresso-heftiness-bdb0@gregkh>
 <20260529232056.1870836-1-sashal@kernel.org>
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
index f19bc76b6c389..3d0ee89f21245 100644
--- a/net/rxrpc/ar-internal.h
+++ b/net/rxrpc/ar-internal.h
@@ -267,8 +267,9 @@ struct rxrpc_security {
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
index 84d1bbb0ede2d..a5620f3274197 100644
--- a/net/rxrpc/insecure.c
+++ b/net/rxrpc/insecure.c
@@ -47,9 +47,10 @@ static int none_respond_to_challenge(struct rxrpc_connection *conn,
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
index 228abd30847a3..7b12fd90730d1 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -874,7 +874,6 @@ static int rxkad_decrypt_ticket(struct rxrpc_connection *conn,
 	*_expiry = 0;
 
 	ASSERT(server_key->payload.data[0] != NULL);
-	ASSERTCMP((unsigned long) ticket & 7UL, ==, 0);
 
 	memcpy(&iv, &server_key->payload.data[2], sizeof(iv));
 
@@ -1023,14 +1022,15 @@ static int rxkad_decrypt_response(struct rxrpc_connection *conn,
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
@@ -1053,13 +1053,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
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
@@ -1071,6 +1066,9 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 
 	trace_rxrpc_rx_response(conn, sp->hdr.serial, version, kvno, ticket_len);
 
+	buffer	+= sizeof(*response);
+	len	-= sizeof(*response);
+
 	if (version != RXKAD_VERSION) {
 		ret = rxrpc_abort_conn(conn, skb, RXKADINCONSISTENCY, -EPROTO,
 				       rxkad_abort_resp_version);
@@ -1090,13 +1088,8 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
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
@@ -1176,8 +1169,6 @@ static int rxkad_verify_response(struct rxrpc_connection *conn,
 	ret = rxrpc_get_server_data_key(conn, &session_key, expiry, kvno);
 
 error:
-	kfree(ticket);
-	kfree(response);
 	key_put(server_key);
 	_leave(" = %d", ret);
 	return ret;
-- 
2.53.0

