Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794146511;
	b=ERhVYnT31oH9PaYTSBfDo5MTBldd7M6CTZAs5HKHhVhSImLRNgYDjbtnwy4B/aTzaWDO
	 WXLZ63R3ONBEeDHVBj4wQSGgs+tZVCliGTN6KKDSpQP2f2XY+pgv4Q2RkHjosniVsnSzn
	 a5UNTKgySuD6g4h7FtK+i9ShK+z2XyEd+zJ2pfC6Iu97iFx7GHz2srTi3+brNFrPp6RLI
	 2IaxkmX+8wyylH4zxvvIa+tlbQSKknXW8x9/9ttsQ3ylIVTo5YXrOcc6nrppRRM5NQxap
	 CcZLVOgQN0ALFmhmJPrDJ+Rlco019hK7kk/3SZS4b/z1mqoudfrlEJ0FYyM3EmE6yfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794146511;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-Id:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=zAQJbBXK85zhqnp6Sy8iRos+KnUH1gw70gkQ2aOh+90=;
	b=vbOuUkZ+94aY4tUoDIw5IKRxOfiAnV9BaEW+KLWautoHJ//csQRH1je9FQPsA0mvZfU5
	 +i+ZneQoIvTA9FE8pIU3JFDJVS/JvR4FHybxwLQIvQ3Lr9VPcqhCPLESqQHn9GvwGWzHR
	 r9k8T9q60GZzZp6yRMIwid56CDJwls6L0snWPLXmTH3MQAT/6Gd2RxsWA163tmylE2STe
	 R7OqBfBLU53mmxuNwiLmm9VEZm+R9xGMYREhBHAfzbUBKAQBVaFhqPhf8WloCwr8Q5qwY
	 nIZfb2iX9eKuorjx75vFCAloXRzjpKMcWSo8E/Ww3HPgKyv2sECTJAuFZQwIo9U8UWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gyJDtw1O;
	arc=none smtp.remote-ip=91.218.175.77
Received: from mta0.migadu.com (out-77.mta0.migadu.com [91.218.175.77])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF782606A31C
	for <stable@vger.kernel.org>; Sun,  8 Nov 2026 14:01:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF782606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=gyJDtw1O
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=HjVZPtkRA01m0fgGyDnvvNCRvaaaXCOerbCRxZkDG8Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794146507; v=1; x=1794751307;
 b=gyJDtw1OHWTueJSrFbE9M6Q9FeXI7GJBm8kIILXHYJKu9jS6IFJNZx9y86K4Hx5DaNjx60WZ
 ADzt/pSpPknIOSTAT/GIlwAu2vGthKXfOQtu8/5NqR4lbOc3yyUfBIZWbS5VJBHuExB355QJqbf
 XH3xNmXRbW76XfiDvsfGxa+Q=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 08f775a7004b422a;
	Sun, 08 Nov 2026 14:01:47 +0000
X-Mizu-Trace-ID: 08f775a7004b422a
X-Migadu-Flow: FLOW_OUT
From: Qingfang Deng <qingfang.deng@linux.dev>
To: stable@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12.y 6.6.y 6.1.y 5.15.y 5.10.y] pppoe: delete session hash entries by pointer match
Date: Sun,  8 Nov 2026 22:01:44 +0800
Message-Id: <20261108140144.1081-1-qingfang.deng@linux.dev>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107052514-failed-6.12-b5b8c81836e2@kernel.org>
References: <20261107052514-failed-6.12-b5b8c81836e2@kernel.org> <20261107053805-failed-6.6-b5b8c81836e2@kernel.org> <20261107055315-failed-6.1-b5b8c81836e2@kernel.org> <20261107061023-failed-5.15-b5b8c81836e2@kernel.org> <20261107062733-failed-5.10-b5b8c81836e2@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit b5b8c81836e2bec7b444dfa2b14fd14e912e9d63 ]

pppoe_connect() copies the requested PPPoE address to a socket before
attempting to insert the socket into the session hash table. If the
tuple already exists, __set_item() returns -EALREADY, but the copied
address and ifindex remain set on the failed socket.

Closing that socket then deletes the existing socket's hash entry
through pppoe_release(), preventing it from receiving further session
traffic. An unprivileged process in the same network namespace can
trigger this through a duplicate connection attempt.

To avoid the accidental delete, pass the pppox_sock to __delete_item(),
and unlink only an entry whose pointer matches the requested socket.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
Link: https://patch.msgid.link/20261020092118.47416-1-qingfang.deng@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Resolve conflict, and remove const qualifier of pppox_sock to match
  hash_item(). ]
Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 8ff2024dde60..293b6fb1c1e9 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -194,18 +194,16 @@ static int __set_item(struct pppoe_net *pn, struct pppox_sock *po)
 	return 0;
 }
 
-static void __delete_item(struct pppoe_net *pn, __be16 sid,
-					char *addr, int ifindex)
+static void __delete_item(struct pppoe_net *pn, struct pppox_sock *po)
 {
-	int hash = hash_item(sid, addr);
+	int hash = hash_item(po->pppoe_pa.sid, po->pppoe_pa.remote);
 	struct pppox_sock *ret, **src;
 
 	ret = pn->hash_table[hash];
 	src = &pn->hash_table[hash];
 
 	while (ret) {
-		if (cmp_addr(&ret->pppoe_pa, sid, addr) &&
-		    ret->pppoe_ifindex == ifindex) {
+		if (ret == po) {
 			*src = ret->next;
 			break;
 		}
@@ -255,11 +253,10 @@ static inline struct pppox_sock *get_item_by_addr(struct net *net,
 	return pppox_sock;
 }
 
-static inline void delete_item(struct pppoe_net *pn, __be16 sid,
-					char *addr, int ifindex)
+static void delete_item(struct pppoe_net *pn, struct pppox_sock *po)
 {
 	write_lock_bh(&pn->hash_lock);
-	__delete_item(pn, sid, addr, ifindex);
+	__delete_item(pn, po);
 	write_unlock_bh(&pn->hash_lock);
 }
 
@@ -599,8 +596,7 @@ static int pppoe_release(struct socket *sock)
 	 * protect "po" from concurrent updates
 	 * on pppoe_flush_dev
 	 */
-	delete_item(pn, po->pppoe_pa.sid, po->pppoe_pa.remote,
-		    po->pppoe_ifindex);
+	delete_item(pn, po);
 
 	sock_orphan(sk);
 	sock->sk = NULL;
@@ -651,8 +647,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
 	if (stage_session(po->pppoe_pa.sid)) {
 		pppox_unbind_sock(sk);
 		pn = pppoe_pernet(sock_net(sk));
-		delete_item(pn, po->pppoe_pa.sid,
-			    po->pppoe_pa.remote, po->pppoe_ifindex);
+		delete_item(pn, po);
 		if (po->pppoe_dev) {
 			dev_put(po->pppoe_dev);
 			po->pppoe_dev = NULL;
@@ -703,8 +698,7 @@ static int pppoe_connect(struct socket *sock, struct sockaddr *uservaddr,
 
 		error = ppp_register_net_channel(dev_net(dev), &po->chan);
 		if (error) {
-			delete_item(pn, po->pppoe_pa.sid,
-				    po->pppoe_pa.remote, po->pppoe_ifindex);
+			delete_item(pn, po);
 			goto err_put;
 		}
 
